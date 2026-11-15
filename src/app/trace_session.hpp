#pragma once

namespace app::trace_session
{
#if defined(AETHER_SHOT_TRACE_ENABLED) && AETHER_SHOT_TRACE_ENABLED
void initialize();
void shutdown() noexcept;
#else
inline void initialize() {}
inline void shutdown() noexcept {}
#endif
} // namespace app::trace_session

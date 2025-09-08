Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4355CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvek0-0001FM-Qd; Mon, 08 Sep 2025 12:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveju-0001Ca-Rr
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvejn-0005QD-9t
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757348938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JYzL+5cV0IyMRejPavDaITiKyUyCQTXCe3pcuB09m8=;
 b=d8b0JDtwuDu0DIKLWQ0Yvp9XZL/W9rmQY8AxtSSlgboIliMOM1aw6/iqgbUN4a6SRLyTzM
 CKuzWH5hxi+4gJEjJDvxkIAKd9QsCuwXyTWdVLMa3vG2OxAnbZJ+7ivIVIbuCdzqhCXikx
 Iwxm3OjyRo9e658dBsPo2YSxoiYzpD4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-LXeA0JnGN0GGyXl7YsJm4w-1; Mon,
 08 Sep 2025 12:28:56 -0400
X-MC-Unique: LXeA0JnGN0GGyXl7YsJm4w-1
X-Mimecast-MFC-AGG-ID: LXeA0JnGN0GGyXl7YsJm4w_1757348935
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FED119560AF; Mon,  8 Sep 2025 16:28:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CA003002D2A; Mon,  8 Sep 2025 16:28:52 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:28:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/18] python: backport 'drop Python3.6 workarounds'
Message-ID: <aL8EQRPwkvVCqKC-@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-6-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-6-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 03, 2025 at 01:11:11AM -0400, John Snow wrote:
> Now that the minimum version is 3.7, drop some of the 3.6-specific hacks
> we've been carrying. A single remaining compatibility hack concerning
> 3.6's lack of @asynccontextmanager is addressed in the following commit.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit 3e8e34e594cfc6b707e6f67959166acde4b421b8
> ---
>  python/qemu/qmp/protocol.py |  48 +++++++---------
>  python/qemu/qmp/qmp_tui.py  |   8 +--
>  python/qemu/qmp/util.py     | 107 ++----------------------------------
>  python/tests/protocol.py    |   8 +--
>  4 files changed, 33 insertions(+), 138 deletions(-)

This change appears to have also (mistakenly ?) squashed in

commit 97f7ffa3be17a50544b52767d14b6fd478c07b9e
Author: John Snow <jsnow@redhat.com>
Date:   Tue Jun 6 13:45:44 2023 -0400

    Use @asynciocontextmanager
    
    This removes a non-idiomatic use of a "coroutine callback" in favor of
    something a bit more standardized.
    
    Signed-off-by: John Snow <jsnow@redhat.com>


If the two backport commits are split apart then

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> index ec4762c567b..958aeca08ac 100644
> --- a/python/qemu/qmp/protocol.py
> +++ b/python/qemu/qmp/protocol.py
> @@ -15,6 +15,7 @@
>  
>  import asyncio
>  from asyncio import StreamReader, StreamWriter
> +from contextlib import asynccontextmanager
>  from enum import Enum
>  from functools import wraps
>  import logging
> @@ -22,6 +23,7 @@
>  from ssl import SSLContext
>  from typing import (
>      Any,
> +    AsyncGenerator,
>      Awaitable,
>      Callable,
>      Generic,
> @@ -36,13 +38,10 @@
>  from .error import QMPError
>  from .util import (
>      bottom_half,
> -    create_task,
>      exception_summary,
>      flush,
> -    is_closing,
>      pretty_traceback,
>      upper_half,
> -    wait_closed,
>  )
>  
>  
> @@ -340,9 +339,8 @@ async def start_server(self, address: SocketAddrT,
>              This exception will wrap a more concrete one. In most cases,
>              the wrapped exception will be `OSError`.
>          """
> -        await self._session_guard(
> -            self._do_start_server(address, ssl),
> -            'Failed to establish connection')
> +        async with self._session_guard('Failed to establish connection'):
> +            await self._do_start_server(address, ssl)
>          assert self.runstate == Runstate.CONNECTING
>  
>      @upper_half
> @@ -365,12 +363,10 @@ async def accept(self) -> None:
>          """
>          if self._accepted is None:
>              raise QMPError("Cannot call accept() before start_server().")
> -        await self._session_guard(
> -            self._do_accept(),
> -            'Failed to establish connection')
> -        await self._session_guard(
> -            self._establish_session(),
> -            'Failed to establish session')
> +        async with self._session_guard('Failed to establish connection'):
> +            await self._do_accept()
> +        async with self._session_guard('Failed to establish session'):
> +            await self._establish_session()
>          assert self.runstate == Runstate.RUNNING
>  
>      @upper_half
> @@ -395,12 +391,10 @@ async def connect(self, address: Union[SocketAddrT, socket.socket],
>              protocol-level failure occurs while establishing a new
>              session, the wrapped error may also be an `QMPError`.
>          """
> -        await self._session_guard(
> -            self._do_connect(address, ssl),
> -            'Failed to establish connection')
> -        await self._session_guard(
> -            self._establish_session(),
> -            'Failed to establish session')
> +        async with self._session_guard('Failed to establish connection'):
> +            await self._do_connect(address, ssl)
> +        async with self._session_guard('Failed to establish session'):
> +            await self._establish_session()
>          assert self.runstate == Runstate.RUNNING
>  
>      @upper_half
> @@ -421,7 +415,8 @@ async def disconnect(self) -> None:
>      # Section: Session machinery
>      # --------------------------
>  
> -    async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
> +    @asynccontextmanager
> +    async def _session_guard(self, emsg: str) -> AsyncGenerator[None, None]:
>          """
>          Async guard function used to roll back to `IDLE` on any error.
>  
> @@ -438,10 +433,9 @@ async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
>          :raise ConnectError:
>              When any other error is encountered in the guarded block.
>          """
> -        # Note: After Python 3.6 support is removed, this should be an
> -        # @asynccontextmanager instead of accepting a callback.
>          try:
> -            await coro
> +            # Caller's code runs here.
> +            yield
>          except BaseException as err:
>              self.logger.error("%s: %s", emsg, exception_summary(err))
>              self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
> @@ -682,8 +676,8 @@ async def _establish_session(self) -> None:
>          reader_coro = self._bh_loop_forever(self._bh_recv_message, 'Reader')
>          writer_coro = self._bh_loop_forever(self._bh_send_message, 'Writer')
>  
> -        self._reader_task = create_task(reader_coro)
> -        self._writer_task = create_task(writer_coro)
> +        self._reader_task = asyncio.create_task(reader_coro)
> +        self._writer_task = asyncio.create_task(writer_coro)
>  
>          self._bh_tasks = asyncio.gather(
>              self._reader_task,
> @@ -708,7 +702,7 @@ def _schedule_disconnect(self) -> None:
>          if not self._dc_task:
>              self._set_state(Runstate.DISCONNECTING)
>              self.logger.debug("Scheduling disconnect.")
> -            self._dc_task = create_task(self._bh_disconnect())
> +            self._dc_task = asyncio.create_task(self._bh_disconnect())
>  
>      @upper_half
>      async def _wait_disconnect(self) -> None:
> @@ -844,13 +838,13 @@ async def _bh_close_stream(self, error_pathway: bool = False) -> None:
>          if not self._writer:
>              return
>  
> -        if not is_closing(self._writer):
> +        if not self._writer.is_closing():
>              self.logger.debug("Closing StreamWriter.")
>              self._writer.close()
>  
>          self.logger.debug("Waiting for StreamWriter to close ...")
>          try:
> -            await wait_closed(self._writer)
> +            await self._writer.wait_closed()
>          except Exception:  # pylint: disable=broad-except
>              # It's hard to tell if the Stream is already closed or
>              # not. Even if one of the tasks has failed, it may have
> diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
> index 2d9ebbd20bc..562be008d5e 100644
> --- a/python/qemu/qmp/qmp_tui.py
> +++ b/python/qemu/qmp/qmp_tui.py
> @@ -40,7 +40,7 @@
>  from .message import DeserializationError, Message, UnexpectedTypeError
>  from .protocol import ConnectError, Runstate
>  from .qmp_client import ExecInterruptedError, QMPClient
> -from .util import create_task, pretty_traceback
> +from .util import pretty_traceback
>  
>  
>  # The name of the signal that is used to update the history list
> @@ -225,7 +225,7 @@ def cb_send_to_server(self, raw_msg: str) -> None:
>          """
>          try:
>              msg = Message(bytes(raw_msg, encoding='utf-8'))
> -            create_task(self._send_to_server(msg))
> +            asyncio.create_task(self._send_to_server(msg))
>          except (DeserializationError, UnexpectedTypeError) as err:
>              raw_msg = format_json(raw_msg)
>              logging.info('Invalid message: %s', err.error_message)
> @@ -246,7 +246,7 @@ def kill_app(self) -> None:
>          Initiates killing of app. A bridge between asynchronous and synchronous
>          code.
>          """
> -        create_task(self._kill_app())
> +        asyncio.create_task(self._kill_app())
>  
>      async def _kill_app(self) -> None:
>          """
> @@ -393,7 +393,7 @@ def run(self, debug: bool = False) -> None:
>                                     handle_mouse=True,
>                                     event_loop=event_loop)
>  
> -        create_task(self.manage_connection(), self.aloop)
> +        self.aloop.create_task(self.manage_connection())
>          try:
>              main_loop.run()
>          except Exception as err:
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index ca6225e9cda..0b3e781373d 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -1,25 +1,15 @@
>  """
>  Miscellaneous Utilities
>  
> -This module provides asyncio utilities and compatibility wrappers for
> -Python 3.6 to provide some features that otherwise become available in
> -Python 3.7+.
> -
> -Various logging and debugging utilities are also provided, such as
> -`exception_summary()` and `pretty_traceback()`, used primarily for
> -adding information into the logging stream.
> +This module provides asyncio and various logging and debugging
> +utilities, such as `exception_summary()` and `pretty_traceback()`, used
> +primarily for adding information into the logging stream.
>  """
>  
>  import asyncio
>  import sys
>  import traceback
> -from typing import (
> -    Any,
> -    Coroutine,
> -    Optional,
> -    TypeVar,
> -    cast,
> -)
> +from typing import TypeVar, cast
>  
>  
>  T = TypeVar('T')
> @@ -79,95 +69,6 @@ def bottom_half(func: T) -> T:
>      return func
>  
>  
> -# -------------------------------
> -# Section: Compatibility Wrappers
> -# -------------------------------
> -
> -
> -def create_task(coro: Coroutine[Any, Any, T],
> -                loop: Optional[asyncio.AbstractEventLoop] = None
> -                ) -> 'asyncio.Future[T]':
> -    """
> -    Python 3.6-compatible `asyncio.create_task` wrapper.
> -
> -    :param coro: The coroutine to execute in a task.
> -    :param loop: Optionally, the loop to create the task in.
> -
> -    :return: An `asyncio.Future` object.
> -    """
> -    if sys.version_info >= (3, 7):
> -        if loop is not None:
> -            return loop.create_task(coro)
> -        return asyncio.create_task(coro)  # pylint: disable=no-member
> -
> -    # Python 3.6:
> -    return asyncio.ensure_future(coro, loop=loop)
> -
> -
> -def is_closing(writer: asyncio.StreamWriter) -> bool:
> -    """
> -    Python 3.6-compatible `asyncio.StreamWriter.is_closing` wrapper.
> -
> -    :param writer: The `asyncio.StreamWriter` object.
> -    :return: `True` if the writer is closing, or closed.
> -    """
> -    if sys.version_info >= (3, 7):
> -        return writer.is_closing()
> -
> -    # Python 3.6:
> -    transport = writer.transport
> -    assert isinstance(transport, asyncio.WriteTransport)
> -    return transport.is_closing()
> -
> -
> -async def wait_closed(writer: asyncio.StreamWriter) -> None:
> -    """
> -    Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
> -
> -    :param writer: The `asyncio.StreamWriter` to wait on.
> -    """
> -    if sys.version_info >= (3, 7):
> -        await writer.wait_closed()
> -        return
> -
> -    # Python 3.6
> -    transport = writer.transport
> -    assert isinstance(transport, asyncio.WriteTransport)
> -
> -    while not transport.is_closing():
> -        await asyncio.sleep(0)
> -
> -    # This is an ugly workaround, but it's the best I can come up with.
> -    sock = transport.get_extra_info('socket')
> -
> -    if sock is None:
> -        # Our transport doesn't have a socket? ...
> -        # Nothing we can reasonably do.
> -        return
> -
> -    while sock.fileno() != -1:
> -        await asyncio.sleep(0)
> -
> -
> -def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
> -    """
> -    Python 3.6-compatible `asyncio.run` wrapper.
> -
> -    :param coro: A coroutine to execute now.
> -    :return: The return value from the coroutine.
> -    """
> -    if sys.version_info >= (3, 7):
> -        return asyncio.run(coro, debug=debug)
> -
> -    # Python 3.6
> -    loop = asyncio.get_event_loop()
> -    loop.set_debug(debug)
> -    ret = loop.run_until_complete(coro)
> -    loop.close()
> -
> -    return ret
> -
> -
>  # ----------------------------
>  # Section: Logging & Debugging
>  # ----------------------------
> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index 56c4d441f9c..c254c77b176 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -8,7 +8,6 @@
>  
>  from qemu.qmp import ConnectError, Runstate
>  from qemu.qmp.protocol import AsyncProtocol, StateError
> -from qemu.qmp.util import asyncio_run, create_task
>  
>  
>  class NullProtocol(AsyncProtocol[None]):
> @@ -124,7 +123,7 @@ async def _runner():
>              if allow_cancellation:
>                  return
>              raise
> -    return create_task(_runner())
> +    return asyncio.create_task(_runner())
>  
>  
>  @contextmanager
> @@ -271,7 +270,7 @@ async def _watcher():
>                      msg=f"Expected state '{state.name}'",
>                  )
>  
> -        self.runstate_watcher = create_task(_watcher())
> +        self.runstate_watcher = asyncio.create_task(_watcher())
>          # Kick the loop and force the task to block on the event.
>          await asyncio.sleep(0)
>  
> @@ -589,7 +588,8 @@ async def _asyncTearDown(self):
>      async def testSmoke(self):
>          with TemporaryDirectory(suffix='.qmp') as tmpdir:
>              sock = os.path.join(tmpdir, type(self.proto).__name__ + ".sock")
> -            server_task = create_task(self.server.start_server_and_accept(sock))
> +            server_task = asyncio.create_task(
> +                self.server.start_server_and_accept(sock))
>  
>              # give the server a chance to start listening [...]
>              await asyncio.sleep(0)
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



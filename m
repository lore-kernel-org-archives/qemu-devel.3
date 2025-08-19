Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69433CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoST3-0002NS-Br; Tue, 19 Aug 2025 15:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoST1-0002Mu-K4
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSSz-0002oh-OQ
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gq96lR5vYhO7HGalNgZ3oAeKWVJ9Z/TMOofTkUhHSqc=;
 b=K8ELJRFzEZ4HJwpkK9dunSvcQBJOFajVyMA9FWMPIUAccb0YF0n+k+2zwNtfpgqMnpkq9/
 w2+ZemhhxiGIrFo3hOHySIstHNx8ejSM6qPdSPjZzN3ZoCLgATKdrPQ3LOODMgwVXMwnms
 OCVDK5epfnjTwa66Y0HntzLSq4cwKCQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-pqoxkrLyORidM22vL8TE6Q-1; Tue, 19 Aug 2025 15:57:55 -0400
X-MC-Unique: pqoxkrLyORidM22vL8TE6Q-1
X-Mimecast-MFC-AGG-ID: pqoxkrLyORidM22vL8TE6Q_1755633474
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24457f440f0so62566085ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633474; x=1756238274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gq96lR5vYhO7HGalNgZ3oAeKWVJ9Z/TMOofTkUhHSqc=;
 b=GUEhQF1a9G66dWf1IglTdQexw4K2KpsPBclugNGikVZcZ7SN6Kgo5Sv9YqkBVTyhqW
 xM1stcN/F0DZVGb4VIfOYDpxLfYkp0GTvh7l2PVCpMYDd1xkTNmwhDbVz8uurmOb8QuV
 gsoRSnx1xtJxoXBDOctZ4YZ8g2ckbsNCtnx6sD+2KQDNK3bKvYZPPoCM+C/L8AncxwBL
 eucOOgKcKbeu4MJsnF4JQm6NNwljPt9dI0Nm5Cut8Ir+PBFdBQV6+jXwqR7XDar6eqNh
 evty7U4yPnCvO/HJm3xzRnD2Rsiqn+m2H0H7i7nFtXBDxkFIP6YTJvccd9IAPDr2KIzS
 DUzg==
X-Gm-Message-State: AOJu0YzxIoCqegkpkW8tDBcrGDrXx+ncDGbImff53PjH+1oA4KsnsavS
 afuzPhklpMd+XflKlfdNJ6vIaR72ynj4+y/pwT649UekIqGhHyKK0buyC3lEgVp/XbtjsFwMKQs
 oJI3lSKVpF8s4onICgl41lAVF9d3KCD/uGC09gZHHhkLYoarj3Kpayp1DQBPzboIsrZHz8YVZdb
 3AgM4GULC6ZZtK6he8bjnQFrR+BGNVMqM=
X-Gm-Gg: ASbGncsxq/JA2vTr+LG/pYeAbWcBrIdvV1QLjhkTTazFq0ys9GknvJLrob7dk4j/Dfw
 Lm0mm6KHRXvNQtm27nhWgBinROhHgrtv6d9ExbLc9vcMEbmqynGJtIw29ZedVSEpi+jIyDkagt9
 w7ufrHTVtvQ36UhBn0W11T76pKFDMvg5Wzs+/XzH+ia/IjDA1XRBAW
X-Received: by 2002:a17:902:ce8b:b0:23f:d861:bd4a with SMTP id
 d9443c01a7336-245ef2275f5mr2290045ad.27.1755633474136; 
 Tue, 19 Aug 2025 12:57:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Uw0lapekeIo4Xub/1nomUoPuJnJDhOBgjZRKq9hIhrzRtnNU6ayhdYUj7uVBvS+zE+SGVCZLPfn9m0p6mhw=
X-Received: by 2002:a17:902:ce8b:b0:23f:d861:bd4a with SMTP id
 d9443c01a7336-245ef2275f5mr2289755ad.27.1755633473708; Tue, 19 Aug 2025
 12:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-7-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-7-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:57:42 -0400
X-Gm-Features: Ac12FXzffvKjAypuhyiTz2cvY4s8Fs0-kgsxBv_N-k53Cq9K3BwhXY3F5sZdAE8
Message-ID: <CAFn=p-bshSJOs=6jGvG8c561bdHPc2CSRo2t98EUZq+K9kt=HA@mail.gmail.com>
Subject: Re: [PATCH 06/14] python: drop 'create_task' back compat helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 15, 2025 at 10:31=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> Our minimum python is now 3.9, so back compat with python
> 3.6 is no longer required.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  python/qemu/qmp/protocol.py |  7 +++----
>  python/qemu/qmp/qmp_tui.py  |  8 ++++----
>  python/qemu/qmp/util.py     | 33 +--------------------------------
>  python/tests/protocol.py    |  7 +++----
>  4 files changed, 11 insertions(+), 44 deletions(-)
>
> diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> index deb6b20d29..4aff0ea423 100644
> --- a/python/qemu/qmp/protocol.py
> +++ b/python/qemu/qmp/protocol.py
> @@ -36,7 +36,6 @@
>  from .error import QMPError
>  from .util import (
>      bottom_half,
> -    create_task,
>      exception_summary,
>      flush,
>      pretty_traceback,
> @@ -661,8 +660,8 @@ async def _establish_session(self) -> None:
>          reader_coro =3D self._bh_loop_forever(self._bh_recv_message, 'Re=
ader')
>          writer_coro =3D self._bh_loop_forever(self._bh_send_message, 'Wr=
iter')
>
> -        self._reader_task =3D create_task(reader_coro)
> -        self._writer_task =3D create_task(writer_coro)
> +        self._reader_task =3D asyncio.create_task(reader_coro)
> +        self._writer_task =3D asyncio.create_task(writer_coro)
>
>          self._bh_tasks =3D asyncio.gather(
>              self._reader_task,
> @@ -687,7 +686,7 @@ def _schedule_disconnect(self) -> None:
>          if not self._dc_task:
>              self._set_state(Runstate.DISCONNECTING)
>              self.logger.debug("Scheduling disconnect.")
> -            self._dc_task =3D create_task(self._bh_disconnect())
> +            self._dc_task =3D asyncio.create_task(self._bh_disconnect())
>
>      @upper_half
>      async def _wait_disconnect(self) -> None:
> diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
> index 7dfb03c9ad..61e8b3773c 100644
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
>              msg =3D Message(bytes(raw_msg, encoding=3D'utf-8'))
> -            create_task(self._send_to_server(msg))
> +            asyncio.create_task(self._send_to_server(msg))
>          except (DeserializationError, UnexpectedTypeError) as err:
>              raw_msg =3D format_json(raw_msg)
>              logging.info('Invalid message: %s', err.error_message)
> @@ -246,7 +246,7 @@ def kill_app(self) -> None:
>          Initiates killing of app. A bridge between asynchronous and sync=
hronous
>          code.
>          """
> -        create_task(self._kill_app())
> +        asyncio.create_task(self._kill_app())
>
>      async def _kill_app(self) -> None:
>          """
> @@ -393,7 +393,7 @@ def run(self, debug: bool =3D False) -> None:
>                                     handle_mouse=3DTrue,
>                                     event_loop=3Devent_loop)
>
> -        create_task(self.manage_connection(), self.aloop)
> +        self.aloop.create_task(self.manage_connection())
>          try:
>              main_loop.run()
>          except Exception as err:
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index 7f9e718154..c44a5aacbc 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -13,13 +13,7 @@
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
>  T =3D TypeVar('T')
> @@ -79,31 +73,6 @@ def bottom_half(func: T) -> T:
>      return func
>
>
> -# -------------------------------
> -# Section: Compatibility Wrappers
> -# -------------------------------
> -
> -
> -def create_task(coro: Coroutine[Any, Any, T],
> -                loop: Optional[asyncio.AbstractEventLoop] =3D None
> -                ) -> 'asyncio.Future[T]':
> -    """
> -    Python 3.6-compatible `asyncio.create_task` wrapper.
> -
> -    :param coro: The coroutine to execute in a task.
> -    :param loop: Optionally, the loop to create the task in.
> -
> -    :return: An `asyncio.Future` object.
> -    """
> -    if sys.version_info >=3D (3, 7):
> -        if loop is not None:
> -            return loop.create_task(coro)
> -        return asyncio.create_task(coro)  # pylint: disable=3Dno-member
> -
> -    # Python 3.6:
> -    return asyncio.ensure_future(coro, loop=3Dloop)
> -
> -
>  # ----------------------------
>  # Section: Logging & Debugging
>  # ----------------------------
> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index 4a0ee94727..9bb23b6a7b 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -8,7 +8,6 @@
>
>  from qemu.qmp import ConnectError, Runstate
>  from qemu.qmp.protocol import AsyncProtocol, StateError
> -from qemu.qmp.util import create_task
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
>                      msg=3Df"Expected state '{state.name}'",
>                  )
>
> -        self.runstate_watcher =3D create_task(_watcher())
> +        self.runstate_watcher =3D asyncio.create_task(_watcher())
>          # Kick the loop and force the task to block on the event.
>          await asyncio.sleep(0)
>
> @@ -589,7 +588,7 @@ async def _asyncTearDown(self):
>      async def testSmoke(self):
>          with TemporaryDirectory(suffix=3D'.qmp') as tmpdir:
>              sock =3D os.path.join(tmpdir, type(self.proto).__name__ + ".=
sock")
> -            server_task =3D create_task(self.server.start_server_and_acc=
ept(sock))
> +            server_task =3D asyncio.create_task(self.server.start_server=
_and_accept(sock))
>
>              # give the server a chance to start listening [...]
>              await asyncio.sleep(0)
> --
> 2.49.0
>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A2CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSSF-0000hY-II; Tue, 19 Aug 2025 15:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSSD-0000gt-Lf
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSSC-0002k4-89
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ni9q+m5r0WcKIq2sN6jx7/okelCYncGdS78W6UOKOYU=;
 b=I00egdlzj7whp3yIEGfHAV2/PxufNSxYMkvsFzOqXHY/cP1t3VXDpj7cizZ5eA1yIXZtWT
 jycD52tW6wMdbp9+5/X1wo0fDBcFmP8zUX9t5fsd+vyl8pv5blHAshrZyNUXjj9Ds21lz7
 UNxKMvP/f2/C+KMqnQUN5jVezNPZkHg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-PGWxSYGhNCO3QT76jWKhvA-1; Tue, 19 Aug 2025 15:57:05 -0400
X-MC-Unique: PGWxSYGhNCO3QT76jWKhvA-1
X-Mimecast-MFC-AGG-ID: PGWxSYGhNCO3QT76jWKhvA_1755633423
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458121274so69093275ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633423; x=1756238223;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ni9q+m5r0WcKIq2sN6jx7/okelCYncGdS78W6UOKOYU=;
 b=pBtlRwCvimiwcE6eU7DZ83+IsEzcxVZ7bEQ2RDa+68LOnInpRzQUGhwhbIshUhvWQe
 Z/gFkMjQRQmO2/UwKU0Y7QsbUnkDEBiO08cv4AsY+VmIALrq2hjIIiyWBPQoICkWWten
 Kxldz9x8Qj4ruus03pqKfvRRYbbCBVHQ26NjXCrHL/mdAxUbz4/s7DvU0UT0sEiObgSp
 r/DKcC9ukq4sMf65pMHXIm/XulFEbZc0PL9Sq13KcHmvsULezPhCXu7jG2oakwQUYozI
 K9AJhW2Rv9cw4OjYQlOpShqxyCNtmDgBgpIMPyChTZ7mHpxxVBlPq2oKmvyRkHdNkmxw
 NbKg==
X-Gm-Message-State: AOJu0Yz8vNhL5Z1hwtzmYVaKdJ9w7YoS0SyRHxHz4KJxzh0t5U97+ubi
 yEaXYAe+l3JWmjjF77cd4F5LnMA9qKS2LRUFRE5Dy4boeLWhABLnT5QMUcYWFDx0JMTmiRcAQIN
 Y2KvZIjbUwiNidL5pQR7cpow+hsvjEHjvTb4dzk7Oue/pEM/BxL5DJP0CyU6A3yRfMzk4Az+Rs/
 otCUkL0HnI/XjGr/Iaj+UPPrtwaWmOchE=
X-Gm-Gg: ASbGncsyOeZGJ5a8nT6yzogeW9PDO+dpiLRCQaO8hJr7PLjRI1Oo40ULDUqnaqfMkkO
 7iakdroJecsocm9wegAPdMd26CqjhNH/sOMby6Feox+y/8sp8f6sXRc9ogAv62vMEu6yjvVeL8h
 KkyremuUMN1M8/+9S61vewLKkvOVKxy29LvFfJJwlJoT8CVnitqG0y
X-Received: by 2002:a17:902:d2c5:b0:240:125:1010 with SMTP id
 d9443c01a7336-245ef14c05cmr2544845ad.14.1755633423486; 
 Tue, 19 Aug 2025 12:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHeEpjNFYuDCbAYZTD/16aQ3Lx/PLAKhNwbPDsgWv55m+ubqO2wHq6VTgoICtrqjPFmIWuA1MzXT/E/lUl3F4=
X-Received: by 2002:a17:902:d2c5:b0:240:125:1010 with SMTP id
 d9443c01a7336-245ef14c05cmr2544635ad.14.1755633423120; Tue, 19 Aug 2025
 12:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-5-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-5-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:56:50 -0400
X-Gm-Features: Ac12FXzQ8OUYQOb-lmiACxCDk2UX7zs_MNHYqzw100ahoUvkA_ArGNRauxUFFxk
Message-ID: <CAFn=p-a0x=LqudNBXYxRGM2W8Ecnap8qf8oUku9_mkte+-2vYQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] python: drop 'wait_closed' back compat helper
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
>  python/qemu/qmp/protocol.py |  3 +--
>  python/qemu/qmp/util.py     | 29 -----------------------------
>  2 files changed, 1 insertion(+), 31 deletions(-)
>
> diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
> index 9a7ada4a1e..deb6b20d29 100644
> --- a/python/qemu/qmp/protocol.py
> +++ b/python/qemu/qmp/protocol.py
> @@ -41,7 +41,6 @@
>      flush,
>      pretty_traceback,
>      upper_half,
> -    wait_closed,
>  )
>
>
> @@ -830,7 +829,7 @@ async def _bh_close_stream(self, error_pathway: bool =
=3D False) -> None:
>
>          self.logger.debug("Waiting for StreamWriter to close ...")
>          try:
> -            await wait_closed(self._writer)
> +            await self._writer.wait_closed()
>          except Exception:  # pylint: disable=3Dbroad-except
>              # It's hard to tell if the Stream is already closed or
>              # not. Even if one of the tasks has failed, it may have
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index 39fc341f2f..b5e9750576 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -104,35 +104,6 @@ def create_task(coro: Coroutine[Any, Any, T],
>      return asyncio.ensure_future(coro, loop=3Dloop)
>
>
> -async def wait_closed(writer: asyncio.StreamWriter) -> None:
> -    """
> -    Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
> -
> -    :param writer: The `asyncio.StreamWriter` to wait on.
> -    """
> -    if sys.version_info >=3D (3, 7):
> -        await writer.wait_closed()
> -        return
> -
> -    # Python 3.6
> -    transport =3D writer.transport
> -    assert isinstance(transport, asyncio.WriteTransport)
> -
> -    while not transport.is_closing():
> -        await asyncio.sleep(0)
> -
> -    # This is an ugly workaround, but it's the best I can come up with.
> -    sock =3D transport.get_extra_info('socket')
> -
> -    if sock is None:
> -        # Our transport doesn't have a socket? ...
> -        # Nothing we can reasonably do.
> -        return
> -
> -    while sock.fileno() !=3D -1:
> -        await asyncio.sleep(0)
> -
> -
>  def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool =3D False) =
-> T:
>      """
>      Python 3.6-compatible `asyncio.run` wrapper.
> --
> 2.49.0
>



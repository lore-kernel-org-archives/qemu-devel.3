Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6724BCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSSf-0001Qq-J1; Tue, 19 Aug 2025 15:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSSe-0001LV-2W
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSSc-0002lK-9n
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwycKZAt5D+pmXO37r4kkB32TFxVbse0zkW9usmUxr8=;
 b=IjQ2SMly97f+JGP6ge0hyJ4wlAslxpZDbbjZ+jKT4NgnB3SZFqZLZXDnZAitFOIwcKnoLo
 IoU+eKXJz+St/kj0NVmsWI+p6xk7sH+hL01qVtr93GqxQDQkilnDC2mS+KWoAhcC4LU7nl
 ktPiYdXa/h3gekHPZ/jH8BpMrhqV0Sw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-HgwxRTrtPzu6AYbo1SbBvA-1; Tue, 19 Aug 2025 15:57:23 -0400
X-MC-Unique: HgwxRTrtPzu6AYbo1SbBvA-1
X-Mimecast-MFC-AGG-ID: HgwxRTrtPzu6AYbo1SbBvA_1755633442
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24457f42254so135939985ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633440; x=1756238240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwycKZAt5D+pmXO37r4kkB32TFxVbse0zkW9usmUxr8=;
 b=PBLXS6zFLZjncQQH7VTuh1srQFDexODcirTvclbZH2IYSP1b2Ts1iXDgV53z3xYe45
 yaOFiP+fDOwsGWMJYXBcN7gQShFZTEU5Cf8jkMOcuixq0UtN3k5QXxoerNy5K6y3/2gn
 BJyNXcsi0222tZpfVkO/EMsLF70nMZb0jpyJEOYZmi721TfpH0fKAlRYu9HBlYOREC8p
 zSkOviJh8uCpYkuDaNyr4f8I3sICcB+rVIdRHdBaU+QyfXHJX53Ftf7lCiNgGnrU3TYH
 xz2FU/RFxaydm72vvSdi+xxo2ycwjSPfz5OAlasgaLPYGti5JCl5uBckNKROhvmJruOT
 J2AQ==
X-Gm-Message-State: AOJu0YwZyXCJlJDEqtBWD3upl8Bk2S33h7nclnKcDBROin0qPiOjBy2l
 EHgcEdbtAZpo653MpC57BGXLJ0aLAxulkD1KIZIYaG+p1/o6PJ94/EP0zlTEBb5IyEkXqmlsfn1
 6Xs2qhnsAo2FwFrZ0Kz4EBQCfFvFAqAKsEPO6NeTphg2SquhofLZoL3VrUYOkdUwnfeg4LnPQ5n
 daYFYfeShsvCFnFPd66O3TncPHava60XDkHYlg4hr73A==
X-Gm-Gg: ASbGncsU/rNfJYmKQUlDJqG92065bGfm9eszCO9T2n5ZAL9HuHL+d34oKGBZJ7v6lXz
 3sKtSpLsQs05za0uTW5/BQOfaZ1avT5pErXD1hCLcE2rapJ5jleXvaC0Ji+OwtjhV+fGxMHHl46
 PF9yifDPeVIc0Msp0sE+ZJgb9JZuKS8/ZNMk78zVTlFHojTuLZunky
X-Received: by 2002:a17:902:e752:b0:240:4b3b:334f with SMTP id
 d9443c01a7336-245ef2161cbmr3160855ad.34.1755633440104; 
 Tue, 19 Aug 2025 12:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPyKqRQEC9vSPWeL6VrfZhce4ThHbXaomrBx7/nuRJA7uQM6k7tpnNzTTW9nhZdnD/lTsIfjntd6gTDvwzyY8=
X-Received: by 2002:a17:902:e752:b0:240:4b3b:334f with SMTP id
 d9443c01a7336-245ef2161cbmr3160505ad.34.1755633439659; Tue, 19 Aug 2025
 12:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-6-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-6-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:57:06 -0400
X-Gm-Features: Ac12FXzU2VRT31LpsQwSNWs5f0CANVOkZ3faQ7ehh7-JGvnRdN0sXG44x1yoiBE
Message-ID: <CAFn=p-anduUEjqagdmQummn6SZ46MvxUefxJ5uOj+PRWETy8=A@mail.gmail.com>
Subject: Re: [PATCH 05/14] python: drop 'asyncio_run' back compat helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
>  python/qemu/qmp/util.py  | 19 -------------------
>  python/tests/protocol.py |  2 +-
>  2 files changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index b5e9750576..7f9e718154 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -104,25 +104,6 @@ def create_task(coro: Coroutine[Any, Any, T],
>      return asyncio.ensure_future(coro, loop=3Dloop)
>
>
> -def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool =3D False) =
-> T:
> -    """
> -    Python 3.6-compatible `asyncio.run` wrapper.
> -
> -    :param coro: A coroutine to execute now.
> -    :return: The return value from the coroutine.
> -    """
> -    if sys.version_info >=3D (3, 7):
> -        return asyncio.run(coro, debug=3Ddebug)
> -
> -    # Python 3.6
> -    loop =3D asyncio.get_event_loop()
> -    loop.set_debug(debug)
> -    ret =3D loop.run_until_complete(coro)
> -    loop.close()
> -
> -    return ret
> -
> -
>  # ----------------------------
>  # Section: Logging & Debugging
>  # ----------------------------
> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index db5d54d83f..4a0ee94727 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -8,7 +8,7 @@
>
>  from qemu.qmp import ConnectError, Runstate
>  from qemu.qmp.protocol import AsyncProtocol, StateError
> -from qemu.qmp.util import asyncio_run, create_task
> +from qemu.qmp.util import create_task
>
>
>  class NullProtocol(AsyncProtocol[None]):
> --
> 2.49.0
>



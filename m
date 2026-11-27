Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ffKvadcW;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=N6WMZa0M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu35-0004dI-LQ; Fri, 27 Nov 2026 06:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xWu33-0004bW-QG
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 06:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xWu32-0004eZ-1K
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 06:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795778602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/pQHxWfG5SbZc1s9n5Y7y/Oupw8cHHKWdE7naUN1Eo=;
 b=ffKvadcWT4kU2PLtPVnrVp8O8iJqff0bYdaVWGJkclkpJq1I0slAhnN0iuea5ewesVcXBp
 VeR0ZcVa0lOXivVNvmRXok1C256NfHoTESKxXgw/C7ojagF0nLpTBz1k5f94nGgmGqNzqy
 5MhO0+3v7kNspHDLp0gfPcxsetgjIjk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-z3nqoYdePzWTgwhy1XrQsQ-1; Fri, 27 Nov 2026 11:23:19 +0000
X-MC-Unique: z3nqoYdePzWTgwhy1XrQsQ-1
X-Mimecast-MFC-AGG-ID: z3nqoYdePzWTgwhy1XrQsQ_1795778598
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f04561ee04so44958275ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 03:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795778598; cv=none;
 d=google.com; s=arc-20260327;
 b=n6rW7qy2vmItqlVQ01QkVSqCnXzTtBdeeLUNTbI/aonBloH+YBpdzE46Xi+uWhBfVG
 7uzJTO+HF5fkSdWnQEYO1Dj2h6WKBhT6cLEQS65KCTHDfKRHJfZ2bqnw6jIOCEq/Q38V
 jVQxul525u3EQzOlNrDAkmwzuJXhgk1Y0hmUP089OYx0tXaqIFDUs3CjCUfX9IuqER5z
 djRQ3Q2Ag/V/Gm/XFqROw0KxpgzaoXq8ciH023kIkjlri5mdgJF6Wf2G6P0c+q2BKBpc
 njx9sneEcGzha8XcsJvYptJPBxNmKTNLS0PZVK20oED4XTOkVcrPsYIjUbYHnnzKXli2
 xo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e/pQHxWfG5SbZc1s9n5Y7y/Oupw8cHHKWdE7naUN1Eo=;
 fh=kxBOQf79OU60jTnEw9uPJh7lgS2EAGYlIhJuzGdC/io=;
 b=W2RiBe9dS3WKpEkJdFqflZ/Eh5yL6kIonrLjKHTRwEGlocTXmCB6w+n4dJPPbitVwz
 8nw/B52UKA4wM/Mvdb5vAgBYL7J57j7GXIDR2SlSBmBVt8oevG08Uh6O/ETJRMJf2XnX
 mie0Z0mvuxKQ1tt1Fc1cD8T50tCudWmagawQ0965SypMc2Tu5v0DMXKOYKhAR3gGTwTi
 WLc/Vgjr7L/tddeC/rqo1YiT8hBvwoTVrM1J0Ur263RnlqjYKk9b9s17DL5PqN7vvO7o
 32gSdWAcAlWpxdabQDN0xFCZgpMfx2mYCHgNip0LxcVfzoRXVbCCohW1FFYqZxywUeRs
 5l8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795778598; x=1796383398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e/pQHxWfG5SbZc1s9n5Y7y/Oupw8cHHKWdE7naUN1Eo=;
 b=N6WMZa0MK5XVbK0jjGP18gF3AtZIpdq44Kcahh+eY9kcptbvEJ0oZSAcRcD3PxEY3f
 cQjoCUIHLFLSVqoiU5bcdwqvAaTsrhqpRMQZtzsB2cHvGLs+7VuE7H+sv4PTifCAv9Fg
 m+ZTkc5oy6hVv6iXJBaXZNLZVCAk7zVVcQXjUIVHZoPNfOmCKanJfOwU/Vb7tCoWfjBd
 HC64GuNnwCIHywSWcrwz/EPDJGQ6bR45LbKNIE8VRo5lBrWESQOx8dd/P1CTzQPT+SNF
 nNowqOeSMHeAwIF74l0WHtyQK5tU6Yicgh7yslZ7NG/rvurdo7Lyq3HtxKPbVN5/PRyU
 /JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795778598; x=1796383398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e/pQHxWfG5SbZc1s9n5Y7y/Oupw8cHHKWdE7naUN1Eo=;
 b=hJbWfT1PN3Mhd8jdxt4/kYLvmc2PO9hQyMcJxRCBzNn2I+LYkAKsVXySxOm2DqZx2m
 KsmFpU12b4w0oTI+Ua7rvLY513ozfbvOkn7Hd616UtGWHsBgdh1F2WfGTrJarZY8HUU4
 zUQ9KW3Am0YgdnNMgrOrkA8cF0lOT44GLojtLkgorMpFm5dODmSKM2pvS+LpAL96LOmL
 XUnQxtTxUDix3U3x7wO9L+0+r+B28e3DM46edLdAGRUUAk+e/Cxr5N+P3IMa7Xlq/4lR
 1HI+wHcNXiVpHkeamFVe2HOy0loucU+KP7+4jKs3UqjTRDEqAu8k00wwAyyI/PleeBLq
 x5XQ==
X-Gm-Message-State: APuU4Z/8n0cfd8SEmnGm648lpr3pxbySHncNzOpUbt71Sha60LgfUj/w
 S04tdSu6JxOggQOg/1g1EZSrxG/Yx9Fh7NU/O0yX2WjxfYlnUnOReoTodwDMd7aJ/ZbgcmKycU3
 12mLapw8rktNZ8zwWcQsr6Jl66n3n//GjEJjmYT070wtpeyEgs/Jf7myCCVUFCSdSofD1ICCXDc
 RGB27gADOAAzhCO4C3BQW73B/2rea/jPU=
X-Gm-Gg: AZFdTZfBL5AdTiXNp6gSvDRyvXQlh3S5QxFLaEW7ETb4uWGTJs7OOceOXx+DDDrWeb0
 8ldlXGDSAKLM+mLodwL0BB1nvR2IZc98wT0WNjZG5LJ/oMr9xKUMbzI1Gi2BCoTuFAJRE+pSeY5
 dWAumo3D15VyWSLNnnKef5qEVdZMAtY4PoQJF80mgnro+stHzmOpbjXf4T6o0AHVTztOtBNznmV
 RtRPTtUPcF6yfK5fgx8Zgiu5uGXfjJjBnqhtOZeUv1s6ppHG7A/L2DDN/jwJWlE+fQhzpMGkP+Z
 Kw==
X-Received: by 2002:a17:903:3888:b0:2e9:5714:608e with SMTP id
 d9443c01a7336-2f03f1beee0mr254437605ad.49.1795778598355; 
 Fri, 27 Nov 2026 03:23:18 -0800 (PST)
X-Received: by 2002:a17:903:3888:b0:2e9:5714:608e with SMTP id
 d9443c01a7336-2f03f1beee0mr254437285ad.49.1795778597867; Fri, 27 Nov 2026
 03:23:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
 <20261124-issue-4848-v4-3-24993c4766fc@redhat.com>
 <b6d7c99c-eb8b-480d-806d-e8051b3e44c1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b6d7c99c-eb8b-480d-806d-e8051b3e44c1@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 27 Nov 2026 15:23:06 +0400
X-Gm-Features: Aa3M54rGhQteJtyhw-ablpkWwmK5zR760xjPe0RCSMRWKFgzy3rMKE6aa7dVGD0
Message-ID: <CAMxuvay0TPLq2emyP87+WYzOb7hCCiun56x+f66Vj7+FmxNdkA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry R <rdmitry@taktcycles.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hi

On Fri, Nov 27, 2026 at 10:23=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/11/24 21:47, Marc-Andr=C3=A9 Lureau wrote:
> > A GL display client that stays attached across a device stop can unbloc=
k
> > the console after vhost_gpu_fd has been reset to -1: the UpdateDMABUF
> > reply or the one-second gl unblock timer reach
> > vhost_user_gpu_gl_flushed(), which installs the display socket handler
> > on fd -1. With the io_uring fd monitor, the failed poll of fd -1 is
> > reported as readiness, so the handler runs and is re-armed forever.
>
> console_hw_gl_unblock_timer() only logs a warning. I guess you meant the
> timeout specific to D-Bus instead of the timer in the common code, since
> the timeout actually leads to qemu_console_hw_gl_block(..., false).
>

Yes, I fixed the commit message. thanks

> The fix itself looks good to me.
>
> Regards,
> Akihiko Odaki
>
> >
> > Only set the handler when the device has a display socket.
> >
> > Fixes: 3cddb8b9e0b5 ("display/ui: add a callback to indicate GL state i=
s flushed")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4847
> > Reported-by: Dmitry R <rdmitry@taktcycles.com>
> > Tested-by: Dmitry R <rdmitry@taktcycles.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/vhost-user-gpu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index 32e7d9638f68..61a15dd916f8 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -448,6 +448,11 @@ end:
> >   static void
> >   vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)
> >   {
> > +    /* the display socket doesn't exist before DRIVER_OK */
> > +    if (g->vhost_gpu_fd =3D=3D -1) {
> > +        return;
> > +    }
> > +
> >       qemu_set_fd_handler(g->vhost_gpu_fd,
> >                           blocked ? NULL : vhost_user_gpu_chr_read, NUL=
L, g);
> >   }
> >
>



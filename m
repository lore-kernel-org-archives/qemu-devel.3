Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35463C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 09:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLfDY-0003b3-Nz; Sun, 01 Jun 2025 05:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uLfDX-0003ao-GA
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 05:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uLfDV-0005DW-8M
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 05:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748770973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSOAlHv4ln6RHvXBwp8KWEb8JOYyxx2oNLERD6uyi6o=;
 b=XdUKZ7Xfhetu+NjMYp0GoBfnyJXHYFeNSQm66LgCmfgTX4xVzrrVyNZjKwnh8x15Xr6Rs1
 LMHyAH9HWbJFQXHAI7YrAt1et5PInO5KttDuFMGY5+sbVAkZoWnKcFwMMa7vZWN56Ttf+N
 BrYyA+UApZ1vgs8DS0XiS6mPDfYiuac=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-3BsvC8NsOJuelusgrubKBA-1; Sun, 01 Jun 2025 05:42:52 -0400
X-MC-Unique: 3BsvC8NsOJuelusgrubKBA-1
X-Mimecast-MFC-AGG-ID: 3BsvC8NsOJuelusgrubKBA_1748770971
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a582e95cf0so6638471cf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 02:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748770971; x=1749375771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSOAlHv4ln6RHvXBwp8KWEb8JOYyxx2oNLERD6uyi6o=;
 b=Gsr9wLebi/eInXgGMpalFVucBVXNdb+9LHkJ0X93O6QUGME/xL2RbBVw20diVguDav
 EA22YSc1R+FQwkceZOksgzjtMbUyJ9ai5619PiCBLLLpvbdcEpaEHtFxkMHur0MRgZUo
 7q6R+XBMwaMAlqcYWYOsxbcMd8dBPDIZ94uVBYWwjj1lhE7YWzkZj5FSf8i5c+Mmw2c7
 OSow2BFU7CqDrdZwhFOVJ/aQqGy76YgJrgaMCMoCkYtbijkIQM3B6JfneS6ZFkX4O3Bc
 mk4yTorteO8ZK4hBXNeixOB9bWPn2N1D6ZzE3ODatC3K6G1xbNJMwxMIdq03mACrHQEE
 U/5g==
X-Gm-Message-State: AOJu0Yzedl5fLtexZnLcnryRLsqmxSFLWhuxMRPVEIyCQWTsI7HcVFT+
 TQGeecoDIS2zA47tNMyi97GQCsJzy68zhlbcMMxfjnOVGzCJgJr8IKvAKsT9/FhG89iMv3aXH+W
 /Q5GmW6KHKOZBDq9x34Qh4JNYjaDUXF1BakfAuHFRN6QYDDko7t3acIxYHv/BEetqxAnTTj2XEj
 8demETnp6AhXqTIMRPZ8F7fHQOSxoygXA=
X-Gm-Gg: ASbGnctpS4aRWm0HNogvV3X8okMXBZ1D4/k8E0tP+byx925ml9ENNd1Gin8Wp3XynPZ
 NTg8Iv9RDqij3ZKRJ3LNMXOi9jFkFBrL2tqvmJ9dWVYgW0IS1jhM6tY8kvXyEx/JZF3nf4d78RX
 z+/5Pl3D00L3YFiWl4gRfNTAaHNA==
X-Received: by 2002:ac8:5cca:0:b0:4a3:d015:38c0 with SMTP id
 d75a77b69052e-4a4aed83fe5mr77688471cf.37.1748770971530; 
 Sun, 01 Jun 2025 02:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERLpnDoeZx/zKLsuUD1vRGOVkCJr5GX01p7KDaQjrLnubPj9/9FnwL6H25JDACKEWNR0lZx39Ez2YBmU4OCoo=
X-Received: by 2002:ac8:5cca:0:b0:4a3:d015:38c0 with SMTP id
 d75a77b69052e-4a4aed83fe5mr77688321cf.37.1748770971173; Sun, 01 Jun 2025
 02:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 1 Jun 2025 11:42:40 +0200
X-Gm-Features: AX0GCFvcAbwz9xd_e0M4RPxdMigt6RIr-A2Ki9doFSWqVNp4J-re_o1tuVXme-0
Message-ID: <CAMxuvazrQ_1A-7esP6bGmZzt7D0vETRdZe275arSKy72ZVEPCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ui/vnc: Do not copy z_stream
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000087d62806367f78f6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000087d62806367f78f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Akihiko

On Sat, May 31, 2025 at 4:55=E2=80=AFPM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> vnc_worker_thread_loop() copies z_stream stored in its local VncState to
> the persistent VncState, and the copied one is freed with deflateEnd()
> later. However, deflateEnd() refuses to operate with a copied z_stream
> and returns Z_STREAM_ERROR, leaking the allocated memory.
>
> Avoid copying the zlib state to fix the memory leak.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Rebased.
> - Link to v1:
> https://lore.kernel.org/qemu-devel/20250417-zlib-v1-0-34fad73b843b@daynix=
.com
>
> ---
> Akihiko Odaki (2):
>       ui/vnc: Introduce the VncWorker type
>       ui/vnc: Do not copy z_stream
>
>  ui/vnc.h              |  14 ++-
>  ui/vnc-enc-tight.c    | 341
> ++++++++++++++++++++++++++------------------------
>  ui/vnc-enc-zlib.c     |  34 ++---
>  ui/vnc-enc-zrle.c     |  69 +++++-----
>  ui/vnc-jobs.c         |   9 +-
>  ui/vnc.c              |  56 ++++-----
>  ui/vnc-enc-zrle.c.inc |   2 +-
>  7 files changed, 258 insertions(+), 267 deletions(-)
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20250417-zlib-ce3034f8bc3c
>

Can you rebase again? thanks

--00000000000087d62806367f78f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Akihiko</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, M=
ay 31, 2025 at 4:55=E2=80=AFPM Akihiko Odaki &lt;<a href=3D"mailto:odaki@rs=
g.ci.i.u-tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">vnc_worker_thread_loop() =
copies z_stream stored in its local VncState to<br>
the persistent VncState, and the copied one is freed with deflateEnd()<br>
later. However, deflateEnd() refuses to operate with a copied z_stream<br>
and returns Z_STREAM_ERROR, leaking the allocated memory.<br>
<br>
Avoid copying the zlib state to fix the memory leak.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.a=
c.jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
---<br>
Changes in v2:<br>
- Rebased.<br>
- Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20250417-zlib-v=
1-0-34fad73b843b@daynix.com" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/20250417-zlib-v1-0-34fad73b843b@daynix.com</a><br=
>
<br>
---<br>
Akihiko Odaki (2):<br>
=C2=A0 =C2=A0 =C2=A0 ui/vnc: Introduce the VncWorker type<br>
=C2=A0 =C2=A0 =C2=A0 ui/vnc: Do not copy z_stream<br>
<br>
=C2=A0ui/vnc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +=
+-<br>
=C2=A0ui/vnc-enc-tight.c=C2=A0 =C2=A0 | 341 ++++++++++++++++++++++++++-----=
-------------------<br>
=C2=A0ui/vnc-enc-zlib.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 34 ++---<br>
=C2=A0ui/vnc-enc-zrle.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 69 +++++-----<br>
=C2=A0ui/vnc-jobs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 56 +=
+++-----<br>
=C2=A0ui/vnc-enc-zrle.c.inc |=C2=A0 =C2=A02 +-<br>
=C2=A07 files changed, 258 insertions(+), 267 deletions(-)<br>
---<br>
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7<br>
change-id: 20250417-zlib-ce3034f8bc3c<br></blockquote><div><br></div><div>C=
an you rebase again? thanks</div><div>=C2=A0</div></div></div>

--00000000000087d62806367f78f6--



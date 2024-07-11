Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F6AC3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRnz8-0000yb-03; Thu, 11 Jul 2024 03:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sRnz6-0000y5-La
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:12:56 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sRnz4-00039l-Us
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:12:56 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38027so545315a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720681973; x=1721286773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UqVrWDbnRNfpkm/MdJzaA/aSZrc6r5GvsZZ4aGsPQdE=;
 b=WWlpQDNyiIdmgRfRkbyvqDUbrdNsGuMVSQ505CrZrSxN7NVs9wM+S6U1ycUfjVphco
 8QjEbuvaCQuHLqSx8KYBbk652oQCZ+Y+utP8g4tPgMSp3e4SQWEmVi5suOCbHADfxqKe
 UXGO7j50ZMcw8nxSgo5R5odlGW90Gl6qzhHdCsRQ7x1b1/4gTHVg3FPWXL/nENc217TT
 1LJXh92qQUEM0TLuTqrZ0bGYKhfnNCOiP8OfiPhFWkFwP234r5m7SbOQ/mpBA4PTw+No
 bjvKJNejR7bSXM8bD96v8kArRYCyzhNmq/6BybfISiHa+d1vD/qG5+vTQ05G2ltC6D2M
 pCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720681973; x=1721286773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqVrWDbnRNfpkm/MdJzaA/aSZrc6r5GvsZZ4aGsPQdE=;
 b=OI4+IBZLy74xvqM5nRH/bVU8XsJzRLmCk2KR5f0AlgMxzSWdDSnpJkG7vc63EprPQi
 2nO2tBLqMwD4GQQfdIFQQisruE+Nu1P0+Yu9VJ13EIFQ8LIt/wQnIEvl/xbcXmCE/6tj
 PZTPJQSlLuF0mFnN58+mD6URELt5xHhjo2uWAzFzxOEKWopqfd/MR3IRlXsTVDwcry+D
 4z3BVh+aq16GCbZM/68BYUV8np8r2GZ5CuVraao6afvyhp5o6enSe7CELBu/rgRIWNc7
 anCE/yMoMPKk4thBsF0tgJceaVxcwwXTcaG7TKSrDl8TeIvgFJAKn6AmIIFKmUXR2pzR
 lzxg==
X-Gm-Message-State: AOJu0YxUJlorCVM9Ro3F1QjTqjR+Y314JEoHCMDALREfodKPw6Dcn7mt
 ku454zS5qWn+bm/an3hBNkOJE+Q9mNIz2fLvPBW2bZGohAix2jeUTcZWKZG+HcS2Z/t7XTG/W7p
 etaEUyOfzn3J7ruw2u8fzXTCfYNw=
X-Google-Smtp-Source: AGHT+IFZiQ/3eI0K72HO3Zed6y4SM0vF4n+vGcoR8mHEVk8/9e3X63bhQD5m0PoO7gLrRPDQhz3jpUcIMTUO/vIgFEM=
X-Received: by 2002:a05:6402:1941:b0:58b:eb96:81ea with SMTP id
 4fb4d7f45d1cf-594bb085d40mr6310305a12.18.1720681972437; Thu, 11 Jul 2024
 00:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Jul 2024 09:12:40 +0200
Message-ID: <CAJy5ezpysMF79vcvnauN9vP2pPLEpA+hHNNWi+8vo7ZunAbRYA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, anthony@xenproject.org, paul@xen.org, 
 peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000bd1d24061cf37dab"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000bd1d24061cf37dab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:28=E2=80=AFPM Stefano Stabellini <sstabellini@ke=
rnel.org>
wrote:

> Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
> maintainer for years, and has already made key changes to one of the
> most difficult areas of the Xen subsystem (the mapcache).
>
> Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
> are very happy to welcome him to the team. His knowledge and expertise
> with QEMU internals will be of great help.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
>
>
Thanks Stefano!

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6725913c8b..63e11095a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -536,6 +536,7 @@ X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony PERARD <anthony@xenproject.org>
>  M: Paul Durrant <paul@xen.org>
> +M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*
>

--000000000000bd1d24061cf37dab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jul 10, 2024 at 10:28=E2=80=AFPM =
Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org">sstabellin=
i@kernel.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Add Edgar as Xen subsystem maintaine=
r in QEMU. Edgar has been a QEMU<br>
maintainer for years, and has already made key changes to one of the<br>
most difficult areas of the Xen subsystem (the mapcache).<br>
<br>
Edgar volunteered helping us maintain the Xen subsystem in QEMU and we<br>
are very happy to welcome him to the team. His knowledge and expertise<br>
with QEMU internals will be of great help.<br>
<br>
Signed-off-by: Stefano Stabellini &lt;<a href=3D"mailto:stefano.stabellini@=
amd.com" target=3D"_blank">stefano.stabellini@amd.com</a>&gt;<br>
<br></blockquote><div><br></div><div>Thanks Stefano!</div><div><br></div><d=
iv>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.=
com">edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 6725913c8b..63e11095a2 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -536,6 +536,7 @@ X86 Xen CPUs<br>
=C2=A0M: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org" t=
arget=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
=C2=A0M: Anthony PERARD &lt;<a href=3D"mailto:anthony@xenproject.org" targe=
t=3D"_blank">anthony@xenproject.org</a>&gt;<br>
=C2=A0M: Paul Durrant &lt;<a href=3D"mailto:paul@xen.org" target=3D"_blank"=
>paul@xen.org</a>&gt;<br>
+M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com" targe=
t=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0L: <a href=3D"mailto:xen-devel@lists.xenproject.org" target=3D"_blank=
">xen-devel@lists.xenproject.org</a><br>
=C2=A0S: Supported<br>
=C2=A0F: */xen*<br>
</blockquote></div></div>

--000000000000bd1d24061cf37dab--


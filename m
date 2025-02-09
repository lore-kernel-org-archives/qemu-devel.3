Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4055C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 18:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thCDx-00019f-9l; Sun, 09 Feb 2025 13:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1thCDv-00018H-2M
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:40:07 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1thCDs-0000Q2-LV
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 13:40:06 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa345713a8so3872934a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1739126402; x=1739731202;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wCuy/VNNVLADGTx75INcd8iyzz9qdlRRFc3D4tzH2as=;
 b=saq84d7E9mSugIhPHwWWanV5L300bFgVWNPjr0aSq1AA57Y4L85kQCF7nJL810RcUj
 BjWUlNeqZzVucJocaicMX+wUmroIQKYqiGEPYloAP1eE+eD2RmQPQ1HkNFhciqy3CmE7
 mz98JJ2drfSSw3RQZYunFZpYeYuw/6GlilOfW20lqcMNv++r1kh22kMHdEGQEy2dKSl4
 AP4+Fazsoxn0OhNqCEJZrAY9zvXogU7GGHpWZG2KGVKqDmqbaiGWkIvawG8R58NfN8qu
 vCqaH6IQfbr7Fq7pvvowaKPMyDfUYM/zbzvKZyNqeMOJm/WaNJTbtZvor90efejgfiKM
 QH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739126402; x=1739731202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wCuy/VNNVLADGTx75INcd8iyzz9qdlRRFc3D4tzH2as=;
 b=q1ICWtDO/ghPdS8uorRbAFdL0pAVUNdCtkrkn4eb/wlphnUgXEXdea4tDHi2b7//BR
 21eMK0suhoLeaA/XQyU+kpigDiGKsoj8e5ggA1MgjnuvTy/PKJHNEu5iQBwc6YhYoEnj
 Fuic2yxIZF9nZzbQ7BqPqcL9whh4bNYe2y0Kj1Nrsc6QA9s2b6lKlhyRrd7zLCTZw94x
 zjELTkEGd8VEklT6ntJnEcd5Nklo+3lj+MYyt3AH659sQnjS9XZ6ENWu48hTRGruOzND
 S9ai24ReiN7a1I5Qxl9Nl0Xu8IZ7FZZWRMHUSUlSIlvZXT3A1GU193RsU2yMWqOiB5wJ
 BERw==
X-Gm-Message-State: AOJu0Yyvf+4Sj0SfsJKaEyjVPQ3jqT54JdBzroxaAMZ64Bf8lH7PtK5g
 M1IT9tMZrD6St1FSftQrTaYc1RS48YHxjN57pgvh7OzxUxoQ5Yv4v9vvSnVewyKTS/EUtWJ08QI
 w23N1ebLJMQxl1A70DJWa5MvtDrId7yMFF1dl
X-Gm-Gg: ASbGncsU2eMP5r/UYtT0ZJ0g9QM2lf1xVeWym37ysChUKTUJU1a0R0C2mkjLz73f2ue
 bUSDMpY7sRIu4bbluRmeWm4tOU1OunGxep3vgKCpS4Fa7x0zndMeQVwcoDM94681hVXG1VgSu
X-Google-Smtp-Source: AGHT+IFAw3b5/ef6qKbfg6ue5eQrQI3WrhmA4V+qxzqfev3l9g8czAqHK9iD/H1WUlgmcdLcVV34UyGk0+b+9vokKAo=
X-Received: by 2002:a17:90b:278c:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2fa243db8e7mr16021043a91.27.1739126402238; Sun, 09 Feb 2025
 10:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20250207210655.16717-1-richard.henderson@linaro.org>
 <20250207210655.16717-5-richard.henderson@linaro.org>
In-Reply-To: <20250207210655.16717-5-richard.henderson@linaro.org>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 9 Feb 2025 19:39:50 +0100
X-Gm-Features: AWEUYZlNbiTN0i1guyYWAhvdI0qmZ4ctYo6_F6VK6ftyXImQ5d1GKR1YS5ZH-l0
Message-ID: <CAGCz3vtNLDpgUJ039GoGT0FEGyr7hOUK_z_O9zSuNqWqF-SqkA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] meson: Disallow 64-bit on 32-bit HVF/NVMM/WHPX
 emulation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, 
 berrange@redhat.com, philmd@linaro.org, thuth@redhat.com
Content-Type: multipart/alternative; boundary="0000000000006ce411062db9eb9a"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::1033;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000006ce411062db9eb9a
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Feb 2025 at 22:07, Richard Henderson <richard.henderson@linaro.org>
wrote:

> Require a 64-bit host binary to spawn a 64-bit guest.
>
> For HVF this is trivially true because macOS 11 dropped
> support for 32-bit applications entirely.


Nit: it was 10.15.


> For NVMM, NetBSD only enables nvmm on x86_64:
>
> http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?rev=1.1.6.2;content-type=text%2Fplain
>
> For WHPX, we have already dropped support for 32-bit Windows.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>


> ---
>  meson.build | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 911955cfa8..85317cd63f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -319,13 +319,11 @@ else
>  endif
>  accelerator_targets += { 'CONFIG_XEN': xen_targets }
>
> -if cpu in ['aarch64']
> +if cpu == 'aarch64'
>    accelerator_targets += {
>      'CONFIG_HVF': ['aarch64-softmmu']
>    }
> -endif
> -
> -if cpu in ['x86', 'x86_64']
> +elif cpu == 'x86_64'
>    accelerator_targets += {
>      'CONFIG_HVF': ['x86_64-softmmu'],
>      'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
> --
> 2.43.0
>
>
>

--0000000000006ce411062db9eb9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 7 Feb 2=
025 at 22:07, Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lin=
aro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Require a 64-bit host binary to spawn =
a 64-bit guest.<br>
<br>
For HVF this is trivially true because macOS 11 dropped<br>
support for 32-bit applications entirely.</blockquote><div><br></div><div>N=
it: it was 10.15. <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
For NVMM, NetBSD only enables nvmm on x86_64:<br>
=C2=A0 <a href=3D"http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Make=
file?rev=3D1.1.6.2;content-type=3Dtext%2Fplain" rel=3D"noreferrer" target=
=3D"_blank">http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/nvmm/Makefile?r=
ev=3D1.1.6.2;content-type=3Dtext%2Fplain</a><br>
<br>
For WHPX, we have already dropped support for 32-bit Windows.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"ma=
ilto:phil@philjordan.eu">phil@philjordan.eu</a>&gt;</div><div>=C2=A0<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build | 6 ++----<br>
=C2=A01 file changed, 2 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 911955cfa8..85317cd63f 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -319,13 +319,11 @@ else<br>
=C2=A0endif<br>
=C2=A0accelerator_targets +=3D { &#39;CONFIG_XEN&#39;: xen_targets }<br>
<br>
-if cpu in [&#39;aarch64&#39;]<br>
+if cpu =3D=3D &#39;aarch64&#39;<br>
=C2=A0 =C2=A0accelerator_targets +=3D {<br>
=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_HVF&#39;: [&#39;aarch64-softmmu&#39;]<br>
=C2=A0 =C2=A0}<br>
-endif<br>
-<br>
-if cpu in [&#39;x86&#39;, &#39;x86_64&#39;]<br>
+elif cpu =3D=3D &#39;x86_64&#39;<br>
=C2=A0 =C2=A0accelerator_targets +=3D {<br>
=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_HVF&#39;: [&#39;x86_64-softmmu&#39;],<br>
=C2=A0 =C2=A0 =C2=A0&#39;CONFIG_NVMM&#39;: [&#39;i386-softmmu&#39;, &#39;x8=
6_64-softmmu&#39;],<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000006ce411062db9eb9a--


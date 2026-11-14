Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1563606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LErfaJdi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGfn-0006Kl-Vh; Sat, 14 Nov 2026 11:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1xSGfg-0006Il-30
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 11:32:08 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1xSGfe-0001Ju-Bj
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 11:32:07 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-7d2c8141dc6so2096921137.1
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 08:32:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794673925; cv=none;
 d=google.com; s=arc-20260327;
 b=fRSySUfEs+y5DXujlLopcPesBKIOK6B//XsKimBoYeAxGzcJG22m48Zt5mJF92YjIn
 WkssIr5RllKVYCSNZf55TsCKCHNq2Lif3cN0mSZtDk+fAX8FfyOtLsnxOxjaTaZBjHmz
 XjDRAb/zVk2Cfs1kHCxU7wK19BHsX3WIHVo/8QNmmyIxwAR5uy5jXGaKCeJ7+Ky5AyWj
 iu0nLdSCk86oXBR5LTMApcyqtGF46wB3gs6ODqdy4dIvrJsE1GJjsbMm+ZP56WVAqT/0
 i+VYuc8yO7h/LS6o0COB8aKRrKubUikP1zgQBpsbFPCDIecu3aw8sEpAIQM1e2+R4GL5
 gfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3wgdSIAoDrEeIIvXG4HKDKD5HT942YEmTc7V5U1ViXA=;
 fh=utb77xCxwlPd36NFcJPZFPFbj5qUgf1WUqK+b1HVE6Y=;
 b=jXK15g13dPDCiOPh88pAGfPgI0PsOWKlWXDBMNX/sSbPHo7Gh0UrQ3BsTCSQ2htYmI
 Odf+xaaZRSy+xXFw2Ayr11SG0DB7Y4r62VIYUwkLUSb5EZd2boQ9VaHdbau8uQJmufDm
 g6zboJ3GCO0hE9+pgtDJrPuF7BFm13Fs32KZsSZ6Dl15ex8KeuHL5ytbKiTCGCtxKVFM
 aHOrSp2skuIccVJtMVAM2/WzCXwr1XjiDS/gFZRD2w5eq+908LEuPQPEUsq1XctB6zzM
 Ck+utAWNvak/u7sxmCsAf4qz7R+R1qeyT/sM0BnRXUQzbfNJ/6ZlGWrQBttM+7c7s7CV
 PT6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794673925; x=1795278725; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3wgdSIAoDrEeIIvXG4HKDKD5HT942YEmTc7V5U1ViXA=;
 b=LErfaJdi5eD7iJGNw4sSv4c4ivSVVZvjkwaZSEvc90kW908OdftyJ0dIux7Sdhhv2k
 rItYeg+bxvQKe75fswsy1nm10nen/RiqQR/gthjssY5En/9gPB7qAd8dk3Zp7YmZ8dIC
 ysGikidUsIewoToh5A9ieO94mWAFvYpEj0pOpNAkgfO9Iw6iwZpPhk9FH52P7TuZrpRk
 ZS14DBgm+CdOT/gbnayGUqu9uqsrovkHs9TRCMnmLDeTIYlELLIYM1VwKpZno7ut5ZSA
 g+16b0hdLcEgB88f07eJ/06fzYvTJ9B7caA3Qr5Be+gUn5oHrloGUxT/qy6XPp/d1UdA
 D+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673925; x=1795278725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3wgdSIAoDrEeIIvXG4HKDKD5HT942YEmTc7V5U1ViXA=;
 b=WWlncx8TfyIGvQDucCBjT2obtlGrtLWHMhF4m/tSYFcNTPwPHmpy8ISE+CM6Ck4SY2
 M4RLBXri6HV45ezTUaxk5iXxe3RNQfesdMx9D+KokiwGm1k3OyU+22RfmiXYyjQqHwra
 EeTAUU5cVgE4Rxe7cph0wyqHrvB9w+lHytKQJnS0cUUuz8pvkZolWRRSFXwB8XzG5w8E
 3494Wl69Wb0HT8IU/13XxY8XNjpZQoHViIKOTZVgfoUJsg5QS+pJ93T0LON9aVAVkp4e
 6fgdBqksh2NNtFBOCmyE+6EWi2WDuZkj9IKcUifF9YtxIfcOua3lJaHASjzM8FZBYnA0
 r1Eg==
X-Gm-Message-State: APuU4Z8jwtlUfXEFZ1Xj73cX/nEWhSe9RSn7ZE8AhwD7Fz3hZrDGlv2J
 kUzLuH5oRQ+WO5nUyEHF6OUPyg+T9D07aUmxqFImI5zNS1NQ/whcmQWlsfKbkrR5lgrPNeUp2O7
 RpAcwuGKuL2JQX+48OEUirBdFlkxtkFQ=
X-Gm-Gg: AYBFou0SA2ZAtOyQB++tz3d/+He7td7W+K+4IZqKTFpRPGvjnPsjvli4Gv+B5lCBWgc
 H64Hy4BnlewKXvP28gVNLSMxO8AjiIzDV838Y0UWsWn0el4oPuZMG4QKMqFW/Dn5Gn6mIDtLr0t
 L1dvHq27xJVVcjuszUtojDs6svWQ4y2YV8Qkol5fcPwIOiXVWvkLn32MtRWoFIMOKVL9fiXdFnT
 yuBVrpZdZDJF5s4SlUeVRjNKBuHA3MOYyf48QlcRQC2oEDDMNg6tAUdsbDcT6P2npr7PkeNwlI5
 qPNLBk2vMPx6Zts5VPSEz425thWvQu2RaosOAE0ZvgDuaqTCj6uitzP9QeEeSQ/I8doijyliKcc
 UmwUnX0anAWIM3VrkpGZ41paPbF+JEQ2T/kg0tQ==
X-Received: by 2002:a05:6102:f9f:b0:7cc:1192:5636 with SMTP id
 ada2fe7eead31-7d64d6c643dmr2388689137.12.1794673924886; Sat, 14 Nov 2026
 08:32:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261114162002.1995864-3-sun4qemu@gmail.com>
In-Reply-To: <20261114162002.1995864-3-sun4qemu@gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat, 14 Nov 2026 17:31:54 +0100
X-Gm-Features: AclHuK8INzV8P9abNYwiljmdMz0jPidOzdQNw4qJVqu03YNOjCbHcsHcZhGCfxg
Message-ID: <CAAM0arP89Yr1fU5r5KPxLqAGnUt6QAy3uta7Ztoj_jm5CBZaPg@mail.gmail.com>
Subject: Re: [PATCH] docs/system/target-sparc64: mention sun4v-qemu-kit
To: Dmitry Pimenov <sun4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@oss.qualcomm.com, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000c7d56a06603f15ca"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=a.tarasenko@gmail.com; helo=mail-vs1-xe2d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c7d56a06603f15ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 14 =D0=BD=D0=BE=D1=8F=D0=B1. 2026 =D0=B3., 17:21 Dmitry Pimen=
ov <sun4qemu@gmail.com>:

> This patch adds the reference to sun4v-qemu-kit; it builds the set
> of firmware (hypervisor, OpenBoot and binary set of machine descriptions)
> for the Niagara machine based on the OpenSPARC source code archive
> with some changes and build tests. The kit can be used instead of
> S10image/ firmware.
>
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
>

Great work, Dmitry! This is really important step towards making OpenBoot
really open.

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

---
>
> Artyom, Mark, please look at this project.
>
>  docs/system/target-sparc64.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/docs/system/target-sparc64.rst
> b/docs/system/target-sparc64.rst
> index 97e334b930..24d5883cf5 100644
> --- a/docs/system/target-sparc64.rst
> +++ b/docs/system/target-sparc64.rst
> @@ -20,6 +20,10 @@ and is able to boot the disk.s10hw2 Solaris image.
>                         -nographic -m 256 \
>                         -drive
> if=3Dpflash,readonly=3Don,file=3D/S10image/disk.s10hw2
>
> +Alternatively, sun4v-qemu-kit https://github.com/unix0cc/sun4v-qemu-kit
> contains
> +a set of components (hypervisor, OpenBoot and machine descriptions) for
> building
> +the Niagara firmware based on the OpenSPARC code.
> +
>  QEMU emulates the following peripherals:
>
>  -  UltraSparc IIi APB PCI Bridge
> --
> 2.43.0
>
>

--000000000000c7d56a06603f15ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D1=81=D0=B1, 14 =D0=BD=D0=BE=D1=8F=D0=B1. 2026 =D0=B3=
., 17:21 Dmitry Pimenov &lt;<a href=3D"mailto:sun4qemu@gmail.com">sun4qemu@=
gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This patch adds =
the reference to sun4v-qemu-kit; it builds the set<br>
of firmware (hypervisor, OpenBoot and binary set of machine descriptions)<b=
r>
for the Niagara machine based on the OpenSPARC source code archive<br>
with some changes and build tests. The kit can be used instead of<br>
S10image/ firmware.<br>
<br>
Signed-off-by: Dmitry Pimenov &lt;<a href=3D"mailto:sun4qemu@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">sun4qemu@gmail.com</a>&gt;<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Great work, Dmi=
try! This is really important step towards making OpenBoot really open.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Acked-by: Artyom Tarasenko =
&lt;<a href=3D"mailto:atar4qemu@gmail.com">atar4qemu@gmail.com</a>&gt;</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
---<br>
<br>
Artyom, Mark, please look at this project.<br>
<br>
=C2=A0docs/system/target-sparc64.rst | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.rs=
t<br>
index 97e334b930..24d5883cf5 100644<br>
--- a/docs/system/target-sparc64.rst<br>
+++ b/docs/system/target-sparc64.rst<br>
@@ -20,6 +20,10 @@ and is able to boot the disk.s10hw2 Solaris image.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -nographic -m 256 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 -drive if=3Dpflash,readonly=3Don,file=3D/S10image/disk.s10hw2<br=
>
<br>
+Alternatively, sun4v-qemu-kit <a href=3D"https://github.com/unix0cc/sun4v-=
qemu-kit" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.co=
m/unix0cc/sun4v-qemu-kit</a> contains<br>
+a set of components (hypervisor, OpenBoot and machine descriptions) for bu=
ilding<br>
+the Niagara firmware based on the OpenSPARC code.<br>
+<br>
=C2=A0QEMU emulates the following peripherals:<br>
<br>
=C2=A0-=C2=A0 UltraSparc IIi APB PCI Bridge<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div></div>

--000000000000c7d56a06603f15ca--


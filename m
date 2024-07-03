Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F0FC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwKN-00076Z-6C; Wed, 03 Jul 2024 05:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sOwKI-00071d-Kb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:30:59 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sOwKG-0001X7-5F
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:30:58 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-25d75d35ffdso152706fac.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719999050; x=1720603850;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFOMHh5M0Xsb8DBjQGrmeB6KeO2VJveqUhb7Sak+Apk=;
 b=xjWk26SXsKfnePIpndmySUJ7ffWwqqxXCl0gG8c5CMG2mh9XqvdUc40lIFcP+2j+iI
 PGdgQHlhEiEeDuY4HL2u8ZdoKdqtDZu8gqzcyVGSP4JTE7DJWALi96KW3ly029z29npt
 co5B9JchaDj4VtjlczvKTwIfwDDSvgWdoAnSITlE5PM3OUOzCUJkaM8/kuGMWwzQ1sSs
 fLRWJuIs2q2xGEg8O2476gSVnqmSaVlOm2X/v8W+Q2ywaw4GTKdNBfabYNhDQ+IA09iw
 7w+2TCZzrWtyAQIJaySF+YKMhYxt8FfQB9ugG9V0fsJOoT14BTXhiuMXZuWzLF6y4f06
 yUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999050; x=1720603850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFOMHh5M0Xsb8DBjQGrmeB6KeO2VJveqUhb7Sak+Apk=;
 b=HWTEmiBY639Ha1uxIAFr8ZjiijitijoIb9RCtRAPimKdH//ivaKKxwZLcGqbFwL2Bp
 pXglGfny8ChigNGAEOyzPn4+XFQgSUFyaqoCngzbP86Fe9fmaR5yGbZQjtWvPMO7Mv9I
 UJSI3vZSRgSMNp4Lb4xoUTgC6v9CGE8EQuzTTd31J3IcEpPQWUM/TV1uMyiAMlVg6joZ
 ZKZRXYDUZO2johQEplf08VZLFtyhB2+24t+ka5jUQFfyMzcHZbFEWShwMKht0FnIQ+eu
 EX/hxmQayyLAa106/KiLhcaKabt5r0izXwGYkmAp6+vzWfDp5VRCKe9wgklqz4Qo6C3z
 bObA==
X-Gm-Message-State: AOJu0YzrAF6BcozbL2Fg5cg4QYWyAXyTxWpdQHXRm3Hnv3BPXJHehzxt
 V5Y2R6smdpbu3wUekM62ggtUdWz+1uQrKDeDoSYWtgykcATVSa90EI8tNTrOQeBCFlXBbPRolMU
 Gj7BuZZ3kr9YBMt/muRFBI152rlUwhKluLNDFTw==
X-Google-Smtp-Source: AGHT+IHz3MwklUCvPR7TL85bXg34gAntSrn2Sb6dj034I58H6W06sVPUBRLD03i8LfqF1I0Flni5hfOkSAtoqfV+pDk=
X-Received: by 2002:a05:6871:544:b0:25d:7d7d:c96a with SMTP id
 586e51a60fabf-25e103ae1b0mr315804fac.16.1719999049391; Wed, 03 Jul 2024
 02:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240703090904.909720-1-thuth@redhat.com>
In-Reply-To: <20240703090904.909720-1-thuth@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 3 Jul 2024 17:30:33 +0800
Message-ID: <CAK9dgmavQqRAGisTE22LHES6cORwnJUyj8QAXym9LJcLuKHkFQ@mail.gmail.com>
Subject: Re: [PATCH] hw: Fix crash that happens when introspecting scsi-block
 on older machine types
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: multipart/alternative; boundary="0000000000005a7acc061c547cbf"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005a7acc061c547cbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:09=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:

> "make check SPEED=3Dslow" is currently failing the device-introspect-test=
 on
> older machine types since introspecting "scsi-block" is causing an abort:
>
>  $ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio
>  QEMU 9.0.50 monitor - type 'help' for more information
>  (qemu) device_add scsi-block,help
>  Unexpected error in object_property_find_err() at
>  ../../devel/qemu/qom/object.c:1357:
>  can't apply global scsi-disk-base.migrate-emulated-scsi-request=3Dfalse:
>  Property 'scsi-block.migrate-emulated-scsi-request' not found
>  Aborted (core dumped)
>
> The problem is that the compat code tries to change the
> "migrate-emulated-scsi-request" property for all devices that are
> derived from "scsi-block", but the property has only been added
> to "scsi-hd" and "scsi-cd" via the DEFINE_SCSI_DISK_PROPERTIES macro.
>
> Thus let's fix the problem by only changing the property on the devices
> that really have this property.
>

Thanks for the fix.


> Fixes: b4912afa5f ("scsi-disk: Fix crash for VM configured with USB CDROM
> after live migration")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 655d75c21f..60858a8565 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,8 @@
>
>  GlobalProperty hw_compat_9_0[] =3D {
>      {"arm-cpu", "backcompat-cntfrq", "true" },
> -    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
> +    {"scsi-hd", "migrate-emulated-scsi-request", "false" },
> +    {"scsi-cd", "migrate-emulated-scsi-request", "false" },
>      {"vfio-pci", "skip-vsc-check", "false" },
>  };
>  const size_t hw_compat_9_0_len =3D G_N_ELEMENTS(hw_compat_9_0);
> --
> 2.45.2
>
Acked-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--0000000000005a7acc061c547cbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 3, 202=
4 at 5:09=E2=80=AFPM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">th=
uth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">&quot;make check SP=
EED=3Dslow&quot; is currently failing the device-introspect-test on<br>
older machine types since introspecting &quot;scsi-block&quot; is causing a=
n abort:<br>
<br>
=C2=A0$ ./qemu-system-x86_64 -M pc-q35-8.0 -monitor stdio<br>
=C2=A0QEMU 9.0.50 monitor - type &#39;help&#39; for more information<br>
=C2=A0(qemu) device_add scsi-block,help<br>
=C2=A0Unexpected error in object_property_find_err() at<br>
=C2=A0../../devel/qemu/qom/object.c:1357:<br>
=C2=A0can&#39;t apply global scsi-disk-base.migrate-emulated-scsi-request=
=3Dfalse:<br>
=C2=A0Property &#39;scsi-block.migrate-emulated-scsi-request&#39; not found=
<br>
=C2=A0Aborted (core dumped)<br>
<br>
The problem is that the compat code tries to change the<br>
&quot;migrate-emulated-scsi-request&quot; property for all devices that are=
<br>
derived from &quot;scsi-block&quot;, but the property has only been added<b=
r>
to &quot;scsi-hd&quot; and &quot;scsi-cd&quot; via the DEFINE_SCSI_DISK_PRO=
PERTIES macro.<br>
<br>
Thus let&#39;s fix the problem by only changing the property on the devices=
<br>
that really have this property.<br></blockquote><div><span style=3D"font-fa=
mily:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div><span styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks for the fix.<=
/span>=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bor=
der-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Fixes: b4912afa5f (&quot;scsi-disk: Fix crash for VM configured with USB CD=
ROM after live migration&quot;)<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/core/machine.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/core/machine.c b/hw/core/machine.c<br>
index 655d75c21f..60858a8565 100644<br>
--- a/hw/core/machine.c<br>
+++ b/hw/core/machine.c<br>
@@ -36,7 +36,8 @@<br>
<br>
=C2=A0GlobalProperty hw_compat_9_0[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{&quot;arm-cpu&quot;, &quot;backcompat-cntfrq&quot;, &q=
uot;true&quot; },<br>
-=C2=A0 =C2=A0 {&quot;scsi-disk-base&quot;, &quot;migrate-emulated-scsi-req=
uest&quot;, &quot;false&quot; },<br>
+=C2=A0 =C2=A0 {&quot;scsi-hd&quot;, &quot;migrate-emulated-scsi-request&qu=
ot;, &quot;false&quot; },<br>
+=C2=A0 =C2=A0 {&quot;scsi-cd&quot;, &quot;migrate-emulated-scsi-request&qu=
ot;, &quot;false&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{&quot;vfio-pci&quot;, &quot;skip-vsc-check&quot;, &quo=
t;false&quot; },<br>
=C2=A0};<br>
=C2=A0const size_t hw_compat_9_0_len =3D G_N_ELEMENTS(hw_compat_9_0);<br>
-- <br>
2.45.2<br></blockquote></div><div><div style=3D"font-family:&quot;comic san=
s ms&quot;,sans-serif" class=3D"gmail_default"></div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Acked-by:=
=C2=A0Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@s=
martx.com</a>&gt;</div></div><div style=3D"font-family:&quot;comic sans ms&=
quot;,sans-serif" class=3D"gmail_default"><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000005a7acc061c547cbf--


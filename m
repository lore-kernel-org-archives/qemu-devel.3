Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB3BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3vd-0004mo-Gk; Thu, 23 May 2024 04:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1sA3vc-0004mf-Es
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:36:00 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <artyomkunakovsky@gmail.com>)
 id 1sA3vU-000553-4d
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:36:00 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-573061776e8so11206812a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716453349; x=1717058149; darn=nongnu.org;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VHIWCTMhrkzZYMfS53kB4rR35uUDiklAtVpU/Rn+ia4=;
 b=UuP+j/3jLgnuQG4K3ONmO1F35qr3f7UKIn+mNOxz3mx2nKPfDXQADEZOquGD8i6Kt+
 HMBqchK5cztrhS252JF7jRTKLzBPZQ4CDOAXwGIIlFUZYP+tTXp23QIwIutdS2vhHoZd
 Cspsdg5aUWF1tUHEj8EzD1niekPKzLspVqFrm2jSJ9dr6j3qA1GUFnDCK+dERr2h1u3S
 Q7z5WdwQP1961gCX4uaeN7ti1IaHrPLa7jA3CYY6hFng34yFThn0ieS/GwQyXe9u/349
 10Rg0P0ZJojmy+rkCFtr8dzw0DNUbtAJkVRcR1HIV4GqBQjqiXoolCtAXRV5+MdBfWhs
 KGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716453349; x=1717058149;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHIWCTMhrkzZYMfS53kB4rR35uUDiklAtVpU/Rn+ia4=;
 b=Ol+oaQfdw/5e4YjIFXKMdr8QQGu6yDZDUB4SuAZpA7ofhGf7JzBloIeGyItoAa2+GS
 0d2akQ+e0iNWKiCpn0iySPFk59VuxYgl7s4+Qk8gkby6zKb66aP7LMuQplDtHGAaQTAy
 gcpxohaxz1C+XaM2anyc7O1uyVarLny321K0F+ytXXyojNhRYpj5bw6tiOzm1m9qm+CB
 Am9fWvbeFOcgfyVxji6jRUo2AxVNZYyJ3BEkRk/9+YX5zKEFHVmFiFiWbSRYNmeCYcp8
 xmEGoCs2Jf4a0KUtWwIiKQ/w8vN+BUteVb7aVGK6L2yVokbnGMEGRV3Zn/WtGiBV9hiB
 y93A==
X-Gm-Message-State: AOJu0Yw5zRbNpExnjODFBQ/IWk+/3gKK8726Td7dcInqlviN+R603CnB
 2PU49ZsJOBn5cnPVsddfcAEK9KVB/Psh8cTeExjqzgseHnpdacSG
X-Google-Smtp-Source: AGHT+IHIeRwrlvZZXml+2jbfoZaIu5qGEym9K8S17IQ99gzoV3leepz7nU2fwi0RTMpWZt4xnOsPyg==
X-Received: by 2002:a17:906:1296:b0:a59:adf8:a6e1 with SMTP id
 a640c23a62f3a-a62281435a3mr234054766b.47.1716453348807; 
 Thu, 23 May 2024 01:35:48 -0700 (PDT)
Received: from AM7PR10MB3352.EURPRD10.PROD.OUTLOOK.COM
 ([2603:1026:c03:3801::5]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0150csm1904479666b.154.2024.05.23.01.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 01:35:48 -0700 (PDT)
From: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] meson.build: add -mcx16 flag
Thread-Topic: [PATCH] meson.build: add -mcx16 flag
Thread-Index: AXl1LTEyJAVp6aUozX2tTDRt1zMYojhfamE0wKyBWrI=
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 23 May 2024 08:35:47 +0000
Message-ID: <AM7PR10MB3352F89C17C05BAA91523253F9F42@AM7PR10MB3352.EURPRD10.PROD.OUTLOOK.COM>
References: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
 <Zk74F0a8ejAp_mP8@redhat.com>
In-Reply-To: <Zk74F0a8ejAp_mP8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: multipart/alternative;
 boundary="_000_AM7PR10MB3352F89C17C05BAA91523253F9F42AM7PR10MB3352EURP_"
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=artyomkunakovsky@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--_000_AM7PR10MB3352F89C17C05BAA91523253F9F42AM7PR10MB3352EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The compilation error caused by attempting of use 128 bit '__sync_val_compa=
re_and_swap_16', which is supported on the host but not enabled, I don't th=
ink this is expected behavior.

Also the patch is little incomplete, I already sent v2 patch, that applying=
 the flag only for x86_64 host.

With regards,
Artyom K.
________________________________
From: Daniel P. Berrang=E9 <berrange@redhat.com>
Sent: Thursday, May 23, 2024 11:02:31 AM
To: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Subject: Re: [PATCH] meson.build: add -mcx16 flag

On Wed, May 22, 2024 at 10:30:16PM +0300, Artyom Kunakovsky wrote:
> fix linker error if the project was configured by the './configure --cpu=
=3Dunknown --target-list=3Driscv64-softmmu' command

Isn't this simply user error, with the right answer being
to pass a valid CPU target to --cpu, rather than "unknown"

>
> Signed-off-by: Artyom Kunakovsky <artyomkunakovsky@gmail.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With regards,
Daniel
--
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


--_000_AM7PR10MB3352F89C17C05BAA91523253F9F42AM7PR10MB3352EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<div dir=3D"auto">The compilation error caused by attempting of use 128 bit=
 '__sync_val_compare_and_swap_16', which is supported on the host but not e=
nabled, I don't think this is expected behavior.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Also the patch is little incomplete, I already sent v2 pa=
tch, that applying the flag only for x86_64 host.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
<div dir=3D"auto">With regards,</div>
<div dir=3D"auto">Artyom K.</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Daniel P. Berrang=E9 =
&lt;berrange@redhat.com&gt;<br>
<b>Sent:</b> Thursday, May 23, 2024 11:02:31 AM<br>
<b>To:</b> Artyom Kunakovsky &lt;artyomkunakovsky@gmail.com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH] meson.build: add -mcx16 flag</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, May 22, 2024 at 10:30:16PM +0300, Artyom K=
unakovsky wrote:<br>
&gt; fix linker error if the project was configured by the './configure --c=
pu=3Dunknown --target-list=3Driscv64-softmmu' command<br>
<br>
Isn't this simply user error, with the right answer being<br>
to pass a valid CPU target to --cpu, rather than &quot;unknown&quot;<br>
<br>
&gt; <br>
&gt; Signed-off-by: Artyom Kunakovsky &lt;artyomkunakovsky@gmail.com&gt;<br=
>
&gt; ---<br>
&gt;&nbsp; meson.build | 2 +-<br>
&gt;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com">https://berrange.com</a>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; -o-&nbsp;&nbsp;&nbsp; <a href=3D"https://www.flickr.com/pho=
tos/dberrange">
https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org">https://libvirt.org</a>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://fstop138.berrange.com">
https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org">https://entangle-photo.org</a>&nb=
sp;&nbsp;&nbsp; -o-&nbsp;&nbsp;&nbsp; <a href=3D"https://www.instagram.com/=
dberrange">
https://www.instagram.com/dberrange</a> :|<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM7PR10MB3352F89C17C05BAA91523253F9F42AM7PR10MB3352EURP_--


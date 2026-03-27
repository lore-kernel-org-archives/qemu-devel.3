Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A445010F284C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69iK-0000Ij-E6; Fri, 27 Mar 2026 12:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w69i6-0000FX-Pl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:07:00 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w69i3-0007bO-LY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:06:57 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso345516166b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774627612; x=1775232412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLMcoG5zcsxWNeHBboZYA4E7ogTDf4I5wChz4+TLAaE=;
 b=za5dZoUPBLy2T+0+jho+2geQoMM1plibAWoKS+h3XFgR9EM6QkQtT2tEDxIzsVdxAq
 RIUtBDBqA0wCdBzi6ahnYq1LzLwve04LKFcTuW0NDV0eehUDLrHng7CRQIbkKaKWrlDR
 rpxFs14jebylih0c0THJJWWtJhFUmHnL4PQmW1oCep3M0waw/AhxVVYtwQJ+VGIQc1MP
 ae29iIlkYBztzeNKWCKsGa/Evs+5Sr0e0y10igY0S1JS6EC9dNISpcPnVbMbmw3qzUuR
 nC9WOK1slxgy4Qo0wsXGOgCa3xqEZRV+FPN/NwG+xASgGjg2llEZQpav+7tsVYwmZDtd
 yWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627612; x=1775232412;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QLMcoG5zcsxWNeHBboZYA4E7ogTDf4I5wChz4+TLAaE=;
 b=BDWq4pej2A7QX7GZNX1zMKNimHXBQ/UZwwgpJgmjpKDJdryjl5Bs/QkS4IO3p/OG66
 dlX1S7/28csTfLJqVuSRpuWvRpvsUW4jIE6WuM4VO7Nduvvr8czIiWLVHRNWMsUlfvOn
 hGI8w4AtvbwI6V9SM2uZBDRKenTCzM2/P0Cyau/FfXVAiFO/D4hpzq162VoJAV74DyRw
 zd+4btOvH8ideJ8vnZC6ijLoSKBNByKeVn1/qOjwCg9dCbTLyBhAo0QSmWfVFlnP7WWX
 yWWZno8BnQkm6EE4L010iADuafqZ9DF1C5Wv/tk//yrtGg4S9lG01Tag5PmK1ROgeUBZ
 EEwQ==
X-Gm-Message-State: AOJu0YwsqXi65n01WDtGsD8slm4zsaGw9z/FuzZUoy2VNyMQAX8oCgsF
 QNOn5K3q6Wuqe5HH8JX/jxZcF6kmvsdHi5F6TtaP3xUR+CNv1/dzc1ISFzxXcxsrdc4=
X-Gm-Gg: ATEYQzwD7pjBcrkrwREQJ6eyz4rU5HKcguS177yK8SZIsb8Rjq6nGaBYHiRN+I3gDhV
 S/F6cV9QvL6HN3KeyZ7O5FlqpwtnMtaE5v3u1Tv/RMmYAa9s0+ekcXZlw4DmugYTpHoxGpH3XIl
 tALKNuM3DqT655Yaiq5AwjNxxZAUSZ90YqGGVnbMogRXe9INUMFgLvKTOtSYE5T/AvZM1wwGJoh
 OD3e5w9cH2MXkuEeqNG6xvDN+w1Vq5WhBPR8nEnHBumbKfTxE/XTp7O2iW31CT/MD8ltIzd0o+d
 QFCecJfEmvRvE/G2c55O6G5LZW82ZQrPk9habs5ThBomsjfWyZlbBqkPGdzBKY0PNIMOOGliRyR
 OtQm0U/Xoag4ajZ+14U6n5OJbaBd0p/ctQ8jDwwolOPHPyxNGoG/tRFTyPwsCj7s/g/Ch0ULD6h
 OeSWZ9xPGSmjK/CQLoj7aGPLSG2MRYoPRiSQ==
X-Received: by 2002:a17:907:7b94:b0:b98:a49:a22e with SMTP id
 a640c23a62f3a-b9b505697ebmr204154766b.36.1774627612028; 
 Fri, 27 Mar 2026 09:06:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b203c2225sm263705366b.37.2026.03.27.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:06:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 838B75F888;
 Fri, 27 Mar 2026 16:06:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
In-Reply-To: <20260327143413.254227-1-minipli@grsecurity.net> (Mathias
 Krause's message of "Fri, 27 Mar 2026 15:34:13 +0100")
References: <20260327143413.254227-1-minipli@grsecurity.net>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Fri, 27 Mar 2026 16:06:49 +0000
Message-ID: <87v7eh1ckm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mathias Krause <minipli@grsecurity.net> writes:

> The control register bits haven't been updated in a few years, making
> them lack behind features QEMU ganied in these years.
>
> Update them to the current version of the SDM and sort the 32bit version
> to be in line with all the other definitions (descending order).

Do these changes come from the gdb upstream (which is where all the XML
originally comes from).

>
> This should remove confusion when debugging, for example, CET-enabled
> guests:
>
> - before the change:
>   (gdb) info registers cr4
>   cr4            0x8000f0            [ PGE MCE PAE PSE ]
>
> - after the change:
>   (gdb) info registers cr4
>   cr4            0x8000f0            [ CET PGE MCE PAE PSE ]
>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  gdbstub/gdb-xml/i386-32bit.xml | 47 +++++++++++++++++++---------------
>  gdbstub/gdb-xml/i386-64bit.xml |  7 +++++
>  2 files changed, 34 insertions(+), 20 deletions(-)
>
> diff --git a/gdbstub/gdb-xml/i386-32bit.xml b/gdbstub/gdb-xml/i386-32bit.=
xml
> index 7a66a02b67e3..1dec40e1d2c1 100644
> --- a/gdbstub/gdb-xml/i386-32bit.xml
> +++ b/gdbstub/gdb-xml/i386-32bit.xml
> @@ -87,27 +87,34 @@
>    </flags>
>=20=20
>    <flags id=3D"i386_cr4" size=3D"4">
> -	<field name=3D"VME" start=3D"0" end=3D"0"/>
> -	<field name=3D"PVI" start=3D"1" end=3D"1"/>
> -	<field name=3D"TSD" start=3D"2" end=3D"2"/>
> -	<field name=3D"DE" start=3D"3" end=3D"3"/>
> -	<field name=3D"PSE" start=3D"4" end=3D"4"/>
> -	<field name=3D"PAE" start=3D"5" end=3D"5"/>
> -	<field name=3D"MCE" start=3D"6" end=3D"6"/>
> -	<field name=3D"PGE" start=3D"7" end=3D"7"/>
> -	<field name=3D"PCE" start=3D"8" end=3D"8"/>
> -	<field name=3D"OSFXSR" start=3D"9" end=3D"9"/>
> -	<field name=3D"OSXMMEXCPT" start=3D"10" end=3D"10"/>
> -	<field name=3D"UMIP" start=3D"11" end=3D"11"/>
> -	<field name=3D"LA57" start=3D"12" end=3D"12"/>
> -	<field name=3D"VMXE" start=3D"13" end=3D"13"/>
> -	<field name=3D"SMXE" start=3D"14" end=3D"14"/>
> -	<field name=3D"FSGSBASE" start=3D"16" end=3D"16"/>
> -	<field name=3D"PCIDE" start=3D"17" end=3D"17"/>
> -	<field name=3D"OSXSAVE" start=3D"18" end=3D"18"/>
> -	<field name=3D"SMEP" start=3D"20" end=3D"20"/>
> +	<field name=3D"LAM_SUP" start=3D"28" end=3D"28"/>
> +	<field name=3D"LASS" start=3D"27" end=3D"27"/>
> +	<field name=3D"UINTR" start=3D"25" end=3D"25"/>
> +	<field name=3D"PKS" start=3D"24" end=3D"24"/>
> +	<field name=3D"CET" start=3D"23" end=3D"23"/>
> +	<field name=3D"PKE" start=3D"22" end=3D"22"/>
> +	<field name=3D"PKE" start=3D"22" end=3D"22"/>
>  	<field name=3D"SMAP" start=3D"21" end=3D"21"/>
> -	<field name=3D"PKE" start=3D"22" end=3D"22"/>
> +	<field name=3D"SMEP" start=3D"20" end=3D"20"/>
> +	<field name=3D"KL" start=3D"19" end=3D"19"/>
> +	<field name=3D"OSXSAVE" start=3D"18" end=3D"18"/>
> +	<field name=3D"PCIDE" start=3D"17" end=3D"17"/>
> +	<field name=3D"FSGSBASE" start=3D"16" end=3D"16"/>
> +	<field name=3D"SMXE" start=3D"14" end=3D"14"/>
> +	<field name=3D"VMXE" start=3D"13" end=3D"13"/>
> +	<field name=3D"LA57" start=3D"12" end=3D"12"/>
> +	<field name=3D"UMIP" start=3D"11" end=3D"11"/>
> +	<field name=3D"OSXMMEXCPT" start=3D"10" end=3D"10"/>
> +	<field name=3D"OSFXSR" start=3D"9" end=3D"9"/>
> +	<field name=3D"PCE" start=3D"8" end=3D"8"/>
> +	<field name=3D"PGE" start=3D"7" end=3D"7"/>
> +	<field name=3D"MCE" start=3D"6" end=3D"6"/>
> +	<field name=3D"PAE" start=3D"5" end=3D"5"/>
> +	<field name=3D"PSE" start=3D"4" end=3D"4"/>
> +	<field name=3D"DE" start=3D"3" end=3D"3"/>
> +	<field name=3D"TSD" start=3D"2" end=3D"2"/>
> +	<field name=3D"PVI" start=3D"1" end=3D"1"/>
> +	<field name=3D"VME" start=3D"0" end=3D"0"/>
>    </flags>
>=20=20
>    <flags id=3D"i386_efer" size=3D"4">
> diff --git a/gdbstub/gdb-xml/i386-64bit.xml b/gdbstub/gdb-xml/i386-64bit.=
xml
> index 6d889692114d..9ac9164e6a99 100644
> --- a/gdbstub/gdb-xml/i386-64bit.xml
> +++ b/gdbstub/gdb-xml/i386-64bit.xml
> @@ -102,9 +102,16 @@
>    </flags>
>=20=20
>    <flags id=3D"x64_cr4" size=3D"8">
> +	<field name=3D"FRED" start=3D"32" end=3D"32"/>
> +	<field name=3D"LAM_SUP" start=3D"28" end=3D"28"/>
> +	<field name=3D"LASS" start=3D"27" end=3D"27"/>
> +	<field name=3D"UINTR" start=3D"25" end=3D"25"/>
> +	<field name=3D"PKS" start=3D"24" end=3D"24"/>
> +	<field name=3D"CET" start=3D"23" end=3D"23"/>
>  	<field name=3D"PKE" start=3D"22" end=3D"22"/>
>  	<field name=3D"SMAP" start=3D"21" end=3D"21"/>
>  	<field name=3D"SMEP" start=3D"20" end=3D"20"/>
> +	<field name=3D"KL" start=3D"19" end=3D"19"/>
>  	<field name=3D"OSXSAVE" start=3D"18" end=3D"18"/>
>  	<field name=3D"PCIDE" start=3D"17" end=3D"17"/>
>  	<field name=3D"FSGSBASE" start=3D"16" end=3D"16"/>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DBEE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 10:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRUNg-0001J8-AF; Sat, 28 Dec 2024 05:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUNb-0001Ij-Sz
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:49:12 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tRUNY-0000Gz-TR
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 05:49:11 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4b24d969db1so1855975137.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735382947; x=1735987747;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm9qCr/yfQFF0NVtL+4X+rXc8O6gPDvf+JlC3PO4Who=;
 b=0q6ewKprw/19TUmASnpklwouDGoxDRpZ3sJflTtKTjFRE29WEtnSb6xG8omO9ddzU4
 MYlmjdptirpPeiJq1cnAK3pSBb0apODv/QBNMtAs2sY1+0eha8Z5v81gerwI7eLNKfnY
 iqQhl4HRJB3yEFGsLijAYV2ctVZkhxs+cP+iRGkNOfdYLO1HcDtaGk5Bvd2iL/qdy5G/
 flfPmYRTsClTNIh70Vy1TjMSL4TnoxpeORZ5wUWsk12uzUIk33vhd+eOIq7w7jnAVaZX
 uiv778pRSrbVKiZZDlyk/oYGid4Rvg6SvtwwB8Ehk0rIRalVNsRWKCMY1tVT4nIfH8X3
 kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735382947; x=1735987747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rm9qCr/yfQFF0NVtL+4X+rXc8O6gPDvf+JlC3PO4Who=;
 b=kP250YE45epU/fcpH4SgLA2jCovIghIdKsbth6NclovoZrbfcY6EB8LJTMHJE1C0X9
 /1m+AUpYg2XpElq583hqbwsddq1UqTfOzCljAEuJF/Z0qKQYZsbJqPzr5/A5Uy36mEBE
 eSfamvlP5C/G5ZZWnPiIui9Od7pP/jg/188sTmgtViMkSU7q/TotWs1GOagu+iFrrpva
 SoW0ERYhreRux3aR+vU3Zg8KGobmERTWvakUZjTsIFUUPT5zhtjvVz3QD4hItVBgTlC1
 1wlM/AiXL1yOTHVgrQPnLwssoAtFVN5/UNj/ShQJAhmZqWr68QVJ/PM9KuTWKpEKCWrX
 qLwQ==
X-Gm-Message-State: AOJu0YxMzBOOjlprJGes4+EFMgYtIQ1IDMaVTv9hIPE2s1613Tje/YSn
 CfoJo/i5iSk2KITCNF1SesNN5ZODd3rf+yexR7dp+J0B6KEHhbtrRImT8DSWdpLdjCkte+veKgn
 NZNmvvxq6/J6o7sle1luDxKNqY8gs/pB0iybl
X-Gm-Gg: ASbGncu7vvUk0GpsFKtG0mxNvdIfFnpNMuxvrbNGlcV1drhOwhcS4td/39WTXbfFDgP
 pe2jEiEcsp1jckThdwuidqwRfNZQyAtw16FuVtw==
X-Google-Smtp-Source: AGHT+IGXMQoBFXzjniSiyZ+tqhsORYq7wMfUpRUWPi3D1WsMacSyUTTdut4ue/i0oqT2D9HReUgbhJnL+xTFQxptBwQ=
X-Received: by 2002:a05:6102:1493:b0:4af:ea3b:7b41 with SMTP id
 ada2fe7eead31-4b2cc31c0dcmr22976086137.6.1735382946979; Sat, 28 Dec 2024
 02:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20241227202435.48055-1-philmd@linaro.org>
 <20241227202435.48055-3-philmd@linaro.org>
In-Reply-To: <20241227202435.48055-3-philmd@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sat, 28 Dec 2024 11:48:56 +0100
Message-ID: <CAAibmn0zhrZjZ+SL7n7eg041a5APx-o4sCAp0YGDiwUk8gpgDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: Have ARM_GIC select ARM_GICV3 when KVM is
 not available
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001ab989062a5254d4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e30;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe30.google.com
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

--0000000000001ab989062a5254d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Dec 2024 at 21:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> When the KVM accelerator is selected, the Kconfig ARM_GIC key
> selects the KVM GIC implementation (ARM_GIC_KVM).
> For other accelerators (TCG, HVF, ...), select the generic
> implementation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/intc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index 7547528f2c2..762139d8df3 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -23,7 +23,7 @@ config APIC
>
>  config ARM_GIC
>      bool
> -    select ARM_GICV3 if TCG
> +    select ARM_GICV3 if !KVM
>

Wouldn't this disable the ARM_GICV3 by default when building with
--enable-tcg --enable-kvm? And then there would be no GIC available when
running the built QEMU in TCG mode. (Bear with me, I'm a relative Meson
newbie.)


>      select ARM_GIC_KVM if KVM
>      select MSI_NONBROKEN
>
> --
> 2.47.1
>
>

--0000000000001ab989062a5254d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 27 Dec =
2024 at 21:24, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">When the KVM accelerator is selected, the Kconfig=
 ARM_GIC key<br>
selects the KVM GIC implementation (ARM_GIC_KVM).<br>
For other accelerators (TCG, HVF, ...), select the generic<br>
implementation.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0hw/intc/Kconfig | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig<br>
index 7547528f2c2..762139d8df3 100644<br>
--- a/hw/intc/Kconfig<br>
+++ b/hw/intc/Kconfig<br>
@@ -23,7 +23,7 @@ config APIC<br>
<br>
=C2=A0config ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
-=C2=A0 =C2=A0 select ARM_GICV3 if TCG<br>
+=C2=A0 =C2=A0 select ARM_GICV3 if !KVM<br></blockquote><div><br></div><div=
>Wouldn&#39;t this disable the ARM_GICV3 by default when building with --en=
able-tcg --enable-kvm? And then there would be no GIC available when runnin=
g the built QEMU in TCG mode.  (Bear with me, I&#39;m  a relative Meson new=
bie.)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
=C2=A0 =C2=A0 =C2=A0select ARM_GIC_KVM if KVM<br>
=C2=A0 =C2=A0 =C2=A0select MSI_NONBROKEN<br>
<br>
-- <br>
2.47.1<br>
<br>
</blockquote></div></div>

--0000000000001ab989062a5254d4--


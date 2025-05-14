Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1903C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEsZ-0006wD-Oc; Wed, 14 May 2025 12:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu_peterdavehello_org@proton.me>)
 id 1uFET6-0001dL-87
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:56:29 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu_peterdavehello_org@proton.me>)
 id 1uFET2-00054q-5o
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1747238172; x=1747497372;
 bh=oCAau1e3uaPksTSHn3KxklFDHrGHl9BVE9R1TFX69hw=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=AxbIWn8FQWP7jm2e08hno5ARovcYEmmMh8M3qmt1FBI4EgwdoTMmPPrYAtuzamAB+
 PA5YsoG+1t0d4jHNIzFhHp9NEIGWZi8Xnp292xhHDcWhkSIF+J6wWuUyhQueHaXXkR
 DrkF8Q6qImTJnBPHe3aDFmoBUG5OmDCgJT59QUBv5STxoA6tDwuSNns0F/em6+H9q5
 2nmB6X3IASv06x7VQKoRD9n5qMXNXYySmvnY32gZG8RfXiP8aLhnMEdf1fSatAEhM4
 OcbvuEstHkTG/TdNQHGgMkaHyyw2BjoPwW2SqXjWt/T+NDptSaWD345jTwaVxCsN+s
 SayIksH8h9E6Q==
Date: Wed, 14 May 2025 15:55:56 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] Add a simple zh_TW Traditional Chinese translation
Message-ID: <ZeYw6O1S8LUp2UeM5TB_HGXH9vOQPC9YdUDH1vZmKydQWqbZxamGOUawCkgJpF8k-BIwLnHuexXwLh1bpMYlNYsCWAiu02NSxRtGuH3z3HU=@proton.me>
In-Reply-To: <jqHNRyfNSXtm_GkuEg4PfIhc5r7bXTHczkQEsanTuQ3kCijpQp4j_5j-phKGiazGYpCYBgpNiW3Yqj1ENbWENF4f1GlzNKi9F5yM-M8VD7s=@proton.me>
References: <jqHNRyfNSXtm_GkuEg4PfIhc5r7bXTHczkQEsanTuQ3kCijpQp4j_5j-phKGiazGYpCYBgpNiW3Yqj1ENbWENF4f1GlzNKi9F5yM-M8VD7s=@proton.me>
Feedback-ID: 91804451:user:proton
X-Pm-Message-ID: c547e2ccf70c9c0737b7d206310e4fe321adb638
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.22;
 envelope-from=hsu_peterdavehello_org@proton.me; helo=mail-4322.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Peter Dave Hello <hsu_peterdavehello_org@proton.me>
From:  Peter Dave Hello via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hello,

Would anyone with permission help review this patch if it looks good enough=
 to be accepted? Thanks!

Peter

On Friday, January 17th, 2025 at AM 12:00, Peter Dave Hello <hsu_peterdaveh=
ello_org@proton.me> wrote:

>=20
>=20
> From 600ed9784dd5c2b209a3f5e1a5c97fc9cf4fa24e Mon Sep 17 00:00:00 2001
> From: Peter Dave Hello hsu@peterdavehello.org
>=20
> Date: Tue, 16 Apr 2024 00:43:29 +0800
> Subject: [PATCH v2] Add a simple zh_TW Traditional Chinese translation
>=20
> This patch adds a basic zh_TW translation file for Taiwan Traditional
> Chinese users.
>=20
> Signed-off-by: Peter Dave Hello hsu@peterdavehello.org
>=20
> ---
> po/LINGUAS | 1 +
> po/zh_TW.po | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 75 insertions(+)
> create mode 100644 po/zh_TW.po
>=20
> diff --git a/po/LINGUAS b/po/LINGUAS
> index 9b33a365..08163e8d 100644
> --- a/po/LINGUAS
> +++ b/po/LINGUAS
> @@ -7,3 +7,4 @@ sv
> tr
> uk
> zh_CN
> +zh_TW
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> new file mode 100644
> index 00000000..e6d2c07c
> --- /dev/null
> +++ b/po/zh_TW.po
> @@ -0,0 +1,74 @@
> +# Chinese translations for QEMU package.
> +# Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
> +# This file is distributed under the same license as the QEMU package.
> +# Peter Dave Hello hsu@peterdavehello.org, 2024.
>=20
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: QEMU 9.1\n"
> +"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> +"POT-Creation-Date: 2024-04-16 17:52+0800\n"
> +"PO-Revision-Date: 2024-04-16 17:52+0800\n"
> +"Last-Translator: Peter Dave Hello hsu@peterdavehello.org\n"
>=20
> +"Language-Team: Chinese (traditional)\n"
> +"Language: zh_TW\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=3DUTF-8\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +
> +msgid " - Press Ctrl+Alt+G to release grab"
> +msgstr " - =E6=8C=89=E4=B8=8B Ctrl+Alt+G =E4=BB=A5=E9=87=8B=E6=94=BE=
=E9=8E=96=E5=AE=9A"
> +
> +msgid " [Paused]"
> +msgstr " [=E5=B7=B2=E6=9A=AB=E5=81=9C]"
> +
> +msgid "_Pause"
> +msgstr "=E6=9A=AB=E5=81=9C(_P)"
> +
> +msgid "_Reset"
> +msgstr "=E9=87=8D=E8=A8=AD(_R)"
> +
> +msgid "Power _Down"
> +msgstr "=E9=97=9C=E6=A9=9F(_D)"
> +
> +msgid "_Quit"
> +msgstr "=E7=B5=90=E6=9D=9F(_Q)"
> +
> +msgid "_Fullscreen"
> +msgstr "=E5=85=A8=E8=9E=A2=E5=B9=95(_F)"
> +
> +msgid "_Copy"
> +msgstr "=E8=A4=87=E8=A3=BD(_C)"
> +
> +msgid "Zoom _In"
> +msgstr "=E6=94=BE=E5=A4=A7(_I)"
> +
> +msgid "Zoom _Out"
> +msgstr "=E7=B8=AE=E5=B0=8F(_O)"
> +
> +msgid "Best _Fit"
> +msgstr "=E6=9C=80=E4=BD=B3=E5=B0=BA=E5=AF=B8(_F)"
> +
> +msgid "Zoom To _Fit"
> +msgstr "=E8=AA=BF=E6=95=B4=E8=87=B3=E6=9C=80=E4=BD=B3=E5=A4=A7=E5=B0=
=8F(_F)"
> +
> +msgid "Grab On _Hover"
> +msgstr "=E6=BB=91=E9=81=8E=E6=99=82=E9=8E=96=E5=AE=9A(_H)"
> +
> +msgid "_Grab Input"
> +msgstr "=E9=8E=96=E5=AE=9A=E8=BC=B8=E5=85=A5(_G)"
> +
> +msgid "Show _Tabs"
> +msgstr "=E9=A1=AF=E7=A4=BA=E5=88=86=E9=A0=81(_T)"
> +
> +msgid "Detach Tab"
> +msgstr "=E5=88=86=E9=9B=A2=E5=88=86=E9=A0=81"
> +
> +msgid "Show Menubar"
> +msgstr "=E9=A1=AF=E7=A4=BA=E5=8A=9F=E8=83=BD=E8=A1=A8=E5=88=97(_M)"
> +
> +msgid "_Machine"
> +msgstr "=E6=A9=9F=E5=99=A8(_M)"
> +
> +msgid "_View"
> +msgstr "=E6=AA=A2=E8=A6=96(_V)"
> --
> 2.25.1


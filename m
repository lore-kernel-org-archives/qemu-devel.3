Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA9EE77172
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 03:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ2g6-0005pm-A1; Wed, 04 Dec 2024 22:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tJ2g3-0005p1-HV; Wed, 04 Dec 2024 22:37:19 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tJ2g1-00012K-FU; Wed, 04 Dec 2024 22:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1733369827;
 bh=HediFTr7Z+9MqQ8uMKyKuZUwMAhiOqlZgcbfm86n3Eg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=M9MqZvycSmpAl4Vs1Kv40dt342Asup7bWfU28WubIT2wRCOtt/2yrmN7S8pAx+t+c
 aEliOXRNlrKwhTUWu4Cnd/mga6sKJNj1mN9jCFrzTFx4ColwGxcgCCuI9OA9qAyaIz
 qjWibALW7t7VAzvqJwV5KIB1WeEuyPz4r51xLUWflLV3C/BONzFQIWvKmVUQTLJVj+
 cfloI2Z8SEcRkK7t7ESTI/WhLBXCxWLZhLVPELznc2weYuhlBaW1W07+PSTWhsNHiN
 LWM5bCgnl6PKDjocqlQrIKgO8/NDDgfbEGZSYjC62diOeMarW7XvSiqdNY9iruyyp3
 gPrRCb5yUiVMA==
Received: from [192.168.68.112]
 (ppp118-210-165-44.adl-adc-lon-bras34.tpg.internode.on.net [118.210.165.44])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0CD1A64A5E;
 Thu,  5 Dec 2024 11:37:03 +0800 (AWST)
Message-ID: <0121beea0cbf51268ce6c9e20e7c16660ec6b9fb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/4] docs/system/arm/fby35: document execute-in-place
 property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Troy Lee <leetroy@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, alex.bennee@linaro.org,
 Alistair Francis <alistair@alistair23.me>,  Jamin Lin
 <jamin_lin@aspeedtech.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 05 Dec 2024 14:07:03 +1030
In-Reply-To: <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
 <20241204203912.3037515-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2024-12-04 at 12:39 -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
> =C2=A0docs/system/arm/fby35.rst | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/docs/system/arm/fby35.rst b/docs/system/arm/fby35.rst
> index bf6da6baa2a..ed9faef363c 100644
> --- a/docs/system/arm/fby35.rst
> +++ b/docs/system/arm/fby35.rst
> @@ -45,3 +45,6 @@ process starts.
> =C2=A0=C2=A0=C2=A0=C2=A0 $ screen /dev/tty0 # In a separate TMUX pane, te=
rminal window,
> etc.
> =C2=A0=C2=A0=C2=A0=C2=A0 $ screen /dev/tty1
> =C2=A0=C2=A0=C2=A0=C2=A0 $ (qemu) c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Start the boot process once screen is
> setup.
> +
> +This machine model supports emulation of the boot from the CEO flash

Bit of a nit, but: s/CEO/CE0/ :)

Andrew


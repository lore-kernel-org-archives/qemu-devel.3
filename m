Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F611C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 23:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rotjO-0007YB-S2; Mon, 25 Mar 2024 19:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1rotjJ-0007XC-9H; Mon, 25 Mar 2024 19:27:49 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1rotjH-0000Cd-21; Mon, 25 Mar 2024 19:27:49 -0400
Received: from [192.168.68.112]
 (ppp118-210-177-226.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.177.226])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 07C4020154;
 Tue, 26 Mar 2024 07:27:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1711409254;
 bh=BcSNJsphdXKJA17EZSo1rc+zIEeoWzPM2m9NIw9j4xQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=BbQ492aMZDwxl7n9viBnsVhWy0RUBGIfT97kAcGBtKNLaxeDZy6qLxG+Ml2mHk/Fx
 wXEuENgE2qB1EK2Xxtjveleoh13Z6j/IIthMGkibJzOM059pOgfy7MePlX2L8VP3yM
 pFZXDH4PW/G0OstD70HIoHoAuXRKcNZc50JjQFgyoUkvt5gx2aC4yKJjmwX+ZKGqzU
 S9RniEOKqRrHNGqU5BDfMttydE0M+hz/JOvEdVBpxdBGeD9Y4WHRjPvg22oXacc9kp
 NH5UnNtn1M0VQEqtDKMdF+CI+hPfp6t8iTZhuS7Pnybs2WCyKMtOEvx1hJb5L1rd8Q
 38sm1Jbc+WGEw==
Message-ID: <0416990a901f2ca05db92033630a8dd7babe1eaf.camel@codeconstruct.com.au>
Subject: Re: [PATCH] misc/pca955*: Move models under hw/gpio
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>, Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 26 Mar 2024 09:57:31 +1030
In-Reply-To: <20240325134833.1484265-1-clg@redhat.com>
References: <20240325134833.1484265-1-clg@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Mon, 2024-03-25 at 14:48 +0100, C=C3=A9dric Le Goater wrote:
> The PCA9552 and PCA9554 devices are both I2C GPIO controllers and the
> PCA9552 also can drive LEDs. Do all the necessary adjustments to move
> the models under hw/gpio.
>=20
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>


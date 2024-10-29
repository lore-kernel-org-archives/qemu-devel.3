Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805C7D5B852
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 00:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5aKj-0004eb-5T; Mon, 28 Oct 2024 20:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5aKW-0004dY-O7; Mon, 28 Oct 2024 20:43:31 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1t5aKU-0002Vs-KH; Mon, 28 Oct 2024 20:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1730162595;
 bh=RfNJOEYfRA4SVGr5drt27pkJ4FQ56aEDZ3ObEOUh6dU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=j9qx7NQ8/B/OPj7qQkXR1qqZiNKF8wjBf3YmS6Wo6cG4EfasDeNT8IqyI4nZbOm9L
 Wt6oglHpmPs8J16tx4LSGb7cl2w5EdqAhQDkWnJ1NdEvprbxaXdwUvGdFWQjbonHOv
 +OHhP58eoyuD0xOGxzs94RtXSU+u0CoSvVdS1/HVXMusHlH4PINVDMaCfWDPAgBmhq
 k0F3stao4QtaBd6gBfKK/pc5DamUWgVAWixbVQPb+UiDDWXLr7fvscxnfILxkoFS7u
 JmFRz57p80r0tajqQz4No7TFxDg8fNKDxugbA3bQ5sFg5KUOo96xgVkgbQey2xXhof
 8RwIKaBB/w44w==
Received: from [192.168.68.112]
 (ppp118-210-190-243.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.190.243])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B34E167728;
 Tue, 29 Oct 2024 08:43:14 +0800 (AWST)
Message-ID: <df317f3f9f70340669f032377328765b81b3e493.camel@codeconstruct.com.au>
Subject: Re: [PATCH] hw/arm: enable at24c with aspeed
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Leis <venture@google.com>, clg@kaod.org,
 peter.maydell@linaro.org,  steven_lee@aspeedtech.com, Troy Lee
 <leetroy@gmail.com>,  jamin_lin@aspeedtech.com, joel@jms.id.au
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Tue, 29 Oct 2024 11:13:14 +1030
In-Reply-To: <20241028181420.1438938-1-venture@google.com>
References: <20241028181420.1438938-1-venture@google.com>
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

On Mon, 2024-10-28 at 18:14 +0000, Patrick Leis wrote:
> Enable AT24C with ASPEED in the KConfig because the boards build this
> device.
>=20
> Signed-off-by: Patrick Leis <venture@google.com>

I was wondering how we haven't hit problems before now. Poking around
with scripts/minikconf.py for an arm-softmmu build we get:

   # config AT24C depends on I2C
   # select AT24C if NPCM7XX
   # =3D> AT24C is now True
   # config AT24C default y if E500
   # config AT24C default n

Seems reasonable that the Aspeed models should select it themselves
given they depend on the symbols.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


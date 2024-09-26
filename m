Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB930CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stfo3-0004vr-Pe; Thu, 26 Sep 2024 00:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stfo1-0004td-Pi; Thu, 26 Sep 2024 00:08:41 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stfo0-00064W-5a; Thu, 26 Sep 2024 00:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1727323716;
 bh=4larEuQBnKILreSGwdxv39R5jPlTKpDxcXWcdC710xE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=MpI5FUomsR3ngfpSCnqdub35qbd5kSY6FCzXBKChAT1pDxc50vInLSgEJ9jzi+WYb
 wZtINWdGmTVXROnQXFdS5nE6m5rb9Pz6IPtM2O4GiP4y22Dlh4d0p8pGxIf9xA8ARb
 KoxnFuhk8wOXWot7hXJc4/7xudNQd/oTVGf1qgbVh+XsBouyAvIhiD1BJZ24U0PSAV
 Qs4o/fToLN0v3wGMebqG//aS7T72DPaIVIoavzmFvf6KpwJnRF6GJyNKGt5oUEUv4m
 XrWvRxVHlglQ4U0kyR9s7ABjoJEr8qfWtXu3+j8wKa8xjUam8WUXcBwEKOBMupUlSh
 Kjw089LAJv0Vw==
Received: from [192.168.68.112]
 (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 034FB6508E;
 Thu, 26 Sep 2024 12:08:35 +0800 (AWST)
Message-ID: <7ee6367997fa5f56d14f653b2ac90863f52f1b2f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 5/6] hw/gpio/aspeed: Add AST2700 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 26 Sep 2024 13:38:34 +0930
In-Reply-To: <20240925033454.4117445-6-jamin_lin@aspeedtech.com>
References: <20240925033454.4117445-1-jamin_lin@aspeedtech.com>
 <20240925033454.4117445-6-jamin_lin@aspeedtech.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2024-09-25 at 11:34 +0800, Jamin Lin wrote:
>=20
> +    /* interrupt status */
> +    if (SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_STATUS)) {
> +        pending =3D extract32(set->int_status, pin_idx, 1);
> +        if (pending) {
> +            if (s->pending) {
> +                assert(s->pending >=3D pending);
> +                s->pending -=3D pending;
> +            }
> +            set->int_status =3D deposit32(set->int_status, pin_idx, 1, 0=
);
> +        }
> +    }

I think you can apply the same reasoning here as on the previous patch.

Andrew


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3937C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 04:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdMCv-0007ij-6c; Wed, 29 Jan 2025 23:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdMCq-0007i1-Qf; Wed, 29 Jan 2025 23:31:08 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tdMCn-00070x-IE; Wed, 29 Jan 2025 23:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1738211460;
 bh=3vI+VlhZYbMJPmUFLHeG56Kv1kAthBUlu02w6Dw8Tz8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=QCO2sCjUMaZAgUv5YeyjcVOHYuOWqRsqA7SH6IEOxqGEuGv7kycWyFgfxS7gcWnzh
 HlxVY2Zhf2MI7/ekht+yFKu6rl+5NNadxlLFL/68dZtfR7PntA7+6vJ9lVANUtuP/W
 9r96zFnkyo3jXuqtargsWq8BsKXD5E9q1uxwgEQXLZvYMOLdlHsmODVryzAcPLQuUN
 cYzRdkv+z6nvpJ9HkVhrFWeW8EJnurD4kRySeQjh0ST6QkG9uW+NFay1KZqQSGDq1T
 LqW8zMsCbou9+vnixO8mh2irtP+dm3iOMQgXBVG3Yg5sZht5It6uZl9f24MvpXlGdc
 zOGIj3xBVv/mw==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 342BB7383B;
 Thu, 30 Jan 2025 12:30:59 +0800 (AWST)
Message-ID: <d9fc0a6b9db0c9d7b80c3a15138941d868a53a6b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 16/18] hw/misc/aspeed_hace: Add AST2700 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 30 Jan 2025 15:00:58 +1030
In-Reply-To: <20250121070424.2465942-17-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-17-jamin_lin@aspeedtech.com>
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

On Tue, 2025-01-21 at 15:04 +0800, Jamin Lin wrote:
> Introduce a new ast2700 class to support AST2700.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


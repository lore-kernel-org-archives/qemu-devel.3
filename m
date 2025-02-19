Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5C3C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 01:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkZ0h-0000pk-DK; Tue, 18 Feb 2025 20:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tkZ0e-0000pL-06; Tue, 18 Feb 2025 20:36:20 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tkZ0Z-0000l1-S0; Tue, 18 Feb 2025 20:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1739928963;
 bh=F63M/1e+eywrzPbVcgGK45bzslpIH0ylXeM+M4jaei0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=O7CvckeRmEnzBPIT9eExLgwyKXhayFMaj1H43otklqoMD1gmkaUCQkmJWKfsWX/od
 fAOD+F3lFW9KiMZCg0uFsUYBZ9pcfTYLpm3h2KHEZHph0ceOdH1SNGUyKKWVraQ6oN
 /lZK1srivKTtUtO9wPBN+wSgy87mZPpXTc2+31Ic3+CpiDBxGAeXmVUvTr46zSDY47
 VVPcAowv43u9K0LkvK4FgWyfo+rMfuK5BwJckLovoMWGNR0frYWu7rJkp/TRN3ajYh
 RQrN1KwWFV7+crLmBAdPdecysH3rqwaSoHl/Ou+FlvQbHVi6vXGgWUD94Jn91A5Iyz
 q//fc+J1hPkzQ==
Received: from [192.168.68.112] (203-173-1-6.dyn.iinet.net.au [203.173.1.6])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C96276191;
 Wed, 19 Feb 2025 09:36:02 +0800 (AWST)
Message-ID: <090dbd8f11acbd3c166c62e3b0b7acdd1d6cb347.camel@codeconstruct.com.au>
Subject: Re: [PATCH] aspeed: Remove duplicate typename in AspeedSoCClass
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Date: Wed, 19 Feb 2025 12:06:01 +1030
In-Reply-To: <20250218073534.585066-1-clg@redhat.com>
References: <20250218073534.585066-1-clg@redhat.com>
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

On Tue, 2025-02-18 at 08:35 +0100, C=C3=A9dric Le Goater wrote:
> The SoC type name is stored under AspeedSoCClass which is
> redundant. Use object_get_typename() instead where needed.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63800D3B7C9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 23:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFMIG-0005eL-Da; Sun, 24 Nov 2024 18:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tFMID-0005dZ-Hs; Sun, 24 Nov 2024 18:45:29 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1tFMIA-0006yu-Mm; Sun, 24 Nov 2024 18:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1732491915;
 bh=5kZ3hJbdSRjGP3VHseVn/bxOyT1jcblJ89CvRF4QySc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=K7SCEmZi9DjWWsHriWlpOkv4lhwYI2WjxWw02ZsxkEEz+0cykfV0BlBajRWWC8gup
 +Lav9L4D8OOjZgpKpePHdrIIURj6L7Pn/QyHxVHHuDFPVPJZ+o6D+4c8QJaM8ImJOQ
 MPQOW1jlQepblT1NPLB5Xg+2atREJ6/Us77p91eh0SN7JOVFCd2vJehVWe+wCEp50Z
 aYRcK/292+o47roc6OvHCNM2yX3vIoKPSTzAt8DNk2HiTJr6G6ei8Sj/KKMjTAA/o3
 baQqXY5EguM7UqzwmN8cETBK31+WYdR/2Q/OnsnBqTyniEpdRIpFBb4LcNA00BFPeo
 N1EnPCBC0abBg==
Received: from [192.168.68.112] (203-173-6-52.dyn.iinet.net.au [203.173.6.52])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0EA8E6BDDC;
 Mon, 25 Nov 2024 07:45:11 +0800 (AWST)
Message-ID: <45171109dbf17fc742176a824d63c00e07235b9e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 12/12] docs/system/arm/aspeed: add missing model
 supermicrox11spi-bmc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org, Steven Lee
 <steven_lee@aspeedtech.com>, Richard Henderson
 <richard.henderson@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org,  =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,  Peter
 Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>
Date: Mon, 25 Nov 2024 10:15:11 +1030
In-Reply-To: <20241122225049.1617774-13-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-13-pierrick.bouvier@linaro.org>
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

On Fri, 2024-11-22 at 14:50 -0800, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


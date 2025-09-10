Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB53FCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 03:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwBsW-0007Dl-J3; Tue, 09 Sep 2025 23:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uwBsU-0007Cw-B8; Tue, 09 Sep 2025 23:52:14 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uwBsP-00009F-ME; Tue, 09 Sep 2025 23:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1757476316;
 bh=yWDWey0kX2C4+EepxuMZtAhFxFEV8ugfLIryF33TJsI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=IW7dWLrvlmjwUB9tnJpOn3qwT7a7UuAO8LDCi3Mc/7LB9lxex810cxY94sFdp4qqo
 CtYu+4nIjnvnahEKv2ZX9tw19sbRxjUaeo7R7uy5tPBk2TthkF2b+n5UfUzHwfdWmF
 CuHDMa9iHlxE+BeIxzTWuYjpnU758c8rAOKhlP9m+qFBjKEOE5i2je1V/QdQHjAV79
 0i/lWGewYKbC1zZwVDrIgYJ1R6pmjrcOYYphc7kwuUIgzQQZfdcEzAa6uxOqb93AbI
 S8kAPlqacKsUKOwflFukasF59Ep028neFlUVJEqie4oi717uffSfBd6yh4GVPLXF7Q
 nTU+5Iz36L8pQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 840316472E;
 Wed, 10 Sep 2025 11:51:55 +0800 (AWST)
Message-ID: <e0e733ff458cf253ddaf2b5570183b86c7c13102.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Coco Li <lixiaoyan@google.com>, peter.maydell@linaro.org, clg@kaod.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Date: Wed, 10 Sep 2025 13:21:53 +0930
In-Reply-To: <20250903213809.3779860-2-lixiaoyan@google.com>
References: <20250903213809.3779860-1-lixiaoyan@google.com>
 <20250903213809.3779860-2-lixiaoyan@google.com>
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

On Wed, 2025-09-03 at 21:38 +0000, Coco Li wrote:
> From: Felix Wu <flwu@google.com>
>=20
> Added 32 bits property for ASPEED GPIO. Previously it can only be access =
in bitwise manner.
>=20
> This change gives ASPEED similar behavior as Nuvoton.

Can you point me to the Nuvoton functionality? I had a quick look and
couldn't immediately see an equivalent implementation.

Regardless, I'd like to see more motivation in the commit message than
"make it behave like Nuvoton". Can you provide a concrete use-case as
an example?

Andrew


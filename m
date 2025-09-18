Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB0CCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 00:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz2zg-00076i-BN; Wed, 17 Sep 2025 20:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uz2ze-00076P-Kg; Wed, 17 Sep 2025 20:59:26 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1uz2zb-0002N9-Ub; Wed, 17 Sep 2025 20:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1758157152;
 bh=sTkx+x0j0baz4PLHANBk0eX4iCYqGr2oBPhzlsP+DSA=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=WXRRrVhe90w5QdJXrIASOgeCq2ULOic7skhuM115CoOM21G8UqezY6CPUQ5JXXlQM
 QrdDHXg0JSEf6Lfa60wbyizanYFVZSj53gyvkDgb5yavdNnA7nZOXKboQaPg4SKDJD
 sH1eZg2E1RkzZInUKmefjyBAfn/pnCtD4tWoGIUBf05L7EoXEoCwTpXNGeFxs8lPMY
 FkFuFIPlQZ9MmaMx0/97xtQ6ZfHQu5tExCT6SGkZ00OfBWq+Z/1nH6yR7Ifw93rwks
 BW/TUGkboS737bPu/6YGxwU9t3rwHcCzx9yFfvdXSJW+Y+qSSZ7rgmkZvxmaz6v5Dc
 bon3DG1DDkhTg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E88A36445D;
 Thu, 18 Sep 2025 08:59:11 +0800 (AWST)
Message-ID: <e244fdb5d2d889674a583df8f8b9bc4bf8d476f4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Coco Li <lixiaoyan@google.com>
Cc: peter.maydell@linaro.org, clg@kaod.org, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Date: Thu, 18 Sep 2025 10:29:11 +0930
In-Reply-To: <CADjXwjjjSQGwOfquXmLfENRAAmHv5KXaGvjkiK7KFzGuehPsow@mail.gmail.com>
References: <20250903213809.3779860-1-lixiaoyan@google.com>
 <20250903213809.3779860-2-lixiaoyan@google.com>
 <e0e733ff458cf253ddaf2b5570183b86c7c13102.camel@codeconstruct.com.au>
 <CADjXwjjjSQGwOfquXmLfENRAAmHv5KXaGvjkiK7KFzGuehPsow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Coco,

On Fri, 2025-09-12 at 10:43 -0700, Coco Li wrote:
> Hello Andrew,
>=20
> I discussed with the original author of the patch and the Nuvoton
> functionality mentioned above has not been upstreamed since then,
> unfortunately.

Okay, so can you please update the commit message to reflect this?

> Aside from the comment above, we believe this patch series allows gpios t=
o
> be accessed more dynamically/flexibly in complicated simulation, and also
> helps with accessing advanced gpio features, see the sgpio implementation
> later in this patch series.

Can you please add a discussion of these complex simulations to the
commit message? I'd like a description of what you're doing where the
current pin-specific interface is insufficient. Motivations help a lot
with the patch review.

Thanks,

Andrew


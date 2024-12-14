Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B4E77183
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 08:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMNRS-0006B5-Vi; Sat, 14 Dec 2024 03:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tMNRN-0006Af-1s
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 03:23:57 -0500
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1tMNRH-00056A-Iw
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 03:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oZTWn4pHjaxWnkmtqimNrIg5XXEBCIgSQlWlAJ6gdgY=; b=FtEw1P4Elb2l5Jhqau3ZVXkXwT
 WIdjInVRb5OrJEDNK6iWtmg4LMmNRFQbhZy9uu1DzgZHVkVJyOHqroUxX2Zb2AHHGAZMuo/wZxQUp
 3mU4iIw15lzl7DInRrELhvfZ0TPdU6x0KDUO8Frofyyjss5RJqvurcxSuxZSMlv4ne0Y=;
Date: Sat, 14 Dec 2024 09:23:39 +0100
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 62/71] hw/tricore: Constify all Property
Message-ID: <eweotjqvsz4jd4iur4gc3jwrgbqgbwj4k3ryvgfqn53zkw2muu@jjtyzc7flvyv>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-67-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213190750.2513964-67-richard.henderson@linaro.org>
X-IMT-Source: Intern
X-IMT-rspamd-score: -25
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), BAYES_HAM(-2.99), TO_MATCH_ENVRCPT_ALL(0.00),
 MID_RHS_NOT_FQDN(0.50), MIME_GOOD(-0.10), NEURAL_HAM(0.00),
 RCPT_COUNT_TWO(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00),
 RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), TO_DN_SOME(0.00), MISSING_XM_UA(0.00),
 Message-ID: eweotjqvsz4jd4iur4gc3jwrgbqgbwj4k3ryvgfqn53zkw2muu@jjtyzc7flvyv
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 13, 2024 at 01:07:36PM -0600, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/tricore/tc27x_soc.c          | 2 +-
>  hw/tricore/tricore_testdevice.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian


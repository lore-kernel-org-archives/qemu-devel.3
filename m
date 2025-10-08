Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839FACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RpA-00077x-H3; Wed, 08 Oct 2025 06:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6Rp8-00077j-J1
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:55:10 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6Rp7-0000Y2-8T
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=8CASA0rQ12FT7Bp2+CjcHbw6861AIVJ28xIToxFXD8c=; b=ub1nbwfyAcmsMJw
 B6w+KxXprgdjlBo5M1pR9N5jzp6XzUhtReCLWYZ6u4k8SIUlTXbab0VrX1EQkmLgGdanvdHWiMuw4
 hW/QcG3ooKFfX7bsLojEOkcyrnxQ+wqNoUFDXRQn/JktY4BflKlIujWmM49aVlEeiphOkR+QoqWGQ
 W8=;
Date: Wed, 8 Oct 2025 12:57:49 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: Re: [PATCH 4/6] target/sh4: Remove target_ulong uses in
 superh_cpu_get_phys_page_debug
Message-ID: <p2qtovxgunrzmymihxd7sajrwjpnrmffhnb5oyvro43npyhkhf@4h4p767r3yjv>
References: <20251008064814.90520-1-philmd@linaro.org>
 <20251008064814.90520-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008064814.90520-5-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/10/25, Philippe Mathieu-Daudé wrote:
> The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
> type since commit 00b941e581b ("cpu: Turn cpu_get_phys_page_debug()
> into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/sh4/helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Anton Johansson <anjo@rev.ng>


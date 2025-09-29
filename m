Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3436CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AJT-0002UD-CA; Mon, 29 Sep 2025 05:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3AJR-0002Tz-9L
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:36:53 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3AJG-0005D0-Bm
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FxyUNwzEjhFCjy/WHl0ngwC7Tn/NPrKeGE7HgM945N8=; b=ZtcR2QPV/boV3Xz
 +5HngwjPUQ8ih0f63TK3gvBdCYFbxbg7LSdayLOp5cMBZJh9sCQno50z1yf4FlZXfj46c5RSr1ZWE
 LdE8U8yR5RT9CEeNUCw8DywJQt8KsAQ8FO2BWPk3XuYCbS6htPzc7dzpjx8siz+5o8GQVmUhWUjsY
 7w=;
Date: Mon, 29 Sep 2025 11:39:01 +0200
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 03/34] target/riscv: Fix size of mcause
Message-ID: <js46hjbkexanadfdo3kuhoc2wacyt2skwbbhlxmed5qpjmhq4p@jlwyfjdg4rwp>
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-4-anjo@rev.ng>
 <d78f6956-0800-4a7f-9cc0-7c2d9935dc3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d78f6956-0800-4a7f-9cc0-7c2d9935dc3e@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/09/25, Richard Henderson wrote:
> On 9/24/25 00:20, Anton Johansson via wrote:
> > and update formatting in logs.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h     | 2 +-
> >   target/riscv/machine.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> There is no updating of logs.  Incorrectly split patch?
> Cut and paste error on the commit message?
> 
> r~

Agh yes you're right, I was going to squash this patch into the trivial
changes.  A previous verision of this patchset touched larger parts of
target/.

//Anton


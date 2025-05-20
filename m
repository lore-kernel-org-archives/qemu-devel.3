Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35382C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNv8-00083E-Vs; Tue, 20 May 2025 10:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uHNv3-0007lc-5I
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:26:13 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1uHNux-000315-I5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adNegI1bS0vvh8dGjqkdxae9rqawuKQZ9ZNV3X8eh7o=; b=sWkvP4Z3JV2zLroA6/+gzqa7Yk
 k/cZjy5rDNk9nPxVf24qmiGBnhsHstIBDIBgt9pDgKOKooiSSTpHeuOcYc2YF1togGwKwLDlFyP2A
 DORNtly1nXKZg05mGn/QKtUx5aDc0mmEJnz1N/XB5/kNdoAZtTYladbPfBsQ83DpHzGk=;
Date: Tue, 20 May 2025 16:25:58 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 21/25] target/tricore: call plugin trap callbacks
Message-ID: <kt4lgx6upplbsasq5zkwedfgzj25qysnygq3cibowuhzhwzzjw@mcqkdwbzumlp>
References: <cover.1747666625.git.neither@nut.email>
 <8bd3931ba67e8beb420cb198e2eb16b7b1270084.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd3931ba67e8beb420cb198e2eb16b7b1270084.1747666625.git.neither@nut.email>
X-IMT-Source: Extern
X-IMT-rspamd-score: -10
X-UPB-Report: Action: no action, RCVD_TLS_ALL(0.00), FROM_HAS_DN(0.00),
 FROM_EQ_ENVFROM(0.00), BAYES_HAM(-1.47), TO_MATCH_ENVRCPT_ALL(0.00),
 MID_RHS_NOT_FQDN(0.50), MIME_GOOD(-0.10), NEURAL_HAM(0.00),
 RCPT_COUNT_TWO(0.00), RCVD_VIA_SMTP_AUTH(0.00), ARC_NA(0.00), ASN(0.00),
 RCVD_COUNT_ONE(0.00), MIME_TRACE(0.00), TO_DN_SOME(0.00), MISSING_XM_UA(0.00),
 Message-ID: kt4lgx6upplbsasq5zkwedfgzj25qysnygq3cibowuhzhwzzjw@mcqkdwbzumlp
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On Mon, May 19, 2025 at 05:20:01PM +0200, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places an exception hook for TriCore targets. Interrupts are
> not implemented for this target and it has no host calls.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  target/tricore/op_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian


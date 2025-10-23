Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D89CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwvs-0007hH-HJ; Thu, 23 Oct 2025 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+253124156df135ae580b+8096+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vBwvn-0007gL-Pp
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:08:47 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:3::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+253124156df135ae580b+8096+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vBwvi-0007Ai-BP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=vUd9iejmQ3YIoCZIrpCmvS9LgqpBQbgMRVezSirRowk=; b=avSsCJpghnTcVUnnYsy1KPz7Bm
 VaZgVYc8z5ZU2TlVYuBcoicMDzu9qYYyJ1KfbbjeantAq42rZAidTQgctxDU4mpAro4+7lxelHELv
 VIgMiVehJvaADt6ZMF/Zk8uyw6sc0AKJ2P/JMlp/QLDgUDWVGrXFklP5TMjb+lrFrMJkPrYvAeNug
 dtIse1769tluZFc6HCS/t/KzBV1vxwpuvNtUP4IW4LFjtZtK0bY6qigApTtCMaQ8vjc2eyY9q57Je
 hUn9HIha4lueegkCHrvS5vSWqj9xhMwfcSeWAxVDlgC/lJBxOXkcslMPltiwmlGY+0lAvuGHOS59+
 GpYzmPeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vBwvZ-00000006hj5-2ZSu;
 Thu, 23 Oct 2025 15:08:33 +0000
Date: Thu, 23 Oct 2025 08:08:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: coconut-svsm@lists.linux.dev, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas.Lendacky@amd.com,
 huibo.wang@amd.com, pankaj.gupta@amd.com
Subject: Re: KVM Planes with SVSM on Linux v6.17
Message-ID: <aPpE8emZ9n4N7S-T@infradead.org>
References: <wmymrx6xyc55p6dpa7yhfbxgcslqgucdjmyr7ep3mfesx4ssgq@qz5kskcrnnsg>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wmymrx6xyc55p6dpa7yhfbxgcslqgucdjmyr7ep3mfesx4ssgq@qz5kskcrnnsg>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2607:7c80:54:3::133;
 envelope-from=BATV+253124156df135ae580b+8096+infradead.org+hch@bombadil.srs.infradead.org;
 helo=bombadil.infradead.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 10:35:28AM +0200, Jörg Rödel wrote:
> Hi all,
> 
> This morning I pushed out my current Linux and QEMU branches which support
> running COCONUT-SVSM on AMD SEV-SNP based on kernel v6.17 and the original KVM
> Planes patch-set from Paolo.

Can you explain what this alphabet-soup even means?


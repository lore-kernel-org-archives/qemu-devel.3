Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D80CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwpF6-0003iI-7U; Thu, 11 Sep 2025 17:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asmadeus@codewreck.org>)
 id 1uwpF2-0003i2-4H
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:54:08 -0400
Received: from submarine.notk.org ([62.210.214.84])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <asmadeus@codewreck.org>) id 1uwpF0-0004Qw-0D
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:54:07 -0400
Received: from gaia.codewreck.org (localhost [127.0.0.1])
 by submarine.notk.org (Postfix) with ESMTPS id 1EF1414C2D3;
 Thu, 11 Sep 2025 23:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
 s=2; t=1757627641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KvwC/G6e6nZWTm0KLgAtnQSg+Q/QtezHjy8X0JGwnG8=;
 b=LLA0uYz4Lb1BkkKf6+0Q0AX/CtMTIT5gG6pVPjSwoRdM1cqU4UtWWOQ+D5dlDg7DQFHbvs
 lJBRzzov3O5rlShSlcIR15o1yy/2JWD4GNxKaDM+Xm/bWD7FOkRmE/ZxY1TA9bAthKf6jJ
 5AlegH1UPw9Q5EljvBfHja07Wbz8Fh+Azo6H86iNpc9eUqZRZNQ/gMkyzS3s4GLKPmgTk5
 z32/M9fCBSLqxEbPO4jIA/pO3KiIbvZbym8pZm2/HYATAamxotXEPtAzG5n5IoQWaAvGaZ
 0lk9s9pM7uUPght5lQDirt7r+IAHiHg39r0VtMGqUb0BRfcq/R5Oex9z95PcOg==
Received: from localhost (gaia.codewreck.org [local])
 by gaia.codewreck.org (OpenSMTPD) with ESMTPA id ae0fabb3;
 Thu, 11 Sep 2025 21:53:57 +0000 (UTC)
Date: Fri, 12 Sep 2025 06:53:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org,
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org,
 mst@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
Message-ID: <aMNE5rOJaORVmk3M@codewreck.org>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
 <aMAwL8q0i6pqcAOn@codewreck.org>
 <7eadc2c7030c79923303a5b1b3f2bce0f27ded44.camel@gmail.com>
 <a5918eaa2d28d08ff3133dccb06c1966064e5579.camel@gmail.com>
 <e30c59563cce0fc8e4935c5b6aba6f85cf8a8288.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e30c59563cce0fc8e4935c5b6aba6f85cf8a8288.camel@gmail.com>
Received-SPF: pass client-ip=62.210.214.84;
 envelope-from=asmadeus@codewreck.org; helo=submarine.notk.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek wrote on Thu, Sep 11, 2025 at 11:19:15PM +0200:
> > Done. You can find an updated version of the patches at
> > <https://gitlab.com/filip-hejsek/qemu/-/commits/console-resize>.
> > I haven't tested the updated version though. I will maybe do some
> > testing and then submit it to the mailing list for review, although if
> > anyone else would like to take over then feel free to do so.
> 
> I have done some tests and it seems that lines and columns are swapped.
> Maybe the implementation in the linux kernel was changed to conform to
> the spec?

Yes, they have:
https://git.kernel.org/linus/5326ab737a47278dbd16ed3ee7380b26c7056ddd

I had also rebased the patches but wasn't sure how it was supposed to
work, but perhaps that was why it appeared not to work instead...
(I assumed running qemu with something like that would "just resize",
but also tried the qmp command to no avail:
-serial none -device virtio-serial-pci -chardev stdio,id=foo -device virtconsole,chardev=foo
)

I'll retry with your branch, thank you !
-- 
Dominique Martinet | Asmadeus


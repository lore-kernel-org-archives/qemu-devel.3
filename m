Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95C2C55838
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 03:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrSJg-0005ja-Ho; Tue, 04 Aug 2026 23:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tls@netbsd.org>) id 1wrSJf-0005jQ-0Z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 23:29:15 -0400
Received: from mail.netbsd.org ([2001:470:a085:999::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tls@netbsd.org>) id 1wrSJd-00011G-0m
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 23:29:14 -0400
Received: by mail.netbsd.org (Postfix, from userid 1083)
 id CAEE984E5A; Wed,  5 Aug 2026 03:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netbsd.org;
 s=20240131; t=1785900549;
 bh=1GryWXWPzSsspjt6SSCHp2Aj1sltw8dbby70G+ZjFOE=;
 h=Date:From:To:Subject;
 b=bzHwiTGsVCGcTrQiR5nxZIf3/WuVqqIdWHrs9JRvDfbSNu9QyR4J5T6UJOaqeoNgc
 QAK0hCI1tdYmd4ZXF1ONipPbMUhikXHDz/FvN+houglsIx5SQSAYB6eaPQkuCnvZ3U
 unVIXjEpVs+VLDPF6zwuzE6hNGNK4C4WXiRBpqXM=
Date: Wed, 5 Aug 2026 03:29:09 +0000
From: Thor Lancelot Simon <tls@netbsd.org>
To: qemu-devel@nongnu.org
Subject: Issue tracker hanging?
Message-ID: <anKuBeH-D-XUovxh@netbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2001:470:a085:999::25;
 envelope-from=tls@netbsd.org; helo=mail.netbsd.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I am trying to report an HPPA emulation bug (QEMU reports support for
coprocessor disable and the relevant traps, but doesn't implement them)
but the issue tracker at https://gitlab.com/qemu-project/qemu/-/work_items/new?type=Issue&initialCreationContext=list-route&description_template=Default%20%28Project%20Settings%29 hangs indefinitely when I click the "Create Issue" button
after entering an issue title.

This has been ongoing for two days.  What to do?

Thanks!

Thor


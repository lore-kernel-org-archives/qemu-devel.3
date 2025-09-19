Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D2CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzefS-00014h-In; Fri, 19 Sep 2025 13:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uzefK-0000z6-Sq; Fri, 19 Sep 2025 13:12:59 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uzefC-0000bB-1n; Fri, 19 Sep 2025 13:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e/1Pm4r2AB+FxCodoxWHDdw3g8kD8HEUpJbx03NMgIw=; b=Mbr+lVtsHpSdL/pN3KTyrR9Um0
 HlPQK9xcQwRkNmqB01/r74+z6yofABgM5eu1NQ/TWBBoNI2lPVJISys7FwHwLGZenzMhjbOKVuTQ4
 KYgOWPMGsvriPfnjn+ON/S+glPwQlj4zQKk0lfgfOzBkO1XUPxy0gPIby46YWzI4uVBx4nJZ8kVLa
 nIxZ9LBs9AWjtvs8PggnitartFjXGpq85GYqNU2EVQnpfKUr1uE0IuBi1GeLzN1Nvm7/M66OatUKD
 Crz8f/AhOQnXCF43uD+/zY0ZdRPxlKxiDP6s5cs0zucHfP2eBcCJHmbfs9FvlgtCb4SmmbVbryVzl
 yjf2FynQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uzeey-0026Om-23; Fri, 19 Sep 2025 18:12:36 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uzeey-00000000dgm-0Fyl;
 Fri, 19 Sep 2025 18:12:36 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 lawrence.hunter@codethink.co.uk, javier.jardon@codethink.co.uk,
 roan.richmond@codethink.co.uk
Subject: RISC-V: Add CVA6 machine
Date: Fri, 19 Sep 2025 18:12:33 +0100
Message-Id: <20250919171235.152476-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Add CVA6 (the corev_apu from the fpga) model from
https://github.com/openhwgroup/cva6

Previous submission:
https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg01411.html

v4:
- comment fixes
- make the core-type first and then add machine
v3:
- fix missing file source
- set 64bit only for now
v2:
- rebased and fixed whitespace issues





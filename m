Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB8BCA0EDC
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Aug 2025 05:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unWMr-00045D-Lw; Sun, 17 Aug 2025 01:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1unWMp-00044p-I1
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 01:55:43 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1unWMm-0006yV-O9
 for qemu-devel@nongnu.org; Sun, 17 Aug 2025 01:55:43 -0400
DKIM-Signature: a=rsa-sha256; bh=U/lmlPc/n70yZXOzTWw+mwJ5sbmDzvly6AsrXvQIXdM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1755410136; v=1;
 b=IZccm+FNd+RWulSvP2zPBQENHI8XOZt8AKrrWXNLbAHHJfFcmROljEyVFKj4P9Abs338D1xU
 X7LLMJgMsoC2XCMszZDyw40oDp1xVddnMSfNbuBg+01nWleLhXhvPTPqrzBwom7dhthUIVfDomE
 Fj6r0UMm3zB7pDjGj4qwrs8rNWjKeES88L3WzkWJPjPmQcIH0nJKTI3YRdmyih/SleDqCN9ALiO
 20FZmPIPA/QS1MI694ufTeIJ2tUmYKTWwoVlleUSZCwFBGmQLRKGaVpV2NOsvd//XcjFuZIs8oI
 KIumq2YSRiNa+DXGzbYjQrs7z0fACRkmI0pnBM2Z9ow6g==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 32CD522E37;
 Sun, 17 Aug 2025 05:55:36 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Sun, 17 Aug 2025 05:55:36 +0000
Subject: [PATCH qemu v5 0/1] Honor guest PAT on x86, absent Bochs display
MIME-Version: 1.0
Message-ID: <175541013614.15277.14412479690071783636-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an attempt to follow Paolo Bonzini's <pbonzini@redhat.com>
guidance on my previous proposed patch (Default disable ignore guest PAT
quirk). Hopefully, it correctly applies the advice.

myrslint (1):
  Honor guest PAT on x86, absent Bochs display

 hw/display/bochs-display.c |  4 +++
 include/system/kvm.h       |  1 +
 target/i386/kvm/kvm.c      | 52 ++++++++++++++++++++++++++++++++------
 3 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.49.1


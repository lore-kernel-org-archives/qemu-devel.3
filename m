Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494BBC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnS-00006r-KE; Sat, 11 Jul 2026 18:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifnB-0007lu-Lc; Sat, 11 Jul 2026 18:03:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifn9-0000B4-Tl; Sat, 11 Jul 2026 18:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=zivBvMtzxtYkIZOGgfUxFwYqxl7Hte03wmnIXCt/eyk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lb1sdgz1pdjdS9mN/KM2+IslWhTHR2kZ/XU2KZCRvprBtZuF9oINmy+QHws/BSrwL
 N9FQS6RLPahehY15Qnw9wUZjNK58DeqVGqMrCh9wCngU5jSGdDNqxZ2DTjXizMbaBH
 a04ZuOKAtL0r8+Tg1ZUPeSCBRKTarmPXhXUo7QtDcgCSNJ+oKHPR+I8eNjcfACWPLf
 uNVFyMlb7+x+CusThQsvIgjLh4bsBsgtXiJjVeSt21dPdqk0tX79SbacyxDSfx4ng5
 +/1Pxd0PzDIgoM6RKyqLbX/g+VnBaYia9D7M7KqYTjLdjY3iClfszRZ0s7IckUUiYN
 SoE4QnCJMFPow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1073F1C0AB4;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB6A13EAF3F;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9952313335; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 41/81] s390x/pci: Shrink RPCIT ranges to registered
 window
Date: Sun, 12 Jul 2026 00:58:19 +0300
Message-ID: <20260711215904.3757-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Today, if a RPCIT instruction is presented from the guest whose range
exceeds the previously-registered IOAT, QEMU will process the range
so long as 1) the specified range at least partially overlaps with
what was previously registered and 2) the guest has valid IOAT entries
in its table.  If the entries are not present (invalid), then the
RPCIT will unnecessarily spend time reporting the invalid
region/segment entries.

Optimize this path by exiting immediately if the requested range falls
completely outside of the previously-registered range or if the
requested range ends before it starts (which would only occur if the
guest-specified address + length would overflow a u64).  Otherwise,
clamp the request to only the portion of the range that overlaps with
what was previously registered, effectively ignoring the portion
outside of the registered range.

Cc: qemu-stable@nongnu.org
Fixes: 5d1abf2344 ("s390x/pci: enforce zPCI state checking")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-4-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit b8c8ec1d752661e1904d089c77d8617c4b6bfb5a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index ef20f7645eb..b7de23c7d2c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -770,10 +770,16 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < iommu->pba || start > iommu->pal) {
+    if (end < start || end < iommu->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
+    /*
+     * If the specified range at least partially overlaps the registered
+     * aperture, clamp the request to the aperture and ignore the rest.
+     */
+    sstart = MAX(start, iommu->pba);
+    end = MIN(end, iommu->pal + 1);
 
  retry:
     start = sstart;
-- 
2.47.3



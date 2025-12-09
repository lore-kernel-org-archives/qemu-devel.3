Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03962D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxQV-0004Ia-Hq; Tue, 09 Dec 2025 08:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1vSxQU-0004IN-Al; Tue, 09 Dec 2025 08:06:46 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1vSxQS-0007xs-Vd; Tue, 09 Dec 2025 08:06:46 -0500
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 226E2DA0776;
 Tue, 09 Dec 2025 14:06:34 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=weilnetz.de
 (policy=quarantine); 
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id EE2AB460023; Tue, 09 Dec 2025 13:58:07 +0100 (CET)
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH-for-10.2] Fix typo in documentation
Date: Tue,  9 Dec 2025 13:57:59 +0100
Message-ID: <20251209125759.764296-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: 226E2DA0776
X-Spamd-Bar: +++++
X-Spamd-Result: default: False [5.50 / 12.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_QUARANTINE(1.50)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[]; GREYLIST(0.00)[pass,body];
 RCPT_COUNT_FIVE(0.00)[5]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 FROM_HAS_DN(0.00)[]; TAGGED_RCPT(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all]; R_DKIM_NA(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 include/hw/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6bccb25ac2..b72e484500 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -751,7 +751,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
 
 /**
  * pci_iommu_unregister_iotlb_notifier: unregister a notifier that has been
- * registerd with pci_iommu_register_iotlb_notifier.
+ * registered with pci_iommu_register_iotlb_notifier.
  *
  * Returns 0 on success, or a negative errno otherwise.
  *
-- 
2.47.3



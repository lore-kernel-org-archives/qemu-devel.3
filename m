Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93546C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf2ZZ-0007tQ-Ae; Wed, 01 Jul 2026 17:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.9yoaq2aauad66j2=d0e2tgnx3a05=42zs6ymhmgdkzt@em1175899.techtravels.org>)
 id 1wf2ZY-0007st-7C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:20 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.9yoaq2aauad66j2=d0e2tgnx3a05=42zs6ymhmgdkzt@em1175899.techtravels.org>)
 id 1wf2ZW-00089i-Rp
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782941651; h=from :
 subject : to : message-id : date;
 bh=E1uDVsDHSyU28kuJ6GKslw1fWCMQ19ySF7S2/j1aX/8=;
 b=EmTtTOnmFJmvnqCN2t7jlS8F59DPaD1GuQi2JNlxNWqPZMq/j56VebZbTQWocLkXsvIkJ
 73FYFfB99Thp18I8AZqFJGNdkiOmf8wv/jytd30W3kfjjYH6KyU68yH3yCnWuYd6iQwqVU0
 Tavu9vtAgYR2ySlrry4KlYta4UAadM0Y15xW7bMohG1GFpj/C2KFRYzTRH2IJn5dV/0Sqo4
 KwD5Ebzl8JId2Qr1j/dwFf+AleITIxip3Utuc2bV4wmE80RElTKeeZZSWBFfILbh1KoyrAR
 ZJ9s4yQyNyCDYn1EBZDV6QAVAptwzh42SWy+1u87fAf6nm24oEY2qynVqPsw==
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wf2ZF-FnQW0hPscrZ-HRh9; Wed, 01 Jul 2026 21:34:01 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
Subject: [PATCH v2 2/4] hw/scsi/lasi_ncr710: remove dead and shadowing defines
Date: Wed,  1 Jul 2026 17:33:57 -0400
Message-ID: <20260701213359.1855870-3-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701213359.1855870-1-keith@techtravels.org>
References: <20260701213359.1855870-1-keith@techtravels.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899smeRLutvCC
X-smtpcorp-track: HcToV7P5WeQB.KgATQeTdDhTp.6qrqcQrKYSI
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.9yoaq2aauad66j2=d0e2tgnx3a05=42zs6ymhmgdkzt@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Drop unused register and phase defines that duplicate the authoritative
definitions in ncr53c710.h (LASI_SCSI_RESET, PHASE_MASK, NCR710_SCNTL1_RST
and friends), and the leftover SCNR debug constant. None are referenced.

Signed-off-by: Keith Monahan <keith@techtravels.org>
---
 hw/scsi/lasi_ncr710.c |  1 -
 hw/scsi/lasi_ncr710.h | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5..3fccda9e4e 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -24,7 +24,6 @@
 #include "system/dma.h"
 
 #define LASI_710_SVERSION    0x00082
-#define SCNR                 0xBEEFBABE
 #define LASI_710_HVERSION    0x3D
 #define HPHW_FIO             5        /* Fixed I/O module */
 
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 450fb7e1c3..75d3e77d20 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -22,22 +22,6 @@
 #define TYPE_LASI_NCR710 "lasi-ncr710"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiNCR710State, LASI_NCR710)
 
-#define LASI_SCSI_RESET         0x000   /* SCSI Reset Register */
-#define LASI_SCSI_NCR710_BASE   0x100   /* NCR710 Base Register Offset */
-
-#define PARISC_DEVICE_ID_OFF    0x00    /* HW type, HVERSION, SVERSION */
-#define PARISC_DEVICE_CONFIG_OFF 0x04   /* Configuration data */
-
-#define PHASE_MASK              7
-#define PHASE_DO                0
-
-#define NCR710_SCNTL1_RST       0x08    /* SCSI Reset */
-#define NCR710_ISTAT_RST        0x40    /* Device Reset */
-#define NCR710_ISTAT_ABRT       0x80    /* Script Abort */
-#define NCR710_ISTAT_CON        0x08    /* ISTAT_Connected */
-#define NCR710_DSTAT_DFE        0x80    /* DMA FIFO Empty */
-#define NCR710_CTEST2_DACK      0x01    /* DMA Acknowledge */
-
 typedef struct LasiNCR710State {
     SysBusDevice parent_obj;
     MemoryRegion mmio;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3F3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 22:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIDYz-0007eF-IB; Sun, 09 Nov 2025 17:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYx-0007dH-UU
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:07 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vIDYw-0005tt-Hi
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 17:07:07 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AB99C439B2;
 Sun,  9 Nov 2025 22:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EF2C4CEFB;
 Sun,  9 Nov 2025 22:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762726025;
 bh=faF3cw0blnpSJDXWBDnPx0moZoO2Eaq0wCzTLHV9IOE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NBPLWiwSXjXSVYJD2HFKI9s6V9lipgq7DRHc+axxBeuyRHuMSNLS6/+nHwvlUSbV9
 9kTkmFF2o6Nc3VgrtaSkfW1Aa+aY/afJv52jAL4f8EFOGkX/eoqBDrkGMTscQZ2nVf
 eaO1aA7D2Yj8HuyKXRV2QFxQL2o6bre2ggyyBzpOwGg4+mfgpSWXfaNG/KJZczQjiB
 SllfCJGxk/YWmYUIoKt1UCbvVVWaE653owCbM6WlNJhN7B8PaBEnwA9ePXVKY+K6PE
 hqjRAgDFu05N5EAK9sD6hGyMxS8CciRYnCnF0mzV00DPAJ9iCoceqJ9tsB5rVraVCT
 fO4ADloZVJJJw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 5/7] ncr710: Add missing vmstate entries
Date: Sun,  9 Nov 2025 23:06:52 +0100
Message-ID: <20251109220654.46718-6-deller@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
References: <20251109220654.46718-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 4 ++++
 hw/scsi/lasi_ncr710.h | 1 -
 hw/scsi/ncr53c710.c   | 2 +-
 hw/scsi/ncr53c710.h   | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index b674a4066f..7e0076c7a3 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -160,6 +160,10 @@ static const VMStateDescription vmstate_lasi_ncr710 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(hw_type, LasiNCR710State),
+        VMSTATE_UINT32(sversion, LasiNCR710State),
+        VMSTATE_UINT32(hversion, LasiNCR710State),
+        VMSTATE_STRUCT(ncr710, LasiNCR710State, 1, vmstate_ncr710, NCR710State),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/scsi/lasi_ncr710.h b/hw/scsi/lasi_ncr710.h
index 3711233b0f..058718068e 100644
--- a/hw/scsi/lasi_ncr710.h
+++ b/hw/scsi/lasi_ncr710.h
@@ -46,7 +46,6 @@ typedef struct LasiNCR710State {
     uint32_t hw_type;        /* Hardware type (HPHW_*) */
     uint32_t sversion;       /* Software version */
     uint32_t hversion;       /* Hardware version */
-    SCSIBus bus;
     NCR710State ncr710;
 } LasiNCR710State;
 
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index aaac31cbb9..ba064c6ecf 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2250,7 +2250,7 @@ static const VMStateDescription vmstate_ncr710_scsi_fifo = {
     }
 };
 
-static const VMStateDescription vmstate_ncr710 = {
+const VMStateDescription vmstate_ncr710 = {
     .name = "ncr710",
     .version_id = 1,
     .minimum_version_id = 1,
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 380e3959b3..6d30f9b663 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -242,5 +242,6 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len);
 void ncr710_execute_script(NCR710State *s);
 void ncr710_set_phase(NCR710State *s, int phase);
 void ncr710_reselection_retry_callback(void *opaque);
+extern const VMStateDescription vmstate_ncr710;
 
 #endif /* HW_NCR53C710_H */
-- 
2.51.1



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35891606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsVvtHDx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35i-0000Fj-Rp; Tue, 24 Nov 2026 21:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35Z-0008W4-8n
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:29 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35X-0007V1-OO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:29 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D74C04598C;
 Wed, 25 Nov 2026 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC561F000EE;
 Wed, 25 Nov 2026 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575026;
 bh=HugnzUabm/jTZb/kfIrh9k9uEyxJ3v2ARMQCaI5MUXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YsVvtHDxk9t3tZqgTnxK5ltscWRBiINzwAnkYGaJ1dRLHWYxTP50SyrWy+PFI+Twn
 9MiKob3QhOGY8I+LLAXB0GI1BfU5s5trAu+jDHnpuE7NXJpuFh7q2ot+eNps6SZ2zP
 xoCWs2XVeDcLkFtblQaxj8JSCFyL6wXI1+sO57Wym1fH/ac33f6Gq+vQSKD7q5/WR1
 NnF0TL+X+adYryKMJp5SYe+FoUd+YOF/HopDFqd8HA0qA8gL3GfZJdbcROKb2fwK3h
 66icaKuaqAq1wSGdekT09aujpQvL8ZFmaiW66qk+QvfW/wYTPJVWPi8yFhJCX32nRq
 QlQaqoiX8fV5w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 14/14] hw/scsi/ncr53c710: Bump the migration version
Date: Wed, 25 Nov 2026 03:49:51 +0100
Message-ID: <20261125024951.10428-15-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
References: <20261125024951.10428-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The migration format is incompatible with the model this replaces, so
the ncr710 and lasi_ncr710 vmstate descriptions raise minimum_version_id
in lockstep: an old stream is rejected rather than silently misparsed.

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 4 ++--
 hw/scsi/ncr53c710.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index c8a28cd987..62608d039c 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -163,8 +163,8 @@ static const MemoryRegionOps lasi_ncr710_mmio_ops = {
 
 static const VMStateDescription vmstate_lasi_ncr710 = {
     .name = "lasi-ncr710",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ncr710, LasiNCR710State, 1, vmstate_ncr710, NCR710State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index a161912727..face9039b7 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1683,8 +1683,8 @@ static int lsi_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_ncr710 = {
     .name = "ncr710",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .pre_save = lsi_pre_save,
     .post_load = lsi_post_load,
     .fields = (const VMStateField[]) {
-- 
2.54.0



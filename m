Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AE606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHiwhUjA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkq-0006xP-Ms; Mon, 23 Nov 2026 12:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkW-0006hC-KW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:42 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkV-00046S-3g
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B184C45A94;
 Mon, 23 Nov 2026 17:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF4A1F00AE3;
 Mon, 23 Nov 2026 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454557;
 bh=SnbfrGG/VTfhVIaxiKWzSJpNLOLZfbUe8l5ttGO//ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iHiwhUjAAlI/jXzeeG/+7Fm63IbOXnhD+BW1ODoniUi1EevzTdjzwP89RWFoz4ywb
 qx9C0ota9ahWzZo6fP8QgQyTcKMj3YSC0Ywp3f8em/gUrYV1Ic1AxdU7JmkmiCuk0h
 tOjkiMvfQoNdJZYGmkWei1xoDGxFPBzf/gh71O0a87Z2XLW3bYnsdvPrHWSfMY77FX
 Mu6Mw+mTuZi4uvwhblaaCf+fU9iKo6+OM//3IDMJdf7q2jvdl/fz2lRtCxZPDfOZ7+
 AoQVmzX5mhPvByDtRe5mib3r3d6lr7umKTHsxWICoigJ9aiRbhzK1QCjpd2A96QtM6
 IOn+FhYpXukSA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 14/14] hw/scsi/ncr53c710: Bump the migration version
Date: Mon, 23 Nov 2026 18:21:51 +0100
Message-ID: <20261123172151.7605-15-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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
index a77705eeda..2d3c52667c 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1675,8 +1675,8 @@ static int lsi_post_load(void *opaque, int version_id)
 
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



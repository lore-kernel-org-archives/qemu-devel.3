Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE23606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5k2TFVU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWQka-0004XR-7J; Wed, 25 Nov 2026 23:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOoi-0008Pn-4o; Wed, 25 Nov 2026 21:02:32 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+daejun7.park.samsung.com@kernel.org>)
 id 1xWOod-0007Aj-1s; Wed, 25 Nov 2026 21:02:29 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C4B84338F;
 Thu, 26 Nov 2026 02:02:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795658544;
 b=hI4gddac9QwrOhPdgiWMk9D/zjh8heP9dctsnzFe1eAR21Lv9SwGQtrgCdG7nLcoWdtx
 7Rh/RmipDEAFIvIvfsJ/Mo9FPFmrZ2xkNuqEqpjZduM3npGUTLolUQT1mjEQ4nUKxZXI4
 2xJxGqRTSEz/kqFJlIbL71fovC4QPBiQz7mOqEVA5AwysdtVguIoKduYA+WkjzR+IRl3O
 xrGmcOKKVTWggpzpx8kEzCm6X9V1Wkxnsj7k62/OfsL8r69ocDLZfUQQulyHj9oVbGo+F
 sK0wa7Re4lTY3LYG2obCgCnLQ8yTitE1ifYmmBK4Tea1hkOth+v72sF3vQzuQ4Xu/5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795658544;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=5kbaupddmJczJQzgf1uHEen+1A9SENHH/y8A2dfER2w=;
 b=oGPdAZD6kzUqcFHCI7EydgqlQIK0/neoFYE1NnS2hNnFIcOrPqqz5U59PLKrnb8rbbA4
 ghlft6J+ejKdfNfbEccaYVqDDO2XKItQkWmHFi8z70rSCVRRM73ckbJDDlsQ19vir0dz6
 yAryKkl5jQ9c3leyeHXJPXCUM0slxksal/XhR2lxpOV1cTAX0L+Vxz2QM68I+Mvx/YemT
 jO5Vg6w5YE8zyNHFRTGcUV9Ga2GmJOVllYMhFnU8INCqanTptEdAu/RQe8zePJd4Q5Q6a
 Tv2kT7E84ve2+YVnGJzu5viEsWRq/kKwb9TEb8RqrPAEpOlpYgog4kI2i4Q2kyu0k5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9260E1F000C0;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795658544;
 bh=5kbaupddmJczJQzgf1uHEen+1A9SENHH/y8A2dfER2w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=D5k2TFVUNa5Q0iVc9HYiM89uiVZKtcek/Ptra0RMO6+q57KhE9kMIO+vDyw0AgPFQ
 lP3DCnXJlh8ScukzxpImyU39cgqu6TpxE18rSOe3vv2k8V1Q/2G9sc1elWLmmtQ+Pr
 L+yc7/FsQLF/joIBD8QXZXqxy71J1qequrA+sngk/EjOjzRGHZffRxwtW0qN+pO7Wd
 /CS4j81EIejhFlHZWI/wCbdF86STxMaO9JUrb0Bx/DwHr7EtDDbx6FFeFb1CVMpR8Z
 6CP5Q0yRmpSZpxDHOoTt5u/79jVWeAE1arwEh7McVFZyg3dnLYNgorLsrOABd0WBBU
 DLHG6dJHYPa8A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1E7D64D184;
 Thu, 26 Nov 2026 02:02:11 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Thu, 26 Nov 2026 11:02:10 +0900
Subject: [PATCH v4 2/5] scsi-disk: Report zone errors with their ZBC sense
 codes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-zoned-ufs-v4b-v4-2-f90239d12a55@samsung.com>
References: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
In-Reply-To: <20261126-zoned-ufs-v4b-v4-0-f90239d12a55@samsung.com>
To: qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stanley Jhu <stanleyjhu@google.com>, 
 Keoseong Park <keosung.park@samsung.com>, 
 Daejun Park <daejun7.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795658528; l=3383;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=RtJEtOqUcVPZOmbAoYOQxqGUl03XOQZDoLQB2Vd6q/M=;
 b=ZWuz6BUBbZ5PGfvwLesYCxv/bHWY0FNE8nFH8bX8iCpVarrFIgzroG8I/ca7StcWLq6W1YyD6
 ZVBnA+lOCHYBPCSyJatkbvOVLKLWhZHJoAZr0FNaYGmPVmqaLdbp133
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=devnull+daejun7.park.samsung.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 23:06:17 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daejun Park <daejun7.park@samsung.com>

A zoned block driver fails a write that breaks the zone rules with a
BLK_ZE_* errno. scsi-disk reports these as ABORTED COMMAND under the
werror policy. So the guest retries, and with werror=stop the VM stops
again on resume.

On a host-managed backend, report the ZBC sense code instead, whatever
the error policy, as for a reservation conflict. A write to a full zone
gets INVALID FIELD IN CDB. The mapping goes to scsi/utils.c for zoned
UFS to share.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/scsi/scsi-disk.c  | 11 ++++++++++-
 include/scsi/utils.h |  1 +
 scsi/utils.c         | 28 ++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a2df3a4ec4..643247da0c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -246,7 +246,16 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int ret, bool acct_failed)
         r->req.host_status = -1;
     }
 
-    if (ret < 0) {
+    if (ret < 0 && blk_get_zone_model(s->qdev.conf.blk) == BLK_Z_HM &&
+        scsi_sense_from_zone_errno(-ret, &sense)) {
+        /*
+         * The guest broke the zone rules. As for a reservation conflict,
+         * a retry fails the same way, so report the error whatever the
+         * error policy, and do not post it to QMP.
+         */
+        status = CHECK_CONDITION;
+        error = 0;
+    } else if (ret < 0) {
         status = scsi_sense_from_errno(-ret, &sense);
         error = -ret;
     } else {
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d16c264b22..93178e7528 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -148,6 +148,7 @@ int scsi_cdb_length(uint8_t *buf);
 #endif
 
 int scsi_sense_from_errno(int errno_value, SCSISense *sense);
+bool scsi_sense_from_zone_errno(int errno_value, SCSISense *sense);
 int scsi_sense_from_host_status(uint8_t host_status, SCSISense *sense);
 
 #endif
diff --git a/scsi/utils.c b/scsi/utils.c
index 9eb41aefdf..cdf3ef11d4 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -17,6 +17,7 @@
 #include "scsi/constants.h"
 #include "scsi/utils.h"
 #include "qemu/bswap.h"
+#include "block/block-common.h"
 
 uint32_t scsi_data_cdb_xfer(uint8_t *buf)
 {
@@ -597,6 +598,33 @@ const char *scsi_command_name(uint8_t cmd)
     return names[cmd];
 }
 
+/*
+ * The sense code of a zone error, one of the BLK_ZE_* errnos with which a
+ * zoned block driver fails a request that breaks the zone rules. Other
+ * drivers use these errnos for other errors, so only ask for the errors of
+ * a zoned backend.
+ */
+bool scsi_sense_from_zone_errno(int errno_value, SCSISense *sense)
+{
+    switch (errno_value) {
+    case BLK_ZE_UNALIGNED_WRITE:
+        *sense = SENSE_CODE(UNALIGNED_WRITE);
+        return true;
+    case BLK_ZE_BOUNDARY:
+        *sense = SENSE_CODE(WRITE_BOUNDARY_VIOLATION);
+        return true;
+    case BLK_ZE_FULL:
+        *sense = SENSE_CODE(INVALID_FIELD);
+        return true;
+    case BLK_ZE_OPEN_RESOURCE:
+    case BLK_ZE_ACTIVE_RESOURCE:
+        *sense = SENSE_CODE(INSUFFICIENT_ZONE_RESOURCES);
+        return true;
+    default:
+        return false;
+    }
+}
+
 int scsi_sense_from_errno(int errno_value, SCSISense *sense)
 {
     switch (errno_value) {

-- 
2.43.0




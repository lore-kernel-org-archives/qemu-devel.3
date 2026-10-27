Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF5606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AMt5qbDe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaGM-0007rw-SR; Tue, 27 Oct 2026 02:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VD7gagoKCq8hiPcaTnYWjVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG3-0007pb-2A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:03 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VD7gagoKCq8hiPcaTnYWjVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG0-00067X-EI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:02 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cd68b8579f2so1473324a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080917; x=1793685717; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MvEx57NIAgJI0ijP3mUpfKJH9oHR1otTCVEVwZ8ExXE=;
 b=AMt5qbDeislEFSuMUpj9fgN9bOK7CXZ6+o0cSA7HoPAYBuufT05Cnas6vpGWpDPLIn
 rvCvVg6NDpcvp+KR+fdkdEWZ8aelMsOR9BSObqzHqWudD5iGKrIna4/ci3yYtv07qykp
 bAedDPE218qsp8ZKHyOSrJsjlz0d6E3YEWkpXFl9LNDkFCtsY4Xr1yiIYv+I3XMDOrkP
 vLDDvPEgiIXPRyWTxJQ13nrDabQmWfLFkoInef1zyFLjfrkAFIDowyHKSoD1q/RisgKZ
 3mr7H84JoF4vbXdfh9Tkdk3BlvCkRbmvETYtWfvH3B1zdxVuz0kWpGmeKgyGoGAWUH4Y
 ERHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080917; x=1793685717;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MvEx57NIAgJI0ijP3mUpfKJH9oHR1otTCVEVwZ8ExXE=;
 b=r6fdUKImZCM2FDHnZ7/xb1meG8MhLJCuOYXdUxgpAOhHM2Bu28nU7mxBnnYZotawYY
 5+/J7+ktKabvSOmMG7mUEsOuwB/HWymJZiOVaOe6J4Wn2s0IAqfP3FBuAt0aM3uPqn6/
 a/27Y+S+TCbVIfa41gJXxWjMVNcflbYYuHW39XBGXMLYmPuAdkvgGrXzqerUGz6ddZfs
 6k76Pcwr0XOCMeYDq5DqwbaLIOIMKcrXTKtVA0AN0hjUX+COvWOMZJ5EGyPyd1lOvc0x
 lEl2I4POJM8EhBvkXuuMPZZZCLCypuJrf0+ITPBgpwU6rIOtNNfLwdKVjthQhl1+8Icm
 1RvA==
X-Gm-Message-State: AFq9FYJUGvDmUXC3vbmNe4OTtJVxOFlfGJbdoeI6x7xTuHEKLbWV/VZy
 J4L7WP5ko3CFEeLhuWR8h/f1z79nmVsbmNQo23DYKeHfrf+AtvEU2sClFiakHCRq4JQ1Ez7FBh4
 TgJUQTU318kxrnK3Arn+7AQ==
X-Received: from pfblc1.prod.google.com ([2002:a05:6a00:4f41:b0:89e:65fd:e92])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c92:b0:886:9078:546 with SMTP id
 d2e1a72fcca58-8a366c7db93mr6784850b3a.26.1793080916730; 
 Mon, 26 Oct 2026 23:01:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:46 +0800
In-Reply-To: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027060153.1842910-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-2-stanleyjhu@google.com>
Subject: [PATCH 1/7] include/scsi,
 block/ufs: Add security protocol and RPMB definitions
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3VD7gagoKCq8hiPcaTnYWjVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--stanleyjhu.bounces.google.com;
 helo=mail-pg1-x545.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UFS Replay Protected Memory Block (RPMB) accesses are transported over
SCSI SECURITY PROTOCOL IN (0xa2) and SECURITY PROTOCOL OUT (0xb5)
commands directed to the RPMB well-known logical unit (W-LUN 0xc4).

Add SECURITY_PROTOCOL_IN and SECURITY_PROTOCOL_OUT in numeric order to
include/scsi/constants.h, update RpmbUnitDescriptor to expose
bRPMBRegionEnable and bRPMBRegion0Size..bRPMBRegion3Size per JESD220H
Table 14.15 while preserving its 35-byte packed layout, and define the
512-byte UfsRpmbFrame structure, geometry constants, request/response
types, and operation result codes from JESD220H Section 12.4.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 include/block/ufs.h      | 58 +++++++++++++++++++++++++++++++++++++---
 include/scsi/constants.h |  2 ++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/block/ufs.h b/include/block/ufs.h
index a0bbe873d6..339c3bf5b4 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -387,6 +387,10 @@ typedef struct QEMU_PACKED UnitDescriptor {
     uint32_t lu_num_write_booster_buffer_alloc_units;
 } UnitDescriptor;
 
+#define UFS_RPMB_MAX_REGIONS            4
+#define UFS_RPMB_LOGICAL_BLOCK_SIZE     8 /* 2^8 = 256 bytes */
+#define UFS_RPMB_BLOCKS_PER_UNIT        512 /* 128 KiB / 256 B */
+
 typedef struct QEMU_PACKED RpmbUnitDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -397,15 +401,62 @@ typedef struct QEMU_PACKED RpmbUnitDescriptor {
     uint8_t lu_queue_depth;
     uint8_t psa_sensitive;
     uint8_t memory_type;
-    uint8_t reserved;
+    uint8_t rpmb_region_enable;
     uint8_t logical_block_size;
     uint64_t logical_block_count;
-    uint32_t erase_block_size;
+    uint8_t rpmb_region_size[UFS_RPMB_MAX_REGIONS];
     uint8_t provisioning_type;
     uint64_t phy_mem_resource_count;
-    uint8_t reserved2[3];
+    uint8_t reserved[3];
 } RpmbUnitDescriptor;
 
+#define UFS_RPMB_FRAME_LEN      512
+#define UFS_RPMB_DATA_LEN       256
+#define UFS_RPMB_KEY_MAC_LEN    32
+#define UFS_RPMB_NONCE_LEN      16
+#define UFS_RPMB_HASH_OFFSET    228
+#define UFS_RPMB_HASH_LEN       (UFS_RPMB_FRAME_LEN - UFS_RPMB_HASH_OFFSET)
+
+#define UFS_RPMB_SEC_PROTOCOL       0xec
+#define UFS_RPMB_SEC_PROTOCOL_ID    0x01
+
+enum UfsRpmbRequest {
+    UFS_RPMB_REQ_PROGRAM_KEY        = 0x0001,
+    UFS_RPMB_REQ_READ_COUNTER       = 0x0002,
+    UFS_RPMB_REQ_AUTH_DATA_WRITE    = 0x0003,
+    UFS_RPMB_REQ_AUTH_DATA_READ     = 0x0004,
+    UFS_RPMB_REQ_READ_RESULT        = 0x0005,
+
+    UFS_RPMB_RESP_PROGRAM_KEY       = 0x0100,
+    UFS_RPMB_RESP_READ_COUNTER      = 0x0200,
+    UFS_RPMB_RESP_AUTH_DATA_WRITE   = 0x0300,
+    UFS_RPMB_RESP_AUTH_DATA_READ    = 0x0400,
+};
+
+enum UfsRpmbResult {
+    UFS_RPMB_RES_OK                 = 0x0000,
+    UFS_RPMB_RES_GENERAL_FAILURE    = 0x0001,
+    UFS_RPMB_RES_AUTH_FAILURE       = 0x0002,
+    UFS_RPMB_RES_COUNT_FAILURE      = 0x0003,
+    UFS_RPMB_RES_ADDR_FAILURE       = 0x0004,
+    UFS_RPMB_RES_WRITE_FAILURE      = 0x0005,
+    UFS_RPMB_RES_READ_FAILURE       = 0x0006,
+    UFS_RPMB_RES_NO_AUTH_KEY        = 0x0007,
+    UFS_RPMB_RES_COUNT_EXPIRED      = 0x0080,
+};
+
+typedef struct QEMU_PACKED UfsRpmbFrame {
+    uint8_t stuff[196];
+    uint8_t key_mac[UFS_RPMB_KEY_MAC_LEN];
+    uint8_t data[UFS_RPMB_DATA_LEN];
+    uint8_t nonce[UFS_RPMB_NONCE_LEN];
+    uint32_t write_counter;
+    uint16_t addr;
+    uint16_t block_count;
+    uint16_t result;
+    uint16_t req_resp;
+} UfsRpmbFrame;
+
 typedef struct QEMU_PACKED PowerParametersDescriptor {
     uint8_t length;
     uint8_t descriptor_idn;
@@ -1397,6 +1448,7 @@ static inline void _ufs_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(GeometryDescriptor) != 105);
     QEMU_BUILD_BUG_ON(sizeof(UnitDescriptor) != 45);
     QEMU_BUILD_BUG_ON(sizeof(RpmbUnitDescriptor) != 35);
+    QEMU_BUILD_BUG_ON(sizeof(UfsRpmbFrame) != UFS_RPMB_FRAME_LEN);
     QEMU_BUILD_BUG_ON(sizeof(PowerParametersDescriptor) != 98);
     QEMU_BUILD_BUG_ON(sizeof(InterconnectDescriptor) != 6);
     QEMU_BUILD_BUG_ON(sizeof(StringDescriptor) != 254);
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index bb3981a779..5a738e89bf 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -127,6 +127,7 @@
 #define WRITE_LONG_16         0x9f
 #define REPORT_LUNS           0xa0
 #define ATA_PASSTHROUGH_12    0xa1
+#define SECURITY_PROTOCOL_IN  0xa2
 #define MAINTENANCE_IN        0xa3
 #define MAINTENANCE_OUT       0xa4
 #define MOVE_MEDIUM           0xa5
@@ -142,6 +143,7 @@
 #define SEARCH_HIGH_12        0xb0
 #define SEARCH_EQUAL_12       0xb1
 #define SEARCH_LOW_12         0xb2
+#define SECURITY_PROTOCOL_OUT 0xb5
 #define READ_ELEMENT_STATUS   0xb8
 #define SEND_VOLUME_TAG       0xb6
 #define READ_DEFECT_DATA_12   0xb7
-- 
2.56.0.307.g5fe7bd680c-goog



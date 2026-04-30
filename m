Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD379FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJXk-0000ak-4f; Thu, 30 Apr 2026 01:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wIJX7-0000FC-Br
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:01:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wIJWR-00057x-UA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:01:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b24fede2acso3002405ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777525270; x=1778130070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yQ10o/nhNMp9WiPLO3oSpqcfumGQlVQMd3hRta3eci0=;
 b=prk+x0crdHLN1fKm8sw9lNOCLlurerEG/Kv+XiJy/mPxH53gLKqCTQ69aC/1lC5WRw
 v3bgGr4JzQKn2Q63jhzGYaARJegu+7mIOfJwL5evAeOKB7g8L6hDe5Ry7S6UVmP/tB26
 9dk05Nxk1b5+/I39bBwaB0BQeRcmYvnD8CMWGUTDxKST1cFdHiQp8bP34UB5v/iSDua3
 okBckwqtMPXCafjzzh5ONI0P8bxXeemxNvP+tbhYxeDBrinY/xy8it+juojv8prD7UF7
 7cJSenDo9xLQhnA+z7VZeX/KBABH1oqgmmcPVZas49PaPWkOuYdT9nTIitlNLOiDraJd
 x3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525270; x=1778130070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ10o/nhNMp9WiPLO3oSpqcfumGQlVQMd3hRta3eci0=;
 b=LtRHJiIH23TpeEt/46v3l/HzXuX9umbcCV3lPWtHi1M3ghsEyFguNDvk1CfFqB27cs
 nvmnrLAAKt9NpyqizyjdADLlYo+aHrrNdPROxWf24THWH+RIy0xLb5/Vfi9VBzZ8tZuc
 cR6FaW7JzIFLa3dmt3i2OkdxRbAK5D5Sb8FsD+u02u2IO12vMch0GztiKK56B3TO7B4a
 pPMfKQXpjE7ryK9BRbANln563+9iujKnYCzen1Vv3J/NaCMsLMhiuMKpBSfSgl+29C+q
 6wgw+tX8eQ/L8yzREB7PXfmoNuzI17hBVtT8t4GUW6JKo5Cizp8klEPpWXaJ0GBUR1V4
 pK/A==
X-Gm-Message-State: AOJu0YwH4lEJ2SXtKjWEp9jDQJf+cyWJ4fgbR+SqERqv9J8ud9M3McHL
 Mkkw4sjV0ZpUbtPBIfnahbfQjRvMRChxKUCLBwHrcMMH1MPnF0U2Zs0lr97Ql15bDPgKnQ==
X-Gm-Gg: AeBDietN5x57hmtK6m8wIp6WUDtXlYq48Sgo2f2JlfYFi/YPJNRBiL/vHmsKu96+X23
 UISGS/pYpEUME0Lf6W+6rU1eX4TY7zfwSNgeVuxKrOpwNgbU4IPEhrd2l1UXG6FbjHzYLnWH2iY
 j+wNH2otiFtkwqulGFHASonWY1rqecSoXviF7EynSHADMT1xIbLCfD5r2qQZN3j/gcqlQBiqNar
 CzFWc6njBS4Ru0LhSOqURppm/kYNYzoAV8erOn6Qtcks7aKvf9dkf+ZllOX5izzePrzGY2KtA+g
 w5geJ31l1nLN1L7BiBLmbLq2abJbk1hxKbOgoMSPtvhV1p6nu+zJasmew2bXZmH3SSoBzvbwrNe
 v7Z/Ck1+5P0o2PGp7amVo5w+V1i49gmU8u3Jm/5bqdmRkKdPqtNaW5PH8ati1E5sO3ytlqX702I
 Q2oIr07oX/xk0XQ3Y7Np7nqQ008PqkDgRCOfbLn3pmcQ1EHPU1m64=
X-Received: by 2002:a17:903:3c4f:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b9a24b954fmr12675645ad.27.1777525269442; 
 Wed, 29 Apr 2026 22:01:09 -0700 (PDT)
Received: from localhost.localdomain ([114.249.134.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988963ed0sm39527405ad.65.2026.04.29.22.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:01:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH] hw/cxl: bound Set Feature cleanup to written extent
Date: Thu, 30 Apr 2026 13:01:03 +0800
Message-Id: <20260430050103.3172190-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

cmd_features_set_feature() validates each fragment against the target
write-attribute buffer, but it tracks data_size as the sum of every
fragment copied so far.

That becomes a problem at transfer completion. Cleanup uses data_size as
its memset() length, so a sequence of legal partial transfers can keep
rewriting the same small range while growing data_size far beyond the
feature buffer that is actually being updated.

On an ASan build, repeatedly sending 2-byte rank_sparing fragments at
offset 0 and then finishing aborts the host with:

  ERROR: AddressSanitizer: heap-buffer-overflow
  WRITE of size 1144
      #0 __interceptor_memset
      #1 cmd_features_set_feature ../hw/cxl/cxl-mailbox-utils.c:1961
      #2 cxl_process_cci_message ../hw/cxl/cxl-mailbox-utils.c:4642
      #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:209

Fix this by tracking the maximum written extent instead of the cumulative
number of copied bytes. That keeps cleanup bounded to the actual
write-attribute window without changing the rest of the transfer flow.

Add a qtest that confirms a multipart bank_sparing transfer does not
clobber adjacent rank_sparing state during cleanup.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3461
Signed-off-by: Jia Jia <physicalmtea@gmail.com>

---
 hw/cxl/cxl-mailbox-utils.c |  11 +---
 tests/qtest/cxl-test.c     | 119 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ce139e30eb..8346177b79 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1769,7 +1769,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
                ps_write_attrs,
                bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1796,7 +1795,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1820,7 +1818,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
                sppr_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1842,7 +1839,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
                hppr_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1864,7 +1860,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1885,7 +1880,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1906,7 +1900,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1927,7 +1920,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
         memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
-        set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
@@ -1938,6 +1930,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_UNSUPPORTED;
     }
 
+    set_feat_info->data_size = MAX(set_feat_info->data_size,
+                                   (size_t)end_offset);
+
     if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index a9fcd98736..ed222aca4b 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -99,6 +99,21 @@ typedef struct QEMU_PACKED CXLSetFeatureInHeaderTest {
     uint8_t rsvd[9];
 } CXLSetFeatureInHeaderTest;
 
+typedef struct QEMU_PACKED CXLGetFeatureInHeaderTest {
+    uint8_t uuid[16];
+    uint16_t offset;
+    uint16_t count;
+    uint8_t selection;
+} CXLGetFeatureInHeaderTest;
+
+enum {
+    CXL_TEST_GET_FEATURE_SEL_CURRENT_VALUE = 0,
+    CXL_TEST_SET_FEATURE_FLAG_FULL_DATA_TRANSFER = 0,
+    CXL_TEST_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER = 1,
+    CXL_TEST_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER = 2,
+    CXL_TEST_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER = 3,
+};
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -177,15 +192,37 @@ static uint16_t cxl_test_t3d_mailbox_errno(void)
 
 static void cxl_test_fill_set_feature_header(CXLSetFeatureInHeaderTest *hdr,
                                              const uint8_t uuid[16],
+                                             uint32_t flags,
                                              uint16_t offset,
                                              uint8_t version)
 {
     memset(hdr, 0, sizeof(*hdr));
     memcpy(hdr->uuid, uuid, 16);
+    hdr->flags = cpu_to_le32(flags);
     hdr->offset = cpu_to_le16(offset);
     hdr->version = version;
 }
 
+static void cxl_test_fill_get_feature_header(CXLGetFeatureInHeaderTest *hdr,
+                                             const uint8_t uuid[16],
+                                             uint16_t offset,
+                                             uint16_t count)
+{
+    memset(hdr, 0, sizeof(*hdr));
+    memcpy(hdr->uuid, uuid, 16);
+    hdr->offset = cpu_to_le16(offset);
+    hdr->count = cpu_to_le16(count);
+    hdr->selection = CXL_TEST_GET_FEATURE_SEL_CURRENT_VALUE;
+}
+
+static void cxl_test_t3d_submit_get_feature(const void *payload, size_t len)
+{
+    memwrite(cxl_test_t3d_payload_base(), payload, len);
+    writeq(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CMD,
+           ((uint64_t)len << 16) | (0x05 << 8) | 0x01);
+    writel(cxl_test_t3d_mailbox_base() + A_CXL_DEV_MAILBOX_CTRL, 1);
+}
+
 static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)
 {
     static const uint8_t rank_sparing_uuid[16] = {
@@ -203,7 +240,7 @@ static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)
     qtest_start(cmdline->str);
     cxl_test_t3d_enable_bar2();
 
-    cxl_test_fill_set_feature_header(hdr, rank_sparing_uuid, 0,
+    cxl_test_fill_set_feature_header(hdr, rank_sparing_uuid, 0, 0,
                                      CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
     memset(payload + sizeof(*hdr), 0x41,
            sizeof(payload) - sizeof(*hdr));
@@ -215,6 +252,84 @@ static void cxl_t3d_set_feature_rejects_oversized_rank_sparing(void)
     rmdir(tmpfs);
 }
 
+static void cxl_t3d_set_feature_cleanup_stays_within_feature_state(void)
+{
+    static const uint8_t bank_sparing_uuid[16] = {
+        0x36, 0x96, 0xb7, 0x78, 0xac, 0x90, 0x64, 0x4b,
+        0xa4, 0xef, 0xfa, 0xac, 0x5d, 0x18, 0xa8, 0x63,
+    };
+    static const uint8_t rank_sparing_uuid[16] = {
+        0x34, 0xdb, 0xaf, 0xf5, 0x05, 0x52, 0x42, 0x81,
+        0x8f, 0x76, 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7,
+    };
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+    uint8_t set_payload[sizeof(CXLSetFeatureInHeaderTest) + 2] = { 0 };
+    uint8_t get_payload[sizeof(CXLGetFeatureInHeaderTest)] = { 0 };
+    uint8_t out[2];
+    CXLSetFeatureInHeaderTest *set_hdr = (void *)set_payload;
+    CXLGetFeatureInHeaderTest *get_hdr = (void *)get_payload;
+    int i;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+    g_string_printf(cmdline, QEMU_T3D_DIRECT_PMEM, tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    cxl_test_t3d_enable_bar2();
+
+    cxl_test_fill_set_feature_header(
+        set_hdr, rank_sparing_uuid,
+        CXL_TEST_SET_FEATURE_FLAG_FULL_DATA_TRANSFER, 0,
+        CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+    set_payload[sizeof(*set_hdr)] = 0x34;
+    set_payload[sizeof(*set_hdr) + 1] = 0x12;
+    cxl_test_t3d_submit_set_feature(set_payload, sizeof(set_payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==, CXL_MBOX_SUCCESS);
+
+    cxl_test_fill_set_feature_header(set_hdr, bank_sparing_uuid,
+                                     CXL_TEST_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
+                                     0,
+                                     CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+    set_payload[sizeof(*set_hdr)] = 0x78;
+    set_payload[sizeof(*set_hdr) + 1] = 0x56;
+    cxl_test_t3d_submit_set_feature(set_payload, sizeof(set_payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==, CXL_MBOX_SUCCESS);
+
+    /* Repeating the same 2-byte fragment must not clobber adjacent state. */
+    for (i = 0; i < 2; i++) {
+        cxl_test_fill_set_feature_header(
+            set_hdr, bank_sparing_uuid,
+            CXL_TEST_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
+            0, CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+        set_payload[sizeof(*set_hdr)] = 0xaa;
+        set_payload[sizeof(*set_hdr) + 1] = 0xbb;
+        cxl_test_t3d_submit_set_feature(set_payload, sizeof(set_payload));
+        g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==, CXL_MBOX_SUCCESS);
+    }
+
+    cxl_test_fill_set_feature_header(set_hdr, bank_sparing_uuid,
+                                     CXL_TEST_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
+                                     0,
+                                     CXL_MEMDEV_SPARING_SET_FEATURE_VERSION);
+    set_payload[sizeof(*set_hdr)] = 0xcc;
+    set_payload[sizeof(*set_hdr) + 1] = 0xdd;
+    cxl_test_t3d_submit_set_feature(set_payload, sizeof(set_payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==, CXL_MBOX_SUCCESS);
+
+    cxl_test_fill_get_feature_header(get_hdr, rank_sparing_uuid,
+                                     offsetof(CXLMemSparingReadAttrs, op_mode),
+                                     2);
+    cxl_test_t3d_submit_get_feature(get_payload, sizeof(get_payload));
+    g_assert_cmphex(cxl_test_t3d_mailbox_errno(), ==, CXL_MBOX_SUCCESS);
+
+    memread(cxl_test_t3d_payload_base(), out, sizeof(out));
+    g_assert_cmphex(out[0], ==, 0x34);
+    g_assert_cmphex(out[1], ==, 0x12);
+
+    qtest_end();
+    rmdir(tmpfs);
+}
+
 static void cxl_t3d_deprecated(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
@@ -337,6 +452,8 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
         qtest_add_func("/pci/cxl/type3_device_set_feature_rank_sparing_bounds",
                        cxl_t3d_set_feature_rejects_oversized_rank_sparing);
+        qtest_add_func("/pci/cxl/type3_device_set_feature_cleanup_bounds",
+                       cxl_t3d_set_feature_cleanup_stays_within_feature_state);
         qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
         qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
                        cxl_2pxb_4rp_4t3d);
-- 
2.34.1



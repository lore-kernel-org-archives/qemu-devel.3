Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0336AC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdB-0005qU-O9; Wed, 14 May 2025 07:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd9-0005q2-Qp
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd6-00063Q-HV
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fJgSbXc546dwe+4Ew3aID1Zi5bepWCH2l5RAH/aT3s=;
 b=JRarwsNWDbuLmY6zeF2Ld5lqg2Hs13pM5rwFuqiyhqRXdwFvWsgKBUMciMr21g8e2U7pV2
 t5oK4vMeS2cc9oiXdA7weoDBNO0LcGrXVvdj4m+fdFHMN/5Sn43NTqTPho1j62vmbI70fY
 BLulcWSd9KdC2FQEft8pfScqq+h5S0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-KLdPkNfJPDWI5Ls_LoXXmg-1; Wed, 14 May 2025 07:50:27 -0400
X-MC-Unique: KLdPkNfJPDWI5Ls_LoXXmg-1
X-Mimecast-MFC-AGG-ID: KLdPkNfJPDWI5Ls_LoXXmg_1747223426
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so41300765e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223425; x=1747828225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fJgSbXc546dwe+4Ew3aID1Zi5bepWCH2l5RAH/aT3s=;
 b=duOVMG/9S9R6TZi2KUYcjX+Mqmat7mhvaipY/XD3ZyFlLqECz8Lrai2pSB9hmSFfUr
 7Ll9QFFqj4fl8w234Hd7/7FNZ53iTY/kDL9xQbGsm/3z/qdLV7QkEV9roDV/uR5yL303
 koOtUWlj8lCCXO9rzgSfqrlDufHfYoT9jLVi6zDE4VvLLIe8HAFcknLW0/roOfwHMdTl
 bS8lmIgxMPcj/zt4WQK7RFR3DCc6BICX3tV6EZjckGkudk6V+zLKAN3LHsosSC2idmsC
 IAhPvdgu+Eg4O95HqbxDKgl/RX8lhxoDTQksiLUjvSkXI2+DExdcHRX6EArMFRgoSt+i
 ejDg==
X-Gm-Message-State: AOJu0YwdCTBJVa40sYajetOogkaNzVgv9tr00bL6SKZNiUR2/PVJHcHJ
 sQpKIlGSYpCUAE50Bo7WgzHuSEtuoezb6N3wMrizRzwhIN7CQHNACfGaSfgdlLsUO33x0/IKVKq
 OAQgygXDV525aMccl2AiBumcEWAa8Cj2YdyywxZuJSv9/OQvRiad9uah6088ptJgbFq6xX+p9nU
 mfkkcFd6hnSzYzjrA1sX1ptAZ4WAr4PA==
X-Gm-Gg: ASbGncv6OBTSO3CLZ6sVeQWrZpMIxkqmofq6pYbkXvQzh0IWvaAJu/dkEnnR1Q43DdF
 J4twwK7FsdbbJYHhSGSBsfpbEpyd2DuJzumPCJKfWL3fSCEXTU1oErB6Ymv4ivtWyUm6ZFLanRI
 Wuti3TswTyKqbIiui2L694BtiWbIn3k+qe3f1o8sf75eOZvMm+dBj3ohrdMsuxOrTfvKGKc/GjP
 tzU8BpXmB9WXt1yz52FCvv4/vOzueKV9QA68FzmGDb3rGsMUkiFVDrr5q565UV4ClYraqIhWHlL
 W26DpQ==
X-Received: by 2002:a05:6000:40dc:b0:3a0:b539:f330 with SMTP id
 ffacd0b85a97d-3a3496999e0mr2602490f8f.2.1747223425578; 
 Wed, 14 May 2025 04:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ixA3LrF3ohTDjsAXpI7B90nqWULVqAZvTiHrwD0KQdt1iIoyobl81S0SFHavH40RYe1NCQ==
X-Received: by 2002:a05:6000:40dc:b0:3a0:b539:f330 with SMTP id
 ffacd0b85a97d-3a3496999e0mr2602448f8f.2.1747223425032; 
 Wed, 14 May 2025 04:50:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3979275sm27340185e9.34.2025.05.14.04.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:24 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vinayak Holikatti <vinayak.kh@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 03/27] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Message-ID: <77a8e9fe0ecb71b260d17f43221df5b18769b359.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vinayak Holikatti <vinayak.kh@samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bd25df033a..79b35d1405 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -89,6 +89,7 @@ enum {
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
     PERSISTENT_MEM = 0x45,
         #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
@@ -1705,6 +1706,126 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+enum {
+    MEDIA_OP_CLASS_GENERAL  = 0x0,
+        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
+    MEDIA_OP_CLASS_SANITIZE = 0x1,
+        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
+        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
+};
+
+struct media_op_supported_list_entry {
+    uint8_t media_op_class;
+    uint8_t media_op_subclass;
+};
+
+struct media_op_discovery_out_pl {
+    uint64_t dpa_range_granularity;
+    uint16_t total_supported_operations;
+    uint16_t num_of_supported_operations;
+    struct media_op_supported_list_entry entry[];
+} QEMU_PACKED;
+
+static const struct media_op_supported_list_entry media_op_matrix[] = {
+    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
+};
+
+static CXLRetCode media_operations_discovery(uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint16_t start_index;
+            uint16_t num_ops;
+        } discovery_osa;
+    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    struct media_op_discovery_out_pl *media_out_pl =
+        (struct media_op_discovery_out_pl *)payload_out;
+    int num_ops, start_index, i;
+    int count = 0;
+
+    if (len_in < sizeof(*media_op_in_disc_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
+    start_index = media_op_in_disc_pl->discovery_osa.start_index;
+
+    /*
+     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and
+     * start index should not exceed the total number of entries for discovery
+     * sub class command.
+     */
+    if (media_op_in_disc_pl->dpa_range_count ||
+        start_index > ARRAY_SIZE(media_op_matrix)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
+    media_out_pl->total_supported_operations =
+                                     ARRAY_SIZE(media_op_matrix);
+    if (num_ops > 0) {
+        for (i = start_index; i < start_index + num_ops; i++) {
+            media_out_pl->entry[count].media_op_class =
+                    media_op_matrix[i].media_op_class;
+            media_out_pl->entry[count].media_op_subclass =
+                        media_op_matrix[i].media_op_subclass;
+            count++;
+            if (count == num_ops) {
+                break;
+            }
+        }
+    }
+
+    media_out_pl->num_of_supported_operations = count;
+    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    uint8_t media_op_cl = 0;
+    uint8_t media_op_subclass = 0;
+
+    if (len_in < sizeof(*media_op_in_common_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    media_op_cl = media_op_in_common_pl->media_operation_class;
+    media_op_subclass = media_op_in_common_pl->media_operation_subclass;
+
+    switch (media_op_cl) {
+    case MEDIA_OP_CLASS_GENERAL:
+        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        return media_operations_discovery(payload_in, len_in, payload_out,
+                                             len_out);
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2850,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_SECURITY_STATE_CHANGE |
          CXL_MBOX_BACKGROUND_OPERATION |
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
+    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
+        ~0,
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10872D3001B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pbP-0003lZ-RH; Fri, 18 Oct 2024 12:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbK-0003ke-Ak
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:18 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t1pbH-0004Ob-DH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:13:17 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b13bf566c0so141760585a.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1729267993; x=1729872793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/0cRfb4YBF8cPInnUDV/L7Jp4pgWglmeJbCtRCfJPQ=;
 b=HNFcszvgCsCQpBwfNyRF30E11MocbpOraEzo9kzfMqaez1xGn4M+UvoItRolF8GcJ5
 Lb5ABzCCWqtlq9YetA/ylo87VOi5jZQ0OeDWjCCN6eUjZD3UN5294YHU5JsV3pukPmbn
 UwQuK+ORf6pBl0MbPFMru9zP/tHluHD6VwP+JZRvx8DxbG3mbpNYDXGqEx56PjaASukQ
 +w9M3i/aLWxQxgbALlSvHWJVlcFwGU90Fmpn+y/F1Zr91HMnjMYJp9LuSTuPvxOyYfZV
 Q8/N8w32ZunGU1zZtQdk753ZgRmYxuHBan81WFaRjKPpsz/4TEChkY5H5vaN1kg7hnqk
 o+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729267993; x=1729872793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/0cRfb4YBF8cPInnUDV/L7Jp4pgWglmeJbCtRCfJPQ=;
 b=au6oRU4yckc0zpfSGEcYyvQ+j4B2MLwh/7ZJtC0/2AtDWP3zJubh2d8hIANIEJl7+Y
 OnSHYlfODRCtnECTCbcX/qilYKgq1IK0qJuxVXNLSTgjuNHVjx2OV7p+C4sF5fFtlFNT
 dE4G9+++qCwjqf9UI1bln5JgDy6zhP8pN//3a5sDEm0F7UNu6S+uJI7z255Q07l9f/rd
 O1BOfGwKsAMICMLTszHUQUBYA2xKVOiqLtbb/xdI45XED0mAqjgOfwRhdlpDW6ZYeHW2
 J6ssAO6hS9H6frN+ltePIK+UKr5TVPEV3CpQvyqpIaJZr2GmccK8MezFn5IgeH4RNrtP
 edFg==
X-Gm-Message-State: AOJu0Yx/e2SY3FhCKNXIBkNfrv5/+nF4UmCxnWKf8RnXlAdTcxyOgPwd
 2UYss3kPPb6PagKmbw3xC45eCZlbDOJm0yKpf2slRQuBaxbRyHR571mYfPOItfM=
X-Google-Smtp-Source: AGHT+IHgiNaZWimN4akiargJriy+PnqMz0dQ4VKMrO8LERPUv3AnoxXaArowIO1TsiS2YWVAiX8YXQ==
X-Received: by 2002:a05:620a:2402:b0:7b1:4948:109f with SMTP id
 af79cd13be357-7b157bf13camr287097685a.57.1729267993256; 
 Fri, 18 Oct 2024 09:13:13 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 09:13:12 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, svetly.todorov@memverge.com,
 jonathan.cameron@huawei.com, nifan.cxl@gmail.com
Subject: [PATCH RFC v3 1/3] cxl-mailbox-utils: move CXLUpdateDCExtentListInPl
 into header
Date: Fri, 18 Oct 2024 12:12:50 -0400
Message-ID: <20241018161252.8896-2-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018161252.8896-1-gourry@gourry.net>
References: <20241018161252.8896-1-gourry@gourry.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Svetly Todorov <svetly.todorov@memverge.com>

Allows other CXL devices to access host DCD-add-response payload.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 16 ----------------
 include/hw/cxl/cxl_device.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 72c03d85cf..10de26605c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2446,22 +2446,6 @@ void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
     g_free(group);
 }
 
-/*
- * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
- * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
- */
-typedef struct CXLUpdateDCExtentListInPl {
-    uint32_t num_entries_updated;
-    uint8_t flags;
-    uint8_t rsvd[3];
-    /* CXL r3.1 Table 8-169: Updated Extent */
-    struct {
-        uint64_t start_dpa;
-        uint64_t len;
-        uint8_t rsvd[8];
-    } QEMU_PACKED updated_entries[];
-} QEMU_PACKED CXLUpdateDCExtentListInPl;
-
 /*
  * For the extents in the extent list to operate, check whether they are valid
  * 1. The extent should be in the range of a valid DC region;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c3e93b876a..b2dc7fb769 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -552,6 +552,22 @@ typedef struct CXLDCExtentGroup {
 } CXLDCExtentGroup;
 typedef QTAILQ_HEAD(, CXLDCExtentGroup) CXLDCExtentGroupList;
 
+/*
+ * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
+ * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
+ */
+typedef struct CXLUpdateDCExtentListInPl {
+    uint32_t num_entries_updated;
+    uint8_t flags;
+    uint8_t rsvd[3];
+    /* CXL r3.1 Table 8-169: Updated Extent */
+    struct {
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED CXLUpdateDCExtentListInPl;
+
 typedef struct CXLDCRegion {
     uint64_t base;       /* aligned to 256*MiB */
     uint64_t decode_len; /* aligned to 256*MiB */
-- 
2.43.0



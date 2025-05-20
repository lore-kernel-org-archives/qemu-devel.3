Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECFAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKn8-0006tz-4k; Tue, 20 May 2025 07:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn5-0006q3-Ua
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn3-00030f-Ly
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qOlExwNMcagvx/lGsDp7j3+eP/poXrPNaeClAqyXqw=;
 b=YkKXqCWqtrdSxyMu7ixNl6kOUKhYMoJrExSY+bOfdLZlLkHmQlkRCd2QJi2q++i+zZ9nGs
 f3v5iNOv406dk9kyZYl7E+g/rd9A1t8uHkPlOGaSYjYMrvY46zue/rt8COBOKWtymQUb94
 nHa45w8e0iURW03fTBJyV8o9+hDVwfs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-Ckl99zI5PgipzVlfyE5jzQ-1; Tue, 20 May 2025 07:05:43 -0400
X-MC-Unique: Ckl99zI5PgipzVlfyE5jzQ-1
X-Mimecast-MFC-AGG-ID: Ckl99zI5PgipzVlfyE5jzQ_1747739143
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-601803587fcso3630649a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739141; x=1748343941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qOlExwNMcagvx/lGsDp7j3+eP/poXrPNaeClAqyXqw=;
 b=Oqp6/SUgP8jjtflWBGyBQKlKRaD0ib4noVsbU7m3mARNZHk911nR74MV0SApR8Xqo3
 wcjPQrY0A4GRcz1mqPjLJnznvmmHCMM1EM3r/YaqZHT23xMwV7qmt/lUkZ61XvGDRw/T
 EZ3SniL6bYkVxAslgCsOXuH9MN5+5VVnyqtnOfDkhefSFMHS6+xAlJtjQtpb7dOnNcRh
 OjWjE/XlTkMLEgQJkPtt8ej3ZklL8j3J33j6bsLRVtwf5jMnSjdN3w/mb/dNPxhVuFSk
 ve4iyTwX48p+098Qk7FcXLqYIK2YjJ3M+0g3M52j0ecIOf0jamyIbBPt0CH6NlxAd2k3
 9Z4A==
X-Gm-Message-State: AOJu0Yyp3ulerd9/7x/KAAZ063QJVCWOagjsMXBFZdSS8dQR9VsxbDs+
 yPgH0H8zkbGPTc1bvDKWSvuSr4hRW4lHDBZeQljaflLGR9tMnzPjhsbVxKkIkrQm3kxr/IQ5Odm
 1XIEeNJOX30RyTbDttIjw2IPybKthyBTZ2LISBgoZyDhV2PvvnA+HvtUybyujXJhb4vI/RxyAbh
 /i9Rw9aufeObaFRuxTVlvMlZ5iWP0LXaMuCslwaDt3
X-Gm-Gg: ASbGncuRpHv4fO2v4n/a1m8pB5y4kD3ZEb5OM8IbSIsUD5g/rcc9zDTr4FNe3BX2Yyn
 OsvZzBjbaQ+X8L4sobyo5xE5BWC19TNAc++R8YT3tMf2bpr5Eu0izpfkIQaVpcsmO5dT3o14sft
 8HcgWsfKCcObFlnPVm2bSAblk02YCIe5bWFJSFi1H8eeZ4V0vSdg/BWben8mLSYlmgcQivL+scx
 YC7ojCEjh1ic8EQ5AEDH8iGCdagSR0lq0KrUzoa0Xa+Wiaq+HN2qYg6SgvDBQel4itZfcANuyy8
 YRfLt4P4rpSsFg==
X-Received: by 2002:a05:6402:4415:b0:5fb:f347:88cb with SMTP id
 4fb4d7f45d1cf-6008a5a9085mr14796342a12.13.1747739141250; 
 Tue, 20 May 2025 04:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYoCGRyO1J76SqiC3YI84pvxvXe2U8rLu2JYe4ub2XokJgptkyCgiaaUv/lNDku5QleGRsA==
X-Received: by 2002:a05:6402:4415:b0:5fb:f347:88cb with SMTP id
 4fb4d7f45d1cf-6008a5a9085mr14796312a12.13.1747739140693; 
 Tue, 20 May 2025 04:05:40 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d502719sm7065536a12.26.2025.05.20.04.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/35] qapi/misc-target: Rename SGXEPCSection to SgxEpcSection
Date: Tue, 20 May 2025 13:05:00 +0200
Message-ID: <20250520110530.366202-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

From: Zhao Liu <zhao1.liu@intel.com>

QAPI requires strict PascalCase naming style, i.e., only the first
letter of a single word is allowed to be uppercase, which could help
with readability.

Rename SGXEPCSection to SgxEpcSection.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250516091130.2374221-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc-target.json |  6 +++---
 hw/i386/sgx.c         | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 42e4a7417dc..a1275d3873a 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -319,7 +319,7 @@
   'if': 'TARGET_ARM' }
 
 ##
-# @SGXEPCSection:
+# @SgxEpcSection:
 #
 # Information about intel SGX EPC section info
 #
@@ -329,7 +329,7 @@
 #
 # Since: 7.0
 ##
-{ 'struct': 'SGXEPCSection',
+{ 'struct': 'SgxEpcSection',
   'data': { 'node': 'int',
             'size': 'uint64'}}
 
@@ -355,7 +355,7 @@
             'sgx1': 'bool',
             'sgx2': 'bool',
             'flc': 'bool',
-            'sections': ['SGXEPCSection']},
+            'sections': ['SgxEpcSection']},
    'if': 'TARGET_I386' }
 
 ##
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5685c4fb802..3c601689eb7 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -84,10 +84,10 @@ static uint64_t sgx_calc_section_metric(uint64_t low, uint64_t high)
            ((high & MAKE_64BIT_MASK(0, 20)) << 32);
 }
 
-static SGXEPCSectionList *sgx_calc_host_epc_sections(void)
+static SgxEpcSectionList *sgx_calc_host_epc_sections(void)
 {
-    SGXEPCSectionList *head = NULL, **tail = &head;
-    SGXEPCSection *section;
+    SgxEpcSectionList *head = NULL, **tail = &head;
+    SgxEpcSection *section;
     uint32_t i, type;
     uint32_t eax, ebx, ecx, edx;
     uint32_t j = 0;
@@ -104,7 +104,7 @@ static SGXEPCSectionList *sgx_calc_host_epc_sections(void)
             break;
         }
 
-        section = g_new0(SGXEPCSection, 1);
+        section = g_new0(SgxEpcSection, 1);
         section->node = j++;
         section->size = sgx_calc_section_metric(ecx, edx);
         QAPI_LIST_APPEND(tail, section);
@@ -183,17 +183,17 @@ SGXInfo *qmp_query_sgx_capabilities(Error **errp)
     return info;
 }
 
-static SGXEPCSectionList *sgx_get_epc_sections_list(void)
+static SgxEpcSectionList *sgx_get_epc_sections_list(void)
 {
     GSList *device_list = sgx_epc_get_device_list();
-    SGXEPCSectionList *head = NULL, **tail = &head;
-    SGXEPCSection *section;
+    SgxEpcSectionList *head = NULL, **tail = &head;
+    SgxEpcSection *section;
 
     for (; device_list; device_list = device_list->next) {
         DeviceState *dev = device_list->data;
         Object *obj = OBJECT(dev);
 
-        section = g_new0(SGXEPCSection, 1);
+        section = g_new0(SgxEpcSection, 1);
         section->node = object_property_get_uint(obj, SGX_EPC_NUMA_NODE_PROP,
                                                  &error_abort);
         section->size = object_property_get_uint(obj, SGX_EPC_SIZE_PROP,
@@ -237,7 +237,7 @@ SGXInfo *qmp_query_sgx(Error **errp)
 void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    SGXEPCSectionList *section_list, *section;
+    SgxEpcSectionList *section_list, *section;
     g_autoptr(SGXInfo) info = qmp_query_sgx(&err);
     uint64_t size = 0;
 
-- 
2.49.0



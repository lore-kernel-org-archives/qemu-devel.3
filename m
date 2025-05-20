Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A1C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnB-00078s-8m; Tue, 20 May 2025 07:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn8-0006wx-Em
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn6-00031N-Bt
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/oubsQIn5BGzqrXUUzIWldpKT0QQbTDt/12TcMjXir4=;
 b=J7qMKrOUOfXDxWw+n6MS8YSyY9u/Bd3X86MbOsbpbyJMlQv/f/l7LCjMI4espF/dFbu9ZE
 UxJv6prnyzsutM3vMFM8usgtI9i5oeP6g8hgujLpegvils3gl3lwKYD7hXb9bbGoEOXL2p
 DWddVT9aQKrjLsGp2j5Ce8ZXjh7iQBA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-kNY5N8IYOwyb_mNlJORu3w-1; Tue, 20 May 2025 07:05:46 -0400
X-MC-Unique: kNY5N8IYOwyb_mNlJORu3w-1
X-Mimecast-MFC-AGG-ID: kNY5N8IYOwyb_mNlJORu3w_1747739145
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad54ada24ffso382864266b.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739144; x=1748343944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oubsQIn5BGzqrXUUzIWldpKT0QQbTDt/12TcMjXir4=;
 b=tNQ400p9z3d1qDHvt7zMNTaWyfUljuMvGqtPuNT7UXarq08iaVEn03suW8iryJN3Sc
 8105UDfTqIvDrQ0cbq5Ri9wttlS+T6ViZeq1P7FGbR18BMki/0YEWAghYfcpZC/gjT60
 WVwXr7ytkqY4ig1w+cmRQsnuycIoIfA8YwSlvOtUUIvphJGbFSABidcfaE/DAn8m5coT
 SNFll3hp5vAxhFa8/bXG4XScyFocEg06TxoEuWG7r6+vV4oBk0fCj8AbUcPTmN9AIDOM
 9ANFkPdpXWdp2z6TicTdWl5ZHehg+2nOla0Q21VCzuzknnVIOqK+31klKMk9YJiLn6FV
 PWgg==
X-Gm-Message-State: AOJu0Ywxyt7R1tIJxSwM5QJm269WDnyyXLMXbbjeTlpkuvqG3d+TIPS/
 elEGbXc348ZdTx1TCQgRf8RR5/oKDeXRvReMwUWcNHWa7zA0/os0SYNiVUWtL241LsWDccLpJzc
 Y+pUknKnhAcrtV6CsaceR3u86Naagh61C3bKFvTdAkNLq+tpnUybqSQjv6dZLE4tIrqMBO9Y2DN
 xtkSdWaROv+yy2C3JQGehAdroTXLCeNsEaE/odVSxR
X-Gm-Gg: ASbGnct0BuL+hLptEcCyzKgDjBNMCFDG5uytB4F08TA3wvd5QRj9mhjk5EZaMIiCMsh
 XZvGc1SJj3kPRANbOt8mJ7o/+qDShfjkAGXCDzC5ALshhFmmXaedZ0nhkkaJVysHw3GcwMhhRaV
 jPzyIDlO06NJl1Mna6ceueyk6WG2cyemNMRulvSi3KKKg1EqwD6i/Hf8uXvG+svpenWbm7b4ZzW
 KKQPLRxTozMzP4ox65MfwEi6JWMRkW8IYhZBqFBR55JECfhuybVUEY+vxdkQROMs3T/Zd6or1dc
 gp3LQyX//bZX5g==
X-Received: by 2002:a17:906:c10b:b0:ad5:5e61:b091 with SMTP id
 a640c23a62f3a-ad55e61b421mr970269466b.54.1747739144340; 
 Tue, 20 May 2025 04:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8AX3ZbSwauJd4nXQfRXUCwpHLiuZs6ddJaaBik9vrqyeCNWo80ugUH5zUvAvAfFXRI2Kuxg==
X-Received: by 2002:a17:906:c10b:b0:ad5:5e61:b091 with SMTP id
 a640c23a62f3a-ad55e61b421mr970266766b.54.1747739143820; 
 Tue, 20 May 2025 04:05:43 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4c516dsm711052066b.154.2025.05.20.04.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/35] qapi/misc-target: Rename SGXInfo to SgxInfo
Date: Tue, 20 May 2025 13:05:01 +0200
Message-ID: <20250520110530.366202-7-pbonzini@redhat.com>
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

Rename SGXInfo to SgxInfo.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250516091130.2374221-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/misc-target.json | 12 ++++++------
 hw/i386/sgx-stub.c    |  4 ++--
 hw/i386/sgx.c         | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index a1275d3873a..6b3c9d8bd58 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -334,7 +334,7 @@
             'size': 'uint64'}}
 
 ##
-# @SGXInfo:
+# @SgxInfo:
 #
 # Information about intel Safe Guard eXtension (SGX) support
 #
@@ -350,7 +350,7 @@
 #
 # Since: 6.2
 ##
-{ 'struct': 'SGXInfo',
+{ 'struct': 'SgxInfo',
   'data': { 'sgx': 'bool',
             'sgx1': 'bool',
             'sgx2': 'bool',
@@ -363,7 +363,7 @@
 #
 # Returns information about SGX
 #
-# Returns: @SGXInfo
+# Returns: @SgxInfo
 #
 # Since: 6.2
 #
@@ -375,14 +375,14 @@
 #                      "sections": [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
 
 ##
 # @query-sgx-capabilities:
 #
 # Returns information from host SGX capabilities
 #
-# Returns: @SGXInfo
+# Returns: @SgxInfo
 #
 # Since: 6.2
 #
@@ -394,7 +394,7 @@
 #                      "section" : [{"node": 0, "size": 67108864},
 #                      {"node": 1, "size": 29360128}]} }
 ##
-{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
+{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
 
 
 ##
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 38ff75e9f37..ccb21a975d7 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -10,13 +10,13 @@ void sgx_epc_build_srat(GArray *table_data)
 {
 }
 
-SGXInfo *qmp_query_sgx(Error **errp)
+SgxInfo *qmp_query_sgx(Error **errp)
 {
     error_setg(errp, "SGX support is not compiled in");
     return NULL;
 }
 
-SGXInfo *qmp_query_sgx_capabilities(Error **errp)
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
 {
     error_setg(errp, "SGX support is not compiled in");
     return NULL;
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 3c601689eb7..c80203b438e 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -153,9 +153,9 @@ static void sgx_epc_reset(void *opaque)
      }
 }
 
-SGXInfo *qmp_query_sgx_capabilities(Error **errp)
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
 {
-    SGXInfo *info = NULL;
+    SgxInfo *info = NULL;
     uint32_t eax, ebx, ecx, edx;
     Error *local_err = NULL;
 
@@ -166,7 +166,7 @@ SGXInfo *qmp_query_sgx_capabilities(Error **errp)
         return NULL;
     }
 
-    info = g_new0(SGXInfo, 1);
+    info = g_new0(SgxInfo, 1);
     host_cpuid(0x7, 0, &eax, &ebx, &ecx, &edx);
 
     info->sgx = ebx & (1U << 2) ? true : false;
@@ -205,9 +205,9 @@ static SgxEpcSectionList *sgx_get_epc_sections_list(void)
     return head;
 }
 
-SGXInfo *qmp_query_sgx(Error **errp)
+SgxInfo *qmp_query_sgx(Error **errp)
 {
-    SGXInfo *info = NULL;
+    SgxInfo *info = NULL;
     X86MachineState *x86ms;
     PCMachineState *pcms =
         (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
@@ -223,7 +223,7 @@ SGXInfo *qmp_query_sgx(Error **errp)
         return NULL;
     }
 
-    info = g_new0(SGXInfo, 1);
+    info = g_new0(SgxInfo, 1);
 
     info->sgx = true;
     info->sgx1 = true;
@@ -238,7 +238,7 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     SgxEpcSectionList *section_list, *section;
-    g_autoptr(SGXInfo) info = qmp_query_sgx(&err);
+    g_autoptr(SgxInfo) info = qmp_query_sgx(&err);
     uint64_t size = 0;
 
     if (err) {
-- 
2.49.0



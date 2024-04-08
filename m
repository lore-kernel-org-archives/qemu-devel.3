Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FC3C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtubK-0002nk-3z; Mon, 08 Apr 2024 15:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubI-0002nS-Pb
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtubH-0002ga-1s
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 15:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712604254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDbDDhsWKY0Wn63jDverbc2XQYZ04EYm+iDbg78hMFo=;
 b=Sb3UdLjXbKP7/RYaOxTT5kQk9AwuzVclesjP61n1BoetiJgDL+y0VeQ14EGENW41xgXxOI
 VIjXgE2yXpKXQpn89xWLqHkHQQUJdIkJgP/nMU3Rt5W56VfHPV70BmMQYpcEmjTAR5PDVW
 JKVEYPm1YJ+wTGPhJmkenPc60uSN9Sc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-ijpWR0zGMo2ba1hCshOFkA-1; Mon, 08 Apr 2024 15:24:12 -0400
X-MC-Unique: ijpWR0zGMo2ba1hCshOFkA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4147f17da12so24030475e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 12:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712604251; x=1713209051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDbDDhsWKY0Wn63jDverbc2XQYZ04EYm+iDbg78hMFo=;
 b=GFaGvo74wYTFMIekWoGFOc8Sjf5kp37GJtJtIl57bvqIXpESqEg3E8rwJdwi8CiGNb
 cgRADwZ3cj0usHeAgQo289c9dx41HkDupKrf2U3RqasItVWeZ6zRJH8Eqg2LNnjj/VwS
 83WWoiJNXbb84eM4Kr3xyQrs+wRCuRioooBo1mlTZpD2omC8iWM99hMNTb1e3VcdIcI+
 NBJXhNLVge2dWHIR7BbfjrbmxrXqWVaQvGVGCg4QhvEd6rtUbtud11yOyP9KxqZfhMdV
 bzlNHQJqspzWa0b07Jl6BFj9zYW5M0h6l9jfePCbIcrrS1t/NNv+IrZ6VwnFpKOwOjCr
 Yxcg==
X-Gm-Message-State: AOJu0YxptUjScuHLleBK9064pNOuq4sUaOnChC+d5XCIqnNr1vPTQiDa
 7KUccdZfgQ5f1OkWXW5OPbNcMqgQa+aAdCKSCiVZt9w91xGQI+nJOaPTX0ZjIQne4FjpKvkDXhr
 lMOkvM55Tkd6RG/e7WRJ5Dfp8Rb9INNGN3LDfhInKqcm0EPlY0YSz2zUaQcZAglE+5tgenJTIV/
 Cjzf9gKu4GV0eCAIC3hsiSznZ8fjzOWdP57KYP
X-Received: by 2002:a05:600c:1d13:b0:416:644d:6dba with SMTP id
 l19-20020a05600c1d1300b00416644d6dbamr3047458wms.4.1712604250943; 
 Mon, 08 Apr 2024 12:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFREQDA6Zpt+kxW9lt/2alRaanY7mKBU+NXsDRvT7glxQ1sW+64s0aJQur6Iq/dRwbYcA9pg==
X-Received: by 2002:a05:600c:1d13:b0:416:644d:6dba with SMTP id
 l19-20020a05600c1d1300b00416644d6dbamr3047448wms.4.1712604250593; 
 Mon, 08 Apr 2024 12:24:10 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 iv9-20020a05600c548900b004162e3e5b9asm14170866wmb.44.2024.04.08.12.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 12:24:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/3] nanomips: fix warnings with GCC 14
Date: Mon,  8 Apr 2024 21:24:03 +0200
Message-ID: <20240408192404.542506-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408192404.542506-1-pbonzini@redhat.com>
References: <20240408192404.542506-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GCC 14 shows -Wshadow=local warnings if an enum conflicts with a local
variable (including a parameter).  To avoid this, move the problematic
enum and all of its dependencies after the hundreds of functions that
have a parameter named "instruction".

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/nanomips.c | 194 +++++++++++++++++++++++------------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/disas/nanomips.c b/disas/nanomips.c
index a0253598dd6..db0c297b8dc 100644
--- a/disas/nanomips.c
+++ b/disas/nanomips.c
@@ -36,35 +36,6 @@ typedef uint32_t uint32;
 typedef uint16_t uint16;
 typedef uint64_t img_address;
 
-typedef enum  {
-    instruction,
-    call_instruction,
-    branch_instruction,
-    return_instruction,
-    reserved_block,
-    pool,
-} TABLE_ENTRY_TYPE;
-
-typedef enum {
-    MIPS64_    = 0x00000001,
-    XNP_       = 0x00000002,
-    XMMS_      = 0x00000004,
-    EVA_       = 0x00000008,
-    DSP_       = 0x00000010,
-    MT_        = 0x00000020,
-    EJTAG_     = 0x00000040,
-    TLBINV_    = 0x00000080,
-    CP0_       = 0x00000100,
-    CP1_       = 0x00000200,
-    CP2_       = 0x00000400,
-    UDI_       = 0x00000800,
-    MCU_       = 0x00001000,
-    VZ_        = 0x00002000,
-    TLB_       = 0x00004000,
-    MVH_       = 0x00008000,
-    ALL_ATTRIBUTES = 0xffffffffull,
-} TABLE_ATTRIBUTE_TYPE;
-
 typedef struct Dis_info {
   img_address m_pc;
   fprintf_function fprintf_func;
@@ -72,22 +43,6 @@ typedef struct Dis_info {
   sigjmp_buf buf;
 } Dis_info;
 
-typedef bool (*conditional_function)(uint64 instruction);
-typedef char * (*disassembly_function)(uint64 instruction,
-                                            Dis_info *info);
-
-typedef struct Pool {
-    TABLE_ENTRY_TYPE     type;
-    const struct Pool    *next_table;
-    int                  next_table_size;
-    int                  instructions_size;
-    uint64               mask;
-    uint64               value;
-    disassembly_function disassembly;
-    conditional_function condition;
-    uint64               attributes;
-} Pool;
-
 #define IMGASSERTONCE(test)
 
 
@@ -544,58 +499,6 @@ static uint64 extract_op_code_value(const uint16 *data, int size)
 }
 
 
-/*
- * Recurse through tables until the instruction is found then return
- * the string and size
- *
- * inputs:
- *      pointer to a word stream,
- *      disassember table and size
- * returns:
- *      instruction size    - negative is error
- *      disassembly string  - on error will constain error string
- */
-static int Disassemble(const uint16 *data, char **dis,
-                     TABLE_ENTRY_TYPE *type, const Pool *table,
-                     int table_size, Dis_info *info)
-{
-    for (int i = 0; i < table_size; i++) {
-        uint64 op_code = extract_op_code_value(data,
-                             table[i].instructions_size);
-        if ((op_code & table[i].mask) == table[i].value) {
-            /* possible match */
-            conditional_function cond = table[i].condition;
-            if ((cond == NULL) || cond(op_code)) {
-                if (table[i].type == pool) {
-                    return Disassemble(data, dis, type,
-                                       table[i].next_table,
-                                       table[i].next_table_size,
-                                       info);
-                } else if ((table[i].type == instruction) ||
-                           (table[i].type == call_instruction) ||
-                           (table[i].type == branch_instruction) ||
-                           (table[i].type == return_instruction)) {
-                    disassembly_function dis_fn = table[i].disassembly;
-                    if (dis_fn == 0) {
-                        *dis = g_strdup(
-                            "disassembler failure - bad table entry");
-                        return -6;
-                    }
-                    *type = table[i].type;
-                    *dis = dis_fn(op_code, info);
-                    return table[i].instructions_size;
-                } else {
-                    *dis = g_strdup("reserved instruction");
-                    return -2;
-                }
-            }
-        }
-    }
-    *dis = g_strdup("failed to disassemble");
-    return -1;      /* failed to disassemble        */
-}
-
-
 static uint64 extract_code_18_to_0(uint64 instruction)
 {
     uint64 value = 0;
@@ -16213,6 +16116,51 @@ static char *YIELD(uint64 instruction, Dis_info *info)
  *
  */
 
+typedef enum  {
+    instruction,
+    call_instruction,
+    branch_instruction,
+    return_instruction,
+    reserved_block,
+    pool,
+} TABLE_ENTRY_TYPE;
+
+typedef enum {
+    MIPS64_    = 0x00000001,
+    XNP_       = 0x00000002,
+    XMMS_      = 0x00000004,
+    EVA_       = 0x00000008,
+    DSP_       = 0x00000010,
+    MT_        = 0x00000020,
+    EJTAG_     = 0x00000040,
+    TLBINV_    = 0x00000080,
+    CP0_       = 0x00000100,
+    CP1_       = 0x00000200,
+    CP2_       = 0x00000400,
+    UDI_       = 0x00000800,
+    MCU_       = 0x00001000,
+    VZ_        = 0x00002000,
+    TLB_       = 0x00004000,
+    MVH_       = 0x00008000,
+    ALL_ATTRIBUTES = 0xffffffffull,
+} TABLE_ATTRIBUTE_TYPE;
+
+typedef bool (*conditional_function)(uint64 instruction);
+typedef char * (*disassembly_function)(uint64 instruction,
+                                            Dis_info *info);
+
+typedef struct Pool {
+    TABLE_ENTRY_TYPE     type;
+    const struct Pool    *next_table;
+    int                  next_table_size;
+    int                  instructions_size;
+    uint64               mask;
+    uint64               value;
+    disassembly_function disassembly;
+    conditional_function condition;
+    uint64               attributes;
+} Pool;
+
 static const Pool P_SYSCALL[2] = {
     { instruction         , 0                   , 0   , 32,
        0xfffc0000, 0x00080000, &SYSCALL_32_      , 0,
@@ -21907,6 +21855,58 @@ static const Pool MAJOR[2] = {
        0x0                 },        /* P16 */
 };
 
+/*
+ * Recurse through tables until the instruction is found then return
+ * the string and size
+ *
+ * inputs:
+ *      pointer to a word stream,
+ *      disassember table and size
+ * returns:
+ *      instruction size    - negative is error
+ *      disassembly string  - on error will constain error string
+ */
+static int Disassemble(const uint16 *data, char **dis,
+                     TABLE_ENTRY_TYPE *type, const Pool *table,
+                     int table_size, Dis_info *info)
+{
+    for (int i = 0; i < table_size; i++) {
+        uint64 op_code = extract_op_code_value(data,
+                             table[i].instructions_size);
+        if ((op_code & table[i].mask) == table[i].value) {
+            /* possible match */
+            conditional_function cond = table[i].condition;
+            if ((cond == NULL) || cond(op_code)) {
+                if (table[i].type == pool) {
+                    return Disassemble(data, dis, type,
+                                       table[i].next_table,
+                                       table[i].next_table_size,
+                                       info);
+                } else if ((table[i].type == instruction) ||
+                           (table[i].type == call_instruction) ||
+                           (table[i].type == branch_instruction) ||
+                           (table[i].type == return_instruction)) {
+                    disassembly_function dis_fn = table[i].disassembly;
+                    if (dis_fn == 0) {
+                        *dis = g_strdup(
+                            "disassembler failure - bad table entry");
+                        return -6;
+                    }
+                    *type = table[i].type;
+                    *dis = dis_fn(op_code, info);
+                    return table[i].instructions_size;
+                } else {
+                    *dis = g_strdup("reserved instruction");
+                    return -2;
+                }
+            }
+        }
+    }
+    *dis = g_strdup("failed to disassemble");
+    return -1;      /* failed to disassemble        */
+}
+
+
 static bool nanomips_dis(const uint16_t *data, char **buf, Dis_info *info)
 {
     TABLE_ENTRY_TYPE type;
-- 
2.44.0



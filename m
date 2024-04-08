Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C66C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpxX-0007db-D2; Mon, 08 Apr 2024 10:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtpxT-0007cS-Bs
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtpxJ-0004lq-JR
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712586397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bNIMErwO49CCrP01kpy3mn1tVVv5d400fZ2DSOWNBAk=;
 b=XBPfA1CmJfzBGMjlvZThGsuGuVZcnkUOS6buRIpCxj+c1h43W6xaRsR1Nw1kh9s8w3zJQJ
 gv4B+x5EduHlT4Ci4oq9F89/RYIsXZ+GtwbUz6hkPv4Bmvh+Y6eGjipSEEKwN8jR28abTC
 mnib80cDHPoys9oJTm/NH+y9mkLqtmc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-A3Stl9fWNu2lFZd4_FG3sw-1; Mon, 08 Apr 2024 10:25:18 -0400
X-MC-Unique: A3Stl9fWNu2lFZd4_FG3sw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4165339d3a5so6982075e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712586312; x=1713191112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNIMErwO49CCrP01kpy3mn1tVVv5d400fZ2DSOWNBAk=;
 b=oGQsq/ew4a7kxngMsz24n8pO3lAa8/I5y4BOJepR+CXPXoxjnNF0crfibF8ykbtHzY
 SjLQu/0axzd7QVAgRRvFdD4Kb59yL9QSJUrxtrxywHNZWtv5roII+JHnXIXN6xZua934
 KuefyiZbzPcN8tnIuifoPjfgpUk1KmioK7baGZ54OEugZfI930+AEubCd071ZLAh5mt3
 gclTJaHlpQXJOhNxhdh3xn9RVEOrnKs3x+5cBPlCx9CfQ6yCCN9nwQ+9wSBJrlRTbQb/
 I1VAtn6pZefDI0qoDbhWcou2XMVIEavXe9Xydx5DbUJCjbA/zcGHOc4WwCWlNSQW+6Qu
 H2iQ==
X-Gm-Message-State: AOJu0YwiS7UN35MUv3VWYUMr2fnynoh26CaJI/sD6MHjDDcfJRAsjijz
 0nbMrqAAwJUhQDwmw0tsGATb/bNZ4n8F2Wf3bpUXPitWJjRzAhRP5HcoMeKuvwLzZAW3D7sF1/6
 qYR04zhCGWHxfA57ZNsw6sybggu4MMaEzovx8MRbDwrjbx8r+ZBABzAY3lzYaU3XEmn3Kh5hdkF
 AXowbMq6iUt73Ce+/ZDe6qcu8o6vr6yPMyRr1m
X-Received: by 2002:a05:600c:4f0d:b0:416:7071:6354 with SMTP id
 l13-20020a05600c4f0d00b0041670716354mr2069845wmq.18.1712586311874; 
 Mon, 08 Apr 2024 07:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8yn9yQODgncvyPd6x3nxFdlRnAdQyNcuXGgCARBgKSxBuBt3pnj87UgI+swtqiTONyLe8ZA==
X-Received: by 2002:a05:600c:4f0d:b0:416:7071:6354 with SMTP id
 l13-20020a05600c4f0d00b0041670716354mr2069825wmq.18.1712586311400; 
 Mon, 08 Apr 2024 07:25:11 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 i21-20020a05600c355500b0041665b6e111sm4839634wmq.12.2024.04.08.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 07:25:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH for-9.0] nanomips: fix warnings with GCC 14
Date: Mon,  8 Apr 2024 16:25:09 +0200
Message-ID: <20240408142509.484027-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



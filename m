Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395D606A32D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R7SJvGMe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQNd-00043r-Ru; Mon, 23 Nov 2026 04:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xVQNb-00042U-Eq
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:30:31 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1xVQNZ-0002dN-4j
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 04:30:31 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-33fb4680717so8508122eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795426227; x=1796031027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h0IF62CloKuTzAtOOCokQqZ1MKg2JQOlVAbI7smZ2GE=;
 b=R7SJvGMe1yu9KAtiIudhek9CDA4qW5tJtO0vgzhdS2pV6mb6gOXcKzv22krl4ceKSS
 /rX/+/OVYeSHTy+EOUCkYVvU8iMYnBc39ykiYxwOIiVsfqyIL/wjV2bpNHOzBKkhIjXE
 BquPjjY47bmY8zqk+w0XVnbWObY9ZbcX+7qLlKsnr011PfgtTeCQ3vD8K2t+Xk3XzV8s
 E+Ysa3+mG919jBZPlkaZhAo7bRGCqy7BghAFPY/7x5KOP7B1+YPC+4ZsEybkh29r09qz
 UR3I8E42DyFX8Pb3YgHz98yhBlJp4eRE9bJ78j+L2A3mPR69yiah421hTPjPRuEItpcx
 eqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795426227; x=1796031027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h0IF62CloKuTzAtOOCokQqZ1MKg2JQOlVAbI7smZ2GE=;
 b=MEBA8iRVsBGKcD5d996n6YkActGLu4NAGLClRCb3kOAxSpRuU7Le+7Od2WXMVelEDZ
 PYIZIcPRSoVktbcp+uS71c5IvmSwOEqmdR+50DWx4VlIb+4AeDfBcZUzuVUbJT4FSaOF
 duOckGPhPKDY0RuFL75NtzDT3dwRIrkvbhvOR6LFkoOtT3mfHwVKnQCy0ZkXt4zpCDJP
 Ay3V82NGin+jn4Gggfyfmq+C5gaYhAnc8aTsCCO7q+QaaxtZ+bi8KFaRmAfqbm5mdpI+
 qZyqtqgLRERscpP7kJlhnMNZ/Ls5BIEWhvLlMspLbvomlTbm1+0FYgdSE+No2jnG/pj+
 YRfQ==
X-Gm-Message-State: APuU4Z+dg3HDIhvG8wDziUadN68niuor8Cvpew0bHMRCDuMRDNik54yS
 VUhTvCdaRY9ARjwt8qafon72OrZVXNTTBMDFhMEHXiaR5ZxBpJpuYRbc6KrRkA==
X-Gm-Gg: AZFdTZfGc/zDgY1LmCdT+89kgcM/HBgGBUsbpCoB3GQWw4RdK1VCLMYe+oyQai1sLZ+
 xLtCp65iki6/mHwrnVQtDjk/UdPwXDxA+bTi9zNGxESVZOBE6H3rj1qeIPZVKF8ixbwUp0gyrBw
 7hyw5+BB7fYiqnf3j0VjyqBtPk1PL/XjyLmXjEXMyvKJUPostvPToVqVF00IL5QdsmqaQvnvlxU
 11R0Vab1JF2dpRYDxTtQ8gNTP2AxITHxKQ2SnHmMmdBYO0rrO9gS+Re746Psy6vxFY3SR1x0fi/
 oHMd1C5u/7b7FczUo8FuJEHTJdbiQuC4++6ua31K3jus/OmlnI2yVvwiqiAX4YJyHNOXQvVW96G
 qV+pglj+YDCZ2Nniv4E85kJSfwdLhMmsmAjHA+1qONQZzPQgU6IRVy5ueWXA7Sx1HB2j8Aerrq8
 E6qjyA8n/DZFneHR9u/0DVb6vnQTn3Ro6dv+ax/Rujfar070DRx1ZBVfkhU6S/Wt/tevO+5Uyk8
 d7+2PSDsQz9w/AufSm4sjKlrMxveVSraU23dppiUkKEjP4l8O5JzL2MJrUigefqi8Zlp2qA8JUt
 wr52lruBwNYFeje3a8e4iDOM9KfW3+SKSXER/gNvC1OH9KdX/GOx0o8SRiOVlU/RdWhidloDx1X
 MKfXWKDR4v76d/Wvi7wpaUEE8DYnOzzeUN/ecCFzTswu8BTHpUQ2ZsErJKA==
X-Received: by 2002:a05:7301:a23:b0:386:9ad5:6641 with SMTP id
 5a478bee46e88-3869ad56b0emr8090068eec.32.1795426226936; 
 Mon, 23 Nov 2026 01:30:26 -0800 (PST)
Received: from octofox.metropolis (c-67-164-4-253.hsd1.ca.comcast.net.
 [67.164.4.253]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm43231128eec.5.2026.11.23.01.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 01:30:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] target/xtensa: constify internal pointers in xtensa-isa
Date: Mon, 23 Nov 2026 01:29:55 -0800
Message-ID: <20261123092955.84910-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.993, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Constify pointers to immutable data in structures defined in
xtensa-isa-internal.h. Constify users of these pointers. Add const to
the return value of the public function xtensa_opcode_funcUnit_use() to
keep const correctness.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 include/hw/xtensa/xtensa-isa.h      |  4 +--
 target/xtensa/xtensa-isa-internal.h | 36 ++++++++++-----------
 target/xtensa/xtensa-isa.c          | 50 ++++++++++++++---------------
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
index a289531bdc8e..899e63ccb6e3 100644
--- a/include/hw/xtensa/xtensa-isa.h
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -437,8 +437,8 @@ typedef struct xtensa_funcUnit_use_struct {
 
 int xtensa_opcode_num_funcUnit_uses(xtensa_isa isa, xtensa_opcode opc);
 
-xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
-                                                xtensa_opcode opc, int u);
+const xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
+                                                      xtensa_opcode opc, int u);
 
 
 
diff --git a/target/xtensa/xtensa-isa-internal.h b/target/xtensa/xtensa-isa-internal.h
index 40dd8bac96ee..b05be7f8cf9e 100644
--- a/target/xtensa/xtensa-isa-internal.h
+++ b/target/xtensa/xtensa-isa-internal.h
@@ -66,7 +66,7 @@ typedef struct xtensa_format_internal_struct {
     int length;                 /* Instruction length in bytes. */
     xtensa_format_encode_fn encode_fn;
     int num_slots;
-    int *slot_id;               /* Array[num_slots] of slot IDs. */
+    const int *slot_id;         /* Array[num_slots] of slot IDs. */
 } xtensa_format_internal;
 
 typedef struct xtensa_slot_internal_struct {
@@ -75,8 +75,8 @@ typedef struct xtensa_slot_internal_struct {
     int position;
     xtensa_get_slot_fn get_fn;
     xtensa_set_slot_fn set_fn;
-    xtensa_get_field_fn *get_field_fns; /* Array[field_id]. */
-    xtensa_set_field_fn *set_field_fns; /* Array[field_id]. */
+    const xtensa_get_field_fn *get_field_fns; /* Array[field_id]. */
+    const xtensa_set_field_fn *set_field_fns; /* Array[field_id]. */
     xtensa_opcode_decode_fn opcode_decode_fn;
     const char *nop_name;
 } xtensa_slot_internal;
@@ -103,22 +103,22 @@ typedef struct xtensa_arg_internal_struct {
 
 typedef struct xtensa_iclass_internal_struct {
     int num_operands;           /* Size of "operands" array. */
-    xtensa_arg_internal *operands;          /* Array[num_operands]. */
+    const xtensa_arg_internal *operands;        /* Array[num_operands]. */
 
     int num_stateOperands;      /* Size of "stateOperands" array. */
-    xtensa_arg_internal *stateOperands;     /* Array[num_stateOperands]. */
+    const xtensa_arg_internal *stateOperands;   /* Array[num_stateOperands]. */
 
     int num_interfaceOperands;  /* Size of "interfaceOperands". */
-    xtensa_interface *interfaceOperands;    /* Array[num_interfaceOperands]. */
+    const xtensa_interface *interfaceOperands;  /* Array[num_interfaceOperands]. */
 } xtensa_iclass_internal;
 
 typedef struct xtensa_opcode_internal_struct {
     const char *name;           /* Opcode mnemonic. */
     int iclass_id;              /* Iclass for this opcode. */
     uint32_t flags;             /* See XTENSA_OPCODE_* flags. */
-    xtensa_opcode_encode_fn *encode_fns;    /* Array[slot_id]. */
+    const xtensa_opcode_encode_fn *encode_fns;  /* Array[slot_id]. */
     int num_funcUnit_uses;      /* Number of funcUnit_use entries. */
-    xtensa_funcUnit_use *funcUnit_uses;     /* Array[num_funcUnit_uses]. */
+    const xtensa_funcUnit_use *funcUnit_uses;   /* Array[num_funcUnit_uses]. */
 } xtensa_opcode_internal;
 
 typedef struct xtensa_regfile_internal_struct {
@@ -171,34 +171,34 @@ typedef struct xtensa_isa_internal_struct {
     int insnbuf_size;           /* Number of insnbuf_words. */
 
     int num_formats;
-    xtensa_format_internal *formats;
+    const xtensa_format_internal *formats;
     xtensa_format_decode_fn format_decode_fn;
     xtensa_length_decode_fn length_decode_fn;
 
     int num_slots;
-    xtensa_slot_internal *slots;
+    const xtensa_slot_internal *slots;
 
     int num_fields;
 
     int num_operands;
-    xtensa_operand_internal *operands;
+    const xtensa_operand_internal *operands;
 
     int num_iclasses;
-    xtensa_iclass_internal *iclasses;
+    const xtensa_iclass_internal *iclasses;
 
     int num_opcodes;
-    xtensa_opcode_internal *opcodes;
+    const xtensa_opcode_internal *opcodes;
     xtensa_lookup_entry *opname_lookup_table;
 
     int num_regfiles;
-    xtensa_regfile_internal *regfiles;
+    const xtensa_regfile_internal *regfiles;
 
     int num_states;
-    xtensa_state_internal *states;
+    const xtensa_state_internal *states;
     xtensa_lookup_entry *state_lookup_table;
 
     int num_sysregs;
-    xtensa_sysreg_internal *sysregs;
+    const xtensa_sysreg_internal *sysregs;
     xtensa_lookup_entry *sysreg_lookup_table;
 
     /*
@@ -213,11 +213,11 @@ typedef struct xtensa_isa_internal_struct {
     xtensa_sysreg *sysreg_table[2];
 
     int num_interfaces;
-    xtensa_interface_internal *interfaces;
+    const xtensa_interface_internal *interfaces;
     xtensa_lookup_entry *interface_lookup_table;
 
     int num_funcUnits;
-    xtensa_funcUnit_internal *funcUnits;
+    const xtensa_funcUnit_internal *funcUnits;
     xtensa_lookup_entry *funcUnit_lookup_table;
 
     int num_stages;             /* Number of pipe stages. */
diff --git a/target/xtensa/xtensa-isa.c b/target/xtensa/xtensa-isa.c
index c564af340fa9..2f5d21f05815 100644
--- a/target/xtensa/xtensa-isa.c
+++ b/target/xtensa/xtensa-isa.c
@@ -280,7 +280,7 @@ xtensa_isa xtensa_isa_init(void *xtensa_modules, xtensa_isa_status *errno_p,
         }
     }
     for (n = 0; n < isa->num_sysregs; n++) {
-        xtensa_sysreg_internal *sreg = &isa->sysregs[n];
+        const xtensa_sysreg_internal *sreg = &isa->sysregs[n];
         is_user = sreg->is_user;
 
         if (sreg->number >= 0) {
@@ -391,7 +391,7 @@ int xtensa_isa_length_from_chars(xtensa_isa isa, const unsigned char *cp)
 int xtensa_isa_num_pipe_stages(xtensa_isa isa)
 {
     xtensa_opcode opcode;
-    xtensa_funcUnit_use *use;
+    const xtensa_funcUnit_use *use;
     int num_opcodes, num_uses;
     int i, stage, max_stage;
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
@@ -801,8 +801,8 @@ int xtensa_opcode_num_funcUnit_uses(xtensa_isa isa, xtensa_opcode opc)
 }
 
 
-xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
-                                                xtensa_opcode opc, int u)
+const xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
+                                                      xtensa_opcode opc, int u)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
 
@@ -833,10 +833,10 @@ xtensa_funcUnit_use *xtensa_opcode_funcUnit_use(xtensa_isa isa,
     } while (0)
 
 
-static xtensa_operand_internal *get_operand(xtensa_isa_internal *intisa,
-                                            xtensa_opcode opc, int opnd)
+static const xtensa_operand_internal *get_operand(xtensa_isa_internal *intisa,
+                                                  xtensa_opcode opc, int opnd)
 {
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id, operand_id;
 
     CHECK_OPCODE(intisa, opc, NULL);
@@ -851,7 +851,7 @@ static xtensa_operand_internal *get_operand(xtensa_isa_internal *intisa,
 const char *xtensa_operand_name(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -864,9 +864,9 @@ const char *xtensa_operand_name(xtensa_isa isa, xtensa_opcode opc, int opnd)
 int xtensa_operand_is_visible(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id, operand_id;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
     iclass_id = intisa->opcodes[opc].iclass_id;
@@ -891,7 +891,7 @@ int xtensa_operand_is_visible(xtensa_isa isa, xtensa_opcode opc, int opnd)
 char xtensa_operand_inout(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id;
     char inout;
 
@@ -917,7 +917,7 @@ int xtensa_operand_get_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
                              const xtensa_insnbuf slotbuf, uint32_t *valp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
     int slot_id;
     xtensa_get_field_fn get_fn;
 
@@ -953,7 +953,7 @@ int xtensa_operand_set_field(xtensa_isa isa, xtensa_opcode opc, int opnd,
                              xtensa_insnbuf slotbuf, uint32_t val)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
     int slot_id;
     xtensa_set_field_fn set_fn;
 
@@ -988,7 +988,7 @@ int xtensa_operand_encode(xtensa_isa isa, xtensa_opcode opc, int opnd,
                           uint32_t *valp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
     uint32_t test_val, orig_val;
 
     intop = get_operand(intisa, opc, opnd);
@@ -1062,7 +1062,7 @@ int xtensa_operand_decode(xtensa_isa isa, xtensa_opcode opc, int opnd,
                           uint32_t *valp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1086,7 +1086,7 @@ int xtensa_operand_decode(xtensa_isa isa, xtensa_opcode opc, int opnd,
 int xtensa_operand_is_register(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1104,7 +1104,7 @@ xtensa_regfile xtensa_operand_regfile(xtensa_isa isa, xtensa_opcode opc,
                                       int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1118,7 +1118,7 @@ xtensa_regfile xtensa_operand_regfile(xtensa_isa isa, xtensa_opcode opc,
 int xtensa_operand_num_regs(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1132,7 +1132,7 @@ int xtensa_operand_num_regs(xtensa_isa isa, xtensa_opcode opc, int opnd)
 int xtensa_operand_is_known_reg(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1149,7 +1149,7 @@ int xtensa_operand_is_known_reg(xtensa_isa isa, xtensa_opcode opc, int opnd)
 int xtensa_operand_is_PCrelative(xtensa_isa isa, xtensa_opcode opc, int opnd)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1167,7 +1167,7 @@ int xtensa_operand_do_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
                             uint32_t *valp, uint32_t pc)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1199,7 +1199,7 @@ int xtensa_operand_undo_reloc(xtensa_isa isa, xtensa_opcode opc, int opnd,
                               uint32_t *valp, uint32_t pc)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_operand_internal *intop;
+    const xtensa_operand_internal *intop;
 
     intop = get_operand(intisa, opc, opnd);
     if (!intop) {
@@ -1247,7 +1247,7 @@ xtensa_state xtensa_stateOperand_state(xtensa_isa isa, xtensa_opcode opc,
                                        int stOp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id;
 
     CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
@@ -1261,7 +1261,7 @@ xtensa_state xtensa_stateOperand_state(xtensa_isa isa, xtensa_opcode opc,
 char xtensa_stateOperand_inout(xtensa_isa isa, xtensa_opcode opc, int stOp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id;
 
     CHECK_OPCODE(intisa, opc, 0);
@@ -1294,7 +1294,7 @@ xtensa_interface xtensa_interfaceOperand_interface(xtensa_isa isa,
                                                    int ifOp)
 {
     xtensa_isa_internal *intisa = (xtensa_isa_internal *)isa;
-    xtensa_iclass_internal *iclass;
+    const xtensa_iclass_internal *iclass;
     int iclass_id;
 
     CHECK_OPCODE(intisa, opc, XTENSA_UNDEFINED);
-- 
2.47.3



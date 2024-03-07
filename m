Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E008C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4MB-0001Tf-4C; Wed, 06 Mar 2024 22:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M9-0001TJ-Co
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:41 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M7-0005ji-JN
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:41 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-21f3a4ba205so166021fac.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781817; x=1710386617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U46l8139A+4KRjWcCLYKQaeKeiOnLqLqKh4dYSCOgv0=;
 b=eNAqIRU/zVGgMQC1Az+Beqf0jCqIEY3FDRkh0H9VAhHYyck3uGEScnZ9lIqom1a8P5
 c6Jz0dMgE8TY5NErI9zs9LqDO2/Q+7uiBHG0SXPmlc8k1zMy1dUqpklTOB3ABn0WmCdU
 KsiMy0jM3M++LTqnQHkCd1M4RrO9bRjVxeakUFLW59CJSJBab4D7QpeWnrgotQRJ5xa5
 cBUfbghkBctDvc3/qmPoIpjANGby9WZpmS+Ue39DUyexJsSKncVHzFOMpdOfhJ5UP2+G
 AbKCKQgLst8vkEzA73h/5Lfk0kWOJM8/WmBazjRhc+zaRVphQiZKYVXhvfxXVFm6W6bu
 +I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781817; x=1710386617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U46l8139A+4KRjWcCLYKQaeKeiOnLqLqKh4dYSCOgv0=;
 b=gF31pQRKEEi4iHJs8mOuyu4zHLEQkqYlfNt0euk4Bu253KEzYbWUf5ovFEiDZNRD0e
 dnWgkSkMb2SLy3PWmohZkQpFOSbM7zI16Ob18pbj/2EjoAhFnUxxHA0ssVKnimfUSqFJ
 yzeUMYBHLSDIswxjTyj8ZF7W5rZCqpLX2jkClp91VYKQceCKFq7HwqCdDaywNW2zOu7G
 9hAW7PIMpxEczXs8vXhR5invh2xz/92gbJmk/2orDoSq/0vdQH+2JJznynSoG/xSDSR3
 5ZX2vwMuThPNoAOhhS1WpvkicCnvOTm7IjH+avB0ujBphvYGosUITq6RZ3PZ+AeEN/ZJ
 haog==
X-Gm-Message-State: AOJu0YyFPAmveTrhjvLxVxl75pP3q74ZsOAphDSggraI/H6dg+jCsv81
 TBQEKyy8EcLEaBOshIAGEOxq9t2xyJYnEav+EKCU9ZDZeg/LFay6zGuCw5YwQt8=
X-Google-Smtp-Source: AGHT+IHRKajcx9dcZRRaAWHLoYhTZ7Cd6KlsDgKJgxZwEny+8Ebo76gwgisGMG7EV9jVoTZqn7gveA==
X-Received: by 2002:a05:6870:889:b0:221:38c0:3f0a with SMTP id
 fx9-20020a056870088900b0022138c03f0amr6649970oab.35.1709781817225; 
 Wed, 06 Mar 2024 19:23:37 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:36 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 6/9] Hexagon (target/hexagon) Remove uses of
 op_regs_generated.h.inc
Date: Wed,  6 Mar 2024 20:23:24 -0700
Message-Id: <20240307032327.4799-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/opcodes.h                |  4 --
 target/hexagon/decode.c                 | 57 +++----------------------
 target/hexagon/mmvec/decode_ext_mmvec.c | 34 +++------------
 target/hexagon/opcodes.c                | 28 ------------
 4 files changed, 13 insertions(+), 110 deletions(-)

diff --git a/target/hexagon/opcodes.h b/target/hexagon/opcodes.h
index fa7e321950..0ee11bd445 100644
--- a/target/hexagon/opcodes.h
+++ b/target/hexagon/opcodes.h
@@ -40,10 +40,6 @@ typedef enum {
 
 extern const char * const opcode_names[];
 
-extern const char * const opcode_reginfo[];
-extern const char * const opcode_rregs[];
-extern const char * const opcode_wregs[];
-
 typedef struct {
     const char * const encoding;
     const EncClass enc_class;
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 84a3899556..23deba2426 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -115,24 +115,13 @@ static void
 decode_fill_newvalue_regno(Packet *packet)
 {
     int i, use_regidx, offset, def_idx, dst_idx;
-    uint16_t def_opcode, use_opcode;
-    char *dststr;
 
     for (i = 1; i < packet->num_insns; i++) {
         if (GET_ATTRIB(packet->insn[i].opcode, A_DOTNEWVALUE) &&
             !GET_ATTRIB(packet->insn[i].opcode, A_EXTENSION)) {
-            use_opcode = packet->insn[i].opcode;
-
-            /* It's a store, so we're adjusting the Nt field */
-            if (GET_ATTRIB(use_opcode, A_STORE)) {
-                use_regidx = strchr(opcode_reginfo[use_opcode], 't') -
-                    opcode_reginfo[use_opcode];
-            } else {    /* It's a Jump, so we're adjusting the Ns field */
-                use_regidx = strchr(opcode_reginfo[use_opcode], 's') -
-                    opcode_reginfo[use_opcode];
-            }
-            g_assert(packet->insn[i].new_read_idx != -1 &&
-                     packet->insn[i].new_read_idx == use_regidx);
+
+            g_assert(packet->insn[i].new_read_idx != -1);
+            use_regidx = packet->insn[i].new_read_idx;
 
             /*
              * What's encoded at the N-field is the offset to who's producing
@@ -153,39 +142,9 @@ decode_fill_newvalue_regno(Packet *packet)
              */
             g_assert(!((def_idx < 0) || (def_idx > (packet->num_insns - 1))));
 
-            /*
-             * packet->insn[def_idx] is the producer
-             * Figure out which type of destination it produces
-             * and the corresponding index in the reginfo
-             */
-            def_opcode = packet->insn[def_idx].opcode;
-            dststr = strstr(opcode_wregs[def_opcode], "Rd");
-            if (dststr) {
-                dststr = strchr(opcode_reginfo[def_opcode], 'd');
-            } else {
-                dststr = strstr(opcode_wregs[def_opcode], "Rx");
-                if (dststr) {
-                    dststr = strchr(opcode_reginfo[def_opcode], 'x');
-                } else {
-                    dststr = strstr(opcode_wregs[def_opcode], "Re");
-                    if (dststr) {
-                        dststr = strchr(opcode_reginfo[def_opcode], 'e');
-                    } else {
-                        dststr = strstr(opcode_wregs[def_opcode], "Ry");
-                        if (dststr) {
-                            dststr = strchr(opcode_reginfo[def_opcode], 'y');
-                        } else {
-                            g_assert_not_reached();
-                        }
-                    }
-                }
-            }
-            g_assert(dststr != NULL);
-
             /* Now patch up the consumer with the register number */
-            dst_idx = dststr - opcode_reginfo[def_opcode];
-            g_assert(packet->insn[def_idx].dest_idx != -1 &&
-                     packet->insn[def_idx].dest_idx == dst_idx);
+            g_assert(packet->insn[def_idx].dest_idx != -1);
+            dst_idx = packet->insn[def_idx].dest_idx;
             packet->insn[i].regno[use_regidx] =
                 packet->insn[def_idx].regno[dst_idx];
             /*
@@ -366,11 +325,7 @@ static void decode_shuffle_for_execution(Packet *packet)
         for (flag = false, i = 0; i < last_insn + 1; i++) {
             int opcode = packet->insn[i].opcode;
 
-            g_assert(packet->insn[i].has_pred_dest ==
-                     (strstr(opcode_wregs[opcode], "Pd4") ||
-                      strstr(opcode_wregs[opcode], "Pe4")));
-            if ((strstr(opcode_wregs[opcode], "Pd4") ||
-                 strstr(opcode_wregs[opcode], "Pe4")) &&
+            if (packet->insn[i].has_pred_dest &&
                 GET_ATTRIB(opcode, A_STORE) == 0) {
                 /* This should be a compare (not a store conditional) */
                 if (flag) {
diff --git a/target/hexagon/mmvec/decode_ext_mmvec.c b/target/hexagon/mmvec/decode_ext_mmvec.c
index c1320406df..f850d0154d 100644
--- a/target/hexagon/mmvec/decode_ext_mmvec.c
+++ b/target/hexagon/mmvec/decode_ext_mmvec.c
@@ -28,21 +28,15 @@ check_new_value(Packet *pkt)
 {
     /* .new value for a MMVector store */
     int i, j;
-    const char *reginfo;
-    const char *destletters;
-    const char *dststr = NULL;
     uint16_t def_opcode;
-    char letter;
 
     for (i = 1; i < pkt->num_insns; i++) {
         uint16_t use_opcode = pkt->insn[i].opcode;
         if (GET_ATTRIB(use_opcode, A_DOTNEWVALUE) &&
             GET_ATTRIB(use_opcode, A_CVI) &&
             GET_ATTRIB(use_opcode, A_STORE)) {
-            int use_regidx = strchr(opcode_reginfo[use_opcode], 's') -
-                opcode_reginfo[use_opcode];
-            g_assert(pkt->insn[i].new_read_idx != -1 &&
-                     pkt->insn[i].new_read_idx == use_regidx);
+            int use_regidx = pkt->insn[i].new_read_idx;
+            g_assert(pkt->insn[i].new_read_idx != -1);
             /*
              * What's encoded at the N-field is the offset to who's producing
              * the value.
@@ -70,33 +64,19 @@ check_new_value(Packet *pkt)
 
             /* def_idx is the index of the producer */
             def_opcode = pkt->insn[def_idx].opcode;
-            reginfo = opcode_reginfo[def_opcode];
-            destletters = "dexy";
-            for (j = 0; (letter = destletters[j]) != 0; j++) {
-                dststr = strchr(reginfo, letter);
-                if (dststr != NULL) {
-                    break;
-                }
-            }
-            if ((dststr == NULL)  && GET_ATTRIB(def_opcode, A_CVI_GATHER)) {
+            if ((pkt->insn[def_idx].dest_idx == -1)  &&
+                GET_ATTRIB(def_opcode, A_CVI_GATHER)) {
                 pkt->insn[i].regno[use_regidx] = def_oreg;
                 pkt->insn[i].new_value_producer_slot = pkt->insn[def_idx].slot;
             } else {
-                if (dststr == NULL) {
+                if (pkt->insn[def_idx].dest_idx == -1) {
                     /* still not there, we have a bad packet */
                     g_assert_not_reached();
                 }
-                g_assert(pkt->insn[def_idx].dest_idx != -1 &&
-                         pkt->insn[def_idx].dest_idx == dststr - reginfo);
-                int def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
+                int def_regnum =
+                    pkt->insn[def_idx].regno[pkt->insn[def_idx].dest_idx];
                 /* Now patch up the consumer with the register number */
                 pkt->insn[i].regno[use_regidx] = def_regnum ^ def_oreg;
-                /* special case for (Vx,Vy) */
-                dststr = strchr(reginfo, 'y');
-                if (def_oreg && strchr(reginfo, 'x') && dststr) {
-                    def_regnum = pkt->insn[def_idx].regno[dststr - reginfo];
-                    pkt->insn[i].regno[use_regidx] = def_regnum;
-                }
                 /*
                  * We need to remember who produces this value to later
                  * check if it was dynamically cancelled
diff --git a/target/hexagon/opcodes.c b/target/hexagon/opcodes.c
index 1f7f3def38..02ae9cf787 100644
--- a/target/hexagon/opcodes.c
+++ b/target/hexagon/opcodes.c
@@ -36,34 +36,6 @@ const char * const opcode_names[] = {
 #undef OPCODE
 };
 
-const char * const opcode_reginfo[] = {
-#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
-#define REGINFO(TAG, REGINFO, RREGS, WREGS) REGINFO,
-#include "op_regs_generated.h.inc"
-    NULL
-#undef REGINFO
-#undef IMMINFO
-};
-
-
-const char * const opcode_rregs[] = {
-#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
-#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
-#include "op_regs_generated.h.inc"
-    NULL
-#undef REGINFO
-#undef IMMINFO
-};
-
-
-const char * const opcode_wregs[] = {
-#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
-#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
-#include "op_regs_generated.h.inc"
-    NULL
-#undef REGINFO
-#undef IMMINFO
-};
 
 const char * const opcode_short_semantics[] = {
 #define DEF_SHORTCODE(TAG, SHORTCODE)              [TAG] = #SHORTCODE,
-- 
2.34.1



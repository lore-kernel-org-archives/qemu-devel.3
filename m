Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9525CA100E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzr-0006qy-HV; Mon, 01 Sep 2025 23:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzp-0006ot-Jk
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzm-0004Tl-Nf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SKpT025556
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bXOYi8iAS5C0z9QpXZYNZrW4sw+vX27RxmMAI6y6g8A=; b=eElxdme9GZmjtLjp
 I8L+V1dJ6uYrvoiMOwGv7zAlSMs2t0cdZrlCCROXoLdMcxrcDAnde3pRyKYP8BCP
 3BZF8sEANFKXGGKGu52UfQxAthMFwgjUecQTx0Gf7Yh5W8nviCx+TSo0N34MMLY/
 Jotz2r71/ZPvS4GCswqdAW3LlZJhDilPyltZyuAXw25uqMzk6mXw2H5a+Z6liVgC
 K4KCfAzLGZVdlPfQ5o1xsj13+mWMHxWUxMe5erGAJkZxioY20vJuPqn4wgyv4Anu
 c2dh18IidrijOe5WdGpSMYlNQEX0mZXbiKnXV5f3RTr2FJtqa4JENv6C+whRLCH/
 yfCLWg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxe6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-327594fd627so5027695a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784864; x=1757389664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXOYi8iAS5C0z9QpXZYNZrW4sw+vX27RxmMAI6y6g8A=;
 b=L3JQYkN3pR/HTgT6Y5k6hBDWv5l4eXJwRh3XvT3ep2PpTQnbjin3+nlHEpRIWpwqer
 4D/2FDdeeY1GtvOO7YdZw3Z9JOYOLT03Vdh5ACZrTeuQOA4oKi1XPvr9pnRGa9i3/xce
 5u8dkJc9xBOMZT7IHxuSmXzPXqZW9uODQGG5tWens7ZUo6r4U1E4KEWsuHp82tUoWgea
 9CdhizmoJJ6NFNCoZ4gWDs6lPJi2ElmoSr2pc/zJHhax9OoE8FrCK/DOStMvlEha9Ezp
 gfRel7E/z0tocMt+sQw+DtWCUHWAaLOGFD2NT6/0Ag8eyxm1WeF6Z9Kxz18QXezo49E4
 CoJA==
X-Gm-Message-State: AOJu0YwK5Aeo1truyMSXYy3K9ghHPq4yDqjPFpQG4Nn/SxzUTo2SjYlS
 Ug2+UFW4MzXQOkuEzegxYaQxSsvDySRLiYyZ2pNmAvQdlEGUtDXbJ97nzEFgyN+cDDxGuBZsAms
 xibc/zGGWXZhwgDu4W+EF0q+Seqd3PpEexzZxqW1gOk6/0dBHRAxJD3/J93ZLW3ccyOB9
X-Gm-Gg: ASbGnctE4i0rlEhhMsu2jTxeBI9GBtz0Zo6E+TwB+nmF56pjLWTjFIV5QDQAq1sIiJt
 5jvVEV7i67mr7w8HIbiPaTuu/o4OngoPpaC6kQlzNIJMxChllaMjj/yBBpZbWxo5ZLikcjzDRV5
 H7V8sqXstGZGrtDapuFMMSCiXMbP+igStjo5v/X/EH6XOE6Dxw/kjMZIbClnUU3EnOp3Qjol3BR
 lfsi5Myk47QKmJ6zi04UkscscCQUXmZCDPGW3/cgsUfc8fZsT3zO5emV1HpDbEXvR+CrdH22I6K
 sEOjEC48ahzDAvRt/zyPztwhjV6+IUh4mxEGIqMnIvUJGEZgXyTWG6oAy51tcd1U2ZqdXjG/0nw
 5e5Z6qi7GHhU7
X-Received: by 2002:a17:90a:e7cc:b0:327:dce5:f644 with SMTP id
 98e67ed59e1d1-32815436034mr12726894a91.11.1756784864240; 
 Mon, 01 Sep 2025 20:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPJGleTnbtJzITfmYs9WL9msDmN9r09NTzpZ9pjJjjziBfS8UjoB2RacwalyFuBJZKWOoPvQ==
X-Received: by 2002:a17:90a:e7cc:b0:327:dce5:f644 with SMTP id
 98e67ed59e1d1-32815436034mr12726857a91.11.1756784863699; 
 Mon, 01 Sep 2025 20:47:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 18/40] target/hexagon: Add new macro definitions for sysemu
Date: Mon,  1 Sep 2025 20:46:53 -0700
Message-Id: <20250902034715.1947718-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX0jAAsEP9mA92
 m+Tl50ubWl2AE3s7dEYcERma/Vj9LEeeZSnX1tXG+qNcTRHKw1KweB/3/eXRVbEIXnhGfXfv2lX
 anCL1Rb1m/a2RPi9usDkOCni4+4FUgmsQJ2Rml97EQLzvRRKb51Q9RT0jStkAtqJJiWOKb1Vd3+
 hxZv9E0Uxph7dUsniDrnaIs3rFAN98fgWKuFYXaUAB6LSiWIBy3tjftyJkgPCU/ikOH/IQh4/BQ
 4FERZEO8FfRZ65kY+rVTiP/Ngaj5kvUkEy4lgjrKL/+7c4gKKT6sZOyftMAg7DQiAR86pHIZRTT
 xdjjdNEMAJptzR3TSsScVzWPRxhVtUxvRtWnV8pht96WRQxZW/E+51NXonoTO3geSLocdd5lYZz
 i9YG4mQW
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b668e1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=H-6vKWyFFGuCzvjpqwAA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SXo4E8s4e7LUQrd9ocOP1RGoEtqtSLWs
X-Proofpoint-GUID: SXo4E8s4e7LUQrd9ocOP1RGoEtqtSLWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

From: Brian Cain <bcain@quicinc.com>

Also: add nop TCG overrides for break,unpause,fetchbo,dczeroa

break: this hardware breakpoint instruction is used with the in-silicon
debugger feature, this is not modeled.

unpause: this instruction is used to resume hardware threads that are
stalled by pause instructions.  pause is modeled as a nop, or in RR
mode as an EXCP_YIELD.  This instruction is safe to ignore.

Since cache/prefetch functions are not modeled, dczero and fetchbo are
safe to ignore.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h    |   9 ++
 target/hexagon/macros.h     |  30 ++++-
 target/hexagon/sys_macros.h | 238 ++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  |   1 +
 4 files changed, 274 insertions(+), 4 deletions(-)
 create mode 100644 target/hexagon/sys_macros.h

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 8a3b801287..71f8a0e2d0 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -488,6 +488,7 @@
 
 /* dczeroa clears the 32 byte cache line at the address given */
 #define fGEN_TCG_Y2_dczeroa(SHORTCODE) SHORTCODE
+#define fGEN_TCG_Y2_dczeroa_nt(SHORTCODE) SHORTCODE
 
 /* In linux-user mode, these are not modelled, suppress compiler warning */
 #define fGEN_TCG_Y2_dcinva(SHORTCODE) \
@@ -1133,6 +1134,9 @@
                            RdV, tcg_constant_tl(0)); \
     } while (0)
 
+#define fGEN_TCG_Y2_break(SHORTCODE)
+#define fGEN_TCG_J2_unpause(SHORTCODE)
+
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
@@ -1342,6 +1346,11 @@
         RsV = RsV; \
         uiV = uiV; \
     } while (0)
+#define fGEN_TCG_Y2_dcfetchbo_nt(SHORTCODE) \
+    do { \
+        RsV = RsV; \
+        uiV = uiV; \
+    } while (0)
 
 #define fGEN_TCG_L2_loadw_aq(SHORTCODE)                 SHORTCODE
 #define fGEN_TCG_L4_loadd_aq(SHORTCODE)                 SHORTCODE
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 9ba9be408d..4823c97fde 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -538,9 +538,6 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 
 #ifdef CONFIG_USER_ONLY
 #define fFRAMECHECK(ADDR, EA) do { } while (0) /* Not modelled in linux-user */
-#else
-/* System mode not implemented yet */
-#define fFRAMECHECK(ADDR, EA)  g_assert_not_reached();
 #endif
 
 #ifdef QEMU_GENERATE
@@ -631,8 +628,18 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #define fCONSTLL(A) A##LL
 #define fECHO(A) (A)
 
-#define fTRAP(TRAPTYPE, IMM) helper_raise_exception(env, HEX_EXCP_TRAP0)
+#ifdef CONFIG_USER_ONLY
+#define fTRAP(TRAPTYPE, IMM) \
+    do { \
+        hexagon_raise_exception_err(env, HEX_EVENT_TRAP0, PC); \
+    } while (0)
+#endif
+
+#define fDO_TRACE(SREG)
+#define fBREAK()
+#define fUNPAUSE()
 #define fPAUSE(IMM)
+#define fDCFETCH(REG)
 
 #define fALIGN_REG_FIELD_VALUE(FIELD, VAL) \
     ((VAL) << reg_field_info[FIELD].offset)
@@ -649,10 +656,25 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
         ctx->dczero_addr = tcg_temp_new(); \
         tcg_gen_mov_tl(ctx->dczero_addr, (REG)); \
     } while (0)
+#else
+#define fDCZEROA(REG) ((void) REG)
 #endif
 
 #define fBRANCH_SPECULATE_STALL(DOTNEWVAL, JUMP_COND, SPEC_DIR, HINTBITNUM, \
                                 STRBITNUM) /* Nothing */
 
+#ifdef CONFIG_USER_ONLY
+/*
+ * This macro can only be true in guest mode.
+ * In user mode, the 4 VIRTINSN's can't be reached
+ */
+#define fTRAP1_VIRTINSN(IMM)       (false)
+#define fVIRTINSN_SPSWAP(IMM, REG) g_assert_not_reached()
+#define fVIRTINSN_GETIE(IMM, REG)  g_assert_not_reached()
+#define fVIRTINSN_SETIE(IMM, REG)  g_assert_not_reached()
+#define fVIRTINSN_RTE(IMM, REG)    g_assert_not_reached()
+#endif
 
 #endif
+
+#define fPREDUSE_TIMING()
diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
new file mode 100644
index 0000000000..3c4c3c7aa5
--- /dev/null
+++ b/target/hexagon/sys_macros.h
@@ -0,0 +1,238 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_SYS_MACROS_H
+#define HEXAGON_SYS_MACROS_H
+
+/*
+ * Macro definitions for Hexagon system mode
+ */
+
+#ifndef CONFIG_USER_ONLY
+
+#define READ_SREG(NUM) arch_get_system_reg(env, NUM)
+#define READ_SGP0()    arch_get_system_reg(env, HEX_SREG_SGP0)
+#define READ_SGP1()    arch_get_system_reg(env, HEX_SREG_SGP1)
+#define READ_SGP10()   ((uint64_t)arch_get_system_reg(env, HEX_SREG_SGP0) | \
+    ((uint64_t)arch_get_system_reg(env, HEX_SREG_SGP1) << 32))
+
+#define WRITE_SREG(NUM, VAL)      log_sreg_write(env, NUM, VAL, slot)
+#define WRITE_SGP0(VAL)           log_sreg_write(env, HEX_SREG_SGP0, VAL, slot)
+#define WRITE_SGP1(VAL)           log_sreg_write(env, HEX_SREG_SGP1, VAL, slot)
+#define WRITE_SGP10(VAL) \
+    do { \
+        log_sreg_write(env, HEX_SREG_SGP0, (VAL) & 0xFFFFFFFF, slot); \
+        log_sreg_write(env, HEX_SREG_SGP1, (VAL) >> 32, slot); \
+    } while (0)
+
+#ifdef QEMU_GENERATE
+#define GET_SSR_FIELD(RES, FIELD) \
+    GET_FIELD(RES, FIELD, hex_t_sreg[HEX_SREG_SSR])
+#else
+
+#define GET_SSR_FIELD(FIELD, REGIN) \
+    (uint32_t)GET_FIELD(FIELD, REGIN)
+#define GET_SYSCFG_FIELD(FIELD, REGIN) \
+    (uint32_t)GET_FIELD(FIELD, REGIN)
+#define SET_SYSTEM_FIELD(ENV, REG, FIELD, VAL) \
+    do { \
+        uint32_t regval = arch_get_system_reg(ENV, REG); \
+        fINSERT_BITS(regval, reg_field_info[FIELD].width, \
+                     reg_field_info[FIELD].offset, (VAL)); \
+        arch_set_system_reg(ENV, REG, regval); \
+    } while (0)
+#define SET_SSR_FIELD(ENV, FIELD, VAL) \
+    SET_SYSTEM_FIELD(ENV, HEX_SREG_SSR, FIELD, VAL)
+#define SET_SYSCFG_FIELD(ENV, FIELD, VAL) \
+    SET_SYSTEM_FIELD(ENV, HEX_SREG_SYSCFG, FIELD, VAL)
+
+#define CCR_FIELD_SET(ENV, FIELD) \
+    (!!GET_FIELD(FIELD, arch_get_system_reg(ENV, HEX_SREG_CCR)))
+
+/*
+ * Direct-to-guest is not implemented yet, continuing would cause unexpected
+ * behavior, so we abort.
+ */
+#define ASSERT_DIRECT_TO_GUEST_UNSET(ENV, EXCP) \
+    do { \
+        switch (EXCP) { \
+        case HEX_EVENT_TRAP0: \
+            g_assert(!CCR_FIELD_SET(ENV, CCR_GTE)); \
+            break; \
+        case HEX_EVENT_IMPRECISE: \
+        case HEX_EVENT_PRECISE: \
+        case HEX_EVENT_FPTRAP: \
+            g_assert(!CCR_FIELD_SET(ENV, CCR_GEE)); \
+            break; \
+        default: \
+            if ((EXCP) >= HEX_EVENT_INT0) { \
+                g_assert(!CCR_FIELD_SET(ENV, CCR_GIE)); \
+            } \
+            break; \
+        } \
+    } while (0)
+#endif
+
+#define fREAD_ELR() (READ_SREG(HEX_SREG_ELR))
+
+#define fLOAD_PHYS(NUM, SIZE, SIGN, SRC1, SRC2, DST) { \
+  const uintptr_t rs = ((unsigned long)(unsigned)(SRC1)) & 0x7ff; \
+  const uintptr_t rt = ((unsigned long)(unsigned)(SRC2)) << 11; \
+  const uintptr_t addr = rs + rt;         \
+  cpu_physical_memory_read(addr, &DST, sizeof(uint32_t)); \
+}
+
+#define fPOW2_HELP_ROUNDUP(VAL) \
+    ((VAL) | \
+     ((VAL) >> 1) | \
+     ((VAL) >> 2) | \
+     ((VAL) >> 4) | \
+     ((VAL) >> 8) | \
+     ((VAL) >> 16))
+#define fPOW2_ROUNDUP(VAL) (fPOW2_HELP_ROUNDUP((VAL) - 1) + 1)
+
+#define fFRAMECHECK(ADDR, EA)  g_assert_not_reached();
+
+#define fTRAP(TRAPTYPE, IMM) \
+    register_trap_exception(env, TRAPTYPE, IMM, PC)
+
+#define fVIRTINSN_SPSWAP(IMM, REG)
+#define fVIRTINSN_GETIE(IMM, REG) { REG = 0xdeafbeef; }
+#define fVIRTINSN_SETIE(IMM, REG)
+#define fVIRTINSN_RTE(IMM, REG)
+#define fGRE_ENABLED() GET_FIELD(CCR_GRE, READ_SREG(HEX_SREG_CCR))
+#define fTRAP1_VIRTINSN(IMM) \
+    (fGRE_ENABLED() && \
+        (((IMM) == 1) || ((IMM) == 3) || ((IMM) == 4) || ((IMM) == 6)))
+
+/* Not modeled in qemu */
+
+#define MARK_LATE_PRED_WRITE(RNUM)
+#define fICINVIDX(REG)
+#define fICKILL()
+#define fDCKILL()
+#define fL2KILL()
+#define fL2UNLOCK()
+#define fL2CLEAN()
+#define fL2CLEANINV()
+#define fL2CLEANPA(REG)
+#define fL2CLEANINVPA(REG)
+#define fL2CLEANINVIDX(REG)
+#define fL2CLEANIDX(REG)
+#define fL2INVIDX(REG)
+#define fL2TAGR(INDEX, DST, DSTREG)
+#define fL2UNLOCKA(VA) ((void) VA)
+#define fL2TAGW(INDEX, PART2)
+#define fDCCLEANIDX(REG)
+#define fDCCLEANINVIDX(REG)
+
+/* Always succeed: */
+#define fL2LOCKA(EA, PDV, PDN) ((void) EA, PDV = 0xFF)
+#define fCLEAR_RTE_EX() \
+    do { \
+        uint32_t tmp = 0; \
+        tmp = arch_get_system_reg(env, HEX_SREG_SSR); \
+        fINSERT_BITS(tmp, reg_field_info[SSR_EX].width, \
+                     reg_field_info[SSR_EX].offset, 0); \
+        log_sreg_write(env, HEX_SREG_SSR, tmp, slot); \
+    } while (0)
+
+#define fDCINVIDX(REG)
+#define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
+
+#define fSET_TLB_LOCK()       g_assert_not_reached()
+#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
+
+#define fSET_K0_LOCK()        g_assert_not_reached()
+#define fCLEAR_K0_LOCK()      g_assert_not_reached()
+
+#define fTLB_IDXMASK(INDEX) \
+    ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)->num_tlbs)) - 1))
+
+#define fTLB_NONPOW2WRAP(INDEX)                 \
+    (((INDEX) >= env_archcpu(env)->num_tlbs) ?  \
+         ((INDEX) - env_archcpu(env)->num_tlbs) : \
+         (INDEX))
+
+
+#define fTLBW(INDEX, VALUE) \
+    hex_tlbw(env, (INDEX), (VALUE))
+#define fTLBW_EXTENDED(INDEX, VALUE) \
+    hex_tlbw(env, (INDEX), (VALUE))
+#define fTLB_ENTRY_OVERLAP(VALUE) \
+    (hex_tlb_check_overlap(env, VALUE, -1) != -2)
+#define fTLB_ENTRY_OVERLAP_IDX(VALUE) \
+    hex_tlb_check_overlap(env, VALUE, -1)
+#define fTLBR(INDEX) \
+    (env->hex_tlb->entries[fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX))])
+#define fTLBR_EXTENDED(INDEX) \
+    (env->hex_tlb->entries[fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX))])
+#define fTLBP(TLBHI) \
+    hex_tlb_lookup(env, ((TLBHI) >> 12), ((TLBHI) << 12))
+#define iic_flush_cache(p)
+
+#define fIN_DEBUG_MODE(TNUM) \
+    ((GET_FIELD(ISDBST_DEBUGMODE, arch_get_system_reg(env, HEX_SREG_ISDBST)) \
+        & (0x1 << (TNUM))) != 0)
+
+#define fIN_DEBUG_MODE_NO_ISDB(TNUM) false
+#define fIN_DEBUG_MODE_WARN(TNUM) false
+
+#ifdef QEMU_GENERATE
+
+/*
+ * Read tags back as zero for now:
+ *
+ * tag value in RD[31:10] for 32k, RD[31:9] for 16k
+ */
+#define fICTAGR(RS, RD, RD2) \
+    do { \
+        RD = ctx->zero; \
+    } while (0)
+#define fICTAGW(RS, RD)
+#define fICDATAR(RS, RD) \
+    do { \
+        RD = ctx->zero; \
+    } while (0)
+#define fICDATAW(RS, RD)
+
+#define fDCTAGW(RS, RT)
+/* tag: RD[23:0], state: RD[30:29] */
+#define fDCTAGR(INDEX, DST, DST_REG_NUM) \
+    do { \
+        DST = ctx->zero; \
+    } while (0)
+#else
+
+/*
+ * Read tags back as zero for now:
+ *
+ * tag value in RD[31:10] for 32k, RD[31:9] for 16k
+ */
+#define fICTAGR(RS, RD, RD2) \
+    do { \
+        RD = 0x00; \
+    } while (0)
+#define fICTAGW(RS, RD)
+#define fICDATAR(RS, RD) \
+    do { \
+        RD = 0x00; \
+    } while (0)
+#define fICDATAW(RS, RD)
+
+#define fDCTAGW(RS, RT)
+/* tag: RD[23:0], state: RD[30:29] */
+#define fDCTAGR(INDEX, DST, DST_REG_NUM) \
+    do { \
+        DST = HEX_DC_STATE_INVALID | 0x00; \
+    } while (0)
+#endif
+
+#endif
+
+#define NUM_TLB_REGS(x) (env_archcpu(env)->num_tlbs)
+
+#endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 444799d3ad..c3140b97bd 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "macros.h"
+#include "sys_macros.h"
 #include "arch.h"
 #include "hex_arch_types.h"
 #include "fma_emu.h"
-- 
2.34.1



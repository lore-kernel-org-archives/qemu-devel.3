Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B07DF417E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv1-0001L6-QR; Mon, 09 Mar 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbub-0000s1-8c
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuZ-0005GE-9C
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629Du3pC412692
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FH5Ff8qDxOxOBStMB69z3bKi36eF9Ye3CU+a1kTIdyM=; b=mPaZpK199+YYF9QB
 xd/rRilfAvdZI2Us+hW38WWoA8ZWgVZyQLk8eH95Z5bD3IsBXnYpd+EbAYXdCuAi
 4M6Psrv6Df6IaCJet7Zp/9e43S3T6NCZB0cxjNSl26+5v9TpYv6BVlqhbyB+LwTG
 eZnJVm5YNDRvVoMHdybRby0XRuq7pFVE87nxEDQ0CvS1KsOnQWIZ/Hc0okdaxfST
 XjiT34MyvjdpEQDROLjS9U4eOefqT6U7DE4MAPhOvPHUdR4g07jgpEUzsyHzvkW9
 bYE9TcySQ1HKRa/HWVzFKXoHV0Fvo5y9Vt6xfOvCIXLCouLM4GrCxOYOh9BZaweD
 askyJg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyhbr5gj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be21c6e2f5so29045757eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067725; x=1773672525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FH5Ff8qDxOxOBStMB69z3bKi36eF9Ye3CU+a1kTIdyM=;
 b=hc7Qv0XbeB/bLMNDJracy6MmsOLg2vQZ3KBDWvThGXM0h3G0PwG+f4eQzI3DtrO9FM
 RBN9baDC0DcZ/qoe9aWYRF4ylQKY1dby/iqHEXy5Ym8RHnXzvxBYaW6w8RHWASoXJAoT
 0ngn1AFllD0VC/m0nnVeifA6NhZzlNM0wALrM93GOmTVWge9hhdGDsTMOgr3SLCaHjMi
 /9ivAZhstra2DHicbw6uvpw5+wdL/f/XSBtGHp02OsD1AdxKYAHDcsHDyGZ11/34kbr+
 isnJFib934OvXY8+YGuiCq+2Dj/K5lpq99zLpAIqOQ94HTqTUAg8A9LDULejfptsVKRu
 LSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067725; x=1773672525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FH5Ff8qDxOxOBStMB69z3bKi36eF9Ye3CU+a1kTIdyM=;
 b=uU3eLbFchTawgZSKX8NRqg1WHYNh8kDFbcZGSI/FYC66agGR9vFSqXt6nPzjao3qYN
 A87ZADWNjmjv3d6Fn/c15zbH64nImEugnnfjPECG4Dh+xnb4WjPUmAQUswR1OTko+3lb
 NFRyJYTbYox0CEWS/358voUMdcDyUrMcaS+5nnNOEPqWqrWEgumnB5GnJ02LJqTVBbBQ
 YlAj911O8xBSZiFCcx23gzkuomo7xRAhHrD++vKnWDxy6fkr07MtjKuv2xfr1whaO4c9
 kCSbEdyJbpFU9LZhyHrg54qaNOPeDEPEIS8BoMIvQTJtfM09gNJd4s8lN/R/a3b+NpQR
 gTdA==
X-Gm-Message-State: AOJu0Yxi+bYZ6uAaNz7euJMoAqsJs2slmCMoYgqA6rGb7XsKvVweqfgt
 dxa2PxTnsCqczPI9DU5XyZ8wVZHMVRrd+qIC1DIdWvc5N2EK4q4l695JkqUlsvAMPFqAvuHqgUN
 /xzRrsAq9I+m6KN4Pac+BJjrONIsPA7O1uAoiFhfcN9KKqL05lNI+KhZ0rejr+qwkig==
X-Gm-Gg: ATEYQzwsECEjxeUd6+ham1YK+JgXKmdmq6lCn2qQnQ6W4cGkswK+mn9XwsrBqq63P8B
 UVU1kpUBn9LlAkPoibqY+Kj+x8b20elqMgtS+iov32EOrQgAnNs6lQ/XwDslDOWJVYgJatu8gnD
 f9yknSHwadjHe6ma07Uuf91rGzOPZ9QhcD19aMyerCXmiXrOpbHYbdtYMV3tKXH97lPvDsKuXYw
 kqvZ3c1MiiLeQnIKeaL9hSgOUk/xowli5v23B/w4G97QFfCeLdBu2alI9aP+kK+WIym1I2ndZ/Y
 OMbvph6+P/oosSSfwWTPJHogA9iXUq3TrEMypv6kAq61Dre8zw1sUro2F/uSuAh5jCS72TJcNUC
 ssrfnBsFW02YQfHjgmLiAeSkyMsZgN+jLk1bsFdoPcZeI/AjY6rRxp5O4J9PGXsRVVaBc8g==
X-Received: by 2002:a05:7300:fd0e:b0:2be:53a:5f4 with SMTP id
 5a478bee46e88-2be4deac6f0mr4883787eec.9.1773067725037; 
 Mon, 09 Mar 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0e:b0:2be:53a:5f4 with SMTP id
 5a478bee46e88-2be4deac6f0mr4883768eec.9.1773067724371; 
 Mon, 09 Mar 2026 07:48:44 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 16/35] target/hexagon: Add new macro definitions for sysemu
Date: Mon,  9 Mar 2026 07:48:03 -0700
Message-Id: <20260309144822.877695-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rcmdyltv c=1 sm=1 tr=0 ts=69aeddce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VoFV4bgUeqxKQXHmsMYA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX8d9YU6dTH8av
 A8udys63gKyTqsHpWfcRQ4TB4M4z5qqTyVowCvxlyE0aEAQu5OVkBZ5HvH7xi0jQgE1Ob6djRs+
 Q4IH1S9ANzlaMjtaV5pBMzGYnDn1FvltHS+40UXcp/+8NZAsAG3FpyBmr4dqSi94+jdhqlLwiI3
 vk7OeQRiapXn5N/e9eu68V0P7KQ4D21iKnsXVNiEZRf+QtCvCD9v+yUXf3iBCHOjSIlDhuIHkIF
 eKBtXK5nJJUfSkXI+WpSAMRFnoCx6pgywD1dNuYXIZt6A7QznhdY/co1QY/4Ce5cA7QlduZKlJm
 9wOKwbKSOmbaZooiJEp8bDJCHjiityMtqckKamTFS8cAFyfBWzXSF9zmAiNA0WX5qbUR3xGTXHe
 et5i9Tn5M3/2zLLtHqC7EbtjCYfkStQ2feb5CIseTvV+byM5o10HfA3HpKEb96wNRjYCktvZukh
 fjT11ABsAlTEwgS4t5g==
X-Proofpoint-GUID: oA3ABY60cPqZKvamAqtNGE9y5Sv1r60h
X-Proofpoint-ORIG-GUID: oA3ABY60cPqZKvamAqtNGE9y5Sv1r60h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Also: add nop TCG overrides for break, unpause, fetchbo; add TCG
override for dczeroa_nt (non-temporal variant of dczeroa).

break: this hardware breakpoint instruction is used with the in-silicon
debugger feature, this is not modeled.

unpause: this instruction is used to resume hardware threads that are
stalled by pause instructions.  pause is modeled as a nop, or in RR
mode as an EXCP_YIELD.  This instruction is safe to ignore.

Since prefetch functions are not modeled, fetchbo is safe to ignore.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h    |   9 ++
 target/hexagon/macros.h     |  25 +++-
 target/hexagon/sys_macros.h | 237 ++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  |   1 +
 4 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 target/hexagon/sys_macros.h

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 7b96dab9185..bd04386d860 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -488,6 +488,7 @@
 
 /* dczeroa clears the 32 byte cache line at the address given */
 #define fGEN_TCG_Y2_dczeroa(SHORTCODE) SHORTCODE
+#define fGEN_TCG_Y2_dczeroa_nt(SHORTCODE) SHORTCODE
 
 /* In linux-user mode, these are not modelled, suppress compiler warning */
 #define fGEN_TCG_Y2_dcinva(SHORTCODE) \
@@ -1132,6 +1133,9 @@
                            RdV, tcg_constant_tl(0)); \
     } while (0)
 
+#define fGEN_TCG_Y2_break(SHORTCODE)
+#define fGEN_TCG_J2_unpause(SHORTCODE)
+
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
@@ -1341,6 +1345,11 @@
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
index 6c2862a2320..e4bfea4923f 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -631,8 +631,18 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
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
@@ -654,5 +664,18 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
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
+
+#define fPREDUSE_TIMING()
 
 #endif
diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
new file mode 100644
index 00000000000..f497d55bb81
--- /dev/null
+++ b/target/hexagon/sys_macros.h
@@ -0,0 +1,237 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
+        HexagonCPU *_sf_cpu = env_archcpu(ENV); \
+        uint32_t regval; \
+        if ((REG) < HEX_SREG_GLB_START) { \
+            regval = (ENV)->t_sreg[(REG)]; \
+        } else { \
+            regval = _sf_cpu->globalregs ? \
+                hexagon_globalreg_read(_sf_cpu->globalregs, (REG), \
+                                       (ENV)->threadId) : 0; \
+        } \
+        fINSERT_BITS(regval, reg_field_info[FIELD].width, \
+                     reg_field_info[FIELD].offset, (VAL)); \
+        if ((REG) < HEX_SREG_GLB_START) { \
+            (ENV)->t_sreg[(REG)] = regval; \
+        } else if (_sf_cpu->globalregs) { \
+            hexagon_globalreg_write(_sf_cpu->globalregs, (REG), regval, \
+                                    (ENV)->threadId); \
+        } \
+    } while (0)
+#define SET_SSR_FIELD(ENV, FIELD, VAL) \
+    SET_SYSTEM_FIELD(ENV, HEX_SREG_SSR, FIELD, VAL)
+#define SET_SYSCFG_FIELD(ENV, FIELD, VAL) \
+    SET_SYSTEM_FIELD(ENV, HEX_SREG_SYSCFG, FIELD, VAL)
+
+#define CCR_FIELD_SET(ENV, FIELD) \
+    (!!GET_FIELD(FIELD, (ENV)->t_sreg[HEX_SREG_CCR]))
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
+#define fREAD_ELR() (env->t_sreg[HEX_SREG_ELR])
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
+#define fTRAP(TRAPTYPE, IMM) \
+    register_trap_exception(env, TRAPTYPE, IMM, PC)
+
+#define fVIRTINSN_SPSWAP(IMM, REG)
+#define fVIRTINSN_GETIE(IMM, REG) { REG = 0xdeafbeef; }
+#define fVIRTINSN_SETIE(IMM, REG)
+#define fVIRTINSN_RTE(IMM, REG)
+#define fGRE_ENABLED() \
+    GET_FIELD(CCR_GRE, env->t_sreg[HEX_SREG_CCR])
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
+        uint32_t tmp = env->t_sreg[HEX_SREG_SSR]; \
+        fINSERT_BITS(tmp, reg_field_info[SSR_EX].width, \
+                     reg_field_info[SSR_EX].offset, 0); \
+        log_sreg_write(env, HEX_SREG_SSR, tmp, slot); \
+    } while (0)
+
+#define fDCINVIDX(REG)
+#define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
+
+#define fTLB_IDXMASK(INDEX) \
+    ((INDEX) & (fPOW2_ROUNDUP( \
+        fCAST4u(hexagon_tlb_get_num_entries(env_archcpu(env)->tlb))) - 1))
+
+#define fTLB_NONPOW2WRAP(INDEX) \
+    (((INDEX) >= hexagon_tlb_get_num_entries(env_archcpu(env)->tlb)) ? \
+         ((INDEX) - hexagon_tlb_get_num_entries(env_archcpu(env)->tlb)) : \
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
+    hexagon_tlb_read(env_archcpu(env)->tlb, \
+                     fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX)))
+#define fTLBR_EXTENDED(INDEX) \
+    hexagon_tlb_read(env_archcpu(env)->tlb, \
+                     fTLB_NONPOW2WRAP(fTLB_IDXMASK(INDEX)))
+#define fTLBP(TLBHI) \
+    hex_tlb_lookup(env, ((TLBHI) >> 12), ((TLBHI) << 12))
+#define iic_flush_cache(p)
+
+#define fIN_DEBUG_MODE(TNUM) ({ \
+    HexagonCPU *_cpu = env_archcpu(env); \
+    uint32_t _isdbst = _cpu->globalregs ? \
+        hexagon_globalreg_read(_cpu->globalregs, \
+                               HEX_SREG_ISDBST, env->threadId) : 0; \
+    (GET_FIELD(ISDBST_DEBUGMODE, _isdbst) \
+        & (0x1 << (TNUM))) != 0; })
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
+        DST = 0; \
+    } while (0)
+#endif
+
+#else
+#define ASSERT_DIRECT_TO_GUEST_UNSET(ENV, EXCP) do { } while (0)
+#endif
+
+#define NUM_TLB_REGS(x) (hexagon_tlb_get_num_entries(env_archcpu(env)->tlb))
+
+#endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 368391bb846..39f0c0445d6 100644
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



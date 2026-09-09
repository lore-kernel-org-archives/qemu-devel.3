Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0D8C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jbb-0002fY-5e; Wed, 09 Sep 2026 10:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4Jba-0002fI-0i
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:48:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4JbX-00076v-Lu
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:48:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BUF6h2376133
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y1G43mXJyZC
 AkF2zCgiqyq5k8gvkMSyLp9Du7elC0Tc=; b=GIbdLtWM4BaeMC6P9l7QIg/OroO
 uNbJfaXB7hn8qiIDRrwuPEG8481aEflctbFWBCPRUyh5x4X7YKvjnO8Ai1//yH5M
 xiOzVcDJg3RbdLcB2epFUiHx9/J/r9jgzGPtnwmywca4l11JgAgjqydIp1zms1nR
 u2+8bRpU1jRxHf5vml2y9qgJ0MWCKV06RLMQTu4WkEDjQDTOJYb8OwW0M8VvNfLA
 qyseWhwZcZz3/LbzZX3OSfo4T764EaVDq2FsRium5travIcpLR9DDqMeMkvB5oGf
 tlvrorOopCrzHT46DxtAX9PpaBfMzzLkFT7W33U2FhI37pGN+R1xsZWtMlA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru11qr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:48:50 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66cdb701595so7091267d50.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965330; x=1789570130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y1G43mXJyZCAkF2zCgiqyq5k8gvkMSyLp9Du7elC0Tc=;
 b=Pp1YjiErQlmHTB6Z60gkMy4396Vy7vXAkPDXuw8FT/r9VbiRvC15TrceNTmTvuPG9+
 DNz1EGqykCoivhn/1HRiaemZHHF76rHBIV9GupnLXH+6MAO3jv4NxfFTnd6t6GOXrOh5
 NAUN3Jt9luWfAWshn+P2q5mI0YDbTZ024h2tIv9yNjZCJUlvF0H9UzRJYoqylSe0kbd2
 C7HDDGEOFcz5K0M52VLVV9VWGswjMhh1PpMcjHkZ7GQWQ0CfWyI1EHNHh8VzNAcbjUm2
 LJx5ExrnCX3ar3oBmUaoFzz778xI8e+abJ77cEciJex1JUHM5cbMJv8aIEoxQ2kcTcnC
 01gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965330; x=1789570130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y1G43mXJyZCAkF2zCgiqyq5k8gvkMSyLp9Du7elC0Tc=;
 b=mM66J9DRLIGe45DoreI400Gra99UXQ/EJuF1aFgFbwp7oP/6dxeOGQ819vKY0oJZI5
 VlRYgiliupiHeqaS+Q/RgC1K8zLruLBs+dXBgLbIuYWM5z+8HDsU/tssAeu8SM1yTd2n
 /wt5ka/gVRHi5pplvaj8MCcPojvAI4APLsRWRKO7bUVI6e6pTiq9F8fKCqk658SjR1Qd
 i0bUu4poM39QZLei+wscOiXFkWFD3GfyoNoS9fav/mOCkAugp+e0ntuY6FJ16XmfB40s
 njDzS+91IOevkKED8gRRWRkn420bW8QWW2WBAx7sFkVAPD36QgkWwhlev9aeVQOv90/7
 7DMA==
X-Gm-Message-State: AFuF++niXyHM6WEljlidQIrwPFtZxQKVGaB1dSIDP2g6n7nBwX7hlUXV
 M8qGiyNCs6dqgB4l1wxXjWVgy40u1t2NK/v0QuprM7W+MaR3f7jA/vgCyE88JrEOKHl03ONXKhA
 89mH1HlJ1lSfPC1mevbkqzB3p04mUIR3/U6txA4yAvp3kMkHrskAXXr1cWpS5u3mJWg==
X-Gm-Gg: AYBFou1kV7pXKpIy+xxhG1vrhg2DrLIYNuilv0m+D67u3J4H54KxbbB9FPno2lpcRTR
 4TZv67n/Ye01jio61mRamxgLiBsiGMnU3U/bbxbG6bDAA6D5/nK74432hb1vW2cpk40u2+v8GwJ
 JzfC0CUVgO4hpEJRsgozYAkmDJ9ZF5UN5deSuyqVCAtput178a/Pmxhdp+2wN3gs83X7jCi0H8F
 lTjilHxjEqsnRkfM99GNY8dvOsLknPSswM8BOc8P6onfKx2Zyc7f2vv7u5THytMkMnDpuhXX2Ud
 3K5BAykcqs2qg7zuiXd6kdItr4V/GPqPQrc4v+cn9sOWcFfgYPNroC/w+YygIpe6XJf+WJbt8qE
 ZHcNZgGBUUIaAYnyFUPZBOgyKOAUySBCdhYds
X-Received: by 2002:a05:690e:4554:20b0:66f:c1d5:c6dc with SMTP id
 956f58d0204a3-66fc1d5c8e2mr5271786d50.99.1788965329628; 
 Wed, 09 Sep 2026 07:48:49 -0700 (PDT)
X-Received: by 2002:a05:690e:4554:20b0:66f:c1d5:c6dc with SMTP id
 956f58d0204a3-66fc1d5c8e2mr5271740d50.99.1788965328856; 
 Wed, 09 Sep 2026 07:48:48 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910464bf898sm125678886d6.7.2026.09.09.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:48:48 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 1/7] target/riscv: add sdext debug CSRs state
Date: Wed,  9 Sep 2026 11:48:34 -0300
Message-ID: <20260909144841.1766921-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa171d2 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=xvfqbYfxAAAA:20
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fgrLqfBXAAAA:8 a=8aUGYKOvqt1NoZA4oJ4A:9
 a=yHXA93iunegOHmWoMUFd:22 a=_Ge82aPy-h_wFa7gWU4u:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: HZkuiq-pgx8KtsL5GmSf7BvMpfaUH-kc
X-Proofpoint-ORIG-GUID: HZkuiq-pgx8KtsL5GmSf7BvMpfaUH-kc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfXzznhMmKih9E6
 RScS8JiYWJwZXDyJqFMv0WQPAAzGmxgUyxikNxyeNelZzZjYLh1mOFRAw9xnVBuYAFaGQr398y1
 gbHnrmr2sZ2bU+fs22KRLEWhdfbkLKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX3ZjLg3bWLwTr
 XpVW7Hr6sq1s8/3cWOqldSERf30T/WpI4s/GQSMNnyYlffuzHgBJ98zDa9I2jo+esEAvE0itZaG
 E9MJAOH8lJ3uPMudjmUSniEPcdACe3IRnaTtEFfWO+SP5SdJEM8lqxJF5KnqFBnvxjBA5HVO2Rr
 Kv1WzxJ7+auPUvIEJaTqTf0TJP60CG276kSs6fC4QvkjWOKOWOOk6UJ8lvHsyB+8OWVrxC7nBSE
 20JN41nCnglP21/+W5+Ci4EJnrcqavukwi4O6NNvpUQgu5yKtR/ylBVPJCu5G+01NI51vhIlWsQ
 hPx1Zc9BA6HFB+yfgSuES8UdpFFxLmejLNAcqj/lMAk5pT5zLyYJcz/ql8329CJO4GKJ6mBbeMQ
 uiu2v34S2dN4fE1891cJoUIRTpbZhkHH6eIrAYXrD0ubkg+FaktdVCTBm+BYJ49UrI3HWpuRaeA
 FUYgg7BgwXgLxVSBxxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Add architectural state for Sdext Debug Mode: debug_mode, dcsr, dpc
and dscratch0/1. Wire up CSR access for dcsr/dpc/dscratch and gate
them to Debug Mode (or host debugger access).

The Sdext is not fully implemented, so it is disabled by default.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c                |   7 ++
 target/riscv/cpu.h                |   4 +
 target/riscv/cpu_bits.h           |  33 ++++++++
 target/riscv/cpu_cfg_fields.h.inc |   1 +
 target/riscv/machine.c            |  20 +++++
 target/riscv/tcg/csr.c            | 126 ++++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5fff9d745e..0fe9762022 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
@@ -1091,6 +1092,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
+    env->debug_mode = false;
+    env->dcsr = DCSR_DEBUGVER(4);
+    env->dpc = 0;
+    env->dscratch[0] = 0;
+    env->dscratch[1] = 0;
+
     if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c2138dbd4b..7b343d7a3e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -507,6 +507,10 @@ struct CPUArchState {
 
     /* True if in debugger mode.  */
     bool debugger;
+    bool debug_mode;
+    target_ulong dcsr;
+    target_ulong dpc;
+    target_ulong dscratch[2];
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index c01050ce2b..769c945517 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -467,6 +467,39 @@
 #define CSR_DCSR            0x7b0
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
+#define CSR_DSCRATCH1       0x7b3
+
+/* DCSR fields */
+#define DCSR_XDEBUGVER_SHIFT    28
+#define DCSR_XDEBUGVER_MASK     (0xfu << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_DEBUGVER(val)      ((target_ulong)(val) << DCSR_XDEBUGVER_SHIFT)
+#define DCSR_EXTCAUSE_SHIFT     24
+#define DCSR_EXTCAUSE_MASK      (0x7u << DCSR_EXTCAUSE_SHIFT)
+#define DCSR_CETRIG             BIT(19)
+#define DCSR_PELP               BIT(18)
+#define DCSR_EBREAKVS           BIT(17)
+#define DCSR_EBREAKVU           BIT(16)
+#define DCSR_EBREAKM            BIT(15)
+#define DCSR_EBREAKS            BIT(13)
+#define DCSR_EBREAKU            BIT(12)
+#define DCSR_STEPIE             BIT(11)
+#define DCSR_STOPCOUNT          BIT(10)
+#define DCSR_STOPTIME           BIT(9)
+#define DCSR_CAUSE_SHIFT        6
+#define DCSR_CAUSE_MASK         (0x7u << DCSR_CAUSE_SHIFT)
+#define DCSR_V                  BIT(5)
+#define DCSR_MPRVEN             BIT(4)
+#define DCSR_NMIP               BIT(3)
+#define DCSR_STEP               BIT(2)
+#define DCSR_PRV_MASK           0x3u
+
+#define DCSR_CAUSE_EBREAK       1
+#define DCSR_CAUSE_TRIGGER      2
+#define DCSR_CAUSE_HALTREQ      3
+#define DCSR_CAUSE_STEP         4
+#define DCSR_CAUSE_RESET        5
+#define DCSR_CAUSE_GROUP        6
+#define DCSR_CAUSE_OTHER        7
 
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index f91c780299..24f3606f94 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_sdext)
 BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index bf203bffce..8658d43643 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -301,6 +301,25 @@ static const VMStateDescription vmstate_debug = {
         VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
                               env.num_triggers, 0,
                               vmstate_info_uint64, uint64_t),
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_sdext = {
+    .name = "cpu/sdext",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = debug_needed,
+    .post_load = debug_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL_V(env.debug_mode, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dcsr, RISCVCPU, 3),
+        VMSTATE_UINTTL_V(env.dpc, RISCVCPU, 3),
+        VMSTATE_UINTTL_ARRAY_V(env.dscratch, RISCVCPU, 2, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -576,6 +595,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_ctr,
         &vmstate_sstc,
         &vmstate_mseccfg,
+        &vmstate_sdext,
         NULL
     }
 };
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..988261cccf 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3207,6 +3207,126 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static RISCVException sdext(CPURISCVState *env, int csrno)
+{
+    if (!riscv_cpu_cfg(env)->ext_sdext) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (!env->debug_mode && !env->debugger) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_visible_mask(CPURISCVState *env)
+{
+    target_ulong mask = (target_ulong)-1;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!riscv_has_ext(env, RVH)) {
+        mask &= ~(DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V);
+    }
+    if (!riscv_has_ext(env, RVS)) {
+        mask &= ~DCSR_EBREAKS;
+    }
+    if (!riscv_has_ext(env, RVU)) {
+        mask &= ~DCSR_EBREAKU;
+    }
+    if (!cpu->cfg.ext_zicfilp) {
+        mask &= ~DCSR_PELP;
+    }
+    if (!cpu->cfg.ext_smdbltrp) {
+        mask &= ~DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException read_dcsr(CPURISCVState *env, int csrno,
+                                target_ulong *val)
+{
+    *val = env->dcsr & dcsr_visible_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static target_ulong dcsr_writable_mask(CPURISCVState *env)
+{
+    target_ulong mask = DCSR_EBREAKM | DCSR_EBREAKS | DCSR_EBREAKU |
+                        DCSR_STEPIE | DCSR_STOPCOUNT | DCSR_STOPTIME |
+                        DCSR_STEP | DCSR_PRV_MASK;
+    RISCVCPU *cpu = env_archcpu(env);
+
+    mask |= DCSR_MPRVEN;
+
+    if (riscv_has_ext(env, RVH)) {
+        mask |= DCSR_EBREAKVS | DCSR_EBREAKVU | DCSR_V;
+    }
+    if (riscv_has_ext(env, RVS)) {
+        mask |= DCSR_EBREAKS;
+    }
+    if (riscv_has_ext(env, RVU)) {
+        mask |= DCSR_EBREAKU;
+    }
+    if (cpu->cfg.ext_zicfilp) {
+        mask |= DCSR_PELP;
+    }
+    if (cpu->cfg.ext_smdbltrp) {
+        mask |= DCSR_CETRIG;
+    }
+
+    return mask;
+}
+
+static RISCVException write_dcsr(CPURISCVState *env, int csrno,
+                                 target_ulong val, uintptr_t ra)
+{
+    target_ulong mask = dcsr_writable_mask(env);
+    target_ulong new_val = env->dcsr;
+
+    new_val &= ~mask;
+    new_val |= val & mask;
+    new_val &= ~DCSR_XDEBUGVER_MASK;
+    new_val |= DCSR_DEBUGVER(4);
+    env->dcsr = new_val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dpc(CPURISCVState *env, int csrno,
+                               target_ulong *val)
+{
+    *val = env->dpc & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dpc(CPURISCVState *env, int csrno,
+                                target_ulong val, uintptr_t ra)
+{
+    env->dpc = val & get_xepc_mask(env);
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_dscratch(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    *val = env->dscratch[index];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_dscratch(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    int index = (csrno == CSR_DSCRATCH1) ? 1 : 0;
+
+    env->dscratch[index] = val;
+    return RISCV_EXCP_NONE;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 /* Execution environment configuration setup */
 static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
                                    target_ulong *val)
@@ -6435,6 +6555,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
+#if !defined(CONFIG_USER_ONLY)
+    [CSR_DCSR]      =  { "dcsr",      sdext, read_dcsr,     write_dcsr },
+    [CSR_DPC]       =  { "dpc",       sdext, read_dpc,      write_dpc },
+    [CSR_DSCRATCH]  =  { "dscratch0", sdext, read_dscratch, write_dscratch },
+    [CSR_DSCRATCH1] =  { "dscratch1", sdext, read_dscratch, write_dscratch },
+#endif
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
-- 
2.43.0



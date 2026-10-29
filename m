Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD71606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ErBQS7i8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ekaM6wfp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPuH-0005z0-IQ; Thu, 29 Oct 2026 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xMPu0-0005jk-5N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xMPtw-0005yz-T7
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeeFL3215794
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wyFvk13p+/Z
 utgVEglmYltqIL0MqbewRcZ6dSTY/KAg=; b=ErBQS7i84rAIpBV+It2Stw5IRqY
 bw7+6+N1rIeGLTsD/gYxK1tsQGbxQVTZkrndvqD4XPfxpzzzy4iprpKdg4uSV6H8
 NSaymWwxEkZ8QzLgTASvrWqN1dlI4+KAG+/72cI5MLtjXTPe3ZvK+ZS1DezzeluC
 xtlppia1lEih17zh1JKAjyp9P8InMUhxlma9XcSFSN3CdPIbnt7M59vnYWURHglO
 6YXJnblgeJsn+wqLJzmUC/g1+s/93mmbnhvQVsYUaBmReCP2nfQDy/1UU7TWx3hZ
 wiQLjDG6I+RyLKe2QTQADO4YRdWmpA+QpiSIVPjvqKG7IdTQo2rs4OYMJjQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s9t4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:10:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e8e16d22d8so30468545ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793279439; x=1793884239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyFvk13p+/ZutgVEglmYltqIL0MqbewRcZ6dSTY/KAg=;
 b=ekaM6wfpCkiqSQDz+/kTuqT9yWEUzV4bBOfJTFoC4eKVI9FSj0cGKyJUzQ7Ca02Xkh
 qiBEjaypYc7SulvaPX0Hev3uWfvr3NgFjzKvw3A+Ee5MlDhk2Pr/MTA59wreQp1nLoar
 IMZuFdos7TxZ3H7sgxG3tbTBWSSCdAXWDV+Og4dBdDXlx/vEORqohJyfIYKr+IUfJIvv
 aRB/+EK976bm4vVmWi4UwLx4G0hlKONwZu4T/FJO8BaFOo8ccDqrjK/279+uf2KNjVpp
 595N8K5gYkSa8nWUMl7sF9GNiT5qzpYkSIo+a4ZYA2ILpM7zZAUIaImP06+zXxzQCQp1
 Ajbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279439; x=1793884239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wyFvk13p+/ZutgVEglmYltqIL0MqbewRcZ6dSTY/KAg=;
 b=F9RHMQZqvk2Yzs2QGX+w8eoZa8G8bIk0pDl0Cfi108Tdz+BGQ0WRI/Znv1XBfSx9j/
 oMe6sm4XJ/KG+4nOS0pRrvc+7jS2EpCeiAi7phEjJbwY4ziIJ9YjdHxrdsDiYrxJlIfC
 1hqjvlOSThDyjeex+ajkQNvvZjbh5Nge3+0/4Wn6MTDpPKY1Fbtgo7T4MZjuzJWCKblW
 ctRt9Ci656BtymFw3TQTXHy+Dedg2CnSw57fWJWEoM+7+Mv5kEu4+5NR5tGkebVglEFw
 ZrxbBhJBAwhmzrQ+6Z+M5p1bwegZNg8zvp8hys91eNB2iKU4wASJ1e6Rv2kpP1wSArtn
 3xjA==
X-Forwarded-Encrypted: i=1;
 AKwUvByB8zRmY/KkVAj8/yVg65/aoofcvCeNT1tvZReRJ3P1JsleXWNNP/YTSdUtuwMh5bOvqgh7yXQ8j5pI@nongnu.org
X-Gm-Message-State: AFq9FYJDV8r09lHJxuaQocZM6xeTY9bo51l5K/B7sUYY6y8nEL4JqsNr
 ovkqZ85Z7lslVt2xM5DmqWijp9NDF5LsYDWGtl4k/GROqPjEPkMQ1vNcBhkvYt8Wu94Luy2ItDb
 WlTcx2KnHm/jk4M/Jxnxu4BIbc/QAOXp1owZ9dH4HKdSctcKEbLpwMLpnzQ==
X-Gm-Gg: AYBFou0a0/tWLdQzktB86wC2OFFBboLM8DZaMGa/OzikXHNtaSs2mF4RJyfhIgbqrsj
 qh/O5wt6gTB8v8ASEUYpq6eLtK3KPcvz8PXvN3MCNUrxgRXY5WL2Q2qri6Wp8pRpMfSmxwUbJHH
 G4ye4kmnv2xBnzJN6+tExRKtqHQ6KHK+L7Rdv9ihRemfi2eyLCmT9A2nm9b2ATkqOfO0shwkdIb
 dSNllxnfJxYtHS/ReGh1rli62J1LuyIS8QVCUThyzDkjSO4tVTSkG4OWsgkf/UR6QJB1TVXrDTE
 z3dzVllQ67xQUYsXOiOMSOSgb7AluTxiyMjXh5SAsHG4w3LRMfrQuSeF/kkGE1bo7rEndz3ZMv4
 RPXCbtrvcOKYHdXglByjBlIHrp2G+guVOwyFZim4x5O6Ay07zmohDT0XexITOPsmoD9XjfMcE6S
 ZCefUPBBcB+SSDPR+oJQpdyr3W2jR7xjugZu0EJGG/5zHRprciKwAWhA2baYRJMkeiGXPq6zqKn
 bE=
X-Received: by 2002:a17:903:b50:b0:2e2:d77b:e587 with SMTP id
 d9443c01a7336-2eb0051d151mr47903255ad.18.1793279438822; 
 Thu, 29 Oct 2026 06:10:38 -0700 (PDT)
X-Received: by 2002:a17:903:b50:b0:2e2:d77b:e587 with SMTP id
 d9443c01a7336-2eb0051d151mr47902955ad.18.1793279438264; 
 Thu, 29 Oct 2026 06:10:38 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2eae6bd60desm34467845ad.29.2026.10.29.06.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:10:37 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH v2 2/2] target/riscv: Capture Sspesa sample PC and counter
 ID on overflow
Date: Thu, 29 Oct 2026 18:40:09 +0530
Message-ID: <20261029131011.3715081-3-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
References: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfXwKgR0/HWlyLD
 9hZpi1wwg9CeU06LrrMumBSA466DSRBfIHjPdeKQCZXE8+3G7WUs6GmHAp1W75qPMNu2SbrOZBA
 Tkh3wDS/YUr+lMTJMwRWcXte0VIYmRvGVPtiDaIWGXbfQUnNZOg90Bg0p4UPZgQZFEZD8jRbO2M
 LknOhWM3PlkXIwrU73UXxsW2SrheDdiK2nXiZcc2yY5LuoXsYISkQiYB2J1ehWIahPd5UKMl5zL
 ndutHtuIzlmEeWf9rKXFnaosF2ZnBKBEwgqLmibTnPbgKNSzXm32LSO/WzcYMfQJukafWfWWJ+U
 5bsz5oBo6ccXJ03nV+MSBzc2HMOxNdes307wbI6DlU4equS2sXPGwCfc1OSHeMSuLch+mzs8Qhw
 3j1Rzh5K9hYCfUg3jynaBIbT86fzashisK/0zara5A28XQUb50SwtYBNh+xDMqTsjTlaCXL8ak5
 MMnHy8x1Wc75ukL+KmQ==
X-Proofpoint-ORIG-GUID: tMyimXWoavx1G-WKq7VsV0VdXeu-Ug48
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfXxbcVYRla2pD2
 hhdti2yYfcpqXELjsvhZyqtMu054T6Oh1J2Y/ROm8u8yN7Mc2kwrzxGFHsy9Sfs8zZZK/xz+ev/
 5eErmP9lyyS6Eii5YoHV/zMQ+T1IYnQ=
X-Proofpoint-GUID: tMyimXWoavx1G-WKq7VsV0VdXeu-Ug48
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae345cf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=fAx3W4zVqjXaToMRdlAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Capture shpmspc and shpmsdata just before updating mip.LCOFIP.
As required by the spec, record the current PC, counter ID and effective
privilege mode. When supervisor counter delegation is enabled,
only overflows of delegated counters update the sample CSRs.

Preserve shpmspc and shpmsdata while LCOFIP remains pending so later
overflows do not replace the pending sample. Currently, cntrid is not
updated if two counters overflow simultaneously.

The captured PC is QEMU's current env->pc, so it provides best-effort
attribution rather than guaranteed precise attribution.

Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 target/riscv/cpu_bits.h |  3 +--
 target/riscv/tcg/pmu.c  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 61258ce6e1..e99da434d5 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -642,9 +642,8 @@
 #define SHPMSDATA_CNTRID    0x1f
 #define SHPMSDATA_MODE      0x60
 #define SHPMSDATA_V         0x80
-#define SHPMSDATA_MODE_U    0x00
-#define SHPMSDATA_MODE_S    0x20
 #define SHPMSDATA_VALID_MASK (SHPMSDATA_CNTRID | SHPMSDATA_MODE | SHPMSDATA_V)
+#define SHPMSDATA_MODE_SHIFT 5
 
 /* Crypto Extension */
 #define CSR_SEED            0x015
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 1a4658319b..31edd31117 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -178,6 +178,43 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
     env->pmu_ctrs[2].mhpmcounter_prev++;
 }
 
+static void riscv_pmu_sspesa_capture(CPURISCVState *env, uint32_t ctr_idx)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    target_ulong sdata;
+    bool cde, ctr_enabled;
+
+    if (!cpu->cfg.ext_sspesa) {
+        return;
+    }
+
+    /*
+     * When supervisor counter delegation is enabled only overflows of
+     * delegated counters update the sample CSRs.
+     */
+    cde = get_field(env->menvcfg, MENVCFG_CDE);
+    ctr_enabled = get_field(env->mcounteren, BIT(ctr_idx));
+    if (cde && !ctr_enabled) {
+        return;
+    }
+
+    sdata = ctr_idx;
+    sdata |= env->priv << SHPMSDATA_MODE_SHIFT;
+    if (env->virt_enabled) {
+        sdata |= SHPMSDATA_V;
+    }
+
+    /*
+     * Only the first overflow that raises LCOFIP updates the sample PC and
+     * metadata.  Currently updating CNTRID on simultaneous overflows is
+     * not supported.
+     */
+    if (!(env->mip & MIP_LCOFIP)) {
+        env->shpmspc = env->pc;
+        env->shpmsdata = sdata;
+    }
+}
+
 int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
 {
     uint32_t ctr_idx;
@@ -211,6 +248,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
         /* Generate interrupt only if OF bit is clear */
         if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
             env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
+            riscv_pmu_sspesa_capture(env, ctr_idx);
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     } else {
@@ -403,6 +441,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
 
     if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
         if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
+            riscv_pmu_sspesa_capture(env, ctr_idx);
             riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
         }
     }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD1CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQhW-00016W-Jr; Mon, 11 May 2026 09:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhU-00015V-R1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMQhS-0007cb-Nj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:29:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD5Yww453885
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iUspq2xRT6a
 0BQ1RxGBvAupQKezv1Gv0gBE2wUXI4Yc=; b=dMtBXovnHnHUPeNySTYlaakuWqJ
 Q3WJDCH4XDwie3IhCNDSs40wtgm3AwsPqZKXy7zEp3txAAj6czCws26hundBmS1x
 ArzC6QOWhf7k0PpL1hYZ8JfBN1Qg5RCCJAR0ax4rnEypZHFLLzUkyY6PA1nsc8r7
 UhksUv3UsSK/8I4PkxzbSN47K0APYTwi0FMYYv0/rtxyvxYbmqXmA8GNB4WPt0SD
 ckexAdTZctnCOIz+PVbhy8Pbg4vZKYDKeFErLVEemO978pyMgLlyx2JhsUuYgZyF
 XDxbDxp3wKrAug3q60xjnDmKAtsFn4tCjc5ISd65heePHpX/vxJJ3zNhifw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h9mb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:29:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ba9baef44cso70334966d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778506171; x=1779110971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUspq2xRT6a0BQ1RxGBvAupQKezv1Gv0gBE2wUXI4Yc=;
 b=KtLV1EQM1HJuXQkF/lNPv+QGRtfbhD1+OX80RbqLhbqT88zv5QLow8XIFnDUnHh4TB
 h+3zwnBe9qmEckJdI/GqhT5diTTe4L2AbYNQvPrkfGfG7w118HKlVWLJnL/eUId8YKIh
 TTAGu/eLGdTMUO9c7f/EPVqYeKxFnd9jmSahODjgx7GotpUfNT0mM3GjoEnkW97if0mA
 svQWhD1On74nEfOpbRE1OC76NhcWgOVqXUwjAnVX37Hx7LUHNh+k7Qr7KiL9eT65xs1G
 hb+aCdwgs8HzsUQESmuzrrH7EVbTYYQOY2VH4UKiCc6VS9PMWLTz46QFFO7dso3JEc6E
 kDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506171; x=1779110971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iUspq2xRT6a0BQ1RxGBvAupQKezv1Gv0gBE2wUXI4Yc=;
 b=pOgNG+jMf1EHp0LJKaOWjsasSVxA5/mokUvWf8SmfazXrhTNmE/iPGw8ruVDj5waVh
 GwIRQPBK5Ro/ajE+HbEPyMG2pM9+YeivaegBcv7M8vQXJ9WdPR0SEYC7iWeaKj0dpjro
 Cn2E16OUq5c9N+sdudKmLUonSgZWpCBTw4U/JP1fTCwYKQAcO/kdsZOw+RXx1v+4s2kx
 r+ocyMgT3T5dzAlYpm/08T9T4rVozV4BQ19r3fL96mjC6VoZJSAq/B9oU1cKFd+WHgTz
 7+mw68Lkh1RPWUSPSciMumbsWjlHl/BIMDpzXS6gRiT97UbDHIXFFCxVSnuF+mga3TYY
 bhNg==
X-Gm-Message-State: AOJu0YweKCcU+1MbumOMsouwhjperBWkQbVj6E96GkJwHGoHB4OHnsiO
 73nDsxteTpxXT5N2KP0YxhHD+7dkB8jZoRtzmILyrGL6HCfVKjAap2asrPX04TzzHn+BUxoLyGs
 lr0uD0J7mBtPMeCgkG0k+SuSdPe9RMZmhjGwe9PaYM03LKFBLH9+kdb8Orx8CfVBAzg==
X-Gm-Gg: Acq92OE1uzmJxxg6/U7HKspIeErKYreHFnWWuV2MxSJAcpO46PMgyvC03w1PRLdOXrC
 Z+E47HsihvVTHOtyH2fXLD4bRgBYPY01yV82+R+LuSevhJCczvBkamwYy50wPmBh6hRNjcdoD6e
 yPyBppWc1atrylbiwoehkA9dc4TX6tCjxoCp+nFSt6vbUENN1lPbRjlsBCQaI5bAP3szqSAEPEF
 +gpUEt4MQzqlViDB+zy6zhQ34dSAJ+Zw8/mqTH1umv+6/x8fr7SuzuiSewvWVg00g6+sAKqgwRE
 KvC/AUa2gx+wNA0dmzZ1snkJoCPFFNHAbirgpbpEyQeH0j+Q8Xiy0NikUtzd1ySf03788bF9Isk
 Jk0RDwZv/I/M5jg1M+DRzx9qtkd4hwWMnXx0rSMEsF7aDeOhcM/YX2ZTsncyI
X-Received: by 2002:a05:6214:3f8f:b0:8a0:4e92:c45f with SMTP id
 6a1803df08f44-8bc42b685eamr384721206d6.11.1778506170761; 
 Mon, 11 May 2026 06:29:30 -0700 (PDT)
X-Received: by 2002:a05:6214:3f8f:b0:8a0:4e92:c45f with SMTP id
 6a1803df08f44-8bc42b685eamr384720486d6.11.1778506170143; 
 Mon, 11 May 2026 06:29:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c81b3fsm95250326d6.29.2026.05.11.06.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:29:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 07/13] target/riscv: remove riscv_cpu_named_features[]
Date: Mon, 11 May 2026 10:29:04 -0300
Message-ID: <20260511132910.1738069-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d9bb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=tsLqsuv_eFHLPcQPQHYA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0OSBTYWx0ZWRfX9iurBHNTPxLP
 iioZd7oyNIbIzX6pn/JvDBAzasJ1qA6tc1mct7wwgHok301oifqQvcXdPN5TLhPkxXhR+SEAu/d
 N/VjpZjX+NDBqke2eaYaqt1WPefGmxb+oIPJr/S65UjFqk+lJ9bgJoH+TY392oXgFxLmf53W77A
 izr/jRxlDiiNL/xd+paBZj/XLkrxLfVRZfGwm/WcNVSYai8TlGyiHBJ8DGMvREIKv/BFSeyZkLd
 8FR7Gm9ECyTOrnRElDn6gdOrL3eZgwQ4hrAhftbjidJgT4uox01lFsxfbLEZcWPzLoUUycNRuoE
 bqdatfLsbj754AiSurxoQxl163XkyFGzuoQEpe80RpGEsl2gGm/AwO5/v1vSVnM9v1cn5ojDx3B
 ciuF0flTGVvHp9uznoW+FjAG0EJ7T1ijjbIyUcK58N1Et/bIHk47F6wKkEp/eCQqJ8VZD96BM/4
 D5E8B3exsbdx0knbQxA==
X-Proofpoint-GUID: p_7CRmnTcWaoMepQT2tiM-1yMF_OCmim
X-Proofpoint-ORIG-GUID: p_7CRmnTcWaoMepQT2tiM-1yMF_OCmim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This array has no uses left.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 26 --------------------------
 target/riscv/cpu.h         |  1 -
 target/riscv/tcg/tcg-cpu.c |  4 ++--
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 047f81b163..4940596ffa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1407,32 +1407,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     { },
 };
 
-/*
- * 'Named features' is the name we give to extensions that we
- * don't want to expose to users. They are either immutable
- * (always enabled/disable) or they'll vary depending on
- * the resulting CPU state.
- *
- * Some of them are always enabled depending on priv version
- * of the CPU and are declared directly in isa_edata_arr[].
- * The ones listed here have special checks during finalize()
- * time and require their own flags like regular extensions.
- * See riscv_cpu_update_named_features() for more info.
- */
-const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
-    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
-    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
-    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
-
-    /*
-     * 'ziccrse' has its own flag because the KVM driver
-     * wants to enable/disable it on its own accord.
-     */
-    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index fd9c3c4c9f..ea6f3e8731 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -991,7 +991,6 @@ typedef struct RISCVCPUMultiExtConfig {
 extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f4a6838626..e17203dbb0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -454,7 +454,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
     }
 }
 
-static void riscv_cpu_update_named_features(RISCVCPU *cpu)
+static void riscv_cpu_update_cfg(RISCVCPU *cpu)
 {
     if (cpu->env.priv_ver >= PRIV_VERSION_1_11_0) {
         cpu->cfg.has_priv_1_11 = true;
@@ -1127,7 +1127,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    riscv_cpu_update_named_features(cpu);
+    riscv_cpu_update_cfg(cpu);
     riscv_cpu_validate_profiles(cpu);
 
     if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
-- 
2.43.0



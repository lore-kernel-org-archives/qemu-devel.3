Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD6D3940D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Faa-0004hZ-Gb; Thu, 02 Apr 2026 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaV-0004fE-TH
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaS-0007nS-SS
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327CVWa3044437
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0S7Zfen1BUQ
 8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=; b=lwF3Ig/KisnwOEwsDBc5sUvH2Nh
 7do2BnYvPNFEex7XX/deznUe5B2PAMVD+ADxKL/KxJZD0S4HSBxyzYVz/K5KrwPz
 ZEv2Yn0O5lQedQYbgSJcnwnlG8lBiTqZV5DalJXyLB06Ud5EQn4H1k7PUcnEGGBH
 dYP/TWeShR6BqSOUvrlLn1BvoJBKRxH0ngRMfhs44tvWXonXM6bpRp96hDO9Pn0a
 foNayb+K9y3U89fEyZ8uY8++VZn3ut6PZuLOKpBm4H57RZky2xvoUd5h0GtlEzQ2
 KN1Lt2LCVJHK7lwA2jSM6BBJRfWX3OemBQTkk2QUgAg6iciQtIXlTqjrI7g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9483vevp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c72849f648so3525212eec.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126861; x=1775731661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0S7Zfen1BUQ8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=;
 b=ZljdqLDiXzxALc0IyHII/1KN0x0k4ToDIWBwRDNo08ldNOcWFuu7HvpqDkFCv34aB/
 xoJ1nHKBtlIn2Kv3AGDRPWPP25GjuEhCghSSyAJ9L2bOB1kPzlmuTD+l9L0ZFq3frd2k
 aL5iyhPDoaBeElihSFo+xFWkxMY2RMZg1hDI0BM2XyTCgc80AnQntW3M/ltm6bT6UZXJ
 CG3vCCrxyc6B9MdMVYVKseU9iDoMwUxiXNIj4IlR6Ve3st8OrQ+4vSP2S8J095O2w+Kb
 B2CZxacGRWnm8gaI9yO5QfNBKxpbVCgrSCzMYjVZ5eecDFHabjduxDCoXFwvsATQeud/
 XTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126861; x=1775731661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0S7Zfen1BUQ8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=;
 b=fdhgS8yZoDEBG94Cq8JJadRPV3T8RW9S4H0NfspN2bY4tf1u6Qi/AIgp1/GSzO/FWo
 2bJPcEo4VSr9uZfHuBZTBatv60JcgKVZkTKpjT0y62gHZ1titKQn4a1nDGTAY/mrE8/E
 57E4eJto2mlCaE6b7sPiNRWRVGjeVzTRFr7YxrtlBuBWyAhiA5m+JywX6vauVpLiWWmR
 f2U+KTXUJC4yFoKjm9IVL804bjQjeXckyQLVo6EFq0RQo0t+PXjHc9oFqx15+phrdiKJ
 2NBzOQ1DrfJ1m2v3TR+Qtuf7TAOfSbEHbwHgFkcjJLyOp/OhcXmDgQF8gF9QNhWZwUWP
 ao2g==
X-Gm-Message-State: AOJu0YwXviw/2zSV3XHQAiMH6/QugYv5VwRTzH0XQR8UPgypWE6HYDui
 NI1x/JTbsu/ZMNOgRMFx8b6+4nyKMCAFtabl1Fmgcagm11ERddo5GaFYqU4ml3y5nrzvVuSyJDl
 Xt2kTuyf2xOX1JWjfnimtCNwaX4o8rKF9E2gdfGTSdXkE7l9a+gNwkFXpW+NfsJs5XM9t
X-Gm-Gg: ATEYQzyzS8DpGJNTUs3A+BWE54AHRCjm3LrSZegFI37MALP67mjPT3XaTghPcG5kJPE
 d2Epq0hk2O+KUkQNJDK3DnmH1kP9jS4W6+VdBzTmkwrPwlfjVcdj0On4JzgCqPNRJcEu6DakVjI
 I88iUgLEKXSNhbiu+Lv6U6wwLuKzLta+ALma/gu3lrfJj1Lhvy/aGjPFn82X8W3sYFWWyZLPamS
 obE9+sXj0cV3wlE4Pvbu0qkxm+KZvaQe8ur3s4f/o33iZvzMQYgQ0WYTg8Smk+4lOyNQt8DBTOE
 i3yJECzqUycCXQxJNtZrYZ9mQmC0L06P9EJ85tQ3SdZtuiMwGzAV7mkFWpAg93X0OBmS4wVuPuU
 3+83iVYiNxGzWl//VBbMs/NsWYybCEh6iUX06LOLiSiwbHXtBZVcGkdiMo8cRKusj7RThG10/BO
 BkSjOV42vt
X-Received: by 2002:a05:7301:6087:b0:2c5:b23e:48a6 with SMTP id
 5a478bee46e88-2c9328abd2fmr3675947eec.23.1775126860598; 
 Thu, 02 Apr 2026 03:47:40 -0700 (PDT)
X-Received: by 2002:a05:7301:6087:b0:2c5:b23e:48a6 with SMTP id
 5a478bee46e88-2c9328abd2fmr3675927eec.23.1775126860093; 
 Thu, 02 Apr 2026 03:47:40 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 05/16] hexagon: print info on "-d in_asm" for disabled IEEE
 FP instructions
Date: Thu,  2 Apr 2026 03:47:22 -0700
Message-Id: <3ff972307eb799dad24ec655759ee37aa788ca1f.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYydyltv c=1 sm=1 tr=0 ts=69ce494d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=uwSgyZDXI7pCxt1u4dUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfXziCcT6Yp/wby
 AnuDEdEY/hqClOkgfl9tOK0uZnD1vKHemmahieIkgelO0qNCfkAcDRdT6mNkDb7BRdL7I5jBTwi
 fHVfK2QeHSGK9yFUm2jp8aG3jssNZT3GTKOQgS5lT/2KGKDxWJpo8VWIzYf8u1EIYgnEHt/apuG
 Cak+5v7Y+qPfQEe4KOzdyOxAF7MQXNIdDRJwbx4x15toijZ+uqOIxNfi7nDoYTSFJcoDKHsIc44
 B7eSdZltpLejRnlKh0GRp04OPPirgkzsV6mxrAbADOa013snWmJSjgmeGPQRtTwiDtkonlTUg89
 B7KdFyuCyhKPG8qytNSlcHjCVoKruXE6cptwLCHTbFq+xhaGXKLR4scYAaG12+B3oJ/0ta0irZs
 H6avN2jQyE+zzjnBHLRCnXd0HYZVhMZ6YdCIpvcoRvMZ9wBI5i/fTv/iDyQcc7kg51Q5xu7xq4f
 JZP/zz2Ua1rg2rVQjfA==
X-Proofpoint-ORIG-GUID: eUY9D6Uts2z6iNn0V9jV14Lljx_xmFqd
X-Proofpoint-GUID: eUY9D6Uts2z6iNn0V9jV14Lljx_xmFqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

When cpu->cfg.ieee_fp_extension is off, IEEE FP instructions don't get
executed. Let's print that info on the "-d in_asm" output to help users.
This will generate an output like the following:

0x00020e30:  0x1f82e1c0 {       V0.sf = vadd(V1.sf,V2.sf) (disabled: no ieee_fp) }

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_bits.h  | 3 ++-
 target/hexagon/printinsn.h | 2 +-
 disas/hexagon.c            | 3 ++-
 target/hexagon/cpu.c       | 2 ++
 target/hexagon/decode.c    | 4 ++--
 target/hexagon/printinsn.c | 7 ++++++-
 6 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 83d13de569..1f9e617d72 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -72,6 +72,7 @@ static inline bool is_packet_end(uint32_t endocing)
     return ((bits == 0x3) || (bits == 0x0));
 }
 
-int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf);
+int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
+                        GString *buf, const HexagonCPUConfig *cfg);
 
 #endif
diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
index 2ecd1731d0..6a45ec571f 100644
--- a/target/hexagon/printinsn.h
+++ b/target/hexagon/printinsn.h
@@ -21,7 +21,7 @@
 #include "insn.h"
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc);
+                         target_ulong pc, const HexagonCPUConfig *cfg);
 void snprint_a_pkt_debug(GString *buf, Packet *pkt);
 
 #endif
diff --git a/disas/hexagon.c b/disas/hexagon.c
index c1a4ffc5f6..e2d3804606 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -57,8 +57,9 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
         return PACKET_WORDS_MAX * sizeof(uint32_t);
     }
 
+    const HexagonCPUConfig *cfg = info->target_info;
     buf = g_string_sized_new(PACKET_BUFFER_LEN);
-    len = disassemble_hexagon(words, i, memaddr, buf);
+    len = disassemble_hexagon(words, i, memaddr, buf, cfg);
     (*info->fprintf_func)(info->stream, "%s", buf->str);
     g_string_free(buf, true);
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 5470d9c7ce..d7f4df5f96 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -307,6 +307,8 @@ static void hexagon_cpu_disas_set_info(const CPUState *cs,
 {
     info->print_insn = print_insn_hexagon;
     info->endian = BFD_ENDIAN_LITTLE;
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    info->target_info = &cpu->cfg;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..d7ce8c8e1b 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -801,7 +801,7 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
 /* Used for "-d in_asm" logging */
 int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
-                        GString *buf)
+                        GString *buf, const HexagonCPUConfig *cfg)
 {
     DisasContext ctx;
     Packet pkt;
@@ -810,7 +810,7 @@ int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
     ctx.pkt = &pkt;
 
     if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
-        snprint_a_pkt_disas(buf, &pkt, words, pc);
+        snprint_a_pkt_disas(buf, &pkt, words, pc, cfg);
         return pkt.encod_pkt_size_in_bytes;
     } else {
         g_string_assign(buf, "<invalid>");
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 4865cdd133..85527f56e2 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -51,7 +51,7 @@ static void snprintinsn(GString *buf, Insn *insn)
 }
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc)
+                         target_ulong pc, const HexagonCPUConfig *cfg)
 {
     bool has_endloop0 = false;
     bool has_endloop1 = false;
@@ -85,6 +85,11 @@ void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
         g_string_append(buf, "\t");
         snprintinsn(buf, &(pkt->insn[i]));
 
+        if (!cfg->ieee_fp_extension &&
+            GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
+            g_string_append(buf, " (disabled: no ieee_fp)");
+        }
+
         if (i < pkt->num_insns - 1) {
             /*
              * Subinstructions are two instructions encoded
-- 
2.37.2



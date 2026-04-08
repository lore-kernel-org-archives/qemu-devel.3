Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA40E10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYSd-0002fo-6o; Wed, 08 Apr 2026 15:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAY2m-0005jX-R7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:54:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu0-0006oE-VS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638Ftf0d2411845
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0S7Zfen1BUQ
 8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=; b=PoABlAdVnZHWMtNITr1U53cW6Td
 ZYDkAOcLr3w7Qvn/xMD2Fj+bcnGyFD21Stfn1ITL0AMxIcShIP3XhPmPH9ehZz9M
 JyeS41fumo0yEb8DDexD8JKqD96ky1NUZN/yrVff2772YjVLq3ViU8A0ZarlgnfQ
 hq/g2d/4oK/96/u6X9+ouEPSBC3RvLSzwcOywgNBbR4b0qmbmT6FmRcSmAgUR2FW
 KdauSYjqUVvZHEXyJZ0LviiZW016XqVvSODJfLwXAR4FCviVjyG4Efz0fIGzadjO
 c+ykH7AvwXpQ8lCJOlNmm4p6cByK7Dzz9jUkQXOql0yOwze1uaVnLzSa4vA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd61vcns4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b242cbb97aso208505ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666235; x=1776271035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0S7Zfen1BUQ8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=;
 b=iZuZvHG3s56A039boitP7IZt5rKL5UhZ1r00HFNUTRhfNrq/0VWEafK8bg8CfrcqWe
 Hlja5/SJgp5mbxb1y8p/i3oEdCGsAJTe8U7CKH4iJAa79jghVPzPg87mF01vzzmMy4E8
 NPqj1Ba/4uzoiiuJDBTm0gkhCmoaOhN9rcJ2GMcluh7v5x+6xYL/dDv6QNq1cfMX1xR9
 hWwzVHaYHtRrw8KpDN177AKsBkQ3YMTba55UeyV3RhcivfmsUacNCa7noK0bcFUZz0uP
 yd5Lv6uN1Taesw64T9IJCLTCJfM3lUcczCIfow++FS3s52f/XsKN1kOghYlOXAYhWK93
 +5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666235; x=1776271035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0S7Zfen1BUQ8XVf0HAhwF1ysgfu/0MLe2KDwvHQXyBo=;
 b=WQ6ppki/1ACKVTGXiJalYnB9NXZ9K2RKCTSbDOMzGehADXkbkDn5BCS2/JI9Vz5ztS
 C1Xq95ZEsLqDVa5/6mFHYPEkj6UKSAcBzbRQQhYKjBnERTYmncsF/P4o3/jJF8A9eyv9
 2zeuyBCCNr9ubiwQMwPLmlz6qER9PjkIN3sRbrbN9VTrLhbz5bKdqMvs4AlWzf4rL2Xd
 ly2pMkCA74agJ1UGQBKwqNOywHlng7/ejDc5bTlUbt0h8oFcdissl8dxXBIpF+5Ecj7w
 PMKwv0QQrs6K7LbxBA8oj7CBpzi+rOwNkdQMgNiybqA8NnIO4TGdE3mSPVv5TLSuesz4
 zU1A==
X-Gm-Message-State: AOJu0YwfupyZuY8iktqYq7ajUNWzP7+i7wtMOXkzdwp07wx8L33fgi/j
 elcF4xBK3xmK8t/9BY008o+EAgxuXY+/eb4x/oO3KPnWtFpSty+F/KowQwN636RFUaRDAUkqKCy
 t7qfLQDXWCT6HE5QrdqceAW+N7TGzGNNNowX54E0/QRJFVPeIUveAU8wkqcr364/P2YxO
X-Gm-Gg: AeBDiesX7LQMWRBZsCEyk7TdQUps6zfTYicaxxwIaJ6Mv1P+gd8Mhl6r8AuVz9MZIco
 hb0iAWhQkj+DP5+M+OkVDc6IzIQLO6VUQr17t71y/zgfiyP+K1p0KI9Pv3+VfrbqARGNsTiVtAm
 M59WpdlaoGvI9z+XqwtmDSgpLcflmhg0U+6LQE1cBk26A41Y3F49KYPr2kbNN0O9Djv/O54LOIY
 iQN+O5JDkPJRdkbi4f4DPKiBplwaSNOMC5fgYT7MUQx6Pv6Ymf+m3AHEHoodBS0YHMaH5+qEdEN
 X/jgwf7d2i7T88RBco3BZBnVBYM3AwfmFayusHSd1cMBld3wHvF6Ri8okDUNCrzTJWlXYCJV/KA
 WrmH+Fo9k2YR+jDD9O+DOKSSwCJ2vsA/dfHgZYlWvCJaGD5jjS/r4FLzgn4MztzOV/AigN7EbdN
 /P0zWKCoxQ
X-Received: by 2002:a05:7022:90e:b0:12b:ee8a:19ae with SMTP id
 a92af1059eb24-12bfb6eb332mr11164165c88.7.1775666234631; 
 Wed, 08 Apr 2026 09:37:14 -0700 (PDT)
X-Received: by 2002:a05:7022:90e:b0:12b:ee8a:19ae with SMTP id
 a92af1059eb24-12bfb6eb332mr11164142c88.7.1775666233937; 
 Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 05/16] hexagon: print info on "-d in_asm" for disabled IEEE
 FP instructions
Date: Wed,  8 Apr 2026 09:36:56 -0700
Message-Id: <192fd1ca5cefcac271f5efb4cb0b5b15e671f833.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX9gI2eme8iyMc
 tKYvthUi4rqZwG1r4aO1eukja7ZUyyuH45Jc/VMhOTBUK+bMOnM9z1vnctg26m8iZ6z1OiSRnuT
 II/xzYGuNcvF3j4FcmGuUoCd0+gOl1LBKJzh1FmZKHhgfgvJzxbs7I5195aK0KPKZfqmWKISd70
 GkJUvrS0DZmM2TzgYE8J0BH9v9+FJcCsCJZEGHz6DrZxYKLI7vOTg5KOKgv08etEsjhzsmPe3qV
 XHNue0E+e4NtBMyi5PsYCTOmh3OTtQ+4SfKWr1Yyt0yL2bEzr2u/Rg7yHQ3ODNSIyPptA134Uoj
 T1oPJmYRkJgJIAPQUBl5kPiiCQyPxCasADhO4GEqjsYatqZfXrzTks9MBHpIRFZsrcp0wuy7Ksq
 ChnGvqGSJNGqKn0JLa6KS0ztht3indfUMAEs/6DqiFuDv5QQQPvPVqgyzKxYXraWMmb4PBFzl1N
 Eq8ItT+STOihQW4tHmQ==
X-Authority-Analysis: v=2.4 cv=FecHAp+6 c=1 sm=1 tr=0 ts=69d6843c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=uwSgyZDXI7pCxt1u4dUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: qPfrfWUy-aMQsBSpMunofxs5FIyka0Vp
X-Proofpoint-GUID: qPfrfWUy-aMQsBSpMunofxs5FIyka0Vp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69B3F8A15F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4Q-0005EX-D8; Thu, 16 Apr 2026 07:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL45-00056T-OT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL43-0003AF-Rz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:21 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8Mhjk3733617
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ybwCHZLfhny
 CfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=; b=Byr7ot8ieGuX1N5ri82I7lmiSfV
 aCBL49jm6QfNYZ51/0cceMu7jAKUQK8jVro6F+fH9s+BXL6bLHF+BO25oHdf3C7r
 KLZeSxQ5NrU7qz8XYzvv+nCyK1hlCO81h/fODpi9Cc2gmnb1F9F6SQjkACkRtNPn
 nPDwxzp66hJTZoB9ZJAU5a/98s2/IB6yNyacVuNs/c3cEdNK9aTHMX5SjFSqUPm4
 LXwGeMEuyuPbRTBujxifs3Oirs5RMKZ/r/F3T8oyf7EqaS2GomGrlSgF5+7yJDld
 f0wNUTLBYcQh2n03/i4CoQh5oximnozeqyybgM9hw34Bkq40xc1W00Mh9mw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwktwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:14 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so10020963eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339554; x=1776944354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybwCHZLfhnyCfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=;
 b=h6ZEQbX/QjrX7HbI6dQUmbZ+IomVEpJrxNxhpQdHEUgk/UZhompraI4/ytELkj4zL1
 4LSez+RrcOagJg0poBGGhYO2tX+SNkdBzmN8YVuuOa5awYxL5rgBbf8xHGnah22yIcyx
 xfHgcMMb70dcywNAmjgm8Pr6glWI8X8pdPaidf/yhHgViNCAQRWfw6MHeFi4LsV5p0Ro
 /iCh3oe1lmKJ8U7hRg4/r0KOKuIobWTvCHhmSz3q57bxceK3D3AslzLDpcnBH7LAbq0e
 udUAasU5g57xJ5AtClhbIPNWaVDB+EffjX6EvyD/QcgDSuRIp92+2/8q0HcJs9MIERGk
 3/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339554; x=1776944354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybwCHZLfhnyCfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=;
 b=h5tb476SqSdXI3pT+Y+ETuurb8dSDaL8ZTjV1S9YGIuRS5LicxsUk2OTv6QxatIMYk
 /JK2j4N7d0cnhj545lI3HhlAT6Q0UcP4HALZ1f01+xBX1CYxR2kDiIGKwPBMOBVpMpvt
 36dAOmzsrfYElGJAam/094PxmQf+cuEAbSDOT+E9eW7TwRZtpRsdbxv0c7efBBqz3Lo6
 BlU+ArMVJ/0uljzRUH2L/+lcupXdHy4hgcjbxaBwaBmkN3tVirrxc1Q1mOUh+Suh+4Uh
 UtDPsdO/ufRUhs7ACBgkl8/YqBOf64OynBpwlOJPGD4akg2D1dIUFe+38Nb4Ean3gnnz
 Npng==
X-Gm-Message-State: AOJu0YwM57GniJN5dYCEECvPYq13SzvQrBh1axg30BBpFwN6q/xa7qtP
 qskut1TlsZKPkOa16QxSqSYrXtbT3o+r2ZQ4U85kpujwT1XN5e+aW9RyHLcB8Z7MDiRDFedGTwW
 j/Lh5UskxbLecxqsqUc5LroN9Wk9jy8k4d/oztPPsN35cZxD6+wRjBBt38Pf66cVVRE9d
X-Gm-Gg: AeBDieurG4OIl0RSLZdFbEVejjzHsxKDrVlZc1Pg2vQuV7sSjab25CcYTDtUgY5LdY/
 1ItnbOdxZW1G8KqGfTl2Djhs1rzTpPs/ZsDa/ScJWOV5INAdfG+6/vhs0rj4WnJJpB8k/uji2sM
 ZRXOGOa8C/9PHiyXW+SOw5bB1WmGWqzHjzF03pu3JNYTnbQFRywcjBiZejdSTYnp8Y6hlPJtEm6
 QUV9Jfvf57ydye4Ucc5c4VK3Qx6XvYQFXL7oToqFaKBckjZBl8ZCXbWev4MmWkrcwPG21i2WcSg
 kTwZhCMMMNSl4zMw4PYZJoofMwISTqdWVfgpYaA4YTc0ku7chIAqsxgvkSKpCvtUHB2hip+7y4G
 eJJszl8GqSKLSKgfpwjvBxkPexLYbLwlWpka14VXLzBKPX68jloOjpMkHoTb5BklmfjBW/Fg1r+
 jDnMDCTYtntqaPkk+yqGs=
X-Received: by 2002:a05:7300:a287:b0:2c1:3f85:747 with SMTP id
 5a478bee46e88-2d5894628demr13808502eec.21.1776339553495; 
 Thu, 16 Apr 2026 04:39:13 -0700 (PDT)
X-Received: by 2002:a05:7300:a287:b0:2c1:3f85:747 with SMTP id
 5a478bee46e88-2d5894628demr13808475eec.21.1776339552863; 
 Thu, 16 Apr 2026 04:39:12 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:12 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 05/16] hexagon: print info on "-d in_asm" for disabled IEEE
 FP instructions
Date: Thu, 16 Apr 2026 04:38:54 -0700
Message-Id: <1bdc772e4a795ecd9f5bf2b7e7143cc4b297318c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fsy5q0_QbfNxr2g5Zma8Vfsm1J0CRdw-
X-Proofpoint-GUID: fsy5q0_QbfNxr2g5Zma8Vfsm1J0CRdw-
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0ca62 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=uwSgyZDXI7pCxt1u4dUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX+G+q7TCNfhC9
 Rhs2Nk3qjKe+YfteQaz/mfrPLvivhieLpq57qipwe3mN0K0Gjj1YyMuW2lUSYBBF3sd/PKOv/FA
 JIZSkffZu20XYGtbGvtUrx0YnTVopG0ysOJrrj3gPff3xWdfEjA/RVbslVedJHdAkaWPjfPsmEy
 yGA43JbCw4kS4J0zvmGvvjJhnu3DC3BodquUU44HZlDB+vZBEvy8bycgKWWzar6+k6RAhpTFpcc
 5Smvj1tigrm5N3YrxH4XbuthqR0lSkvU7UvrEObm5DbtORjxXQtjPxLQV6G0aT+N/vMnSX496mh
 zvDF37hkrfCaLDIXjlZ1+KJqv2own9IvC/P6XBb5Jeee7m5XbtwkXdnq0ytdhZynAqNDhZ+s4BO
 eVwLb+ZWLquqD5uhoIyKeBOeKVvAM2CTU3Fw66Mkys+MVymC5HsdEsfNK7DMm8Lffov1Ur+h4dH
 OQ2YnJjlFQG5oxmhVGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
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



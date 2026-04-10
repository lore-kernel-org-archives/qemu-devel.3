Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675BEF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5c-0006od-9Q; Fri, 10 Apr 2026 13:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Y-0006ml-SY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5W-0001Yp-DM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AFJAJi3118235
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ybwCHZLfhny
 CfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=; b=czj12LvQjd3dtqYnEEiq9xypWBF
 7EjoWChhCC03C7goXFtkkJGI8nznFd5foOhfZ7pMv/x/tsWGJPEWnzvF/sT/sxcB
 R8ZFcJ/0ZU/19Co1p4m13cwjxi1U7YBaxs4TcQ7+Q1qk5oDAVrGfwe1VNOxDp+AO
 nJec0x5vVUbOIXVnw6dT24PZuvlHcqgo3P2FGap8sm2p9uFtA26DV2N7iOV6vs5i
 2dxSoQTIj5Bo3fAP12BmPUQEASDPd3ykOg8y8LbABjq8YywX78srTC03295MVJmb
 oCw5MKBSBz/gMAN2hJJ6IntT/iQr+n0jyIjk9A5T5Z2BIhQWo7MIaE0zCoA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4df3rarexg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:13 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c28353912so1965438c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843772; x=1776448572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybwCHZLfhnyCfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=;
 b=dqS5e8hqzOTK6L7zLHRrJsv9VETLeXPGX7kuTNlT4BTQmdb6RFszsRVuAH/xXx3Ov1
 LNal+5gOgQrprYkr4GRUzcFk6oWW6WrZv6y//NSNFECYIhl5aRVM6LWtBEecmXp/GFI0
 b6vO9ZiBkxXEAMVlfRb++nYf4qQsfdJH5jOX84LzZtGa8zUOHys1Y+QLON6GKxrotSwR
 qTsf0I+B/F7T4R8O1F+3QdtsabEoERVWpZNwxlL+2dSxJB4lInf6lDw+mqLcCI5tk2xM
 Z+znJrK3+8yHSmMs8AX7N2kRfG+SERnE10ifMMEwEAx9KzLKLieoDzJY1rlZfj8VrB6y
 uZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843772; x=1776448572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybwCHZLfhnyCfuN9WWdAhCLFmoos/vVMcKHV+YU2Zd4=;
 b=bJh+x0es04DmOvxvCDQLd3gaHmnyGES95bzGWzviXyZmq+xkG3TZCvW59SGeQabFKc
 Rb4zt7sci1X3vHyVsTqwOGziZpf67e6VGjsc+Z5v6rgL5whoLonoBQrmzjmepw+K9NuN
 xITVGO8dueCgpvJnDsBJZHFr8qxdkVmVNGhVeDofaEaVq3pWll/JrElMgLhtC1r4sOLX
 Oun4scnq0z/rwfImReOXccMlr91Inv9jDij6W8v3ynByuQ5B6Zsrt6SjBO7O2l9r3I3O
 m967axyf1422k5ekKBLOXD13rqHVciRdPAx8knRwANnSLTabWmKMLR+oljABTFmNDJjP
 zhDw==
X-Gm-Message-State: AOJu0YxpEryYg6ol5MSUZEGwqpaDKR+6ZJFCTQkFUD5m2zwnGwZO0m61
 xOueSEyEYC7foIclQu5jZZiR64hheo6ybe1bjCJj54nBHCKGP+yEzmFgPowPi+1PlD6Bv4ojdtP
 MwVGzxxCA4xPd8pdIhc7z2xQedakSxHPvTDIivLdBVl97knchl8zMSk/EH9hvrXdLwe8V
X-Gm-Gg: AeBDies5ZtlEmIbuiK4lcd7iVIBti05o7MbwfywsYC6qbznvWlONd8372qqkOvTqDh0
 GkQQB0Jm161DNfh6HUyFJLk6AlubvTF5nI5kBMatt/Psjeof8fvaffN7Za4C9xzsjqTM+CHnwni
 hM7ivY42FrXIRgAxF8eSja55XsytYe+NXj5fUQrMSMLQpBB08uNjnnV4rl/MQgUpAkP/9Ewb0Sr
 bNkZMMtEoxjM/Z52YaYgI8BjOx0DTSuV39b7lbUQA31vEHnYL3l64SRZzQ58hJdoFG1EBjxdXXZ
 9GNzAAOS8XJh7H6xqHrjPxTzXNKp80TJIguNvAGavNEOyd+qyPszrMJ25UlkTEs8hGW+GzRoaEB
 J1saRgtOzBVBw4mRhoW9BztfEy5kE69Wvh4KpXiRBRXrTAu4AvuS8iPdeYsXsVI8GmVcPBDJU02
 ck6rhhXRuM
X-Received: by 2002:a05:7022:6890:b0:11b:f056:a1b3 with SMTP id
 a92af1059eb24-12c34e7fe53mr2429678c88.11.1775843772168; 
 Fri, 10 Apr 2026 10:56:12 -0700 (PDT)
X-Received: by 2002:a05:7022:6890:b0:11b:f056:a1b3 with SMTP id
 a92af1059eb24-12c34e7fe53mr2429647c88.11.1775843771492; 
 Fri, 10 Apr 2026 10:56:11 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:11 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 05/16] hexagon: print info on "-d in_asm" for disabled IEEE
 FP instructions
Date: Fri, 10 Apr 2026 10:55:53 -0700
Message-Id: <e24b76d95a5e7f45b8ca2fff8c89df89a1f4ac60.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vs4Txe2n c=1 sm=1 tr=0 ts=69d939bd cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=uwSgyZDXI7pCxt1u4dUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX8tPrXJEFZIKJ
 VTyVw9A4kPdkxZpWgEVMhMg+y/laH5+0mazohCAzSQz4svr/maIPl+D3Ri0KiRPMAgDt0pBHdp7
 /9dBGld6SyXEJR/zY9NVonUP/zQUGG3ofK12KV4hmqtX2lsrVQ8ICzUNRH0anbwBWBWgHyg0xnf
 r/kZhwvD3cR4sdSD/94Er8l4xEcjjnvKVAWoBzTQIVlZLODn+JPqPeFEPxJXT3zhQP9mURdH5W6
 7YNV9odVVB8jZKUTZ8KOEHIPB2OjQagRacBWobY0LV9ZHVOSGO66XJeIJ74xrulJ4Yq74KNvYQp
 iQ6hSzuLzfZaRQbFjZMEek+SzqMRkXE4uf8v5aZ/aoLlXwYnuQ7amd6D/Qi/FZO0smmk8X0KuBJ
 EvxkpJzwflxeeLxufTZhWY0Ky2Cwi85KlDU75p1C573WOZftPIaRppVH15nCPU3Aq8bd/kRcAGn
 sM6IP2HDxyv1/x0/Gmg==
X-Proofpoint-ORIG-GUID: 4-8ecqawj4QK7Hw4PoIUwVgwC7HJTkts
X-Proofpoint-GUID: 4-8ecqawj4QK7Hw4PoIUwVgwC7HJTkts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100168
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



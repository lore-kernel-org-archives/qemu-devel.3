Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE5CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRLl-0005KZ-CN; Tue, 19 May 2026 16:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPRLb-0005Hn-IR
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:47:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPRLV-0005DB-SX
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:47:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JEwtuP1637265
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 20:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=FypPL3g7Kl1kPAg3OfPfg3Q5oazJC004v0Y
 YnPLL/Vk=; b=Rc7WC1P3HzqFTn64X2eK1FEoBxATbHsspVPUE3fWK7AV0RSXdwx
 d2dmfgfnp4jxfrpEuNHBHacK2PJ1lL/6Rtf/HSjoJk/lTlLZy7T6chfwLt+3FkP1
 OFVQvW+rY4RUvpwVUszI54R0eYQK5vaMyMZuulzFIbsUsuZxMJeNpqCBpJJrXkaQ
 Euo9I7Eus9Ky8bJGYIcDtFGTUwBOKb7FyMxVf5fKCCe41PsNeDnbJ0QHcNQl9qw4
 iIg4ds7pDbTLBJXE9bclsFytSkDOCROalE52+m1KX6R8bKnRgLUORiMn0QbAmtFz
 HxkFnaPoNVQ2ULY9ixui0Gy/+f/Fa0YFbcg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3s9cxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 20:47:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b552610488so87640226d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779223640; x=1779828440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FypPL3g7Kl1kPAg3OfPfg3Q5oazJC004v0YYnPLL/Vk=;
 b=d0oVckifEMTURD9kCjqo+YLN9mDDdjypBdQRuVdM8y4D7QAoYME/bWeKmzCP+ukHzX
 vhtCOcPhOB+lshoXm9AhFAPMirjJu+AdWO2AQFKC2sTea+v/jgHJqXZMttcdfJDD8dcb
 WRoFea5xNyb75hkc2Upr5JUxQEF1fuIETIKtpEz+27sCFxTuLoIID2Xv7XlitEr7HoYy
 XyxmIOFREaNdn+1d2xUPHncd3F3CCPAV91bjQXxelJMUtVOCCH++811q2WkFIR3ZQdYS
 ykYgMCEmOkq6ltwabYD1i4DqzHW+mwGdhsFocDdYezpqlV/5uI9tcKQhd/YmeHp2x9VD
 V//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223640; x=1779828440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FypPL3g7Kl1kPAg3OfPfg3Q5oazJC004v0YYnPLL/Vk=;
 b=JV8vKaOE8ie3DC2v+IxQyG+ZGCUR5FLb0I5LDKGQoQaEf87puJZ4WFlmV2TbKr9nYP
 qvtEuyT4YE77g9YPQR05SYB7h216qaluLgzJkGxY6tcwxhEsYEuAXZnsKkJCdtOMb1Jw
 4Pzj5jLcEqVLIBeWMwNhIggDcfYQ88LQvxYrcEcbF95YJllcHAaTdHEbXSaSkGg/c1Gc
 IJe4YMGjTwAqXNuk4CHzRfAtJnS1wxYPye/UXmmkSAZHNYc1Qu6o1ps9u1Zgcb9+xWIJ
 Mi0DLgmy+bg4VUaNKKEWHW7Y7+5dlrbYRotsa5lZN0Y1XdWxcO/xESO3Mifq9VHnbKGW
 IYXg==
X-Gm-Message-State: AOJu0YxTlf2rAHA6vHmYHVbb9o7rWSfX5aPukD619CZelB7zPw9dgyan
 pqKaERHK5zTow+l8hO9W1VPAyCCZVxcxD8Y1kmiIrGl1QKpIQ5zTXth7fxBmf3O3OZOjcEPdaN1
 cL4Hg3EJ8Mh9OjfV2cezmveLGhgSjamXKZvMLyF6kwB64ky3AEA8Jg78JA/ABiHu2Xg==
X-Gm-Gg: Acq92OEjjuAf9YsvrQKt6HW7T7K8lSbkuDYFYhJfyAlZjUIvoGIm/VjmS9bakSmRiM/
 aS15ZTboDJ9QCWDw+jnzca7+uWQPPkmsthcmskcPSrBSzx47+oFQoUdpcYYl8OHecQCqwfhkMvE
 MvsHsaifw9DGgvCq+ZczzJVyH9UxrnoV5SKzh3cAeovW9f5tV7P3zaanTe5J/5i19kSvjC5i07e
 RguTWfs9mgYfbFZPRQMm4B59Fq7q7IAMU6qr9sT0bzlGUehyDUhRItsEJ0mQpm9/wfYWdklgBli
 HdIzQWsgxF0PITB0qSzYiqKrgWAOQXauXblBwGIPYU59I0CuqmhMqlukF5qXphawIb77dSJQDBC
 DnPkeuDfx1j4T6NRdfvd3rMrJ8XyAF/cwmWdT8+2iFExAx34Ph2Kvk/yey1tV
X-Received: by 2002:a05:622a:a0c:b0:50f:ae67:96df with SMTP id
 d75a77b69052e-5165a23dfe1mr281424911cf.50.1779223639736; 
 Tue, 19 May 2026 13:47:19 -0700 (PDT)
X-Received: by 2002:a05:622a:a0c:b0:50f:ae67:96df with SMTP id
 d75a77b69052e-5165a23dfe1mr281424491cf.50.1779223639300; 
 Tue, 19 May 2026 13:47:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619b03fsm102584916d6.37.2026.05.19.13.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:47:18 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] disas/riscv.c: add 'cbo' insns to disassembler
Date: Tue, 19 May 2026 17:47:14 -0300
Message-ID: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIwNyBTYWx0ZWRfX/AY0zn92o0XV
 w/3GDzwiFz9EkqrR0rAcH/ettcmu16Wcp16/NHr/j2SM7yMvvasar9mrwjCK4kS66L6vrL2vBnf
 sA1O6GcMrjOO3vGlFjtNDdGeF0XaDTuGbJXm+3oBaSvkYcyPQRkw4I+6pBrkltk49N0BOriQMRh
 H64lSPtvRQYqOR9di45gQhNtpKKLpuFS1dNDC1ftE1ZTMG/XuZfcQ5/m38nGACdSw1HDKRarLA4
 1j6bNxjz/a7tY4+CF/4d0gJMxgVoFCS9bqEW8cjgP8V0QsFvEZoayh1jI67DpzXcYabrQbV1hFG
 VF2gzFnHDOtDw12Q8crFc+Gs5tXe7k+req2op3u7K1fM27X8W/So5ygVOWLy27J9b0RrFLdXgps
 OXYdPQFEkh1J3EBRiyaw+2iAGKeMXfghwzkgWlBnLzXholVYs8WnOl93QGDD2uQqwAp8qG7iPXr
 KCkN3EBDPKd2oR0JqQg==
X-Authority-Analysis: v=2.4 cv=Oc6oyBTY c=1 sm=1 tr=0 ts=6a0ccc58 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=McKnsUwnZl3qh5pntSMA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: gG3tF1iHnY9TKZIqtEVeocpn9MrdHQkj
X-Proofpoint-ORIG-GUID: gG3tF1iHnY9TKZIqtEVeocpn9MrdHQkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190207
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

We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
disassembler recognizes all of them as 'lq', an insn that happens to
share the same opcode space.

While we're at it reorder cbo_* entries in insn32.decode using opcode
order instead of insn name.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c              | 29 ++++++++++++++++++++++++++++-
 target/riscv/insn32.decode |  2 +-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..36609efdf5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -985,6 +985,10 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_cbo_inval = 956,
+    rv_op_cbo_clean = 957,
+    rv_op_cbo_flush = 958,
+    rv_op_cbo_zero = 959,
 } rv_op;
 
 /* register names */
@@ -2255,6 +2259,10 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
+   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -2876,7 +2884,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_fence; break;
             case 1: op = rv_op_fence_i; break;
-            case 2: op = rv_op_lq; break;
+            case 2:
+               /*
+                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
+                * with 'cbo' insns.  Check the next 5 bits to select
+                * what we want:
+                *
+                * cbo_inval  0000000 00000 ..... 010 00000 0001111
+                * cbo_clean  0000000 00001 ..... 010 00000 0001111
+                * cbo_flush  0000000 00010 ..... 010 00000 0001111
+                * cbo_zero   0000000 00100 ..... 010 00000 0001111
+                *
+                * Anything that doesn't match these will default to 'lq'.
+                */
+               switch ((inst >> 17) & 0b11111) {
+               case 0: op = rv_op_cbo_inval; break;
+               case 1: op = rv_op_cbo_clean; break;
+               case 2: op = rv_op_cbo_flush; break;
+               case 4: op = rv_op_cbo_zero; break;
+               default: op = rv_op_lq; break;
+               }
             }
             break;
         case 4:
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..21272fdb50 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -207,9 +207,9 @@ ldu      ............   ..... 111 ..... 0000011 @i
 {
   [
     # *** RV32 Zicbom Standard Extension ***
+    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
     cbo_clean  0000000 00001 ..... 010 00000 0001111 @sfence_vm
     cbo_flush  0000000 00010 ..... 010 00000 0001111 @sfence_vm
-    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
 
     # *** RV32 Zicboz Standard Extension ***
     cbo_zero   0000000 00100 ..... 010 00000 0001111 @sfence_vm
-- 
2.43.0



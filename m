Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5372C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpki-000577-Ds; Fri, 28 Aug 2026 02:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkg-00056z-RQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpke-0000kR-S7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S233J42943070
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hDJwUjMOujHFT8PyK
 UlKS7EHiN3eC5sthja9PdhqzUE=; b=Y1e1ULyDXlvKsCrE1XDVeaN1HpnRcV580
 /Z20JZncdQ5pwo8EUwziZTv8917zrp1z5Mtj+GsYbmmebXhj5CS06OAs9iLGkJTb
 5JF8RhtODghXzyGfwbdKjQVoUG2+Qjyfiam+FKl6isHfjEmc6RQWECSZAeXrxa7L
 CLOzF++qsUWifB/DAu7/OMQIMpcWTk+HqNnWTWluYVtxU5XbZgWLXdgqMZYA3gU2
 xIm//3/RV/cYMFyVM2atWDCi9lFVrF53O565X8p5me2w+aqYFpwq2DSod39votgp
 wxqNgWd1eDPTH7e4Wg3sK3AEr4+fbSYEJK//b6wPTGIn+PyfoSq/A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eraasc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uGtq019143
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3kcm5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67cTg42664382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 179AE20040;
 Fri, 28 Aug 2026 06:07:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CA9F20043;
 Fri, 28 Aug 2026 06:07:36 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:35 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 05/41] target/ppc: Migrate extswsli to decodetree
Date: Fri, 28 Aug 2026 11:36:40 +0530
Message-ID: <20260828060716.91672-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fe_BUiUodDGzmY0ck3fEMgMT3rJPZkZO
X-Proofpoint-ORIG-GUID: fe_BUiUodDGzmY0ck3fEMgMT3rJPZkZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfXypm3P618OlB5
 WeCQNyQFDuQ0WlPwAtM9qg1FuMMTOEl5le1uxCJ5/MIuvR0AxmxrIezJrj1xGQOjZuEmtXSdIhw
 Ju5/JaTBJbE+HubCnq9Du36B/JfkUP2+R7Qv2cqE80L/XGODq3WdfH9kaKcJsy78CEi6Xu5Tptp
 ejDF6YhPsVNRGt+626z/yf81n6+4IdR2aAEzcDhEQfpjEdVLyXPj6D/Hjoa1Ee+Syhq2+ijp13Q
 pneuMPReCCSEh5FWxopa4U1/lzNAPj+4xf+0bhOsd98g6ERvIsjibGAP9N7E5FK+o2glip5sWuk
 FTAu3AMra2bkglNHj2cx5Q0iVdoYHvTeiil0aNcmTWFniIGlI4n/knjZ/24PnfUVlhH1zYHO8gV
 Id/TUFzi3+6TCVU0fyJ5s2ryBlNq3MfYmd+hIxNzpP37oLRnqGcDAEhUcag2cjV0U8dczBPb7qM
 f805W1FKQlZTo4vZ73w==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a9125af cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=KLPrRlqQ7FRIV3ge0CkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX+q89XhWTQ+cL
 J4ixnC/reRc7OyPRfWduqQp7fiGuxeXXfSddtV74+hx3+ja0ELnUzXPaOdMRW05Lg+p8WRK5Aon
 WCjc6SVu1JpC0c/btJLwh69UpNisxkk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Move EXTSWSLI to decodetree using the XS-form layout with a custom
%xs_sh field to represent the fractured shift encoding.

This replaces legacy GEN_HANDLER-based implementations with a single
trans_EXTSWSLI() handler.

The implementation intentionally operates directly on the destination
GPR to preserve exact TCG output and avoid introducing temporary
variables, matching legacy behavior.

Testing:
  - Verified TCG equivalence with legacy implementation.

Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-2-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/insn32.decode |  8 ++++++++
 target/ppc/translate.c   | 43 ++++++++++++++--------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 0e9c68f2fb..342e65dadf 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -117,6 +117,11 @@
 &X_sa_rc        rs ra rc
 @X_sa_rc        ...... rs:5 ra:5 ..... .......... rc:1          &X_sa_rc
 
+# XS-form with fractured shift amount
+%xs_sh           1:1 11:5
+&XS              rs ra sh rc
+@XS              ...... rs:5 ra:5 ..... ......... . rc:1        &XS sh=%xs_sh
+
 %x_frtp         22:4 !function=times_2
 %x_frap         17:4 !function=times_2
 %x_frbp         12:4 !function=times_2
@@ -1301,6 +1306,9 @@ XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
 XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
 
+##Extend Sign Word and Shift Left Immediate XS-form
+EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
+
 ## Vector Division Instructions
 
 VDIVSW          000100 ..... ..... ..... 00110001011    @VX
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 06ed2adf10..e627f48f9e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2470,30 +2470,6 @@ static void gen_sradi1(DisasContext *ctx)
     gen_sradi(ctx, 1);
 }
 
-/* extswsli & extswsli. */
-static inline void gen_extswsli(DisasContext *ctx, int n)
-{
-    int sh = SH(ctx->opcode) + (n << 5);
-    TCGv dst = cpu_gpr[rA(ctx->opcode)];
-    TCGv src = cpu_gpr[rS(ctx->opcode)];
-
-    tcg_gen_ext32s_tl(dst, src);
-    tcg_gen_shli_tl(dst, dst, sh);
-    if (unlikely(Rc(ctx->opcode) != 0)) {
-        gen_set_Rc0(ctx, dst);
-    }
-}
-
-static void gen_extswsli0(DisasContext *ctx)
-{
-    gen_extswsli(ctx, 0);
-}
-
-static void gen_extswsli1(DisasContext *ctx)
-{
-    gen_extswsli(ctx, 1);
-}
-
 /* srd & srd. */
 static void gen_srd(DisasContext *ctx)
 {
@@ -5750,6 +5726,21 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
     return true;
 }
 
+static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+
+    /* Mimic legacy behavior: operate directly on dst */
+    tcg_gen_ext32s_tl(cpu_gpr[a->ra], cpu_gpr[a->rs]);
+    tcg_gen_shli_tl(cpu_gpr[a->ra], cpu_gpr[a->ra], a->sh);
+
+    if (unlikely(a->rc)) {
+        gen_set_Rc0(ctx, cpu_gpr[a->ra]);
+    }
+    return true;
+}
+
 #include "translate/fixedpoint-impl.c.inc"
 
 #include "translate/fp-impl.c.inc"
@@ -5850,10 +5841,6 @@ GEN_HANDLER(srad, 0x1F, 0x1A, 0x18, 0x00000000, PPC_64B),
 GEN_HANDLER2(sradi0, "sradi", 0x1F, 0x1A, 0x19, 0x00000000, PPC_64B),
 GEN_HANDLER2(sradi1, "sradi", 0x1F, 0x1B, 0x19, 0x00000000, PPC_64B),
 GEN_HANDLER(srd, 0x1F, 0x1B, 0x10, 0x00000000, PPC_64B),
-GEN_HANDLER2_E(extswsli0, "extswsli", 0x1F, 0x1A, 0x1B, 0x00000000,
-               PPC_NONE, PPC2_ISA300),
-GEN_HANDLER2_E(extswsli1, "extswsli", 0x1F, 0x1B, 0x1B, 0x00000000,
-               PPC_NONE, PPC2_ISA300),
 #endif
 /* handles lfdp, lxsd, lxssp */
 GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
-- 
2.52.0



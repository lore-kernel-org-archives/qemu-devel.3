Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664A606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bdVL3qUG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iBj4cyfp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvv-0006rX-Oq; Fri, 23 Oct 2026 12:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvQ-0006cJ-Uy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvN-0002Ky-Vw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3gfo2930960
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ttnh8O3EdsZ7ga2Ka3CSnzfU/hl8LtB/gPNp0efbYoU=; b=bdVL3qUGHisXtbj1
 htGIVsZkOu7zshAzZAtHs+rmhBeP7RsmnGhCqy1MCcvCtfcHUqxps14I/pAZmY8Q
 ARKucMNncqHDLwgJTiEdn0djdkaIfYd0m9gq1a3W/JDBmuiG8Rw1SqrP3szIAbmy
 XozVfzFi4QyS7yf4D2AH2c9pCbE/9AUElBgb8bYn0OA8u6tgnYzsgJDt6YJsLtk5
 iTscabkHBeV0U0uA8tW4dRAYWtkop/1JRYCwtENMI48UaKUlvD1HplinUfNBj80w
 zatrrnIPJoKhKUjFf1DEEGCHocDv+flrTcEPsNeiVjL591gAJRXKbHRZ5XEtu7V0
 KXNFJA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6r1fh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f568dee56so217182985a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772120; x=1793376920; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ttnh8O3EdsZ7ga2Ka3CSnzfU/hl8LtB/gPNp0efbYoU=;
 b=iBj4cyfpJgxhMqkik9Dv8yFVCETNibOeV0PWANt0Vj7RwYFLr34O2RO85QzaIJVoyW
 Sz6ZvbCnEuvchfEtKzDnX+JPDRoqRoPqxxpSHkqg9chSj5ogGQP6oA08E7GiMbD2ifFH
 TjjZRMCaj/bwuW/8YkDuXhWf2nxmlvDR0f0+UwXLmQwNTxZ895pMWvZY6/rfeuxcabLK
 e7Ef7v11bTa3k1tFyP7DiI++3jKed9we0yMjnUAj9prRXkcRSzMO0lV1qLDtBpI3nGMp
 6H0iQqnlabVkHB+QFZFrQg5zjHf19gXJMMOBA0tj3xzMRQ/y6hwHajNJuF3SL/Ho4bBv
 GNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772120; x=1793376920;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ttnh8O3EdsZ7ga2Ka3CSnzfU/hl8LtB/gPNp0efbYoU=;
 b=i4dT8sqzjCscXLojScsyyES+SJf6XfxunwTrGkzLeIdSU3coIaGC3GugJqA+D4kfx7
 zVLNGtUtekOWAivRgH+b2DjaZyWhgou1LNcQup8olmrChE35mMhmqHmh7zO0oSCiH0qH
 x3DxWZ456243iwCs0uduQQdUfQguV80T09SwuBubDVYSC3Sqx2bqBOf1WqZG/LfkfDE5
 TIGTZ4pCWhx5j2zHf4AY4NEv8ngZWy9QWqMuEU6vtaluH1DmV2cHdsdEpaQwzgie+rip
 26N47cSeF6BFvB4dRQ/Jgsa0hxTL9Th/ksii23nCLaEoFHYaXcqdBvb3OQfD0t0xbvlX
 reag==
X-Gm-Message-State: AFq9FYIm8M8T8dWQ3GZrCTwj0OCWkM4zJgHMHJ/7ryoXqwFhVWnfyuZO
 KZXVxk0C6tlgKo767cAT0Ja3y+2svejA/II3XWnoatGFlzjR5D8rno+OwECt61ePae5lCtxN4TW
 145jNclRoZKEkT6dxSuGbseX7lLP/xSOloldPwvioYcwaLcOB/GleGAUwBmNQF3As2Rwe
X-Gm-Gg: AYBFou2YNQjtI5OtRuekbpz1wrwDiP9AwHInraklQnrlKSoc/+goAI9PkeU/4Fc3DmV
 x9Y4rLOYxNC2t1Xpcyc8Ub4xzItd1uCcsFFa5GbOuzPqaxl2ame0rKXePlvDU6UvwS+qCTelgfW
 Dpua0NIWh7r4wuSkskbWlPy0IrldWjClcGUmjp9YlRQLMTJt/Vmn/Vu9lt2qrYPmImF5HuPWHUH
 eo93RsHANLbk4+k2MkqhtqE9HkJhUFkSgp0GY81pm+uU0tMHYbDAVTV1e6OMdD8E4vceyDtaXh0
 t97nLxsc+phDziKLCYT9t1+z1604QuIC/9yEuhBCiHWjQFzsNYIdV5nKdi/npyvQ4mRvf8rNV7E
 s7CvJXXk4/84Vv+Knt4ZUjkt8WuATV6XgjnKWAA57
X-Received: by 2002:a05:620a:1a15:b0:939:6de8:43dd with SMTP id
 af79cd13be357-93f6f996e2bmr547463285a.49.1792772119791; 
 Fri, 23 Oct 2026 09:15:19 -0700 (PDT)
X-Received: by 2002:a05:620a:1a15:b0:939:6de8:43dd with SMTP id
 af79cd13be357-93f6f996e2bmr547456085a.49.1792772119306; 
 Fri, 23 Oct 2026 09:15:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b064084esm13747045e9.9.2026.10.23.09.15.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/83] target/ppc/gdbstub: Replace gdb_get_regl() by
 ppc_env_is_64bit()
Date: Fri, 23 Oct 2026 18:12:22 +0200
Message-ID: <20261023161332.60153-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfXxN2sfrgQmdJD
 fp2bl/yHScCuuvdvEbcQeNnjjAlOVdSIamJk41bMCfvSI3v/AvdCI4VeutQkgDMfATna2BhaVZq
 8eVdtHzEq8tdJLQSGYS+AJ0k/X2P3ZdAeLUW1DOwp/w79WVH3y00816lrtDhnBVLx99Dj0PTj4P
 R/8ps/VYatg/LB/VUXGpIIp62dQYOudvz1vieMagf7yJd9bk7btWFKvQsMbArikFi0QzgDOWaGf
 3KpG+nTpRrcyJzjYQnifgK9HcqqCI8tOzkwhEJsopWeX9VkUjK/B1ZkeshX4holqamt5u9wikj/
 y7U0T3R5a6nMuJpy9PKiLeKw4qfprLM+7iiLHLP7ySs30Oe3u0GLPlG1CXWB42NZgIusCxNRdck
 d1ugL4CDS3rw/KwKO4vcllVgfQrHCeuSW+5nOJkGAFffHHTQlFwwbA3JPTb18CEfeBJkkxbFMyv
 pvdSEfbapGaPKJ6wvUA==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adb8818 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 7wDK4djVRVN8t3cTdH_Pvv0-OfyqHxJ8
X-Proofpoint-ORIG-GUID: 7wDK4djVRVN8t3cTdH_Pvv0-OfyqHxJ8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX/dgoTOCp/WHt
 ahSLQUOMJkk7vdkhIv9TyY4W9S8rFTB0cy9TFEQTj2CqPLmakE+PFutjroUjv+Zfkz73oN47WuU
 nEFEFuxqjnhKqgv8pdi0WdIQEmFKuzw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Inline the deprecated gdb_get_regl() as ppc_gdb_get_regl(),
replacing the target_long_bits() check by a ppc_env_is_64bit()
one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Message-ID: <20261007232326.66240-7-philmd@oss.qualcomm.com>
---
 target/ppc/gdbstub.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ee02be63ce8..0071c2b3bab 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -53,6 +53,13 @@ static unsigned ppc_gdb_register_len(const CPUPPCState *env, int n)
     }
 }
 
+static inline int ppc_gdb_get_regl(const CPUPPCState *env,
+                                   GByteArray *buf, uint64_t val)
+{
+    return ppc_env_is_64bit(env) ? gdb_get_reg64(buf, val)
+                                 : gdb_get_reg32(buf, val);
+}
+
 /*
  * We need to present the registers to gdb in the "current" memory
  * ordering.  For user-only mode we get this for free;
@@ -98,14 +105,14 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(buf, env->gpr[n]);
+        ppc_gdb_get_regl(env, buf, env->gpr[n]);
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(buf, env->nip);
+            ppc_gdb_get_regl(env, buf, env->nip);
             break;
         case 65:
-            gdb_get_regl(buf, env->msr);
+            ppc_gdb_get_regl(env, buf, env->msr);
             break;
         case 66:
             {
@@ -114,10 +121,10 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
                 break;
             }
         case 67:
-            gdb_get_regl(buf, env->lr);
+            ppc_gdb_get_regl(env, buf, env->lr);
             break;
         case 68:
-            gdb_get_regl(buf, env->ctr);
+            ppc_gdb_get_regl(env, buf, env->ctr);
             break;
         case 69:
             gdb_get_reg32(buf, cpu_read_xer(env));
@@ -281,7 +288,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
     default:
         val = env->spr[reg];
     }
-    gdb_get_regl(buf, val);
+    ppc_gdb_get_regl(env, buf, val);
 
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
-- 
2.55.0



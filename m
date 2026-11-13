Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000D606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F0V+4ZCM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=as6OFx2Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtw2-00051s-Sq; Fri, 13 Nov 2026 11:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtvD-0003uY-12
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:48 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtv6-0000Op-A5
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:36 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRDua1076437
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4dtcWc5Gs7vGnKiv9o0VpxYBBVlHFoyDcnBqH9IHigY=; b=F0V+4ZCM4z+b3GG/
 OUrte7jOOq9SFnG3Z6hZ+3kSQe8+dmQiL86LCo8fpgnzwDVTNBfUAvPMoPmDrVc0
 abHluTipyisZGrUCa4JBjwYTI0WV4gCzl6xxB9T0dGdVuFos7g0n0vIaJIONX5Rz
 xqitcuvoWc8CrZMbYCdkobpoPQqeDHJVVSCy7Ja7GTmFjwHnOwSwa6VEmt0jdEda
 rB7UBDv7gu827O8Mj4AukcAWoxMxq2rgpSP2oOtEvoEoL37nmRliBJObFP9IG4Qe
 f5GIM48igU3jlG6Jk/JDacYvE/Aub+s5UMqC+uONI+g/wkCiSG1SVYvAVmLPxJ4b
 vhIXVA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0amhwj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:31 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99939c0007cso211281241.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586471; x=1795191271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4dtcWc5Gs7vGnKiv9o0VpxYBBVlHFoyDcnBqH9IHigY=;
 b=as6OFx2Y3Imt+WZOvncBP60WyrDgNxY/pYqdJT1seokZm0ZqQEM8DbkzyKBm5jb796
 Lh0IoC8wosib4iZwRXQYvEnkBnLXTwPwGnxCRI+4Y9Q4o7Rm9UF4Zya693pok+B8pyU3
 7QldcwWjpT0tnYbXsBSmFcxVS7NkYKHe3+DsH0/iY81wKMgNOqJfMIabRGRYJ7UMVKXS
 /Zv32La5oRBFJdOSnIisFk+NYd2JJKpGD4e/gFaR/IXpq6CQTme7CAomh2qc3A3D+g/F
 jKNlQSk2+SaSPmMJdI893qk9QDoG71Nq5VygRbOC8+Nqf7N/d0C82+cWNCPqlS6dYnL8
 /gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586471; x=1795191271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4dtcWc5Gs7vGnKiv9o0VpxYBBVlHFoyDcnBqH9IHigY=;
 b=ORSEWatx59cYQvNowjSx0C2m3A38nSAEpyubmQiukvXvimhfkHMwgiPJ1rLjoFJe/g
 piUSEVLKvd3CZjcet8O6OWwwfBkHu7i0SaM6irSe7OFUNTuco4ZcBq1WM5hnuhx1UXbB
 EoPxWOkKclNF/kM5uc5pbbIFFvlK69vxXrziA64gyc2rq971mgHrmoKg6GLwSHnGRKak
 BQFpt5MBPTAuH9F45qHV65tg/x9wieCd9V2x+ZYtIoXPM4yy3qNM16QkiZQkjkAuU+zw
 nwyjAS9kqQv7gqIPWwEmGPLGwuX9cEXsDBZPhyv7uyyIQ4SV/obcpMjkaQBqfD3W16pX
 I1vg==
X-Gm-Message-State: APuU4Z8TnSIV20YDDweCTnHPRacjo4YAbBQyHT5vr9bwLIMduK778fn0
 XfIJ4NkI1tqbruoVcIoGw9Sd1fN3XQndqxlyXuN3alHT87w6JDw6ErVysaMk8xsp1+2DpJOTvgv
 1KbjmMdW1iFqmcVSdEcZEKLZlTYfpq0Wo+e81iVbbxrHFNXfMRKjEqTdeITVN/X+8Atha
X-Gm-Gg: AYBFou2jCbEXyGW8J4zrXt2CIFoILmuR/s40jtOHKqI7tpDx0fmjno8/x/fyVcOnuHy
 r79hPZrJYIMrxPIq4R/ybxqtU0PZmusr6SasEHo7/qGe496pGdb+SqysRY4oodDXN3yUiik3Dhs
 WzEe7uSVwvvUPKrxNpctry/fO87F1wiPANcjrFIXPQuEjdtgOQ5JonWjh4wOdB+pVtP4txyY23o
 k30ppfcWJITRQx6lMPClzvHRB84db6QUaI0cD1afT+2e22kecuiI195korjZyt/rmP7XoVZO9Pu
 2KTle4+tjLEUIR++oM4TexqAP2G7Zbj7UQwIQKzWBKHkfS50rWukIwG70GL+lX+ENXedbMhdIjC
 JPMzvMOUejjlUwKEh2bFxhQ+6bNBcF31pGKPLusmWKoPlZi3GylOIMaBAiyPY84cLX/39xnNTQk
 xHbMXQeP0Xs11kpQ==
X-Received: by 2002:a05:6102:3c92:b0:7c3:8150:83e7 with SMTP id
 ada2fe7eead31-7d64d6db6dcmr778651137.9.1794586470560; 
 Fri, 13 Nov 2026 08:14:30 -0800 (PST)
X-Received: by 2002:a05:6102:3c92:b0:7c3:8150:83e7 with SMTP id
 ada2fe7eead31-7d64d6db6dcmr778641137.9.1794586470044; 
 Fri, 13 Nov 2026 08:14:30 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb52bab8bbsm101790665e9.13.2026.11.13.08.14.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:14:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 19/19] target/mips: Do not negate NaN results in NMADD.fmt and
 NMSUB.fmt
Date: Fri, 13 Nov 2026 17:11:57 +0100
Message-ID: <20261113161158.25811-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX3KWWJl7muMKj
 UFQe0rj61VZNf3g8GQKBPAzBs1+sLGZ+XVbVHPdov4LutJEq+/WMo/KCGpWHY9M5WEsJartSNzR
 R2GLwUTnZlLuFJBGWegVoo5NhvPj+fs=
X-Proofpoint-GUID: e-IuZcINGChtEVpORQBzjB0Xl1Dmc78Z
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af73767 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=YABXkFt12vpHfiLejZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX7QlDQTlKWrVv
 sm1Z93IJwN03hSi2ij1I9Qv0sBGl3d2+Mled1WckfuskIkZcozGHdrxBqnW5uep5xQnTLzh2EKu
 x1y3pcaT1HIvZDY34HBrV5rw9aqoEafMctR1zie3sQrJwHEWPZd4lDuGz6SNORZaMqexaovAkFo
 AGo0j6HVZnXkM2cJQIy3pR7bTk/VaGEQ4kJ2Zo/tLOJpmK0g9fFKYgPUAMMLf6fIMbggufdHrh2
 qxMN4rbqiffarumzrDZYk9luWWY4oVuClA6OB8Wx0QlG9Pdw+nFF+k+PuhZdlT205zMI7M0+b+Z
 vCJWZGRVjgq8krOTKEgDRC3VBGh684+DnsFQL7wnYuvDefDH71SBTPpJqkxudR+X9JxiZqAce9x
 4/nAu9RmCCuR/lAas2+/y1CAXzh/+BlrSjqYbXwysEX0YUxwJlZekMXexiMI+5lbOHbZnGySFq7
 6yRIXw+PG5PQc67R7nw==
X-Proofpoint-ORIG-GUID: e-IuZcINGChtEVpORQBzjB0Xl1Dmc78Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
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

The final negation of NMADD.fmt and NMSUB.fmt is arithmetic. With the
legacy NaN encoding (FCSR.NAN2008 = 0) QEMU returns the default NaN
(0x7ff7ffffffffffff for double precision, positive) for a NaN result,
then flipped its sign with float{32,64}_chs().

Observed on a Cavium Octeon III V0.2 (FPU V0.0, Linux 4.9.79) running
risu: "nmsub.d $f7,$f27,$f23,$f15" with $f27 = 0x7fffffffffffffff (a
signaling NaN in the legacy encoding), $f23 = 0 and
$f15 = 0x472fa6f57f408dcc gives 0x7ff7ffffffffffff on the hardware,
where QEMU gave 0xfff7ffffffffffff. The same was seen for the single
precision "nmsub.s $f1,$f18,$f22,$f21".

Do not change the sign of a NaN result when NAN2008 is 0. Non-NaN
results and the NAN2008 = 1 behavior are unchanged. NMADD.fmt, which
shares the code, was not exercised on the hardware.

The hardware (or its kernel FPU emulator) also returns a different NaN
than QEMU for "mul.d" with a signaling NaN operand and a denormal
operand: this is not addressed here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/fpu_helper.c | 39 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
index d6595da6482f..e085aa5669f0 100644
--- a/target/mips/tcg/fpu_helper.c
+++ b/target/mips/tcg/fpu_helper.c
@@ -1627,12 +1627,35 @@ uint64_t HELPER(float_msub_ps)(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
+/*
+ * The final negation of NMADD.fmt and NMSUB.fmt is arithmetic: with the
+ * legacy NaN encoding (FCSR.NAN2008 = 0) the sign of a NaN result is not
+ * changed.
+ */
+static inline float64 nm_negate_d(CPUMIPSState *env, float64 a)
+{
+    if (!(env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) &&
+        float64_is_any_nan(a)) {
+        return a;
+    }
+    return float64_chs(a);
+}
+
+static inline float32 nm_negate_s(CPUMIPSState *env, float32 a)
+{
+    if (!(env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) &&
+        float32_is_any_nan(a)) {
+        return a;
+    }
+    return float32_chs(a);
+}
+
 uint64_t HELPER(float_nmadd_d)(CPUMIPSState *env, uint64_t fst0,
                              uint64_t fst1, uint64_t fst2)
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
-    fst0 = float64_chs(fst0);
+    fst0 = nm_negate_d(env, fst0);
 
     update_fcr31(env, GETPC());
     return fst0;
@@ -1643,7 +1666,7 @@ uint32_t HELPER(float_nmadd_s)(CPUMIPSState *env, uint32_t fst0,
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
-    fst0 = float32_chs(fst0);
+    fst0 = nm_negate_s(env, fst0);
 
     update_fcr31(env, GETPC());
     return fst0;
@@ -1661,10 +1684,10 @@ uint64_t HELPER(float_nmadd_ps)(CPUMIPSState *env, uint64_t fdt0,
 
     fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
     fstl0 = float32_add(fstl0, fstl2, &env->active_fpu.fp_status);
-    fstl0 = float32_chs(fstl0);
+    fstl0 = nm_negate_s(env, fstl0);
     fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
     fsth0 = float32_add(fsth0, fsth2, &env->active_fpu.fp_status);
-    fsth0 = float32_chs(fsth0);
+    fsth0 = nm_negate_s(env, fsth0);
 
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth0 << 32) | fstl0;
@@ -1675,7 +1698,7 @@ uint64_t HELPER(float_nmsub_d)(CPUMIPSState *env, uint64_t fst0,
 {
     fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float64_sub(fst0, fst2, &env->active_fpu.fp_status);
-    fst0 = float64_chs(fst0);
+    fst0 = nm_negate_d(env, fst0);
 
     update_fcr31(env, GETPC());
     return fst0;
@@ -1686,7 +1709,7 @@ uint32_t HELPER(float_nmsub_s)(CPUMIPSState *env, uint32_t fst0,
 {
     fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
     fst0 = float32_sub(fst0, fst2, &env->active_fpu.fp_status);
-    fst0 = float32_chs(fst0);
+    fst0 = nm_negate_s(env, fst0);
 
     update_fcr31(env, GETPC());
     return fst0;
@@ -1704,10 +1727,10 @@ uint64_t HELPER(float_nmsub_ps)(CPUMIPSState *env, uint64_t fdt0,
 
     fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
     fstl0 = float32_sub(fstl0, fstl2, &env->active_fpu.fp_status);
-    fstl0 = float32_chs(fstl0);
+    fstl0 = nm_negate_s(env, fstl0);
     fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
     fsth0 = float32_sub(fsth0, fsth2, &env->active_fpu.fp_status);
-    fsth0 = float32_chs(fsth0);
+    fsth0 = nm_negate_s(env, fsth0);
 
     update_fcr31(env, GETPC());
     return ((uint64_t)fsth0 << 32) | fstl0;
-- 
2.55.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6A606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D3cytxMC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fZObYqEs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvF-0005op-4g; Fri, 23 Oct 2026 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuz-0005Mp-Bc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHux-00027q-5A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:57 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6rYb1492211
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r5ztHSxtnM2xlbH+JNVpudFMc8yyqAiO/5A2XjXGEAQ=; b=D3cytxMC4vYCmrFo
 XDowlqFXrbZPBrcgoTWiNw57bbQIaFdGpIV73vzzzlTsBdJVume71//Dgr7rZ5V0
 cS58L5bPetK8/ozHDlSizbTfliyio4Phg40UDh1Ca6mZiqRfwaAw7TG32R1Ab1VA
 Am/1o78kI24WiIqDzJumk7C4Eg5AcRiU/OtsHSGQD25DoMA4YjNqVjhhbHNas8Qg
 YikTtTOndF00uodA2S34ELRj1PDMPY964b0kU/eM4jW3+kb8cBij3DC6FLjT/ZTN
 9mSBDd7ytE4LfOWFEy6Avt0kvJOdHD332p3JWPX134vhN5jRi+M1rNpdKWO6l0uh
 /+/Wlw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauxyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso133063485a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772090; x=1793376890; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5ztHSxtnM2xlbH+JNVpudFMc8yyqAiO/5A2XjXGEAQ=;
 b=fZObYqEsQSPbilvaKQg11xHv6zHnCk085CLr0bogF2leRcMrahsYisJ9eOWfOjBm+x
 6GO2UsCePszwRQLi5Meklo7j5hWaAVO3M8KGOmsIdyFw3aH3Mzv6N6Ya9psP409fCuBd
 MpsNYJhcRjsPMm/HRPGu/ZLRq/o+Du0OMf35jc5f8F7pXi9XpfpS7HjvacCpLe+xYnPZ
 SIekWItT9sUJYLROnzcjh6Um7eQWqXkB6Lgm3yMLL3dxq9F0+xNOth8eNzvN3UbLXCXi
 KjybqioEAxWpyr9lnSNd5TNVqkNIivGdZoL9y+oqhtZ2cHEbxjs21w1NAGCxZ6OZiCd3
 KJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772090; x=1793376890;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r5ztHSxtnM2xlbH+JNVpudFMc8yyqAiO/5A2XjXGEAQ=;
 b=cmTwx5M96GgzsMCgW97bQ0LPUxgXtmg3dLKa8hW0zYLsUtCTJf0h0/HbpbQjpjPV9l
 zAgr/LhfuKDA/Jr0rQux+zNkuccHg7d9FUycSfb6BfBBQT5SdLcYzbwtd9iFmhkIhKVb
 6SGpPYKBChq82wQ6BqkcLwpyiq84aD/YrLmxvPgG+GU3er2M86HQFZSc2k0b6mo6gZqU
 +pN8fBcSMs3VMFjcq9qspxpZBePgv8CQFSPMWmkRElV9+DSEt5QrXm7GrOp5yagucOxs
 EgpUZwueuEqcpeXN+l1kx7hGEpklWk7cpeNNzj53DvP8kydkyaeH2mQNnc9ib4ONne0Z
 k56A==
X-Gm-Message-State: AFq9FYKiNmU8MGCam0kPtOr5V3luMNJMWm2kW+6jd0wfpEZuMx1033BB
 cl9271zxro6/FGDDLWedV4DpxVOZFKwdrTp9HDHPfoajN+3wJkR33QsuxEZve6fn8Y/kX/8h3lJ
 4AudiM8jmlqitzcc4xspAIpba0J9smJ7bvFdnhwcPu2LTTPGO2qkcPrR2C7zxfr0rn2ri
X-Gm-Gg: AYBFou1WafdVm546S7yuxC7kXNvGqI3SIVmMuKXG6ZYy5VqJx65R446axHKigaIPlp0
 BifM339E/zKt7SxD/VtWGMvy40OZSSopgcucVfPX3xRsqCtzg48uQKApT++Mam5sffckLKWn/Kd
 +BzjtSuvnmHHY5EMYEyaw7CEnMmkNEV7kl/M+qJ0MQ/ndeyTYIiOFUI5WvINFnv4qsPgVTxHc6q
 iq/8Kj1Q7gEbjar1AprDy8zIwFHbicyV7fbuuDkz9A6c1u67EHlTpOAVCKef/GCW8pDf2zR1vM8
 BV4wUQ0sDDoVwQ4RHpTYS4q0mpTABKQMfYvgriQQYs7veku0nKu4W4phcBNhCs0h5k3U++fSMC6
 utQAWsFa8Q4shvhhywOLAEY5LhUMWVxQ/mTtHaMm6
X-Received: by 2002:a05:620a:439b:b0:93f:211b:a7a with SMTP id
 af79cd13be357-93f6f907cf2mr477026485a.29.1792772089931; 
 Fri, 23 Oct 2026 09:14:49 -0700 (PDT)
X-Received: by 2002:a05:620a:439b:b0:93f:211b:a7a with SMTP id
 af79cd13be357-93f6f907cf2mr477022485a.29.1792772089394; 
 Fri, 23 Oct 2026 09:14:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d416241sm728957f8f.43.2026.10.23.09.14.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/83] target/mips/gdbstub: Reduce to a single gdb_get_regl()
 call
Date: Fri, 23 Oct 2026 18:12:18 +0200
Message-ID: <20261023161332.60153-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb87fb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_MRS0-8QzHIUbcTvO48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8SRc2dEFoIlT
 yWLZpe3rYQ/isxqmjAVLgspa922b+/Mwqy+vcGsXahHYYDBMQB99Y67KLM/xlKmHEzBhcWh+l0E
 84QqT9ErjfTQXccxRDPs0B8ko8emioE=
X-Proofpoint-GUID: WXtkGik3xbaCKlRRD3IlgYItfB4VEueg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX17758+txZLdy
 36CbDHWRM2hK2LtXaRh0fBRgzmmKT71XKYpyfN53exIKoJqrV8H3/n2yJFS21yftjP2rLBf6Qoy
 Q4i3gL2ILya4SwX4EGZoNX5d30La2K7pbpNlVrVQ+k8N+B+c18OskFNQDM4fN368kyeTe4PUYmd
 fCzzyRqgaJxoDMIZCdRuPaM+4otjNkqMl1IOpC/qJzud9/h/ZUDgJdSEV+QFlHAnWmKA5Gkz40Q
 bp3ak4UlpBx+isIKFX0MqhRWzkXTsFmk51/Dk1Gm8nM3vFw2vuQxVDK4Bky2WA6soX2Nfd0o1lS
 whRoYLjdCjrvtdp59CgAYUrUsWDEu2CLPcqSL8WD02psB/YkIMRz6ZgTCQ/1h0uSODQL2R6hgLd
 nFvPS6/TkKrIUrYsMdTHPzoDC6063bofGLp5HhyJDhEyw1axBUW9zo6dRe5Pa0kvhEgX13tWQ3D
 4PnNyokf8goMvr9gUzw==
X-Proofpoint-ORIG-GUID: WXtkGik3xbaCKlRRD3IlgYItfB4VEueg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Store the register value in a local @val in each switch case,
then append it once at the end of mips_cpu_gdb_read_register().

No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261007232326.66240-3-philmd@oss.qualcomm.com>
---
 target/mips/gdbstub.c | 76 ++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 8e0b08a096c..7598aab6158 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -27,6 +27,7 @@
 int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CPUMIPSState *env = cpu_env(cs);
+    uint64_t val;
 
     if (n < 32) {
         return gdb_get_regl(mem_buf, env->active_tc.gpr[n]);
@@ -34,46 +35,55 @@ int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
         case 70:
-            return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr31);
+            val = (int32_t)env->active_fpu.fcr31;
+            break;
         case 71:
-            return gdb_get_regl(mem_buf, (int32_t)env->active_fpu.fcr0);
+            val = (int32_t)env->active_fpu.fcr0;
+            break;
         default:
             if (env->CP0_Status & (1 << CP0St_FR)) {
-                return gdb_get_regl(mem_buf,
-                    env->active_fpu.fpr[n - 38].d);
+                val = env->active_fpu.fpr[n - 38].d;
             } else {
-                return gdb_get_regl(mem_buf,
-                    env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX]);
+                val = env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX];
             }
+            break;
+        }
+    } else {
+        switch (n) {
+        case 32:
+            val = (int32_t)env->CP0_Status;
+            break;
+        case 33:
+            val = env->active_tc.LO[0];
+            break;
+        case 34:
+            val = env->active_tc.HI[0];
+            break;
+        case 35:
+            val = env->CP0_BadVAddr;
+            break;
+        case 36:
+            val = (int32_t)env->CP0_Cause;
+            break;
+        case 37:
+            val = env->active_tc.PC | !!(env->hflags & MIPS_HFLAG_M16);
+            break;
+        case 72:
+            val = 0; /* fp */
+            break;
+        case 89:
+            val = (int32_t)env->CP0_PRid;
+            break;
+        default:
+            if (n > 89) {
+                return 0;
+            }
+            /* 16 embedded regs.  */
+            val = 0;
+            break;
         }
     }
-    switch (n) {
-    case 32:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Status);
-    case 33:
-        return gdb_get_regl(mem_buf, env->active_tc.LO[0]);
-    case 34:
-        return gdb_get_regl(mem_buf, env->active_tc.HI[0]);
-    case 35:
-        return gdb_get_regl(mem_buf, env->CP0_BadVAddr);
-    case 36:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_Cause);
-    case 37:
-        return gdb_get_regl(mem_buf, env->active_tc.PC |
-                                     !!(env->hflags & MIPS_HFLAG_M16));
-    case 72:
-        return gdb_get_regl(mem_buf, 0); /* fp */
-    case 89:
-        return gdb_get_regl(mem_buf, (int32_t)env->CP0_PRid);
-    default:
-        if (n > 89) {
-            return 0;
-        }
-        /* 16 embedded regs.  */
-        return gdb_get_regl(mem_buf, 0);
-    }
-
-    return 0;
+    return gdb_get_regl(mem_buf, val);
 }
 
 int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.55.0



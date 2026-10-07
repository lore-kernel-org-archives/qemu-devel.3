Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B416CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEazG-0007Y6-Al; Wed, 07 Oct 2026 19:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazE-0007XV-IM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEazC-0001M2-Qc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtokT1345976
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /Q22BSJD6PBqIQeSmtdbW5WR0BtVVfbssmj44DtvFG4=; b=AobeXDIUz5djuSka
 g3vOcc50J6tZzgqD4cyRMJ/XQ/l6qC2B+xo41/1yZrHdl7RKcqFEdve7QJYXCYMw
 H2Af4tZGCJ126eYEl03Pef1VLUb/x3bd+Ax+ProhVAh2D2mTF5Ms0wItZ++Om+94
 yjub9uncj4monWsQZxKwbcDPFLk/VT0v+F+oezH3sKV/uUVTIGJFEB/1YefV/c0F
 wHbfk+qKlZ8NLCEDrHwa64L2T80cANPLYH7MxSK5DlOVjSXWl1AYBlJkd8ra9D68
 jkczWY7tR66L55ONJo+7rarE/G77Iw7kD1Qh6V1+0zgyWWjbQuRkKD4+2gV/YlYq
 GxQecA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe807fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:23:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dea1b6c89so795834185a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415425; x=1792020225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Q22BSJD6PBqIQeSmtdbW5WR0BtVVfbssmj44DtvFG4=;
 b=OZ/YiEeezIhEaTmlQHHN6+9AZJ4lGSUmad3ZoB4Nk8brMe7tU6KZSOToVng6wHKS8D
 eqdbifDnoPTwjxe2jYFb12OAnPyGShb1fuvZPGqN/ZSJFSyFEqpAXKcwpk/OB5rHieNq
 1+lqZ58kn0aNNYF+4U7taaeo+OqUXXFf5OaME4tjbovLom9fEkQ/9QFTrK1hICBwQfyu
 vTuFcoGpBxL+noTOe97cberzJY1tocVA923PfdmMVFekF7674ahGAGS3cc1ee1qbntBZ
 HXtPcwDKC4jDjlKAp/YQcGtJra96TJi+yDDCfcHhL6tO5iSCtQrblIIWY4ivyssj3XCi
 SD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415425; x=1792020225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Q22BSJD6PBqIQeSmtdbW5WR0BtVVfbssmj44DtvFG4=;
 b=igR6DbHQpUOd1UKrDVC/h5aL1t6hhjOuTwxD+Xo4dhwcYDQFUEiffYfUNzH4uI8r9n
 DjDhypNsQCVy1dlk6MiSeBV0WpibwLpGh1keXM+oNDFeYKK1I0FrS43KMb9/jHWY/Tu1
 REGWbNGuuWvblOB7MgX6VPN9k+iqy7omATKlNWXFPHj8tKbZz39buDqAjR26oBWO9kaS
 bTIjh7YJzm/gRb9uTRX/L1tpMkh+A1txNJ7aOuXedNdaLSGgoMI8cuQdpX9lfpiUn/Rh
 rIRfBGSRUcPFShG2JqiIesMyl6ZGjFksih2HS5yXndmek9JjE00xfS/e4zwAR9pe0/WP
 YdRA==
X-Gm-Message-State: AFuF++k77FZ98riZkyJHp6NEKH2LuZp5KIs0hhNGbc59uY+B1+5ex+Us
 XiJcd9dqvuTyYzyWl/C0lQN1ndJ6SKgHTOBAwthrgzH+ktgvKo2QXQrLE6ytdeta1qArd5cJld5
 R45HdN9ebKgFsPNU+ATmK/Zxe1cHI4Ou39OFaZywzceBT6iGEDLyipCnynpNU9atTukHQ
X-Gm-Gg: AYBFou3AdOYYUC+n2bbPdhsIIRTVydvq/kh+4Xw8euQtQ4mo8Inl1/W3IJHYpJOGukS
 0zvsd8mi14nx7RpgFfFmoEZvwFqenV2FTFKcBklTwespK9liVDZTqy6pKBEE+KDB+Z/1gfDiO31
 vcmLVnyXP2u1zYNfqLH7sxhbcenajgpnNKNUbstnEx24H+ovQZaKn97o0yvpgu2FpiUZLNXCalS
 ofHvlEEUk0vzyWcgad2TbxjP7C3eLa3CsiqE3fr+ydsxlr15NbYMn+gpA1xeKLPF7ll+QM3qJsQ
 059k/egJnxF8971Mzz2C3VOswELtA70Boivt8he1BOlsYV7kFkelRH15hqKb1EiRRXL//rgEyGD
 ZNOV5tE3hIpMIZLr2fGzxjDNFAsmOmIzFKY1kvvst
X-Received: by 2002:a05:620a:4802:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93e9b77d333mr766741785a.43.1791415425014; 
 Wed, 07 Oct 2026 16:23:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4802:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93e9b77d333mr766737485a.43.1791415424525; 
 Wed, 07 Oct 2026 16:23:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1814ce9a0sm78733735e9.3.2026.10.07.16.23.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:23:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 02/10] target/mips/gdbstub: Reduce to a single gdb_get_regl()
 call
Date: Thu,  8 Oct 2026 01:23:17 +0200
Message-ID: <20261007232326.66240-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007232326.66240-1-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX2hghBH6fRZO4
 wtQkmohezh67rI4TPMNhWNArVMS1KDO0EURekbxSDne5U9ISbHW6uHnnTG/zSc+iCYjjZTl3zPr
 inKVcAU/Hqk9uucfYWElpSAlXI0iKvVo9wj0iFq/0mC7uPSVG5gvuznk38J0GCp+hfTcCPFfBtv
 YiaTYXLuOruJ+N5nhQY0DWMZnGQAAEpcbPk8HLFOUqjWmmCjYVw5kDXzRBRBLJSxrhGO9QUBTHs
 qW8FwoHWojo7LeOoT7G+tTWz8fQ/nnsnNw+f8LWdrmKIL5LD2XbkKubEv1Q+erQ0tCVI0WtUNHo
 n2VFuZwnBl2kwjjvUiGW4a4GCYzD3ZAi2tZzkIL0x1eNA8x2Zeq9oWTsA/rITUblU5sKnbEQMbj
 yDeLMjT0gzTFUrKEMCHA0ayIPK6PNtyBaN7Rgc9oIFqUrLK6t2Aic4eH8UeN5p0HR9a5GqkT5IL
 gHijy+fQYkfYnBaltuA==
X-Proofpoint-GUID: lAmw65HmJ2HZxRg2rc-8bhRKMKShIhPs
X-Proofpoint-ORIG-GUID: lAmw65HmJ2HZxRg2rc-8bhRKMKShIhPs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX+ourI+gsrFnP
 8EMSPPh2MK2AnJlCtyeixj2QooXS1HQYHZyO898YBqNMJUDutaIbeZ0w7afu7uP87Tt0e0NycyT
 ODYdPtiFGrYKekFEeC9xxT1oM9cMtQ4=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6d481 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_MRS0-8QzHIUbcTvO48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Store the register value in a local @val in each switch case,
then append it once at the end of mips_cpu_gdb_read_register().

No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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



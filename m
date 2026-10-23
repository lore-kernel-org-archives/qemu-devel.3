Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EUxsscrN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=StUobGmX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwt-0000Zl-UV; Fri, 23 Oct 2026 12:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwZ-0008Ef-J8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwX-0002Sf-GW
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6usH1492294
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGeeIZrkqsAca3CU5LAZyWYtnKHbU8aUt8+q9zv4tjs=; b=EUxsscrNx6QYKDhB
 yNGE2X0f2kNNlieoKUWivmhIAJqQ3jENDkMfDkkLtYRROTF5bpWYT9D/Pfqz5waU
 NdZav14+BVDIR5norc5OzDTO+k7bUbuzQn7e/mcUuAr6oBLl4XE2X4pLJNKbeQmr
 wiHizHAplk3QSITm/O/jnoWp3PxVEUXWs6+6s8KQ9X9gk5NgJ9DRd/Nxhp/CEjlt
 VHK4w3TpwZH7kCM08ycHOOX83JF0yxhTJHJbBzKb4m0+xHsXKEI/KlDdN6h+ghWJ
 SfPTW/f06dhMU69wazrPjkRAfMD2Lvmu9l+6TnnKjj5ICfhImJks877keZ1e5hbx
 zCGqGA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmauy70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f20addba1so201739285a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772191; x=1793376991; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGeeIZrkqsAca3CU5LAZyWYtnKHbU8aUt8+q9zv4tjs=;
 b=StUobGmX3vzK3UJgaZa6AMEpl+zoGrTeBLQf4RoWav/2GI+IKPbJL47WbuhkKiBcMC
 iVeJXscHWPQCVU9YLk61yJylKHNRKqULvKtJ6YTwKgNWL1bPc8DmMQR6dEMspsTDaS/R
 pGfwkD8uRoIEpv5rJL5JmqjuDFJeBDLbBE6tZVI4FPFBSr4BrfW1ezEyKSFD9wMtJmuW
 TksLLbJ8Q/ThxkCgk5pM9jPyjJBY8aWXUJSgpefjvPaQYMiX40gIve1v4trJG1s6qjif
 NaByEheG1X1LrEjlxDNACO0UrcmNggWjfwXNDVTLwkdkJuJR1s9zZ/xnRn2vbVYM9r4L
 jNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772191; x=1793376991;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGeeIZrkqsAca3CU5LAZyWYtnKHbU8aUt8+q9zv4tjs=;
 b=Z5BijgjZ4xlbs1TNsokl+8ZMpAYDo9vh26yHeZ7ME8GmwC/wKeYLEbfQ/mlVXuCPp7
 qGIatYSKqu3zaYm+FZ2qPTW1bQCMkAESAmagwSyn+n8IVZOSnGsvWiaNWgaWfDZ++IdW
 +Vby7qIJnf8azAOgIhPbIjem+n/5dzKariCwKe6iRReDtQaiQxjgJgA8JERB6fWR12+b
 34L6ArkJlxgSegCPtoRbQByjo2vkYSg8FxjIwIHudCwKA3Vfp0swLk3PmqwBU4Uz/HjA
 HsCWxrKsG4n52PEgG/DwF1JLYdMxM3zQGaPnhf3cwGme7e+N5OXelQOoCv/Gt/9+2k0V
 AniQ==
X-Gm-Message-State: AFq9FYKGwr7LBZjg9l9/2OHQnWL2pb7fGTLT/EIwsrEAztW/vbv3IPyf
 g7pCwJNgf0iYX3P4uXNBf2b40y05H8C1FdrIzCbOOQKMeihwojgA/Hb0HghqrVdsuppv/hmCj0o
 BaMz0aaSgPDRijm6RZqY1V77iCW2u1nGwdcEalm1awzW+qgMjPAFcAuQuEx6AVtyIdGks
X-Gm-Gg: AYBFou154jIUERsr986ZD5DY6b99x+f7yYUxpLzk85uduRNvLCInT0f2hF4c2fFaKoZ
 5DU//WnGv2hFenJfWe+NBFvljL5ESpTzOOZIC+aDtLhvTuLQyLeQHoMFD0RZoD0mEh4SmpnTySF
 tS/78nJX6k+koG5ZIoTkQNhtXhNMX6xvdsUnN88Hb7Dd6BAjbkWKLBQMbQEO7fa5vqW3PMlESmr
 OcDfkLY1km2Wl75GtaSb1BFQhUxNad/hzAstc6uJJbaJTq9X8sca+iG500pV3Z+q5upAbtZ4TGl
 dw7lklRVvj47qYjG9dV1jqNw+F2u0b2b5DzKyPdXklE0ZxazVFVPhplG+O3TSfsXCHikxv+YNKm
 pr62DKvNqIZefFpPSFu9vHNI3NJGhaA6Uu81Z7Guq
X-Received: by 2002:a05:620a:44d3:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93f6f8a80cdmr475380685a.66.1792772190736; 
 Fri, 23 Oct 2026 09:16:30 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:93b:fb3c:2d09 with SMTP id
 af79cd13be357-93f6f8a80cdmr475376585a.66.1792772190139; 
 Fri, 23 Oct 2026 09:16:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312eafc80sm18499885e9.3.2026.10.23.09.16.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/83] target/alpha: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:32 +0200
Message-ID: <20261023161332.60153-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb885f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=kVf6GzFcR4OVXmdlW0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX3v0rwDE0dMLO
 0/PDl1gQWUHQB6yiEtJb4NmkXu7CK9G1q94es2gCUlm6Ja1xL4l6UUOe5TdlyI2cvf+9rgRyMxG
 8TqXbZk3LH202FsOx3eUXYL8cG6Ocbk=
X-Proofpoint-GUID: -OBs0n-c1qsc2hV-p5Y3-otxCuoh2wdG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX80jsLOi/2xP8
 e34ttt1gPtj5aPUZ7XfIXaawERNwAVuou4mN5wRsJjxUs+ps4uncCSwxa1RpfpsFKhOOteY8PwC
 0HHYfNtKj4C4UDU9LHlS1mh2uu+rEvijOm9hVyIqiyPEmthtXrNGFj9/upZRk09+6neE5LqhKfX
 WqXETVYdkvdAq3w/9YllD3lOePRy9+rx5OT5ho43Y8r6lCrt1jihyR1IJXIXM5UJSTLQtdzEi0m
 h1MgjFXUwD0jp9xSoElU5Hnq0MUArl+5+wuhcoAcW13aObKqsUAbFMS2MgEMUnUJeXQL5if+tc6
 flQbHLZ9m/MnB3k8pT8RvKiXVQUHrzIg1ObidKvU86V8nYdF2GZ4tSMd2SQ80lnT4LDdYGsfoG9
 ZdcJInJw3vzeChDg7GfVdCcp379op5ujgTLHE3U4bImzoP9rVaTLvA91dRujkXtGP6NdoOwbKdU
 DFohdFs14zEEcTSPn8w==
X-Proofpoint-ORIG-GUID: -OBs0n-c1qsc2hV-p5Y3-otxCuoh2wdG
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

Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve Alpha exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-6-philmd@oss.qualcomm.com>
---
 target/alpha/cpu.h    |  1 +
 target/alpha/cpu.c    |  1 +
 target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 378bd96d941..8f780502476 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
+const char *alpha_exception_name(int exception);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7d1d036e1d3..6e514dcf4cd 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -282,6 +282,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = alpha_cpu_class_by_name;
+    cc->exception_name = alpha_exception_name;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->get_pc = alpha_cpu_get_pc;
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index c3614ecafda..cedb0006892 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -35,6 +35,51 @@
 #define CONVERT_BIT(X, SRC, DST) \
     (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
 
+const char *alpha_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case EXCP_RESET:
+        name = "reset";
+        break;
+    case EXCP_MCHK:
+        name = "mchk";
+        break;
+    case EXCP_SMP_INTERRUPT:
+        name = "smp_interrupt";
+        break;
+    case EXCP_CLK_INTERRUPT:
+        name = "clk_interrupt";
+        break;
+    case EXCP_DEV_INTERRUPT:
+        name = "dev_interrupt";
+        break;
+    case EXCP_MMFAULT:
+        name = "mmfault";
+        break;
+    case EXCP_UNALIGN:
+        name = "unalign";
+        break;
+    case EXCP_OPCDEC:
+        name = "opcdec";
+        break;
+    case EXCP_ARITH:
+        name = "arith";
+        break;
+    case EXCP_FEN:
+        name = "fen";
+        break;
+    case EXCP_CALL_PAL:
+        name = "call_pal";
+        break;
+    default:
+        name = "<unknown>";
+        break;
+    }
+    return name;
+}
+
 uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
 {
     return (uint64_t)env->fpcr << 32;
@@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name = "<unknown>";
+        const char *name = alpha_exception_name(i);
 
-        switch (i) {
-        case EXCP_RESET:
-            name = "reset";
-            break;
-        case EXCP_MCHK:
-            name = "mchk";
-            break;
-        case EXCP_SMP_INTERRUPT:
-            name = "smp_interrupt";
-            break;
-        case EXCP_CLK_INTERRUPT:
-            name = "clk_interrupt";
-            break;
-        case EXCP_DEV_INTERRUPT:
-            name = "dev_interrupt";
-            break;
-        case EXCP_MMFAULT:
-            name = "mmfault";
-            break;
-        case EXCP_UNALIGN:
-            name = "unalign";
-            break;
-        case EXCP_OPCDEC:
-            name = "opcdec";
-            break;
-        case EXCP_ARITH:
-            name = "arith";
-            break;
-        case EXCP_FEN:
-            name = "fen";
-            break;
-        case EXCP_CALL_PAL:
-            name = "call_pal";
-            break;
-        }
         qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
                  PRIx64 " sp=%016" PRIx64 "\n",
                  ++count, name, env->error_code, cs->cpu_index,
-- 
2.55.0



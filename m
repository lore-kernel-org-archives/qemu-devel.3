Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91604606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eTohncxs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CAt27QTA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hk-0005ZI-QC; Thu, 22 Oct 2026 17:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hc-0005X5-0T
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ha-0007Tj-6b
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH98R1494700
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 POX/WJTfRTtj1QzagZdqMLjkjh6Nnt7ofKB6ovVu0AM=; b=eTohncxsWGWLbNal
 fA5t6Ef3u4PuEjGnjzX1PlCshELlWo1oPFPrmkq40PsZf6Ltuu3H5Y01BN32hML1
 0SG7D6rxUMT231sESqE1k+iyOCWGG1zI5CcAYo5/lCpBUh6UWaVFaDeVeDXDlJ8g
 64zJaLdUofCHC7IkwWua7meSAkbYfdRexAvO4yG7luBxuGtAKnOp4Pp8Rs36D0nJ
 KEBSFF+HnlwAce+3R9nIs00BtYUE0OUNidH7MTWTcbwvgLmQZ1n7d9PReedQFG8S
 7gft4awSaZ3GVLLQi/VVljrR2YKnu2M6rlPvfYoEgFHZD1s0Idvh64nRwGNAflic
 F6uwTA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8pe7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2c0e6653so43887685a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705916; x=1793310716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=POX/WJTfRTtj1QzagZdqMLjkjh6Nnt7ofKB6ovVu0AM=;
 b=CAt27QTA28j7cOJIFSZCXhdKGK0C6u0xiamDDEQhsRSA3MadDruLh61C8flVKp2SVV
 mnOIeEXTLaMeswZNvIt0X2Qh3/X7t/7uBj1ciKeapD+YWil9DSPhMwqK5NFmX3SJTXLX
 +BgPgsuV0otaMoP0obefSgx8lSA3eAqzu3pMyeORT4jNDtLuct+ty9wWiN+R+4yu6nyA
 ePYI/KCZar8nviQsy1IQ6Z/sFnJcuzTXh1I2NSRmLFmduyiUQhyyZLd3d+axRF8MVfn4
 98G9vNghpzu4Sq9PtkIvGRm3sCYaAKW4noTq/lpS3ZM2bRcCrrkYWpKHemJ8l6fXEBYd
 12IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705916; x=1793310716;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=POX/WJTfRTtj1QzagZdqMLjkjh6Nnt7ofKB6ovVu0AM=;
 b=WNt/dtMKdnNxCHNK5We8mO7syjnmrRC2Scw5zT0Um1hUzgUKs7iaOTyP2Pc7DiHDhY
 XLmUF50lJU7BW7OlsTT9LTFn/zws9WKyA6cchnBEdmYf0O9chHri0MGo8Z8ncvm99LiF
 AiJXw9HP6yeRNaedp8FfhJS7H/KH3KEO9UyMfkdgjdL0kDHU44p0xm8Rq7i2HZBwo5op
 ey00cr+q30uJVW/wPKHEYsy3awrND6n+pyDLrUZCq3YCFpiNk2cZAoa5RizHTfSv2H7v
 bXIQoZ8MOHHUljqgL2wLupnJTW1kVMtpmg/95t0oZm8qS8eDu1kUbjGlO8q9pzT6pB6K
 8ZPQ==
X-Gm-Message-State: AFq9FYJ5KfKVZ9g/DqMovksDG+mZZqb/GimErbj+8gzlarzNxgHcseN1
 h0wUiUdQTWTnU17czk5kOw0xkDRHJj9+8hRjI7hLceo1ZVygBJY5vNd/MX0xm6tVhVyyYyOkW/Z
 KeWg+Z4mcQcR0V37oW77qZnAZ217F4ABCFicItO9E4r940aH/IurJ5cwbrbUKmYSL3g==
X-Gm-Gg: AYBFou0z5s8fhZcgJ1dX4/dd8wBNLN3rxcYE14kLkn9EQJQrFu0Q9sgaky7c4Gh29Mx
 JxbK4i55W6+60QokDNHz/jICGy/fHHG8Hdq9nW2hdxnP6ZBldjLXB6jWvktt8wTZpR3XWQc45gj
 sKVaFJnR5zbwN+AMMMNsCTFP7zCXT94zxAI6q6c6M5puDzf5B7FsWp69F3DF55H8gYinGYfsrW2
 W0JSqXljwkMMXYzireiQSdXDP5UoUngb+8DTOYXABZJxcM3GlzEQvt7eVjvFoVuQnFfN15mY0kr
 Ja89vvq2In8b9l3YqB2npmabTpBfbn4U5PlMGFrm4kjC4sfaw7JbgA5TmWusSN/Fm39QCvTLlVc
 X5JxZxsqExWuusk97F57/BVJyu4FahhXISsgSJIz/
X-Received: by 2002:a05:620a:6404:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-93f6f819040mr139590685a.51.1792705915388; 
 Thu, 22 Oct 2026 14:51:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6404:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-93f6f819040mr139589085a.51.1792705914824; 
 Thu, 22 Oct 2026 14:51:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37eded3fsm682214f8f.7.2026.10.22.14.51.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/33] target/alpha: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:45 +0200
Message-ID: <20261022215115.19680-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: afLchSSGNdprEPhy5tXMUd33zuAyks_S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzRxyOdQuWed6
 +Iu7E+TPfCeGXaLivJwH1AOMhp2BawNvmt4Ep+lPmFkLifGt1UmgK/qFWsnoGI5uuNn6kAfSxW2
 rvUzq0TRwFhNGB3dllgImN3YryaRfO0=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada857c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kVf6GzFcR4OVXmdlW0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/RYjg2DRMxbc
 dlLQFIqVsMh3AB1tKS9hyGx7pjcbxLXxKt5ymXQYMZrfi6ryPkKq/R2YwuvInYd2ANNjWFOC4/j
 8QAyXzk+YlTD1vtO8rADqnghq3dIdBu5Yun3oiQrndnWEocyP2r/F+OV4hC512dj588rknMkkot
 2KX1zC4kKQ4w9LkjnUOAKmRi2lxpyr+NF7dDmMAsLiUv1rrIHfWMzqeZRpI19j8he3hN855So5l
 5lQyuYGMleBq8l5MI2er2zMJKmOa3mZ/tScnBZ9Vp74bazB81izPkO1bITKLL+aPo9Ofk7QDPdK
 tV9xAxALt/bRlgq+iePo9Grn33dkyTwebaNwOSRku01N0dCDbW5+ofHnsoywR99ZaTxLbf3ilHE
 /K6EMIeZY06IkXbBsKzGebeJ59RxCyMER+iooZ+TAPng5MURqq5fOYm5T7qOHwjWP/89mh1kRVB
 BIGNYl7yj72OWuCrQQw==
X-Proofpoint-ORIG-GUID: afLchSSGNdprEPhy5tXMUd33zuAyks_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
index 12e86021663..f9936315fa2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
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



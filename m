Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF728CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJk-0004hx-T9; Wed, 07 Oct 2026 05:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODh-0007gH-71
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEODf-0000Pr-Kp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:45:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jXxi3810929
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PU2VI6qkNXDpdbk5m0DZh1qRxqSHfKnXWyfKAEv1H0k=; b=CQs6CVLt0IW/6zEQ
 08MhSDRrfr6NeDHOvzIgEUvCr1SvTqpS+SzA6Fg6ukJyLT0y/JcI4hjJK1EQaJ7k
 zxjWQQvsBW8UYY2zt+yfc6KeCD/5GYYul1JDW4GBcbPjBW70q53ULvlgRdRdViEj
 TksALsiof6Muho4WcIzdF8K+4F7pBf9KtFENJey84Tt4zyqx3xgExZ+lUWlIF3ue
 /gELgxM+uBFTHkAFSwcVwvp3i8vKYwtda0bH/yOjp3TNyO/FiEO11XhSOvrfHYsE
 4hHn09VTdwhUw7Hl1q0/UESOJ9XcrJXUyprO0POnew7THCVf12QaX/96X042sTtT
 upRQ3Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5gvrrn74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:45:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so863479685a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366349; x=1791971149; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PU2VI6qkNXDpdbk5m0DZh1qRxqSHfKnXWyfKAEv1H0k=;
 b=RauIelpsvid1bfUGlGK3484PldBwTAtbm/chTISecUHlbTxYGjeLVYZ2Q2Uzry3GkQ
 IUaIH4coLLXwKUESL71P/NbtnSkicJVkJ0OH7+0j5OGAkC2TpzxlNyj3cYBOE7K4F4QK
 h0vC3xHk2oA2HV0cGJH//9KwdN/XF5v36LNQuKTgSDRCLKBHw1pWT/35PyGBh9XHNrVl
 e6A3XFJEGETCZGwyO05h1P3Bbs8XNXkj6FzBZ5sqpVD9aUDMVBtnwvw579KNzeLNXCzj
 b2ACEtnPkuyiUJ2y+5qZsbObmr2ceI6YUmgHPfnaTkw+7TkNEEnvOILxabTEYLAUvu7p
 UH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366349; x=1791971149;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PU2VI6qkNXDpdbk5m0DZh1qRxqSHfKnXWyfKAEv1H0k=;
 b=ql465WktWFuyblus/kbECyB0J2UDGMMP5fu2UCIw17zpvx3viVClHWOFm/162/eBz3
 EPXwXtCp2V5E1ksnr07xF/OiiEw/vrA+7cJqGUd0vlLJt8k6Y0GcRlWguXKF4rNkePPr
 7/Qsz1OVszkDyvlBVVqcR20BUxWnLZXJm3zbzTNBpTKgK37SsAR81hk3lK272QGkD0AQ
 1Ox9ym1F8dvOchFXg+oaGYCN6SRwe+w6gcrzmBFlURDqVvZFgHRIoOnz0HZsLnI9F6D+
 yjkYsc8zrLVNZ9JpPl9b1y5bKa8JIRk8ALAI0hPC6caiBGLBg/5tVjhVvapR1zZkBUqu
 t4PQ==
X-Gm-Message-State: AFuF++m2512Eo+bq2mfNEC8UTjacOuhE1b9w7WJqRbxTCO5J2+vpSVsE
 LngMDNTjN2gwFZW1y+Bd8W66tR3qDINn5HlAeDGvx4KJwM+uUeIquPpQKTr4XOwpEg1Eib96ZQo
 WAXlIS6sLG0VUQymQaws5X3gouZzX1aw5bG6ctZkD8M1znd6D+Lremom3Ihftb0no1Nyh
X-Gm-Gg: AYBFou1zjaY+2OpmkQzr8SAqJEp1rnvwMWs1KTtlPTNTg25KYZaqnbSNGlaeytPl5os
 L8ytEsH0BT5NzykHmCTDNzhxIpnHEQSRnn6AwHqbbuzyxxXW4nSvVbKyZv1fiLJGkXst3RyAfzR
 6dUAnmlfQ8AlU1cOTDDypFC97W/uIWsztmoYCC6g/7E3l+rIqXSEGi56gE7oIsyXpRNwWrw2JVc
 ThbxTG1lpzYzmM1hL+9MIXFfKfhBPO1+nRDn8V6N4mku0sRE66NtLVfBCL9kr0/hZGEngl093Vh
 tfqwbtPE19RAayaSEmk7Rp/wU6vUhnpOMEQlXLRgjiLmunXhojUdbmswCK4bd+hzJy8+iPnup3h
 vGsRD1KuZ4oC0ramJ/j/AyaZVhsmYbSboqPGagAM1
X-Received: by 2002:a05:620a:444a:b0:93e:9809:26c with SMTP id
 af79cd13be357-93e9b84eb17mr288152085a.68.1791366348732; 
 Wed, 07 Oct 2026 02:45:48 -0700 (PDT)
X-Received: by 2002:a05:620a:444a:b0:93e:9809:26c with SMTP id
 af79cd13be357-93e9b84eb17mr288148685a.68.1791366348068; 
 Wed, 07 Oct 2026 02:45:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f54a55esm52027285e9.3.2026.10.07.02.45.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:45:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH 04/27] target/arm: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:44:52 +0200
Message-ID: <20261007094516.75732-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W66txhWk c=1 sm=1 tr=0 ts=6ac614cd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=QvePOBYGvqDf6_zMoJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: XKd28YmEWuZ9CexUum5uPRZNmBiFwZcw
X-Proofpoint-GUID: XKd28YmEWuZ9CexUum5uPRZNmBiFwZcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXw/Z0qeDKUZht
 8G4ipydpGAw9F7pB6+WcumZWu3NZnQYwMA5B/j2XU1+nNJpfn7tRgxpvxjHdp7rtKVqq1JrO3AT
 WGXwE18p8HZgHibuRMk3F7KJEEMPFt7gFgNiGfwW2POlRg8yOGYfjNCoYV3j9nLI7DA3JRoaktD
 3OKNdWX+PKmtb58ZVp/zPu8mGb7ZtQGdxwAVzRz4jopsmiPVRAFDjD8w0eCnvISvnnmmxkRV8eU
 pR9ff+/g6vyc633M2nNJeR8+Vc7rLjGTt4DHcd4OLm5+acqg4etohKQAJylYuP29uyD58HaekKJ
 yMAKcJns7HCgSr3IxXetVwWj96m43NKUbePPp7SFWUnrn3xm8WEDhphAnRje/OoIFQtxVk6RYTy
 ouxvWAU4pnY4BD8eznOli9fcLR5nSWHpaxiDJHJksU/0v8xQvWOUPIX22FjofeVnvcuGu3y9wUr
 V4m9sDF8Nw2TODCghIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX2q2GpNliEQ/M
 qqggkZgx/bf0bdI8iLLN+batEc/OKCTSIWgdeqLn1eFsDlMYdpIrH27YFOG1nfSRi8HxisTeeSY
 9PNtFvxz0rQUDxl77Kvg95t4C3khkws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

Factor arm_exception_name() out of arm_log_exception() and
register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve ARM exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.h    |  2 ++
 target/arm/cpu.c    |  1 +
 target/arm/helper.c | 79 +++++++++++++++++++++++----------------------
 3 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ebed4a8fd..b4b4ca52d19 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -67,6 +67,8 @@
 #define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
+const char *arm_exception_name(int excp);
+
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
 #define ARMV7M_EXCP_HARD    3
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c98318..b12bb07b59b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2647,6 +2647,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
+    cc->exception_name = arm_exception_name;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff0b766b73d..94c05121214 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8802,46 +8802,8 @@ void arm_log_exception(CPUState *cs)
     int idx = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *exc = NULL;
-        static const char * const excnames[] = {
-            [EXCP_UDEF] = "Undefined Instruction",
-            [EXCP_SWI] = "SVC",
-            [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
-            [EXCP_DATA_ABORT] = "Data Abort",
-            [EXCP_IRQ] = "IRQ",
-            [EXCP_FIQ] = "FIQ",
-            [EXCP_BKPT] = "Breakpoint",
-            [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
-            [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
-            [EXCP_HVC] = "Hypervisor Call",
-            [EXCP_HYP_TRAP] = "Hypervisor Trap",
-            [EXCP_SMC] = "Secure Monitor Call",
-            [EXCP_VIRQ] = "Virtual IRQ",
-            [EXCP_VFIQ] = "Virtual FIQ",
-            [EXCP_SEMIHOST] = "Semihosting call",
-            [EXCP_NOCP] = "v7M NOCP UsageFault",
-            [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
-            [EXCP_STKOF] = "v8M STKOF UsageFault",
-            [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
-            [EXCP_LSERR] = "v8M LSERR UsageFault",
-            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
-            [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
-            [EXCP_VSERR] = "Virtual SERR",
-            [EXCP_GPC] = "Granule Protection Check",
-            [EXCP_NMI] = "NMI",
-            [EXCP_VINMI] = "Virtual IRQ NMI",
-            [EXCP_VFNMI] = "Virtual FIQ NMI",
-            [EXCP_MON_TRAP] = "Monitor Trap",
-        };
-
-        if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
-            exc = excnames[idx];
-        }
-        if (!exc) {
-            exc = "unknown";
-        }
         qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s] on CPU %d\n",
-                      idx, exc, cs->cpu_index);
+                      idx, arm_exception_name(idx), cs->cpu_index);
     }
 }
 
@@ -9928,6 +9890,45 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+const char *arm_exception_name(int excp)
+{
+    static const char * const excnames[] = {
+        [EXCP_UDEF] = "Undefined Instruction",
+        [EXCP_SWI] = "SVC",
+        [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
+        [EXCP_DATA_ABORT] = "Data Abort",
+        [EXCP_IRQ] = "IRQ",
+        [EXCP_FIQ] = "FIQ",
+        [EXCP_BKPT] = "Breakpoint",
+        [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
+        [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
+        [EXCP_HVC] = "Hypervisor Call",
+        [EXCP_HYP_TRAP] = "Hypervisor Trap",
+        [EXCP_SMC] = "Secure Monitor Call",
+        [EXCP_VIRQ] = "Virtual IRQ",
+        [EXCP_VFIQ] = "Virtual FIQ",
+        [EXCP_SEMIHOST] = "Semihosting call",
+        [EXCP_NOCP] = "v7M NOCP UsageFault",
+        [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
+        [EXCP_STKOF] = "v8M STKOF UsageFault",
+        [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
+        [EXCP_LSERR] = "v8M LSERR UsageFault",
+        [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
+        [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
+        [EXCP_VSERR] = "Virtual SERR",
+        [EXCP_GPC] = "Granule Protection Check",
+        [EXCP_NMI] = "NMI",
+        [EXCP_VINMI] = "Virtual IRQ NMI",
+        [EXCP_VFNMI] = "Virtual FIQ NMI",
+        [EXCP_MON_TRAP] = "Monitor Trap",
+    };
+
+    if (excp < 0 || excp >= ARRAY_SIZE(excnames) || !excnames[excp]) {
+        return "unknown";
+    }
+    return excnames[excp];
+}
+
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
-- 
2.55.0



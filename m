Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B351CC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMpl-0004Tu-09; Fri, 21 Aug 2026 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpk-0004TX-Cp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpi-0003T4-Ml
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9LfKq3029206
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=; b=hc1m1jrOV7xNBmy2
 nsErzd8irCu0V8T5lU2FNpk5HSArK7xrwmJ1tp25bDKhbiirYNMW4dwVtfFJQqs2
 b1oFTiFY38c4vl8wEODQtmeXShtgn43erv8SnTXH88TfBJMl6R0JkMpS2DgHmHkh
 0w6pe84bsZcpX7tKaLvv+mTGuTMeDA+xuN/UDsPyY7ypP6/o+3fVlgH2rdB4B+f0
 hLdPb23EMX6x7lesqCQiGf8KPRBiCiejDZG0yBMACet1Kgg2ptTkebMQB52An3as
 ZGLPA/1yQvuEMJY9DPGSjTRWo3nj7UysjChkFZyoXDCwxRyZ+fJkE4sWZlrNTqTi
 HML6+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9sae3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so14415331cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309444; x=1787914244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=;
 b=X5JNCCRPFEPBBgehUnYE1n6fEFFY6FUehAIVDPBm+n7YGeOiwkCpovTpaJEn/UZf32
 drHhKvB3y4rUWZquyNzEYQVq/sJpJ9EwcsHEsT5XTmePbPpg+71hkNHNy5vi+Gp2FLu8
 D+PD6JAQ6FAmHNGgtKIYkV/2/0aaJpPlOa5vZquKXMkC7DdQHwr8cs0rIhP1SaubCG16
 j+Ygy+bbn/NUeTUOrx/g+OxpQ0Qk7Uz9zXTZSFisQdYgus0UYLVxPLA9C88NS/C9B+Lw
 78R+Zz008XV/Dw033oNzEkUcnQW4zydnQs/CGLVijl20qlZB4+ctg83opE15+HtBsFcp
 6/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309444; x=1787914244;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=;
 b=qjGT09DR3+jArt4YJIwYnbI9PbNEuhi1iE/HqPVbIRfXX2mZARu0ANhnC6OOl/MbwA
 bQtaiPo29hsXR/o+Y7ou/RK7+HCz+UBP1e3aKJ8WdWASRCK9WCT2aCBoP7mbdDJRp26g
 62IsX+re/vSfpr5/Ej+zb0YQ3kKKQUiuFk4+W6uaQ+ua8yvAGw5nmfmfAKRlgSGAEKqt
 gd4reCgmkEBRpvIUc7Gn0Jo0gMGc+5r3IQB6nknvjLjqiiHejhqgs11+TKQ5Qc+S5h0q
 YNYMoqvWqmf4Zyg7kNC2XTawOHrQs/pwmB4+eypYeZ5XPRWfEkMFapcm6bSI+gl/kcFK
 vzeg==
X-Gm-Message-State: AOJu0YyUiBGgOOphv0D5GbyX3oRV3zuNCJrzpksLkp0CSrnqBmpsQCGx
 Ge6Jk8ghyEJeOM2N38sCQCGlhFT5YvDh474QhZ0a8pXQ/1FlVQYrJVyap1cNZRu4wK1zdGHUPAI
 vK30NuOtw8zmjekRXteDBiqKDgS4hzy1EUXe1X0TJBvfTwR4oDfwlrU0MoAmnLVhLqiiD
X-Gm-Gg: AR+sD12DV2BYOkVVF8pKGnqWDP7IYHTDrDIhOe2F85DTvlw8V1SUBPGR9o/iElPp9gn
 pazDitLl5ifUgFBMyMZACMxdjWHl97+MvN/MuC5UTqGQW8HLQjMFRWpKiuiW3xffmxjgmqD0DT4
 BCVFvJd/gPSaFEngxlblOmHMN6bFoSoxCkeDLg0nDhuupuh7o4ALyZp4jbdHCDaXNniXOfjRnul
 E6szzGIm3z4P2Sl16PEn9l41BpKbLGvo1VxC1SM+fyXQzysd/ghtZG14t7LepD8fjNUBJ5iWGhC
 5TCSOmjnIraPZlne05PT2nNKqfcn7gWP6X1ieV/h7gZbaMDPJhG58Xewlx1PSt1BKVIcRmRrxOx
 srAUasVpLmQZbuqSwchTyIEQjx+yCuVYWZns2xKO1wg==
X-Received: by 2002:ac8:7f96:0:b0:51b:fd82:22dd with SMTP id
 d75a77b69052e-52df5698102mr47698311cf.15.1787309444182; 
 Fri, 21 Aug 2026 03:50:44 -0700 (PDT)
X-Received: by 2002:ac8:7f96:0:b0:51b:fd82:22dd with SMTP id
 d75a77b69052e-52df5698102mr47698011cf.15.1787309443839; 
 Fri, 21 Aug 2026 03:50:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm18640395f8f.5.2026.08.21.03.50.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 07/15] target/i386: Constify CPU*State for
 cpu_*_interrupt() getters
Date: Fri, 21 Aug 2026 12:49:41 +0200
Message-ID: <20260821104950.32108-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX3GZr8UQBcM1Q
 gzzhxXQTCWBs1xg/IiSHWRhMD5OavGPJUsLA+T0u09FqS3KXlaxIW9VV99Aio0gVBjrkXb2TUFs
 pyvMNSoNtz6UKbr+HruTBKeePiageJDfUBiyg7d53iVZETTCUYNtQyGxyqzFTznm7IHbq3JFSBe
 x/f7MBOMqt//CrEPld+hEd6V8XTFCzCdrKsMJqK1NTW60Y7EBxqUCAjvNEjeWQakAAwe1CZU2vF
 jrqgeLBZyys9DfIm40WAgINtQ2z8XAYaR3fFwqgj5yKvZ3LoDOboaLvLYIPjDBy16KzdUVP/+/b
 p5a4KhIapfBSjmpuCu+rDGZg8/ceCfxyDjJZJG6CSM3kvyMjHa4O3hxlZ4N1jcVM0SrtK6d2t1T
 71yX1JjKAogLbQv3Mz/98Y3sDLhwgyxaSd4KCusfd0s1olC9D/v8jIYW61XZDKLP+M6b25GW7BM
 YoCFw6eNoquA6FYu8Tg==
X-Proofpoint-ORIG-GUID: Y9YF9y2iRdhTZ-Oq7L8R-uFGTIeWe1bT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXzwFUlDn/pMHP
 NjkUHBPfePBiHbZywRZa5Nwiop2PSKsDrK9M+F+VTDOll9TR4j8Y2UowKWYNW7CcRIPJYhOp7ig
 wdCX0hU2eyGMEuSt5yqhL7Ozz//3VgA=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a882d85 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Y9YF9y2iRdhTZ-Oq7L8R-uFGTIeWe1bT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

x86_cpu_pending_interrupt() and x86_cpu_interrupts_enabled()
only read CPU state without modification, add the const
qualifiers to CPUState and CPUX86State parameters.
Simplify directly using cpu_env() in x86_cpu_pending_interrupt.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2f..b0436dbf665 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2596,7 +2596,7 @@ void x86_cpu_gdb_init(CPUState *cs);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request);
 
 bool x86_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
                                  TranslateForDebugResult *result);
@@ -3104,7 +3104,7 @@ static inline bool ctl_has_irq(CPUX86State *env)
     return (env->int_ctl & V_IRQ_MASK) && (int_prio >= tpr);
 }
 
-static inline bool x86_cpu_interrupts_enabled(CPUX86State *env)
+static inline bool x86_cpu_interrupts_enabled(const CPUX86State *env)
 {
     return ((env->eflags & IF_MASK) &&
             !(env->hflags & HF_INHIBIT_IRQ_MASK)) ||
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d156..1fc02cf94e6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10601,10 +10601,9 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
+int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    const CPUX86State *env = cpu_env(cs);
 
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
-- 
2.53.0



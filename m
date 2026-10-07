Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AA6CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOL0-0007Mm-SS; Wed, 07 Oct 2026 05:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOE3-0007me-8r
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOE0-0000V9-R4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:14 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jnf92711451
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VRr7SXlvgg1rq+U/lhmfMLhRTjRXzuQ0j6/7MduTc/4=; b=Fwic03t8tqmOda0t
 rz/DQgvLbItd5+lllc4IwYfXhWGyv5+E9LmREA+ya70XuGxMaC5vVNSR6e0jb03l
 A8XdcMiNnPOLB5dxyDwV+Mn3fZXxq/EjkmRhZlwSitgKmz6HxOzJsgaSVaDEt7xz
 udXlAEDf+lVYmiGPWe9g5VQ3o4FmfS9tm40A8nsOhnLtB7BPMiKgN41dYc2iC9Wf
 o6PsIuFUB2GC3xVrcRRoiRDjxUMStGGE7pJ1Az+F2SNODQoTpwSys+QOg8r/IZau
 ductpm/5zidKZKVLIPLD3j2bTQ4hTWF7OFxnz94igQWkHTIqTfV903/daYVFG8mr
 LkxGvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s1j7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so653797785a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366370; x=1791971170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VRr7SXlvgg1rq+U/lhmfMLhRTjRXzuQ0j6/7MduTc/4=;
 b=YX71rf+JbflAa9ssNBNIH83tMhAKk5fqYkbdE5aTME46rPcQlMbJthgV2hpqrJHmGi
 weI1BBVNBy2+WMcJvAIC3KBifICDLXcpbkKRSus8p7PfpYQJf1wAHk44l4hLDTeW+ZbF
 eAgQEXE5z3FPEwJDxCuMosMQMpOa0Gxoeb1igYndqZJMpw9urp2Eo3idabSe1R5rp6+q
 RIGOU8EpoSADPzNQIfE+eNd4nTLFk9QEoRFN9+EtH47yJQfWJ8KL/jihp8kqHBZuNu9j
 VzcoX2ynfpQ1jc6UTM+e4Y7TlNSDIW8h2BqljO3EwIHcEXbdlbRn/x3bSozAOFAA3YwZ
 kz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366370; x=1791971170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VRr7SXlvgg1rq+U/lhmfMLhRTjRXzuQ0j6/7MduTc/4=;
 b=i/PcpZAgFLGrUpKogU9/NOIrBbi4AFnIItzOhsgmAQ3cXTNwn25jmOPwIsIQlwndE+
 klmlXhjFvgZHmDpEUIgMvYbK+mky7HkVKGj0b3QpFVDWcCNn2ekVN7jXHO/r3XGKJTiK
 YYv+pllhGWinptuIdmk0RhRbTgABeWQHuvsNyvTVcGOzLLkgBf8xjJC+mDy1YwRij2+1
 2CO1uKNxEG84351rdEQi+IqMrxaiXYXtCslkM025oPn+FV13eWn2kS4mmCpm1GGduzfY
 /8lpBuk8Km6vkQrgnCZIj7a3KdBbwSXvoPlOhBMxB73Jw+KnjESnfIrqeU46PzPWiCp3
 y7vw==
X-Gm-Message-State: AFuF++ma9rJLiG5NgD3/AMOVJfk4Crw8mBLsuOsCgi5ZYIhzgK/Hl/Hi
 1qcGQQF7fhTFkniDRUWs+tT7VUNgZMEZroRgakhBQhsv5XEDFFZQcZGXU27cmzFaVtDfeQnsdyN
 mJhZXo2GWO3duwL2WvUCvZ8hpIp9ziwzBc4sPf1RzIRxEBNfW2j6IkrLlPjT+9TeqXon1
X-Gm-Gg: AYBFou0S70lY7t00vArcZ6G6uunrUphTONSXfgwsC6GIKRucl+t3JIjaxnRdIsY+GtT
 poICVHWzlNVrI/QPmFkizhrxepEtmLWISZS2aKbKjdxpE8pWIAPaK38XF25YbHH8kSXiIoCTEAv
 wLgiga2ftyEOpHDHfZtfV+pK1Y0xgc88ZC6rt7DbkpqAUxqSDe39VWhEg8a2P5DYq5fH0IF0uaR
 TwDi0SDaEvo060+fXV82QUu7A2RNgaHYZEhilRfUNVwWgwrJ5J3dTmwbORMfR+B7LqgMuKMqh/1
 4g9+XDDcApALwEceSSC18OEPHUIeSo5uUNM0NTZbtbQamjhu5kXPJd+TlaK2UOIIATCcrAA4S5Y
 xrEVwT0g80nlyX74Nqp5ryJxL4wFPmxrPuKa1Z6lg
X-Received: by 2002:a05:620a:4410:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93e9af43264mr350350585a.0.1791366369944; 
 Wed, 07 Oct 2026 02:46:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4410:b0:93c:b6db:8c with SMTP id
 af79cd13be357-93e9af43264mr350345485a.0.1791366369292; 
 Wed, 07 Oct 2026 02:46:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3b502sm4688109f8f.52.2026.10.07.02.46.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 07/27] target/hppa: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:44:55 +0200
Message-ID: <20261007094516.75732-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p50w-SX1LB_zIAEUsmE0XraP9HpO0hc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXzEAsWELEvS4q
 mQ98Zox7dogY9Dmyb4Oeg0+SR7N4kUhz/6cfZqgbOeO2qqTlYDeJuW2gKd/AgDFYi3PHma57/sA
 B/bpVtd5zoCSDW4Bun8bYUJAR1BCtcUFOh5JIC03sEWzvWCtAy8VZZfW5wGC3KcaxlnUEKrS8H3
 s1iTf8miCZN/LD5wKOG/Ca6SENo64ddw0IcTQW4uBEjQ/GCxhDLuuFIDHbUOIsFp6YTgcjFrJHE
 nqE1XlxPYBOhySyYOOdHdpIZ9gR8MkDGl5lbJdOAz0uIw++2oEOF9EkeFX9NCU6wigfxPV7+NBi
 aHMIib2n3FVlwbdgB6RoGb7lK4D7mR19g9QRp62DMltxemgV1VU31tWaKmq0PWvqegRylWwe5rJ
 SEAntUKJMTXJpIrv4/7GSXlUyZfd3DT3OkrrZHxZ/6H8WxA0SDA/CNTGovIyXVtofIgXQPpMCfl
 5HB3zEO1P/6SFM+W2QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXxNbw4tlyoIhd
 TTdDsF89/EufzIXPw2uKTeIu1olImTujZEbscSLBhkGbcHOcxjRTxqHbnYNmVnkIehWZ4PYNX2L
 8QkhwtzYvZLcC3yVAfOIvkxIcZrCJEs=
X-Proofpoint-GUID: p50w-SX1LB_zIAEUsmE0XraP9HpO0hc5
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac614e3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=TU1vJ8DaLJqu0uKs2-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

Factor hppa_exception_name() out of hppa_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve HPPA exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hppa/cpu.h        |  2 +
 target/hppa/int_helper.c | 91 ++++++++++++++++++++--------------------
 2 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f9..3914b3285c5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -98,6 +98,8 @@
 /* Emulated hardware TOC button */
 #define EXCP_TOC                 32 /* TOC = Transfer of control (NMI) */
 
+const char *hppa_exception_name(int excp);
+
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3         /* TOC */
 
 /* Taken from Linux kernel: arch/parisc/include/asm/psw.h */
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 3e87b9a0011..ad240ab8b2e 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -90,6 +90,49 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
     bql_unlock();
 }
 
+const char *hppa_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_HPMC]          = "high priority machine check",
+        [EXCP_POWER_FAIL]    = "power fail interrupt",
+        [EXCP_RC]            = "recovery counter trap",
+        [EXCP_EXT_INTERRUPT] = "external interrupt",
+        [EXCP_LPMC]          = "low priority machine check",
+        [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
+        [EXCP_IMP]           = "instruction memory protection trap",
+        [EXCP_ILL]           = "illegal instruction trap",
+        [EXCP_BREAK]         = "break instruction trap",
+        [EXCP_PRIV_OPR]      = "privileged operation trap",
+        [EXCP_PRIV_REG]      = "privileged register trap",
+        [EXCP_OVERFLOW]      = "overflow trap",
+        [EXCP_COND]          = "conditional trap",
+        [EXCP_ASSIST]        = "assist exception trap",
+        [EXCP_DTLB_MISS]     = "data tlb miss fault",
+        [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
+        [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
+        [EXCP_DMP]           = "data memory protection trap",
+        [EXCP_DMB]           = "data memory break trap",
+        [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
+        [EXCP_PAGE_REF]      = "page reference trap",
+        [EXCP_ASSIST_EMU]    = "assist emulation trap",
+        [EXCP_HPT]           = "high-privilege transfer trap",
+        [EXCP_LPT]           = "low-privilege transfer trap",
+        [EXCP_TB]            = "taken branch trap",
+        [EXCP_DMAR]          = "data memory access rights trap",
+        [EXCP_DMPI]          = "data memory protection id trap",
+        [EXCP_UNALIGN]       = "unaligned data reference trap",
+        [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
+        [EXCP_SYSCALL]       = "syscall",
+        [EXCP_SYSCALL_LWS]   = "syscall-lws",
+        [EXCP_TOC]           = "TOC (transfer of control)",
+    };
+
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
@@ -235,53 +278,11 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        static const char * const names[] = {
-            [EXCP_HPMC]          = "high priority machine check",
-            [EXCP_POWER_FAIL]    = "power fail interrupt",
-            [EXCP_RC]            = "recovery counter trap",
-            [EXCP_EXT_INTERRUPT] = "external interrupt",
-            [EXCP_LPMC]          = "low priority machine check",
-            [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
-            [EXCP_IMP]           = "instruction memory protection trap",
-            [EXCP_ILL]           = "illegal instruction trap",
-            [EXCP_BREAK]         = "break instruction trap",
-            [EXCP_PRIV_OPR]      = "privileged operation trap",
-            [EXCP_PRIV_REG]      = "privileged register trap",
-            [EXCP_OVERFLOW]      = "overflow trap",
-            [EXCP_COND]          = "conditional trap",
-            [EXCP_ASSIST]        = "assist exception trap",
-            [EXCP_DTLB_MISS]     = "data tlb miss fault",
-            [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
-            [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
-            [EXCP_DMP]           = "data memory protection trap",
-            [EXCP_DMB]           = "data memory break trap",
-            [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
-            [EXCP_PAGE_REF]      = "page reference trap",
-            [EXCP_ASSIST_EMU]    = "assist emulation trap",
-            [EXCP_HPT]           = "high-privilege transfer trap",
-            [EXCP_LPT]           = "low-privilege transfer trap",
-            [EXCP_TB]            = "taken branch trap",
-            [EXCP_DMAR]          = "data memory access rights trap",
-            [EXCP_DMPI]          = "data memory protection id trap",
-            [EXCP_UNALIGN]       = "unaligned data reference trap",
-            [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
-            [EXCP_SYSCALL]       = "syscall",
-            [EXCP_SYSCALL_LWS]   = "syscall-lws",
-            [EXCP_TOC]           = "TOC (transfer of control)",
-        };
-
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
-            const char *name = NULL;
-
-            if (i >= 0 && i < ARRAY_SIZE(names)) {
-                name = names[i];
-            }
-            if (name) {
-                fprintf(logfile, "INT: cpu %d %s\n", cs->cpu_index, name);
-            } else {
-                fprintf(logfile, "INT: cpu %d unknown %d\n", cs->cpu_index, i);
-            }
+            const char *name = hppa_exception_name(i);
+            fprintf(logfile, "INT: cpu %d excp %d (%s)\n",
+                             cs->cpu_index, i, name);
             hppa_cpu_dump_state(cs, logfile, 0);
             qemu_log_unlock(logfile);
         }
-- 
2.55.0



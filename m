Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C07C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhko-000111-DT; Wed, 19 Aug 2026 10:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjk-0008Jz-0X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhji-0000aO-AG
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbtl13550287
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Fzguqwss8Btp9svxAJImwdn9mEae4S+kgFmdeZVkHTM=; b=mW3SUDc289AiED6h
 RrBG1K6SNKvr75KQ77h6/0jhBzSTQ1AGu01RqctDjK2lDdHl6yKw4+evF1IWrKJd
 m2Ul541lSWHNbBOFMHLJ0nyFdfPUlEQm26Dc6y8is79szoA68TsghAdhyn65frOx
 kj2ALtg6pPWIdCfuoByNeLxZq4bE/qGIkvER2fH5N6L8eqHR0z3HXkmrZ61AsH4S
 dgkoxG6UjmyvvKhAAtc/XjJDaHDJiHEnhYIXR/XM8GXKRIiW/KK9QhSB8sN/TE1p
 TtXS/mK3JTEVlZWxDIP04fhohoSiGpjAi/s2Pn2/St75iCV019gZ2m0e0SmkEvBR
 yaAxzQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkbvwj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so197305785a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151469; x=1787756269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fzguqwss8Btp9svxAJImwdn9mEae4S+kgFmdeZVkHTM=;
 b=bvsHo4+fCSVM4Y+oX43c3Dnm4zlv8DAl1V4bZFu89n0lG5tIZ8W0kk6TnIqXj9WDwu
 JRQz0yzai4MlklKwndxICFnrPYtdYuQngCrpBziyEVhVu1ABjfrOmCar/UVdLlHvgDwX
 K/7a9pZpbxkJXOs+wva5GIko6e7lVyH+eJctuSCAaUkAr26BrnVqP+2lEBSJeW9fhlmc
 0mzkA6KEtXfhLeaE9tU3zgSUljb3t0qvZtWMSnw/5VcjE7rmZoyoeF08YRXGXiwavTI1
 l/KEy9IbCBzulIJosHtfO2bpd+bpv+cboegqygiUXQCjriSBitgDDMUx0stUr1zoOl7x
 bZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151469; x=1787756269;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fzguqwss8Btp9svxAJImwdn9mEae4S+kgFmdeZVkHTM=;
 b=FtBktCX9Sy4ugT4XyqhXT7koGlw+j7/qLqMfjYkBl0Otwqhb1ag3rtdi87Ndi5YZSg
 2g3nKmw3rR489aOj0z3Sz0xNSnSmgY4DgCppm5zBqZfuNMdwBK1PMG1bPwC5ZkZxJdxh
 FttGD9x3NbCONvNaOqhbyJMQAGO6AlcQDOadODijAXT/WwNXjjnKjFiU7bDBddNFgJbn
 vggwtxzbTGXDPwRr0g1CxUZs7WhhYbSNrKV1tkQN/pEtSJmsOYN8wc4u05u6QBS9febg
 EY4bw90qh5/0cFJHbQurbWYXTn49gK+ofO14XgLClD5GlR/RmTqkg4WeF8cVaFkVt3/g
 4QVg==
X-Gm-Message-State: AOJu0Yxv8Jf+W+dnez3voyUtoNy1G6gF5ISy+lbFx1TpWilNro5SrilV
 +Jx2UiV81Or3GdfJEfQ3J87eD8Pn7C/n0Y/7+7GAPIcd+BDTcFJG5n5VJjLpPErv+8LtfCMSXFL
 aCGXRfmhVKLo9zGFkn85mGT/I6cGpR0LRWxgNjeMcuCvkwUhr2cfHhFZguOJsfFnc8M6i
X-Gm-Gg: AR+sD1310v5uoAbnp8QR9oK6W8qGpUNbSnVfM9bXGegRh6sZ/qtK8tN9RaWimyN6h5t
 Nm6VqUvNUmdxJqKKElLjM5gxrj2dGYVfU8wpsGD+uRqGxs9FYny1SLMhnM68rgyYi9Zj1DmFtG+
 VbkbqV/xgewsVq75/4YlVfIyKrxYe1sqT//AGOHyDE5s0uOSiTjxYXRQsbp1chhF+s95qBZiHKc
 CgiJZCYU9EJIB+t9hkc4P8sF7rBBN+ZzT/KiXrSiAwAgIqJj2EeOzB4g7G4xv46uj0JUw3O9fRA
 hBxLYycleawFZj6YevKANNEkU8kzfpUeovwiTc7UCf5ypHY7Vm1lzflAWfKYbopM0C5yy1RHswI
 h56MgIahJexqqmtKX2Z7KohWOoIQQ4j8tXukS2CJA7A==
X-Received: by 2002:a05:620a:1710:b0:932:ddff:123d with SMTP id
 af79cd13be357-9371e6f64b6mr522122485a.29.1787151468711; 
 Wed, 19 Aug 2026 07:57:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1710:b0:932:ddff:123d with SMTP id
 af79cd13be357-9371e6f64b6mr522116885a.29.1787151468241; 
 Wed, 19 Aug 2026 07:57:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm6398172f8f.8.2026.08.19.07.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 08/11] target/i386: Extract async event processing out of
 x86_cpu_exec_halt()
Date: Wed, 19 Aug 2026 16:56:46 +0200
Message-ID: <20260819145649.23439-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a85c46d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=h7OMh5kjI76PbTVxvEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX/H6s6UCRncyP
 Bc+J4ayGqzfucXdka6M6hLFvO0/uZyizGsKd8ChldALvi2chHilaeNjhjQjuoYjNZlYieaHkwhr
 flxgnQRNXFwxSSHFa/tpmrahng+Ll84g7MOiGHfP0/EF0+a3fIN3j3zxE1szO89X1dUIxmgz/rH
 ZagxzvbHrxG0wmWBFGA0Kitt+wfYfmrXwUgqtcUXayivfCUnHJi3A6x1RNhDRhdeNOjpyCIAqzp
 Mo/6VV2gKiLmqUVG3mG1w4qYHL/oK/mI5abXQmP6XwY9lrUGp0wV2Y547sDnBbGkLNiInTZqjY0
 V1NUBNGgg8QxkK7p1dDHM8KWOzZNI+ZRF13fNnflr4AyqXW7IEe6wtYDazL5EvlGxD4IrDm8VpJ
 wLSaEQoIit7rimN+QjDVKQVPBJeQlHH7nrlvz4GwJiSQ5sTMZIf3xrtUGYEb8rd3UhfA7NIQB8S
 5q/iZeJAeic4PqtBhiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX8Bw8kWmdXN6Q
 Jb2OTPkhNVHDQmaFruQyh3pJruMqNIo8sw6yFNbM5kRx1TNv64FLX0Jtiz+KYsrCDgHzqAUp4iC
 jfBgsu9+nrqQn8fVActwrSGt5+uEJYY=
X-Proofpoint-GUID: 0nPbC4NJaIdxE6eaS8_Jae9_QUsGgI2T
X-Proofpoint-ORIG-GUID: 0nPbC4NJaIdxE6eaS8_Jae9_QUsGgI2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Refactor the target-specific async event processing logic (APIC
polling) into a separate x86_cpu_process_async_events() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index f4b2ff740d5..cab197368b9 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -37,6 +37,7 @@
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
+void x86_cpu_process_async_events(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 8c7856be81e..4856a6b3bab 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -128,10 +128,9 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_process_async_events(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_POLL)) {
         bql_lock();
@@ -139,6 +138,14 @@ bool x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    x86_cpu_process_async_events(cpu);
 
     if (!cpu_has_work(cpu)) {
         return false;
-- 
2.53.0



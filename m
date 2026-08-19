Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66E4C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhjL-0007yQ-4b; Wed, 19 Aug 2026 10:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhj5-0007os-5O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhj3-0000UP-Ge
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbogM1117524
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I96uBStEzwv3QchDG24HNeNgtTZ6xFHi7FY8PK7OH5U=; b=YYe0B2U0ZvLRA3aa
 qXxc4CIP5t0l6TcwJz37XChBEi32U0uhI3muvh1wHYe97QxrnuW2SAs6wGy1MmqM
 q/RLyaEXxhuJetZ7/JpGe7LFMyNO0mh5s7hfMYXKhZCisqkvhc0KQ7AEQMSIM1Pa
 phIIAbuy0go4KlbLrj1xAtFwqo7iL2CQqX8pROJ+teuDxLp7nUOTI8lNfCH82P6W
 o6LqU2FC8epYBSil3IOh5jp//PRPgUpWazmT4w1FPKRdY1CuW/RJ21mOlQT11Dct
 75iCluyJTfRvb4VzUOCi6LZ4VdGX7o2fUyuChdZufDtnQfFjdHpjFgr0HXcAOWiy
 C0BiRw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpus16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9349c5af52bso192702185a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151426; x=1787756226; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I96uBStEzwv3QchDG24HNeNgtTZ6xFHi7FY8PK7OH5U=;
 b=OYvf6NMszWyNrXwj0hMES1GRBnD1jJs5NQqG6y2c2cI3zxsJUh1sU7T+wrsf+920ZR
 jmiN+BFbnkr8Km53FQ1yW1A/XnusloW/kjryDvOp6LyyXhPSSCiKkIFxGIyYJUz4bTDg
 PxUiMRkL3IBaQmPQCFYV/2TXjcc/Zmp9uSrxUiXlFlUrSUN4iOk/XwrBDXeuipKjuDkR
 bpRgwapMKHOaXHVo+vWwYTgjAPf+8g04P33ymS9E1Y7Qb7GDrvl3wPSMD4AyrH8MXssk
 wlUatYRpVV8l9STFi9wtDCyMVb2bAnzakqKvKgzdxCD15cUG5UsfSXO6hdbkfPsd/v25
 gQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151426; x=1787756226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I96uBStEzwv3QchDG24HNeNgtTZ6xFHi7FY8PK7OH5U=;
 b=kRVsh5ssDdTjGrztk12cIXi4TYwvoo5T14/AIAiKuOpY703h/ROeGdEIeltmcDcVOz
 5fSmN2XCFLzFEtiK/oKenFTwoMLMgJSF+HQX1JaePp+whnWLG8V7FCuY9p8H4q+RZtPX
 FDEFpD8flgitB6dZZYz/Wra8fuoQ+EYdMnKp/ISsQAcuk3aJs/t+sOJ9YEkPKbHbc/hs
 5A8pfFR/7Km4XjKeR5lQqZFlOR3zBifLweDSFKVvsjwovv0H+KvONOIugRJk6EvOtV4U
 xfaO+BG3Bhpy83bgiVSVXbcqwZ21N+YGoweHvG5ZVFxyl+dkr7AQFh8A41GuqRdU/hAg
 aPyA==
X-Gm-Message-State: AOJu0Yy1XBLvOFGtoxD/ZH7q5YUzXsVNWMM1ZiqmWNauv3OQFRyIdn3J
 9vjWUOuL/kE0zhX3XML784jWuMLPyM/T9f7zEAdcyCoQichRE7iHiaOv8F3GKVTA8x2ojI22GIn
 RKjFOZi9C2GG5nHtnRzZq/brgZgb+k+2vvS9dxryizLJqqKRrnVOlPozVc5bHZUWRu9Rp
X-Gm-Gg: AR+sD11/nczi9NFHHdi9MIIvHlgFP7UP8WU11eI8x1eyVMDR2W4uBzACpODTidrStPx
 GxvoXUmacvhg6rCUAB0Qyaiywz0ez9hP99ciji8bk+lvxMmwaByAl+NCz0e5thVO3G72ZRepjr6
 vKahkiQV3vwLP+44SJ0Z0Fw4buJBA/mL2Gx3CmswTNSsiNUMWcXeWvuMS0nhpX/Rq6zekP4cPIi
 A/X2sQV+ug85UUGakkMvUgZf7KvmZVUUM2rt8ByXmkeZe8lPt063sPNthR+8myxOQPgXNQq6F9s
 P4pZnEOOOYBAt76Lqe9aM+z1w/A3u9neFclI6C9JdVmEe/GFsDNC1MnOKopF1PRTDUU+DTBxUny
 eSq6cV/srlLYqKpkpHm2istXkgNVn5YsulTB0MXDpqQ==
X-Received: by 2002:a05:620a:278c:b0:936:bcd6:269d with SMTP id
 af79cd13be357-9371e1de2d4mr526777585a.6.1787151426162; 
 Wed, 19 Aug 2026 07:57:06 -0700 (PDT)
X-Received: by 2002:a05:620a:278c:b0:936:bcd6:269d with SMTP id
 af79cd13be357-9371e1de2d4mr526772285a.6.1787151425754; 
 Wed, 19 Aug 2026 07:57:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm5089325e9.4.2026.08.19.07.57.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 02/11] accel/tcg: Restrict EXCP_HALTED handling to system
 emulation
Date: Wed, 19 Aug 2026 16:56:40 +0200
Message-ID: <20260819145649.23439-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TaU-EhjGus_vWSrHm4FhsET3I8IqcOjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX7Yh0ZZENeAuk
 VLqo8yH2RHlzjgVs39L+dCHF5uSRjFM8HDuFp6qO4tK12Pbdbk3RlI9T8RX3qcF7mnuYfAa2PBB
 RTMjCGimzJ9CzG/vdnBmI59ZEmFsvhInXmjT8bRAlKh9F7BO12u9xt7s1EfUWY6tUfmoCsbbbEd
 mZjAhIVmhaXmAYAh7odKOCQc8u9okPJf+YXnUbYxgSA9z4IOZieQYZ03xMYVfXi2YIGOJys4k7I
 EsMEGedZt62vE9z2NZIX8AMO26y5u8qF1s34/SH3Fgvy3xABrABYcoQpNj6EXPwN4CPWIyvc8a2
 JmhM9HqyVdsWL5Iuvdro20g0lgo8z06+3b0JPU1RQ1gPO7ZPDWJ+FkoC8cFlX8iL2M9+v14qYIx
 rmQmoCqmZ1USyWsickUgBAQRLs4c43bhdHUi3vL1XP6ypyRWt/WopDOHWptSmih6NY+538OmSTb
 Xa5fqLh7s7ZZNaSyQbQ==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85c443 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-hA0-U2ujmm1-e6JBJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: TaU-EhjGus_vWSrHm4FhsET3I8IqcOjq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX46FsqWD77z3y
 FKc8UHV4x/zD4YPzqooMpqYl6zjaecRg7kHkAOWxIIlHwREzjPdFm2lKtSxDPWYcM6TGWfdHDb0
 QYlrktye3+9O0poAxJ0tPlGfQdkIJ5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

EXCP_HALTED is defined and documented in "exec/cpu-common.h" as:

 #define EXCP_HALTED 0x10003 /* cpu is halted (waiting for external event) */

Since vCPUs can not be halted in user-mode emulation, guard the
whole block within !CONFIG_USER_ONLY section. No logic changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 53d90c400d5..69207301d1d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -653,9 +653,9 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
     qemu_spin_unlock(&tb_next->jmp_lock);
 }
 
+#ifndef CONFIG_USER_ONLY
 static inline bool cpu_handle_halt(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
         bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
@@ -666,10 +666,10 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
         cpu->halted = 0;
     }
-#endif /* !CONFIG_USER_ONLY */
 
     return false;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
@@ -1027,9 +1027,11 @@ int cpu_exec(CPUState *cpu)
     /* replay_interrupt may need current_cpu */
     current_cpu = cpu;
 
+#ifndef CONFIG_USER_ONLY
     if (cpu_handle_halt(cpu)) {
         return EXCP_HALTED;
     }
+#endif
 
     RCU_READ_LOCK_GUARD();
     cpu_exec_enter(cpu);
-- 
2.53.0



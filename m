Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69918C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySho-0003pM-VN; Mon, 24 Aug 2026 07:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShn-0003g9-7j
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyShl-0005d3-FH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:19:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99FEX3575214
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=; b=okLhfKOWv3GguvKR
 W0kG5k00RdZSpbukZ9TL5IfHhrHHS4kT8JRK+4WNJfmau06M/CByq+IS8TvdjjJq
 2KLB+X8HX2pDsCMlGszBesmQGijxLOdEY1S1caKllMynjdd95ydH1xc8QweVFBq5
 rRDJDdLv9roYqm5PB3Mjz0dM/xfODw72w543vgiAkpY7DhLhwfSIE1R2QyVfiYr/
 vy+9TuRniS+xB8yg5yYO0dniKAogQbAct+MpGFE2LLQFGUd1+z5jFhw9ale/Qetx
 5pBfDC5Ux9iz/juDt4jWzwp1sYK2OaTJAoLqZEykZWCtQND5uvH4aSMujBSDCvY9
 2YNEAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpjd2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:18:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52dcf1bb6e9so42234291cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570331; x=1788175131; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=;
 b=RLikqBmc/o18yz3zjm3L4bSQ2DdDmJEZZ8IJ1MJAZ+H1Zr6ECcRTqt2tp/X/GlS/UE
 Mg1tUaN0Vp5WqPifTcft9nYddI/uQICaNU/7jOpZXnC0BhTP2v7XenClkvRInYE5x769
 ND064aoIadZaxYJ+F5Z9bn0r4aUsG1o/+i5Fln3+RmYG3ptW9HRapAFtqTrHMJnA70Xc
 qcn7ezEf+bzvsQMKwXd7fRLwF+swI+QFV6+X/Xm9KkbSRY+/bgSMIQv4V2QMv/Y+9x+u
 4/7ObEhUHKfyT3gaVggoZluLK7AVzIBSEkCW3Vmt3IJOu8Lsx0W7cDQ5m7lIGDAq1qQ0
 OmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570331; x=1788175131;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WWjKl8lE0l15HkiBp4oGylMn+2gkaoOjSN4ksHt/pc4=;
 b=MfLjVQQl+k41MnNsFxHQFZRFYWWA0UmzfrdbEsjARu8t1UKDQ5UPoaJB/uEUBGaJY9
 gK58p6vyjEDouaYz2E0K5WL+6FCQcmuE3ItUXN2eMy0q/kMpJANC8aV18bn0Dmdq9foL
 zXWb7zSNbhl6EB42ydt2jduwP0Lpk21nFMl7mJpBxzztr+EZLMoH7yjR/rLwQVu1YzZ5
 lAQP+zzZWC/HtMiC2OiJGSXIGUf5cFgx1j71KExwcY1IoyDxWnUuyAVK0yw52vyCGefv
 eyvQo1hEviOa2LgLLoW/32uoGi53Agar5XT89lcv9Ao3L7Tzv0I/VzwkFr4zXfjYlv2g
 kdow==
X-Gm-Message-State: AFuF++n263cdXViaLemC1HKMsrTxPsncPneRLeP9mtSDfkNKoZltsWJ4
 6WPrLsqQPv9R4lI0YbntMBhriXWVWM2i0DF01pwRvu9xR/fPQQIzPosU7x8hGZc59KLdkzQmjHw
 54CrHcyBFIC5X/rwux/jJEHxf0IHFJyouBd4YABhMs4HWcHUPoaxMvKNfdK7QWkkliA==
X-Gm-Gg: AR+sD11AQdIvAKd8g1RtCm42UPs8wvVc1xjwc9ukrY5+uJKwgeLttqep3yy6HS87qlk
 f1Icg/cGGKknWCEYnBnFQvkotpT0U502pKiUlM9FDWilE51ZqcP4sOj7bAMylNq962ySfV5UA9x
 zc2xGW3FwgRfJi8tutkk0pL261ECFMX+9B0IiCtNfkuWTztph1Mkdgl/VUWoaCdVLJ6zl1ur9bm
 Bsg+HZODjoO/x5/heDNC69LgD4Vsbt4oFZAss7uB9xEAb3CEbimgq4SoO5u++/t1C17yn3s1D1p
 gpkjDh2ZhVsmRQfi01QrLZdtvuWuCln1cVsF5uWtqn7f6C+f6RyVnn8tQX/mBwm7IpsYEDlaoD6
 kJyRnvP4IjsnWFERdeQjZVLBFoyKDuwH1qzgUwKkNSFr7ulHSXg==
X-Received: by 2002:a05:622a:4d89:b0:52d:3483:ed0a with SMTP id
 d75a77b69052e-52de33af2aemr340164711cf.18.1787570331236; 
 Mon, 24 Aug 2026 04:18:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4d89:b0:52d:3483:ed0a with SMTP id
 d75a77b69052e-52de33af2aemr340156531cf.18.1787570324808; 
 Mon, 24 Aug 2026 04:18:44 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a905sm1375485266b.13.2026.08.24.04.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:18:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 09/20] target/i386: Constify CPU*State for
 cpu_*_interrupt() getters
Date: Mon, 24 Aug 2026 13:16:58 +0200
Message-ID: <20260824111711.26297-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX9V1LRL0IKwgv
 kv0kCIIUy2/EfkY+mq52Y6D9UIH8NxqiueFJdOKvoGOVFrTMB8brJH6+8EamtPwctg3i0vn/MQx
 EN44FM1h6xvTPxOW9FLY/QJiuCfDGc9SyDGphwnvDh5KOLbwtTkLAY+QscosmlLlcggnDl9NSPO
 Ti7VNjpUc8rQwwJk1nQgPhktnklOB7zz37q+CnujoFCtl37Y92c5oIx4q4o+inGFDn4St+oYbsf
 TRjgehO4j93cBiXd9jIy55SKspgGaCOLYOY76IXImrEacyiJ9JkIXxtG4ebJm6j8U2YxoBeOYbi
 h54BzYDDsN5XjXJ1lJNV9Be4u5tlsi0I/f7kLRKTSZ1G2vBadv7lMsjmIr2FQixqpyDU8NUguiY
 4R8YCMko5NHEJTmp8ptNhvX/0yEzH5hWMb/SGTJdnM0Jt45D9qgDMfYrtMU07oi5OKhlUA92Dir
 wIKK0d8AnTuZ7BFk41A==
X-Proofpoint-GUID: _eAMrgZ_pk9ysBeHQcm4ZrAlBoGImHA_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX1EW3FBJdjbcs
 JYt0KA5xEACzTt+P0djaOv5dgDLeLijT1THR8Hz1w29p1f7C4IxvjSlfMrMJk7BHaYvL5Gdj1sK
 Uy0u+9CxgyiNg7agSqKYBc9UZ10GwjI=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c289c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: _eAMrgZ_pk9ysBeHQcm4ZrAlBoGImHA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



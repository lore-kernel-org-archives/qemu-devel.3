Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED29CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySN-000273-T0; Wed, 30 Sep 2026 13:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRx-0001xv-Aq
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRu-0001Xe-0Q
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHf4rT3566541
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KUfE/kAPKd/Kw3FhdD4xJiGfxG7IJoFZYr41KEw339A=; b=Z9C+mSTESC9YkRH3
 SpqYT7kZeYUZCZkRpD3t+Hq0DIAU6JSvDNy6k0Wp/JnK6aDiCJTjsVfrRb2ih7oh
 Du6j8CShIqY6jxOhzDYyp6y7K0nsIFfImqhL2zy2GdGJcutBTs1TGCLRe37SHDOS
 p+QErHnGJZwga0i8pLukenDiUHqrzSqwWsnFu8z9fFeSklrcVXiU7gWv93jCvDRJ
 ANvuLEBbIzUGeKJERm0g7xZ/J3lN0bSM5wq3L+Zz4AGzMPo141dN9yHs9Qljh/8j
 FXlpB52dKefwNDVTmBcRfy4BV9JiWzhc3Tl1r3Dyme2TlBCwm+CB1+7+5gN/EVl4
 45R9Mg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjkyub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:32 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7b43c5f2b6fso586740137.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790631; x=1791395431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KUfE/kAPKd/Kw3FhdD4xJiGfxG7IJoFZYr41KEw339A=;
 b=OCbHjtsZayYhpEnVpnsKtJHifwLYF2nNj6gPU+lmeDNtKV/tSt9aRROt13lEVxaLYk
 mxlA6Gms1SfBBNoWonnpO/dLs2j59iB9Cw+pLZAk0tR/85mu6OxaMBUKEPZs5ancMbtW
 PqZ/BNKIjM9UHK75JAJbegMHiFaN4LdhMLr03KDThF8/qzI3KTlC8rzQ39AWPJAQD31u
 DMMvBaZ23y7ZRZkEsFvZc44jAH8A63Xqhq+2iTT2k/l7Brkk8+a3xP3/ysyn2I7b+lv8
 pOYqC9n+8dUEexG+B2ZvOK+nRJPksMMD/acTBPQHc6KGofFd5k3VmzMZwmlJjJHJ6DzO
 HDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790631; x=1791395431;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KUfE/kAPKd/Kw3FhdD4xJiGfxG7IJoFZYr41KEw339A=;
 b=qCYw5BQjlI6M0FM/Nfrphp3Bq9qli5XTfW5ZKc8kqdYbBPITMMW7lkjtKkfUL5yRZP
 CR5SocVeQSuXbQaSr7QdVezmV9Tgc6OhIQvavyKxJL3seCDhwb4KMwlflYRk+CGRkZKp
 Vupte2BFf5NeDpNaew6RxLr0wrP/QjKr2GuR/WfZCsAKM0tW7IlQ9NvrKzb2EP8I2247
 xUzXZ96bqCX4pkRQrzzKYmD1wgXfdekaxzwghrPO/8NRDGrRgGbq1LaIHOjaRFeBOsnH
 h2PRMuAT23RiLvN6KqpQIELTqyu0/+jdgK+zQUnIqUTW7FYS7sQx+jLiemnhpD8A4oaC
 08vw==
X-Gm-Message-State: AFq9FYKRZnVL7HlwOoNqHUZ7BsyEAxTIXbcVEQOQB7c5i8cKLkPaAL/K
 6DrIiiFowLO4CnLKKtB6kTGfbQdkysklAQrG/QZ/n/IKapxrQFsqOIs5QHnjog5Ja10J+I1ptns
 tXOJOtKj1yBfCIlX/x3LShof4/EN2wtU4uwWKm5GIYhzpQZbML4QankKGVgRdx8tE1Q==
X-Gm-Gg: AYBFou2nhr/m1HqUU1Zb0i9d6VlZClhFH4DdrOL1p8gDLbuLvr/r5LVFeBeByjqAiOA
 9dqIVjbLdUbB/5JNa/Xvi7Ums7bh8vtT95VoX/FjHDXhDs3t7afkgBZrk05OWnG/rL6PVrJLL3V
 0Otluknuzg/rZpl4ZyLtn5wsGiiXqALcunjJfzeYjFgS3grWUhMp1G/+3qbVz6jATwLaZlZngCF
 pL7C/LHHx59mIDgVfwxDh5+COZkSDmlr5b5jaA65tZRgexSQOLqY5ZWW/jWA9rDzI+zfzYZVubN
 ezinM6BhJgzuwbU1Tx8lAG8ENPx9rwpbwpOoNI2W1MtwWasZIcDUQApg7+DpXuvy1VhDDT/igJk
 KK8Yhkqg1FwksZGXxIUCPeGyaz2eJr4xESZHAXZ7Y
X-Received: by 2002:a05:6102:3f0f:b0:7a6:b8fe:e834 with SMTP id
 ada2fe7eead31-7be7339c863mr464679137.27.1790790631240; 
 Wed, 30 Sep 2026 10:50:31 -0700 (PDT)
X-Received: by 2002:a05:6102:3f0f:b0:7a6:b8fe:e834 with SMTP id
 ada2fe7eead31-7be7339c863mr464672137.27.1790790630684; 
 Wed, 30 Sep 2026 10:50:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9d1sm627843f8f.5.2026.09.30.10.50.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 6/9] target/i386: Split leaving-halt handling from
 x86_cpu_exec_halt()
Date: Wed, 30 Sep 2026 19:49:42 +0200
Message-ID: <20260930174946.82195-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXxxLRex0XTyVN
 G0k/ey/ZjYYSXVgTFYcgevlXQhDfQ3/A0UeKqBqojI9pOjMTS2cZDTvmlz+KCBNghypWb1sXT6O
 LkiKnqOuKgvei5kyxM9WZC5gEEBTGPg=
X-Proofpoint-GUID: _ljd5lzu2lVfo7PZ1CggdGftCPK6aVCz
X-Proofpoint-ORIG-GUID: _ljd5lzu2lVfo7PZ1CggdGftCPK6aVCz
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd4be8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GiXQl85om2WzCxkx9rAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX838cgo+WgwU0
 JIicLPr0KGAVXuwGQwY1KJYHgAHjIyuNnFXr2n6v1f8sq03Z1Tnd1aqzbGsXBVEiGpmcL3JP3QN
 IjEWCtUogC6gdp+SZ5cVDHAute/7wJNn4ZAc6CSgAUDWyaPiKBGVpLpvONc8u7IgJSVQd7mXh10
 yTIf/H+f4W0eVGJIV1YpJYXdhc1TjPY4caYb3lYSlOM0hnxI5Kx1l/UwZUHkZLtO7qjrQZQMu9h
 t/i7hUTkNvg+9i590R5WBK70p1neblKeqrXJaAOBuY7AnAV1qdDEBDObzs09yF3ySy3i782hJxO
 gam9rEovsppL0yFQDWGafr0RnIr8JIghTMrKKHMWWuyxUMO8nXBSvj5/JzrhWRBncMNpaybkl8d
 5+LD2ZQeoc+axIpsvKsSxyJ47wxhX6Yt6E4ypb0dHhLk5J5GlWom7bHBVN8DhHFUDxzTiFmn6KO
 qUZH8ekfLfk0vCyiAEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
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

Move debug exception handling performed when leaving HLT into
x86_cpu_leaving_halt(). Keep x86_cpu_exec_halt() responsible
for checking whether the CPU can resume.

Document that #DB IRQ delivery through do_interrupt_all() runs
in the vCPU thread and does not require BQL protection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 58e8ca0bc1b..96accb30a80 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
+void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 9ce608a0bb7..566b3d4d80c 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -140,22 +140,31 @@ void x86_cpu_poll_during_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_leaving_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-
-    x86_cpu_poll_during_halt(cpu);
-
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
+    CPUX86State *env = cpu_env(cpu);
 
     /* Complete HLT instruction.  */
     if (env->eflags & TF_MASK) {
         env->dr[6] |= DR6_BS;
+        /*
+         * do_interrupt_all() is the normal TCG exception-delivery path
+         * and runs in the same vCPU thread context, so #DB delivery does
+         * not require BQL protection here.
+         */
         do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    x86_cpu_leaving_halt(cpu);
+
     return true;
 }
 
-- 
2.55.0



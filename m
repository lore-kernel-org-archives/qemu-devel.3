Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9729EC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93hQ-00049r-LD; Tue, 22 Sep 2026 12:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hP-00048H-9h
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hN-0002Sa-3N
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjoA63952905
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6UxGihtlILmLNAlJDNzlMp6lYb9vw/O1Tq4HlIquyw=; b=StDmECc0yJSAVTEB
 glDeQ+sMgMDNV6rHCrZEoSt2rb/o7tS9cCMJELHITszNs3blQ8exRLmzNv+fbzZc
 2wXGuApDmX2ZeWLBqJO0kISt3dpOFOj1Kq1IUIMUhZCDPqCz+khg6Z0LborSSVL8
 oNbnSwiNHUv8DcaN4Tqf+7lKtbnM7f15S78aC/tDPleVRYJLWRUjQ9HjZxxH4o89
 9vVt2FxqnMtvjz3fBorRyKsuideczx/X7oLMXzKiR+y0mpvrErXZPE699DXUtzra
 M7QfA0Zj8ukU6wU6Oyz6WvPtsKKppw4how1sbmuOhS69Dvo57aakJEfAPGASUVfu
 z0Ce0g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqbp5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:18 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78f4d6af128so661137.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095817; x=1790700617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k6UxGihtlILmLNAlJDNzlMp6lYb9vw/O1Tq4HlIquyw=;
 b=cMwNkOcJrgcNDEBQ8oMYZ70BkNxWpx+/YlkrOLkcKcNzL/eFt1+sgToTzbvGUPyC+J
 vtqXKEWmDvp46kIlel6rGq0O7O90+3WGofRZxgwH1oGerUEcIVhHNqsguDVJX1OvQsp4
 8ncuOz+aGm7RAiqNn47gMQVRGXarMIhHRYy1PBUH7BpU45bhIQP4l88+hAPwjOMQWKOn
 KLzbQYI47px7V51hCxHFpnVuvf4K42VE6KNo9tYJOp3Li/TBybjlenIzzXuO9650YZko
 Vs15wOQfcc34JrxQUK1/N3ijAVrVSDctjfp2ZWvKvMgRaMr4CQKBm+n0yTIH/QccTF0u
 DK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095817; x=1790700617;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6UxGihtlILmLNAlJDNzlMp6lYb9vw/O1Tq4HlIquyw=;
 b=IveDDVRS3cJ+nR4XVqQRVcoXbVxBLeMH6ZvmynebtO/ROE6X/VwOOItiXJIP0RXUd4
 TFXNc068xOekQiUYUC7PyHb8kQbXgrjErDtK7xoFph+IzkiSx+EKniUm1Hi0Uhvo8d7e
 VapApBLkL47t56iy7RPe8KqAlWcTxpbhFu+etYuvwJRL2P9bXRgoffvY4IVAs/KPbtOI
 uFNggadwCCerXS2TG4ZwZZ4+Mss+AkJ6YOnjvKURUMRD3foedJ80jw2kfVcnckDqKKhx
 Jz5F7AgtNYb4aFSPqtihdSAhDzgtgOPzszDAnaJuXb6+EUBXK/TNdOgaSSaVnuxgAGJv
 N40A==
X-Gm-Message-State: AFuF++mazk63/OpyEoB0gwHTX6Eha150nVPoBMAyTDAs12aFqlCvyX8a
 KiU4EsOJ0jxgNawtDec7lxeR797nqe0EnlME4Bre3qJWgLkOjmR8nDFerCST7mHITxXkKwf2vVJ
 qJgKAq9aq4ChEnKSEPAHh0ywKgLIhgzGC/4S6n3xpRw9GpbeDkL/sG8LYEo84jJEfVQ==
X-Gm-Gg: AYBFou0KmetDgyd0omBhoFEqWD/Haa9UT/CaDlTRTT0qGZ3+yZWloaDNzVnCAWt7T/8
 FvOuvfLCo7gFvXZ7jhT9njbrP8ZDP1ufvD+jIbhtUZapE1oE7HaZz59Kms7EQCqBKx0vQ3DG8pJ
 4nLm8gXqjFiRgOy0HJg2AYJFxesKMN3m5QJlA0N1Ti/l763KmG3+oDMEwYxsvUL0ZBuOURGNRAl
 koO+T4MlyfU8/OVZjXTEOZQ0n3bwBYF4qMJ4vMIyvCEPjl/1oTo1py8vbh7s6LC/w/Po6qCod1s
 l/9Me0TMPj+tLIfIlh95+zmYk4mevccov2hmUKHd1d/GvjxAw+00iaF+caY/I2ktixX56hLAFg6
 h4DlUXYUVM/WER+nfR6fuAiQ6Fpq4dsjj6Ci2fKNJ
X-Received: by 2002:a05:6102:370c:b0:7a1:f7d2:e80c with SMTP id
 ada2fe7eead31-7a55ca8a2ffmr6835343137.20.1790095817266; 
 Tue, 22 Sep 2026 09:50:17 -0700 (PDT)
X-Received: by 2002:a05:6102:370c:b0:7a1:f7d2:e80c with SMTP id
 ada2fe7eead31-7a55ca8a2ffmr6835317137.20.1790095816785; 
 Tue, 22 Sep 2026 09:50:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1c0f6csm3767665e9.3.2026.09.22.09.50.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 05/17] target/s390x: Access S390CpuState atomically
Date: Tue, 22 Sep 2026 18:49:23 +0200
Message-ID: <20260922164936.15189-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KTzqmst0-K2I5fyJZUyX9hSK7w_wJRJ1
X-Proofpoint-GUID: KTzqmst0-K2I5fyJZUyX9hSK7w_wJRJ1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX6QHDwD7oK+8c
 REE3VZ4X7evJldc0VRn0gSVavAUVPmlRV0Fpg6uftvHj9+Hym8U3R0DIotEOmwlOgl67YJjhOUM
 +05sePobz8RBs+wquZiioN3WCWz69Fs=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2b1ca cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jkZ4ftcXAbePN3d4lLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX4SpasvS7/akg
 QiPCmSsoaOvoRDX7NZKn7C5Ba9KHW4MFhVH09K4T+ZIZaAniG1FAo8y2If8JYBmiOYBoVQoXHcV
 nW0YpH2QEVwTkvInu7krSbevjeCTjFT3mSEmi2ns8/u8TmKk4tnEz00XHviFUtegoaeSdVAhTWg
 fAx6bOL7U9QWY0DcmpL8cDSiy9VJLk92763g95tlEdH3L47TSUlXBAjH0n8nLUsMfKINSyrra/6
 U0hqZmDoHRPFLCmBt1ZWdknpXkwFB3NN3BZr8x3bVqKiNo8ObyEHSpoTm9+QPhhuwhWSEM1+N4N
 wc8ZAwB/NkQA/O/csVQA7q5lw8c6BjdhCFraybhZZlvtWf2Q3yQXXPdSEKDaYunCd9F7L0pqgV6
 roB1OR9pzeUusAkoW8SUnpQPH0xDwnabI5cqKXY9EHuJFYHGv6xGmoiGKMOAZIw1YCA0Kc9wMaY
 BMp2khGS0zsR83kmmoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Use qatomic_read/set() in the S390 CPU state accessors.
This avoids non-atomic reads in s390_cpu_has_work().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h        | 2 +-
 target/s390x/cpu-system.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bf9f6ed1de2..ef73b15218e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -855,7 +855,7 @@ static inline void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
 #endif /* CONFIG_USER_ONLY */
 static inline S390CpuState s390_cpu_get_state(const S390CPU *cpu)
 {
-    return cpu->env.cpu_state;
+    return qatomic_read(&cpu->env.cpu_state);
 }
 
 
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index fffac09f241..d38de4fea2b 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -272,7 +272,7 @@ void s390_cpu_set_state(S390CpuState cpu_state, S390CPU *cpu)
     if (kvm_enabled() && s390_cpu_get_state(cpu) != cpu_state) {
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
-    cpu->env.cpu_state = cpu_state;
+    qatomic_set(&cpu->env.cpu_state, cpu_state);
 }
 
 void s390_cmma_reset(void)
-- 
2.53.0



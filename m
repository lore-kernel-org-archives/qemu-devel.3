Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73433C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93kC-0007AB-Eq; Tue, 22 Sep 2026 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93ht-0004Pe-3v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hq-0002XA-Of
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MG5q3h884502
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wzgwIgPwTbv5GuXC1qq/1cp5HK8wllQnhGsYgJ3NxUk=; b=YNvKOs4wZLxJEQB8
 MxRtMyv51FVS2mRHvXc8yqJN2OzBK28HhlOz6yaxzk/0wWNeSNYqOCUL603U5Myf
 eHCBL4UiROupy2buqxpdSVHBQIL1huygbNBDhc6faNNmo69eHDzLjLzP+NoJcHaG
 cN8W8zSK0NeCeET9EWtMvlBsjVBh9Zy2WaaZB0CgfeWG4gO0EVL+Yv8G4ZWSM2SP
 AmKc56D+CUwXosKWXncclOY9KDZgk0XZKn2EoR/r4JIm8MSNYYyO0sOg2IEOr/mP
 bCntzkTFyY7ew51eS068NHEmtTKoGfYMhp3cW2A91HyVp5x/zcMC9nVGqgAWFUEj
 TJUUqw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guvw7g6su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:47 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-982a39e0c4dso8554241.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095846; x=1790700646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wzgwIgPwTbv5GuXC1qq/1cp5HK8wllQnhGsYgJ3NxUk=;
 b=H4Qqg152/gmQaDAjEyjrjDaKw2iGmnyuatkfeiDyCo8YwqvDs0LNGO9o2//QHJJzUU
 B8pJ/P0Cmjy9P4PdpyrtRjnR6HO1fcy6r4kqin5c9F4MbsAVy51fJQm5vFTdObLbFjGR
 WL/r9JpLG42Rf1Vqpk6eJFRP6OsEKAn/6xlOBneCAeWUtR8FmH2a3XRb/DYDPHXq0Ngu
 iEGkp1Nc25cBtfmIpzYbGvemFkbBmQHfT1bu9IOFZfODUB9WWTImDSSzOh9ZglL+BEnQ
 3mJS8x3VKtamL3fx7+REZWCDUNxq2CrB3kf0jqtxDjpvus980jpYl5dVRV/8KUqZTe5y
 VKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095846; x=1790700646;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wzgwIgPwTbv5GuXC1qq/1cp5HK8wllQnhGsYgJ3NxUk=;
 b=2t3/kYtQ5CiOnSXITg3Fd6mRQ10gdxUfc833Yw0LjKrx6/b42vpIpNI3PpM7F1JxGW
 lp4zG7cOLmHM2FMydMayZDABftZXr6oPBBvaWmj2yEQ8BX9FaPyXoWDkvXLwb2BsJZNM
 w7kRmAcQ1wtbOGs7/K1lqUSuyB5VsnQctj3Uj0GQCpSJyWJO/O8vQJiVtBfmyaedZrpV
 3WBhGprNIpsKPvV+YWymQlLX649V+CRnrE6HcPocUuCct7iVaUpNUBAKDKPYpfeZi2Vb
 aBe5gQaNZoml/93O8rd6iXqW9qJ9Hi1sqWawYkzkt9ca9SJRfHTOdsKpYdsH6deEYsPz
 BZnw==
X-Gm-Message-State: AFuF++mTX/u4knueCgETjL9JkSIpeLVy79sY0ETYt0yTg3PMqY4QoGiW
 QqEGOX1FSxBzcR/JJbdcgNIIz0Gspt1Sem42R/5foonLm2CWik+WzMxxMYh2y4wk0LjTydZN3mF
 CFLuBheNpZH/yYfYPOnDeHUPT4lyGht1uEGg3Jr2ttbGvZyc+ya3yMJPkDmCUKyW+fA==
X-Gm-Gg: AYBFou0I3dyY4nA7iDTCHt4UDOWFviN9eibsyDYOMav+43z7e4ujLOXt0onxhhg7LRM
 uuvpDHD+lQbvpNs+dSJ4Okg/nPgGu/AgPUX1gRI6NbCY4eYPZv7+mgkNpUzH6N3GC3tPf90Atlo
 l9IK3AKCQwPLt1bFtadRJACY8hjZTo+lcitZGvp5s2KLAtsqnHoq7gbIa+yAQ3br1jk89wcs/Va
 tD8EBv3DsuYvABhkM/dVm63Qe/8MsofFZQbJHf6TEPmz49ztjKgJbzLlWf9QbTcs9mkwJXkRb0U
 jD/cv+JNJ7KV38J3KO8nhzvTIgCxADdZIZt2PQsIf3626DBiqyxqo5UHQSa9UoU6+bqObI6n70G
 AQsD2vVkgmbEahDoIwPE7HD+eXLMbqQwftMnR03I2
X-Received: by 2002:a05:6102:41ce:b0:7a5:1d50:ac35 with SMTP id
 ada2fe7eead31-7a56fb37fe7mr6286080137.21.1790095846024; 
 Tue, 22 Sep 2026 09:50:46 -0700 (PDT)
X-Received: by 2002:a05:6102:41ce:b0:7a5:1d50:ac35 with SMTP id
 ada2fe7eead31-7a56fb37fe7mr6286056137.21.1790095845679; 
 Tue, 22 Sep 2026 09:50:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde197466sm3544725e9.7.2026.09.22.09.50.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 09/17] target/arm: Read halt state atomically in
 arm_cpu_has_work()
Date: Tue, 22 Sep 2026 18:49:27 +0200
Message-ID: <20260922164936.15189-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfXzaJXOTNtVM0T
 4p+fSCy92igt2ipY5W81vs4mLIGxYKIrI/u0r1r/FB1iFiS31pWoR82sVzGl9aLYh3OGnKpy1nz
 lUWBR+nIj7q3Gr+Os6uqQ5DcTHvGEjo=
X-Authority-Analysis: v=2.4 cv=ZYqIpcVA c=1 sm=1 tr=0 ts=6ab2b1e7 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fCBUlyQ174aHMSgJZicA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: 8Szn6mnifi9q8YLKb1ccLmwqNQH8v1J7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfXzHov23IB41y5
 xtYHataIpuKrRxofZI0H1R7hnGisDWL5uOgAhYcZOcqhVBtCTmPZJ/lVshqZBYFd1TZy6UkBBRr
 zLIAFRO32iumalbV6zUxOMAN6sNJgp4oUNViKBOX5KgUF7gScQ61IJhXstVD36xr4mR6slbvmEN
 HHfKvq0AfQxBDevBbJ8yWvmnM42QcfJN0klWbjhJ8Q0NEpixh9ToVkjC8bJV+2NcPJIBJHppR4B
 uPF3u3q9hVeqopJIiK2/HUitPyqjUVbtiXtn2wEDdTYiY0s2iTSwFAbLyq6PHUVYAuu6WBgfqVm
 lsGyNaZFJuG4zstwju2or9L42iaFUz/iTqjbgIAr0bgvHrFkbQF9QKAyEZCkDiYNOYDkI/DFfAm
 Tv+jg00oZq8BlfeuvOAd5EPSF/3g0HzYx0nH8lEMZvPG/JGnvy5CITmtfftoSUpgs19iKsgk6M0
 LVh8R+upjMlHhxpeU7Q==
X-Proofpoint-GUID: 8Szn6mnifi9q8YLKb1ccLmwqNQH8v1J7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
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

arm_cpu_has_work() runs without the BQL held. Use atomic reads for
halt_reason and event_register to safely inspect state updated by other
CPU contexts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5cfd3bcfc8e..ccc6630026c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,20 +144,21 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
+    ARMHaltReason halt_reason = qatomic_read(&cpu->env.halt_reason);
 
     /*
      * Only another PSCI call can wake the CPU up in which case the
      * power_state would be set by arm_set_cpu_on_and_reset_async_work()
      */
     if (qatomic_read(&cpu->power_state) == PSCI_OFF) {
-        g_assert(cpu->env.halt_reason == HALT_PSCI);
+        g_assert(halt_reason == HALT_PSCI);
         return false;
     }
 
     /*
      * A wake-up event should only wake us if we are halted on a WFE
      */
-    if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
+    if (halt_reason == HALT_WFE && qatomic_read(&cpu->env.event_register)) {
         return true;
     }
 
-- 
2.53.0



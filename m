Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B459C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegbp-0003ah-3p; Tue, 30 Jun 2026 18:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZo-0005zE-0A
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZg-0004bl-V9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:05:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDmGG2937313
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QX/5VAvSqOqOJOe4gWkMq1KSG0RZMviAyB0aJgsDBWc=; b=MVj39ppmUN37oJmg
 IuEfe+YiV2WJ8XKw7zLKvYeLPZv3moVzB/j+o9Y3lph6PFXV12/gJ550wI58e3+Q
 pU4vYvnE/zzsS/kggs9h83gx8X2u3qfG7p5ZyPvkDRYcYtC0vbhyT7GOGgY5P210
 lY0zQhWMIMxtq2q3ABXCLhoXbjtWkuegLK2cqTH8bwTP+3vmwfW1uA/cEIhQXPrJ
 3fYkZbV4qOV8TLBNZYVHBHd+tU5PiBltEUM21g8RHM4PMi7Gfg2TROTJ1tRTfQEw
 rT8pFI83MXC65Y5qeZRp15aVRSHyhQN0Ksh8mXcDt+TUvcOPmJsF4mc4ZQONMxey
 oqDL8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a45t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92d4b18b373so1006985a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857089; x=1783461889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QX/5VAvSqOqOJOe4gWkMq1KSG0RZMviAyB0aJgsDBWc=;
 b=BOY8B8sUBjNYEFISXbtqOUMSjn2YmZqPDgTuvbFmgpAlm2ouw6dK0cbsmk70nNMxgQ
 ETM2RIFSntlZkxekj9o2jWwpq2+q6UFGaAs8OQsByBxARZuDPFzn1cF4DeBITDXtzR7T
 cYpGH8vfAFRO50ZAwmLyRMnuwUGs+gx70QmYBFI7nWVWed+tcxFRJfMzUQVHQGgq0kAm
 JIAqi3GIrDtC4T6fme91qjw0lsdrREwgpqH6B6/3lCKaa/t//IvWM8wv+xgo27wp7lnU
 Xf0yARBu92nGz2fXeEgiFaKsJwitPaKQrGVkh2O2POL44YS+6cgJD9Ygjum8nn+BayUF
 uzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857089; x=1783461889;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QX/5VAvSqOqOJOe4gWkMq1KSG0RZMviAyB0aJgsDBWc=;
 b=onf4ME9EuJ+ILqvWHZIwn2HBti+07ZmJcMt91e0NteUBjTiWGmCnjp988iqQWOPMmq
 aEX6lCl2upLMuOJo4fepoVzpxHF+sy6j/hjQN8M/U2xFSzRsrtVsLP8LZhdW3vFMU1KM
 gZbE8G5ojlOzAwPkEaLskwEFWwlwRt+pAmv4kNskJ4xaSUPxd+WSwhGZJjUS971bFDBx
 zkNB5T4wdTaiFpF2Xk3a3KM1U6EKmv9qq3IOGupBbqF9NuknycuDJH+V9dUjf05TzAOg
 6UvfBB5lcC/sjrRK+cKBXp15biUOLfKEHcsynzzjvTaLayMw4vgtiCcOZkNT2eX5VOiy
 0imw==
X-Gm-Message-State: AOJu0YzoY3r0vynZp3lgSbkS/KHNBlJT67nshu8Le/izKCdfDUaZpW2A
 2B/R8sXSHIXtgzl3OB1EKGTRs96aRZI4QgcEcMynB8E05xQ7hXpu6ImSp9pzU0EIlIz8jLr+x2v
 K7fzCYwW5QDVpmOYJ1yfUYOmTLxormFZp9mWfEDhRnAFCwsWkrXfHhlpDSbu+NiNbdg==
X-Gm-Gg: AfdE7cnYETLjbMrQPxg5bSGA142x2ZKtin9oSjV9IC8bzmhnR1jdsUDJHJWsIntdPoV
 u7Po5m9DtlAM3f0gVa/zLgivv0mr5Ny6eb0xcKX3Kgd1wzh92Wzj/So5B4rRUMhglYN/jT/eG58
 HuLLpzdbs411WLDQENyGzdRVYR2IruvT7d7bPAwJCfk4EKtCh+eY0RzCZqpdyu7EWWH6UHrBlW7
 Put3JniVRkiBQKoyDYJvZwPPOYLWE4KuAJh//LsHDvz1Lh+9hEChtOspISwvEQ/aF5qHDWpxz4a
 4DxuhA1xoqf2wBk5jCCMA+DPlAQJnck1bB6ncVQed+9qMkbPAn9rU7HsXk1/Ifs2YLqv+2BFVbP
 fXgb7P7dpdO1GqNC1J42NO+c7/XN4BOz1JJ9xdzTyvlET4xj55aNzPuTYmQA+H/f4EipZ
X-Received: by 2002:a05:620a:2b9b:b0:92b:855f:e91b with SMTP id
 af79cd13be357-92e625f6a9fmr851303585a.26.1782857088674; 
 Tue, 30 Jun 2026 15:04:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:92b:855f:e91b with SMTP id
 af79cd13be357-92e625f6a9fmr851298985a.26.1782857088137; 
 Tue, 30 Jun 2026 15:04:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566743895sm11661368f8f.25.2026.06.30.15.04.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 30/33] cpu: Better name cpu_single_step() trace event
Date: Wed,  1 Jul 2026 00:00:57 +0200
Message-ID: <20260630220100.1289-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX8d0eGJuhKd14
 E7TivF2gVkpXBBeZsh7Df9xNgkxB5kWOo+adOojQgB++5sSS9gMDM8ORRXvliVdI4O3NhYi1Q8m
 EvZoUXtvywmUZiakMmJB9gr5XxTBXlKBEwKOitUlzgv5VfAyEK9roc96lXePwxKPb9JPRmjaigm
 BxN210tCKnxBSOhZ6VOEKpikmJsfSUd3RdC/sxKv06xB6KJO1yaHfT7osOxl1EMSTFA8YHDr6VK
 F+T6OAHpkRmt7WlkRLk2dsVevZaw3z0lsn7XK7VL7Ua1679VZR8krK6ms8wCGjwWi3kntD3n4mo
 nKCr0seBFxvdwJ8T/cuZ2ErXOSlvja4jPwES97R4tPkSyLTravt3BkiMrEYQXqv9MvvJqJUI4mu
 U4DDCnEXlnJ7OJYAe5keYPKiK3mqTitOaYfi9wAJOKXZOS/aRR912Tgz+IJnKFoF8/SkCelSyan
 UyXWJ8wdgSfyGhJgo1A==
X-Proofpoint-GUID: EdAmQUrKX2cncX5ogljHpkTyc3P4Azpt
X-Proofpoint-ORIG-GUID: EdAmQUrKX2cncX5ogljHpkTyc3P4Azpt
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443d81 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=fWCg92Okmkq_k9tJrKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX77JScigseZnF
 /nlAg3uDUZJK54EI3Ww5i7nJ6sh8yP+5ALM/SiQIAquysw7UydZYnkHikWUahIYRQQEyNpz2c02
 kC96iEV5slKQAjXHSyoGSP3xEXCViwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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

cpu_single_step() is not related to breakpoints. Rename the
trace event.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 cpu-target.c | 4 ++--
 trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f030e2c642e..019906b32eb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -31,6 +31,8 @@
 void cpu_single_step(CPUState *cpu, int enabled)
 {
     if (cpu->singlestep_enabled != enabled) {
+        trace_cpu_change_singlestep_flags(cpu->cpu_index,
+                                          cpu->singlestep_enabled, enabled);
         cpu->singlestep_enabled = enabled;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -39,8 +41,6 @@ void cpu_single_step(CPUState *cpu, int enabled)
             ops->update_guest_debug(cpu);
         }
 #endif
-
-        trace_breakpoint_singlestep(cpu->cpu_index, enabled);
     }
 }
 
diff --git a/trace-events b/trace-events
index faeba6242fa..ea1d2b11a22 100644
--- a/trace-events
+++ b/trace-events
@@ -28,7 +28,7 @@
 # cpu.c
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
-breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_change_singlestep_flags(int cpu_index, int old_flags, int new_flags) "cpu=%d flags=0x%x -> 0x%x"
 cpu_exec_start(int cpu_index) "cpu=%d"
 cpu_exec_end(int cpu_index) "cpu=%d"
 
-- 
2.53.0



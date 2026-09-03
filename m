Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F6C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24tT-0001mY-91; Thu, 03 Sep 2026 06:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tO-0001Zl-JU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24tL-0006nT-T8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:42:01 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHEMQ327166
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fuM8ZAZQF356rzx0icKWrBqwhMkt0ZBFMTqhAkvZu3k=; b=TwjHLJqQuTn+1LOs
 tFSgnkn2Ba1ONt+suQrsOvvpW5IngvxNNc0DGvXc68/Un8MA9wyuCGl8f9gv6ciZ
 /BKVhi3JrTTPlnCzW2QDw5epNuM7MXPTxavKwqquzalg8JOzyOv0ui1Y3eEKGCQA
 XiMnMwlnBhZUYAnjqmSE1lAiBXi5aPWT3P2VdRcFjYjIVs7Z2J8kiUwuJtC3Vrm+
 GjxlCKecHKFZ+/rh4WTdGWFKtGuUgdNqHOop+8qkixGhe2pSZTNvDdbjjQDItVnJ
 jXJ1r4UWD67UeWD9vtHJFy3a3+uxc9oRRW1a9rZuI5jOZxaSqQTukx2HKAZETxEw
 I8XIzw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgtkg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93975d63ffcso53806285a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432118; x=1789036918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fuM8ZAZQF356rzx0icKWrBqwhMkt0ZBFMTqhAkvZu3k=;
 b=TszqLVV3eeuw/Z1bpZOhbU6CVO/1WPiGnFWmfd6dtx7dR1luEmpK5H9kqYcM08fXqt
 nkMRjIHrZ2vcBAGpYffkuq+JcZ563PIx3ZDrqbxxjES9TLxMFhzNZUAHSxil/+72mzNX
 INe6EP1K1Nde3tGHcbSeYzX+t10cevY3TXIMRwTvon2y7dqXHPxdpFG+BmbqYUSpEHuY
 UnQmwvem+x4CrZAy/ipZHoYx5kPWPDikxFtz8KH0/2BH1eJ34315gKgPVyJjOOdq+/FX
 nbl4tmTjREWVtmW1FpVOMSfAjv/MkFCGTCvVOucQ8YPDVvsqRm4hOXoGsh85X+lv4ndc
 LGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432118; x=1789036918;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fuM8ZAZQF356rzx0icKWrBqwhMkt0ZBFMTqhAkvZu3k=;
 b=r119/w7uMqi/fwS//jpiZwUqVl2wMvdl0Pn0e76NaHyxvLtsrg75UBSIPmsyZJQzqZ
 o458JNCt+cWYso44rQsIaQ7e655pNFUjzYsToGnmjaByJooRxohBjdbMASpNL8KDUAyh
 5Qpx6uqHIbP3AGUcDsUhOl5xK2d7GG58yOepoYYWTOKDdQ6pDtOCl8Nu4CoHZ+JoBveb
 MsjImb1G975MgWg1G9+GvhSjzZX4nUUPQzvs96pXNLqMa7FKqlIrDL2L/JvCHa2ZCCn2
 MqMmiR9laAEW7crbevqscmUoDYCZrYaM6TAQ95W26aSWh8w9SFE38an8i2gHGYaaYMXk
 YhDQ==
X-Gm-Message-State: AFuF++kysZcOYA05AH4by/jRCJ8aAJt13sRM2mtSgbTnhrFu13fYE5+S
 17ESW1M7h1N/3wJgNpxi3AvthYnxDEsXNA8H/ixT5O2gYItgl8DgZ7vX0qwQYzM7h5sLu9GwEgR
 PAS7c9U21Gks19kFw90NUNpbif8eo8tXVgCF/IHEI8Wt7IIQZ3m3ViBP886UZa5CpGw==
X-Gm-Gg: AYBFou2RDSP5LCTbiFVVBgnaRufXHAqJfE9UdG1Pi13bUWPcEjTpU506q9R4FXJrDW8
 jBwmhcMDnF0a8qTtnFZLKt9UrFGn3zB2AvcECtqxTmFZYjVQmqP5Y3er4Q99gLMsXpZ0j9+akag
 xhIFgAO8hFiuXAZDwLrC7mZH0qDvHdVHkOpWaRd1VOja7sN7kSn5oLVwXJgyMeZ2L0oPGqBrxxu
 dbi4iKgT+Kx4tIj/3+6N3ZJRL1P+qt0WyQSUtkGFqQnYsk6ZVzIgtVt+IdBHhnLu5nvNsakEBge
 t3LNryM/zcCvgNJKd+8LxunJQktfODzVeWPyRnMo38Vp564JVvsWw0AyOFn4i7qRMXVk9cINNo3
 mD0exbyHl7dH1s4ZHTlpVJqFkVVTQujCQLlkGuiJi
X-Received: by 2002:a05:620a:2794:b0:939:1464:db90 with SMTP id
 af79cd13be357-9396f21efc3mr493672185a.18.1788432118186; 
 Thu, 03 Sep 2026 03:41:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2794:b0:939:1464:db90 with SMTP id
 af79cd13be357-9396f21efc3mr493668985a.18.1788432117771; 
 Thu, 03 Sep 2026 03:41:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2edfsm12612949f8f.23.2026.09.03.03.41.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/51] accel/tcg: Check %halted field in cpu_handle_halt()
 caller
Date: Thu,  3 Sep 2026 12:39:03 +0200
Message-ID: <20260903103936.62355-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hIrBnX8jSj8DixY8T-rUXaypU2ua_FMB
X-Proofpoint-GUID: hIrBnX8jSj8DixY8T-rUXaypU2ua_FMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX0SnzVIIe6SiK
 d475eNhikNbw/oDJgpcXwoNzc090LHu5ussqyvGV3jOJtfgasnEg7Nsx7sDERBA2XR/avWTJ07a
 xV153lCbBluz6xl4G0wT0PvsjeuJotofjPlCCesACwoDl7eWR/anK74hBZbuEKNE0xkMt1ZBa5d
 K1pm2utzqzc1VbZmWcMymaOduHb94hmvMOcSoYd5oFyxHggqXMQRwy8K9MM/6mhPQ1gdMJ/oNC8
 CV2HvcUGy1p6kgW6Thc727+lHk52VvsP+f8RgrYbZ/FB/DJH/5ZfksQjOJMzKqoYN57M9zBqyqh
 8PD4EvPi4f9Ya4TuvvsBc7ibUfbSpjmYoKQxAD0zwv5JyWy1lMwGEWou44nRuzguKYiCGWpMMdd
 b8su0nqKKwoDNvNUp4aX7rsDYYZsObCVq/Ad7Ri13Qu3OatkiLi+02gCn63YZV3Pm2D4MCC8KkM
 MxhsS1HvPR5ykHMuNPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+/pqNlA1RuRU
 jPoBJsd8JHE4NnFF6DsSpO2jjLlQsb0GN/sdvXtAZogxgsxRph9Ca8VUcT6UVI9BljZtJnagB8J
 N+Hw7IbFfCCzUyRl1Oc9D6cBBxmFfhc=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a994ef6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

In cpu_exec(), check CPUState::halted field early before
calling cpu_handle_halt(). The logic is the same but allow
to simplify the async event processing hooks that will be
added in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260819145649.23439-4-philmd@oss.qualcomm.com>
---
 accel/tcg/cpu-exec.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 69207301d1d..46b723cb734 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -656,17 +656,15 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 #ifndef CONFIG_USER_ONLY
 static inline bool cpu_handle_halt(CPUState *cpu)
 {
-    if (cpu->halted) {
-        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+    bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-        if (!leave_halt) {
-            return true;
-        }
-
-        cpu->halted = 0;
+    if (!leave_halt) {
+        return true;
     }
 
+    cpu->halted = 0; /* allow execution */
+
     return false;
 }
 #endif /* !CONFIG_USER_ONLY */
@@ -1028,8 +1026,11 @@ int cpu_exec(CPUState *cpu)
     current_cpu = cpu;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu_handle_halt(cpu)) {
-        return EXCP_HALTED;
+    if (cpu->halted) {
+        if (cpu_handle_halt(cpu)) {
+            return EXCP_HALTED;
+        }
+        assert(!cpu->halted);
     }
 #endif
 
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FC3C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93js-0006U8-DX; Tue, 22 Sep 2026 12:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hz-0004RN-OA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hy-0002YP-8L
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:51:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjNCL318300
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kDFRggGBgd+2DtAqNLeUqcVcpYvkyK4ydCRh++BAI8w=; b=ZjSxuWWZhzYvfDsX
 Ba/AmxUDn6I7edwNCDrZkY19c4bXh0Iri2c9g5fI8mKgJpfB3Srt5qRZWvlHpxic
 A70GV0xTg1Nz84H27jUdZxhb8EHJzjZ1YXZoDDoJOeJIajzqTFpNtRqbACZWQ/NI
 Yk+QwdjhKIuu0rWDYxW2NQDC8pDx+qngsAHZq4+rZsG6EejOE4k1ew602OFDqG73
 y0eMO3PJrXWj+j6diamEfJpGnosYgsFPbHZd7fbcsC0/pzLWCTZ6OpkaY9W/B3VD
 B07jGsW5BtWQ3w8rgUlBV6SCR1oGlNUAqN176/Ufgh9MobAvU4x6gH2fEpfQFcBu
 RyeWZA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqj7j7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:54 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97e768af628so3476862241.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095854; x=1790700654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kDFRggGBgd+2DtAqNLeUqcVcpYvkyK4ydCRh++BAI8w=;
 b=dmSGtzKQ0l8E3G5erfLQctzNYEGMFuD/sRTegOFnUrYXUnbBxzIxAv2e6s5Ex8NyeX
 fj2F31PV/fo/WuOwrvO2b/M7OGLNcDfb4gCX6II+0GJJ4DX6NPxH8UqgZqTkkmE9GDka
 ZewrWHl4l/c6bvkeD1WEJkH0S+icfbDPkuLTSMcNZnVk1Ew3lwedrIZf7Iv3KYdIYC26
 MLPfhc4MhrIL9JgyUStF+5ZmqGNyw/wmEH/WGgVVUTiEZA2+UOi035h6XNevIH86+fgL
 q7Qi2zn6NocPC0PRMl5waajzwo13rro1RzlBEbecdSG2QVN7gqRB+LSIwRSLCOjefXtY
 +Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095854; x=1790700654;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kDFRggGBgd+2DtAqNLeUqcVcpYvkyK4ydCRh++BAI8w=;
 b=qwmQ8f//nAnRrnt8ZSADaiMrEQZRH6oRakAWYs3jXgqo/xa3kDW+foHN6reFFAgSXu
 UGHK2vvJhOPP7X1L6f1dxDmzIP6Rj3DHCo9dVx48mvzw0MhLtruqXjnF95dRDMUvw35q
 mbBcmT/asdMdHK0NXI3BtpGQBllEcCw6NYRDF5KdfefDntaIdXKMQdQ1fvMsP/QJpUQI
 4ROx4hz6g3Ka9/9BJWDhseFxMbSTTV5YhHLTEBKDNS2X9E55Es1vxbuvA5Otkz1u3bG2
 8Dur6fiCjFOyvs4nVZpduyfQ7uuzp7tFlNhMLsrBYv58uxZX8JO8F0w/Y0Y8VZLN53vy
 eCtw==
X-Gm-Message-State: AFuF++lgKQPB6nJ5fWb1ruxzlJg1TGKu39pa6QU7bpEwSv50RERYAX0w
 7gTq3Dl+/UtjEcecpbF7tzrgTS6RqGV0zvXe0K5EAQKpKGtw+F+GMM9YPOoanDSJHxFWRGYeeUh
 di5N1t9RqRAHbpni5h8r4MvoPduYSpDAcOpFha0o2zCrQkprEfvgJgIOE3tcCP5CVmw==
X-Gm-Gg: AYBFou1li57T42Hok4zM6JBQix0uW9tMlrW4vSCZxjJJ1t/5Lbd17h8MDfjCdzNzBhc
 N4mExL18CbHjLhGBO5aN3aXR70tHUrMTNBoY5MS84SAi2oSObjh0Oe28bxELIdnqObkOmPlfJRx
 Od2rbYig8MIO6/Kw7fT5zhNy0jYi+gTh3mbLJod4vUdO7uEYk0J2OTrzTRGhbyAYqOX42fXYWG1
 zmD7X/eVCGLjIpPJk+U1vYuEX56sj//J/5p10CgazBSqc2Qxvs/oeGV/l1FgUv9zS9eI5Zoadx2
 Q0DJSnk/lEGluvj8iU52usmO64JH44gsUUYKsJRrlQJmLfzO4SEyFmm+BNJyvyfMcnIiuBNp/yi
 OCrfTZyjyBiImyI256wOVBPFO3HoZJfntV/V40+PC
X-Received: by 2002:a05:6102:8552:10b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7a7ad9f8177mr5127613137.1.1790095853341; 
 Tue, 22 Sep 2026 09:50:53 -0700 (PDT)
X-Received: by 2002:a05:6102:8552:10b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7a7ad9f8177mr5127568137.1.1790095852801; 
 Tue, 22 Sep 2026 09:50:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdabe8a2asm68093685e9.4.2026.09.22.09.50.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 10/17] accel/tcg: Refactor poll-while-halted flow in
 cpu_exec()
Date: Tue, 22 Sep 2026 18:49:28 +0200
Message-ID: <20260922164936.15189-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX8u32rO3IM6LL
 tZrwJGxyJUdlOIISvq9vesdniWGoIw01VD33df9ImvpdpHUhakggcv6YJD/7QTM9hzUmIWFJ0Q/
 VnYoeZug0NkdCDi0asBbNM/KESJ7a7JMcUsTZN+ZA7yDjlktzL4Ad4NxzTuWCDjMt7+HwJexaXX
 EbczAHVLpZg+bqvNArc40+G4iT+0jsLL4GI1W4ePgNqPsM8Cu0Vzy10FLwo0AlxJI1T3Ui3s7Uj
 qt/jfRE66muDkrrSR8eXGYrQM50veXN+ea5SQY1coF0+SX5grEKktf1PcND8Mk6em8rRKYRaZIp
 CGQYXwxMoPxtWVcHI7WGOqIvyHp7YG9qI3PnJWrLsz5kGal1riO+d/nusT80vY74QoLRMCLJ7ZS
 gSqJ9EhEpDDJZ+P4suP7ehAGXB4CUWtLHkymGXnBPASSKYfXV6nEDqJaOivTFqhOaRw9NUfpIUr
 GonUHqWmW9itUr/CqYw==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2b1ee cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xF3Xt6V14tk6trZ56bgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: C1iOU-9Rqd_XQgTAvWzNJFLFrFZw096K
X-Proofpoint-GUID: C1iOU-9Rqd_XQgTAvWzNJFLFrFZw096K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfXwQH99Bq9NvEQ
 P5Ihj7vlITdpdjZntDyBd6GqXsmeZ9t7LzTgaRxyzvYFEDRadePqadR4zlcqTxQMrdTfLB6K6nv
 ubjq4BX8UYJ8Yz7OjdNUau0DI22gAuU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

Invert cpu_handle_halt()'s logic to read in cpu_exec()
as "if halted, poll for async events and find work; if
no work, return". Rename as cpu_poll_while_halted().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 46b723cb734..76182803592 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -654,18 +654,18 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 }
 
 #ifndef CONFIG_USER_ONLY
-static inline bool cpu_handle_halt(CPUState *cpu)
+static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
     if (!leave_halt) {
-        return true;
+        return false;
     }
 
     cpu->halted = 0; /* allow execution */
 
-    return false;
+    return true;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -1027,7 +1027,7 @@ int cpu_exec(CPUState *cpu)
 
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
-        if (cpu_handle_halt(cpu)) {
+        if (!cpu_poll_while_halted(cpu)) {
             return EXCP_HALTED;
         }
         assert(!cpu->halted);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B67C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mnL-0005lL-Fc; Wed, 02 Sep 2026 11:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mnF-0005ZE-QH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mnC-0000QF-M8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:22:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CR7bl1549918
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PcKu3i44ri1OZFtnx4XTf2WZmuF2eslyvAy1y2DWDCw=; b=auO83S/jtBNSjXby
 P6vGB4nV8V+kM3i/suLTlNTIYeBRVdvmQefRefisPKUwhvK6RY1OKqRUu9OXlHs9
 pTdNPL8ldigIfVa0DsriYiB9ty3TJ98m4ifW9p2kicq8GqGfx4atXzD5izEqPrxU
 HHjUBsE1FPqdUFeLASIR6+VGSCa4fWVKD39/mImS/2abGu7vV8yFIohip18IZZpx
 DYj7+NjkG34fPFmIRwNBkr5+qFwowmqDNVYmdKwOGJv4YpRy1o90Ig8BW2gXxs5x
 +FTe1JVdRV+9SfJKp1u41AnEiJB4+gwv1uv5trhFLKZgBClSAJjCVj9JSkZlI0Fb
 mhmR3w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c9533-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:22:15 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806e283b0eso478804241.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362534; x=1788967334; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PcKu3i44ri1OZFtnx4XTf2WZmuF2eslyvAy1y2DWDCw=;
 b=CAgOD0MIMmZGEe+bHWrZgHUqi9Go2n8CbmEu9XNwz3WxU3Xo3nN67ac+d1GYuRBktN
 9tWx0UE/wJqYxRmhnK1JZ0xvNAf+Jfkw8MuAoKJ9k6+j84M0eW8vdiKiDc2xqJUagTXO
 +33POnl7lHoQAXiXpZYy+xBIZD5ggEbSzYJEiKVDunnuQg6QgzwbJfPMRBLUlve17tGr
 3JA3rAFIIoyEieVHJz4B9DHBnLIlFT45xbVAXNtUY6zjSc6hFJvK0Rd3sUWQ+2FulJVN
 Vd2pYBH4l/KMaOt5TMffabntWhNS7n0SVzzN2TE2A7kVKClKFkkolygYdOiX89wLjhEI
 5NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362534; x=1788967334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PcKu3i44ri1OZFtnx4XTf2WZmuF2eslyvAy1y2DWDCw=;
 b=kCnd8WZViGg27aFGjhXHekB/f0cmLiv9oBHCxaYs+kI/kYwMLm13ygBMBQsa/X3UMl
 RdOZ5PzcdAlU7vdK7tqXvIAk6devBHovRpCB5G3M/eaueZZHc23RR2bd34nxD3Xg8otG
 5yI7nbTHrzuJEWOuxoExZGnJGrx3Cw+iSL/rFmT/NI6eNIG/7731DFUnAlzXnCTOfMEe
 +KG3bXkmkN8mxDJ7UtGFzOCspcV7gYJib692lhr2+C16UJzSRLlnW/ISHnpVL9ULurRj
 rwJqdayHmrdcCQTd6fDVHa/bz9EQ/qDyxQeEDr7I8Y+VIgQkcusxB4b0Rwsyzr7VSr/m
 EFQw==
X-Gm-Message-State: AFuF++lE28QDuLgY4AX3LrU2OEXym3caM8spdnPbkcbT09BXyj24fMjf
 IWq0qfYe91ChGp5NJ0h8I3wXyvO8/c3vdf10Gro9Chrnj6D3dDMeUekeZE5A+EUoq58eHXUz+Te
 wWO5o2mWH0p/sC89fFYk+aCyeErl3ecNG+OnYDH3nc8bqrd+MTPuRDkoDG15TZV+huA==
X-Gm-Gg: AYBFou3qPIOgxRCL8eu/1WGGO/t5KaM0K6voyLdjacyXCkZXdwPsqdx+JErQUpjyHd+
 kyhCnTf3lgBNdKDjTiNsl8u+tx7o2ehSocbukeZw7QmtWjD4oP5aA6T6ZY4xKG2TmKuL5dlKa2o
 F85vEHQAyKSSVxcbbELwMftFT6BEF7dazVP9s9sM9Vd4kQE2Uqkufsie2tFR3RNBJ+KWcpaii+r
 N/m+tw8cwjHRTn3FuTq+H8ib20XpGnW5TQ6DAfWx62ndoHeL+c1b8Y9C5L6yQ9wtGXNOwh8/fzq
 lwwlZQqKqBSotEoghgwNsnMDFGAxnrJ3qDspuDZrTLvJsNR07sMSWbQeJO1p11cfgwlUlPq4E/E
 YHoJnCRkOxNWRVZiGu+/l69Gk2VAvU6eOlEnYM1j6
X-Received: by 2002:a05:6102:2c03:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-78a1f4c036amr2122341137.13.1788362534149; 
 Wed, 02 Sep 2026 08:22:14 -0700 (PDT)
X-Received: by 2002:a05:6102:2c03:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-78a1f4c036amr2122219137.13.1788362532902; 
 Wed, 02 Sep 2026 08:22:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72d2asm6668125f8f.8.2026.09.02.08.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 11/11] accel/tcg: Remove do_interrupt_locked() callback
Date: Wed,  2 Sep 2026 17:20:42 +0200
Message-ID: <20260902152044.31291-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX1/ky+8Ml7+Q/
 G+EBfn4qvvFm4bqrv1+5QsFElQEfgYIA3jegYXk2x59gZcBzfHChmSuUOaE604nBK92jZrmFa+c
 kun228UIQAA1rUZj15AhWllUDJNFw+c=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a983f27 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=tCPwWEVRRVLTMAjpPnAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: EjSKEjusdH33JAnjbtyXp_NTqHRS65v5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfXypbS2Y7geZsN
 nB9lRWvL0wLzmeb1OpAVkmeWvWzdw1SdIskLSsDNAkeLJLAXPW4Y3mZR20yAeXfrVCVMQdS8LrS
 8g5t2Xc7LfdvLdEvzco5yji8llFyJ6WJOHOTcSFzjsclqIZySenxfhDR5LNiYPliJ+7Wa4FHmUL
 AOlTi6tu9qFcwsuvXbMHxJiTBgud19Zos25/kFBGBgNmeXfDP1p4QPQiqPccolnYpCYGodV1V9T
 Y4+K5SGanRMXQsmeX+KF4605cN6yqTMvmAgYTy1m4gIR3YGIy2ls3thyhJco3GDp4pZ/eDXTqMn
 lLMGq3Ec8slHwlwfaTl9RY3V1BTIee+kzOE9WLhX2sWREkyLg9X7qV9RWkRlJlkGBzgl9/ildaq
 GzBuoWkbVwh/QlmkihA/bBjA29MGfUhm42kOGPrSXVYOSj5aZ5ZQjWRXkWgjum7g5T9Rgh3zswd
 wO4C669l+46bacYcG9w==
X-Proofpoint-ORIG-GUID: EjSKEjusdH33JAnjbtyXp_NTqHRS65v5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020136
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

All targets now manage their own BQL locking via do_interrupt(),
making the do_interrupt_locked() hook unnecessary. Remove it to
simplify the TCGCPUOps interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 12 ------------
 accel/tcg/cpu-exec.c        | 10 ++--------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index e2e67f796f6..89b3a11fd6a 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -183,18 +183,6 @@ struct TCGCPUOps {
      */
     void (*do_interrupt)(CPUState *cpu);
 
-    /**
-     * @do_interrupt_locked: Deliver a pending exception/interrupt to the CPU
-     * @cpu: cpu context
-     *
-     * Called when cs->exception_index contains an exception code to deliver.
-     * Updates CPU architectural state (usually before executing a guest
-     * exception handler).
-     *
-     * Called from cpu_handle_exception() with BQL held.
-     */
-    void (*do_interrupt_locked)(CPUState *cpu);
-
     /**
      * @cpu_exec_interrupt: Callback for processing target-specific interrupts
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4deb7e00571..5d4b26357ff 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -727,13 +727,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (replay_exception()) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-        if (tcg_ops->do_interrupt) {
-            tcg_ops->do_interrupt(cpu);
-        } else {
-            bql_lock();
-            tcg_ops->do_interrupt_locked(cpu);
-            bql_unlock();
-        }
+        tcg_ops->do_interrupt(cpu);
         cpu->exception_index = -1;
 
         if (unlikely(cpu_single_stepping(cpu))) {
@@ -1063,7 +1057,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
-        assert(tcg_ops->do_interrupt || tcg_ops->do_interrupt_locked);
+        assert(tcg_ops->do_interrupt);
         assert(tcg_ops->pointer_wrap);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
-- 
2.53.0



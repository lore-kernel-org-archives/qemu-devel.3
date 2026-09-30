Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8B9CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBySg-00036Z-39; Wed, 30 Sep 2026 13:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBySR-0002KF-7r
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBySP-0001Zt-OF
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:51:06 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHf8qs643862
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WiprO/BfxT5lE7ahfMPOMbhDy541FV9UafP7EhJU+Zk=; b=NPzkHbrBlvsD2t4x
 QnunFZ6I4x86lzRUfJWXRMtCg8UGGsowRQI6TBZ9m4p82OucFRnKBxClScSt/fc9
 HHzv9KrioO0n+eVznHuL7AR/7whGm3ktmnBuxQ15hdxhQWGtqqjLQUD9BaLlKK1Q
 FKo9hdkappgx4ZnG0PhaKFKrE5Dy8/oYIDjaGLNG6OwTomotUX/gtobujs2HtZ8h
 Ce8GDJS59kckto3Krzt81Ua1yJYBkBp+0p4lKCEwPvIrWRC7E82cn36rPwNUpGqL
 Nj6DoIwGJpolssURAqo7rrZ+NLedMhiUsdqF1ZCr2+gVztf6nw3M5qZG7eFDrGUH
 xU0QFA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n20uyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:54 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf5c02f7a3so78164137.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790654; x=1791395454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WiprO/BfxT5lE7ahfMPOMbhDy541FV9UafP7EhJU+Zk=;
 b=DvyklPkaAy9UO6v+F8wiNYrwGF0LcsoAVeGq5mBpqe7XoXUIvxjO/UZ2hTwksAnB6q
 27E8YUxkOtQW145G8c3mL7ILx6J5Bwg8/Gqd96y/4OXaM7akOFtNK1FKn2PLgbeTiEsl
 +BMGDE39XPUqviv1tk2BZWhtAfXjY1c7QbXoIW2QZcGlWmMeXhfpvO1+W1LObZH/4XW6
 wKIJHowNozoOBZ9/DCibLvQa1iyvcZHuRHyppsegi1zW1mt+T8EK/EWVcf5IZqYFwGlf
 rYFzFXTDGzyggNW2up9TKxkNpfJwFc/eHDnJwmSy0DeGOe3icd0ZFmdXLVbfVfu6Yss5
 35HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790654; x=1791395454;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WiprO/BfxT5lE7ahfMPOMbhDy541FV9UafP7EhJU+Zk=;
 b=zu0zuKszjyGrxPMYbUwQReIqrNzAPAtBoxlCNwo0dYJXNyPr4OneZMKqNYHxFstvAY
 Wt5MgYbe32CTwReWAAQPZH72u+B4jXUBsrR4WUIwumRaeSnU4W2KVH2Hu4WMXDeZSi/G
 mVAS9Z7IM94sSs+VPxtKoZXSStuGd/6smxEA9yjzxk3o2dra2WOF0YtqQ0PdFqwCH2a1
 kjQQMoV0KbhTlvdf87PIg+W4ALRd8F/hRDo8hToc9PrsJoy5qyIT3J7jasAlBY6iuMgr
 CpRPBL7WmpenLkP5LQ1y+sF7Fz6wrtSh6WKDxB+KAgxhqcr6RTgG5jBTYj+/MYoxkxt0
 cFpA==
X-Gm-Message-State: AFq9FYJJkxTGOQPWZ0ehgKiskPCOStcaLAeGRYQvJkkF2pTM3/7tDcin
 6wE743lJbyZ1cLLQNyib6FVQwgM3lot4Jovt4IueESt238E1iDbkdTDOAHYw0Z3VcP0QxPsnGxY
 GE0/gmNhfql8aTrdhz9GUEI6aotJ/FWjhJyVlpvt7GWsyVlapLy5gobfWJprcsRPjdA==
X-Gm-Gg: AYBFou1+HraDG+5rhe8KTPO0d6o5WagvTaYcnPiCDbJc91B2l/Xe4/MWYMm2CKftRBt
 1X4A2+bZZrWKFaoGAbnSPIxkKvRUz9xPWgvzwzXIb7ODfK5f7I4J/dFyVMShEobVA99Fzh+AIPJ
 fjY5CfzHVVLowdy/rhpzy0Z6S2TqetQnyebkVbX9U6NYNLXW0tqF01SkHJcZ4m3VOdi9CEdzbKM
 qDnLXhacr3NPIo1hQXlIbEN9jxKPlwdqabtOpVJs8uz1D+zNtQj6CK1XtDWh01exUPTSi1nZFL+
 Wkk5q8d5DnbfueKh9da46noKQySlQZgv2a+fCV4CHYilL+UjSOJlkxpJNyc/Yzwzlkq6G4T3aO/
 Re7iVSWgRk1A4ofN1gDTqN6bfNg0gWYNzkmaWssbo
X-Received: by 2002:a05:6102:54a7:b0:7b7:3acf:bd48 with SMTP id
 ada2fe7eead31-7be61e9038dmr591725137.2.1790790653796; 
 Wed, 30 Sep 2026 10:50:53 -0700 (PDT)
X-Received: by 2002:a05:6102:54a7:b0:7b7:3acf:bd48 with SMTP id
 ada2fe7eead31-7be61e9038dmr591708137.2.1790790653181; 
 Wed, 30 Sep 2026 10:50:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb717acsm8138085e9.8.2026.09.30.10.50.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 9/9] target/arm: Kick vCPU after updating PSCI power state
Date: Wed, 30 Sep 2026 19:49:45 +0200
Message-ID: <20260930174946.82195-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abd4bfe cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Gywfzpfelcof4kT6qmkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX22SVWL2W4Uic
 /vj38heswsddS3SqnXweW2uSGBXKnX7EgGFBMtZW2hc0Z9xr2+fwPyFzuUUL6Fq/wUo0/JuwlCf
 v3LHbvw3yP4mWLR1ul+8nua/9a/Xumk=
X-Proofpoint-GUID: bEq2Y7wEIEwbgFuBDbYFkvI4-NYRUucH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX09HjcuqWFbuz
 pJkbXlUHznoYc4yuUduF1scYCHvidl+8DwgWkip9y/mKpDx0/2hD9GBH1TVSXXBrStA8/VgcqzI
 UBnENZ4rSbMpCy8FZbIBeVyAMgBcEJjYGQeK+cysJPFZ8UBQfUgv6SLSW3KiQecTUlDIFRTCEkb
 C6xS6shX8F8sZkTUbcJVD+OS/cRBRAMGkjV2vNM3RetukBkrl70NHHUhH6FfLiYMzAyZMJ/MZTW
 oJTNOE83XLb43LOdxSkCREoKkCmGxBes/g9UX4Uvg3/rH//sQAIUpKu0GZdMYptDTSfTmp8gL8X
 0EInMNVvxEuYJvHXrMj28QU4/ZyPjfvzTD1bGgau7RHg++FuGLE2OeG306VXtboou+Bn03qqWdG
 e8F0h/PuqyXcUx7Qt0ALwgnCosIMuHs3edw6HmKIzYaksIQ2BShTzaEIkwHBA9eELCTIbqtbsYp
 it0qkujaKazI7kfL29Q==
X-Proofpoint-ORIG-GUID: bEq2Y7wEIEwbgFuBDbYFkvI4-NYRUucH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
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

PSCI can update the power state of a vCPU other than the caller.
arm_cpu_has_work() reads env->halt_reason to decide whether that
vCPU has work to do, and is called from the vCPU thread without the
BQL held. A remote power_state/halt_reason update is therefore not
observed until the target vCPU is rescheduled, so the vCPU stays
halted and a PSCI CPU_ON of a secondary vCPU can hang.

Kick the vCPU after changing its state so it re-evaluates promptly.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index ef14a1f8a94..1ba5277b023 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -48,9 +48,14 @@ struct CpuOnInfo {
 void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
 {
     CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
 
     qatomic_set(&cpu->power_state, state);
     qatomic_set(&env->halt_reason, state == PSCI_OFF ? HALT_PSCI : NOT_HALTED);
+
+    if (!qemu_cpu_is_self(cs)) {
+        qemu_cpu_kick(cs);
+    }
 }
 
 static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
-- 
2.55.0



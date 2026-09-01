Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C7EC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LBI-0007nI-Se; Tue, 01 Sep 2026 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBH-0007iW-E0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBF-0007Zt-U1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68178rQI2974280
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=; b=ZN1vXOUB5gCpDKWg
 J0jDVsp07IObPNt9nLOELdO2jzw78xjQftH1pnFcBPW8pGZto9pVGuCMIPZtUV1j
 X1a1g8nIAfi5RES+vxZEiKH6g322giVTOGRtrrbBeCimVan5H99XQQGgiJQX7i4H
 YlL+8u7GPIrKiK2RIhgBgpXqJr2N4UID/Jb6JTGktF4WcMPEw2EjAlhNFVZbuLsX
 8QLwUf/SRNuwKnOsg9irUOAZSRmEPpInNaXK6KChFdk8p5TBwpPYXXm/Z3x62QkZ
 W87/sSb9fBwP+sKxedxiAGQ+12qfNkAf0eEmHs3cXn4ODxjXEPylIaztItmA7Iu+
 6DFREA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu0u40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93915f50a5cso178511885a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256403; x=1788861203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=j4FntiyZU34lBXoIdH2iMejDJkVrsFfoJqzHDtFGSlbDikFgU9m+g9w3bkc6aRrf4/
 YIxZAUWjK4LgOh06D6OGSabD9v8qJJJGUOIVoomJ4K6vSAfNKWMB62xed6YKOdR2wofV
 7VuuslmxHDyRkDjpoWRNrCK0Ap6cNzEjtyVlXTfu1Fb3o5Jl2Kbv4Bsqti918x+hyceY
 NKYKKmTAF8d02qKbEGPoX0xYZN4H1qEDx3fJDSE5SxDgqvRG4z3puIsvzr7GE34X0MOI
 1s9dBfqbg7fzG4Obb9fBvuOI9S521iQhgFJh7+op0UaZW97oZ4h4+9A+5MBE/rP3KFYX
 ACPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256403; x=1788861203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mEq07J79FZAVrGE5OPh7byVYhPMuxRT7e37T72un2JY=;
 b=IL3yj+kxWNHhDuZIYlX4estEz0610/JumCvv/FudHK4K5DM6fTdeztMxQ5aLiRQ0Kp
 7vhvHkrVeBkG1TIegrLIZrbaoDc+HNpg/YrPrlc7CBTozr76HLS8SGYSunKuNOta2y2T
 JYaTScE7h+rbelTeVBgAF7ie5nT0VsQv40ivgCsWHsRJXYNsDbfjAlUBmQPmXZgA0g2Y
 JeNzp3zAwOYAXAIiiXKPnKunmEFZK4TJ7dbu94ar48RXeGLcuB+c3T0FtIE/hUa4RNNp
 FRKy9/Wj1QuW8eyRAMALsSMpHgi9L7h8k5XmP66TnyKB4Y+38YEU6rPxm96M0QuNUPB1
 m8uA==
X-Gm-Message-State: AFuF++lBqL0tMoaLa8O/MXePOiNjG7Wb2BnsmcKGumvq7Bg2LCRN2RPR
 /poShFnkfsjHRGGDInVFibZH8gGbu8H5XAyAx2N/ZzHASGBEatz+VEr56plbGUNT5ZKgiHe6rSn
 pcmiUah26+Oy5qI1w5HWt2oxBbxychx+kYBCdJjHN1VJvD4suJkr/HNfV1EJyIYQWCA==
X-Gm-Gg: AR+sD12fUlNKg9ww9SsLDnSzufxU2lHuQWSALLTwFgQHvzgjzw4FDz7hN+cnyttetS6
 i/icpKFBGmvDASikSw3Ku9qHsRc3A32Wgg5NxfYfAd6636B86ddkTxqc2tx7jKXiiZE3VDYF7ky
 2/Rzd9JApVEEWDliYdjUcaF61RPABgpgVGXMBQOe2s9gUfQYKAqYR9hLDh/qZjUtECBgvxRQ2Jv
 2NMNQnaqD1L9eu7LunagYfli5E8hEXNmi0vxeNuvc4NEYAWPbn3F57IMBLh8mi4kw9EeB70G7s5
 SyxeGBUjN39Qtx7qcUaKtdAkJyTpHQJ8uhIBtHAbux43KmSZrX7NIvLMMDJI1AOqMGpnDnoftmJ
 l5mz23mwC8wbjdjH5JTgfhIkawD/hmgWmAM7tuPbD
X-Received: by 2002:ae9:e50b:0:b0:939:cb6:997c with SMTP id
 af79cd13be357-9394bcac7c0mr421044885a.13.1788256403559; 
 Tue, 01 Sep 2026 02:53:23 -0700 (PDT)
X-Received: by 2002:ae9:e50b:0:b0:939:cb6:997c with SMTP id
 af79cd13be357-9394bcac7c0mr421038485a.13.1788256402551; 
 Tue, 01 Sep 2026 02:53:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442c42593sm4033726f8f.2.2026.09.01.02.53.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:53:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v5 07/21] target/avr: Constify CPUAVRState for some cpu_*()
 getters
Date: Tue,  1 Sep 2026 11:52:13 +0200
Message-ID: <20260901095229.72018-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX5rt3AJCsHEzx
 JZYwWYDWjGgUlAul5P7RCGtxSgVh1fEaERSFT3K1eN+2moKsKrtC2UNGBDKitYbgT3XsDgJgQLM
 sdZCYLUHzuop3j6eR95qAzzhIz96IDtyGSUj9llj0VkOAMOLQNSPmrUJiy6GyMwYcICfX5CthAh
 XwX7O2voHyqtwGuj7En0PC3Lm/PnyvdHz/xOWMkMtpa8KDyI3nwLl80McWZ7kr6k70a9knNIyFh
 lsf1yKk5Ty0plAeeeDtOUh2q/mATesgbD/0eFbhKWupTZy1xNCjzEKaQZHpmtIDA8mBi5esUkDk
 15jKiRZFqmGvIZAx06H0kWNVGi6eGmIm99r17sJiMQA/DpMeZ+XPvdHq46peDwDSR8gWRBMgtYd
 rKCvWLUOjHkUTKTLT9bdu865AN5j8vYAtJ543pb4s0V+zgxHnBgl5B+L69ClVDfZjflv1/xfpRz
 uqgT4T9G/MFhltX7kGQ==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a96a094 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=064F3_fa85QpgnnSfTgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX4X4pWybcd9w0
 GXWE/sO8M+Uh/xBWt7vXRuXHX3im9ebXCLtG3DG7Hl8QGopd6XneW1ARaQHfVFA3KHEo8ENBW/u
 uyGAGFPGxzMIkF2GCnvrumOFsnxKUkk=
X-Proofpoint-ORIG-GUID: MuEN66p8nPzdaayfxP0Tpg4VVcxJIoS8
X-Proofpoint-GUID: MuEN66p8nPzdaayfxP0Tpg4VVcxJIoS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

Add the const qualifier to CPUAVRState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/avr/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a818db753b2..1e4e839bd83 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -183,7 +183,7 @@ int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_print_insn(bfd_vma addr, disassemble_info *info);
 vaddr avr_cpu_gdb_adjust_breakpoint(CPUState *cpu, vaddr addr);
 
-static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+static inline int avr_feature(const CPUAVRState *env, AVRFeature feature)
 {
     return (env->features & (1U << feature)) != 0;
 }
@@ -204,12 +204,12 @@ enum {
     TB_FLAGS_SKIP = 2,
 };
 
-static inline int cpu_interrupts_enabled(CPUAVRState *env)
+static inline int cpu_interrupts_enabled(const CPUAVRState *env)
 {
     return env->sregI != 0;
 }
 
-static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+static inline uint8_t cpu_get_sreg(const CPUAVRState *env)
 {
     return (env->sregC) << 0
          | (env->sregZ) << 1
-- 
2.53.0



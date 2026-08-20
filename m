Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C9C5DF8E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9Ah-0006cw-9T; Thu, 20 Aug 2026 16:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9Ac-0006IH-5J
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9AZ-0002d8-5n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:15:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7mS6250419
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=; b=TEYDVI7f33wtkr13
 tqpyv6vR7GvTspu96LWcmHILMOXsMBsmNybvHUQYfwNTKNgMX5IDrcCLCIYWc/qj
 DKgqURiqgLKAEQjsUUJhIUKC34UEyik109nYIsRISvXV16HZLyU2joo6GeMJaXJK
 hJ382WDZHoR/oDIlS3INJg3tuStBGXJ9LOfNJC1tXDiyjE/TbajcHEIWkj2+3DFc
 Fh6+hNKFm05ydl8BFIsK5GY22dcnCnS2LNmmeTVkXlkzNhN9pNA3tPISX3tNNa2p
 4CBAjhuCryh5deKB/3v+wR5RX0ConRefIAj3289Mm6CffDJbAnjBi9PhSRkefLZC
 AGVBGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bem6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:15:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso2295941cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256911; x=1787861711; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=aUlr6jzEoJW+qeLNryC6U6n/A56FAlysR+ZloNwIPYDuZlVGUygVRcdKL51itJGAyy
 MaaSoA+gfDDJh/WcS59FNqYuuvkxJOT+A+HVXvwsMvbwybyw6qrMfYtc0RufaCNCBH/z
 xMP09fY34BdOLjD5GLh1ogRZN3FCJh4BhiqgweeTY3xaa5R9Fft8WaihNLrKtA/MQ6xh
 gfdG1hG/gI7DxetdJZa4dBatOLaJIJnB53U7pmzb33dBKk1TKbBw3C0bfxtx8Y+R88J4
 CvFGhS6Q5l9KB66sKg9j5xmopJaxIWeI8YslkCth6yHMftjUq3LY9bXoxIbT4zmsXZOL
 vaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256911; x=1787861711;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2rUL5dnRfopAxRp6y8OcNqck/aSQMf0xVr1iUn+iFc=;
 b=GUygFL3LQA+KNO0nBDS6QeXpmJK4ty+jlkOS/Yxu4TI0ItmBmQ9WFP0rITmwAgI4En
 JmBYeyTpJiratyX3eROeL7TE9p3IKgg3nQCItvO0SRajvqWdRNFqzaxhzS4pJH9Yy8I+
 SGVZRz0tMA5WR38/YYc59LEYxj2tcdVHollJFcLoEQLjLwWRYjACGvzfV/VGiqEiN8j7
 AzYDmqAZWM0szKS/8x/T6dwadyOdqidICUR4jOn/8T7wuytKCel0wav+gxIq2FNBrJ3i
 zF/A71iN3ryOKHgm2KWkWWAy4acxDy7Yl0CH7CxY5cI7KIQ6LCaz4x5eMPMJ0QyDs82i
 IQog==
X-Gm-Message-State: AOJu0Ywro13UDdhFR436Y0BOnVeY2GCxrArV4rz3jgy/ECtGoE0H2qzo
 XdXWq0Rv27wLo8pTasrKFI2opfIcDRNTrlQk5A9gf1akQpZ75nz2mSMQHUQPLAQCyplxAdz8f6A
 onrpI3H6RHXDw9eizrfadrkj0U7kgvc3KDF2dTqBPuJMYuNDpAZ7O2hPAbPEosZ11WH5i
X-Gm-Gg: AR+sD13XTMuHeiOYgZAkoqzEJM37PK+BAe0AZzmHyo90zO3xFbalNGT69NpMY87KxIN
 Pld3tQh6ekfcY+KmliFHHlSlsb0tcvxZtbQ7hsgkQFKVi10lQNKd8FiDMj2DpVQsHH3dleaiFtC
 1sv03Vf7kzM5CWd5EsPzMBFiQhrBt1l6CQ9M811L5CltVU7YiquhLPUM4ujFlsfHNJslvv+ZQfq
 nvdoNf6xWFyMI/Jx9qUixmzF/WOZSVj3TC3tLKE7x/ZGefkxBTzpuS6iCks/HAGtQCgfdIxuOai
 4cDcXin6lQR+Lmi+bpxMv69Xy9EpP/5+rO5uRxZHmd1IdiaqiTdN55OCUd8pQ5M7mf9jN4+Y94q
 iYzfH0vybwHnnDMr9phGfGn5miw1bI3V7lnjmAqsWFA==
X-Received: by 2002:a05:622a:8a:b0:528:17d9:2d99 with SMTP id
 d75a77b69052e-52df5a748c7mr9238061cf.43.1787256910778; 
 Thu, 20 Aug 2026 13:15:10 -0700 (PDT)
X-Received: by 2002:a05:622a:8a:b0:528:17d9:2d99 with SMTP id
 d75a77b69052e-52df5a748c7mr9237201cf.43.1787256910274; 
 Thu, 20 Aug 2026 13:15:10 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm15613895f8f.0.2026.08.20.13.15.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:15:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v2 09/15] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
Date: Thu, 20 Aug 2026 22:13:49 +0200
Message-ID: <20260820201356.29775-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX1byi1tlrxTnI
 wVAIQ8K/6J4SXp/zPJawHgy+7/vfYCT8VkepfWps6WXfIN80RvLF/QVYRoOu7E6b6O46AIYC1Xx
 4ISu5sjxVnHmwWzKFDrOqSFBYFSQy3w=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a87604f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: RxmqAVQgd81AwAnDz91od_tkWb4zCWIG
X-Proofpoint-GUID: RxmqAVQgd81AwAnDz91od_tkWb4zCWIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX9yptbuOE6pvL
 qfbBSKjL7Ae/VaT1pynVrUqfETa13p+U4pKtEnYmSnYkEkTdGdrZO6KqJkD3NFa8YLjMeSejahz
 OS4NwQzB9UejHlJJJnNt/k8uBWKbYn6y5/BX+gGVMBPMJWVgN9MZTthXwiS6ngt89OU2nBPj9n+
 YngfP0I5MerMFygsx4iEHQ0OCyO/FlMprCqHi/ellNJfzySe1mnTDPVdLfXtDJw1dFt4b3LGxOb
 dlyPiNZiBQad0+ub8ON3yww0FKtfHQnoODv5ZIyd4nP2kqLYD1RhU+jUt4QvwJt8J2IA6DNt6CO
 XGeq2R0RxybC62eMr14C3lyS4cA9zz+kMaxS8xLzTRb2N7J2ldmGtuNdMf4TSyxhI4IRNgTz4e4
 TrMSIOEEaVqP+51qzfCx37xxW/NLwZziWQZg7uZM2RmpmDx5qo3FbLQsi73rvkmNIHvt4+E84yJ
 DTXbE1+YoDUU6K7I60A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

@iprio[] is an array only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 376cff656fa..bb4c8563554 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -642,7 +642,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio);
+                             uint64_t pending, const uint8_t *iprio);
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7bf098319f8..858fbf865fd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -866,7 +866,7 @@ uint8_t riscv_cpu_default_priority(int irq)
 
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio)
+                             uint64_t pending, const uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4483C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySjK-0001Il-Pu; Mon, 24 Aug 2026 07:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySjJ-0001DA-52
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wySjH-0006bz-5n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:20:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99FEm3575214
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 moIOwYFYai3NnlfAbgOQRMXGHJfvZC6nBcjOaLv/HnI=; b=TK23fj6RucgPUomh
 aP47k2O8UpGSTi1C7wN527nbpiL7ynsXTObam2ydXuxZvekTjJpDx8G6H0GTIS2M
 FoEN6+zvVxkB7m115HrKspk5uyWFDpgxz9eJy5P3Ejy9XDgffwAvivuSeU9yrsKR
 SW1pNUkx61gGZjOWPJqoASFmjw69w2QNXYzFSFp36PUF2/C965ElQnAuwbJBhn8F
 3bdkVSMem+ET7nXNSCTUtNRrINSl3hw1V9vPKRuKzJAA3Pti/1Ft3Vxsi470AQP9
 X64u1lwTrSkh4/gb0UEXc/MQsC2HQbPfWDR6/Pvv5kZuzu1E8FQPT+uPTeCgro6s
 QthdoQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpjd84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 11:20:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso47831561cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787570427; x=1788175227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=moIOwYFYai3NnlfAbgOQRMXGHJfvZC6nBcjOaLv/HnI=;
 b=Bs8tkFmviHp3l5RHl84J+3bDA8hvp6lg+U5+ckFqV+aYM1cT/GaIOlwhfA37D3nMJV
 8rr8nGEFCDaWIaAU3sysVTMlWPHFvzHCbilUYhyIAhp3g2TanUl7pzohPAhCue3FVhKv
 j17eFisxQkuATUdmsUpdSFZcDgNi9uhIwgI3HYTOLChv/5SnGmukFGJwD6aQB5xktZrm
 2T/uRmD4i6wBHeUTXL4fKun8kS8uDpxoeJAQcq6kSMLJHZxqEFSzoY/Ty/+2Ah9l+2ja
 WG8v4lwyJEbLB93gcEvmn/+KNPa3okuKuUlsQhZeEt5Kr6n3NEYT0BKzhrV7YsLQ2jh0
 dAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570427; x=1788175227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=moIOwYFYai3NnlfAbgOQRMXGHJfvZC6nBcjOaLv/HnI=;
 b=hd0HBaZIhYfFbhFvfeSa3aVmUc3vQFP0Cl6A00yQ8O5RdlenOLumWAis9SHbSyLi/b
 Ul7dNfsUGzHp8eOw6aeUV2c2YbB53kBl10UVFHqPsg78pnr6QdQOlmqmPnd/VlcCz7i2
 6qc8QdpZR/z1me+8jaLLnqkpBmL3Q5u76kc8rA12Dlqdf/ir6rQXdIHQ4mPAzP0DzOkA
 /AbC3QF60qS7HwNMF1tZt9QGsXYu+1FCYr4ToG4F91e1jpQaUOYUSSfz3zemEEWFDdXP
 faUlN6pwsVmc283mW/dWB1yhibj38oCwq32QCqhrp8ajAhcUjIyY98W0Mw79ErWipTvA
 kjhA==
X-Gm-Message-State: AFuF++mtPAt+Q0CXw22vNc3+A1xldIGxIOGcB9NS9QKG1uh6J+5TFnjT
 373yjChx+lKdhPGR5VRhkP5Dq9+MDm1ehXnj6HEE7GfVWvEThc/nU1rBQMXxIbmrm99Qtg22kNr
 I0jdrvyl8iYebxxADj37GC6zf5SffSwZv513KyjQShHM3fy+RS6pfRPyDGjxkhE9tbw==
X-Gm-Gg: AR+sD11Oqt2U2oUpRnHtCQHzc7krlReqnccsRxZJywF7gz6fA2y8/O6vYVzXg7O2DMZ
 hnxM+Ya2waDG8Sf5N2AXZNSx7QJ/7GUWpE38CCjbaCgQ+Uzh8iRduuGH+34LsV5mAleYDyX/28Z
 3rxL1+r2MZXU+ckeUdr0P00geCiOSkUztD0M/X+iFJgjg3U/8DONLaLaABD9OaPRpnGD0iZMQNe
 9qwqgS5+EmUVp4Go5MoFJFuh8pMqYjwtIvMS8i1p2QcCloP2LdYP6ekPyec6mGCTpCIVCocWxSy
 B3enGYrRGgkwxZxP7elTiCWQ2u0C79hEltvMRR8eMcV7AV6XMidtt8QJU7jfbn6xuseJAMZy7pM
 RSL+FuMqnYql/D7bf0gKVqvolxmhZ1O8OTZo73ZNWgculRQcAlg==
X-Received: by 2002:a05:622a:4c0a:b0:52d:f4fb:8baa with SMTP id
 d75a77b69052e-52df5a57d2amr244522341cf.35.1787570426453; 
 Mon, 24 Aug 2026 04:20:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:52d:f4fb:8baa with SMTP id
 d75a77b69052e-52df5a57d2amr244521861cf.35.1787570425991; 
 Mon, 24 Aug 2026 04:20:25 -0700 (PDT)
Received: from localhost.localdomain (44.170.88.92.rev.sfr.net. [92.88.170.44])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b5aasm1217813166b.4.2026.08.24.04.20.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Aug 2026 04:20:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 18/20] target/xtensa: Constify CPUXtensaState in
 xtensa_replicate_windowstart()
Date: Mon, 24 Aug 2026 13:17:07 +0200
Message-ID: <20260824111711.26297-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824111711.26297-1-philmd@oss.qualcomm.com>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX/Ym6OFu8s6WN
 62/3UDzsK5V3I/LgCplaO5wgK5Hm+H+SPFh4hSxWRTR2gBvDsq0ZCa9ShxGWTKNKtMEynO2Ka0Q
 2DJEgSu4pVigttd3UH2NGRTr+vQWVmaBXVMocYYTBTDX6thY+Fa0+EqKSDgUqm1mIHr8CJOTKMd
 8F3WZ3wPEQDFvjywrtmJifP0qDva1kHx3S7tDM5lh6mB4ajarj1bkEKXwhuJD2VV1Aevaz+ULvo
 f6eq0vdqHR25NVCP9WXnKTLyBLkWa7Nm/YegLfTP7k6Di5LBZ8/jGsACie+09fsTA0jujG8vgic
 LbpaSJO7CLRdf4ArFhGvx66wMpevQAEb19l7r1r/ayWZhL97jaLEzfb++vERwsfGm2X1aZ3gQgJ
 TW6EUxrbLV4eeu8hM1UJAB92LF+zN2o6eCr/X6R43buFuiy2XqFDrGowQdh94T34dXjsE0b6Hib
 tvk63b8YhkpWl1HItBw==
X-Proofpoint-GUID: mTfneT3-S_w0RQc4uLJlvExKJhfD7a26
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NCBTYWx0ZWRfX67eUzoh5cD46
 NOra4cX7EVimpYDs2tpOqWjE3PEmyEBj6aDkMksGGvdXwu8G3TxguHfPCbM6xRfWKsZFwWPoAE5
 /gFJjkn3g/Z/8DyqjMO189oBSoMy4ao=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c28fb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=s1NLoHz9uzatdv2VNqxUSg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=i4eqDRyDUUk0pEqmao8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: mTfneT3-S_w0RQc4uLJlvExKJhfD7a26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240094
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

Add the const qualifier to CPUXtensaState when the
argument is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 442e98bd1ba..49d6ad9083d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -708,7 +708,7 @@ void xtensa_set_abi_call0(void);
 bool xtensa_abi_call0(void);
 #endif
 
-static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
+static inline uint32_t xtensa_replicate_windowstart(const CPUXtensaState *env)
 {
     return env->sregs[WINDOW_START] |
         (env->sregs[WINDOW_START] << env->config->nareg / 4);
-- 
2.53.0



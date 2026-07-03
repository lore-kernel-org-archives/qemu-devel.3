Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FFEC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgyC-0006Ze-BO; Fri, 03 Jul 2026 12:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgy6-0006YA-KR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgy1-0001zx-OS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIx70348410
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uj95z83/1sCENjH/Xd8wZ3dfLnySSTwmBS0AlA6qk1w=; b=IA9dqBZ5yivJIbfp
 tmgI83yN4jzWpxnI3BnhvWHOcAa73ga56SQmcIVsxUNVOH8NmynbdHW/WtGE+bnp
 44OOAk4VSnRUc8PdniGRD/1f2w/iKJsxkLhz+r0dJ5iKH4CtiJPglyUZqcfRdIWR
 tGrJkomCoi2CzMZQxtsi4YbUk8ASMmDY1hM42Ed0czTGfktpkA1viE/zwbCDk5UT
 erIggHBRW4wDWLjir4RIrnFy0wj5nyFGmOtXuDMAtLYqiZ5BbpxyD3SjW3Ht/bK6
 tGDusJYGDdbbe35ZyRyRzr4rGqcvc33WiC6kpFiOyeBlXYvIK+qafzpB3eq1tb9y
 TDTQRA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n38mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:42:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92da6f3cc81so89855285a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096926; x=1783701726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uj95z83/1sCENjH/Xd8wZ3dfLnySSTwmBS0AlA6qk1w=;
 b=Jk8CrKTSBLgOJUoNpA/Jy0/SQlDvdYvKj91HlWmF0xh8w9cJ+yWglbnuvwPQKXUmz7
 F6ayl8sdzPfxI0bNlMgpfQVy8OuxCHBPUnuWF4JpVJpvpKgf5DZ/Ajv3k+0FHlM6CizF
 AbomDLpavUq3DbQkvpnPUqBdTFifizqxVwQ6SJvVQ9RGFw9WNUJHMbpcw7SoKt1bbksI
 8lRCpX860eMat9tyunFg5lFHi+aTUtUdJCDHoEAW3lPpfMfJSR36r2Dr0D34gM7KD5o+
 tTcv3Y38w8xDa40oww3qIKICPF5YDGhfPsg7PDJ/oyqErcO+qKCP6P9ibyos3WBag1lR
 SSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096926; x=1783701726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uj95z83/1sCENjH/Xd8wZ3dfLnySSTwmBS0AlA6qk1w=;
 b=F2hAWGfQ4uMKbQ8HwO5FRs6hTUIRkypwjcspP8CqmhTTSMUvA/Pja2vDFRFIIMi9TW
 nCQXtPimY8RBnbQK8OZCwH2a0DNkAWY1bgW5z3olo9/jM5nSt/k+4rAHJlrpUIckTjg5
 CaPDCL4KH0IOIjU+RAyVu4YFOD0eE41vXvbwSIfJKBBz+DlkjTF7RzE86jDSgy7IE7Sw
 RFr/uXm0vvzMfIy97a6grxiLOOxFR9rsrF38UoLCafrpMi2Y08bu2kyuaFWyJOnNholI
 smVlwBUE+xcAl++yJHpUk7/CVwKJ/e+04q/DjHo/dABN0z/kAyQdq4k7z/MPwuqELOdk
 bqCQ==
X-Gm-Message-State: AOJu0YxsYV1mbjZc1la4atGoQ+Jb67xDqo68XIFIZ2XGLDaMf9bQjhcY
 jwv1l7iuAHxDCyEp55t5OktR2Bd2bIA7ZrQnDtq9yMshfhT/biP8xPaRtgSPOluvMHdP2g0xKM/
 x0z8WHqtBBW/Jggh/3+6yjUdgt269Nc2xq0YIqVzBdgf+TABygE0jS4FZ/TvRoWsNVA==
X-Gm-Gg: AfdE7cmL2nUXHXrxO+BRwPNTW6kRH/7fBK6xYNzUYpdU+OgwCT/m8H+8hSZzdpHuaE8
 tK1khlFVwXbxpKaVf8axDyb7z2QHpnwN3bvR7ooqhi5sx4YTWvvJrupR3EUOBYoY0hCeoYtBUix
 8eFW7c8LQs19Bs0Ii5c9iMQgbAXkNAK8ZJvLPeBBFdMLa8AxtALTZIFMNMjE5JxUxdSP9HPFRf5
 pCyEe70Pe3n7c4vfPgaUZjNFf8FwvYoEp8+2jNW036WsBULNAthYKKD+s3+qEcyOgQEq8PeJp3c
 uXpczD+P7RnqKvqX/XikzuTO1mKT39c8oUi0gn/v+pcT7BkMBuuK9JjL6uL091hVsE5CM1MTrZz
 qFzzd4HubcWT8JDLrAk0b9qTlB84+cHA9aiORPSlhyakH8oHiwKEAb5FdtE0d1LvPfaGu
X-Received: by 2002:a05:620a:27c1:b0:92e:745c:6c48 with SMTP id
 af79cd13be357-92e9a4a1518mr24362685a.34.1783096926206; 
 Fri, 03 Jul 2026 09:42:06 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:92e:745c:6c48 with SMTP id
 af79cd13be357-92e9a4a1518mr24359185a.34.1783096925675; 
 Fri, 03 Jul 2026 09:42:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm646199f8f.3.2026.07.03.09.42.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:42:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 33/33] cpu: Only check SSTEP_ENABLE flag in
 cpu_single_stepping()
Date: Fri,  3 Jul 2026 18:37:56 +0200
Message-ID: <20260703163757.55500-34-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX/VT6ay9qO8LS
 XcgMrMrMGCwovQ2knVEKqegiHr07283hU017I3raMsU9RKCamRXi/ha2oa6YVOV/YLMSx8opWrG
 T7WbHSmpSyigSxVK9tcg2GWQZG79gjo=
X-Proofpoint-ORIG-GUID: duDqyRwls9rYCU45v8GI6-DNKyh7-leB
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47e65e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=67IpyjWKbRJXbWkAkIEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: duDqyRwls9rYCU45v8GI6-DNKyh7-leB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX2oRRV17h/E4g
 qYUDS2+7OgKQWM7eLxo+pdsZgYQ0pBVOfp4TBtEaT0Vt/kTlSt8i8xzhnctEx6dGmh+hvUuFxTA
 0P0F7suJ/wryDA8XHpb2AEz8Np3Ax2HZ//V1kA5TYxa1FyCU/wdNshpO6nxneaeOieBaZQxKFkw
 ZYtCllr5qOqXO8loHCQS7Ogd6RuRUzbLctytIShXbvp7qyK6OoyhGhZhC39+Xm8dxzLCMHPybM/
 rE6jbulrdsw9QMP0HCGyndv3JR6Q1byjihasQSrwxLUv3Qn+gdP4j9bbiKtHji3vp1D+WyLxMut
 ztMXf1lMfyRFa9N+MjQFOAfG4mIz5GX4JerxoiISyUZo1JCgpk+wnmrycLMae896rebTdROaUES
 ee7RZKB9jMK8XtWw26/XHbF3FelcV0EJHFHM/BuIwmKSAfa1pi3xsNRj5oQ5k5GMuA6m1ckZNqc
 WJETZMTD3b9ab+bL8+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

Only the SSTEP_ENABLE bitmask means single-step is enabled.

Fixes: 60897d369f1 ("Debugger single step without interrupts")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 31f1d787352..0d14ba49782 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1146,7 +1146,7 @@ void cpu_single_step(CPUState *cpu, unsigned flags);
  */
 static inline bool cpu_single_stepping(const CPUState *cpu)
 {
-    return cpu->singlestep_flags;
+    return cpu->singlestep_flags & SSTEP_ENABLE;
 }
 
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
-- 
2.53.0



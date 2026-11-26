Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04359606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L/7z1utR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gGbYltEZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj1f-0004pO-1a; Thu, 26 Nov 2026 18:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1c-0004lm-Cq
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1a-0006Nu-Rv
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:37:12 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwj661712623
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 om4N5O1FLJz7xduBeJcXUAQPPUkAoSRPIsSLAiB1kzI=; b=L/7z1utRFFuVk2kg
 txpjkQwhXTicxB2VMvI1QSJppZ5C319iZDmIy+VrQqyD7adJzTW7z8sXzF+g55/t
 Ri5Rf2wtG8sxqH1jkZGo2T/R8WJ0fitckDOpdOSEfgjZGoVwQlTi20zIUz0ITZcU
 SH4CvbYknhsE+/MVvWzKS87SwBTmdM67j/7zf/Aj3mHDU2SJCkudpGhkxda9yMZA
 VU/J+zqXx+SqGKiX1WcR1CZMi3wSGcBrk7SbAv05mLqEHlk1fSPVc1KYOf93xqps
 /ZBdZXmnpik77nad1GuW817+IieOe5J54R3clyO0FiPPBPbjIG4NYQ3Xo6r83L1K
 e4S84g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2u61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:37:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949dc497896so639120385a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736229; x=1796341029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=om4N5O1FLJz7xduBeJcXUAQPPUkAoSRPIsSLAiB1kzI=;
 b=gGbYltEZIA2D7m/aUmPl8nfjkU3RHn8dqxU/naDDmz7g89Q1kj8tpp1rc5oA/C0xU7
 t07M+A1x9IX6uVWfQg51OHTSNesdTec5HIgXen7+xKa8fTPYTMV+2uCuGwQXGWnrCvkc
 QHdoMdcubYPVhYe6sbzm0Et4iFeF8FkZnh3y5+JAdxilPirkoNkyCoeywNPYnY5zIVRf
 N8gH6DSch6tNhnjIWNKA4SqitnhYYTbysnVz6GFxSp05BOKY4dJhe0erbLZq+622V27L
 5Rr+ytWT+5J/SUH2cCbq7WV665J0sy6lBPfImUeQN5L4vORGjssy6PxBzP5Vu07+omGf
 pXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736229; x=1796341029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=om4N5O1FLJz7xduBeJcXUAQPPUkAoSRPIsSLAiB1kzI=;
 b=z0Vx/diSwgG1TA7ZMce0hiCj4TIDAu4EBhyvMwPbVjK38Exf4qf9pHsmL/4cfKvR4k
 Z+V5EbvX4qNma5Rg1sfeHVfIe5XnDkYbfqkKg7L+u0FfxIIPUSJqnICi6uXJP3kigcKC
 KFpxvVQiVxyUdzIbrjCZ8veKtn61qzt1LfzuUP/7+r6fMUjkS75S4G6x8LhpdObgTovZ
 DmnagMriR3EasFHtoizMtmTF6bebrdMJgmBdwr8WpV4EKdOzWNPl4GaGABP8d3aXyyD+
 KYHpQcau+ULaqcRnhQZGz58DzJFMm04amt2ZPoXfBee8cSQ3IGPp5O0X7nx5uECZoeNm
 cvJA==
X-Gm-Message-State: APuU4Z9rkSR2hNZ0rVMXhQHdDVGR1dmB/Jc9AMlRo8Yyfp1zzsnCpYIL
 MzeqHOn68RVORwOAIG4Gp0IBih+TgMROq74XMirJ8EgsiSDTHsx2P5CRfBp0IyxzLNivF0tnxcb
 44Rr1gr1LHNtP6qqoasXGNBe+EGgh3GyymCIC3uFdE4JdzWcwxK6UlPocN55S7tBpSw==
X-Gm-Gg: AZFdTZeYgrQfC0sAew0t6Vr7nEj8FaZRZDIv/eD0DQ92A+D5iSErbyR1KduEJ8wZHCT
 C+kaFnFApQsglKHpQ9EqUmbZJGe8cB3yFTS1CEgM0U1Jo3OgO1lCiiY0q8hMqxCpGh1g/kZlmxG
 MJca4iZZKcyhrD5mSMlpJqoYXT2g59vaE2dQqm06nhlW5ZvFhp6CUbc0eHMes7eUmtOVTfcaKhE
 T/I6Nrt/RlsiRFs7pNvbCF7zIKR02bd/g9w6LvQaqGmFrebJjOzAPneCISyQxdh2IW0p42Hw016
 U3gIW351+VLnVuABC0sk1BxOkwqAHuFpAYN/tSGwyO9WaNTzaw4fy7n6sBRtGwajCEQny+H4ThJ
 mIVRFq4rpfhIzn81Ie/pKazWo8P8GikmbO82bVwft64O09QMMDO4d+sZ1AuxhYlW0cz4v1ITrq7
 bTbyRn2DA5c/yFeg==
X-Received: by 2002:a05:620a:2a02:b0:93e:c12c:fbd0 with SMTP id
 af79cd13be357-949bac7c677mr3979822685a.76.1795736229079; 
 Thu, 26 Nov 2026 15:37:09 -0800 (PST)
X-Received: by 2002:a05:620a:2a02:b0:93e:c12c:fbd0 with SMTP id
 af79cd13be357-949bac7c677mr3979820085a.76.1795736228598; 
 Thu, 26 Nov 2026 15:37:08 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b39b6sm592173735e9.12.2026.11.26.15.37.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:37:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 08/24] target/hppa: Use 64-bit TB flags
Date: Fri, 27 Nov 2026 00:35:46 +0100
Message-ID: <20261126233604.67722-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08c2a5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=bB0c2MIPfoLSnOdUAGAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX2fB7uReEq0Uk
 gdxy7CYeT0QBZHA1TT9uksHChCF0pmfDzGDwcB3lxneaPkV/qG0VJpPqx+acVG1//idbhdiFUGc
 gr/eGxEWwAvVjuC1xsGGoP0G9pm25y7Rv5U+uyAUP2OEAwuXmHjjSRfFU9NaNvxMOAFLjYUxpy2
 x9H2dBpVOcdSsQksEMNE5FhWAL1YS4BoFeXGwfngXh1nwMJgy5bJ0R9m06p+TC5NraDUJkus++g
 tcpo6LsIylYfyMsawMjiTlyf/WQiw37mDINRk7HQOTYR0SeSDIUULPaFUtG2WfsslsyT0z9EtCJ
 WxCZ/L5IJTyLHWhqOMrru/Z4QFr1f6McS67L1zeGtqeggz2NGfHHLlVsdOzjcs0f8XodPf936mJ
 B21JUbFkn9b9DL4Or6gk8pe0todyZ3anO7YRHhzq3msRqVpADoKRcwKCoFboNX/3jiZNVbOWXb7
 lytbTlWxzMJ9kMl/XmA==
X-Proofpoint-GUID: NUA0lbZ_dRbSSI4feqH6WxUzBLqWBhZf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfXyETDNRmkG4WR
 cjwuFzvNzwuxfgiSTPB0UJr3VdZDbYIic4KyOJ7kHppcV3qj0sUKcGvXgRv2RGh8QZkW8nBjF/M
 1OMpCqaEejUVuOFIpIk0IM8E0FJ6Kvg=
X-Proofpoint-ORIG-GUID: NUA0lbZ_dRbSSI4feqH6WxUzBLqWBhZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags and TCGTBCPUState::flags are now
64-bit, use matching types for the values derived from them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hppa/cpu.c       | 2 +-
 target/hppa/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 83104ae0c70f..2e30451f85ad 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -56,7 +56,7 @@ static vaddr hppa_cpu_get_pc(CPUState *cs)
 static TCGTBCPUState hppa_get_tb_cpu_state(CPUState *cs)
 {
     CPUHPPAState *env = cpu_env(cs);
-    uint32_t flags = 0;
+    uint64_t flags = 0;
     uint64_t cs_base = 0;
     vaddr pc;
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ab3505f9c973..16bd0808bb40 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -82,7 +82,7 @@ typedef struct DisasContext {
     TCGv_i64 zero;
 
     uint32_t insn;
-    uint32_t tb_flags;
+    uint64_t tb_flags;
     int mmu_idx;
     int privilege;
     uint32_t psw_xb;
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA1C98314
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QWn-0005Jn-NG; Wed, 23 Sep 2026 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWl-0005Ah-4Z
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWi-0001DO-VF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTsZk2470361
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IeLVm5/+AbWfhQYlNgRIjGIoDIVppu1o783xUoR+s+A=; b=Av6laJltTdL/EMLE
 iTVMtsWtI/PWMZnlA9r2vRbBaHC8TR+yoKjcPz/xnGOEsHt94p+EtoF0QAyo1bhh
 2NqZstN0xsTGEVACBsNvsseVAO17NuOlJi6G62Rbn/qg9ILOCD14sqY+UiFy0WWO
 cBrYZkFNGxOhyKr2WP8T1dTyX3Nne/mYPl2TQmrhp3DyR0VdPB8iAGHsZ2rtvyIg
 2Do3x/qPwMs9G7+DVxYwMawury/u68Kt4sM7roZiSh1mojfKl0kfnqZCAKDV1cAl
 uxbgAtnAkTTgqQPxvp4hyhfKegHlTjUdFqpkJoUPkfD3WRoQXxbwYjsuH+qway6E
 UmEzAA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv12sy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:49 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e99615e0dso62376241.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183568; x=1790788368; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IeLVm5/+AbWfhQYlNgRIjGIoDIVppu1o783xUoR+s+A=;
 b=JsPekU0DZhXuLZfM3+wUgqr4YWRXcj2TsbU2wVHdmsYKqoqbjV+tyxg4+p2YXqBhYK
 Jqoji0ZxXNQ36jEKxM4MIZrS6+CibmRP6adXykvjrFiJ3Dh9pPAW0374EeidkT6B9pQf
 aJjj9+Pli9OL6q1AyV3qaPLYOezZfpIh+2nUpCSfAdGxdt8BofMYBO6Ogp7nJhBnTwyp
 oWEqg/hP9NhtgqqBVdOBAJOWaa1PzQ8K1IMHwohRJjEtK07W9ej+pzFwo0COHhDedVh0
 ci3r6SB0xNtitk0q6qjrhe67cvbZRshhr8VkZC9xhZ5uijemgnZZftk9XH1v/CB4x739
 +AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183568; x=1790788368;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IeLVm5/+AbWfhQYlNgRIjGIoDIVppu1o783xUoR+s+A=;
 b=nx8jS8F5fRfqCTkIqR/pALnE7aZ1qeU84/u1uNzI/e0xqCOuInFj4ej2OyKtAKMzJI
 a2qbPyS+xsWeEtVCCVU/R/ObG1qcTbwsFE5zjLMhH6P73XhgqtVtcQdPqJ+FzOyDmkq8
 HoNiE1rZJ+0SVXHLgHSjZFk2cp/3JvR8kSwuahCyem71EBO6RKHL0NUsT2QVBHNNlyZo
 hx1oVBo1ZBMaPalUutLdgLH+vqZty9Z4zM96rWWmLIUsT8DQNpSZLaXkoN6TnEaPeKd3
 EGTIyewEyhpYfQAT4CIRvxC97qANBufO+zXQE6kUCjM1KdW0og8kYrkZ3zcqUknImPMX
 dKHQ==
X-Gm-Message-State: AFuF++lmB8CjLou+DwmImhmJagWl5heIoMxbp3U8yVJKBSKDAUHJyMhg
 mFU/9uN7be596/+gEgodfwvG3Spz6COwf12Uu/79c4QclteoZVxwbYcCaAF1C1hVyqMzUxFIlLZ
 ntbjVDBBIiOtFnWkfu3pwE4NVZoWp9j426avnlIw/mn6/CTSMYwHWn9J0Cdb9Ju4yF+CI
X-Gm-Gg: AYBFou0w/tAMXPPQLcmyaDCGKfWZ4CLHfK4/+kBaew040JNb9azKpSpKunuWLm/F1MI
 Fy+2CDV3XJqK4bvAN7eM3ohdVoOcqkosCFhMwgkTLdi07Fyv89saLVsyruD7RAAoE6d4p2MDzDT
 Lzjk28HQjOVZX0kQW+AkqGvdTqRo9Y2LRxugaAX+uyzt9FBmUy9V3oxVCkWka4jXG65LuhZ/Ff1
 ImbzB2c1okyGcmKAnobDvyPrflaxuXWXYLBIXCXkp3iRPL2RDYc/ksB6NjeZp37TpzJs1jczch3
 VyxSMs1b/njC0mzY5//+0sL2WA8mUDF4FR6bwv2SoUrxw4Th+u5GGMjImuIRUbECJS+cGpfxJCA
 fxeK0YTwLZuh1n1k3Ci/BiCVV4VRLK9U1gx0TaTML
X-Received: by 2002:a67:ef8e:0:b0:7aa:d0a9:c5aa with SMTP id
 ada2fe7eead31-7aad0a9c60dmr4313404137.18.1790183568418; 
 Wed, 23 Sep 2026 10:12:48 -0700 (PDT)
X-Received: by 2002:a67:ef8e:0:b0:7aa:d0a9:c5aa with SMTP id
 ada2fe7eead31-7aad0a9c60dmr4313381137.18.1790183567911; 
 Wed, 23 Sep 2026 10:12:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bae53dsm875175e9.4.2026.09.23.10.12.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:12:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v3 12/21] target/riscv: Access MIP atomically
Date: Wed, 23 Sep 2026 19:11:06 +0200
Message-ID: <20260923171116.31276-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4g9/GmFHGRe9
 wyPgDn1af1l/nqNIJmxK3e+uT5Selohq/q4nCvCcUzRE2H+MtnQEtAUNh3CQm1C1kYzP1lQt7d5
 8lvqEipb4li/sYGWH1ARIcWKXs6t9qXIhcyNTevXcusXcDiMHleTxLxzwxvjQ2zwjRUs2ati110
 wbf7guR68cm/iNTHldGlzMzyVKzX+53P86ReyzeIyEaTLizsoVmlLxjrz0rOyvKCoEtmQec41L9
 cSs9KXzYnlUQt8BKCEvfH09d3fw4IcE0jonl1Z59tV1HqGjJosrvEOpF9WssANN8w8bZXDGjhls
 C2XFrozBN/bBrtzy3m4hqLTi8eLv4xhC+be95MJu1SVmQUH6wDFg80r3Ip9ddW5mDoxm3cPPzYC
 YoLm5bfC84WlQ6YGywvM+rWMsj9eEHZfsZhvlIUqNxExOlAPZKG7VSozNU12nKIMH9Eg2w8uM2D
 P3A+Q7OX0YHKaXPPZXw==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab40891 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-7qWTPA4ftCRTD5zRq0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: gbsEqcb3rf38SnHoXoPo97_WjN9cRcuT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX78tIiGsHvQu+
 XsHMiN6gTxIzh/pVeqAOuGEfFGFjJ0pjMs19/YccUd0VYbiK7oVEwKNxWFDlOMldwHQyKfrhwm1
 Y7g1SWJxmHyWm9aNc+fgkYe6bMC4KxI=
X-Proofpoint-ORIG-GUID: gbsEqcb3rf38SnHoXoPo97_WjN9cRcuT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

Use qatomic_read() in riscv_cpu_get_mip() and qatomic_set()
when updating env->mip. This makes MIP accesses safe for
riscv_cpu_has_work(), which may run without the BQL.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/tcg/cpu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index e524798d312..2081875a206 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -528,7 +528,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
 
 uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
 {
-    return env->mip;
+    return qatomic_read(&env->mip);
 }
 
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
@@ -592,7 +592,7 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
 
     BQL_LOCK_GUARD();
 
-    env->mip = (old & ~mask) | (value & mask);
+    qatomic_set(&env->mip, (old & ~mask) | (value & mask));
 
     riscv_cpu_interrupt(env);
 
-- 
2.53.0



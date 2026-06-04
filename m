Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D689BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4lH-0005VO-O4; Thu, 04 Jun 2026 05:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lC-0005TB-MP
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4l6-0003hj-W7
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6545PuMT994913
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tjcJ28mFinE
 xTdQkLHGFFBxaKcXZG06GkSkZCcUr+IA=; b=hZ8933vxbSyuJSh6epnSwdex7Vb
 Umx+MAw45Qpma2T/aJrw5y83KmdI+fveEf7B8DKYiRNRc+axh7Dchg+fRUuyZjTh
 9JpnY+Iumfj2HMwkTiVq6cTYhKvyIlyy5Bj0zTwMYpp1nKMDVtTi9m/lcCTUAhZ7
 A6Rp4frRqIMXZgciql5/nvcqEXRhkDnbA89qYXqsdRKi7mACETpwVtmPXY1D0jzg
 GJ4ghNrC8j2giSs5lsuCDixVT4sPO4yTvR1JrH5q2LZjszlkDTjXq6zF6IzwOfjd
 No6hOCq6Wq+TzARvIU/vS7cWigrO6sW9injd/e6dZ/hG07Amls35WVP3Aug==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek374rxee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:53:01 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7d19c3a699fso6713637b3.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566780; x=1781171580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjcJ28mFinExTdQkLHGFFBxaKcXZG06GkSkZCcUr+IA=;
 b=PdxC499qvShdHKa1pDS7wxLH625THegWvIbiaDPUEz8AKfw8mxEaJw/S3BBmlRKnmh
 5Qg1LSK6j1C8qsIl4v1KgrOuP0D1KGs3o5KvpkjwZkoT82eWwz52ZQ3LnnB2Cpior7fn
 nYfjPaGOvhqOZ9YTvDW90iF3Goj7mqkqMrH+kwsAPNIo1D9TNPHibJ/CGN3751fnjT1i
 ohh9kErUzyNePVz5Z6yton33r8bI2ugn6svXRClqNfSVpgPcgUxHWSQTev6XCAkSnb4j
 Xl7t+2vE3q3lizNWkBrAS/TyWyDEyAU96LDAgHNyhZQliAFd953r0v/o+nxAJDHIXxLL
 QOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566780; x=1781171580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tjcJ28mFinExTdQkLHGFFBxaKcXZG06GkSkZCcUr+IA=;
 b=ED97o3mfi418RPnvrWw4AZ8+egS4DF1qwcM6H1hgQBkKntLkPFgRC3LHkr6y6x32hh
 LQ9voL4nF1ZoLP4CO7M/PPXJC4LKpTzFF7O/GB5or59r/0jRYNbzjXxgRoAeWqiBg3zX
 Krd952r+mQWFH9vDGh4NMSHCZSEmoc/zsVPArce8dgOGYa3s01PV7ShdME5Ip/c9Tbpy
 KDs1QgVRYCCc3vyHf80DE5HakBt/IOIWSm09i4IZNQ2xc87XR5vTylR+0pvTe57dFK/x
 aK5xQmmZZ5LKsjksHOkNp8PnmMHPgyP+0NYHI1z0UI92ql+CKVTqqma8GLA611UCeE8s
 em5w==
X-Gm-Message-State: AOJu0YyD4DZwxaJFLXt2/g1YgJc/zIPJGoUC/iMDgEQHh0Lw5aEULvEr
 bTcxzA6kMZbUXqFoNVw+8gmR6Ifes/E/XLPnJ2/W+4uaiyc2Qw6al6L8JDqQRG77m0aLLgtkn5v
 6nXIA2X78B7Zbb4GedXgpTQ6e0FU0Gi2SQpN3kyOH07eGbxBTXBDpbQi/6c2az4j2BA==
X-Gm-Gg: Acq92OFRu4xuTKGx/bceFthdHZqbdYtp9whNtaWUfN8OY86ETYjLeBKyCap2JMM0SaW
 4M24FpXpTKK7KzlB/0IZryg3N+4gd4Y18PfJjN15usj15SYuTJ2A/kNb+fbwwOCpQP+En8LKuFV
 uG3QmHzuCZUJfGlL0C3161YBFCiaiHZkT/BtQtwn35DlULS76fzyVLA5b0pc9/bQ85YCY0HJ4d+
 TVszrD2DK1UIpo2swXD1nBO/tFgPSvEmodRBUnzlkueGMZy1k+oX/3Es6/hBKPqSZ4A+XHBeNEi
 UrzC7JlzeiCvRWRpeG6g1xE0T+2JELjQYxJ6d2X5yjERhvKmh931HmrRwB9mhOWxwLhJIxXtPfS
 x5kHQFqwB2NLkr5enGUDsSxhKvtdyCjp0QdgxUMl9EryEmcaUWiiVLzwSpRkFsrxDGoe2ug==
X-Received: by 2002:a05:690e:4384:b0:652:ddea:1679 with SMTP id
 956f58d0204a3-660dbfc0251mr4376583d50.16.1780566780317; 
 Thu, 04 Jun 2026 02:53:00 -0700 (PDT)
X-Received: by 2002:a05:690e:4384:b0:652:ddea:1679 with SMTP id
 956f58d0204a3-660dbfc0251mr4376566d50.16.1780566779935; 
 Thu, 04 Jun 2026 02:52:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64ba680sm3522830d50.21.2026.06.04.02.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:52:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Thu,  4 Jun 2026 06:52:40 -0300
Message-ID: <20260604095244.3313259-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX8emNDhO9nte4
 vEvb5KNB8KxWVkzoCPv3uKgDVd7u31xEzqOej2zzWF1TiPbN6+EMmYSeKpGlGlz0TEiXX5mVG+h
 /IjgPuXBPRNeXlnyYBzL7XcPh4m7YaWexvTooGvCDaO4+JH53s06TY4RsNHOhp0L0yvC5XvpPLP
 yr75VjmTJ041VB9iIi8f/3oecnCmZtUnI9Ti6eh+jsctRlIxzd+UTHEmVKaPqE9HnKqH3OJuH5p
 wPEhWDPlov6mTLlA1SIY85OuD15KESfeBN/ucAJRn6gccMsD0a4qogrtYcr3MP1CUssYkY1qe34
 banxmLkbP3m1Dyp8VDqe7tDfwge86W9Sw2RMVX747fIEIoCoouLtB0OKVT0YZ9Hs9NobL+C5Psh
 yGFVdwlt6gWBWTqrQyWT/R/JkL4hicZo6c0dlqXIXlLxW9LYvgmjvlSZ6pmqUGpIlTjhrOrrhTM
 hWHxOk+QdYYSKeLOPVQ==
X-Proofpoint-GUID: cJFrTq3PdGZa2zgDWDJb1Ei4zPsW6mOE
X-Proofpoint-ORIG-GUID: cJFrTq3PdGZa2zgDWDJb1Ei4zPsW6mOE
X-Authority-Analysis: v=2.4 cv=eJsjSnp1 c=1 sm=1 tr=0 ts=6a214afd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9 a=kA6IBgd4cpdPkAWqgNAz:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f3b5d4c94c..3f0f931335 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2737,7 +2737,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0



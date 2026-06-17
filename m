Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3081DCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtK7-0007K0-Jl; Wed, 17 Jun 2026 12:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJw-0007Hn-KU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJv-0004Xw-1t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HG5nfl2634356
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FvLfy4VNFVkLqiaXXkc0xOlKpdZetDI+NFSc8TX6LTU=; b=ZSr9ZGAS3eY8KQeP
 IGxdjFNwN3OlJv7t/n49Bar9W6Yozo5D5B2XU8voTq/ATNtxyxvsycaHopezRPpL
 SpCQCxRwpN8HMVIRifFwaEcaC+ITeJ3oCjvPYEQCAsMxrYr7M2qsZ1k3CHVtn4Fy
 FQqjAHTu8IPR2/71k9mTbsX9pXXcNs/HEgJ75MckdtY+sQvc6eE+0GnByWC6Fso5
 /kyOOfvxLnsrdahjR6KEjogrlHyfZzLyzUhy22si3xmlDYSjEOfLLDn9FlmdDsB3
 LRfPpPAYPHqa3rDYjCDeKMSNwzDfXq022EyKXNY+mW6IX3C2XbUCPovpNO4z5dE1
 Wd1XWA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt507v0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963d7e5ac77so2593168241.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781714453; x=1782319253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvLfy4VNFVkLqiaXXkc0xOlKpdZetDI+NFSc8TX6LTU=;
 b=SGBYHeW41hKQ5cwwrCpouEIW89fTq8o0mySKeyTpURxUMA6Q6DX+wAyQAHRbUzY1x/
 KHi8KYHGqcBGMRJF6lfgZIw+GrQYR+8GXpYpzFIPNrkQ1NlqZxzMrQGiF09mUkD5WSHl
 qTL5yJvMAyiCUhkAtn3hbv3POI6O/BhxR6FF3GH4fq5Rif2IsYwEQZdDJ5UaL0iPOOe8
 ZKrknThrVINi4+P1Y44hHoxsCx498g8d0WypHhpoCzrZQheGEOOdn3WpyfLnEQPnj/qe
 Vvspi6g9WZIWzo02fUXQn93X6QVRLhzVZ5M/qZ2H1yodIk966+a8gOqUOZRy+azPSoU0
 PTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714453; x=1782319253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FvLfy4VNFVkLqiaXXkc0xOlKpdZetDI+NFSc8TX6LTU=;
 b=T4N7c4S+jj6wR0kZVSiyIlajt8LeYvFaqe6Hiivsk0Uj1imfrHFbKWy/6cl5dFBurR
 uW6YoIY0mvzlMfdCUCmGYXIq/LnqZXjhrFDZ/W0JSD546U+SnCSoMFBE4KRVgna5tZ/z
 HF+AGsuM0trEKNyq5EW2tNTAJ24V2+nvY7uiiCtX06VurLoSKVLPCBFyXhVS9gxYLplD
 UdhRFxidwhkjCyGp+1vZ0FYuXWgtZqZjDrKB0oQ+wBeYZXCmrveDmDDrCRuqNwePbMMd
 tlhtiWAwUmgNp0MMA7AC3wzJ61S/SynU4mDFb+kJS1iCg+tnv/Galbb2QDiNo3dpXSmr
 aY4Q==
X-Gm-Message-State: AOJu0YzX/SJelIwxvXuqFJSTzXhsZ2WZ8WQ5ya6nlLFPykBL9vRsfzSS
 t+aDes4xTI/4w4q5sE3tKVDr8zvf4a0mMgugUgyMPVkMaS2oAZlLvBrbXiM/pAeeUZ4U23/HSXC
 24DPMdZej4ksvERw2WNzi+BC4zDLm9/Cgn7aRkSu7064MOHuG7cpxRcgaoKR9fQy+RA==
X-Gm-Gg: AfdE7cl7/pzJYERrIdLlaiFJ2ojfuJa6WXD6f9tx2C8f3IajMrVc+ftyNOYlUoEp2fw
 WqNe76DBGeBYXMYoXwt1eXX1hrrmyxxHyVLShQnVm4QsSyjTLR7QpffV7y+Z0zKqmxJnEc8iHk7
 yfrGMvHi2IELaJ8GKN9BTMsKWwqCabmgAtiOMO4qtL+b6p5J0vXIqdQtUaVm0JiR/nd4rMQTJP6
 A/I4RG2IWo/I/b+5yXaOgYKTquUhaVSEuLTtQ8OM4wW3U7Esw8ICloBqyJ5TYmgCyzEtLL5nmRf
 jlDoGRqILE/O0AEyml6HSldcR+GO5YE/uS13qQEOMvdoLJjZ0ge3XIPEezcJlxkHulUbKjR/TU6
 PDUqjopcINwOYWkc6En7M2YBQtm34c7+nfpwnXcRkwtl6j4CZfX6KSsxfr8BOm6MrlmLK
X-Received: by 2002:a05:6102:4b03:b0:632:3bb5:95f1 with SMTP id
 ada2fe7eead31-7246d528766mr2317276137.27.1781714452650; 
 Wed, 17 Jun 2026 09:40:52 -0700 (PDT)
X-Received: by 2002:a05:6102:4b03:b0:632:3bb5:95f1 with SMTP id
 ada2fe7eead31-7246d528766mr2317238137.27.1781714452121; 
 Wed, 17 Jun 2026 09:40:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm11872529f8f.2.2026.06.17.09.40.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:40:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 2/3] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Wed, 17 Jun 2026 18:40:34 +0200
Message-ID: <20260617164035.70788-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617164035.70788-1-philmd@oss.qualcomm.com>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s4f3i79wnS9jmgHpEiepmAS8-tNaG9Hi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX0AJd9ydi5rHd
 lEraTq+bEjmsWJF1VZrpxjf6A3uIV/SXh2MTSz6XQ+eVFVKIK4u4JNSFo/dzTwXbs0eZmuwU6kd
 4UAiDkRE0mPFDUeE8Yg+w+7hYzNy2VA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfXw8YOz/jF0PRR
 IxRKrOkJi5UV/eQSmqtWgZefTOLfQZJD2agMpEVhBZvBYRynQFAe4Pkf4C0FqYaoHOZyQe8hz0N
 NW9WOWYQKwB2CHcau8RrnokUu/1lFjCVmFqge8olB1qqFCRTj63/cbVWEIKCEMNB+TopihbWfx7
 gOcRfTU8/J9BHhi+9obTq368BB1Rhjqn2266XDczgRQ7WIJ9yfFgaAxD1HlYxx4ggHwFRAOvfLM
 D+MRhznLGfcppxTb4G2qphuIlxrTSU7A1ZkxW9y3WsMa/+Y2qC/dtoUafwcyTKgbI6riz3TY7lT
 HwP7i5htDVeDE8gnvuHSzz9b6rJ/+lVFW7tsEz3N9ze/72F7IVObH2t5/fFnf9leSuo8NCdZEbp
 9BJzNgrMF69qTr1vKHE2CQ70jaDMOHfiPYcu9lpA/9cM96PQ9LvD4K2gpJp6ExckgsLN/iOfu2H
 5Cx1VOzauuT0JNTKZzg==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a32ce15 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wtMswhJjl9DcAQxfHdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: s4f3i79wnS9jmgHpEiepmAS8-tNaG9Hi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170160
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write() respectively, accessing the per-vCPU
address space instead of the global &address_space_memory one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-6-philmd@oss.qualcomm.com>
---
 target/s390x/diag.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index bc1791067d8..01cc802eaed 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -79,7 +79,8 @@ static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_read(addr, iplb, size);
+        address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
+                           MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
@@ -89,7 +90,8 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_write(addr, iplb, size);
+        address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
+                            MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
-- 
2.53.0



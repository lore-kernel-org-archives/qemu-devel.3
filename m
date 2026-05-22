Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB8BCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUNr-0003nk-UO; Fri, 22 May 2026 14:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQUNq-0003nL-96
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:14:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQUNn-0005d5-9K
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:14:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHY7xv1800953
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Ktj2Z0ZFGdfq/FiXZETGXdKoNGygvhKkC3N
 C9nZeL78=; b=L7W63cjKJEIGUy+lX4rw1BpoyYO6H7W/mYPy5FzvR9J8DYeu7c+
 p7f2I3loNSvMQl4I76btjG4dze8nu2inDVFgRAgDidaNZ3x2EP/W6cSRPDIhmk92
 NfVMzjZ/v5Uo3z2s0LGoLJ4VFMHJqTnAY71RgKA3dwGc0RhDpGQyLoNXUy11zPVW
 Nh9uG6ZxzR9cFYYz2xkv4AU9XVO2frbpjClDsKk9NVTSG+ZMMB4Lyi9+cv1sur0a
 kkKlsD6dfVNGt6KupYix0aG/vLCF6GCv1CypywW+dkvi21GCE/XPSJwQUtNJMINS
 39/evBx2M8vlTw1hkoxK/58dAWRDuAUKuSg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g1ux0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 18:14:01 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95d434f3356so2770447241.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779473640; x=1780078440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ktj2Z0ZFGdfq/FiXZETGXdKoNGygvhKkC3NC9nZeL78=;
 b=T94lccZjpqII/95IlqHmtxv3xGPk0n0WovOntnLd4VG8w21oe9itEQcrPkMLCuBtXR
 ebJb9VStWqCQqQUrwW+XEy4mRdeXswffxNdP8T2PzpFI6KA6C5TI/blcr5LUDtiCTq9P
 1Sb/m8qCi999YVfcY5LrMEjGktDpdKKESMt6BAWX6quOgpBZPA/7mRlBt6fSlzwvLTUN
 ZLM+CunfMCCKPeiJkF22Rp5g0i/Ynv8z1c+1yQhuLxRQWd2AWeliJPo8Z/jlLulfztV9
 KL+YjaFgxxzII1UB9JEDTwIhmPtJBxNNp9NOyFpSoMId9Xqmv/fUMUSn0qB342A/2h6N
 LRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473640; x=1780078440;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ktj2Z0ZFGdfq/FiXZETGXdKoNGygvhKkC3NC9nZeL78=;
 b=lScj82QeLQhLKLzunal+M5Y5s0+lt8oz4q+mxjZk0X1dZPJuJLVZuHMC8ENHHYC6QP
 N3dTSrQVOib6pXEb0HfmziWfJ5YJrA8RM92IvhfZqub1nu2lr/GLD5EadBRX20QcSxMD
 K8MkapyZpjC9BD8YD5uh2YW9adq1+kODQ8zPmfM11ztLuGlmbQORCXBCoiSH2xTFUM1e
 3AfC7h9Jt7n0BN88DJF2ZBE4e19N6Hi3nLUnAM4iWAYiXQYIt1NXB+fbNuzWXIrZLLZ7
 59zrt1/EDWIE/XKD8m9IihukHazY0xTYKGjeRAjuCZIqjMWQ/SSIAEPVfarFSFdMspaW
 PHcg==
X-Gm-Message-State: AOJu0Yz4KnFEzN7xgLkPWN6EK8eD1HxhObDr5Y3LQDSafwkeN2R69pBX
 6fX+6WeGOXbnpvUOBu5pN06JKlIB3ohqAqQLkm1SRjlcpufA2/7Zf2TTEWzl1a6xsXEJI56f2IA
 jjVjysiObCBmFUNiRDMaOxeqi9nm9r6M1KqhqYZjBzaXl/g7UR+tfcrxW9+F91zvmCA==
X-Gm-Gg: Acq92OEij6xbsjtWGDNX3+QwVy14k8oZMjL4e5AHdJw53RRPhQT92wMfThmLcuSGeDN
 XiPx0fBLIBSQS9A6IP+jlEaUY922RcnouRy2KRGwb4udEyWWC9ynojL9oLjr9F1WNKSQBtcIh0Z
 nTzSvxKiUx2iVTgTRpPTKfpeJ1QOfkJdjatVFk3PB38UJ7Y7ydtXck3s3CBJwa8Vt5I3dlvRQeh
 uCpXFvjqkeAH5WFreYefGXgJE0xdGwfOrkUST96EOnrdIKE5SJ29kaZjV9M+kI3DeC5haM8tYrN
 Jktr9G63Rb2dCjRDsbs/B3VP/0tcKA+GjCKrD6oQBZd9/1xsne4DtbK/QzA4rJkP9kUJjx44Wsu
 OPFeixHlIJLpAjgZUrCRknugF34sDUBbArFIUv5i7ePeTjYgku4ebY/hgiOwj
X-Received: by 2002:a05:6102:3e8a:b0:650:94b2:b202 with SMTP id
 ada2fe7eead31-67c80d67e50mr2730058137.22.1779473640287; 
 Fri, 22 May 2026 11:14:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8a:b0:650:94b2:b202 with SMTP id
 ada2fe7eead31-67c80d67e50mr2730048137.22.1779473639918; 
 Fri, 22 May 2026 11:13:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96177c1a9e4sm2180368241.0.2026.05.22.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:13:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to
 AMO fault
Date: Fri, 22 May 2026 15:13:53 -0300
Message-ID: <20260522181353.429782-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E2kI1Fe4eML1F__GqpVSwpq7WN8xIrYU
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a109ce9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=LBstxtzZK52VN0eRwD8A:9
 a=o1xkdb1NAhiiM49bd1HK:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: E2kI1Fe4eML1F__GqpVSwpq7WN8xIrYU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4MSBTYWx0ZWRfX0vqvIelfwYay
 YusNJhWJm9dwD/X/rSLOd4bTRDBd1siZWkrnFYGcT5zm0PQCIC5HoWXJqH/sJmRbFR9MFyl2wbQ
 FsiKLhAEXE8qBojKGYNmaFjiZtv/Jn4xSqnyN5P/z5jERyfDwq7GTBlCBt+GHrQJCo/vrMWlgyg
 q+lcQ9QnFxXIg5K7oihW4AOlb0Ihsu1PhqQjXL1tDxESuXsyvj4QsLP3kcGIa98TEIe5eU6CYqe
 IlGL9Nrso23oTVSUi5q1wCAqviCz7sqEWTVffrqM2TplntZn3oxQ5MWswRWOfwwSd/VAI7lL5in
 Qm7n9TLJZXz23RUDciXiaZnwK0XVwgPabQ2beKNdddOM8mrrVkHxrr1Im5XDqAkExpZthICUKqj
 1Fvj56ZwQZdvtm2B+Cl9uboP8YxF79PEWTxUyAgF8T4WHc+12GBW9RkSEkGzmjqj/OS422CO73O
 JybgLr8CpfL3zgyX3Wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

promote_load_fault() is missing the promotion of misaligned AMO load
addresses, i.e. RISCV_EXCP_LOAD_ADDR_MIS should be promoted to
RISCV_EXCP_STORE_AMO_ADDR_MIS when RISCV_UW2_ALWAYS_STORE_AMO (i.e.
always_storeamo is true).

All other load AMO faults are already being covered.

Cc: qemu-stable@nongnu.org
Fixes: 98f21c30f5 ("target/riscv: AMO operations always raise store/AMO fault")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3503
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..aa4cbfcf40 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2174,6 +2174,9 @@ static target_ulong promote_load_fault(target_ulong orig_cause)
 
     case RISCV_EXCP_LOAD_PAGE_FAULT:
         return RISCV_EXCP_STORE_PAGE_FAULT;
+
+    case RISCV_EXCP_LOAD_ADDR_MIS:
+        return RISCV_EXCP_STORE_AMO_ADDR_MIS;
     }
 
     /* if no promotion, return original cause */
-- 
2.43.0



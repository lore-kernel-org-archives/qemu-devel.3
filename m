Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85319C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwd-0003mp-1C; Fri, 03 Jul 2026 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwa-0003je-VV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwM-0000mc-Pd
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIoou498252
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=; b=EQsW0JlPoRwqo44h
 0hoOOlBSE9IBb589iXWPZA9oNEtASk0iM7fYmIMlH/w9xSe3Hw5ib6jLExVFfGnz
 OVDPBnLNIpQWhoa/CBZTKQgZiME1kRq8RJcYAKjb4KuxP6ctaR63Y0O3Cd02Ux0j
 +mKdIL6ZLm+WhbuIqOh58UwiJTPlQnGMFqjx/9R1SUYyAd0GVI23bnfZpGiD8Qro
 3d6xwuMASEjq77d/prxrSjCZSkteveGwYsWRY2V+qN9qMnRGsqztEWZGEtd1izT7
 4trzBMwyDTqtk+0P5uIytL562/x0dJ8nfMuLzBP0t+plK1rgTEihaGVXyR0yJlCl
 P6Nrsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjwyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e52306621so54366285a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096823; x=1783701623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=;
 b=cQQWnH7cLlgfDQwptN13BF0kjGHiWTJdYasFvPd0EMRfrpwKZJnrGhhnK8BrP63m2Q
 znMVcJvm8YizofPCsgcOFAoyQ2ARxObTPwpJKTaGSTpTLNNlOQ5gUXLxgjmbIBLK9s9u
 UJTSxN1Jyi3X2U6cN2KSrMImyabwpIJrnqjI8IqHdnHPrNJelG3nL7B+YM/pV4yhfVWh
 Jj7f5PiR1Jqu2+8DhX+SieS94Vc2ilHh2rTC+GYKybRnIXbQGMViT18xVVe/XuKW6+lD
 HRyTWoiUtzOlRnPj2dovLibdTuZ0FbzYFJSUlmuwGygCdC8C2Cu+BnwlVMSopDqSaChG
 /RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096823; x=1783701623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=;
 b=AwiAsc7WDlHN5WgnOatB5un5wC5krnjeXZeTQB3wtJpNpL6NiNR0eLBP2dexyIlD/a
 TBGyt6QCLcG1OdADWWEBYEhY3YpEZzfgNfJE9tVLpEa5dhByuttAmnVoF4qCPwBSImvb
 fmy662h7t64IBFqKPcfELlphMsTh0TGFWNFsTRnKOqLZqLwmeY7UiG70U6GMiGy0V7jE
 Hd2cdcoMNK05t2XU6HdtpmXTuy+hih2RCyA3gmoPuu4lAgmEAtaBmvHaTiYmxnk++T0h
 6U0jxC26MYKn01yDWqmaKy0atO47il06uy5cQo0FIHDq1azPUoZ06s7d17dXylHUqfwp
 RRyA==
X-Gm-Message-State: AOJu0YwaaZUdaaB8ptd+LDbUcDPaM3vVqop/S9DGXOPC17xDouxQX1FQ
 I8Zy4YtHN32pyMJD3P5dOw7iZhoSOkphCiBv7RWD2L0j6S89YQpxUeu61YWxg65yCLDhKPOvC6w
 yjZ3xOuOxZxfvBfbV6QVPBWw1CxVY+6xTxii1KnnOpwH5EQUDy9jCXjgFij+/YH2d7Q==
X-Gm-Gg: AfdE7cn/+H39ygznfBIY5VhzNdVr6Xj7uea8V6RYTh4bW7ForJG70ZvuL4f00MhqlTx
 C2aA49WpDufkkOG+d4+ySSRv84qCdcu6ZT0K7TgKIxDZttIYgZPVJm8Wa1BpcIkGhuUYioYaXcn
 JbkvrDAKPlWgBXr49uCxKNGiO/PI35Yin/o7kEP8rzGNXeaNPyIs105068j8tbL3akjQuOKlLrR
 eiuhlzzNUYljWvjkxWmPH0okUIUFPf6nddkm8fKmJo//FqvGcj+LOWnC4y4C97iyDEWFYV7fKno
 W0st6FIxJJbaVzGNYKCowIU8jDuLWyY5zXfRfRBmli6LvXoh9uZm+sqD/bdRXRtoGayEnbyZOyO
 1j9aGwQluTtM53dEX6ofOoHjQBNtw2h5E+1RGDqc2NSaZyo2ILsihV3foj4f8uzHFRYqC
X-Received: by 2002:a05:620a:28c8:b0:92e:8734:b833 with SMTP id
 af79cd13be357-92e9a4e735emr24593885a.59.1783096822796; 
 Fri, 03 Jul 2026 09:40:22 -0700 (PDT)
X-Received: by 2002:a05:620a:28c8:b0:92e:8734:b833 with SMTP id
 af79cd13be357-92e9a4e735emr24588085a.59.1783096822260; 
 Fri, 03 Jul 2026 09:40:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce1947bsm63472415e9.14.2026.07.03.09.40.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:21 -0700 (PDT)
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
Subject: [PATCH v2 19/33] cpu: Move BREAKPOINT definitions to
 'exec/breakpoint.h'
Date: Fri,  3 Jul 2026 18:37:42 +0200
Message-ID: <20260703163757.55500-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lKeT7ajh3bWCnx1w9FAxEWtSnJft5KV7
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e5f7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yZPQLu4l72ctXTxYlJYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: lKeT7ajh3bWCnx1w9FAxEWtSnJft5KV7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX7pY8Ui6cVUmG
 XMCgM0bT62Khf7mkK9RS6KVebi18tRn7MaRNqFLEnPE9NT8tXgyGt+1sKcoRxSAvGUxrDmpBZ3i
 YIk8IHBW+bMhWPrqtxGZyq9P80dy4Gn6V1Z3JAQJAPkLs0CXKBSE0piIMtZ8w1ywMLEm2Y4vXvR
 f94vABwqWyC1zi2ET0y4ClukepAaXRdMVZQ+z0LF3o/qdPrWUCsQpHkLQoSE/tH2zGSSUT+m+Yg
 k7rQExJp/8ZwY+WlsYNDKdpZIemY1HO+J04f8TaA7iml8AGZ7zjPZ4t50KrEDk/Gu/bvc5UL7Zu
 JvCBj2PzouoSIZwCbs3VOk/P437HY49xLhjHJ3vp8PCPC6xRVycp4ifu2LtySHW5kagIAi7BXfk
 08zLbHk3QzDl2pN2cwlwRFc+UsGVTGa+mqdbfJCf8QNmJ4+HTrNQsA/vqyaRp9UiXUocOrUa/xv
 5C5iCqncxgKugI6vxAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzrORDPjXDyxA
 u8+qEChtlw9IK4ksMr6k0YUfYZEPlOaVQIzfG0YKVNYTm8sUb98NmhubnmOCd3zuNdASgYJBLNv
 HNi3qRbj+wz13u2Y4c+/RDcs5PJ1FI0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/breakpoint.h | 14 ++++++++++++++
 include/hw/core/cpu.h     | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d0..cc6fedd09fe 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,20 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+/* Breakpoint/watchpoint flags */
+#define BP_MEM_READ           0x01
+#define BP_MEM_WRITE          0x02
+#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
+#define BP_STOP_BEFORE_ACCESS 0x04
+/* 0x08 currently unused */
+#define BP_GDB                0x10
+#define BP_CPU                0x20
+#define BP_ANY                (BP_GDB | BP_CPU)
+#define BP_HIT_SHIFT          6
+#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
+
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 31753f331fb..e5b68bced3d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,20 +1138,6 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-/* Breakpoint/watchpoint flags */
-#define BP_MEM_READ           0x01
-#define BP_MEM_WRITE          0x02
-#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
-#define BP_STOP_BEFORE_ACCESS 0x04
-/* 0x08 currently unused */
-#define BP_GDB                0x10
-#define BP_CPU                0x20
-#define BP_ANY                (BP_GDB | BP_CPU)
-#define BP_HIT_SHIFT          6
-#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
-
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint);
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAC0CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvr-00013K-S5; Thu, 18 Jun 2026 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvp-0000oY-I4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvn-0001Ll-SR
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:33:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs0Nc1030375
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5yHXzaYJvyUjrT32bfQgx2x8sTz0bFal6uJwPNkFygU=; b=iM76KZKaGRztQdlA
 3jK5s1TipoQnVOt8jISs0WXaiT+AOKDTv73JyKPTAQh6bWVBAQbNX54w1csRBtNe
 FuhkqvNgdMzBqO0dNgLZtroxxb+FdlijS/tJs1ZvTeA0PIIk/WInQxsi1LIJOxI6
 BimQBY6YjZ/lQZK849//zeu7BGdI9QlTZIxmUx55gM7POFHYmPqyp7fqVGkt8QvG
 AtrbLz3Pz03vkB2aF20X2eR10kwxltAq65nyA4XD/cL4Bt9sQ8bnajnwu6QclisF
 paFwzebgjrnYEz+xv2cWq06SGmPCAMsHQkWIrUxRKpd0u+yn1Qaj76MOmbJM9p1O
 sQzRxg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3cwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:14 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-966a61478ceso274608241.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785993; x=1782390793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yHXzaYJvyUjrT32bfQgx2x8sTz0bFal6uJwPNkFygU=;
 b=BAhsf1oCj6EmQaeHyxC/sVAIakRCROscC0hQcz5C0WGpAEGZ88Po+30uH1mfqgjq+W
 +uNcZuQuKkbO5cX4PRFYeXFvxnYOW1yY54Ypyw8dYeAOqzsvaz9dQyGIoEmwe9BDgUc3
 x1tHVOEsw456m9dY2KIvY1TigpbmZH+/5wo7gBipWIAaWIcEAcCEwoDfBBjhppa1MMgY
 4pc1LMar1oXty8/wMaFs5mCPL3cVHqACSsmE5Dy6UD/mUf1cvHJRqWxAxPT+YJL7TfnR
 97F09ILYz3RtXc3IJjlgQNEnKAV4hgivMfHgfeJthiRqohfX9A/ptPIKjZTJeoubud5b
 +5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785993; x=1782390793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5yHXzaYJvyUjrT32bfQgx2x8sTz0bFal6uJwPNkFygU=;
 b=lmSbaW8O1UGts1UqqGQBgFD/O2f8iWAWy82hEXzIAq5mKebkyCvVHFalmB9llu+9rM
 YXftEURsYzfcSwSdkJm7D8ptQQptt0zQFyh6J8ws8aiBINS/DW8q/vOQQUGWgaMRIvRv
 nXARIAoof9dYFFOsxzkY2eRik/zCcw2XNGJebR62VNGhgw+i1VfpwenKmSj2BQCxUnIV
 cg+bT7JGyeJVUO7WX/txuWgbPdAaj5mCGkvaT8xDqAZdidMaltsQ06PbAw7PmsuJ1Waf
 MovXKkhCX1EprXUYMm3ft9GID5SivDPKuPptMuap/RZke497YtluPYEVD1LTOgb7wjI6
 LEOw==
X-Gm-Message-State: AOJu0YxCxrHzoCcLxEPojBTquGbSZ4kTjmvrePc4FLV9RS4znY/INOTW
 1qp/gPSFf4rzLrrQ50oR2C+uZMJtKbM2ClAhGjmammfUXhEHWM9M/d0I0RpU0ry18xakM5hezDP
 4yI0dzMcb864mUMYbAwMGkkH5OJ1AyGEZzJviTfrCfEik9a4+cHG4LZoFG6JBsd9gRA==
X-Gm-Gg: AfdE7clObcXby/E5v3HmypC6qCX7LLFkuW9eibL5uRo8KOOYenPiuX6UW4nIqsuOo3F
 po7FxJfo+zxi4sFCjNh6UaVRc8P7PVzWRRm8v3pfRAlUhibBgDY39qphdYNviiCtU3NJvqwk5ye
 f4IOA/svLX6xVLGmoUQRfsPtZTqPUdItH2EjpRQMV7otvMKgu60Brk9C9XWErJr1ZnMB1dLZ6oX
 vH5y99j/KKxuFsWiJtK3As7t3Ad7tdYIR252bWW3+puVC44hTWic8VLLS5+Na471tF5y5QfVMSh
 4L9II3idm6pA0wr5OdSDNXHq9oLswxvVLtQbxzW3mzfcVvhbvzOIdjEOapMTbwGSe03i8g1a0bL
 VNYv3CHIcc94gRbsYA//fN6MtZA3l2keKJsxohiL8qIq28OUAE+8jfl7rW5fyDrG096ve
X-Received: by 2002:a05:6102:2b98:b0:71e:1c56:e792 with SMTP id
 ada2fe7eead31-727c4cbd51dmr2076758137.8.1781785993467; 
 Thu, 18 Jun 2026 05:33:13 -0700 (PDT)
X-Received: by 2002:a05:6102:2b98:b0:71e:1c56:e792 with SMTP id
 ada2fe7eead31-727c4cbd51dmr2076736137.8.1781785992929; 
 Thu, 18 Jun 2026 05:33:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4640144c021sm5382769f8f.32.2026.06.18.05.33.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/48] system/memory: Rename cpu_exec_init_all() ->
 machine_memory_init()
Date: Thu, 18 Jun 2026 14:28:16 +0200
Message-ID: <20260618122825.90331-40-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXxrL78xruSBZE
 TAgKtKtnr9/MpxZAHxZ555JGqQzH/aIzPjrR1wNICJ1s6CwsVMecm6vEPf9LoocxqDSRl9fIwNK
 r4qgo08HnhX3vXOWCvMzdJ5K1V0Zdnrg2hB+a2eoGMJuJPsrbvXbyAVxlhODOjjUtk3L2SIPf/s
 PJKi3lfTisLil4M6pSVjsUJIelThpN5d1FghsiVY237MZwnQORd1kIwi04ZgPC3HvX6QzRVEI8m
 A5HJnLOzeuyP+91cMRCQIjzbF1XmKS/T+O+KmxdSksJiM+FdiC77gcJ68gFlhdODyoC7h/6l7tS
 2SJ0AcfWW1zdfh2Mcvq56zZpq9s8EQHDtfEHOSMUmxUQARMoltfsGsao7QyNfYQp8Xnh0P+quml
 X5Py7+9NQyW+qTwUP1qMfV+YZxSpWTzlZTCDFJHafOBvGbdlM5XdMQcRVaEjDibzl58gYxAcT2j
 g8o4FCjJarWkAbXROhg==
X-Proofpoint-ORIG-GUID: 7Xif4O_jKvxirBHl8MVT-owSfXecmcz_
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e58a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=4N88G4Qxp0CkUPUmdhAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7Xif4O_jKvxirBHl8MVT-owSfXecmcz_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX6z1bs2kzL3O2
 bwRIVrS4JwM6jpJPb0sMjykqD8vRws2ijUxtRU+gLJRuql19XSr3Q1yWVu4DG8LYG2uHy3KMlJp
 818m+Gcf0QElJoLC9RKZVwDjCh8iwhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

cpu_exec_init_all() is system specific: it initializes globals
for the memory subsystem. Rename it as machine_memory_init()
and restrict its declaration to 'system/' namespace.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616153754.93545-3-philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 1 -
 system/memory-internal.h  | 2 ++
 system/physmem.c          | 2 +-
 system/vl.c               | 3 ++-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 7eb45a95b6c..a781dba770b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -18,7 +18,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
 
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
diff --git a/system/memory-internal.h b/system/memory-internal.h
index c7573a68b5e..b2b9b5b0c5e 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -14,6 +14,8 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
+void machine_memory_init(void);
+
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
     return fv->dispatch;
diff --git a/system/physmem.c b/system/physmem.c
index 883ac0f314b..9e5b50c5b1c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3592,7 +3592,7 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh)
     }
 }
 
-void cpu_exec_init_all(void)
+void machine_memory_init(void)
 {
     qemu_mutex_init(&ram_list.mutex);
     /* The data structures we set up here depend on knowing the page size,
diff --git a/system/vl.c b/system/vl.c
index dbdd4f22572..1c0da7df293 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -143,6 +143,7 @@
 #include "system/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
+#include "memory-internal.h"
 
 #define MAX_VIRTIO_CONSOLES 1
 
@@ -2217,7 +2218,7 @@ static void qemu_create_machine(QDict *qdict)
         }
     }
 
-    cpu_exec_init_all();
+    machine_memory_init();
 
     /*
      * Get the default machine options from the machine if it is not already
-- 
2.53.0



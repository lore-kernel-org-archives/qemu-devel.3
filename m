Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735BECD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrV-0000Va-Qg; Wed, 17 Jun 2026 13:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqp-0000G9-FZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtql-0006XK-MA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:14:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHEmJC3454428
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c+3G9y9VW8KkifcodrN6+Q0v5CUyAJXSbHbCsBp8pt0=; b=O6Fm56bvHUChbXhS
 1eDs8o80IV+A3MlAJb5IyHeS1I7SLAGBT7QUeu48FMINszlA8knR1c4yzvX97O/0
 zlIWmTWnkh9qzA6rnUe1gCNFbsxTjXrVLsuZ8QXfvskndKANHGBmWhx0NWNjJfIV
 oTkoDoiEfjyye019RdKs/Mmkc9YCGKWhoimf7PDWH1Rqw34QjjOA079puNqGyoCp
 yvPVMTCY3ucKibZ3SHw1uDk0GJ/1UkpoyW0SUXS7oZJm5JIRh5MbFEYFX5PT/2Pf
 BIb4xWu82I9cSATW4c1uYddTBFv6/sCJMj5a+zkr9fKMe6GKLMKIR6d7Iu0RD8jW
 LGirQQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jrppm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:48 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-726a0352f82so21543137.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716488; x=1782321288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+3G9y9VW8KkifcodrN6+Q0v5CUyAJXSbHbCsBp8pt0=;
 b=AVAK2rmOW3e4qTqHjHoa6YpNLboq5EAcQmHnH6WdgEauT7sWw5QP20HWckACkxeFip
 xPAEOjVCcYxvDAtGPRdYIAPSUG8XumYW+KFUPpXgUOZV/K5HmjNtOAsVwT/G3F4txxkz
 /gt/jeMbMpC07V9gE7CoQs8+o24ikWp3p25Ew5M2sXrcxWs3DXWRfykE+y7G5vNBN33X
 0sAN7t4djOtL7YaZFjhHmHjunoTboCWcoH7eytzYHGHhCjr9nQfX2M3xTtEVejklCFK1
 3wYBCfBi+yHjtWwDyh+5q/48sm8dd8g4+3CdigxAFJiCQrSZvRwEQTA3J1Y9ky3vS6U9
 MlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716488; x=1782321288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c+3G9y9VW8KkifcodrN6+Q0v5CUyAJXSbHbCsBp8pt0=;
 b=MXSDqNScq24IYRiU2W178Q+QuOX3KzJFAttD9G/cNCwz9GdqHlTvikRPc5xb/lZMb/
 LC+rBJ4snK2Eucev+SEcEVMKBV07mGPLGsEYzXLZkuI24Fa18+nmEQhsi+jG5NGcISmq
 QIZE5KWktNubvzYKTnj1E/D3zyB7RQuexyCKfBzxJI+AtLSTwxwfh2L2Q7O7YogfsKLZ
 FUhXyeSJjcl19UUz7Eivg9FDei3S/xEaJbBYVCdgSqukfWB0ZAJikTAHZnF7ipSrZ+a3
 wASwcSxM54WzQkVfuhPSEdWwMMdbfJyZqqgd8/fupACUhYEYNQd2v+PfJvN45Zsredv0
 M1bQ==
X-Gm-Message-State: AOJu0Yzrwm3X8Sag2mMNBP1tB8XWWepmgP6U8p2ufxgAp9AD9y9G3mBQ
 0u0+uusnxziUJaVJc77NhBl2S0JcrgD7AekwMKVnKaW+DeN0Jr7LVgIPPR3NDk0e4MKrNUNzf2W
 rneP1qdoxOWWk1J0VlEVm+nqcURC14BlD9FUTpETu5EL1RAmPChyIrvPxD2G/sf7gNg==
X-Gm-Gg: AfdE7cntnMRBp3at8+QyMSIcS3Ema0QZWMYnqf7x5cZBGDtHNx49EQc8aZQ8Lb60lgv
 QEb4LK+XzwvddVZspKpbpPo6k30lNuhZTvkQ+e2tjZHDXZNOTT6qhyrsz5IOqi7FI736iIh5UkG
 4MWZ92XWGcx50LtcYwzpCavfmpvELcUmhd+W5fG4iAdQizbVbU/xYTjK8GynrBNMA8bAqIsSfQq
 0IsRTg92R8wXb8UMwHTUjyvz7nptx7EoHNuhDi1YvKwC1i6q3SxX3z/hmRnd6NKEJOomOy8Lr70
 yi7Dpzhu5uOO7VvpNhpjyDqoBZXAaL9u08AZ8dyZRE3KT3gROybUBee+YITNxxN+X1A9OsPuWVm
 evgAqagXj5U8h8Ed3vbi02KjJjsmPBKDWmHRhKCQ1Ra648UYkuO4usqih/6qR4gl1M7L3
X-Received: by 2002:a05:6102:390a:b0:726:ec78:94fd with SMTP id
 ada2fe7eead31-727c51d656bmr384487137.9.1781716487787; 
 Wed, 17 Jun 2026 10:14:47 -0700 (PDT)
X-Received: by 2002:a05:6102:390a:b0:726:ec78:94fd with SMTP id
 ada2fe7eead31-727c51d656bmr384468137.9.1781716487442; 
 Wed, 17 Jun 2026 10:14:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa3abd0sm201075925e9.1.2026.06.17.10.14.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 01/11] target/arm: Restrict TCG specific headers
Date: Wed, 17 Jun 2026 19:14:28 +0200
Message-ID: <20260617171438.75914-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX13BCdFs2RsKp
 kEFZRZQU/Qa2snYwdTSvLZpYcDGP2ek7qHSvG/sfL7Ku5b0CifM4lhoj1IOe3MyqKkbP1LZ8FIQ
 d6htPX/floky5tIsSBNlGlxKWNTR2qa6FulqyluK2Dw7iBlOdFMO/DyX7NK5Kd2xSibVa/CbbkV
 IcVsh26yjijmKp97xuXWO+8kHqVqGwu3YJuEzIYPO7hHsb+Lzzld0B+NtCpCtW/2ygoOnQwhkcv
 br8hUS3JMStBRGrNNDPSy/0HYO5N0stj84FfwrmuVsXVw7AeomiJoWuQEfYMm7x9HUG6CxKU+0A
 s1VIWjTjgAM/0nrF3kAuinlRj2AYBVC23u3aOQ+LQxaI5eXqQrMEhKmnD6bZs6+Wtv81m+Jy8eS
 eNtKYgHGRCEllTbrBeVG6J4hNPwDnLp0l6A/pCdmW+H0UEXmzmpjmHNj4yLSc0eiiqAuZYV5sje
 SfqDxJYtT0QttB4l00g==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32d608 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 34rdIYnbjbH-KR7YQdS70z8CyNggc_yZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX88wv8WQNrfoU
 qTfVbAyCr4mFvKyjr1MGZv/qw5muO1mEB0gs9WdFXBvGBcK3kb1zIYVN2WXGjiAXpYw4T3H1JNK
 nAmCKhLlCWl6TTwh59Hn9GQA2FVupxQ=
X-Proofpoint-GUID: 34rdIYnbjbH-KR7YQdS70z8CyNggc_yZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170166
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Avoid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 +++-
 target/arm/cpu-irq.c   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index f7a57d3ea70..fcce3804f34 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -29,9 +29,11 @@
 #include "exec/vaddr.h"
 #include "exec/breakpoint.h"
 #include "exec/memop.h"
+#ifdef CONFIG_TCG
 #include "accel/tcg/tb-cpu-state.h"
-#include "hw/core/registerfields.h"
 #include "tcg/tcg-gvec-desc.h"
+#endif
+#include "hw/core/registerfields.h"
 #include "system/memory.h"
 #include "syndrome.h"
 #include "cpu-features.h"
diff --git a/target/arm/cpu-irq.c b/target/arm/cpu-irq.c
index fe514cc93af..883e8a176c3 100644
--- a/target/arm/cpu-irq.c
+++ b/target/arm/cpu-irq.c
@@ -8,10 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "accel/tcg/cpu-ops.h"
 #include "internals.h"
 
 #ifdef CONFIG_TCG
+#include "accel/tcg/cpu-ops.h"
+
 static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int target_el,
                                      unsigned int cur_el, bool secure,
-- 
2.53.0



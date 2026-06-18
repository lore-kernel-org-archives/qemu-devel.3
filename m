Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 905F0CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtq-0003di-NG; Thu, 18 Jun 2026 08:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtp-0003cH-94
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtn-0000lc-Jl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArbsJ1054864
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EeSr3oYrmG5Eoy2J+HNce5ikm8sCvazxJLiAOdvyrBg=; b=HxxYeDtgav3YWhre
 OWVIj5a1TwvRFqfNGj7ykMcv75vKPPCqcOggTc3r08a53xaMvCG4fMCJMV5fP7vd
 OqwNvAtyShFkSFToSZf9El9i1ZdTqM3qljZLe18wKo7qa7nbEkmQSDBuh8AZu5Pa
 cvkqKQZp9+ZoYLHDRwseWBSyNsR68ogvQnK57h+IeQIku5r5Lfoc+GmuZczx9/0D
 nQfNR+WNmP7Di7EV4vwIp8bCeslJRnRxH1+t9WuOKg9Psxt9JyZl2v6ZYTC/IVsV
 IF70BOTdoVV5Kr9i9uiK7ZhLE7QE7Hesbqn9xM6F0FJRHf9VntwHB8+giIdLpUte
 Mg492A==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2ccfg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:09 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-486a2a910efso1769130b6e.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785869; x=1782390669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EeSr3oYrmG5Eoy2J+HNce5ikm8sCvazxJLiAOdvyrBg=;
 b=KF5Jbb+nOEIVrYwG5IsI3IHMqZyB11SHPyrNBct52TJGBVteXNjsh/YnG8xly/denS
 6OwFgUCDqvIp4hhuHaWwcK6QEhmGW3MYi/xl+j5am4NHsjb1lrZ2Zentdemro3bcjgPg
 22cbXjDVbGC35stPUf2CT/c9bPojt84ZYBjiwg5rnQxNwHvRAUo42XE/aFlo183JROaa
 U+vJOfDEVRpNSxpx6PbsxVK2SwUQEm/seY7qpQj+KJk+ifJyva9O7sqZwoBytFweQ6FA
 6UjPjtepk6RHUsD+WkVBYGBZPi+IPjjXsp+ufEzkLcIZwPn+cBJzKt3jwoYTuG7tHVRc
 MErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785869; x=1782390669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EeSr3oYrmG5Eoy2J+HNce5ikm8sCvazxJLiAOdvyrBg=;
 b=YXaWom4nOcz+4wAFjiWfSzRzCDVw6z6CU3ucuwoQHgCGXqVtqac/qMKRRR2A3Nrq9m
 yi90YL66qqshoryexYGNh/lQWY5eDTiP3MD+tF2WocuImoYsioIWKepLQw6l606SM915
 mi62gZ9tuAjvlB1My5m3CE4Vdw66kGusJPNVNJ3RzGYio+hOOEnxo84gXr2wdOKJHnwZ
 /IQ2TgCDN3Ih8gc2ps7Ft7hr2WrzWxpP9Fzixr8nGbjm90F/ezXmHQbsWdTUVFdQtZT3
 Uf3QdAP806Vg7ndR3h0fUFY+txCpzNtp3irjz325Vseak+zTCcdN5VzXB1qVrxf1W/8M
 tX6g==
X-Gm-Message-State: AOJu0Yw+pN2QmK0LIWpIE9ROuwggdd6/ZDhxUhcBkJfVAfWVr+0kYMbX
 +Lm6M/qeZqC85sBXalDOuP5w0bYDKzzGxR+k0XblDajbuGGL1L+X12AhE4gXNWprqYNDUvOpj6H
 qEiomkRSOi4WQOh2MqPx47ycNPxFgexkReVfIHeSFCW98hFvj8Izxx4psA6man6mPUA==
X-Gm-Gg: Acq92OHm/XOG0VS3zfEqNTO4cVMgemRDGNxcD04jnE01coUevEY0hwe/uh8bHp+i5oG
 dS5lHdLzXDrsYwIwu3DNojHMaE8wMI+VZXIXBIG1CskxuQZXKUFppGg1DPPYTVYzNtiWxSZm5Ze
 0exoPNHqHgx1hp0ii9dqpvn3F8ZqQmqzZOvBohl2gh4epRzODSwWQ6fhx58uY3MRgDwaLyV45Tc
 aLIB/Moja38KLndOz49W9hUV0tLA6Rhvh4cllyDyTQZjzj9JHlxoibIB0zNVwBGqCxLtK92/9nW
 Yr4nKteWuWlr2UTpaMZzLQjg0ebaIBQXfOQOJrazt/JY6PxXlPcQiW7ceUJCK85uGKDJYyDRmkP
 e/e6jZS8HbnT3540JiNf5rD84PrpP1AR/wxh/UqNRNRxtOXPxkmRn9gKkN82oNRy2qcET
X-Received: by 2002:a05:6808:c2c5:b0:479:e9d2:26ac with SMTP id
 5614622812f47-489428b51c8mr7254958b6e.16.1781785868789; 
 Thu, 18 Jun 2026 05:31:08 -0700 (PDT)
X-Received: by 2002:a05:6808:c2c5:b0:479:e9d2:26ac with SMTP id
 5614622812f47-489428b51c8mr7254904b6e.16.1781785867799; 
 Thu, 18 Jun 2026 05:31:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa47ce3sm266199185e9.6.2026.06.18.05.31.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/48] target/arm: Restrict TCG specific headers
Date: Thu, 18 Jun 2026 14:27:59 +0200
Message-ID: <20260618122825.90331-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+6LV4hudqq9Q
 vi2XJksUsyt7QTW2b62Wwg8uA4lah3cgSk9TqqCaaMb9viLW0eGT08Uq1FQ4z54ZcFt2uRBUyGg
 hQzv0CqiRZTKzWkxggEiv0aghicRbej/Km7FNhQ9+1szIm3N5dx5c2tDwzaV+SOIYPePG5GHtcD
 YkwL0JD3DzCLCu6JkGr7Y/VduDl/7WAcvtKiIh68J89HzfNxMPdGryY7hzSMiwiydxa0iSTxuZy
 gfAILLAloTS5YzotbdMd+s/9+AUs0iied++WVWGcvLaLKqGW4uu5Aaoy/c/bkq+ePhHZ/Q1VVfD
 CWErOl5y5W3CKa635BPk3Ytj/I0irw8SdJ0h5bqmZ0l32SutWu4NT2apKUcdhLW+aG5Er5be92P
 cVVrxKl6r+rB12HklnhXv1okcJyly5TqIKuQe5bcGbulwuzSV6JpGZWlq5mPbZ3qoMGUCFX+saT
 J8dyYiD44R0l+SZPmDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX4SFelUzLF112
 WoxLasgyqeDgWqy7P/TbxhLWI2AKgNCMbz5xEvrA0DnVQk0gsluwoe5chyg3hgDRIjLs1PQZLfC
 pag1oMaZNiHl5iXXTVsEBylLdxYoXnQ=
X-Proofpoint-GUID: ULUX01ElwlU9V9qF3Hn8H_rH76jQUGy4
X-Proofpoint-ORIG-GUID: ULUX01ElwlU9V9qF3Hn8H_rH76jQUGy4
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a33e50d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

Avoid including TCG-specific headers in non-TCG builds.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-2-philmd@oss.qualcomm.com>
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



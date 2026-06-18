Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789E2CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtx-0003oj-7T; Thu, 18 Jun 2026 08:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtv-0003k8-Qo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtu-0000mp-1w
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs2jM1030554
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3tRm5b2v+F9s6iDGpxMlcdbb4IGu9fnQ71UD6xkJ5nE=; b=C2/UCV62rtDhNTxS
 BRF1uw4QYH3go25fxJ1pC6Rqj/kXcnKbNS1P02nYwqRjlfSSJ1AIcXg9o4BM7OA7
 QPd7FUohOBsV8ITyiMKkGg36QsoSc4GwG2ELg5V34sOGsP4jWuE8zHl8esw72CmX
 9MpRt1iqGDnLwo1JvDSXxM4mgxexdHubabbY5E0DWQ6w7KmIMXjFJKrK5wkeQgag
 F5su6tvPOHYFazEqSqryfGhpwmjXdd6GRP2uxF6/AGaaLhR58OEQs4fxNYNibZnJ
 Bm55FsIsgRWZ5HgpmYKzrFs+P87Vr5/ta/v48xDCK3/kMQNqRIU9AuexcXm61570
 f+rtTA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm3cpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:16 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-48687df43c4so1917514b6e.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785876; x=1782390676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3tRm5b2v+F9s6iDGpxMlcdbb4IGu9fnQ71UD6xkJ5nE=;
 b=h+sKch5S/0J2cYfEj8YxBhAHvLx3wg14lQwzhbEUYUbHjVhSlIfJgfRuw0o8ZYT9cK
 QTkc5k7sFv4B5NzV9lD5p6F+lqs2Ac3brZo127ZQQ5BU6u04Yv8karTbN0i2GQy3bfWx
 PfPs+jLT/cVvPKHo0Q/lZz3XIo5qmXGQMNqIigaFDe1ttCGun+W9S0bOx2UOflKSHfvJ
 RkybAZkM6is+rcimAEK88okItUkD+ZG6YyPa0n0pjp69iqadXuzjMp/Ry7phlItd6JQx
 HEOK4JnTmlXlg7aNY6bedM9ic7YMuPPiUOUBVYMuRaxN/Uqo9APTryrA9q0j+/wcU6qU
 WRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785876; x=1782390676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3tRm5b2v+F9s6iDGpxMlcdbb4IGu9fnQ71UD6xkJ5nE=;
 b=SbBkduCKzXRYN35Y7Rf7z+yK4ds4K1bFHxjhD68OTUyDWPWnoBf8Nqb+8VBCqDmdRv
 SKT0oB9GMRRmxbBVx2zmVqki57ovY+45PPAK75n9Zl3pms2jChvjkmQYsmDGldCJjZBK
 R22BH19fOfhYypOf/73ZQcuKMBAnIv1xlc9OOr/3SQzhwq6AY7vu3tkJfqy1R2TFdV7B
 J2EAYjYMW0+jRCqspCEfTEkX7h8kzTiH2uVqa/PcYVvt3HuuEvbpPYbYWMGlvkrAe11D
 lstLCiPMd3tCc4A8aPZ5J0iq5RTne06jk134vHlaUaLbtM4u4O4MXDBGaSP+5/U6ChD8
 NiOw==
X-Gm-Message-State: AOJu0Yz7lbTgQeZwZL65jKNkSlmJUyIn39WTjkBJ1tKzFby+t276Eggt
 vIVwDSisoEY/WWgRwawNQDnTH+dBHo4QkRQgfP74jGeSAqbfVqAzuABw2NGcaHp2BwP1yLGtYur
 pg/FhAmoWPYQNaIyCQIJq/zqGUrBBBW71PjvPH4Ar2tVvovI0+CL//wOm5GtCrdpkRQ==
X-Gm-Gg: Acq92OFH2/TGEQmQ06TUEwWkq7uGM+eUw43tYZojfQsfSTec6ZyGAGrxy7n9mdYHfAE
 zG1DNj5gr9Ai7dRNOx3/hO9WH0rzD3UZEwIm6GpJkmc6M7xCgatfNHQnCYPEwyaS8in5EOI5Xc5
 qbHMJHFuvF59bXQYHsniz2aNaR9f0TUfopns2Y+JxAmznTAHiz/jEXOXQNp/DSUmIEO1O+B8jVk
 msbD+Czl47Lm92oq5+q0KWKvZXrFOPyIf7aDX8OhCYwXUaEnXuAGw3T22UcxqSXJzpSz5oCIYtl
 L/NMMLYKWT+Z2TExy75tEGEkC+i0rFPlUNV84Fa02W8hwEc0TNzxK17M/OGxY8xVWLPoBHhJWpD
 md+qzvdhzA1r46PfFrcBmmflMTSHhrLPa8bTnMmVDHHC600nKLXNAi6q2ueTo+7W0dq6W
X-Received: by 2002:a05:6808:3442:b0:486:7c50:6fa8 with SMTP id
 5614622812f47-4895d24635cmr1909993b6e.24.1781785875607; 
 Thu, 18 Jun 2026 05:31:15 -0700 (PDT)
X-Received: by 2002:a05:6808:3442:b0:486:7c50:6fa8 with SMTP id
 5614622812f47-4895d24635cmr1909965b6e.24.1781785875154; 
 Thu, 18 Jun 2026 05:31:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm230504555e9.14.2026.06.18.05.31.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:31:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/48] target/ppc: Restrict TCGTBCPUState to TCG
Date: Thu, 18 Jun 2026 14:28:00 +0200
Message-ID: <20260618122825.90331-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXyN3YkEWGtE/f
 vb0G3u71ib/HpZJ0CDEn+x742LG2dXLW6SzH8oPS1FNT7Q2Zz1/tjFzEuSqoQR43BRB7ljWqWRn
 r72r6iOGGhOBp4qlX+ikVl1kao9xxb7XkJqfQlE80BK10hx2DEV1zcUmQUoo7QLxbzuaJmQ0egw
 OS/V5CYNGx7AHKF6kAWh7UTJLNTikQ7W2EQUQDNsCLPBrZDQfzqtLzTNhhndSTyn6CW9maDKXZh
 cLwIQGcj+M70ZHVVpO9+RWHN4jAREVt7avJLQD0zmywtF4eN6AphvZqR7mX59kl+9kX70bO3sVp
 fNSwPvtVfmReSKK18gNhunGhovazYfyAG6EQHw7CiWz6QYugTwdqAId6nK1d/qPKCMKYnVm+7jD
 DWri5MU50ONlujPUDQIWa7OkSXdXQEVZkSqALMzXBO164YJWg/tUp++rfGLTsC/1/y8lJwNgVH3
 JebKrRwBrqlSp1kwjCg==
X-Proofpoint-ORIG-GUID: Hq1R5nfXx07VQYWxU24yAVZxPnTSj2tP
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a33e514 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Hq1R5nfXx07VQYWxU24yAVZxPnTSj2tP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+vnkFgdvKpKo
 oLNjnaeIBsimI1Z/lTo5NnwaliHkcyd1atHAP5JFWIhoidfdXrzZLCJh5FSv24iyxDAne0ftUEw
 z7fAOJLIXdzCAGHkib1RwsfgKcYVl28=
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

TCGTBCPUState is a structure used during TCG translation,
therefore not needed when TCG is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616153432.92939-4-philmd@oss.qualcomm.com>
---
 target/ppc/internal.h    | 5 ++++-
 target/ppc/helper_regs.c | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index dda23b66096..a3bb12afd93 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -22,7 +22,6 @@
 #include "exec/memop.h"
 #include "hw/core/registerfields.h"
 #include "exec/page-protection.h"
-#include "accel/tcg/tb-cpu-state.h"
 
 static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 {
@@ -326,6 +325,10 @@ static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
     return msk;
 }
 
+#ifdef CONFIG_TCG
+#include "accel/tcg/tb-cpu-state.h"
+
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
+#endif
 
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index a07e6a7b7b6..acf74c543a1 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -27,7 +27,6 @@
 #include "power8-pmu.h"
 #include "cpu-models.h"
 #include "spr_common.h"
-#include "accel/tcg/cpu-ops.h"
 #include "internal.h"
 
 /* Swap temporary saved registers with GPRs */
@@ -261,6 +260,7 @@ void hreg_update_pmu_hflags(CPUPPCState *env)
     env->hflags |= hreg_compute_pmu_hflags_value(env);
 }
 
+#ifdef CONFIG_TCG
 TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
 {
     CPUPPCState *env = cpu_env(cs);
@@ -277,6 +277,7 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs)
 
     return (TCGTBCPUState){ .pc = env->nip, .flags = hflags_current };
 }
+#endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
 void cpu_interrupt_exittb(CPUState *cs)
-- 
2.53.0



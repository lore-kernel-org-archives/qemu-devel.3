Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786FACD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZIO-0001jS-Kb; Tue, 16 Jun 2026 15:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIL-0001Ju-KH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZIJ-0004ke-S9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIPDLc173829
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6I90FZKzeXxQeHa4NO1mSr3S6KLKHal2UGWPSx8REB8=; b=lpTuemNkiKz2VpuA
 XhPVVUk3JOtorErMVSAZuToZ2Lr9MaZSVe1/aqBrzoPoCHyruep3kH5J0YOEaPxW
 I6HXo1Ngl7C1tlP7jpRi+2G8rzV+K64LP9TV5oXGFduLMgJnNhEOaBK1SJbskBQJ
 FGPbWPkm8UU2TT9RmvrL+uBsp2xiHDkMhSrc4bMGBo+JhDum+vqYXUDSzlwuNti4
 qHG0ioc/uIhR1/ftlIfIA5FzOhrxS5P2nMqb10rERSoFpVvI02ulQaMk2PE2n4dT
 C61OA0/4rCByE7qk87/xd5+BuMwrckAPF/2Sa2vKKhBV4SB1jbDJGpSsVmzM2Hvb
 jwTY0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kbqp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157f1be083so826281585a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637474; x=1782242274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6I90FZKzeXxQeHa4NO1mSr3S6KLKHal2UGWPSx8REB8=;
 b=BIhkQdmv17f6QmI4DPnYtdhiHCdC220+pkFqRJcVCfK+kWtzpUmV4IpHL6roIPWj90
 jTljeN2ZSblg0eDI3xgr3+ntdneDu/IJZN4wjOC9fq/BvYqOh3sjbibVCArqtyBPII6t
 nsjO0Rv0b1b6u2u7DdTh3XJ0YlKML+gPyX34VXJtk+xs+EgSLRmNcXbm2cdHmMiKRBQH
 hdp9hjoXzNvsWwzfgYPiZPETHudjGggXK1fuZudobEkcf5fGilrCXX0Ep0/I8/yDabxC
 O7SpgB9sKxJE20YFCXN516zQcMKXIBgnbhWAEsyc6//VCF2fSEdQzU/jcXD+6OHjCsEl
 19kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637474; x=1782242274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6I90FZKzeXxQeHa4NO1mSr3S6KLKHal2UGWPSx8REB8=;
 b=ErvwdbDRtr/WzyusZFA5jRxjJ64+eIKLQjHPbG5/4zitRf0ofRZgyHjJq3nOvLa7FX
 lp2czkhykLSUdyf1i+6JfKrZlluPxIu4om3wxyNFzjJ/BKdqfRDm43CzCV7cR+E5OH1j
 2w9bG8BV/wWHWIVAUrQMl1s6UknSZ9C11shyV6+EO14z9fIAjIzYW8cVYlrshpUXaqME
 6TUy/MrQZQa17UgRc0i1wbwll0fgJnxNEq5HXo+h7/UxZW5XJnAkzH85wTadVIN3rw/E
 xbTT0DnyqtEZX1nz3p3OzLKZ4MNWQU+QY/XAeazlZD00Pgth6WE/FFp36Q7fsqqi+/fL
 D3cw==
X-Gm-Message-State: AOJu0Yz3X1LnqURcaopVFi/9YfUKjlINVTBV3UioDrQwQ6YuxHEcp/Uc
 1xkcVJPzEKCE7Czll4dul4/JWfaycF3Qq6yOUXb1MjwXOA3DhKwwEc09tMZDSg+qndvygliUXno
 XJ7v51l8wW+uccTm10aroBzGJoJqOa1zWfwM8f3x6Zfldyt6TW+N9FqY9KvrlOpRSGA==
X-Gm-Gg: Acq92OGPOa6TDqSxhuLDlYQWgp0yqkhbCNZAoVzxPPNLhOpyeymmqzaJ6A/X4XwamRb
 80/+V6E6NBryGn6Nw4MSdDhykDy7gw2Rf2dmNrrm4crcQ0hIq12O+xL/rAfW2TN4hxjQEV+LXay
 tKCcI2WYPq/y2ZgnO9JdlsnQSTk83bwBfY82KOmAtO+njHQX0SlU9LMVqhcOmQEXa4PpChcaNP4
 3lBPcOfXsZcL0Rmw+oXn+13zumNvyH0tTaLGt/jgDtVSJZSOx2hrTpjCwKVdkZr2rGJhoGCR9vw
 30LQSjR4siIfKrCT6eHGzh+tIPqzPq/OAqCwZXwBnbkUahj+UMxaRwlewvSkZBA/rw7ITyXJ2vO
 uCzG8Ef7K7C/g613IxiiywvnRaKLJau+pQKeEiAn880MUYu4rg8ZpEqIU10pUjcKpYAcCW/HXLx
 1nm7c=
X-Received: by 2002:a05:620a:4148:b0:915:94c7:5841 with SMTP id
 af79cd13be357-91d88b50195mr188423485a.12.1781637473725; 
 Tue, 16 Jun 2026 12:17:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4148:b0:915:94c7:5841 with SMTP id
 af79cd13be357-91d88b50195mr188418085a.12.1781637473314; 
 Tue, 16 Jun 2026 12:17:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233434c66sm8085735e9.0.2026.06.16.12.17.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/10] accel/tcg: Move cpu_exec_step_atomic() out of
 'exec/cpu-common.h'
Date: Tue, 16 Jun 2026 21:17:11 +0200
Message-ID: <20260616191716.12932-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX+H0W6xb+sBHh
 qWID28TLvOhqDH1X9t53BVTJNkXiQjvvysRrEu3+OyzMhcXhvkhBaSMUKKIGT8EZG7mBGlZiJzf
 /KsBIPzOpw3r4dc8Ga0nPui0gPlPVjo=
X-Proofpoint-GUID: vIV9JLMRhjVaqaqqREY1F47i3aD8doFV
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a31a162 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Rbkf6VTxm-UGKecmB1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: vIV9JLMRhjVaqaqqREY1F47i3aD8doFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX2zupyYDkRoAs
 6CLCNDQa/yhJZEj40jcfvYJfA7Wng9tIXQdjE7LV+Dksq/uQph6sBkFlIU3x5rti6h6Rd+eCOuw
 ppqaLSy4czN6YfNPZNfUnQGDzy2HrhynZqv6eQpsYh7xvlGTMcgQ3Hxc8VjKYgnW8WJCg8me3gd
 ieiw9MjcTVOa7Fqn+T5lpU9nPEAOBBZYhNzaDco/6I4OsS+xn7AThWiC53zttjZ8ZZn/i1xLSr+
 k5MdA9TeEzx/j19xX3qGtIFgZ9TKBYe69hNl9rDohshHklQj9bvPDqERW2+bAh9RzAc6IG+oaEe
 b8Mf2T1L93MfS+Bo8XrCxtrmu0OeOaqVR2IQoU0FEJVHzPyQXnKVppc9K0ubHumwkAl9FyIiYO5
 Mvcw6CkdONuO896XZ+KCpevHxDATRyEsy/nhJWbX55O0krWk6pGPCUchz2EP9OI6Frk2rSX4UOU
 g3B2qmImOZA5tzvnUZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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

Move the TCG-specific cpu_exec_step_atomic() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-loop.h    | 2 ++
 include/exec/cpu-common.h       | 2 --
 accel/tcg/tcg-accel-ops-mttcg.c | 1 +
 accel/tcg/tcg-accel-ops-rr.c    | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 528adb5588c..d8a5f98f9cf 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -13,4 +13,6 @@
  */
 int cpu_exec(CPUState *cpu);
 
+void cpu_exec_step_atomic(CPUState *cpu);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index ac3ab0e1cdf..ea9a49a1435 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -21,8 +21,6 @@
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
 
-void cpu_exec_step_atomic(CPUState *cpu);
-
 #define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size())
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4160e2ba947..69560fdb9d8 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "hw/core/boards.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f84342e0449..5b132d3d5d8 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -32,6 +32,7 @@
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-rr.h"
-- 
2.53.0



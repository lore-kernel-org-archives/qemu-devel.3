Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81E2C44501
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguL-0004sJ-JX; Fri, 03 Jul 2026 12:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguJ-0004qc-LX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguG-0007jP-OX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIY55446274
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=; b=iYt6ErQIrXdi5tPE
 sCHhgbphy8rn83Y9MGjZlqiYPb3b47l5asHLvP5LKtjgsFldMX5vQ8Oa9mnJJEX8
 B9NNSxrWa/HE74EdKDEmimroP6DvMonse9qSj3SuzX5ZBoft8jepY5FqRuA0Iyx6
 kWM9VlosA0etVgqE9ZDjP3srPnJUZ5uxzmJrejKze//Hk/D4bgpFw2rs+jtZxuLR
 cc8VnoqYpdDHAijmRDCp9TZvwM+wdy2+kS7nu1ZucR0+AJc4D4GRPA1atSMtKbvH
 cL/TlNDZ1XXZEKd5Qye903AsxNOWxeybqE67C3c4/jNh3PDGkBRBRkq7KRj7w6ZT
 s1cGcg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b039eer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915f6ff639aso130128285a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096703; x=1783701503; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=;
 b=A2cPsnyYrnImvfmK5rm7tLFKB3ykwEzn3ZyUl0WcTaF5TdfxzFnKUxfC4erSVCXqkH
 /2BpRcClMmL+k5KjHCPzO4DHbLCqO6B5uiZWEIUFYXQZ04zfvs1FChTrLLBC+1GO8qTP
 9gJwJsnU8jw0/N0KrDowkeCN4AFqKQRa5DdnOYQOqdQzxqo28HP631cYVHa0uPj/ac6I
 syiSz0Gj73D/lk3Us0MmmLuS1J8H0V5HhZHypk6v5VrVxv++6iKt1eyUiOFUGTMC2uSN
 VLD9D+dkDSw+D3ty8tlomgHIdXXBvgb43ygJFqpmV3O4qgyQuNltzotHstL4COr5W0mP
 t2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096703; x=1783701503;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=risRiSv+UEPHcL2LbSldgAbZS/KE/1C0HcsdRJ7pmvw=;
 b=AADainbaz7hbS8bSphs4sHjIyQpujoIp9S7OqbBWb9GKaEKkYTV7ki3J2uVacvqQ3S
 uD7rP8Vu8fbxnVNv6l6CDkPYw5c0TzDktq3Vy1XPGrWfldw+go5TgsVXVpXrx0Ui13S2
 AJhSKsZP55QaK1ytkJK9xaDpeJHAxeq52z4CXQZq3Jz2DZljMHWI856aA2BWaxd0gyj8
 60zcHc9Uy9OUsOB3MSNpo/VN5TzGLVdji2F7HntpvXF7fkzoaGXyqthZzIzHCxArGUiw
 y9uWMA0C01AUB+5/QayTjfyKgf7E6Y7RkF5PJXvKMlSyf1+KbgT0rw9u0nKgZmPvyCEB
 8X2w==
X-Gm-Message-State: AOJu0YwHllNCbeOetL72UXVannJnZ8BErQQFjF9y15fXSI1NwHQAvOPg
 ZkwfpDZyLxllYqcqw0YshrABDTDMTgzlbwmDVDZFVcJAMSly2+VQkH+nKCQiI/keAwrYSXD4xls
 ZTHKnay9+j8J1+oOzzHUjbP9BaWRi9/SOKoeGOu4wJtBNe3nUVsLUyLyfx463YxiH8Q==
X-Gm-Gg: AfdE7ckqrZyT3qctIGY+E26+42w6j5V1TGZ0I6pMDOY+6idEV5FkhpmAMcJiYmA//t0
 zf7NhvP5S+qNWvn3JSZY2kk4+7vO1Fa18WSlHmzhQPt03RlZOkyaOOKSeIeI7/ohA5fAgTvFZQm
 1TferUaxWZqdPFP1frWthnGxx5v7eqByI8OJSxcFp47+1TuS7+YlVXtQa7x2LdeyrMmk64FS5Jb
 /BmkaDTvlq9GlUYIKiNvOGt7j+q8I2t/qUheYlZ4ElclqBL9aslJnclLc2K1VHsnxNkamJaM8ox
 ThPcdCIjE6HOej2GmBB1LKPVpwIyx1lWR5h5b0Tj6wPQ772SVuHxJLLayQB+svdniNMwKPCVJA8
 OcpCA7fRlerFqU8bzwj9VUDXpVmFz6TMMYhzI4fnY8cdzxTKqCKR2R4l6pJmowi3Wyuk5
X-Received: by 2002:a05:620a:43a8:b0:92e:7f13:1489 with SMTP id
 af79cd13be357-92e9a2f76eemr29525085a.10.1783096702986; 
 Fri, 03 Jul 2026 09:38:22 -0700 (PDT)
X-Received: by 2002:a05:620a:43a8:b0:92e:7f13:1489 with SMTP id
 af79cd13be357-92e9a2f76eemr29520885a.10.1783096702606; 
 Fri, 03 Jul 2026 09:38:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cfb6f199sm35906175e9.3.2026.07.03.09.38.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:22 -0700 (PDT)
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
Subject: [PATCH v2 03/33] accel/tcg: Restrict tlb_protect/unprotect_code() to
 TCG
Date: Fri,  3 Jul 2026 18:37:26 +0200
Message-ID: <20260703163757.55500-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXwx+Mrw0U2UJC
 NcCPGYFLYpGyPTLrK605CAcAD3yt8AyUJPo4qK4MV4xtBhWCPZrycRH0CzeLLf0ImnMN1y/yl0d
 5i1tYlovR5oE/WuqSiKE8Z2Rn9ti9xs=
X-Proofpoint-GUID: RRCMYex8IORMBToj2-RgA7Y87ZAIZNcD
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47e57f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=glojBnVPa3CR4aLdIrwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX1MHyy+ADiZFT
 W8Cr6+oaX2f010Zm7WGM3f2n3GroM83EA2ZWkbROv8+1d1KvmoAsUZdsru7B7YyKCgIZdlgY99x
 OUTJzOxQmtfhpMqydl57M5rJ3PeskceuvMLU5vxAhdc1lKCDIsqh90jXlwjRrNDTkypIRyjA0B4
 oSgXfX2LY3OwqJ//8+Z7vs9H3rxaHEda21U2GmmTCuAvnIaUuraPuJ5PGb8P7/ILfMq2jv76Eix
 8X7WtqEC4kSPK/UwL9MkqaGpMeWeZAeRNVlhbVwnTfKb3bm9UEAD5+P/6fvAdgJ5m7Shn4kE6wd
 v05sS9Iw1l5uDpABr/Mx4zoBrgE/kyWS7n/gLQY6j7hEBMeGjMQ3CChurhVU4Zg23xaFR0YWJqs
 H84BNkscEb8VejXeHEbBZ+MgWlbKQn2eZKy28QmAWSz8Qn+Jjbwdxji278Pz4BMpdiD9p1xNOxv
 sESrU5oGpgH+cF6WXfQ==
X-Proofpoint-ORIG-GUID: RRCMYex8IORMBToj2-RgA7Y87ZAIZNcD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
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

Both tlb_protect() and tlb_unprotect_code() are only used
within accel/tcg/. Avoid exposing them to the whole code base,
declare them in a new "system-page-protection.h" local header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 accel/tcg/system-page-protection.h | 17 +++++++++++++++++
 include/exec/cputlb.h              |  8 ++------
 accel/tcg/cputlb.c                 |  3 ++-
 accel/tcg/tb-maint.c               |  1 +
 4 files changed, 22 insertions(+), 7 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

diff --git a/accel/tcg/system-page-protection.h b/accel/tcg/system-page-protection.h
new file mode 100644
index 00000000000..52896c6d24a
--- /dev/null
+++ b/accel/tcg/system-page-protection.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU page protection (system emulation)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef SYSTEM_PAGE_PROTECTION_H
+#define SYSTEM_PAGE_PROTECTION_H
+
+#include "system/ram_addr.h"
+
+void tlb_protect_code(ram_addr_t ram_addr);
+void tlb_unprotect_code(ram_addr_t ram_addr);
+
+#endif
+
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 3a9603a6965..f7f7020382d 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -24,14 +24,10 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/vaddr.h"
-#include "system/ram_addr.h"
-
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-void tlb_protect_code(ram_addr_t ram_addr);
-void tlb_unprotect_code(ram_addr_t ram_addr);
-#endif
 
 #ifndef CONFIG_USER_ONLY
+#include "system/ram_addr.h"
+
 void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6e66f3c6e93..7f7c208ba12 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1,5 +1,5 @@
 /*
- *  Common CPU TLB handling
+ *  Common CPU TLB handling (system emulation)
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -47,6 +47,7 @@
 #include "tb-hash.h"
 #include "tlb-bounds.h"
 #include "internal-common.h"
+#include "system-page-protection.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c33dbf65e7f..4313864d2c5 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -38,6 +38,7 @@
 #include "user/page-protection.h"
 #define runstate_is_running()  true
 #else
+#include "system-page-protection.h"
 #include "system/runstate.h"
 #endif
 #include "trace.h"
-- 
2.53.0



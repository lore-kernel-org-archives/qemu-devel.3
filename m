Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7945CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVoc-0001SJ-D7; Tue, 16 Jun 2026 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoa-0001QQ-0F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoY-0004zU-7q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxcFA3432049
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xeu8tBqbijTrsroTzP2ZlpdNk1D/p74BXzHdUiyh+qs=; b=E+5IKGA2lzwhmNYO
 CsfkzZztk7xWYJW47qpO4Y/toe22s06V21aWReCQm+IUdfrWu/+QudpKv595NSg7
 SrovKzNfAaijxWwH1I9Lsqdggbbt9EH4L4tmok0R9hZJVbPYNL2pJ+H61UQ9hZlB
 W+j0TjjLPCVuulI6RnqPxk6vRcBK2wmvwqsRMgY56JSyk8boXxS9PCs7c/0mOIWV
 O1jB6eiQ4czYvcW+mV3ZV6dfPwryKVR92Z3hZgXXzbDquFr700vm6BnHNdrX4B1j
 xc8rKBKx5sklLWewqq0+SHGcRrBv38iVDiajUFQNU4HVs9+Y62/qKjqpik6FbNxQ
 gtS0VQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1762dre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:56 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b73b3920so5559776a34.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624096; x=1782228896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xeu8tBqbijTrsroTzP2ZlpdNk1D/p74BXzHdUiyh+qs=;
 b=JRb/kUk3G47m5F1hC23QBeY0FX4MePyk7CY9pYG9EhmhYahIjfbG0TInFep38g/Zc5
 XLQLunlDKWJpjTpxK1ml+OS2p9RZaGCsZlAx3ri7gIshCX35LnarBywcrMBMHGaGorQu
 WSSZcq6Kr9oL5rUbooC45cRfwa1OwrlUfuV7avgYqNNVJG3x9bJeQ21SR7Dqx9SRh69Q
 G2I64VUVWSe/E/9UMKbaxrF7GSj10V6fHvETUljApyW1cr2/2Mileobnd3fVIt+hAKr9
 mQCQgF1cNsKbZ5cFFTPDhVaUM2uoK6sCpQbvN2MhXCRa2uu9KZoPzPfLu1dsgiODHap5
 MgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624096; x=1782228896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xeu8tBqbijTrsroTzP2ZlpdNk1D/p74BXzHdUiyh+qs=;
 b=sKQGaxdpib6xT2WhMFbPkN53fRdSITS7K5iAc21c6jtGiSdq1l3HSJgXQkY9SffGe+
 1Gz1B8qE/Z7OhGwvs/Vu+GZIu4uEzx7uxXgMCfV3Xgqfjb00ay81pkOwMDWLGqGcKM7B
 gWHXAkMMVk17mrbhZNu6JmD5/6MwONq38jIc3LIj5pygszaZwmllBxRUABwDF80bBiY9
 ZJkveKJhCViyVuavBq3bWqlAJ3gbY/RhAQ4BIya6lkcKghUnbVCsrTyA5WYmoQOqyuHF
 ZQtU234HDYJDpnuIuZTpnJUVug83Iqvi+r+/qHODGKZAzO91Uj5UekuYd7OZIK19dSoE
 FlRA==
X-Gm-Message-State: AOJu0Yw5vuowEJkdgTvPAcwNb5e4SbQwbxlAkk0YNnk5xLNl8h0XjmeK
 jmmi4v9P9Acjbg/Ovs9bJhsDc+Wn0ad2TJI5ll+yj0+6e2E2iFj8n+T05FRgyPX7LE/5e7bbG1/
 Fd95JWAY6vgI1P9B2ughfNarRYqEAsMmMuTDd719cQ6xrwGx4YHqwvI0KbrrIeSo1TA==
X-Gm-Gg: Acq92OE2oywZ/NqnhW8dHBt8n828DkswQvw0EvSCZyCVANenQD0wQ5elnqSoEHKVacF
 rYiTuhkRl9HTVFTXH7/NXPIGtup1UhCPjBA16L9QTtCc2bt5PhCYZzW3Ap4psBOf0igHz9OJfJy
 FeRIz9ZPUn38bhbRGol9C/246ZAwK/NdM6mIVxMpIbsyVl3b1eE/hpnnGiXuUZibZovNMq1t5Cl
 ALm4r7mC+aDhPTr/QESLQk64RH+h5K93Xhi4uwswmM/sBvwTivGrtPWpycvRebLgdvCNWCmT5hV
 gFoCmiZUuFwgI9Ca5FgseSCgJqM855a9U/thxmVB0EzyNBwP7lo84FQfmqmkDA28IFvsrgMLcpG
 S6Z0BZqPIAbnukj0rghIQbrW9rI4C9nOO9zvH2uqSmuxrzJm9FZYgTtjLl3u4F65X7v0Nsd5xb7
 q7VaQ=
X-Received: by 2002:a05:6820:807:b0:69e:2cb4:2ed8 with SMTP id
 006d021491bc7-69eec9d8ea9mr8552608eaf.26.1781624095980; 
 Tue, 16 Jun 2026 08:34:55 -0700 (PDT)
X-Received: by 2002:a05:6820:807:b0:69e:2cb4:2ed8 with SMTP id
 006d021491bc7-69eec9d8ea9mr8552587eaf.26.1781624095564; 
 Tue, 16 Jun 2026 08:34:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm40578196f8f.25.2026.06.16.08.34.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:34:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 3/5] target/ppc: Restrict TCGTBCPUState to TCG
Date: Tue, 16 Jun 2026 17:34:29 +0200
Message-ID: <20260616153432.92939-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153432.92939-1-philmd@oss.qualcomm.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: drL4Ug6ypWopuC-8Kbqc0sSvT7_nK4CU
X-Proofpoint-ORIG-GUID: drL4Ug6ypWopuC-8Kbqc0sSvT7_nK4CU
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a316d20 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=HPnlhGH_Al5Q2uv1BhQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX7BQOsh4cUpN5
 12SGcLplhfwnADtxcORtwDw/G3Yu9m4ZF2D/WcEunBHcYj/suhHOLl5dcG8lCQtXV9LU94yzHc7
 ngSPeo8Xs7l24UnLMTz8ZZMwkEvOWVA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfXxFQBYZreem7p
 iC+wtFtddaOqd/ZpBYlEYgkaKNW7fpk+SD1HxYSUeOzPiFQnFYCdiH5EN2EddeKbKiqsQVm7WhW
 bz4DyoJk/klj8kc84FPAxd69Ix0rYcncxlhQP+nzRwvEehBfhRrZYKu/YhQR1m4GaP4DmagaXFT
 NM1y/Z53L/yWGfPPHDnnstjI75sltDbPVZbIDaXID+An61phX87I+BCXhQzJAIsL6AQ9Kl9KCYP
 e+8Dqsekp8sXTN9Yy7QJu+rsuo86TeDBhWEc4aG00HDkwkdS3wwPi3KIXfv13yw+aw8s/Vt28rz
 uJJ3Vg1bxbx4VYrEkugEBK5CKrTe9cIoAvOEd3M0SulM2GoZs5aigH72KKgz/P/oLaA21vYokmf
 ziuZLMzaoabIm+uNbVu3J8PGtmEsQM3Phr1gWfvGpzDrXTSzcIQo0WppSMV9/FaUAmiYy+DSZS+
 barm+XUjlc/xdguZHZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
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



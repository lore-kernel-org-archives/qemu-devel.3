Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF10CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByNU-0006gJ-7L; Wed, 30 Sep 2026 13:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNS-0006fD-8X
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByNQ-00016w-Nj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:45:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfdcB3785243
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PBc1D2oz+JV1vmUOlpvPkS3S0H2UGK2jXUvplCDqDjM=; b=EAdZKoyLVYJ8HKfB
 TmfIrYRVvA68Bq5zCdXvaY/qlkeVa2O/BfAdM7FjOfml5bgvnV+LPbPV/PO86JIF
 V7yYZm2YQXJO112gfQJ5SHJ/qh1BYbxQubVCBjza9uSBMRzJy4lHS0h/uA6OFXam
 KNnWm2a+gW6rqXlGx/5NMEV3r15pWEqQ+3DszGC6UXBP/JIl8LNzBwxb29h69owA
 lyHYhY4dw7f7K/OCSwZ3j38UFNbuPg3IDxU3IhI6YabffOIwOLW3MaZZ42r6AvOT
 XhUhteCGgSnToKcZp9P9icM/3il2aZqcaLGZSEECyWicjkaKI1pcjtkvvwmb2Sdb
 TmcePg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn3pr6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:45:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb6391e89so23257685a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790354; x=1791395154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBc1D2oz+JV1vmUOlpvPkS3S0H2UGK2jXUvplCDqDjM=;
 b=B0zoBlhq4YqrYKsLsdiQrioIi6hQfwFaGi3fHpSAZ/7dP7xLuHQ1hcEnIscSkCnl7h
 Q7IPlxfNt9XRrXGRuy4NGyW9jp2W7i5i0Hs7UlcC2/jwdAz24A8o+twwKGzvP2JyGMCP
 Ti9pK65bj/BThxUiYgZ4N3HWLBx8cuYf+FQH3laae4OyA/NI2/qZX7iUU66yCeedZ4Ls
 0nNJ2VeFPdCp08wK59+0G9xYmEuV8lp9dU07k5NdcNJX/k/yM/yxXNGyDLOp9YFw/Np8
 hli10ns6mzdA10cG7VW9OQQbCsHZ6GgaYRYct0qtOu9dB2s3jnFM3g4sCiu8CMq+Sg7U
 E+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790354; x=1791395154;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBc1D2oz+JV1vmUOlpvPkS3S0H2UGK2jXUvplCDqDjM=;
 b=O7epVv/6+NV1PD740thlAt5v9X4elFh5vKiNM73uIVwGiekinHwRuCNsEK8TpQssua
 CWAiC/3jaSf1rWaOxzc6afTf80sqrUJi3wfyGdfxkY1d4RALWBsvzvD65kM9779z6zID
 kBMO0fSPiIKo4pIgTkmjHFGsgNq5OC1anTNBsoFds11b65Dfc1Tgk0DT/tguo0y4i+/h
 7804KAJs/5CIdwPLBeQ+3zono++U3ELMDlkG3Lq8kd4z0rT6vHGOa4Fqz5y8uM+zd80v
 vp3SqdZpwcikZL6XtzoR8NF+Q9LrV8o08awd6vYRv8sGMHcWpyVcOLJcqcmAHgxLn7NF
 wryQ==
X-Gm-Message-State: AFuF++klcXqnR5+DbkqkhaRG+dvhoTGkATRoNrnmemlahmZquDMGQpnU
 5ptLR1APIri0RiV9k+FNykAVd+rCdeiPWEyV0WsaQupd8OV07RkGtDyH4cCw58J6k347AioxRF3
 eNk231MyE5cn2mDfRed/v0uq4RJHhOGoOAnoaEzHVQgJGyvEtVvL9CFaDYTU/LrN/jA==
X-Gm-Gg: AYBFou0ZUJsWrosIFKkEmUZ3saNSpsJhg3YAuxcnyx05MXcBUUwnhcRTMswsqTAukuK
 KxFMvJbQiVk7lWw7+JLU7PAurJ14yCuVTHy83CCUscX/8HjHMIgQlU0QZ1qq35SLskOSVnrhv1J
 Q2vLdPX467DAdbfu2xAAc7TNcmZ6/lPGmrFeneYlAmageTg8HuCPoNvrtu8LouYSzMQ5B/OcNd8
 Twp8c5ITlSF5uNb3dqcy7JRMw4N/YIzGSK2jcdRks5ZXf+CGmkyXiVUevZWh9bbCmZ+CFuE6hN2
 gnFkt40GDLEbQMXA7KNf9vvujBzihXRWZVvXZTfwX0HEGLwQKQAjUS9NGxwJeuefm9760VAqsnm
 8TezZSraVSucnqvlUJ2ODpczVMHiDHINslNKq8b/H
X-Received: by 2002:a05:620a:2686:b0:93c:7a5c:77d8 with SMTP id
 af79cd13be357-93cabf2a172mr343987685a.4.1790790354090; 
 Wed, 30 Sep 2026 10:45:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:93c:7a5c:77d8 with SMTP id
 af79cd13be357-93cabf2a172mr343980885a.4.1790790353412; 
 Wed, 30 Sep 2026 10:45:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bc9b1sm702103f8f.4.2026.09.30.10.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:45:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 6/7] target/riscv: Access MIP atomically
Date: Wed, 30 Sep 2026 19:45:06 +0200
Message-ID: <20260930174508.81497-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174508.81497-1-philmd@oss.qualcomm.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abd4ad3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: k8upuRtVWv_7_7AVTizOgWLoKNZtZ-lm
X-Proofpoint-GUID: k8upuRtVWv_7_7AVTizOgWLoKNZtZ-lm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXwxsMSiecYs9A
 w02e1pJLOCRtQdat2hGo87WvvW0Rdy0FLBPWBbxGI6LaWdQ6zP3Txsje+QRjm3MvwFzZMMlm5X4
 4uwl5rvqNcubcEcGTFS6ZW+XoEFR0HlfUzb2Q/351ipMacyo32lmV9ywBZTBm9O+FeUyqnvLy0C
 UPwqrONuth8exik+0my6c2rE1Nefl7sJfyhKNoxsDb/rwZoqJTxYH9JCikLMemgJmQN0pPSVAAA
 tc0HBthgqfdFkugi64oORTur5KdnzoP399Z+mOyVJECxD1E3Dlx2kxuJT331fbrmWKxCZ/pL8L2
 3hw3ffoklutRZFFA79HfhFbojtcrM4L3JTT857og7FJ+ctqFKMyc1zE9qe5bh8qyutJdZ2bpmzi
 7TyD/ETWPXLuakf2EqHEqj1YRTDSZOYU2MusKWS6IWBuhA3d5Oz4+MQGyA6DplmdnFdQC3FIZ76
 V6DWlweXSQUooC7vtyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXwyz64cEZxbgd
 4L8JGvcso0vZwu8xJfBHMdIw+DqdN7/ZPoziV/WKYbLD7+yvNsbGRYMWyhvr1jA4FmcBqDIWaol
 5iaS5JjX4ug0hEHjGJynrYdqmYnFpAU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Make riscv_cpu_get_mip() read env->mip with qatomic_read() and
riscv_cpu_update_mip() store it with qatomic_set(). This makes
MIP reads and writes safe for riscv_cpu_has_work(), which may
run without the BQL.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c            | 3 ++-
 target/riscv/tcg/cpu_helper.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8d6f992ba4..45e82fc30c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "qemu/guest-random.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/tcg/csr.h"
@@ -956,7 +957,7 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
 
 uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
 {
-    return env->mip;
+    return qatomic_read(&env->mip);
 }
 
 bool riscv_cpu_has_work(CPUState *cs)
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index f8f779a01d8..db7f2bd6de7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
@@ -584,7 +585,7 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     BQL_LOCK_GUARD();
 
     old = riscv_cpu_get_mip(env);
-    env->mip = (old & ~mask) | (value & mask);
+    qatomic_set(&env->mip, (old & ~mask) | (value & mask));
 
     riscv_cpu_interrupt(env);
 
-- 
2.55.0



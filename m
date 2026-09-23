Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA7FC98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QYZ-0007tc-C4; Wed, 23 Sep 2026 13:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QX7-0005yc-9K
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QX5-0001I0-Hs
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:13:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTfxC3081857
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kNtz7Wsg4/5oYhsduTgWMHFHx5o63oBFXK1BI+bPv0Q=; b=HAREu84GgSQzQC8F
 hsIPKrtpjf49b/kXo1YJDNYOmGrKQRoi9wUcyoLsGHcZXGKN3zzGtgGDbNH5xx3v
 pyYIQBcNIZZl5UfG0Q+dOAU0FOgVkF6byXqEmbQSSEf+3Djk8UsoHO6k3DB0AvKA
 tRxwWmaEd0ckv28/5XQwA+0+6Txlo3sp84Eqsbg2+KpUStto7SPTSyNAfP2rXrL3
 Nn3Rw+v7EMCBxcAnR14YhC8ROe5PR+NSW/YSNYXIWbMReXeDcyoA62ysMeBAeaDA
 T+PNTbWdiw7azppwISYvRNt7qGXVWYnKDCP2RIpHcdQzE29n9GHvpkAO/xHh37JI
 nkarSQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7j2fe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:13:12 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9909eeeaso294263241.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183591; x=1790788391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kNtz7Wsg4/5oYhsduTgWMHFHx5o63oBFXK1BI+bPv0Q=;
 b=IlHH60i0y9lSMQLfqYQfIkZgO1Zqs3WoVMsArUHKFXmLqOOdNAm2Ecj1XePk6ltL5C
 CSdSH9HQjG4eFRZIqHqJQtrk0DSZ870ZQHl5ywTt/gIj7hO6wk2iK2ZyQSkWfgDEMhtw
 ZBNaC/mQc6FlPgF5nhNYNi+IRochMSajmu8ofRAOWKPCj67gWfRIIKBlO5DwRVQu/UnV
 zsinZBvwcp4MTwEZkbJoPX2XDOQLZe5boUcksQ/kY6FPvVJefWbS+QmDjNxfYW6mFWeR
 2Vq+FbniGIo7qsvla83kFSDcu3QzVLQThT6SYHDOq7/2anuWXLfR0/u47endysfzscRe
 AMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183591; x=1790788391;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kNtz7Wsg4/5oYhsduTgWMHFHx5o63oBFXK1BI+bPv0Q=;
 b=QcwQZ/OQauVbffNJUUMQu3kWBaLBl++kgKnmucdYx74N4P1xvi4K3oILHqge4siA1r
 VxCwMEDD297bYt7kEzl2v0lGMV/Ox9hBLoGs368FR0gyM89n/ggwmjCbT90qS/WgJbo9
 jXmh+cdr5dH7/rGZi9r9BvjLf43xQ0LUDfieAxuWL1nA5hbJ5TwXgNtzbjvcqHNITn4k
 QjfjjjnqSLGlpmiGRst4Oa9yyHffU8L/bjWxmGshBNmG/xTpGB2kQaTAVB41E/Nm/N4O
 DRK3lFwNrG8ayT+iywfpYViS/AWR2gMp/Y81uX8Zyk8r+EjZU74gE9LtFpYqYrqpcpbZ
 /lMw==
X-Gm-Message-State: AFuF++k8g+wETXJ0y6wTbuzl211HbufHNc+aUT3rZzfOiwXdXRRs1ILJ
 /il7zWBbdoSRFXmwFqLB97rnUGYYVTLTQzvE1to+f/NlLgGg4UNYLFnNCS8ztC+s+ol0DGkaPWy
 LaaBU6L3sAczfxyLrAY+x1UjPRuklfwp4pMEevtcp1JuCseXZFuZx0YX2W/kcdZTUXdVX
X-Gm-Gg: AYBFou01oZFrAeyxaDkN5GK75ob/+khrqyADObNbNJC5zOvYFHMxrNpZc0tsm6ZXLth
 vZHN+ho0MdNy5iWlg4nIxvHcJjalnmdFyFoMEGdcUPUzFJDyFHPXJ62Ac8Ub7vAXPFp0pX02N29
 Ha+ZUqbjTgvx+YlhGbWi4DUU3tkoM22v/+WMd6P/UASMlZJdYe7agei3kt3AGrHeGBrS9nUY/32
 NTEOYpGBM5nj5MqRl+0UklukKZrJ1r/DH9MJYJZv1N9yyW6FuSRTRtUCZ/hZGpkg0UrR8/RIA5D
 utH8yGpNxzaWHPdkExKbcW4Lkc6qQJRrhhZRALca4zN/oQ752ABeRZ/g4RdvXYMHmUHU7/XW8cl
 JLDiiqLzje/9MFStskb6xG/n3tYZ2GsOgn+xt6sUi
X-Received: by 2002:a05:6102:5121:b0:7a5:4d80:a913 with SMTP id
 ada2fe7eead31-7ac1abd2294mr3118746137.7.1790183591123; 
 Wed, 23 Sep 2026 10:13:11 -0700 (PDT)
X-Received: by 2002:a05:6102:5121:b0:7a5:4d80:a913 with SMTP id
 ada2fe7eead31-7ac1abd2294mr3118728137.7.1790183590672; 
 Wed, 23 Sep 2026 10:13:10 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm926755e9.5.2026.09.23.10.13.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:13:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 15/21] target/arm: Split leaving-halt handling from
 arm_cpu_exec_halt()
Date: Wed, 23 Sep 2026 19:11:09 +0200
Message-ID: <20260923171116.31276-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: S7fL2gD6L471qBqAuG8FwZZAvyj70i2Z
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab408a8 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX0EewvQ+6cnVp
 HVLikyrsCEK7CjFlrcZOJIDn9B/RfRaZxPf/8y/991M8HECt1OSV6vm4cithXDlUB8jnlDwkqAt
 yg69PkKIMh+YtbmIo9bC/51qyTgeSc/o9BON4EUjw8Hxju/jm/cB8yW7FkD+4GNcRprRbelXjks
 Yi8gC4bXH2soEkL0BhYi7caqvc6dmtYLy5R8NLtlv++U6h7TLeCyq8sMiTmgzCw1i/n2vdP+yb1
 wXLNvLbp0OxMcI4TnLZxjNAMLvjfnH/kvpSXDxp92ajg66SNN5ethDMt+gCErZOKPdUrfTr3QQ1
 84erE1whRpD4AnBpeOyuZ10TklMoqjxdUKISobKLfYxOHQ3hfV/uACFy4q9tz7fC+P252Ko9eaQ
 m+fWCl/hfYaze6zClqLJaGQmGxNz7wHJc+GxEteUDdj0MQcC2jN/kKBV3onj50aoDaoW78CBVli
 VwRv2VhFEC+djkOG5zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX29fQe2nJKvt4
 5T5MBSaatMNcSJiFjrctZGWIQ2m+QXXN+NsZwEdw7TqanC2TDfVPRE3csx04OPzfBHj2xycvcKq
 rwJBR2jfRaDs/Ce9HLUmPaPKHDNvnm8=
X-Proofpoint-GUID: S7fL2gD6L471qBqAuG8FwZZAvyj70i2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

Move WFxT timer cleanup and halt-reason reset into
arm_cpu_leaving_halt(). Keep arm_cpu_exec_halt()
focused on deciding whether the CPU can leave the
halted state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 090470da40a..0885a8eb03e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -872,18 +872,24 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static void arm_cpu_leaving_halt(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /* We're about to come out of WFI/WFE: disable the WFxT timer */
+    if (cpu->wfxt_timer) {
+        timer_del(cpu->wfxt_timer);
+    }
+    /* clear the halt reason */
+    qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+}
+
 bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
     if (leave_halt) {
-        /* We're about to come out of WFI/WFE: disable the WFxT timer */
-        ARMCPU *cpu = ARM_CPU(cs);
-        if (cpu->wfxt_timer) {
-            timer_del(cpu->wfxt_timer);
-        }
-        /* clear the halt reason */
-        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+        arm_cpu_leaving_halt(cs);
     }
     return leave_halt;
 }
-- 
2.53.0



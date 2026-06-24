Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB34CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9f-0007k8-7w; Tue, 23 Jun 2026 20:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9U-0007ZQ-D5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9S-0003Jv-Hd
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJweNZ617655
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7/Ye8uQmQEt
 QzueRNIktNChhgXsfp7S9pzEwkRTES5k=; b=JDNzLe5khO554nbZ0Bq5UJ+rxXW
 AoO3R3mmi+VPfScCI0xeescN1phJidlez/lXFXVq3gCnrYJ5ML8XUG7eMEHfSSbO
 L+d5AGqFzPoQFL+CHWI55pQ7riw25khWwPT+8DKzYRqLI1XU7/7TazMB5e317HbR
 KdLB0boOPq+61Yad31cFGCDHZ/zJwkPxLVyk0/GhLCGhAzaQ2yd0QHQp6KFC4nBP
 vrQcwRfJxwVH1RFJ1qe00R22ikkg3s3bagyoBki1os+FmhXf7od7VWrFkG4BtM4z
 GItjh2w6YOlxC+7qf/9Gb1O41uR1v6vm0Mkxf/lLpqfjFUEBRr/P7ci72zg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eysv3jpqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a5212cf77so6637071cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259651; x=1782864451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/Ye8uQmQEtQzueRNIktNChhgXsfp7S9pzEwkRTES5k=;
 b=O0nVnqTPVotKthwIs3KNQGcumHndz14KPO7UuJNcct2bViJvRPKkDpKeLkuxa81H7K
 qWCdhTJsPZvjyMXIfa9PVtn0N5tFSAWKDQz6Ev4iBUCDf0D7p/1bpGOzk2UiZcqfDqSs
 n/cU3zY12mjGR9s49YFjJwLfdnUEwRXit+pOIrswYEht/CwNzx7vY/hjizCcLHJxn5DF
 w/ON0VFF2+Yo+9F8L5qSvqGDAQtf/KbDjk3uTGIFFaMgsec63g67JeXdtxCL8hQJm3Sb
 5Zq1pF5Jg16man+n70Gg2gpW+X6uT8Py65nks7nMdt7m77Y6eMiT19YwXvvK3M+YOW0q
 l9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259651; x=1782864451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7/Ye8uQmQEtQzueRNIktNChhgXsfp7S9pzEwkRTES5k=;
 b=tYCaycQxwF6rTDp/PyvJD22TUs4bdA6/LPRAdkV/Em4TgJ2bYILD1p10DVC1zLjoLG
 gSfXfj8YBFzEfNXTXZB1FKkxIMwPj8Len87WeFOuhB24S6SoFzu4Q/eyiNFGM+tMVWsx
 RkR2cF5VnSn1ambKnMnqt0UBbV8hQNWOVGQeb2zCW9PwdX0txLlpo3S+vP7j4UFuKZGB
 /LlB7VFUbGGSBrnc7H+GzXVXTPPX4MFvdOc5+Hsxmy+jQXaVOWoAzHnoQlXADrqAUj5x
 AdlFZRSpkXUdlBODy9psg14uVtKMdBQxq14ALUhQNxRKzRsjiyqRIjtrokUMkGbBxlLb
 LngA==
X-Gm-Message-State: AOJu0YylmLm04tcOzliBmylVD1cAGAp4DUUQhaytuDOZyjwUKhEB6bvR
 KJkaMLYQIZpvXXQ0XXJn1c4wCobFGPSPizVzN3I2sIcLkhKO/WWKVLVs/ob1cKfOfW3yOO4BnPi
 rg1e+0Va4STuG0DhyncKRrbI8DLnDsB3D0XDclxTS90EYZXmB9NEnCZomCa52TohN7A==
X-Gm-Gg: AfdE7ckR7FCRY0fcR4871QZDZSxB2Y41H1nyVlSEYlvNcQMfRIzIBqSZOq3j+6MPoZw
 +9EAbSSO6pyiSqmLhFQdk2BJCriiWgOqUsWUTpqr8KVTMmb/2Mhkgiyj7RoxxSdrPupwFGIz1SO
 BSA+Xj3y0fHg8vn3SyksCarA8dwwqe4gtmuv8Ou4HWWMVu7t+mjEDXhWgaWteVeObse9Uw4sllE
 aq+LByYNcdinjhakDdteN9dB2bKZppYzidwwDWrP97KGKr0ptXvPGXJmCqNXrkFuCLwWSgIAogE
 2kuwm+VSliaQYk+D/x7wdXiE/0S01XqC/mHLpOlIlA9gEqEF0/Eoctfpz9cxJY7VXxRP/OYsyR7
 cQSoDO2V2TujIlqe2n+XprUvZ9mc8eYGtQLITU0taqTWKRA==
X-Received: by 2002:a05:622a:253:b0:519:e1b7:5ba with SMTP id
 d75a77b69052e-51a61d6f330mr19124031cf.15.1782259651370; 
 Tue, 23 Jun 2026 17:07:31 -0700 (PDT)
X-Received: by 2002:a05:622a:253:b0:519:e1b7:5ba with SMTP id
 d75a77b69052e-51a61d6f330mr19123581cf.15.1782259651022; 
 Tue, 23 Jun 2026 17:07:31 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Date: Tue, 23 Jun 2026 21:06:24 -0300
Message-ID: <20260624000632.2149359-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX+vxXIwNxgiYE
 PH1Pd8tQoftkp2o/wRCrbsx6k8zAqZd7Nn0uc+euK5tf5M0/CzXEWLWcZ9IqMx407FZIaBjcPK3
 O2YwXTihhYxWrplNA0lv7P94jywcHBs=
X-Proofpoint-GUID: oGtIQlGshxl3QjGww7N0vXzJgEvquui_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXzUE0rq7RiSVj
 gyyCySN7/uO9ZdHfbAQfs25UAc0bO40dl9EMTJfSDpnOxcR02f2TnhtaYoKX+np7uDVOIjYA5cH
 RXTfchlWYx90adNSaXW0daKaXnca71zRfIre8MX/sWe9POrLoUhQjgRP6UP9e2djN5XK2+cDoUF
 nGuOfQh/SGY/4wg2Re/9hDniohPhPG27Nm9LKdRsG+QQXKys0xAlHlWdUeMVtvCKsOZUTE+5x6D
 /HFXDihhI6mKHs5+0P/1jqVTzdZ22/UEN196mwqjuIkZiJ/Mswe9jdkVgNxanUofgCJ5FAnWWad
 kK3L4hZgc9fGO8UkFuNVU5Oj2hL2z7Xu8J4T8q+fuCAjBH0wTg2WcVCYAUp35fk+SOfmtu3B8BL
 yn+DHPJ3Gd7ZsMJrhgbMYk00OwNjig==
X-Authority-Analysis: v=2.4 cv=WtAb99fv c=1 sm=1 tr=0 ts=6a3b1fc4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bJI4hLjMr12y1cUB6bUA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: oGtIQlGshxl3QjGww7N0vXzJgEvquui_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We have a lot of TCG only initialization in the common cpu_reset_hold
callback that prevents --disable-tcg to work.

Put a CONFIG_TCG ifdef around those bits to make the build work.
Eventually we'll create a TCG specific reset function in tcg-cpu.c but
for now this suffices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f9d2967ef..0c777b76d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -958,10 +958,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
-#ifndef CONFIG_USER_ONLY
-    uint8_t iprio;
-    int i, irq, rdzero;
-#endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1013,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
                     MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
+#ifdef CONFIG_TCG
+    uint8_t iprio;
+    int i, irq, rdzero;
+
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
         iprio = riscv_cpu_default_priority(i);
@@ -1050,11 +1050,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
     env->menvcfg = 0;
-#endif
+#endif /* ifndef CONFIG_USER_ONLY */
 
     /* on reset elp is clear */
     env->elp = false;
-- 
2.43.0



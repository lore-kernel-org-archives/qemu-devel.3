Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E16C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiIP-0002h9-Ha; Fri, 03 Jul 2026 14:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHv-0001mF-Iq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHr-0002LZ-Gb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiWos684732
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=; b=UnEU6NjSmfPMtaLW
 s9bCT4Pu9wsrjyhDwgyOjPFf1i4dOya89j+e09xeFbbfBCToNuDYRNPGJJ3Fechf
 zkJR+nFYKwrr//QwIM4RBhlN6VLgP2Z6D5e8FUfCkqKZ/fQuDifhhtgYttYdZh1G
 sS7EdTKxRq7FGQz3ze+uGbukxEi9zpPAkLUTRa2jZDozZmiwthrPrw+7xgP5IWEA
 ue4PQI8ItaSX0HitVyAS545cAti78+4+c7ip+LRkNaCLtOWuPcYtTjMHjSRNq7Sd
 QopQE1BTfB3I6Xgw5l4PAeLiRr/g4N2UgHqldvgL4lhuI369jdAHlV/LXWC4ySnO
 JOyOpQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bfks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c01ff996dso10236031cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101995; x=1783706795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=;
 b=YV6193tBNC3hQ4ea12CZ9t1l+9yZ3dHaPxADPxn2YBaBcSaOtWjpfNjB9jxkOrtzcu
 ZvorK1bgspOJWsDBXhweyXZ2dUZUkmR+p5dH1MfvW2nn5IZxxR4/rqFh5KgzH4eA7k0G
 2ohbBFlzcI1AtlAXOK663CLn/jpBOjs/cTSqL7NZ7sQ5wUCxCazv2d4VF7CW0nQugpVn
 81vcGHVv3yKNIBZt1ri6NSNrPNaj4/sy8aft4gGnkeVcs/iW6YEwhQVAlQpxkNEfI/Vd
 eEAWhJdHeT0QoFf8ZRmN9Bf6q7l12bnhXj3MlxJb3qn2cf69rM34LcgVZ9jRbitabtXY
 I77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101995; x=1783706795;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=;
 b=dvKgaQoeuFqJkFZWpJIKMYtDaIgvF/Dbuebv2FsxeaR0n6WFyWAZ2DFKSJjuEm5/Bs
 lwti17utJB1UsMopf7MFb4A/t9EGJN/q8w3pmmlWJqEjnxa7vmRhcybzQGzmAUaM+g7X
 cx+/cT1CEEXmzHLcXbrKj4nHuEybXDyXROPFQWw2SVBfYtin+MXANG+Q2GGw11fp6Rgw
 C+Znwx09pBTirh/33Q93LWyYoZ4LCIydU8YMZy7xkQ3DUMCJQq+XDec1oY9oIrYZsIvg
 kTWK3fBjn1X7ryPQ0x6Yl90s9KKaE5GJkLoJeGXSX8kDtn3NPA4z9dTTqSu/Oy9+yc97
 73fA==
X-Gm-Message-State: AOJu0YxXrOBODP1NkseKHPOmWqG+A806cXNbwA9W2iPbfum0f+PA6fqn
 OzTOr74pE7/OJ48071hbwWfTrGkf5QImZmlBVJym08So/RPfKCV8/acsvL+4jwoZHccS0zz0H2R
 tO/IVeq6urBBqPoXJZDebFHPzQWCeaUN9w+Ar/U1/CEp6HQipHunjrZpNGKI1fNZ2pA==
X-Gm-Gg: AfdE7ckTdUQLeMh2dQhut/uywS18CwCabml73kSibJ4WbfvK85utTJbxhCJ2eAgWk4w
 vO6R0zGTYk1Hm1HrE2FvIrm8qWcyn2Ijk1VvISb869c8ObYwzekbfZ1xJGkW0udv1U9qXX/g5db
 iAAEmyiaJtsURU7cMbIIgLiovRDTUCxgOxEBIrPHd+S6qGSAtPB2f1n3DJ8yg3A4joDsko7XqYF
 kRZr45ccEhhAgDmE2lciV9ifRMjV9IrNQSw7qZJMLQ+4Xf2pHRWHHIQJrPV7YfN3+DtgXzgyADb
 JKMxrSBWu54Y1uzTPCFhTqC1qUr5phW9yQnG0wNAP/riJxDfKQ6bw0js8qZQ0f40fnGGK7zjUd/
 A/zc0LzP4MuXUJn8CiDq+cKh5ImDwjAGY351yrb+Grj2CqQ==
X-Received: by 2002:a05:622a:5918:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-51c4c1e497cmr9619941cf.13.1783101994948; 
 Fri, 03 Jul 2026 11:06:34 -0700 (PDT)
X-Received: by 2002:a05:622a:5918:b0:51c:164b:b241 with SMTP id
 d75a77b69052e-51c4c1e497cmr9619161cf.13.1783101994265; 
 Fri, 03 Jul 2026 11:06:34 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:33 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Date: Fri,  3 Jul 2026 15:05:29 -0300
Message-ID: <20260703180538.3346781-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXzSv1qHYCHPQm
 BhU8MaePpz7xwkA+PS4JBtgsJ31Dob0JWB+KLUBB15SbtHFcpvGPT3qjoO1pVz1b10WA4z87QIB
 5IN6MZSDBo2U4FqYJyy+Eq+RalzAMS4=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47fa2c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VLRNWGNRl9IGrp3TKBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Wymo-Ec8fgCujaK89UV1E-BmpocvBnOk
X-Proofpoint-GUID: Wymo-Ec8fgCujaK89UV1E-BmpocvBnOk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX8QNi48OGxCta
 w8AN2Xz/46BR024JD+Pcrk2kVtj8uvnW1EEwf/8qmE45GL33INnCUvrVZhpJMAmXhMQfTBiekuA
 AV51GlA+FI0ig11KmK/dbsrrDR1nVVVPsqU+PlKtLVwM+wjrjn5R4K8j7gWbVDjZjQoldAwiE53
 D+v4YNzhC/aXL9efchHQfgoHCxtBjI5L1g7b/ZCbL9BtHV6iWVosuk0ri9dak1pdpbGLol6qSOr
 Us55IaLHk7eMX4elE1zK3SbMjIezZ/MlZW/y7qWkOgQOoyMMhE3GtjAEjSfy7ntG0L3J+TWwZBz
 BjIzIevJqpB7mAiauZ8I2Ie3Lj4MFFQ02uINss0TlY/Tji5mx7wwPovcG2j8s0E5IuZ4jIUm7/U
 qKCE1yaiGjSgcsoJmWLlf0urVqL8246Hv9hEt3XZ6A4pi4KkhcGG02V+Ol4569ZAEwGGAsoG09F
 at/nkngR4Nrf1dNbr9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We have a lot of TCG only initialization in the common cpu_reset_hold
callback that prevents --disable-tcg to work.

Put a CONFIG_TCG ifdef around those bits to make the build work.
Eventually we'll create a TCG specific reset function in tcg-cpu.c but
for now this suffices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b79dcc5ee..5a82e6563b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -965,10 +965,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
-#ifndef CONFIG_USER_ONLY
-    uint8_t iprio;
-    int i, irq, rdzero;
-#endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1020,6 +1016,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
                     MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
+#ifdef CONFIG_TCG
+    uint8_t iprio;
+    int i, irq, rdzero;
+
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
         iprio = riscv_cpu_default_priority(i);
@@ -1057,11 +1057,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
     env->menvcfg = 0;
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
     /* on reset elp is clear */
     env->elp = false;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FC4CDB477
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNx-0000ot-Cm; Mon, 22 Jun 2026 15:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNr-0000lh-G7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNo-0001qh-4k
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFW6qS1083656
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bqoFOqi9y2j
 ApoBFiQULiZlsCkxGWjY/YWJcwDvQwNI=; b=XdDEwLm8Rm9AjxpnjX9N86/Z+VO
 xjc+/hoTxrxNs4mRbK38krqf70uBUZm4j7BoRjeMJ21M1KsOUcBDe8KoZxWxjTqb
 li8A21313qk4IiWSgEk6RtDdLGI8/f/CDuL+i7FUxZGspK52DbmLzEUBSNCI5Qu0
 Hsf8moIKToti/nWkoWw+e3vto1RTCFiFyMX88wMVEaQp55I7bxAMxqu3lb3J6NGb
 Jy5y8VRc8CSTIncM3VpgdD2EgNTA3e6AKBTsUyymVk7vgwHisxLTKUJ2cKunpmRg
 cFYye02ZF7qwKslkArzLZzOQoP11rcWqFdTmr5f1PgQFP6jTq/zCnJMgAxA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yja2fe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91598ab3a1aso600334385a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156744; x=1782761544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqoFOqi9y2jApoBFiQULiZlsCkxGWjY/YWJcwDvQwNI=;
 b=Qe1+AfxsEpe8iu+YQmyyfWvXtDy6L7Mes3yEYhz5R9jRgbTOxGE+/OXgyRi0q5BkXB
 35mGEm5TlLzC+/2UZia8f4C5405XmHOPwQ9jJ931pCg+35vYuYvrOg7FXU5KeIl4rTDb
 cMz6RgUmeaUepxzJROuNOzl16nOjCAGsdSM+5zf1eRdwQv6aWJLT0jfnf2t6XxRqsj4R
 Z+v3gLKYF1lMlHKEWBsxxIjBECdCb/3P+gQIyMLu5ctz6c95tGLEgB4TH/kwfcB9OBNQ
 zfQksANpiRw+px1b3ki72/wacSoFrIyrf2T1eaOsGVUqgiDVnsuFv1gRfKODNHKbqx+v
 qe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156744; x=1782761544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bqoFOqi9y2jApoBFiQULiZlsCkxGWjY/YWJcwDvQwNI=;
 b=iE1Dnk+h2iuo8UoFDc2zJGWJf2mikh3ERzRBKWyWNedks9R62NRIRKCKTD+kANuXtu
 5SIuJ+8qWPowWdFH6dx4mthYcQRc7X5HgNw0CJyP7KUQ20n0yqZXhfV9aVwxkDdYY35X
 BugNC2XRQtz2b70+y14WxgaQjBuDrsCj/fHodQ15Ci3OwnSfG7n//LADi0fPlicESqHN
 2a8s6erG87GDiq1kCihLpQqLvmgrJqBgLnuMWostkEfFV90uHPFSDdOoxeGpT0DjfU0a
 4acipKXd4/tl47DbmzNWXPy34TqsS8aq5QUetLp9mkQVJe8ke10/N4WlICsGcUnp1aSY
 7SVA==
X-Gm-Message-State: AOJu0YxdJfV+7gtr1O7a2wztCXmSLs4AF6qgRMTIHy3wOm/f8cMuH0V3
 J/aKHwyZ5aRIlXC8onrha+QPEuSI3shN1SYeoMKUtjGLUfFqJRd57pblRmUxbbfmUDeWolPkYIO
 1MBZZJS0CLS96F6ZwMZwf6AcgVK3bxrL74if00TkO8HOnSNy9ZZiV9NXRSp+UcyU2vA==
X-Gm-Gg: AfdE7cnADCZlv7T/didnTcxRWMffTAVq/T57P5AKs/WUqJzfzzjKqN5mX5Mxfl3aMog
 oClAEk9V5e5S9/C2MWOZTHiidfOYLMz9jiuaVOOK7rZtZS/iUnDnRZzyr2BRsx0eFKXdQ/PRp5A
 wyGPxaEH8T2O23C4hcOyz9D01kWAOerFpSa2sESpE7+IFXdUqxVLBiJOpRhV9c4PXT4c31eDzfD
 /gUzCZVVxj5xvErm+stRoFt2sfBCOOVC6wnc//yDfx1+2l0UaTwcYSIAK5cTE/9+nl3X2xocQKG
 R9q1xNb+mrviThFMnF+7bSlI0FIXjeUxi/cBk6KI7NjkdhnCKfAPFWWqVL+tZl/K8+2kt6yk1mM
 8/Lkt7HozYJ0uY0mXNplMuIcDK4mb/iCnj4sCw8lF3Cm60w==
X-Received: by 2002:a05:620a:1a1c:b0:915:cda5:2803 with SMTP id
 af79cd13be357-920d480ec73mr2112870985a.56.1782156743496; 
 Mon, 22 Jun 2026 12:32:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1c:b0:915:cda5:2803 with SMTP id
 af79cd13be357-920d480ec73mr2112866385a.56.1782156743080; 
 Mon, 22 Jun 2026 12:32:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 11/24] target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
Date: Mon, 22 Jun 2026 16:31:27 -0300
Message-ID: <20260622193141.1449724-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o-FvM_FgH-UMW_FZVVwFn3i8SkapAGf_
X-Proofpoint-GUID: o-FvM_FgH-UMW_FZVVwFn3i8SkapAGf_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX4AshNH0eUlRw
 1YEbxw9T04PUqjGFs/YQFn94RHXJVZIwZaQXmn1UNwDps6zZvFVUIdteUqaq1H5NRD5xuY7bHS8
 CCa66HWTbdLuC2XJLAmaz/cDqCxlMeY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX6t3ZoH+Ja/Gq
 oavCvM9AtdgEL3X3GdiQO3WYM8LtzS3dbnyucBiDCz22HRa+dMNUCiyb4dxKYcredMeADGzjf8s
 +8jqfKotLZ2nMTTfDzx5EsB4rUOfJZpM3RtGKIweVrAMlq/WjXNwEBy8u0LmPurDyRnPcke0ZXn
 lrhUKIM5chxIVCup0jotVGrLmwx+OrdRgT+4U5e2qH3H0da2c8r+2zR37VM+u1BcUlzxDCdkMnG
 fxU6Sk/RDRzd5wRRY7RugFtyWO2BaJlKFvkn5kqOMZZYTmtpqyiXpWiMxBRUFEgx1ABkEsgsMo6
 hVnJhBnLeZpCJI8EnMZrb2nxynEz7eel143Ywg2tk5SGSVU/AD/d1ZaB8rUUTJf8dSFkUmTvy4C
 /j6M6VTiv0O79JUCXUjb3w8SVPCoC/UtqzCrzymd4K6gye0iSGPRQTzGEyOSv/LQwCbp2r+fvJ7
 nhZsGivpXdG3izNkJ0A==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a398dc8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=9Y5uhDEGy_uPjlLRjCEA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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

This function is related to Smrnmi and non-masked interrupts, firing up
interrupts via env->rnmip from riscv_cpu_local_irq_pending().

This is all TCG only code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c         | 8 --------
 target/riscv/tcg/tcg-cpu.c | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0c5e000f17..74b6daa76b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1160,11 +1160,6 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         g_assert_not_reached();
     }
 }
-
-static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
-{
-    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
-}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1183,9 +1178,6 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
-    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
-                            "riscv.cpu.rnmi", RNMI_MAX);
-
     if (mcc->def->num_triggers) {
         env->num_triggers = mcc->def->num_triggers;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fef66557c2..0d0a704179 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
         }
     }
 }
+
+static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
+{
+    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
+}
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
@@ -1674,6 +1679,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D63CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9y-0008G3-S0; Tue, 23 Jun 2026 20:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9k-0007wb-0F
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9h-0003MU-IG
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwqNR706773
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P3lydCQDXPq
 vzkivEXgkdj+wjXFKn1TxLNJlSp9IHyY=; b=hCS0GdrWZGHDbi6k1XupNYlcj27
 rIqkdX8D0XAao20gLd9an0YdeOAEcwKArorCDbbxvKshNbSkTgjInKh4swvgczCA
 2r57XhcgkhF1BdK7IgVT1ZOpGZyPgIHMmE7/97nsaZKeuMH0ZSZbkpEmViv3q1sc
 KObjEB5Szg221Q4eBRAKfd0+iryembt+ON5mv+IgGC2LJnmoZkWso0jzeD4Q02qy
 6c0TNt9d/oBJEXOwuJ2ZbAbrovoKePisNdRmduGEDI5HdRxeG3aNNGGxvPK3WsVr
 UOMS5v7vfv8pcYWc3qpZNwjTdP+7Z8Tb/qvLbk3MiUjUYYZcAwyNUW1GNog==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29ktbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:47 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8de2adc85efso9377546d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259666; x=1782864466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P3lydCQDXPqvzkivEXgkdj+wjXFKn1TxLNJlSp9IHyY=;
 b=TbGeKUkvVxy8100QgY6NVJlV03LFMWPu93r3vU8irX4Imi5pU+PQehbrqg/PNQeCsr
 7g1aJumXvGwusFg9zpj0gUwh9nyjh7eZAcyUe5/CtxaKJxpdJRQDFKWh3mR7f0KBKI2L
 DrudOswtXtNPtsT5QI9HLoirx/FWAMNArCB2Pjz38v9Ob6C093HBozMY9+Efgm/XUlxg
 QJ2WBvVMnXlgMK2nG5JzGJSy9RNR8Nn3f2JqgUyNm2U6DeIYMtbBJnTWbO7vxRw1xrNA
 PJPQ8j2pQJPBGJyTJ5PpEgSR4tVoK87seFvfyw3BpnGhOht1YDGOc+0JQr4LL+InNy8e
 dCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259666; x=1782864466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P3lydCQDXPqvzkivEXgkdj+wjXFKn1TxLNJlSp9IHyY=;
 b=Uwen2Wn3V5uptCeCADeAVLvao9GG2XjBrvioR4qNbLp8jbvYcoaUWUUt1epkgNrsL3
 jjJTYD5yYWb676MZ8+TSuvny5+WzMYVlhQ4y9mRm72tLFG33TMdjJ5aPqtwDNIe6fCdY
 VbMGVqJkiG3CpYjt+w9lu596WiR3bMmBcaq3ptE3AHi2+D+GlCtcBui+uL1EhKRXCFUd
 WxsepOnnalZ5ihX2yyJHRCAV7IT9RCkv3okQ733K0nC21dDp8y+kfJPPj5grgKCC7Dtj
 b6Q4XxeQoHxxh2l8MFpekbui6POM4DuQLkM40vsp9vCfE49wqOqQ7iGaUL9OXQvP66L0
 N3mA==
X-Gm-Message-State: AOJu0YwHdWssKpPMA2Yb7WOHmPiZ5TkmNnk9MK49dShQOnmW+mmHjgt3
 +UsUQIdK1Z4Ds5i2ZlZIn26K5WROJRXbJAo0gUAwIXnmGx6UgDN0yeJpVcYjivtr6kJYuoBG+Jp
 RbuCNe1orKKWLi70BbOk3XKsfAA5rfTFxIFFUlwktWiJlSYCEvq6tMCGB4v+15hPS0A==
X-Gm-Gg: AfdE7ckuojagHCQVF4FdKORW8Mc2kDtTt8qd2Hq48lSsZ78NngMzshYTBKInnr3LhX1
 FjwEkhOR/v3bRrV6a/4av7IYrAl/s0t43tcXTY/r7b5OUoG6UvuIdlvNrWGXMC9yrLAen0Tu7nR
 0Idf2jRL5NXQNTItJLz4WMeHTWCZAobqw6jsg9omkvP3natNz2kOE/i3b0PKZGi9n7cAVo2ae08
 oY/GWld+V+9twmpzDHhdf1M4QTpFRaZpMNRf8TqCXP3pxTW6dDwBp/OZhR6SEMawlxcPY/l/egS
 19XaF4/5HvINLPSfYipW2KU/0X+ww4RXW8Yb9jr/crrj7dFP500Jc1RuwjMovALZmYWiqC7kZp+
 2KmpmXA7vxvTH/wq7HM4JUQ6Ku5uoabq3RjAWIFmy4mRJ3w==
X-Received: by 2002:a05:6214:469a:b0:8ce:b018:89e1 with SMTP id
 6a1803df08f44-8e403123d56mr89261766d6.32.1782259666250; 
 Tue, 23 Jun 2026 17:07:46 -0700 (PDT)
X-Received: by 2002:a05:6214:469a:b0:8ce:b018:89e1 with SMTP id
 6a1803df08f44-8e403123d56mr89260856d6.32.1782259665555; 
 Tue, 23 Jun 2026 17:07:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 22/24] target/riscv: move riscv_cpu_set_geilen() to
 riscv-imsic
Date: Tue, 23 Jun 2026 21:06:29 -0300
Message-ID: <20260624000632.2149359-23-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3b1fd3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=O0V1kVBzSblzqwnZNHcA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: fGPdAkqpo4IRsuw3ufuQ267VFAvhCpwY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX21j1j5+NtaJb
 DUI3CQmxirYO0CmdEhEIVI0k8t9q92bQBNliIHgu7Xk89YLc1IUTQCyJLSYSsfe1Amm1K5N5hlT
 36xZ2INMasYPW1nD+VQoseg6YzVkJGE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX5RxyhC8KPR0v
 HhUSeUXErQaGFvB5tNdyAkx01plYuKHUs3/Ws/qvlIW0vVNjO2zXtOgOQr2LrClmzFkhAPZIMOs
 jT7Y84S7Z/Bb82Qiklpenp0VFYoxmhR0aJH4L9p7Pj4TQyEfEvnyprEI9ZKfMxQwpjIRXVnX/1B
 6l5kY75PHT01eF2ZL2dlWRZJNqrSdPsyQWwmCz1d8/ADOVx3NXgxXcMK5SJJIa95wfaG/AEQEuG
 +4jkpimkVQTLzG8PcOFKlPP4YHBdOYU58Ohd736mB4BcSAtdYUID+qyYCZlWx915S/od9nYKDCq
 c3jsscfsFIKS+qr1pdytfypo1xPwY6rIi+l+y+zDn4qzLQRPGSEe8RqUYm/E47q/NVGzW2gyIJ2
 gPlbBQnKixLcOrEOFzmLuXvqADQRzg==
X-Proofpoint-ORIG-GUID: fGPdAkqpo4IRsuw3ufuQ267VFAvhCpwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
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

riscv_imsic.c is the only caller.  Having it sitting in the TCG only
cpu_helper.c gets in the way of --disable-tcg for no good reason.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/intc/riscv_imsic.c         | 13 +++++++++++++
 target/riscv/cpu.h            |  1 -
 target/riscv/tcg/cpu_helper.c | 13 -------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7e5b5349ba..ebb55191c7 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -46,6 +46,19 @@
 #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
                                         IMSIC_EISTATE_PENDING)
 
+static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    if (geilen > (TARGET_LONG_BITS - 1)) {
+        return;
+    }
+
+    env->geilen = geilen;
+}
+
 static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 {
     uint32_t i, max_irq, base;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7618110412..7a4d8abe07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index baf5cace2f..a5d864cd24 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    if (geilen > (TARGET_LONG_BITS - 1)) {
-        return;
-    }
-
-    env->geilen = geilen;
-}
-
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.43.0



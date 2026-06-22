Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DECDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkOY-0001XX-5P; Mon, 22 Jun 2026 15:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOK-0001Ok-SL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOH-0001vW-QP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:08 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXFgE1675287
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ihjj3C2nlHW
 Y9mPwHPQFkjWzNQOlvyu29eIM/9zvKro=; b=IxpurBErDgp5q2iqyvNJHWT7t4H
 ABcuAhBrN/PUe/74BVqGnFSVHo/0tFsukZCz03H1OhX+iGH1dvD6ZrJQOZMgJ0J+
 oFqjQBRz/+SL0UpHlvuFGaHenALraBEz1d+GRWf9x3Fmw4Nlbg/VsX53rWkHYuB4
 B95PqMjasjp8kP7nWtAyvK5Ql7X1AD3rzSCBBE1uPOuCTzbKtC6X/LAoD/a4ZSLf
 v3Tn1U7Z70/FHCm8ipBnyoBOiJ8O/fccdHDDan+Dnq+3wCYsGqSGdCyd9PH13kqZ
 nErlap9w/57Af2P/+AhkPGnLtnGGUb7OQorAVHnzSYsASzNcuh8gLWJsgwQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tms5be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157ae36434so735841285a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156774; x=1782761574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihjj3C2nlHWY9mPwHPQFkjWzNQOlvyu29eIM/9zvKro=;
 b=Z1PS0zM3E6LviK5KgiM8cy+z9bqkAVCKjgYvcVHbKwR/vNbJrGiOgiMmooo1hQUJVs
 y4RPkP8//07v/E99QR1Yn1GmGTQ6SA4mkgllHwJGjRU9cjb5mcFVkr4/JJvaMTZAIrDS
 SCLcw0A1hucklqkxVrIXuRCVsAl86UYYCPRiNliwp0AUHNaW/sa0pX7PqgenNs7H5UrM
 WkTF/hSdGSC1IPWFzeMK6nO/sw2c4tlvEDfjXRrAodzg/FaW/bQh0EdGNgWf7u7z0oDy
 0BvnaHANdquQpzcG029qnlNAkEP+34TgKU9QlqEdLaP4p4DJo1oxR2zy1bn1c4ZvKxOa
 QDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156774; x=1782761574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ihjj3C2nlHWY9mPwHPQFkjWzNQOlvyu29eIM/9zvKro=;
 b=A85MWNW6/Mc2VVai3b1V8Aeu6OfkwbrHe8BkKGl8YLo7wghma5I08+iIO/cN4QkOAX
 9C6ATXKUTZ23do+5WZtH8u3h5wTkKGl4sFwIFksvDEDV1Cam3su4MaHNlXgEAQY7O5Ov
 yjsyyjKftLKPBGoA1gJceKFJVzarteYppd9Xko8WmiO/KszVreIrPCLfYU0ZrL6E9zc2
 TpuqqTQt3shzVbRrvfGUj1EQ1Zot4wlhf1k6vqsIu6OCTOOB51VuZKZAEHkgSKMg4x/p
 sPftLVYBecM66EBsklTSUmVPw7v6pHrENTAKHFCMALQIxBqtTQJdXEhUzy0QUzPcqH9/
 KT4A==
X-Gm-Message-State: AOJu0YzCmtxGczMTSeT0ASXRcq8KuwK+lv95q8gYHQrQDHKsVO+JT7YX
 jdUbZXShbf+pFhXggK2M7Sp5cdmPl0WTkBf8d/0MvPI/5QngSayru7eN7PoI4naslw3lS/L325x
 mijOhBg/VeyTl5DdcqULsZGd3GPeNzJLOK/snkLoC8poU9iKObrd8EdFqyDfOR0WrMg==
X-Gm-Gg: AfdE7cnGK8ypNZaqvDi6po38GZqy4OR8SE6qlLQtUm1Xxc2+AL/PMNryPcONGV1X+B6
 PeA+d08dHzCI7EsYhQ7SqWCgCOjNwWMMTHUBhmCM80Y4+ccLnFib23xsQczVO3lNInoATrv6koH
 QpxTyQfm1ZugxtbmjFanV72oyxAk/YHLxGlVgDVRtmK8yW2xnwrURAkhnUp61XeBvatFX8eaw2R
 hGsjJxZwE01+5L7D6o9m2T63gUusNmuuN+DNROPRhHY4i+LOHW/WcIzvqvqXuh+2KRJnu3xeYLj
 4W/JLclbWeCP+Kq8rvwc/Ra1xPJvF/sDVQ+AtsLQVfnt1uKcaQ1t4dzdQ8oq3wnyWDDfquadJTR
 J4KjnPqim2GvnyNzjLgT8kANvf56xn7BD03oUGym6xMd2wQ==
X-Received: by 2002:a05:620a:a0c3:20b0:922:38cc:bb6 with SMTP id
 af79cd13be357-92238cc16c0mr1207835485a.25.1782156773900; 
 Mon, 22 Jun 2026 12:32:53 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c3:20b0:922:38cc:bb6 with SMTP id
 af79cd13be357-92238cc16c0mr1207827385a.25.1782156773232; 
 Mon, 22 Jun 2026 12:32:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 22/24] target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
Date: Mon, 22 Jun 2026 16:31:38 -0300
Message-ID: <20260622193141.1449724-23-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXwdpOvLsX7jB1
 499vG2eznfhpA2+IBJbb6l/tZSJfZXdQPurWU9Vp38FAWMvh4dfpYej3DJAotIo/xvvadWA8EtA
 RJQjBseOfi/V5Z2JPtKzv6FBgS4OVqo=
X-Proofpoint-GUID: i8vz4Ban9pGJz9RxYNMYfhc_Sx219pGz
X-Proofpoint-ORIG-GUID: i8vz4Ban9pGJz9RxYNMYfhc_Sx219pGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX2UJ2njAMekEX
 hLvUSt7oY8vzsTlrkMG8jyQKf2ExC2LStGs/CtfNLHDl4n/cKKeotbI09uSIg+NMOzZQaPiEisz
 uoX/KktfPM+k+BoEJS2X2wrY0OLEJ6y4iR7YDJ/oiFbGnUl4+B/4j+RqaW6M6hMGcszy+X8TAsm
 ZLcth76kO5SRhx9826CCxrVzJOnws6o6NfpRNz1ORupFs1OKgBXfISikmnLW4sXMioBn9BrBUYI
 DZ1/Qa0okwKGEKvzXpNqwsqRaVB5FcuSQ8T2Os2TOEvwJSffQqUgE+YQMczWVk3HTb0/et8wTna
 afZBAtOF/6MUZp5Kn7t4eFTacHfde+M2zMgLlI7i3/VA/xJQDhH8kiYbaDToT1Ulek232yRR4jL
 8TL5+5OIgmTNIpE8nQ89oGGpaBbaQsjkGyW5T+pbouNb0REI+MbhksRgU8PrCHZm/UyBzNaUv7P
 KcfwoKhTZ0W6XHbYlYw==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a398de6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=O0V1kVBzSblzqwnZNHcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
index aa67999005..65d77842b2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -644,7 +644,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 1f13d257f6..3a4e86f6d6 100644
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



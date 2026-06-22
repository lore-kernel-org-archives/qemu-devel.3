Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2578CCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNL-0000RJ-PY; Mon, 22 Jun 2026 15:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNK-0000Pl-1W
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNI-0001n9-EC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:05 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVi791097889
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iiBX3jB3KRa
 aFmijhkaFMDZ7Xd5BoK+FVfH4I41MbPA=; b=liu9Sha6UbzYQpxXqA+RDz3wT/Q
 N0RDtfDiPY4EeV1Nzd6JFJjkrF3kQey+WEcaFm5O+FZvNrBNIQk2mVO2WhdtPO4G
 aXuaRrSYGSc4D18LPEJB9FGDDw8eI/vaglZAqLXKMkrBG135KanZ0W8qFTuCGzEd
 Y5vF+FHzWozUHa2/9inZfZfi1NtY/eaBF19HHErPP/1zM4PhkOgLrcUWBiElJH+C
 TAQC/nlMfzIJNjQ8pmNBUEWPZkI5IOuy3knvf70KY+PHhrPRvjx8B7FaWnoZr5L5
 bsFSsb7g51y9hfPkc8myNzbD/wfajInQcLWTUNA4cmslKMBeidZ0ydbjnRw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3cq1xd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:03 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6ee0bfb5681so5806681137.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156722; x=1782761522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iiBX3jB3KRaaFmijhkaFMDZ7Xd5BoK+FVfH4I41MbPA=;
 b=Fz2YAlcIilZ0qJ0E3s5l0qPoFpYTX6hSw/JcOJFxhzjBKk2++8umAFsVTubb36vfeQ
 TkDCzHuSd2mD92BoJ24PWap2HpJGKEQBJOi/vySpO5Kk3MOvVXcOHuwzjS1CV1p/nhbn
 15EVRvRf26KxOWFBh4bI7OQK8IkHFjkPYDsDDq2hX7ZlRrrSBA4RsbSZxjqHnpVj/84i
 ebpz2KBsYsoFUJXwkP5uwBnL/o4bEa1iG7pS+fAd1akQOJK9ZXUsiu7ygQHx7YmJSg0Y
 0WoffUxYdunC/BAevRDKUzddYMEJ9MQS7YK0LoBgghunH2oH2dgpZkG+ht4j1zCi/Y61
 GaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156722; x=1782761522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iiBX3jB3KRaaFmijhkaFMDZ7Xd5BoK+FVfH4I41MbPA=;
 b=PfxmdGSieDOrvRyiBOCZusyJI6zn1Mo2EdmLIS3Tjwnbrdqj8g0x5KteUFhFlbuxfH
 KKotv22LL4plzbvWM+UpxECUtIfQas3JSqY/bw4YYls26PfaciH8kcwQcQy4u7XIe1aY
 3cFk8Wx9siYtlg5rO8Gkta6mUNQ6jwGOpkcOampkbCvjCuW9ddbfhtbYfsnsKwNXubCr
 jVLmRgJkNs1nZJDIGR50AZhKyn5Y+qFTDTsKfP2BLfYB5tlajiAdQf4eR1/vVtnFNpou
 QrQgkvjEibyNV9vIhDpQr8S0RDbF8XF7gfOPhghhu6R/Yi/5fyWznhsVrCnoB1luxfdy
 PFGg==
X-Gm-Message-State: AOJu0YwLNS+ciocgb+J2068PWNTgMYoYvr4DbopExfAYWyj+Sq9cOpzE
 uYCvqXvP6kugSht0ogOUN4nOGRfitTouoLnWAgY7evKi+QaVCWXFuCUlc25yoRvWA0eut6odByj
 v6mUBetCwdIxRQXmkBGkFSAfU9Z3mOD2cNY6osmmqJw/ZMG7j47SiBB+hfYPDWpSiiA==
X-Gm-Gg: AfdE7cmgEG6KrVtQ15evc6cqpH9Ikt54UpN3osfQ2jeIVjmoQJrykqNHZ+aztRuC2Eh
 ovdmTK5s0pzMFZvPc4L93Gsi0KThW65m2DN4i2NKJBXrpOU4LjuMFxjcygKFY4u3buBXzaGwgs/
 VfXRN9RcEvKgYTJ9MtvA7LE0t8I+GEeuf8ZeW9QgRsqlKj+JVcolurnyqbNWG4KFBWue81oP1DL
 Q/zUsZF27o2giHSWMlGZubRSU+TOrPoqljKeyHm8DotFar/QvEjNRu4UTj/UFywpnVrJGWcQVaB
 CRD6kficnCBEuZQk236upwVga32eeDry3NjdJBGnA1KRPd7xsfy6F1Fb9pQOele9l5SaCHl2Cgn
 VL5i7XZ52VAMKQjx53UE1/+/XrS3753vMqSFp+bYUi+t6Hw==
X-Received: by 2002:a05:6102:32c3:b0:631:2624:e5ec with SMTP id
 ada2fe7eead31-72a788646a5mr9834126137.16.1782156721955; 
 Mon, 22 Jun 2026 12:32:01 -0700 (PDT)
X-Received: by 2002:a05:6102:32c3:b0:631:2624:e5ec with SMTP id
 ada2fe7eead31-72a788646a5mr9834027137.16.1782156721306; 
 Mon, 22 Jun 2026 12:32:01 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/24] target/riscv/machine.c: do not migrate pmp state with
 kvm
Date: Mon, 22 Jun 2026 16:31:19 -0300
Message-ID: <20260622193141.1449724-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DksOXDXmsKlO0BDyO9xUFO2FV98O-bIk
X-Authority-Analysis: v=2.4 cv=VKXtWdPX c=1 sm=1 tr=0 ts=6a398db3 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=4aX5uSYTwWxERF7RVPIA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: DksOXDXmsKlO0BDyO9xUFO2FV98O-bIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX6iXKNajQd+uy
 CVM+CbMebI4CxRuqAx2D+InS3NnFAmtP0XuZfLOUCUNEWOgjzhxWIVJYFnQgU2LuOup4vQsuSgr
 xL2WoY9yeM+vbl/bGDlLaoLF6tNrc3n617ZszBnDR7fYPppFffk82uFoLJWAkOq5zCg0dYga+1y
 jf57aY9BYHQpasRYfB3HECsU6ROA4nKvDIHxUrykE/mDIG1l9Ag4B8zgnmL/wvtdQr5BxzLONuz
 0g2+VXjSVYewlAbz+8gHf1yc59fp1oCOuynaE5n4cyRhp8/W3/uP5MbgTcwffRnrH+2wU7mD3/q
 JY9tVyYTFE2CLUnJs8A/+toa6leac8bu6wGqsC0tguB/+Pz0ikTUUNDflOaD+1k//zDOQUr0Tpi
 1IyOI0dT06e1CBDebolP/kT+JbQtJ5lsIFxvb1IWFERebUW/OYQrUjHwsti1dx6xJrkuZonszFV
 ibplnW4rcbYvhTsS+Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXxcG5m+P+F+7K
 Anb2ZbFF1O6stMC9W4w1gCwBTOsA4kJF5ix6Fs4pGy9H7hr9JAYTzGEeNJzXl9JMbZLxouCaleN
 /Ey160yqoZocC6RLcQ8NWFCpthc2kqo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
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

The PMP emulation isn't present in the KVM driver.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/machine.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ba96ceceef..bd93d6f3a8 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
+#include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/debug.h"
@@ -29,6 +30,10 @@ static bool pmp_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
+    if (kvm_enabled()) {
+        return false;
+    }
+
     return cpu->cfg.pmp;
 }
 
@@ -39,10 +44,12 @@ static int pmp_post_load(void *opaque, int version_id)
     int i;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < pmp_regions; i++) {
-        pmp_update_rule_addr(env, i);
+    if (tcg_enabled()) {
+        for (i = 0; i < pmp_regions; i++) {
+            pmp_update_rule_addr(env, i);
+        }
+        pmp_update_rule_nums(env);
     }
-    pmp_update_rule_nums(env);
 
     return 0;
 }
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D74CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNQ-0000Sr-8F; Mon, 22 Jun 2026 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNN-0000Rc-B1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNL-0001o6-AP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVoJf3842519
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s9Oa2MR8QAO
 3i/c+5hYDpj196wEltw5TlciP3p8bU50=; b=JVRMFm0Evfv/hyO4+5mMD7o3qay
 QjPjapEtltfOvE11trdUgQxN+MONPUscpysss09x4aXzCNxnUtmj5QhZi7ZKAhIX
 T9mkhyH5QrZqFSBFOPEuS0/9bs0Jr0ipDVb002ytfUl4XdvK15L3YiYEvjW3iITw
 etNkuJlgMmZTKssQZhTOO+gDQKZYH2Vz4Fu/Dq49ye5I0JWlu6bvPsj1aBijMeKo
 kkcrnJRzU7Gy1Rxlvp6YYiNszFZV9HDlxtxZY4BvWLBRGOe7qjDpiRGd5Hjl79XM
 nD+HNZTWjmNaHN2SDSgEw6T5kymbXfyEdoOWlMivFYMY5RrUYYR/dTdnqbg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yht178-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6751db2792dso3503186137.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156725; x=1782761525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9Oa2MR8QAO3i/c+5hYDpj196wEltw5TlciP3p8bU50=;
 b=JIiCCLfN+ROIHJfGRSMOPQahpw9k3iUcDLXg4zdNnSGMqrT+3qPs8IW4m1LWJvpKhN
 Ygdde4GeIPVJuUddbHvP0utQNmwqgZ4yzCK5soYvsLDiaAEj1C2g8CgBdfx46Ng4Pn/3
 UOKi7w9qN0AYJuca/nURLyFC9au2rqs+ikMjXcyLJ8XycMtwvUYIG4oIOI7h65+93Xzf
 gHFsUKS0c3GXbljswxpvJ0nGTRKeo7vOOwsNZfYXe9thFXlB32h/riBjZj1ouzb9g+Ra
 laDEjvNBWh6EFI1ujLPN3LivdC5bdv7pPpOi+JR8UfBop1b0wZZBz1M7VgrdqthI82y7
 QzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156725; x=1782761525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s9Oa2MR8QAO3i/c+5hYDpj196wEltw5TlciP3p8bU50=;
 b=MrS+mg1k27YrmQuiTeuJRwx6d6n99GfsT8uxmb2iLUrSVTNkbHSdL1q6xQdDr20o1H
 pCfCv7s0KBmgGBvVvPvl3izjFrUPWc7NsVtsqwJ2699eQtkuvdPFv1TvHCpWQwmXZm02
 x5VSPNXodlVnzsknQnPx1NMS5RtLF9/07g1WSyoQdLNS3oC7+ehXHQdjWwrUWIgG/6zv
 ZNHqz7OIwAiMqFl2d3MgyZ75KFL8h9/z9iaAAFhRVXYHR2wbyzNsVc8JoG7C9IJz6FYX
 EHdGPMhMr7CgsrboiSf3y5i7qAL+wvUfOklPu2ujBZlRCChDqFonUiVlpDIZbQDNsLY+
 rSFA==
X-Gm-Message-State: AOJu0YzupVPI2g2trulU+Db99sClcMZTY2QKEhu8NiTZT2HwSTCs+/Jq
 yoffro5VpG+1Cj3p58i0x+tIUZeFPOFQK4GyIKiHQZEQGN0sHIr7dBAgad2NZNhnEGCxx8EpWXT
 AWTti+a7x33+ESTzrfNI1izXYdRDqZ3CWe3WWlOEaHEkXGA3ClcK1sgo5Qdk4nAZJPw==
X-Gm-Gg: AfdE7clDg7oHMjJgKgTbnT2HApRLhuDft5ZGiawZpUq9v0SDmDtNhju1XP7KFUVNmFD
 X0ETxJOp2MgndcFfi/Fulr5Ms83fOhMaE11W1HtrP2ywxNfd28Pzwa4ZlM0SYEWNDrMWm+6vLJy
 ETxzbK8o5vufq5PsJ3t6aQsOf2ED1Zxw8biqlUD705bCQH0el2DjuTBE5pd407Y+9+/49bLbs4v
 H+f6HeqOO4CLtmJ+I0KCIFbq23xZzRjPgYaWKHAmzGfsvbxLoCqJsA4XdJojTyCx+lNR1OK7kks
 8fg/X7aCuRERv7J8rK3XF/afTlfeUKCdXQY39HH+eRQu83fJYBgN9SXA752NQspz7p60UPLEL+x
 cCc2xWUWcuX4FyZqitBoIHPYzmJMoXPebMeSIJu8WyVftVA==
X-Received: by 2002:a05:6102:8601:20b0:6f0:3ba3:7d84 with SMTP id
 ada2fe7eead31-72a75fa3c17mr6119449137.5.1782156724893; 
 Mon, 22 Jun 2026 12:32:04 -0700 (PDT)
X-Received: by 2002:a05:6102:8601:20b0:6f0:3ba3:7d84 with SMTP id
 ada2fe7eead31-72a75fa3c17mr6119405137.5.1782156724495; 
 Mon, 22 Jun 2026 12:32:04 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:03 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 04/24] target/riscv: move pmp files to tcg subdir
Date: Mon, 22 Jun 2026 16:31:20 -0300
Message-ID: <20260622193141.1449724-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX5CgyX1xnPJNg
 0rcrfBN6QOsDMr6/law3JpJQCzTObMN9vzIHERvsLBs8GZGFSBEkGwUxO2kNhY7qqUR348nob58
 uaV4vicJ86serzvuGWoedv8Dhs97L8Y=
X-Proofpoint-ORIG-GUID: w7h481vDnycNJQ-sv8uUms9QslKIeAlO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX7qYtXnctIAnF
 WZCZHzWzpbOVDu8B840Udz/TG5bONCVZ91L9L7AWXaCUimIkJ54zGrxLXOk3peDGvSsOyjDxBss
 GV3+K0GrNFq+pVSYPjQ1ESeW7YZaf5davUzW78Ur7zMlr3Zvxk7o1MbT2GvB9gPbIhSFLzNxtyo
 xK1LmkEQnDKeLuQ9KBcyHd5z0V3vt0JAX63TJyR4H2/ByKDuCiUqpC3GpR7aALUo0T4XkXWBYM9
 YefSLNyef0BAo9YFpsF+xxORSGeL3zEbaWBTLjF2o8DxMn01/qkQLqTKZyrqW6zk59suP3cA9vf
 jtB+lI3LrmXMEydba765a5qmBkKS/iAOpJv5KSbIFuqX1NdRZLuzCjgWWb2iyo6Sj2mwyvwsoGL
 FCH2dPPJNFwrYX5QeQd+515JLsFAleI+GqKIyGRU1YTvySTfmnkPyXiIanHT0PXtlG+iiATt7nv
 vPSAYwChw/Ld8RPOJ3Q==
X-Proofpoint-GUID: w7h481vDnycNJQ-sv8uUms9QslKIeAlO
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a398db5 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=fhcCIlfuyIdyhw9Sb1oA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
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

A trivial header change is required too.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h           | 2 +-
 target/riscv/meson.build     | 1 -
 target/riscv/tcg/meson.build | 1 +
 target/riscv/{ => tcg}/pmp.c | 0
 target/riscv/{ => tcg}/pmp.h | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename target/riscv/{ => tcg}/pmp.c (100%)
 rename target/riscv/{ => tcg}/pmp.h (100%)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bdd28d329b..f0c78c1474 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -183,7 +183,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define MMU_USER_IDX 3
 
 #if !defined(CONFIG_USER_ONLY)
-#include "pmp.h"
+#include "tcg/pmp.h"
 #endif
 
 #define RV_VLEN_MAX 1024
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 61874ed0af..42d0f6d538 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,6 @@ riscv_ss.add(files(
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
-  'pmp.c',
   'monitor.c',
   'machine.c',
   'time_helper.c',
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 5684fcf985..a05ab642f4 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -21,6 +21,7 @@ riscv_ss.add(files(
 riscv_system_ss.add(files(
   'debug.c',
   'mips_csr.c',
+  'pmp.c',
   'pmu.c',
   'th_csr.c',
 ))
diff --git a/target/riscv/pmp.c b/target/riscv/tcg/pmp.c
similarity index 100%
rename from target/riscv/pmp.c
rename to target/riscv/tcg/pmp.c
diff --git a/target/riscv/pmp.h b/target/riscv/tcg/pmp.h
similarity index 100%
rename from target/riscv/pmp.h
rename to target/riscv/tcg/pmp.h
-- 
2.43.0



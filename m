Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D5BCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZIB-0008KO-4y; Tue, 16 Jun 2026 15:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZI8-00081w-M2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZZI6-0004g0-6L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:17:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOhvN4037923
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +AN7stYLK7JPdjPiEG66VSBt9lEsW5E/TgBGfmi/f5Y=; b=UlvVLiLNtPlp/t1h
 1ERI8GmcIz/W3LVSGHHQqCzU6Pd5IhXBiPllDTvn1YDVrbC5orKfy3bXbCTxWhEZ
 hG/iFsYgLKx4JE2yGU65+wzfWIVNb0bN+DcZLhBOt2jnMrzmvqhrjyEdQygYX8G8
 bT/d5HysiglhhcWEMZtJNBc9LBAfd3gXAmQ1ze9LRZuONUgAn77ud38hNqtzad1s
 w2+pT4wx+w9indBXXQV+Qou2xZPOO/0X8JSo34iFY+Zf9IPX6LJ3mSucoMCR+1w5
 NC4G1qVepY8Ei9V6ycs5s3mOxEnmzgsYyDH6nngipcUu6SRF8mVkBAwh8tbftlQl
 YdUcow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1763gcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:17:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915757be497so706825885a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781637460; x=1782242260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AN7stYLK7JPdjPiEG66VSBt9lEsW5E/TgBGfmi/f5Y=;
 b=GOubqqZZT5di+NZt7ZtnWxSbv3s5z+227Fq1hkff/HvDfWB+rF3KrH40Dme4Bs5maA
 848vmybClxOOJnPrSNGcoXdeUk1PwORf6c3ggLEsTKMYfvaXqnJe+G7gEHB/DpfAZieJ
 m+NgYwOpJ66MEBCCMeWFD+mTiJWo564w+s6NN3DaNp/YHSElgs+Pexg3FedHm7rVaCf1
 0BxS5Itx6rz537BHugEyKr8kNGDSWCqE3njLLqhlg6FaXR/JfY1tSzkNwHdHP4A6sDTi
 wCMayWxrCRJUFczjCgcqZ9h0I+Q0L+1Tel6mAGx2Zgtt0EuvqTe/F6Lge1DrWWLxsMbK
 yQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637460; x=1782242260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AN7stYLK7JPdjPiEG66VSBt9lEsW5E/TgBGfmi/f5Y=;
 b=Vb1ZoVf7uULYOkFIQP2DGXhZmiPS8neyB0lOEfrrZP6gI3uLvQUlsjXwHQy89eFe8J
 CrzU6e4BGx57S0adcB2ihQcWyXWQnnRz5YAWmLp1fI6W1NqPwjTDj9g09pAw64IqBKFq
 cujnyaSWlzGdwly1HJY7jf4a+e9eZIrL/NB+QgyD0ET/Ogu7XVyRPVr074Vrwa+wZASx
 9cMC8B9wI4Mqv230F+ov3vRkQ9uuDW3CejpRBxSCjQi+My3/7WNJCmokBAM87C5BR1zp
 vk2Wo0HQQc5RCMg6oJvq4nGfeYAh0EyF5pqSqOsje/px96HgcVNitjqzSDLKnUGXj9oN
 qTHQ==
X-Gm-Message-State: AOJu0Yy6/vFwzuA0rMVQGimk29X9D+3VTjvXMx8+H/V1FvpeWMwwdtW8
 4Ux1wiCK0uz5ACqp7fWkK1hFplfnTjxyrB/aUC8YLkKHPjbAMPEoenWFHSlhyuWjStsVvo6iUH8
 qdk936+5lOkWJzD0VuG8oZ6+FfSg2QpnvJ1aSBeRR+8LFKGcmFZpvbDJPa7GI5RaARg==
X-Gm-Gg: Acq92OGDdS7P3yP2tDIEQbQcaD+1T+10vl9aWS4cx2fZkoZFQVVlN8s94G54/4HslCE
 9Tfd4R1zvEMl0lvYHdvR9UQmXwIFwmHNn9sdaQS05j//XCxT8n6Clj5LA8zv1IiGaDDzPNbeE0x
 mD9rGvy63dt3uJROsN8Nzrc+AlOe/hQ4wsfRy3dg4MPEdOg6mqWkHEY0PGI3YoqsDSliN6KGcEY
 uTG2HuYuHNPCkXBhX4zwfim33b0GpfNGhNR9WZMzW9u0IbNyLkV+sOrkCPjqJ1e2gxBTgHYeZWi
 PKHDgTvYJdMJsrFVB4HgfZUsBOasmJyHa3n63qn0hxdaGiRxpoSbR84NvERBer3bTFqGuzEXt7L
 5eT6PJeYpQayJjIbMJgbvLqOpr9V+nqZei65kPjdraP8p0BP2p1fBEu6y6TS3jVvvOHbw1us5Aq
 YaV3A=
X-Received: by 2002:a05:620a:46a4:b0:915:820f:c78e with SMTP id
 af79cd13be357-91dbcc17463mr43955085a.52.1781637459891; 
 Tue, 16 Jun 2026 12:17:39 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:915:820f:c78e with SMTP id
 af79cd13be357-91dbcc17463mr43949785a.52.1781637459407; 
 Tue, 16 Jun 2026 12:17:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3fcfsm41831484f8f.26.2026.06.16.12.17.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 12:17:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 03/10] accel/tcg: Remove cpu_loop_exit() stub
Date: Tue, 16 Jun 2026 21:17:09 +0200
Message-ID: <20260616191716.12932-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616191716.12932-1-philmd@oss.qualcomm.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: U5zAQYVpNGp0v-sNWLXmbDFGQr2XuouU
X-Proofpoint-ORIG-GUID: U5zAQYVpNGp0v-sNWLXmbDFGQr2XuouU
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a31a154 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=nTtTSeO8Bg4HjSiC9DoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfX2xlqdsiKGwzu
 v4KVtlmTvmEB5zC0NJU1x2HbAX2gjRFG4IBu9VCUZJ6pB3CWY2ALNIRGaR8CYTxcQLINQAW8nN2
 QVO4+i0UhXg2P3wIZlOhOltibHwKors=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5NiBTYWx0ZWRfXwkPBdH7E4ncm
 sD9eKLxAvRdcp5RglafrPjQgmP2mKCzsBsAsLFsW6N/Aod9bLWCTpAbGcQe0yIussOHeYLfB9mY
 H/Mqx2BH4AbGyTRsDCTWO7TCmpwxejElEjj9FmBALvcO/uRe33yiWlSfmmnAchmicMa8ByZI/xN
 760eXrZ1jATcTdQtz+4VebrJSPNXCYcvWGA0IyVotksl77Dwx1v2tWIKf9dMFmkfF55ctXcqfHA
 z3P2FN8y73kuj7jrB4j+AAUUWmu4Co/xhxWzay7jZegrzcezIdaj7Ndsa0hhqtu9JxPNQaESWFS
 QWWusuJY4PuVcJfWWWxYhXtR0bpmEGNayfveAycc36DI8zaLoNHWNIjU4tCwBuSwDLSKT4uaMsV
 VzLGCqzKRCUXzHkMKXbFwWApTVuo+ZGxbpqQ4DYLunF19YIJtYeytT+cT9vFJckfUj1C+eh9DOV
 HtYm7kGNJPBIpCNkIPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160196
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

Last commit removed the last non-TCG use of cpu_loop_exit().
This method is now only called within TCG files, so we can
remove its stub for non-TCG accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/stubs/tcg-stub.c  | 20 --------------------
 accel/stubs/meson.build |  1 -
 2 files changed, 21 deletions(-)
 delete mode 100644 accel/stubs/tcg-stub.c

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
deleted file mode 100644
index 855e5d43171..00000000000
--- a/accel/stubs/tcg-stub.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * QEMU TCG accelerator stub
- *
- * Copyright Red Hat, Inc. 2013
- *
- * Author: Paolo Bonzini     <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/tcg.h"
-#include "exec/cpu-common.h"
-
-G_NORETURN void cpu_loop_exit(CPUState *cpu)
-{
-    g_assert_not_reached();
-}
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index ccad583e647..7c6d7ad9432 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,7 +4,6 @@ stub_ss.add(files(
   'nitro-stub.c',
   'mshv-stub.c',
   'nvmm-stub.c',
-  'tcg-stub.c',
   'whpx-stub.c',
   'xen-stub.c',
 ))
-- 
2.53.0



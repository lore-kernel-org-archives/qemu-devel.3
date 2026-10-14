Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A7FCC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g0-0006wc-8e; Wed, 14 Oct 2026 19:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fw-0006vr-Qz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8fu-0006Q9-D8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EHSDgT843758
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7/EXswh2qfr
 dBBY0CFrHqUy38gNfwgqUM1b42qR3v+s=; b=D90xQ/UI8i1ZVvjWiCqBVKoxkh1
 EgFSkAchEaEGW0+/ymYjD7PDb/nVgz+45gdauwEU/zEuPamII5F+jTII+X4YERym
 fiiMhvAdC2IX3SmZfuLaFQOPWOgeBS6eY0/l8reI6surSrY8JSTCaIUDDMxKjtqU
 qC3JcFHNoijzF6EUEx+54VfJKwSvHm8Ee/InE13A0CUYGk4ErLDkslszFKVbDYgi
 7HuNXRz2tdX1hBvxO40MATW0EQuDS+k3DkGg/0HEthY/9Y6M6zzHCAURzI8wQlZW
 cVoXczMLtqvt8HjDrjvwh+E9AsGIWqmpqTPTlGtv2mr4Jh8+LH7zTFMvTfw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4ws6n1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3580c07911eso12288373eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021580; x=1792626380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/EXswh2qfrdBBY0CFrHqUy38gNfwgqUM1b42qR3v+s=;
 b=hU6evbB/yWoe4ipYw4LXpjQo/QcTNmcA6rkwtxHorUSXNruLbfNkqqS9YKo8fEkJeC
 045vHxfGJo1o8/NtU4qcBOX9nW7hy3Us3NrHJutvbipsDEDiGjNuNI94uSftbFmkLTy5
 l8Xyw8CtxWe9Wqqm/13PC6K+UPHj/kOtqOpjCkWsovWLGphqmEqVHvpoGMg1JzoblNOS
 F7GmNxhw+WFEltyu2S4ilxhEVPVyv7lHLK5kxc6DYxneN2u+rUoSnbYrWBQUQ67BJUoq
 25PbBGqaWuT/6b7nBed6sQAmtLNaiDIVGq3rYPOxjvEdBgnjvdi41oKxnAw9i4L9Rsmj
 HYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021580; x=1792626380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7/EXswh2qfrdBBY0CFrHqUy38gNfwgqUM1b42qR3v+s=;
 b=HAcNIRtf8YfuzSKwBt1O9r+dqkTMHf1IcEBUOWXstVR9DqGhK0lffCzaGPRQ+BKN5N
 MtVoMQ8oQxuU7ybKIyUJwqVhTpNUc1YhqpvouA7YJL6SFCBdhaxyTnwNXQJi79OODFFP
 YTe3Wq5YoihGZHPeixq6AgRvyTolXU3Z1NqdYQJAUSGPGrFyK4Wt2Z+gqEsPejcLarWZ
 rMj0NG5TWKZ+vQ47V6KOvO2dZXn7pJ7KU2VG5eliSSncc8NBfp/Vgsd49muAA1ub5DbU
 PhKCCKLAQgNqKuP8usM+p7p/KaFiu70+AjhtJ2EksucKJfsBbkaLZmZDn7etcxOXZGa+
 yxbA==
X-Gm-Message-State: AFq9FYIQRtwqC8pNY7EyJVSsUCbnD5945bZsGTTMFp2XfYSlbpVXDSX1
 Ukb2Omk6/zM4d1Qe61KUiUAxorzeRvBVT/NlGygozEqNBTWGZ6CNMYMMkqx+eU7z8WR15uq5Ijh
 x+AyXvKUwCaZy1+1QoGdHv6n200YBbP10RUI8OxKjOEiStlJMnJEnxo5/pzdQUXmbWA==
X-Gm-Gg: AYBFou11jsh/VvVk1++qssAoK9VlC/hXrX1y3hbDcz40S+jlGKn+ag5pNP96Lu2mm5+
 KxAirQwXeMqLKuCo8CJewy+pbPT4xMsPNuQDGPzh+0AxayDNjuK36RER7WgC87ZD8USRIrhVX3C
 j7H7pOrTp7XwMSDIdkQVdKJQoK2lTi/0WjML/ZFJWVaR4GzrixnwjgzYjtclaVqHtiSV8bThVk+
 bfmZErYl2Y6pM9+/jVFgb/7bweTzLw+QIYhnCGmKO0XRMIBj96GgeIO3NacOBQ45GVlnWAVjR8r
 Ijtye8eBR8T/jtsvpQfmsx7qBX+fv0IFttupiArmigiOEPIe/f4dR2drkfvKHI8+mH7cOHisoWz
 ULJqlJ0A56qpfpHLAxc9aBs/vsJLPLeC46dYjMmhKevM1RcOGO1s2TW21AkwS
X-Received: by 2002:a05:7301:2003:b0:35d:9516:eb26 with SMTP id
 5a478bee46e88-35d95266129mr5020220eec.13.1792021579897; 
 Wed, 14 Oct 2026 16:46:19 -0700 (PDT)
X-Received: by 2002:a05:7301:2003:b0:35d:9516:eb26 with SMTP id
 5a478bee46e88-35d95266129mr5020181eec.13.1792021579042; 
 Wed, 14 Oct 2026 16:46:19 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/19] hw/core/cpu: declare dump ops
Date: Wed, 14 Oct 2026 23:45:47 +0000
Message-ID: <20261014234605.209084-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX6BLVsX+PqIkK
 tyPwVK/C6amIMzY8zsr3GTl8fLTJaGsaf99nqnkDkTkz3newo87vKJqV2lAevblhbtf4WzANjsm
 UQHlLTZh6T2Cx7eNqRzUGejCAHBs7GM=
X-Proofpoint-ORIG-GUID: CM9Ror87Yn81aTJFDweAilS16Vl8uXgZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX4I1TyLUVOai4
 m4biark8NCxUOVF+f/tKA8qlFn+21KJNL4sdbUtY29R3J9JKsne8Q9wXd0dzmaIglXm+b3lJ8BE
 B2dnS0zstmWoVyPA4ARW1sQrdIauq0NNL+txDihjmyBskYthJ9wOulup1sY+SiamDm3Ffwldf0A
 200t1F6Xi941UPJEEwwEL/iZicNvsCE+HPPOQwHLFCwTFfKnrnpfzf93kgnJkrVCZSwnvx+Osno
 jMz1UAQZj+sYEH2AMZDrbquQKh1V+sr2FSGZnThCW5rwNBRYmRN8GiQDOvMj2ffhcOcWsAbxdth
 tEQ980UnOjNzTFgYzrMRbWa4kWhre90J0NFsMl16tYlsvi1nUYxXhzdg2QvwhzY8LbttGKr2lu5
 SCAo6e0W3hHPnvQGfda/8Y+mqsIuLiGuukqBEgiMVy+M/fxlr+LQZJUm2ypFH81gaVCCapapHpl
 Ajo+mOek00wxHgXLVnA==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0144d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Bx8dwOJmyrPxMmO5TvEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: CM9Ror87Yn81aTJFDweAilS16Vl8uXgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows a specific cpu to declare its implementation of the
operations needed by dump, starting with get_dump_info.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h          |  6 ++++++
 include/hw/core/dump-cpu-ops.h | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/hw/core/dump-cpu-ops.h

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 456154df6f6..eb8747b9bcf 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -98,6 +98,9 @@ struct AccelCPUClass;
 /* see sysemu-cpu-ops.h */
 struct SysemuCPUOps;
 
+/* see dump-cpu-ops.h */
+struct DumpCPUOps;
+
 /* see semihosting/common-semi.h */
 struct SemihostingCPUOps;
 
@@ -186,6 +189,9 @@ struct CPUClass {
     /* when system emulation is not available, this pointer is NULL */
     const struct SysemuCPUOps *sysemu_ops;
 
+    /* when target does not implement dump ops, this pointer is NULL */
+    const struct DumpCPUOps *dump_ops;
+
 #ifdef CONFIG_TCG
     /* when TCG is not available, this pointer is NULL */
     const TCGCPUOps *tcg_ops;
diff --git a/include/hw/core/dump-cpu-ops.h b/include/hw/core/dump-cpu-ops.h
new file mode 100644
index 00000000000..5e8a89cbbea
--- /dev/null
+++ b/include/hw/core/dump-cpu-ops.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CPU operations specific to dump
+ */
+
+#ifndef DUMP_CPU_OPS_H
+#define DUMP_CPU_OPS_H
+
+#include "hw/core/cpu.h"
+#include "system/dump-arch.h"
+
+/*
+ * struct DumpCPUOps: Dump operations specific to a CPU class
+ */
+typedef struct DumpCPUOps {
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     * Returns 0 on success, or -1 if the guest memory can't be dumped.
+     */
+    int (*get_dump_info)(const CPUState *cs, ArchDumpInfo *info,
+                         const struct GuestPhysBlockList *guest_phys_blocks);
+} DumpCPUOps;
+
+#endif /* DUMP_CPU_OPS_H */
-- 
2.43.0



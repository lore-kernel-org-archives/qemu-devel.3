Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F24C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJP-00008C-B3; Wed, 05 Aug 2026 14:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgJ9-00005h-J0
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgJ0-0007gQ-67
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:33 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSOeb3673620
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AWC3jvrWcnN
 mnr5H6oLP/K98MOvHsWoX9ZmIMuKsGLc=; b=b+YOsILjabdM+1Tsrd61FhW21Dw
 0WSbI00nogBhzjKLLCCvFE1b1C1cJ9rAzyM5SJxXFwg5ELuJe+uZ2LnXQIi4sHgo
 DKBOqGZRwGXv7ZNLm/nJq4toQ1nLoFphZQoopqKc4z7BuyvDK8qulcrHkVS7jzy9
 WhXzFp1W2bBpjcsSEd2alAZ3DFbBBGvn8ZRmOtG6MOd/tB9LDeeSOkw3ASMBwyOf
 kzT/0epObw/wfgdBRyDsF+OceE9GyvROZT0lCKUVQTOGjH5ujHzuqo/DgT5kZVBA
 URL+qswsM7ZKfHOy+Gz6XSZx9m2xTqbNNeHf13mC1rk4gpYa7wQEbKKB+KA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv3w6a2jb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ea24a2db9so154884685a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954327; x=1786559127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWC3jvrWcnNmnr5H6oLP/K98MOvHsWoX9ZmIMuKsGLc=;
 b=Sjz2KGEJLWG2e8YW76/709sPhOmV/Yhp4NG75DQuMq/z78kcIyL/dSiSB9yf2cl1FG
 hXzjxQPvjSNj3/h404T3J+5YK97B7nVqw/nkEQD5s5Xgg9TX66eMeNVYmg6rf9YHXEDQ
 wJxQrB96SnoIIw9cQ6NWKvkpkGOx90cr0I4hor8FmAjXTbXfSjeDpjYSGiou1SfALiOe
 LMvMD7dkewaKXk+CkIs+4chpxtfjDd8DKVoZ7Xa4MWFZ9MIaQv4ew5vg96sTInXsBpao
 HL/yNje1n98MRiDljTBYzniJ8QtRiCLyvfW9d03t3IaTCdxSYxcVzW5C03pOEaKBNwmh
 xeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954327; x=1786559127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AWC3jvrWcnNmnr5H6oLP/K98MOvHsWoX9ZmIMuKsGLc=;
 b=OuoHRRVwKq+lghM04YX9h5kEkmVzefNYH6tVc7RafDdtfQLNOS0KO+bs8jJGqUxTr6
 QltnfARzHRiODJ7rCIuG4QbBX8SRDvn35FIKMcOgU6P3LOWYRGJ2Q2zCx1pCTNJh9YER
 WTyr1DMeSOksWct9yg4WcjwLAvRn2zxV4GMJ/u41gUk4FlPDeBKsy1EkCpu/WdoPXW5Y
 UuJqIW931TLBlIP40hz6M556VxBOsTNO8GLytfuPU97i8AizNnJqBPF92qn6H29CzkU2
 UhSv+OHuhs3WRB8F3P2jicFHUkNRV07AwK/zpeBUSdh4PGxr3pr5oc9ZfRbQQxxNW2oc
 F0YQ==
X-Gm-Message-State: AOJu0YwrbE1C2obftXx2+MBTVoWb9l295PRPgios0wjfSxz5ZmdF9vEG
 V7FXJltuwPBmyIKUbUUNKYYpmlXGL5SQXvRyoFOdqiioFZQUOqkcFvSDrgRi5ElvjXCuKvMs45+
 SWfRFHw7refb9m3hVoTaGCB5P10IOb3V4UQxSHtql/JkmfJlE6jrRx/csFXgaZwcBHA==
X-Gm-Gg: AR+sD11w5Yi1H02sUFuPZ0RjS5EgGrkTAiZMJSI60dLMomJ/rg4qdBb8W18b6fvqKrb
 e4Q8kxBpmtYOsdrCC1mB7N/D58RpVbHGvtyBrEU4Os31YLBuOf+rLgSCvJ37/gTo27MwVjIpxe1
 A8Uh+LpOXj8kmrsr7cbPzWeOBT4NphDItAnioDKaUGpttuXsSO3tlISwZhy9Yx9S2ZH3SPn2+LG
 CV9eLtZoCt4dT+TAJeG/CPCyQBc5yQ8osEsiy5aLJsCGqtjPBYfgtYtdBxmdrJ984DPluO05CXb
 rUJw666YBSjtfk5B7ZLOhftp0PKOTpDmNyfcBfYjDeYoUOdmjyC/lWAhVWtD5Xd/yjgPX0XqXkj
 Xd/JhwgZFjjFlUy9/nERKq9eecZb5FrmTKD+wTw==
X-Received: by 2002:a05:620a:a2dc:20b0:92e:8aed:4785 with SMTP id
 af79cd13be357-936490e7a4bmr661847485a.25.1785954326998; 
 Wed, 05 Aug 2026 11:25:26 -0700 (PDT)
X-Received: by 2002:a05:620a:a2dc:20b0:92e:8aed:4785 with SMTP id
 af79cd13be357-936490e7a4bmr661843685a.25.1785954326455; 
 Wed, 05 Aug 2026 11:25:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/5] docs/specs: add RISC-V CPU Debug support info
Date: Wed,  5 Aug 2026 15:25:06 -0300
Message-ID: <20260805182506.2943757-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C0WOPJ-JVtn7YU48E-wUj8ruu21Bs879
X-Proofpoint-ORIG-GUID: C0WOPJ-JVtn7YU48E-wUj8ruu21Bs879
X-Authority-Analysis: v=2.4 cv=a48AM0SF c=1 sm=1 tr=0 ts=6a738018 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=HwFc7jivAAAA:8
 a=EUspDBNiAAAA:8 a=hLHZJHzLvL1iQ8yadmQA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=kr7TZk85JJIQSqC0cl8G:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX31FaBFBl8mXx
 1rJRyAe8crAwuLbSU3Ax00rcQE/Qb7Y+eWglrDLXWAsulYnHjlWZm8jxQo6l69Qd8uL6eZA7oJZ
 MajHakFAwGblGXHzdiApg7iCAFuscgI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfXyH5SK/xkWm6h
 B++l535nPiFi8BpWtv60iDpzHL8G+9Lx6yTBKe8CDHOChrVICjkKYGIa/DG1a9pBd6U95Xd3oba
 3oi4xh7eNPnMCNNYtvSNmlK7bg/QoUqM7DnRQ1f2o2MkyY7KYjF7goKfIkHdob4mEY8c3N2YZdT
 PJBkNNsmgiBo3OufnCC38inXZVJ3xD+VPcu/Aatpo57ZiYltsEyjoz+nTFESeNRGCq6LhOKSz91
 OrUWrjJVTO4RmXblgvBRZgUQ3XpLh2nKHpu7ZbIswte375ODuVgwfiB5PWl+CEn4nAVu59Fj8x+
 amCwYJ2qTIDa7M010ss1zf/NFD7RGe9ZCI2V3fzKWsrEaKtgLzVLBht/uD849ch9aRtOhCJ3wOq
 BBqKvIWaLy5ftubEKDvTJpJTWVHjMok4liXY/VWsnBHzj1kKasDdbgzUEv/GoFKgSwljHzeYvx4
 WFM6dt/X0WKfWFiEviw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050151
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add documentation regarding how QEMU handles Debug versions 0.13 and
1.0.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/specs/index.rst       |  1 +
 docs/specs/riscv-debug.rst | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 docs/specs/riscv-debug.rst

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index b7909a108a..181773515d 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -38,5 +38,6 @@ guest hardware that is specific to QEMU.
    rocker
    riscv-iommu
    riscv-aia
+   riscv-debug
    aspeed-intc
    iommu-testdev
diff --git a/docs/specs/riscv-debug.rst b/docs/specs/riscv-debug.rst
new file mode 100644
index 0000000000..e6dcad7d38
--- /dev/null
+++ b/docs/specs/riscv-debug.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _riscv-debug:
+
+RISC-V Debug support for RISC-V CPUs
+====================================
+
+Up until QEMU version 11.1 RISC-V CPUs historically supports Debug version
+0.13 via a "debug" flag that is enabled by default in the default rv64
+CPU.
+
+Starting on QEMU 11.2, RISC-V CPUs supports also Debug version 1.0, enabled
+via the "sdtrig" flag like a regular extension.  The default setting for rv64
+is still Debug 0.13 (debug = on, sdtrig = off),
+
+The "sdtrig" flag precedes "debug", i.e. if both are enabled the CPU will
+implement Debug 1.0.  In short:
+
+.. list-table:: "debug" and "sdtrig" flags and enabled Debug version
+   :widths: 25 25 25
+   :header-rows: 1
+
+   * - debug
+     - sdtrig
+     - Enabled Debug version
+   * - on
+     - off
+     - 0.13
+   * - on
+     - on
+     - 1.0
+   * - off
+     - on
+     - 1.0
+   * - off
+     - off
+     - All Debug versions disabled
+
+
+Debug 0.13 to 1.0 code/design changes
+-------------------------------------
+
+The effort done in QEMU version 11.2 to support Debug versions 0.13 and
+1.0 together was based in section 1.2.1.2 "Incompatible Changes from 0.13
+to 1.0" from the ratified `1.0 spec`_.  Here's how the proposed changes in
+that section were implemented in QEMU 11.2:
+
+Changes that aren't applicable due to either being SBI related or not present/supported in QEMU:
+    * "Make haltsum0 optional if there is only one hart."
+    * "System bus autoincrement only happens if an access actually takes place (sbdata0)."
+    * "Require debugger to poll dmactive after lowering it."
+
+Already implemented in the legacy Debug 0.13 base code:
+    * "When a selected trigger is disabled, tdata2 and tdata3 can be written with any value supported by any of the types this trigger supports."
+    * "tcontrol fields only apply to breakpoint traps, not any trap."
+
+All "hitN" fields are hardwired 0 thus no changes made:
+    * "If version is greater than 0, then hit0 (previously called mcontrol6.hit) now contains 0 when a trigger fires more than one instruction after the instruction that matched. (This information is now reflected in hit1.)"
+
+QEMU doesn't support encoding sizes greater than 64 bit so no change made:
+    * "If version is greater than 0, then the encodings of size for sizes greater than 64 bit have changed."
+
+Changes made in the 0.13 codebase to support Debug 1.0:
+    * "Add pending to icount."
+    * "If version is greater than 0, then bit 20 of mcontrol6 is no longer used for timing information. (Previously the bit was called mcontrol6.timing.)"
+
+
+.. _1.0 spec: https://docs.riscv.org/reference/debug/v1.0/_attachments/riscv-debug-specification.pdf
-- 
2.43.0



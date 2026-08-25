Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D0CC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyycZ-0003Rl-Hx; Tue, 25 Aug 2026 17:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycY-0003RW-KB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wyycW-0002FZ-Oq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:23:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PLAVWS2899975
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tpHPmh/+ghMWFIPvMM5GD6HolJ3r1c8a8Gy
 Och84NEw=; b=UPBszjqzEE2+WfGFFsGV1/GuOdP82LCmproYGFqpYEXlwmzfd9+
 iFKBBORl9mvF8r3Jf3AlX/dtZZHkvZ9s9Mas1Ryvnj9d0Q30CrY/EJT8zB8ziJnT
 i0/RLSX3ZjqrNmMKbhG8TTs5SFB5WyRAJ1/xVFLZ60YoVxYZBMKk0AuTX2c2HwLs
 rXvZEN4pXIpVaw3JsyWt0Laae91Y8fRBURxIOyxNnJqW5EN6oDeXZYrOQjToT5CH
 76OIZNPwCUmczx0qB81m0OudRqZie4Rl9L90UIWcLzpOdCzOtzdMzMRbjleHc0W5
 8cqRYjbDHQDQhZ+hsL8qYePEWqaVK/F7mNg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fcerubp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:23:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso2779261cf.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787693024; x=1788297824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tpHPmh/+ghMWFIPvMM5GD6HolJ3r1c8a8GyOch84NEw=;
 b=hzcbbc0Fo/051VBY2XhhYi8eQQbHVZyTrh+Tvrnqx/a8SbAXAr4pnYi0J8e6P+UhqD
 iPAHkEclC5hO/9VtGXkDub2lA7njilGxlvwEdvbx7RnasCIym8boWHD2QBbtYnAbHsBs
 NID7BxyDuVYLQycJrhHQE3ghaaxMItcwfBRC5Uuta0jBatFzwqCdL16Wf8Hdel+R8VrX
 z51wPyIagWOmihPJBF15C/aNC3bjVVLf4yu7xeznNdN0wVetEEhjk5uOs2uVo2l1yrbB
 6uM6mTNo+7kIL7NDI9Frp1qNKurAFtB3ILO8j08XJHAdBo+uP3t1k0BjB3DMwcvRQefN
 m5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787693024; x=1788297824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tpHPmh/+ghMWFIPvMM5GD6HolJ3r1c8a8GyOch84NEw=;
 b=PD/Xwx9dFnF0PJJDPUfimUMdkYzyZo3mHi2y5mc8mz1XPjS2NyVu6rXNtze6sD8CPE
 mKFE1RhJEqWYb8PpnDPCxBUuxn+Nd1m2TRS7wawXMOWN3QsJF60a8q+5g1lbNVdklGSg
 PN2NSJ/kiiw1XfTPnu7R7DRaNU8d4cxINBayW0cyD5s9WbOVjI12DNroGe4vSAoGoYlU
 6jDThEyE7wbNGPS2B3/2jHHD9pn4lVWCj9M41wZr+ojZNdzJywl47MIslzv5vV1krheW
 krIW3mSVNTgglps7gjQdHBDBTitORuoYcDocaOmguWQ8NOeDBuGFPAFcfMmFAcuPvoGK
 4I2g==
X-Gm-Message-State: AFuF++kkWMHsgXTnqFAoN5gHw+1AoluW7fOKef2CIRn0cwM6wnm82KPg
 pyOQl4SWuPkZFNUgd3KglFmBL9xGLaRIgqg/TThEQ6n2GaStmOzDq7nNRReGbX0IyvJ458cngG6
 4JfVcI6To4WJSxc3mW/tmYLpaDQeGh/CiK0mlwmbWyZ0jfzL3ijEUnQ2ZoTIjQT+Khw==
X-Gm-Gg: AR+sD13Out1XfP2X/tCQ3SeHLUm9Qis6QnRyvhVcYV/9tDUp+Hzw2E3dtQ8W9HxkW0Z
 3Sbo13+G2S7NAg5JZrGu0StP1S9DQzvjTkKsObGv5qBHzfg2HOyU2yVfygtUxMyzPf1V//5jZy2
 I5Oo/6LOA36EmypgbvNbPILaVfaZFPOyjGvPTP8xCfmHzWruKvYTnR4aR6r+vSqTW4sSPZ/G6YA
 /XkWI8Nw7fpWBYQQ7ITwZOUdjzsOzL72LP2hULN1MlYyO1EELzWS21qABLTiSLIiaT0nfZ/Z3Ih
 4ICbrnpg6AwTyI2+dBbgmvsstSOudYhaklfveLpSWidKBpR+6asBN3pkrwlV77Xmdg3WfUx52DG
 zD6Xc6w4tei8PeIOaZ1vbD8UDcEeF/ZXMcWqfBQ==
X-Received: by 2002:a05:622a:4a85:b0:52e:25b3:6b0b with SMTP id
 d75a77b69052e-52e2ed06d20mr113969331cf.16.1787693024399; 
 Tue, 25 Aug 2026 14:23:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4a85:b0:52e:25b3:6b0b with SMTP id
 d75a77b69052e-52e2ed06d20mr113968691cf.16.1787693023908; 
 Tue, 25 Aug 2026 14:23:43 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc65299f0sm8646386d6.41.2026.08.25.14.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:23:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org (open list:Trivial patches)
Subject: [PATCH 00/13] hw/riscv: trivial code dup work (riscv-server-ref prep)
Date: Tue, 25 Aug 2026 18:23:12 -0300
Message-ID: <20260825212326.1907-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8AAM0SF c=1 sm=1 tr=0 ts=6a8e07e0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=NV_7vAgSjKoQyGx3fFkA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX7a27DG8YcXbW
 +4u2RepUh2FyPI2H83QzQJZ5c88B2dPXhsuO9yZlRePwprVWymSpAUqKtjiH7reUSMW1xHA3/Ko
 ByQlIZO00fwvOlLFcnRYouy+8VPVfqo=
X-Proofpoint-ORIG-GUID: yfHjQfYCVJQvxOAvJRkUhrapWaml43A_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4MiBTYWx0ZWRfX48er/xTGmV28
 mRbyXxgE1/Tr4IwEt6pLhDjysjy+UacfBS/cV9NPJehc7DzGQ+DMUKpCLiPo7y3GKbCL8IRFvMV
 28ZqdLhHou8R3XcEu6pAk+cUo0sdyjlPQlVecFKz709XPCvjfqgvzspkjr8wPZRsJCB25CMKRIw
 n06z1csmgktNvvo/y+u6Yu4QizgtcVk0kn7SnBnAKBNLbcc/Ps3jcrQn2hRNpQ2gLzMm6YsHioA
 lCUo2xrhqjP4GNPEdXsnvGJhkgFePy3SdEl51pxsKUaN3xtVkaAahLu7UF3uK8JMgZPUrGdjTQ4
 AbDS3eeCnZfuwIV46l9Ub/p1wyUsw6brnCV+QaCIvEDCh8NhFlS7v5rOCHpBlT6xjItWhKBNp2P
 ZgvfW2klSLGxW2HxJyFrFJhFFH3IkIHLXM7xlobUTZLNQi5Vf0/vogClauFk5UB4TkMke6G+7Ft
 1aNFMxvYwZfCCLKfn7Q==
X-Proofpoint-GUID: yfHjQfYCVJQvxOAvJRkUhrapWaml43A_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250182
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Salutations,

Here is a bunch of trivial and mostly boring stuff we want to do before
pushing the RISC-V Server Plat Reference board upstream (currently on
v9 [1], not yet sent for review).

Although these changes aim to ease the pain for the riscv-server-ref
review, in the end virt.c was reduced from ~1800 to ~1200 lines, which
is a nice benefit we can have right now.  For riscv-server-ref we went
from ~1450 (v8) to ~770 lines (current v9).

We were able to also reduce tt-atlantis code in one of the patches too.
In fact I think there are opportunities to shrink tt-atlantis board
size, but that will need refactoring logic here and there and this would
fall out of scope for this work.

Patches based on master. 

[1] https://gitlab.com/danielhb/qemu/-/tree/riscv-server-ref_v9


Daniel Henrique Barboza (13):
  hw/riscv/fdt-common, virt.c: add create_fdt_flash()
  hw/riscv/fdt-common, virt.c: add create_fdt_syscon()
  hw/riscv/fdt-common, virt.c: add create_fdt_riscv_iommu_sys()
  hw/riscv/fdt_common, virt.c: add create_fdt_pcie()
  hw/riscv/fdt_common, virt.c: add create_fdt_imsic()
  hw/riscv/fdt_common, virt.c: add create_fdt_socket_aplic()
  hw/riscv/fdt-common, virt.c: add create_fdt_socket_aclint()
  hw/riscv/fdt-common, virt.c, tt_atlantis.c: add create_fdt_uart()
  hw/riscv/fdt-common, virt.c: add create_fdt_rtc()
  hw/riscv/device-common, virt.c: add create_platform_bus()
  hw/riscv/device-common, virt.c: add flash helpers
  hw/riscv/device-common, virt.c: add gpex_pcie_init()
  hw/riscv/riscv-iommu-sys.c, virt.c: add create_riscv_iommu_sys()

 hw/riscv/device-common.c         | 168 +++++++
 hw/riscv/fdt-common.c            | 571 ++++++++++++++++++++++
 hw/riscv/meson.build             |   1 +
 hw/riscv/riscv-iommu-sys.c       |  25 +
 hw/riscv/riscv-iommu.h           |   3 +
 hw/riscv/tt_atlantis.c           |  21 +-
 hw/riscv/virt.c                  | 811 ++++---------------------------
 include/hw/riscv/device-common.h |  32 ++
 include/hw/riscv/fdt-common.h    |  94 ++++
 include/hw/riscv/virt.h          |  15 -
 10 files changed, 983 insertions(+), 758 deletions(-)
 create mode 100644 hw/riscv/device-common.c
 create mode 100644 include/hw/riscv/device-common.h

-- 
2.43.0



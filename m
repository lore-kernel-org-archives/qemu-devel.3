Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC62C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CE3-0001B5-Eu; Thu, 03 Sep 2026 14:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CE1-0001AB-VM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CE0-0001cr-7g
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3962346135
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SMd74W35Owx
 lEVCWTBA0XddWMjlMOj1/Eg7By52iCgc=; b=fWZA3SImZo7IvCJKpfJR8m3hvh7
 umWfxuFUaEDDdeQMLkcwb9EI21BAJhbxfiNV4JnJ+rCm/UeqAngomQQSvc6A8kwQ
 ix1TG/sSzsRKxkBqGjLPIddeR5pk3gPFcb9c9UJOglwr6LKSAuPAc98Kv5zaz4fy
 A2PSGEvzaOtVr0bLs7n3sCHhQKrSvPSclsoXJH2N6OK9d4mh2eDkue0JsXjR6axd
 nBVP1sxTepUvjIezVCUdyuMCrZFQ0wwMWPWdxEwn7pGll+V0yXx+LSUvXQF5N4IT
 KndCnzWGkOPnzxDG4vALXfuFj++eDxLhQYJuvBG8FwpxrvFCdi977YwjJCg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5pdtm3c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90ce21f2cc9so4185526d6.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460307; x=1789065107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SMd74W35OwxlEVCWTBA0XddWMjlMOj1/Eg7By52iCgc=;
 b=U1+e+2KDOoy0JHfIpLXZGu5r1spfWIaB/ya4aUtj4eeetZ7ZQBuUqceRcgmKZFvHzu
 pSCk4bSlvY66qKzBTDXuOQhH6lM1ZzgK7Hq+Ojq89KT3jTVOrz7d+mhnV8ldepuHj0+B
 N9j895RIQvfgntNoImkHPb1gHPK4O62SThvyg9GYUp+MVgGly6TFu0x4YfPqadV4tUWK
 oZsL+vHCAbZY4yMQ2HE8+/2AR7niglcazLej8lw77NHcVWw1FCeeXcjKOnglGIQi9wih
 8/I6fm/Tq5R49WMGBT9f40qFG6JrhHYagWT3Y8pPwFzMs30SHRrbGQXirKEwQHSyVbxI
 wkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460307; x=1789065107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMd74W35OwxlEVCWTBA0XddWMjlMOj1/Eg7By52iCgc=;
 b=iLmma/LQiX3wdMxy5XmWKk8bYFNU3DKtHYLp08Oea1xMxg0nLJrYXwynW3nKiJMR05
 Cdrl+SfoU7qM0jEmV+Mvp6PuoG4lNquPtA4fr9MRI769N1gzFEop7aC/F/4IVKTopBxb
 mRXIbW0DhzpiwhnKUmEBoj9mOGvg7YQcWVHi6NPc3poNE6Zmw+0+rL7N7tYoHH661foa
 +hHCv2l7mrtDkid9SCPENxNusIKMrJnKC3NTT8b5gnjuUPAa/9cPQWypQQiKE83AvfqA
 ZjOuXLbPATbrNudbP7ySReJx1kzG/DkdYV2Cyy+zT4a8zlO7rXnc13p1W8gTveGD+O1A
 0s6w==
X-Gm-Message-State: AFuF++nMwAF//jOD8O+FEz+6PSAcLNDHi0BCCOac1pDECgX3LBijlxYD
 HPvUrd64lJreWb+io2rfZTVrmrbX5JdzLtZjNcrHBuRP9PIWKxg586ZpyMA64QHbWMf44n6eXg2
 pyES5V8vUoRxDz9NUx36+DNDDqF0EyFgcc31u7o/CDwoidOsetoW9++cIFy0S+lngyQ==
X-Gm-Gg: AYBFou3Evzv2iKw2auA+YXab9Z4hXYytWp62qY5YrfEjz/Srmw9zXqeCuTuaM53iwAn
 4CShpTBNiDp87OyZ4Y8a6yKICTZu6kQ6eYYFr05QhyD6x7oFUeAw/3QGPiwjID3kFIIqerRvJHJ
 CvGkh1Gy+ltvyvkWnair9Mx/nPdynr9SKApiYcnUn2pSQTdv/2xiUdSCyaSTBcqnocutGWc1PBp
 mZcQaGRZ5enWL52AfC0vIKi+0FRjt/BNMKeaBL9UbnqOyf0ylLiuYZ4Az4fy2YzcUEuDwAkDB47
 e0tEO6ZFgtcB7/XT0P1Vy7HIj2OVT3kwVeIi998ZHTK8SHIklo4dOB3GIN4j1RdJGIKrso93ZRb
 HuZ7sGC4x8U9DdPKUrN7LqC1XebQ8qbbW9fYL
X-Received: by 2002:a05:6214:4e82:b0:90c:4422:84d1 with SMTP id
 6a1803df08f44-9103f043439mr13041846d6.30.1788460306285; 
 Thu, 03 Sep 2026 11:31:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4e82:b0:90c:4422:84d1 with SMTP id
 6a1803df08f44-9103f043439mr13040296d6.30.1788460305114; 
 Thu, 03 Sep 2026 11:31:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 5/5] docs: add riscv-server-ref.rst
Date: Thu,  3 Sep 2026 15:31:25 -0300
Message-ID: <20260903183125.682865-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfX5yHgS+WFksdz
 hqTE+R+vKzfft2o5pfluH5tz6aAJlDBaY+h3XbpCfGHEnDQsD6JlADhHszFEV2ET2PAqoeqwUVj
 +qFCKbpxi3IvLo9MMMBXjhK9becCXgU=
X-Proofpoint-ORIG-GUID: J4uxbeRtz71aDZyrE2HWoqeuQyMGKZuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MiBTYWx0ZWRfXyd7nLeqHJiBX
 Bba00MmYdXGODjwh7/sJ81/tgLZu69/FWwr0z1uZ8j7B3d2KlIOBmFwIpMmhozDkdxaSRGicQTP
 agZGrIoJnmQzsnRNJTptr8hYvX+tO1bpKAtlyV4wjhy3qInhAVgkaNTAWMwhUfIXEqh/SGDbivQ
 7Lg0P1LwYUEUVwnqdwJDKGRMI7JfETehHDiw06r2JiiykXcGaC0AuVzNgPZrVLCBHnFnt0A0ne1
 Qr1ORWGXuXWx5d8R0Tap7nht4rssp6mZIkAHblNsuI28ad/hxhWvazRS05T4t+DutlFjsY9NdB+
 NoMPoZJstMDGHEjkmUIKDfiTw94rYgxgam/I64epzkPcu1yooNokAfkLTDput74AUwcipEsqzwB
 qFUZxIE89LUVZ+24Yv/dbSEpM2mIkm1Z8FIFCn3uPfcaZsDCyNavddVCWY0eLC+kxuQWgbx10BT
 m+MtTLzPyXael2WLIOA==
X-Authority-Analysis: v=2.4 cv=RsL16imK c=1 sm=1 tr=0 ts=6a99bd13 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=vlmih187C6Ts2ntwv5oA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=F9tHCgz3TLBaZgltkx5D:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: J4uxbeRtz71aDZyrE2HWoqeuQyMGKZuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030162
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

Add documentation for the new riscv-server-ref board.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..0573b4e07c
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+RISC-V Server Platform Reference board (``riscv-server-ref``)
+=============================================================
+
+The RISC-V Server Platform specification `spec`_ defines a standardized
+set of hardware and software capabilities that portable system software,
+such as OS and hypervisors, can rely on being present in a RISC-V server
+platform.  This machine aims to emulate this specification, providing
+an environment for firmware/OS development and testing.
+
+`spec`_ is version 1.0 at the introduction of this board.  New spec versions
+might trigger a revision of the emulation itself, which will strive to always
+match the latest version available.  In case the emulation changes aren't
+backwards compatible we'll introduce a versioning scheme, probably via
+a machine property, to allow older SW to run with older spec versions.
+
+The main features included in the riscv-server-ref board are:
+
+* IOMMU platform device (riscv-iommu-sys)
+* AIA
+* PCIe AHCI
+* PCIe NIC
+* No virtio mmio bus
+* No fw_cfg device
+* No ACPI table
+* Minimal device tree nodes
+
+There are multiple ways of using this reference board.  The spec compliant way
+is using an EDK2 image and a TPM device.  The board was tested with the TPM
+device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
+to use this device can be found in `tpm`_.
+
+To use this board coupled with the tpm-tis device, first start the ``swtpm``
+process in a shell (the ``log`` parameter is optional):
+
+.. code-block:: bash
+
+    $ mkdir /tmp/mytpm1
+    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
+            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+            --tpm2 \
+            --log level=20
+
+And then start QEMU with:
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref \
+     -bios fw_dynamic.bin \
+     -kernel EDK2.fd \
+     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
+     -device ahci,id=ahci \
+     -device ide-hd,drive=hd0,bus=ahci.0 \
+     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+     -device tpm-tis-device,tpmdev=tpm0 \
+     -nographic
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
+.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 2639866a3e..74e23fa64c 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips
+   riscv/riscv-server-ref
    riscv/shakti-c
    riscv/sifive_u
    riscv/tt_atlantis
-- 
2.43.0



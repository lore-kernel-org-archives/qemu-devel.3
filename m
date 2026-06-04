Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D587CD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4lV-0005YR-Hq; Thu, 04 Jun 2026 05:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lP-0005WG-BC
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lM-0003lN-Pf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65491ekG2261313
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TVgVH1HOpFA
 j5Ji00+B2fTa3jTQUDt0mbrCqmduThng=; b=cQxitIWWkiHt3NveBSbgrUBroEk
 XV4M2RGjiI1q8EECA+E8gIDuljMqb4dScJ8NHF+DqYciqEQGGVgtbnXgiIU/7gr4
 ay3rpETWb2ySDKWPho+rqVxsn7jlfeHKx6Byg3pEmE4asalS1fP1OgpeIuxQIPpH
 N4iUGw/8Ohpa+Q2T6TlgqeA9ZU3oFrgll/vmGeC0zZccIdxP6tZAiUjRU3A7l1Nj
 gHZOUL+u5jLIXsxR9siyTRp8BdLWYc/FDoxoFNHh/Obh2VMCdiUlBnUPEaQ7kVJV
 DCA068VEs6fq58Jssyoiwny4MgCauVcC0RxfQzUT6JhqYwl7RShik5c1qhQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejr2mkfpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:53:14 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-660575c74f1so827320d50.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566793; x=1781171593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVgVH1HOpFAj5Ji00+B2fTa3jTQUDt0mbrCqmduThng=;
 b=SrHe1T3G7Wn+MriM7QDoyXC+uUcansl5mvWVkU72LVKnljYC88+/Waa8IMCNDzSvF+
 QII6YpSOyawFHOXjsgq9YWyyFvi2Ip0GjrIaLUI9VQQ0Oo8fhHZNN6AVYBOnhmpwG+9b
 Vwzl5NkF4xE9stjc5bY/E2Vdef2bgDSuCgoZVjifSuEya+o2G/c3rVGFPDu7PPXNpZFB
 7caVE4LAWpCQ8orZCzYwCbgWIJnaTnN1VuSkDiAHc5NspTHqieniKHQxxOo4LsE9fc2k
 l17imBd/VPbh0dsquLxztxFrP7CaFrDdTQ4PcEASvYPZ/EuJwyJ5R23T6XfgRxd5Kj2o
 knwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566793; x=1781171593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TVgVH1HOpFAj5Ji00+B2fTa3jTQUDt0mbrCqmduThng=;
 b=Q7+Y/9ydaJtpCPee12GzlZK1YxXaV2p5co3wA4tv+c4eLpre2g+s4LQyVfhIpsRR8V
 ElSUrB5tKprWIiSBaV7VUkK6dyXjkCXsa1DsU42thZH5aaKB7EFMkpwSQJLHCx+rettb
 c3nw1YsOpTB0zlH3PNwZvdyTu3GEUAimkqR+88KxJNV6KiR7JmukHOEcbKDYlm156Evd
 rPAm126d+KrxOXwXJnO2+4yOCKMbF9x92j53mLYIeeV4E8U5q1/MUtlOdEnHgNgzbxmo
 6eII7p+wSSVH1D1PFqOLnpkHeUswpUZwD+ugViGVD9Z7Tv2N28Ktl0fnsuR5aVnzBPRT
 6HNw==
X-Gm-Message-State: AOJu0Yytmu2UpmPKv2n+G5qA83UkfQzxCxVDoJGeAXWAbQCxY/G9JpOu
 qHl/zBCTmAxo+ueCimluzod1M9jBS8p3mJ7K6KEPFNbiJB/EJtLKrJsX730QxHcP/DMXyMVquaZ
 n+ZfRME7QBPBh0NCLGRyWm7KMM+sq9uAUUUPQoGIzzanuwzrkDendxIhmSAJ7kxMpVA==
X-Gm-Gg: Acq92OHfYPPWOG1rivu1rce5LRpf7X6lHOzctdxlZWET38OBWw/KRO5/WIN3cFljlHA
 5bPEuC3SdxRLvLh49rkKJmhh8zszyN48U8pRTi3uzo3xHy9Mp4TDIYHrNI+pgpc3mmdtjUVqv2S
 9QTVkPgsWG6rIXGoBPKN73/y7d/25ijw9ZCrLUeWZMrt37qJNEC3ECyPIjPvKxiGWZE37QuozXX
 U57p31J2Yi4EkK7roS0qkNTqhSZDJJuceLsNK6D8O3U6JaAl5ukUQA6+36fG5+8j6Fhjp5IOdMB
 cr7NNWOlGW7e5JBbZUpnfCDg6M0jUUFgCUGpV2SoC/eWFSunzCtN9qHcvqqRVVxkpw34fp0dwpW
 bQIWatrZ1JQN1ryQOAYIFLuEdgS7VRs9RutnvgZNwS2yx0A5da7uwdYTCvLbZ0qlS/u15TA==
X-Received: by 2002:a05:690e:4847:b0:651:b7e2:6835 with SMTP id
 956f58d0204a3-660dc50cddfmr4833663d50.35.1780566793197; 
 Thu, 04 Jun 2026 02:53:13 -0700 (PDT)
X-Received: by 2002:a05:690e:4847:b0:651:b7e2:6835 with SMTP id
 956f58d0204a3-660dc50cddfmr4833638d50.35.1780566792788; 
 Thu, 04 Jun 2026 02:53:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64ba680sm3522830d50.21.2026.06.04.02.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:53:12 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 4/5] tests/functional/riscv64: add riscv-server-ref tests
Date: Thu,  4 Jun 2026 06:52:43 -0300
Message-ID: <20260604095244.3313259-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F9QnGmn9ZtuStdokBkUGaR6H6p3BBroe
X-Proofpoint-ORIG-GUID: F9QnGmn9ZtuStdokBkUGaR6H6p3BBroe
X-Authority-Analysis: v=2.4 cv=A91c+aWG c=1 sm=1 tr=0 ts=6a214b0a cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=5c9j0NbqnjbX5077XfcA:9 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfXxMIIKI76Fseq
 56eKSEKpGOA8HTzQYkyyFIbfmyzSiM5mC31AGLN/nHFVQ7xim6r/h8yQuuJW3yEiKfyjLembfjZ
 mtT5hS6zE3dTUEI+naI5HjVMCHtktuZgzEuC49koQH/CCGYUudG2tIY9tDZKC5W8fDZGdA3mkly
 +iwRAbMqL8lxfwr23qEigqi7BqWsWkNAbjTRHqujuPE7zqqLbV5r8KOJ84kN/l6R2xD4oZdlGVA
 jRhhZbZoMcjjkRyQLQIn4ewR3Cvjm/xuoroXxfQQjaW0UpM1y5E8B5ZEVLszlTlcv1AKGqkDOIo
 CkzlPpzPR2vhNchvWlwyUHAm3DWuIm9XjEHw3Zyn/R70X/Xl9GBlqWu20DQTBXM1OKkD2cVry5M
 NUQjiZ5k8vLIIAUKAAXaoaPIAFO1UVYkdhGejB5saqhdSnO0PVFCfHnWmkljNsUWu3+4fb1iM2o
 dAbqAgsFlWZ8YIpK5vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add two tests for the recently added riscv-server-ref machine:

- a new test_opensbi.py test.  The idea is to have a quick test that can
catch trivial regressions that would prevent OpenSBI to finish;
- a new Linux boot "thorough" test that will boot the machine up to the
buildroot prompt.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/functional/riscv64/meson.build        |  2 +
 tests/functional/riscv64/test_opensbi.py    |  4 ++
 tests/functional/riscv64/test_server_ref.py | 57 +++++++++++++++++++++
 3 files changed, 63 insertions(+)
 create mode 100755 tests/functional/riscv64/test_server_ref.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index 5871211e89..2eb12586bf 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -2,6 +2,7 @@
 
 test_riscv64_timeouts = {
   'boston' : 120,
+  'server_ref' : 120,
   'tuxrun' : 120,
 }
 
@@ -13,6 +14,7 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'endianness',
   'boston',
+  'server_ref',
   'sifive_u',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f42..057f55f90b 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -32,5 +32,9 @@ def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
 
+    def test_riscv_server_ref(self):
+        self.set_machine('riscv-server-ref')
+        self.boot_opensbi()
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
new file mode 100755
index 0000000000..99e301a852
--- /dev/null
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+"""
+riscv-server-ref board test
+"""
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+class RiscvServerRefTest(QemuSystemTest):
+    """
+    Test the riscv-server-ref board
+    """
+
+    ASSET_KERNEL = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/Image'),
+        '6bacc876c769c1bb6057d2bf549eba67fbe83916e8223f9fe21c8e8fff665a36')
+
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/danielhb/qemu-machine-boot/raw/refs/heads/'
+         'master/riscv/images/virt64/buildroot/rootfs.ext2'),
+        'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
+
+    def test_boot_linux_test(self):
+        self.set_machine('riscv-server-ref')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.add_args('-append', 'rw rootwait root=/dev/vda')
+        self.vm.add_args(
+            '-drive', f'file={rootfs_path},format=raw,snapshot=on,if=virtio')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: qemu,riscv-server-ref')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0



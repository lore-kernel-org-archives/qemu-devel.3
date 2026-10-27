Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28276606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1JnTQxX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UgcTcMvs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmnV-0002iG-4O; Tue, 27 Oct 2026 15:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmn4-0002Nv-8i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmn1-0001qa-L8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWBK1917338
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Faq9E98kwTR3wBkz0nF/S3ELSM4kVgaQwwjx3atQvew=; b=m1JnTQxXpVFkSNxN
 jhG3WSTU4DQ90OePqMQEPuI/fMOYV9+0FtSPJmwq2FgrVI3UjU9U6laIrYMK7NQR
 RS8JCYqDWVdNaIkrUWWzLwhCC7dGNVxGe4KinLt40eNvmt8gZxiI88Nzti7ogX64
 Mvnkh6iZkaY8DI+9vJcmbjEUSrt3krscilaP3ANLl8ms6uHtRcT64MtdOjuWV3VP
 U+ZbgKzckeLgU7AvYcnZihvrvEN/yyjDzh5Y8kMaJL6vSGDaDUE+gJnvkonqEsgZ
 keyZyvf/SwG5A97N02gK9XtkHFpyxFM4LxDQJg/OibJTakENOYcUl0jlCEz0dhQv
 yPk2lQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux99us2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f559420f3so13716085a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129092; x=1793733892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Faq9E98kwTR3wBkz0nF/S3ELSM4kVgaQwwjx3atQvew=;
 b=UgcTcMvsobWCPJwc1qhixs/AuOyxmAJi7AfNKG8OHa2Jy75AkNP+2FfZtxRf9agDGc
 Tj16pdKwkKJKAvAqhRdQP1WpJq7t7cwSe0ue6xwnsrOn4WV4ZfgwlRq/kt4B8D/bLcy+
 1SPoIop2Ayc/RTV1MXIoyRHmBOIYVEJhu2jhaR4KtQTn9YqtaJczTSC5p4RwbeDAFCB7
 zIug9lUKenWgqc+/WIcon7oPAFSkI3kzNtcPtrlNkt2VvCQAk2jrEOiSmxibfxQFso2f
 OZ8I/NHgrIGLWhA6VSBvDVoXUjfBVXv6TJy+uzsGfH3URPdWceHZ4VwkJkTVR6w0F8aU
 3SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129092; x=1793733892;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Faq9E98kwTR3wBkz0nF/S3ELSM4kVgaQwwjx3atQvew=;
 b=nfz/gBd3lkjnamvLgPzTyBfpve/d/YaMJwJPhr3BTbZ5xbAlx1dPDHzlJY206QbFaC
 jeZZbELW58FnZGptZsgjKvVT8+sUZkXkB6AxP3oeeAKYHoE3rxv4zgNE51DikaPERzy1
 bBWxXfI2tB+lmSMi4u0PbT2MsN8g1DCfclAhqK9yhyoRpz6EYF85XzZ6K9rDlvnr/yo2
 h3F3+wzpXv+X4LckNO+GE0TYTiBhlEcxxO2ngbqfvPeokrNYbjEPRMc2HFGiiCEerW6f
 YYw7FbBln6ebLVFoxr3E4A0iTK/OkDtvGbZjUZERiSqdApiFiwuHbbOVkKc+qFVBZB78
 8xSw==
X-Gm-Message-State: AFq9FYKBqad5ALf3EFgNYlxTn+RpoUl5i7SWnSEJFkpq14cAomimCzqj
 XJxV7QPO0753awceC6xND7kys0lZyzQHM5joB7NGsBoCQp3cbSZaHBwoVAbSYOQVGQ+D0YtMVO5
 SecJloLaq1juGrf0Nu5Aqd+N1YZuwCGoKVp6c9qw6Jb1+jBb8oSqkILgd47dxYmqQQA==
X-Gm-Gg: AYBFou1OagC/WS7erkw4MWw+jF77HuHDIwGz0W6ECYx7N23Xxh+bEQTpCeTobKiDS1A
 MKD1lXfRjR5hKox/ICHTkcqAckoLA7zdI1/nmr54GS/L7qFPP5uq3dyUeZzD6pEVEzOKaJi7q8o
 bXDdf2NKRJ52adOVcANUpVh5GzKaCF/rehOf5rEI5+XAA4g1yaa8PUsaydNxhyIbuq0kVzg1VZP
 038VU94LRC+WJJXZpisBorFkyWnTaOmn5RfQQqdo2t/CVWQz6lchNcShXcfvXMLj3UtaVJeAt57
 NqvlBc4T1KMDJ1no/UTdsPBVdJquxxIDjGy79Ogqki0y4nvHYRyyZ1qXbbN5m1eSXtAZ/290JFR
 pJpUqyfXoOVik8nXMqeI9B2nZReFrYVI6jG5JsnsKsSU8nNi9DJd0tbVoumLi3ZnrIWByVxUgDb
 x3fb921m2ZINDA4dG7wYnq0ukgrYTLCw==
X-Received: by 2002:a05:620a:4087:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-940ef9d1e95mr1504202785a.77.1793129092551; 
 Tue, 27 Oct 2026 12:24:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4087:b0:93f:6f8:9d72 with SMTP id
 af79cd13be357-940ef9d1e95mr1504199385a.77.1793129091978; 
 Tue, 27 Oct 2026 12:24:51 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm24484211f8f.30.2026.10.27.12.24.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/59] tests/functional/arm: Add console test for `sabrelite`
 machine
Date: Tue, 27 Oct 2026 20:22:51 +0100
Message-ID: <20261027192341.9197-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0fa85 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=xNf9USuDAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8
 a=KKAkSRfTAAAA:8 a=t8u_m-V0UNmSaiA-_D4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CI1wnthKms-IpzMa7wulFBkC0uGQM-Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX1tPE7miCEyCg
 JFTxyFm9I7dPMUZNgGubab6keyvKVG0BAYyUm9c80zH//qBKkMnDiQxFOy09b7VHvJcU6W3Sf4l
 25PuEIniK0B06IFKCIi+cUHNUG4j4bKeRomcOlE1XCB5vSApIOJ88Stqi68QSJT8vGs/E3qw04y
 a0L8xlY00ANwqOtfMpO3AbUA04rAr8o/XBcjEwaSfqB++4100tzZ2vEMdEdstJzXUMPDLwEtTs8
 ZfU30gkbSX+bnQY5+7JuWVSZY8VLPh5OaMkzzg5mzzMG9IvoiX60u1oyZsOoyVOqTHJZ/JWMH2y
 sNrvrPxttRaDytvatlgjxjKEeSbno3BJpBuCYZ3ep2iMRklqaAg1HyFOrE9d2mFivmQpCgRZyxy
 R4+U8VFAZyjua8Ws/6m+PSx7pKWrs8bocmTnLEW2S+DPDQJKXV8CNG7fUN/InnZtQBUCp/zdm2f
 F/AKJIhD2BkW6Cwh83Q==
X-Proofpoint-GUID: CI1wnthKms-IpzMa7wulFBkC0uGQM-Qv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX/z630h3y95tj
 UQGNLYn/iuIz1ua4rGrV6zwOnomLEtXM+i5gYkz+3XYuyMK2VNHFUC2lZrEAHcbzopkcbjhXuDv
 k4wxCDoF9L2E4UXrXNEQIReh0tGAjyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

The test currently exercises the Linux kernel and waits for the first
daemons to be started. At this point, basic hardware is initialized and
if the log message is reached, no driver ended up in an endless loop,
thus the system should be usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-9-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                            |  1 +
 tests/functional/arm/meson.build       |  2 ++
 tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_sabrelite.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca1751e30f5..47fbd05db186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1069,6 +1069,7 @@ F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
+F: tests/functional/arm/test_sabrelite.py
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db93..989b841555d7 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -24,6 +24,7 @@ test_arm_timeouts = {
   'quanta_gsj' : 240,
   'raspi2' : 120,
   'replay' : 240,
+  'sabrelite' : 240,
   'tuxrun' : 240,
   'sx1' : 360,
 }
@@ -65,6 +66,7 @@ tests_arm_system_thorough = [
   'raspi2',
   'realview',
   'replay',
+  'sabrelite',
   'smdkc210',
   'stellaris',
   'sx1',
diff --git a/tests/functional/arm/test_sabrelite.py b/tests/functional/arm/test_sabrelite.py
new file mode 100755
index 000000000000..31a0a49eac4d
--- /dev/null
+++ b/tests/functional/arm/test_sabrelite.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class SabreliteMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/vmlinuz'),
+        '5851e9c61465a26db810796db671c4729e66e81c365b3ebb1a4b7f772737605b')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/initrd.gz'),
+        'fe33f836232a9107716d34dc56d36dea81bab039243a2a42ea6583a50c9b92ca')
+
+    ASSET_DTB = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/device-tree/imx6q-sabrelite.dtb'),
+        '3ad637c8ea55ebd058a67f686e050b82ccb0d1327bc283623c133c48ad87db44')
+
+    def setUp(self):
+        super().setUp()
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        self.dtb_path = self.ASSET_DTB.fetch()
+
+    def test_console(self):
+        self.require_accelerator("tcg")
+        self.set_machine('sabrelite')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path)
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Starting system log daemon:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.55.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F3606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UEm0J6Ub;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UPuyiakT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmos-0005GW-Ib; Tue, 27 Oct 2026 15:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnO-0002qj-OF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnK-00023y-Rd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPQf3553875
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y6rYAMEK80kXQsUvZJ4GPX960Ux0Gn6eJ/YE4lxkayY=; b=UEm0J6UbG22aj0vh
 sv3jlanCKVAqz79dVIeOumUKYohZWxxr8/B4Cl7+FozW6QAldrvCC72SqMrt9GMm
 MA7vstk3zlibC5nVAIpSW1CQvNfCUhzFZ9/mIcyrd9+chPm5vG5XAxMzySrqauLE
 Rs4FSDNZED+G+tM/ApdqEHuNeCOkFxjlRbl/GOuVwVvIkBb11mFuZFTdalZMEvhe
 soN0n+db8PSDJocr82YP59zHA2P8IK9XA/Vxnwj0GujuGs8OyqRfv+oOMFLXou0+
 e5uxb4fBZGkZm2XLc4qd/UmRzGpFjZWAlesa3yuUYBlpJFfC6MM9XWtHupl4sboU
 A3lTQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so39566785a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129113; x=1793733913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6rYAMEK80kXQsUvZJ4GPX960Ux0Gn6eJ/YE4lxkayY=;
 b=UPuyiakTL44+yix20cgrykJpqIiZdGGGs93gQXwMZIsr8MiGuclqs0VaAQcHgN54uG
 14ZNVI/jXz7Zvb6ZFXuuPhnqNMn4kMXvCDbUWoXSmAxqE2JPWpfWBxlGfOe6C4ZN+Q99
 6zRuMqyZ/oV6H42/2DEvAs7lRB+GWVvSWCDm3F5xGqurl6dpucfzzbXzE51nJBZZfFew
 HAEPi5HSzEHrAVsuquMlWin/65zpcOG7Sv6uUKw6hzi2dGlgKGeK6of9jQXdH0aCY90r
 rz8f3tRwJfTEh4bSjzH99wXY1K8pPtXnHjdR4DoHRvG/8UrtHUHRMtnxRmsSbGpxMEZb
 AdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129113; x=1793733913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6rYAMEK80kXQsUvZJ4GPX960Ux0Gn6eJ/YE4lxkayY=;
 b=llGdC5XPRNjDbcYXNzp0sa2yMxqQfzLCUyvHRVrlkIlLsjEwyQvE17xQUO1Sm/ymUy
 1+ygz+HuaesHY/rCBDRDwedp+MLuDPAys9ClTt5JfuCaOV19sKEaMpNzhN0TQuN/AkEF
 Yzyh3lAVjk3K923hZgX5Q920861jIYOCneMbRImJXE+hGR36xQQ2nGO5vOmYrLwjK/SP
 xGgXrIn6LiaPzPlXydNqmbEYxgpYxduYWBHX7H4j2MBQjbCaRAWVXbi6GU9M1vys7mTA
 zgiRY4QQLFbZBbAJr8G4CFqSdaAfru7E/gbUlmNDGLWVORsVr/lbOhLk29+8NinteINd
 +8Vw==
X-Gm-Message-State: AFq9FYINAN4c1y3MpFJStl24QkI8huvt+O8ZYEtaAipYzCREpka0rQTN
 MePx+xwZQh3jP+rtKakOaciByitwNN1kVziXkWuEqvyaWLbYgqvhcOZ5KNCyKM5uLTTAH64A0eK
 veF3RlaeVo1LKSmWHA9FcINXZl1DFAQ+T0VExz25WWE9J7VzvbiRH0Xu7/3fQyjW7Vg==
X-Gm-Gg: AYBFou2h1R6jVLAmzQScM9u03zSkZtFkJ9GXwBqcPQ2tY7SQTghOy7KHyV7AB2txAqt
 NjpG42VusJO+HL4vWbxQy9sVXuI6Q+WemxFKqSw1AJBkBbcN5Q1o1iNmpuw9DoXano4U9Svxuf8
 AveQme4Lm9CUocellcKMpJvFAUTSCC7rubKaQLfFWbfRI7GJwAa2/eiSWCPG8/PN5EkcCBSIKWJ
 v/zYxZvo1RBcK26VmGxoxVD5T86VuSmiD3xXxpRqq+cKa9rSb7jtSHwCHaRoBntCjSjCqPLdqdi
 brqE3VJTsjmB2FoClfZ4RrYijZU6GcmjUpXaDgFM3z7PHGzspaejBG1bFCnT9fx8teUK18zVgAH
 WJtICOptoWL1/kLgcNJYGazCHXU0YrAehmclmzo554TCbjwG6Mb+CMoFD
X-Received: by 2002:a05:620a:72c3:10b0:944:6ad:1b7f with SMTP id
 af79cd13be357-94406ad1bddmr54748385a.32.1793129112934; 
 Tue, 27 Oct 2026 12:25:12 -0700 (PDT)
X-Received: by 2002:a05:620a:72c3:10b0:944:6ad:1b7f with SMTP id
 af79cd13be357-94406ad1bddmr54746285a.32.1793129112379; 
 Tue, 27 Oct 2026 12:25:12 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a951f7f2b2sm1796305e9.5.2026.10.27.12.25.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/59] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
Date: Tue, 27 Oct 2026 20:22:54 +0100
Message-ID: <20261027192341.9197-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXzw/9rhWkQUZa
 NahV3hk3bDCai+PQX5Oz1hpGQ2zCa5sQgwWTZV0MUA91zJRs3sZ7jpEkjB88SgMaSlNXfqUDsp3
 XbMbN87jnj9gR/UBHnYo/xzXSdiTN44/WImtnisSqINlYGsVA9Tcep3XncLIdbAoQR2KtXUAsMd
 z/bGxXXa9HTerpbCG3N3J8ZjhOV+LtwSOBjh2G8zIZ6DPI9vyM0bfkdro4Q2IuEaLE6ZnarRwo5
 UTlUyJ+OAV3FGWZyVpwmayiLGgrAVJeMSpsH4tb2TWWnXNsz0UoJMOoxhRDfZsSAQmH0fPOIcMj
 JLPGykZGGVsMbfCYWSIFYK/F9+3JbmRYyCnxlSsJIT7XdTcMc+2qcoQsDv6ErlaPmneOXx4dM/e
 34+BmxWfKOi5v3i07yXvWONkDeTiKuJSwPkTTTlcdq59Fk218fzZZwq4KW93uptor13A+8jcPZJ
 +iJq9PtnY0maFZT/uMQ==
X-Proofpoint-GUID: X0KUlbxqMChgrOT0DpMayUUGjX4jeDsl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXw/tNgRA8y7Fh
 Y0h17sRHbr/7mBN1X9+KhmrigvvktbWw8PVTKneeyqe5cS0Dha726CYsI+rAXGrya2f+NvIDTVT
 1ehmkDD/UwzQu3gQ+LQkbgQ4Iy/oFis=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fa99 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=xNf9USuDAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8
 a=8AirrxEcAAAA:8 a=Ygzc3wgccB1K_Ho113AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: X0KUlbxqMChgrOT0DpMayUUGjX4jeDsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
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
Message-ID: <20261006083445.30362-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/arm/meson.build           |  2 +
 tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 47fbd05db186..78d1663f09b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -950,6 +950,7 @@ F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
+F: tests/functional/arm/test_mcimx7d_sabre.py
 
 MCIMX8MM-EVK / iMX8MM
 M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 989b841555d7..e657ecd27824 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx7d_sabre' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
@@ -60,6 +61,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx7d_sabre',
   'microbit',
   'orangepi',
   'quanta_gsj',
diff --git a/tests/functional/arm/test_mcimx7d_sabre.py b/tests/functional/arm/test_mcimx7d_sabre.py
new file mode 100755
index 000000000000..2894b5201fd9
--- /dev/null
+++ b/tests/functional/arm/test_mcimx7d_sabre.py
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
+class Mcimx7dSabreMachine(LinuxKernelTest):
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
+         '20230607/images/device-tree/imx7d-sdb.dtb'),
+        'eed45fe3ba682cc814217bc4558551d36c034ec7a7692c4eb6eaf86132baf80c')
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
+        self.set_machine('mcimx7d-sabre')
+        self.vm.set_console(console_index=0)
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



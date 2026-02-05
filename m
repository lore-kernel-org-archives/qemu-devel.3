Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E3EC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzA2-0007g7-Cf; Thu, 05 Feb 2026 08:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9x-0007em-Vp
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:38 -0500
Received: from p-west2-cluster3-host8-snip4-1.eps.apple.com ([57.103.69.54]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9w-0001Yw-6t
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:37 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 AD1121800141; Thu,  5 Feb 2026 13:12:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297155; x=1772889155;
 bh=uYfGepuvX25YdvzNM/DFH7a6wkIX8tO0xW4cMIOnmXY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TD5c54IwarH7Xn5ACHdNnuCquSbSFT9MBrU4dzQYm/Flb6CFFs6+AmW8yXRmz2aMGgSCgXY/5wMJ0GvghYPG1yZzwS0PK7//laPYvlu9TXQvOXmD51qM3WcsB1iqDBvr34VttPYIMG6h1+y235KsBjgDgYb8PhV0748HcUWLRxzVmlgPQK3Ca4bYXgmQo5SYpRuvZkWcysw4GahWlE8CG0/T7M4XqLMpY0fZAg12h05cdbdYKJMaHoehEMOYavUV6vQmoRGmAXkMX1V0L9Jr19IirobuOm4WgCU6guzD0nEIE1Yjp7koQPbQRsL5RiAS6OxP/bCjIKhvspalfgvedw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 5EB5818000BF; Thu,  5 Feb 2026 13:12:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 07/22] docs: arm: update virt machine model description
Date: Thu,  5 Feb 2026 14:11:36 +0100
Message-ID: <20260205131155.22780-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=DZEaa/tW c=1 sm=1 tr=0 ts=69849742
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=yTMYbjrfWCcMMitk-bsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rbIiH2YholkmUVOImCTcicM0KB8_dxP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX70OfMwJdep+8
 q0ZKqFT0UULBXMVdp4JSxzWSFVmlA9Q1rR78GIMYGdX2lwRx7XepElo/3Q7+9Pisa+tAZpu5OY3
 2yCblnbv3YCGnF9BFqWxG3BqNI/zfJUuPZ+i5nQjFeIaYoS78EVDVgr/uwD6my46M6zmQ5FQ0a0
 rcW5oYYYp0fMrBEv1H0LrfrrrH9F5SoiUnwrPbMvGe/M5fa+rfoh0aQwK8WD/n18CcvBdxH6JR/
 R+rp/Cr3hHFXE0LBe0Hz/Bq4B5xdoaHW8DYDDnllnWHAQeIVSPy2X2M7E4WrXYWAfNJ6VmOkLIN
 +0bY4PJkgYVNguq6NOMUpMFMZENbKIH39ygJnCr4StChWgCy0hyNGIl6cNsW0w=
X-Proofpoint-GUID: rbIiH2YholkmUVOImCTcicM0KB8_dxP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1030 lowpriorityscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABt2GsXl6fEac8RpeuzeVL2QLrX1N66J4nokBxr/242vaOWT0svh59wBQ8V4zJ7Om4C6uutmjmzsdSp9svfaJBsCphIFbMo47S2fZT4wRXJpJKWSr8eqc6USNg1NtfnuIjN5ONaw6PECxtl9oqXfXhjuWwIOGq12QCzFXwP22L6a7guskD2tbcdEWIVO5Q2XZXgWMR8g7stZBD3SMWr71v1HVH4G0kjaX6XjuGGf0CZSfAk64boqwMbdMe/YnJ0T3fzg5sWIT7SXTF6o0GvzDu2aQNvENAcr7xdyVP0vhRG4n4rKWQTWi+ye2HPBTyz/K5rSTlbbqJTcG1FahlE/hQ0nuPjuBag10+7KY21ah39RyAKv7+yQqOmDLbXHGYg4RWKgq/KjNm8bHRqxpiJtr2XS8H40kqD732+1aUjx8BVKHhEUKhJ+Vud5QiuSkVzRWCGMIm+hG2MCNPyjYyw1KfsWQNCpIvLC5X7i3niTBK4xtqfSPTG5mhtPEgbh7m+eK3xAYmrequeRKG02MzX75wB4yvJ81DpUHLcJrUe5H264rcehV+No7HIC6AIFxdD7s4mtHYSc5ORZ4k19qLEt5pGhvtk8qRBO8mFNtJ6dUUgQYYAD22NZgA+Oljv2c8jkrIuriSojXiVh/gBCNIBxd35fDyY0oi9OrNhCdwdRE7a88ebSIK2FP26CdMfw/dJUYOj++bq5Gu6N75dljucrYi1pQ77HtN51nqlh32zrJW0gbGqrEVGT8nzRUIIExGk59W+ZBZUbShKi9KD70ughrjGgz48wr6eKkBAh8+iM0yYTAeSE9f4UkcP2z9Ge8oIhqAs9Sv3WCeZLEeThKOI221Ep7uOGmUMGJLTe3RYxmZQtsGv76Rt0VkOdKwjeYyubFYqgKshyYYlaUafB7zYUhjycBZeacYB9w2gSCR+mtYehC3v/LVr28rdGVcEIK6eIy8
Received-SPF: pass client-ip=57.103.69.54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the documentation to match current QEMU.

Remove the mention of pre-2.7 machine models as those aren't provided
anymore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..f8148b5dcf 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -41,9 +41,10 @@ The virt board supports:
 - User-creatable SMMUv3 devices (see below for example)
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
-- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
-  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
-  that ITS is not modeled in TCG mode.
+- An MSI controller (GICv2m or ITS).
+  - When using GICv3, ITS is selected by default when available on the platform.
+  - If using GICv2, a GICv2m is provided by default instead.
+  - When ITS is not available on a GICv3 platform, a GICv2m is provided by default.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,9 +168,22 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Specify the MSI and MSI-X controller (GIC) to provide.
+  Valid values are:
+
+  ``auto``
+    Use the best available MSI-X controller option. ITS when supported, GICv2m otherwise.
+  ``gicv2m``
+    GICv2m. Typically used with a GICv2. Also available with a newer GIC.
+  ``its``
+    GICv3 ITS. This is the default option when using a GICv3 or GICv4 with a supported
+    accelerator.
+  ``off``
+    Disable support for MSI/MSI-X interrupts.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off`` to control ITS instantiation. This is a deprecated option, use ``msi`` instead.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0A4C2A07F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkGl-0003bb-Q2; Fri, 16 Jan 2026 08:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGF-0003CU-5b
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:11 -0500
Received: from ci-2004e-snip4-11.eps.apple.com ([57.103.89.53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkG9-000278-68
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:09 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 16A02180F914; Fri, 16 Jan 2026 13:53:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WIhlnxgxBCyc+dWCY0SbNhn5OBvUHdUcvG79a1EP0Gg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=I4vr2TS9kAGIBsfxbERJ5pxPSsLyrHQ4d2GMZBMVJUKKf0aGsAYDbGIdzyN7QlAB5yzwaKgg4YVTZ5r+jF/5B09+f5Swea+F60DJ8fsmk7Bi9Ocs4HwtZE8SGNqNlA00VG1QOZY+er98GTYwJTjPxpiRszCXZgx41LO19qBOEq/edpbUKlN60WWGhutyGxNOhQTdf9Lufi1V1lPry4d+ZkiMpJf6zRmJHp86ILDM2JWlQE5+bLuca4V9UAbd3sxKnKW4iC97CIX0IHVR9PguzP7uBe3gJNRCEzZP+2L1LTnAR/8CP+YpN+p89fv6AIpwDqpi5H2mmQsqsPg2VzP/5Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 8E9D718000A4; Fri, 16 Jan 2026 13:52:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 08/26] docs: arm: update virt machine model description
Date: Fri, 16 Jan 2026 14:52:17 +0100
Message-ID: <20260116135235.38092-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX0vARsX7Wgb/U
 lwxnhxRaVRnGa3BtuGskq/cZ8ucV8b0mQev0277f0xtbvqM21aT65AoIFCnWvGTrtbvCVXI+hDB
 rzOwcTEEGJgg1hQ43hsk+usZ1a51iacuaOr3Usy7QBi/vOOHCk+UwjK6juUOTRoT9gi6UiY+R0i
 d2LrsLazzzzt+TdHtQ5fv79aDmgCTUChEd7Y9CHjINgwDtv9fUIIHargwHqFfnqFXV6fOlE8MFy
 iiy/eB8CYrZXRvVML9674lS7u2VFCqN/IgBQnAXi0FT9KTeu4STgTYnOqf08iqILkxAuAQEiQe8
 MXEFsaZnvPQwPMOSqYE
X-Proofpoint-ORIG-GUID: yAl4kIizYxx4W336QSnJhB8L6cCWvxjp
X-Authority-Info: v=2.4 cv=ZOTaWH7b c=1 sm=1 tr=0 ts=696a42be
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=UWX6RoDBcPCHCN3xbnsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yAl4kIizYxx4W336QSnJhB8L6cCWvxjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABtRPL1EnVv0qKcotpu0t1LKxV4Y5QMn7c1DHMsJdk3I4lw3NWanbBd5AMs+UWmaJqiCpNUw9ka07Y2mviewh/C0Uz1qUiuev1Xq+W7zbpBAxZJVfIfeo0p0mrBWMU45rUcqKn2cIlqI2clpGNTZxTbyUWj4iJXdnUU1jTzXX1OH+43G0eLMzPNwcCyLUsDkXufbQqbj5/s2HdN7rgUZsNS2/GPaGGGT4X0vKhWedkeVhCdnyupz9Udv4FP8iF5wPTvxChxZJKTS5tEvBO5KvKiRLXnN4PaOMzygi8habhL5R0O+KIqUTG+8g20GC2hJtHn1Pr0UWyBoDycjH8J60EYGZ6eiSUt7lIbAghD/j6XGK0mnk30jwTuaKz1H+IEieTLXTqYqjK2urStfWLofSyeZVmbCU34YCgslpavwTxQigGtH1fKQsUQuFoXZQsLjRtEU0cfX3/yainIYyadDdebATLJ6SUjoiiHmB5nxGrGtSL1tIr0kfoQxcC5alZaJ1kW07zH5m07K2OXoV7KXJu+iRYmEC1e3VJmV7ktmO/MdO8rhH2ReS2UnTYS+gsAthCiMkzNmRb8wor31mqxU8LF87z4+JHmPldB6YtMK16Pubsp1IFlEcoiMk1l2JKTPmPpOxTHr0pczHEUejUdEzrCYp+o03iY628m/tXkXAYTpf8yUGkO8QPeZ6K/sEUPFtDcKAx0QY20LAl6SKUmmrfbeAO5eOfI2HckaHoU7BWEaXoshbqLHYWQ4Exx4GXxToNZ2dGu5RFZeWl92Vbs7m1wpHO6hfEHWJjN59Tp1iYa2JiEjtAOA==
Received-SPF: pass client-ip=57.103.89.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/virt.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..b6e88c4f13 100644
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
+  - When using a GICv3, ITS is selected by default when available on the platform.
+  - If using a GICv2 or when ITS is not available or disabled, a GICv2m is provided by default instead.
+  - Before virt-11.0, when using a GICv3 without the ITS, a GICv2m is not provided.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,9 +168,11 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Set ``auto``/``gicv2m``/``its``/``none`` to control MSI controller configuration. The default is ``auto``.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off``/``auto`` to control ITS instantiation. The default is ``auto``.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)



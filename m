Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD67DD2FED8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknq4-0006ea-Jv; Tue, 27 Jan 2026 13:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkno7-0001vt-SV
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:01 -0500
Received: from p-west2-cluster1-host6-snip4-8.eps.apple.com ([57.103.68.61]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vkno4-0003VU-P8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:55 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 18CFB18000A1; Tue, 27 Jan 2026 18:28:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538531; x=1772130531;
 bh=ctbJXzUM+EvVedcghhTZxfriWpjcatMtmi/eA3/zXUc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EhDftkqq6JYfDSCGeh+YJhNAwqBpabMWxsRDza7p/k3XuX223FDoPxDdfu+toGi6G3BV/I3bSwvzVG2PsVr6UMbi8SL96NWtZBeAgsGUZpcwkJQL9vv03jGZ5HvNAwVjHxaOwN/muXGTyy/urM+k+5xUnUI7dXBrhALeaLWP0bbgRgfrwSJJpftukGYa9n9vW4fv+bfLbNWQzWRv3Ml/L8z/FPLfAzinRlevPtfap++CaPzOIZWlPjKTFeM8GIE2RwDQ3jtqunlcaHfZPU06+FJuTyn6kbaAFIxL0bxV75SJwfJIMBklUDuXsp9p9Wh3PpLQ2KpNbRKiOfOOdf9Tag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 E62531800277; Tue, 27 Jan 2026 18:28:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v18 07/22] docs: arm: update virt machine model description
Date: Tue, 27 Jan 2026 19:27:47 +0100
Message-ID: <20260127182805.73212-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX2XQshyGIh5vZ
 o2GVBGTqbJq+zCAOesWlMCr2UmGBw7uMnJi7o3f10OURVJcfp3QeTQ3WtCSzl8B7H/HlENaH5sv
 wwbQnBwbPW1etSEjOZVieaWVI5B4g+3Rkg856NJmhW0i8thsmx9PvebleFdHFhn/q57k+jIUDDa
 2u++jz/9VPb96/TlUmpaJY2S7nYWf1nlees7RwU7W/ea+RGEhWUFHZuW9jOJY94wPOD99pp3hKS
 fGIsNKxqR8gdsHyfnKr9U5zJJJ7Ifx0DRUIQDm8GZh5ylSKr7zdlWbiRXo1/7z5z/NmaT6SWyyY
 BMt3qdgqbWHxyKfX8kr
X-Proofpoint-GUID: GO_o24ezhhuAwx61qqXM3vcN-qdRQfNG
X-Proofpoint-ORIG-GUID: GO_o24ezhhuAwx61qqXM3vcN-qdRQfNG
X-Authority-Info-Out: v=2.4 cv=Id+KmGqa c=1 sm=1 tr=0 ts=697903e1
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G9h577CSrmnrssGYHncA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1030 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601270150
X-JNJ: AAAAAAABU1gqCUWAVlxzMlrNjSVtaTCovf8npz1FH2c/dF/Fn+Lh4b4B2U4mml46/IofiAg1Qu+On3i1ny52chGEMf66onGtIRyqSBOJoPKaYsRKv0wx+BhewBZaUX4zimVyqZ7esf3JIKDZBPOfVS6l8QtpIrVYjKy5sxFJXS3HW0LV49FaVCwdW+/9y1Ls9o5k9BxlO3iSlNOSjpOBlB8cPxbqcmc/A2VKgL0CezHOURQfZps/QCqVEV/PtEySYJ9plu/ljo0hGPB28CsGrNmwrIBC14Bstd3MEKLOVLnzy6u1Oq3mcutcQWYWsS7CPPOFgFQQafQ7zCWXsQ8oudiQSNq1aG6ZQeP0D2cCgDz/+I+h+o7+2MwJvlRmlRDa5h7axd7QBQokJigfvFKtagBKT6K9MLXx4WghOKcSvfTJ5C1yXQ7ef4hmvz/qDYIOSNSw+QJTfhVy5Nbp72IRBDzytwUpKpoj/XSK5Zf4G9P+5fj8hzH5CTtchn+maW6tcA5DJUGAl4g0jyFxRJ1VQG4KE/UnqhozMLyE5NFKnhItr6yMwMzwSMuPF/9ds1/AI9kdFQie70YXpwIXmY3h/BqHOPETbFOjD0IoP2qf93UjwpZtUnRk+gNimkL2MJaooLSkTS5bwsZOBJgjhCVy0PMhfTbWm9RE+B1E6HRRzxibFQ6WGaM7u59tqpLbof1RUt1zVGIcPh1wnyZTS7YEzIRgL9714+pKrwaxyma2UfXoJve8yL7zb01Du/Yl4mezX/m358RCBqQ1bjZ7/31yhLwA+8KSoimL0upoTPEJYWNTS0+6l9xoGcs73nxJQTOI/G90JNxASK1SIpIQqnHK54BwMSf1gvsGnm7ZovEVWvVumBieYpW2fyDUggTYbQQG2iFRYWoO7EyKB48q6EeIA2V1nrQNylvTWuCQQk5KsCAklw==
Received-SPF: pass client-ip=57.103.68.61;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 docs/system/arm/virt.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..3799d2237e 100644
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
@@ -167,9 +168,11 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Set ``auto``/``gicv2m``/``its``/``none`` to control MSI controller configuration. The default is ``auto``.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off`` to control ITS instantiation. This is a deprecated option, use ``msi`` instead.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)



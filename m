Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF57D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZP-00061e-Ho; Thu, 29 Jan 2026 14:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZN-0005nk-0Z
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:45 -0500
Received: from ci-2007g-snip4-4.eps.apple.com ([57.103.88.67]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZL-0005uj-Bf
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:44 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 852BC18005DA; Thu, 29 Jan 2026 19:20:37 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714441; x=1772306441;
 bh=RdLZbxPcaLo/xyRlZd+PmykeTOTcGaJlbn46eiVhlBY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=fPoSNat3xV7VzqlSD/mAuvc7ZF6o0gJlOwqqygnMto8dR8mplmbkNAV/eB2/aP6gbPhENfC92fuLAoW04uUvRPXyhlzrdBc2ZvXU5oloxJs6yM1v7mBVucM6waSc0JaQIIm+kRxfAbuaS6tA6jPdiQDHg7p558gndiChUHVpr7aTFMeMp6+ljCyCGahbnftxGXU26Uad1A7brL2Sd9yZpAA7UfVQJEsI7w1JXbqQEFdbs+9RTBaxS4Pp9kM/wOzcXa3ymlueZ/sKN7zgtvAzMIHAhysPGYHdyJ4roINvNTAmG67CsEyOBv35+36O2fycEBDpk9OaXkwtvaP3mzAd0A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 EFBEC1801891; Thu, 29 Jan 2026 19:20:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 07/22] docs: arm: update virt machine model description
Date: Thu, 29 Jan 2026 20:19:52 +0100
Message-ID: <20260129192009.14707-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xBgICWzg6_cMuoSqzZ6nwTTEyKmzGZNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX2/ZVSUp7Ghkr
 /RqSRD9OYZUIocg8rPJnKr46Yv4jmtU2C3K1AyAewXTgLpiRerQ5XyhsEbIzefbWZ0zDbXoc9J6
 0u9CZ3yeZ8++s8wnFztz5pvBFMuqlazK79vpvGgSAsek9OKKKRKrKVH+9V4PNfjYPVQYnMFXUq4
 DJXoDthFE7teUpopHq7nmkV05r4SCKFAS1N6t68/7jLm11KJ5LoHp9nFnjAN1Ac6zSgNF8yNJX5
 3ZxpjZbUeMyariFoylu9dgWItkmXUZ3Mn3BHESik/soba77Et6c7K93mnJaJ1hKl/wJ+ZRlSQez
 Tzl/rbeq0c0YJx/cq45pegpsv3Jf1cmh0aIe5ketFQLOuPl+MGLtR0Hnv8vFZE=
X-Authority-Info-Out: v=2.4 cv=ZeUQ98VA c=1 sm=1 tr=0 ts=697bb307
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yTMYbjrfWCcMMitk-bsA:9
X-Proofpoint-GUID: xBgICWzg6_cMuoSqzZ6nwTTEyKmzGZNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=999 clxscore=1030 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABmzHHOUNHM0fopoge28FL7W6eq/GwKph+xofCJS797eQzcZCQVZZK96+PKxtWObRWrh8LfuS0Wvp6U7IHx6xohWyIbSjnqJGVZzDqb97XiQmtCWTpsi2qnypIsR+v2q3oGIoLgvXa59c3ieWxFJ7vgmWT89oI0/ov70nq5var8KBICefis1HhEQteYWyT8ssLnhKONQwwlbkCIdbghet7H2Zgdn2p5qpnvdCG9oMRM4LPqcJ5uDVk6XG+AIGGMxJJQJG5aDqAN+7mq0Tntduyak8OmZcv7jhAA2+AYpLw0NCaN1uPab5Q0GXkjnvGeOnSWXUzGRnx40PqSxXfHURQ5hM+cSZkK9VeY5p7AatubCSeHPNZYDrJs086PkJTTbUkZdgPMDKcmZBE1ViacS7XAYYVp6gY5hKbzmfDMNnm4HVCYics6Ll5TqkIhNkAHE6wavVJx+UR9d4YrohmoATer0jLfR1IbTROlNbP/4cRYPNpIIRCzaoBDhYF7mb85ikhNoWUY9RnkV4QT9uNOu/RWmm0kf4ThHIBAK6gaQ3GkFj46tNTlLMWSOLrOUklPScPALqMbCi3NZVchBB6aYYZ87ulZsPFANQEZufIPwc/zgXQv+5EnEh51Pr1m2i7gPePibmgOGTq+Pc8zTKvAlXHjvJ0C+zjYBTRlxDGg0BFrVn3hBkaZU08MscuH39YKiIbfi5RVHT6RJ9nCzdnnabxTZ7hZm6ej/mDOn/rPQd8KxlVQCwDuhBbL3Rfaw4gO3iNQ35w+hgeyS8ZOeSXrkxV1RZlhlSBldSS3WoaWopFtm24A3TlitxwEmUcZ15tC/hGGduEta7Es4c2WwJrtU1Co0AVt692F0HPF9agaGDHPEDicQ==
Received-SPF: pass client-ip=57.103.88.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



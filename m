Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF41D3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB22-0006EL-E4; Wed, 14 Jan 2026 19:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB20-0006Dl-Iw
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:08 -0500
Received: from p-west3-cluster5-host2-snip4-1.eps.apple.com ([57.103.72.74]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB1y-0001vv-90
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:07 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 2AA5218000B6; Thu, 15 Jan 2026 00:16:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WIhlnxgxBCyc+dWCY0SbNhn5OBvUHdUcvG79a1EP0Gg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=D5W0YS65SUWkp/h/4y5QctrCaSLqPnV3MDsrG3lydd/8f+e8vhjN3kH+0jnZDicHhaXuEgy7EMA1xKKmlqIMXAAR0RQdSR0Ln+9hjyuQ8n7SiGyf4ILzJqP+3D3UdS8ywqKcK4y+rrarH2pj6ZGzp+5kyMiMqzZKYtCXtVY3udVVpPGG7vijUDKYrVABkHvF2CJnVLhISCNrVa4rg1tolWD3wHuQi/RiHAv1StDeJnMwe5506Mwsdhhl3fqV0iChLmBlao9Juw1ro4Entsm/Hj4+k8u+2g1/2FfHtp4AVFbrFiWwk3ECaLfLJDZkl9XhpoZcKjcdkPj48wa4snAEFw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 34534180044C; Thu, 15 Jan 2026 00:15:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 08/26] docs: arm: update virt machine model description
Date: Thu, 15 Jan 2026 01:14:47 +0100
Message-ID: <20260115001505.57237-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=a7c9NESF c=1 sm=1 tr=0 ts=696831c4
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=UWX6RoDBcPCHCN3xbnsA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3FUIQYR1-voFzuNammOTidQV0H2SKBQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX8exHBDpIB5EC
 iuhoPeEJpKfat6dKK4kPgsnwA/2RP5WCy33/jRXbToraHvbYK5QBzLyFh1az/I8HJXd2Gnp+4gD
 E9eoNWnIhUWQCHpfn2TPBgXUVPIuBz3srsFrdhBcAgUh1SRAiEiYyq09wRjqdyp9+q0oB6BD/ql
 lHXggqAgMxkxM+15ERF+bYPA3GMMoNljmmY64FhzJ1jevY7tEycB+C8jcZtodCSS/Iif7aZauRv
 WXdOZ2xCswqaBd0qnLF+uFly4AcOABVhrIyeTU8QZKqn9geAThuxz3QcOLPbZ5zr9DbnS5cMTsm
 s+vyU8zn9+GiJDO5ves
X-Proofpoint-ORIG-GUID: 3FUIQYR1-voFzuNammOTidQV0H2SKBQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1030
 adultscore=0 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABf2GbJ5eYyFpYcBr1q7jrnKfLVrRNlwQWnXZcByIUzrwr0cm1WuoeGNZ2r5yoIUDWUK5tIfNpjSyLo9ga7Pbe10eJSv1LCjSiPKpz7eJC11llyfS0MWrpIx2RQTvIOkQ6BCN7MRZTluwYCPfNtFMFiTSR2zis4lpTaUoY6Zapopkm3LUwb6zRJLbkYDKu3uha93775gIe8Qvw0hYoZc60ALjQn/e8zuwXgGSosCgfsgpWw9kCy5reiyiYyGPfTewbJxufHtX7GhzGbm2QhgmJLGxfM5e17teTnJVB6VNi5++MGWLgMucAV+NrzgfbDnsMSIC6BZTBeb7eBoscp649+h2fUjGWqjKd162VXWNRPhtJp7x2M/DWglYL9Bo7gE6Lbv0lMDtBvIvhUIHrocymw6n9KTGrqPqOKUJKY6adPv3Z6N6vvqMzBTEuD/aiekA6n/7DKq1JFINB6SLn8tCEGjyX+7m1G5PIXqcc85+1lIScgN9TCXav2egaw6RO1vEz503GZ0LHqO50yeYcFMgln/csFtcSb7ZyEyO4fLf56jMBFN0umlXu/2uXF1ZPDZAn2VEjsfkRc6u78kcGGJy1vShces302zvNQ4a2Wy7xDAURKjKjIAh6iGF9s/66aIvzbrLFpdDhVspXbe/tWqcz6YMB6CJ6gz+WcrScX81rW7C0J1pKAmdlEyjWWL87FPlsKwAqslyMUssBRhA/0WT1E64IRdGyT/Jtk8XYppG69LnBPeTNttcN7azEZpQA3zUuQm+eXConzY/X5lu1hN6AVZ5zxnWX4pqfcApFXdO1rEnQqUzqdfxqD2IF3zjRM1PxeVYDxkQ+N/wN/3F6ykcI64iwAJi/YyBvTwtcRpQtUq5qKzCNNbbdZliruYY6fLhGEPYFhMS+NZ5KAwOqL046zRKK0zvYOnpvJ/vGX6xyvdD8Sv9UaCOd3h46psfMj1lUblw/hS62
Received-SPF: pass client-ip=57.103.72.74;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



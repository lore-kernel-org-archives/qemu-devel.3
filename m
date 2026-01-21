Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40DBC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSo-0004Za-CM; Wed, 21 Jan 2026 08:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSm-0004XU-Qu
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:36 -0500
Received: from qs-2003j-snip4-11.eps.apple.com ([57.103.86.103]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSl-0001Br-9a
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:36 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 8AA2E18001B0; Wed, 21 Jan 2026 13:41:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002894; x=1771594894;
 bh=ctbJXzUM+EvVedcghhTZxfriWpjcatMtmi/eA3/zXUc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ea6kyHE7uvJIzIsGTQMPOaOeLsQd+r1/A34XA50FOI+5/v/CTeB/+0jqdZCrM+EyW037B7W4gJD+cvR/b6+9AdeKCPsk7UDfd3Fp0npwx8o3hPMasaTE9ZQOOMCJqympn1CofcowHuOnt7EaEquNcm5tQJi82HppXeYYEidJp7NEyclkqbsOM3mg3AZ5xwg7SxfxshPNMvU64q/9KL7sHiN3/KnLuesGRA5SE5cHbJkjT6hhejSNbVFWSnAM+XqKWC3AyFLVUeiSHm+h6iSyIkFswsmXW+PxYhnI0CXVrZiYJwI1c7jS38C7VePLy70jE8gsxpW7jh058CtQNx1BLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 D5022180012D; Wed, 21 Jan 2026 13:41:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v17 05/21] docs: arm: update virt machine model description
Date: Wed, 21 Jan 2026 14:40:56 +0100
Message-ID: <20260121134114.9781-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: utxM6Mkb7SHzZpQh7XX2lf9AXJbdWDoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfXwI16/IoUaHTw
 XdYQaVeVok9U1t4i4I0c90jH3GWD68rWVMdvCiGycNI31QJN4Y0qwiHYn5wsc/oGKhRsOCO4YIj
 1qKICjKkU8ZgOuFOT3WUpPbQhsbQKwKgnKA9hhAOfioKvMtQcMCvMs8I76D+w4jCBkCZiL1xsB6
 MGEJSUTfVzLihRrpWswno4P0g37JzmmV/UajBaWkXhXu/8dOKkWG2PG8CVleJBPYZb55s2zmaS7
 hvmaMKMCJs+7xG3a+9Cjr6C8v2euYIKLm2SMQ75BZs5S2Yj39+nm29lRDXermhbY7Bm5TdBx5Nt
 awRNU/DA29Sw2BaLTtJ
X-Authority-Info-Out: v=2.4 cv=AojjHe9P c=1 sm=1 tr=0 ts=6970d78e
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G9h577CSrmnrssGYHncA:9
X-Proofpoint-ORIG-GUID: utxM6Mkb7SHzZpQh7XX2lf9AXJbdWDoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAAB5BuVC4U2B9/VJa/y4ayQcvAVTEk+qqJt1TxSliaImorJv4TPZxeNKnrjZ/cq5r1Owl8PatU1Z3b+y2EyZyRO2NUvj/na7hV5wSNz+1Vxrl24+XqltR+DXx3FRdLOQmenCBF0wgyXPA5TOemwoPe9FeG7poKuc3BmeyAf8tjBVqIVIhkgNfL9bXzT+2JM0uDts3kbendveC4v09n/oBkW+2pGquWzi6Mu0y5o/dAKjPm4+td0GFTVNI/EqqIscCtcBacQScfJ2TKBDDyD1lgi1gM3yKkPAlSBcPtF4pYBEM0brmTYtCpGfwFEaiGM31f6Ith6+oW7wgeuyd4rDwoHnrMlmsA7M0fdvdyfQHxL2ak+7bXgJYCdcfc9CAbWcnUIQE7BySeZZKnpyFSkleMMBK3AR1tjimVwdGrx3qgoYf/3Bpg9N5eax0QqaM6H1h0sK2pODmA37NJFwvnjnN1+Pq5TYTGL/wg/TbNrBa3+RTBSMR9/+doVIhy4WgboiZH9URwX+oCyfYyk3VYFpmEuQz6iyjJVRXNQCA5eCXewtey2NjlUYawGwUmnXqZ6juUnWJ5Ej8WIFuW8UaKMtVIw/woPbJ+eIov9Fzo1efwFnuSSnIUS5LditHlGKWDy81Y+bUPPlhwyYp5j5g3ur5BbSdkGIEM5EAI2XkqpCxQvu8BCbJPhT3cJ0VvV8wcgfvoysuySvK9jy7mYTECodUHp1RBPfyykXGfKlOn9ypElccQIo4uTRn2uy6T7TxNw6YLHUCsS37ehZHo5b2+Mv9Dj1R0hxx8xpnk8xXzeL7E5WAjaPaTYfmoVWQ6eu9wDm4ljTJ5XqrIUqHut7V70J9vdjLfnK/TkIbcLCYToA+xo8FPkngWjn2yIYHCEYJA=
Received-SPF: pass client-ip=57.103.86.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



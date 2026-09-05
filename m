Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FBDC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaL-0005H6-Kj; Sat, 05 Sep 2026 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaF-0005Ds-Uu; Sat, 05 Sep 2026 13:53:44 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaE-0008IF-1f; Sat, 05 Sep 2026 13:53:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B94F601DB;
 Sat,  5 Sep 2026 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7491F00A3A;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=wQgyAR83act1RsCI64W0ZhW7znuJEWe5RJhFGqpIHYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E9Smco0sr8osi8vff1k/862N5+0EHe9XmUfcOTnEqXv0FhfFyzNYVfDsdbLtsv9MM
 XrGWQzYsvTBIn50+2zojaJzvrJQ0K5VXBFFkoih+QW7TJQTzVSR29fVniExwpY16PC
 RsEPCkqGRSN8oAafRLwMxp/jVGu1NYY037Mo2QWvvf9HkhOjKuYY8Y7mi0pf69wgzg
 4teTh9C8l3nsro2qDPReMBfPzgBWk3lhdAoruF+h2afCWW2UHs4HKSq/IayhcNlqix
 z2AAHEsUWHO3lVucuVucqVjskJmbEDtjZKNWy6in9dzbhxPI3aldUiatQ7O27BMQXT
 U9Ih5ino80VYQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bks1-3P5j; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 6/8] docs: acpi_hest_ghes: document notification mechanisms
Date: Sat,  5 Sep 2026 19:53:26 +0200
Message-ID: <ad5db180cbb52fe101c19edfcd1bf144e11fff76.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788630333.git.mchehab+huawei@kernel.org>
References: <cover.1788630333.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the HEST spec mixes generic support with arch dependent
notification mechanisms.

Move the arm-specific notifications to a separate chapter and add
a new one describing x86 mechanisms.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 docs/specs/acpi_hest_ghes.rst | 44 ++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
index aaf7b1ad11a5..1a32550ef3a1 100644
--- a/docs/specs/acpi_hest_ghes.rst
+++ b/docs/specs/acpi_hest_ghes.rst
@@ -7,6 +7,7 @@ APEI tables generating and CPER record
    This work is licensed under the terms of the GNU GPL, version 2 or later.
    See the COPYING file in the top-level directory.
 
+
 Design Details
 --------------
 
@@ -105,14 +106,39 @@ Design Details
     firmware will write back the start address of either "etc/hardware_errors"
     or HEST table at the corresponding fw_cfg file.
 
-(9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
-    "Error Status Data Block", guest memory, and then injects platform specific
-    interrupt (in case of arm/virt machine it's Synchronous External Abort) as a
-    notification which is necessary for notifying the guest.
+.. note::
 
-(10) This notification (in virtual hardware) will be handled by the guest
-     kernel, on receiving notification, guest APEI driver could read the CPER error
-     and take appropriate action.
+    GHES support requires ACPI and ``-machine ras=on``.
 
-(11) kvm_arch_on_sigbus_vcpu() reports RAS errors via a SEA notifications,
-     when a SIGBUS event is triggered.
+Notifications on ARM64
+----------------------
+
+The ARM64 ``virt`` machine supports two GHESv2 notification sources:
+
+* source 0: Synchronous External Abort (SEA);
+* source 1: GPIO notification delivered through a Generic Event Device (GED).
+
+Source 0 reports hardware-memory RAS events on the ``virt`` machine:
+
+* When QEMU receives a ``SIGBUS`` from the kernel, it writes the CPER into the
+  corresponding ``Error Status Data Block`` in guest memory and reports the
+  event through a Synchronous External Abort (SEA). The guest kernel handle
+  the SEA,
+
+* The guest APEI driver can read and process the CPER record.
+
+* ``kvm_arch_on_sigbus_vcpu()`` reports these RAS events through SEA.
+
+When source 1 is available, QEMU supports GHES error injection through the QMP
+interface.
+
+
+Notifications on x86
+--------------------
+
+The ``pc`` and ``q35`` machines support one GHESv2 source:
+
+* source 1: System Control Interrupt (SCI).
+
+When source 1 is available, QEMU supports GHES error injection through
+the QMP interface.
-- 
2.55.0



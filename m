Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0F5F532E9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4vuL-0007tI-C6; Tue, 24 Mar 2026 03:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vuJ-0007sT-IK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w4vuI-00077P-2Y
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774336229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOl0lQ+EjlX1xzpM6vvtcnVBzwxbhD3sIRRpAw0UiQk=;
 b=Dawa2CiOTSaC2YsJpQZDiUlJUUnM77e2XbsKn+BIMRv7OaXQd/yZzFGUuj7WnPfQdkn6/N
 Qm/GVQ1vJ0j/WIGyT2EFP5NS96Db5MM8Ma2wa0vvvOqhX1xIkjL0OuAKrZVDTlghTnq7iW
 PVGNjACiD3Q58X6Q1/bdpWzbU/QzHCE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-zZMm43LaOq-DHaioHn-6Vg-1; Tue,
 24 Mar 2026 03:10:26 -0400
X-MC-Unique: zZMm43LaOq-DHaioHn-6Vg-1
X-Mimecast-MFC-AGG-ID: zZMm43LaOq-DHaioHn-6Vg_1774336225
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D6C21956096; Tue, 24 Mar 2026 07:10:24 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3267519560AB; Tue, 24 Mar 2026 07:10:19 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohammadfaiz Bawa <mbawa@redhat.com>
Subject: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
Date: Tue, 24 Mar 2026 12:40:01 +0530
Message-ID: <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
In-Reply-To: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Document that tpm-tis-device on the ARM virt machine supports PPI
with dynamically allocated MMIO via the platform bus, unlike x86
where PPI is at the fixed address 0xFED45000.

Also add hw/arm/virt-acpi-build.c and hw/acpi/tpm.c to the list
of files related to TPM ACPI tables.

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 docs/specs/tpm.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index b630a351b4f77a8d2512f22446d00a4d674c7777..63cc0b68cd79d64138d4dd05ae158430c6a74643 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -187,8 +187,30 @@ The location of the table is given by the fw_cfg ``tpmppi_address``
 field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
 leave enough room for future updates.
 
+PPI on ARM64 virt
+-----------------
+
+The ARM virt machine supports PPI for ``tpm-tis-device`` as defined
+in the `PPI specification`_.
+
+Unlike the x86 TIS device where the PPI memory region is mapped at
+the fixed address ``0xFED45000`` (within the TIS MMIO range), the
+ARM64 sysbus device registers PPI memory as a second MMIO region
+on the platform bus. The platform bus assigns the guest physical
+address dynamically at device plug time. The ACPI ``_DSM`` method
+and PPI operation regions reference this dynamically resolved
+address.
+
+PPI is enabled by default and can be controlled with the ``ppi``
+property (e.g. ``-device tpm-tis-device,tpmdev=tpm0,ppi=on``).
+Without PPI support, guest operating systems such as Windows 11
+ARM64 will log errors when attempting to query TPM Physical
+Presence capabilities via the ACPI ``_DSM`` method.
+
 QEMU files related to TPM ACPI tables:
  - ``hw/i386/acpi-build.c``
+ - ``hw/arm/virt-acpi-build.c``
+ - ``hw/acpi/tpm.c``
  - ``include/hw/acpi/tpm.h``
 
 TPM backend devices

-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09966FDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26l-0005mF-MU; Thu, 23 Apr 2026 18:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26i-0005lD-Dm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26h-0005vd-1a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWUit7ORmnbMwKkQBkkNc5UfinAhFeQM6ukdDKrJS3o=;
 b=GfcZHN337xF0DS5+1rYY/P1kwHG8csUXgf1JFt/kdIF7qW5oltS4ju6MVQASMBkE1CIRze
 A7vX4BP51/7FBCzDAOyNdQtgCs4W6Dc0RcJtyJQb/EOS3nmF2TZaaV7KwdpBaXdf0G8unk
 MAlxwInjMYUsF01agSvzGQgFXMZTUcU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-uTPHz0mpO-KRCBDjqlLwxg-1; Thu,
 23 Apr 2026 18:01:05 -0400
X-MC-Unique: uTPHz0mpO-KRCBDjqlLwxg-1
X-Mimecast-MFC-AGG-ID: uTPHz0mpO-KRCBDjqlLwxg_1776981664
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10FFA1956046; Thu, 23 Apr 2026 22:01:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A38F53007572; Thu, 23 Apr 2026 22:01:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH 11/12] qapi: convert intro sections for acpi.json
Date: Thu, 23 Apr 2026 18:00:20 -0400
Message-ID: <20260423220022.2180059-12-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
References: <20260423220022.2180059-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a55..ea6ad2cd45f 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -12,9 +12,8 @@
 ##
 
 ##
-# @AcpiTableOptions:
-#
-# Specify an ACPI table on the command line to load.
+# @AcpiTableOptions: Specify an ACPI table on the
+#     command line to load.
 #
 # At most one of @file and @data can be specified.  The list of files
 # specified by any one of them is loaded and concatenated in order.
@@ -80,11 +79,9 @@
 { 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
 
 ##
-# @ACPIOSTInfo:
-#
-# OSPM Status Indication for a device.  For description of possible
-# values of @source and @status fields see "_OST (OSPM Status
-# Indication)" chapter of ACPI5.0 spec.
+# @ACPIOSTInfo: OSPM Status Indication for a device.  For description
+#     of possible values of @source and @status fields see "_OST (OSPM
+#     Status Indication)" chapter of ACPI5.0 spec.
 #
 # @device: device ID associated with slot
 #
@@ -106,10 +103,8 @@
               'status': 'int' } }
 
 ##
-# @query-acpi-ospm-status:
-#
-# Return a list of `ACPIOSTInfo` for devices that support status
-# reporting via ACPI _OST method.
+# @query-acpi-ospm-status: Return a list of `ACPIOSTInfo` for devices
+#     that support status reporting via ACPI _OST method.
 #
 # Since: 2.1
 #
@@ -125,9 +120,7 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
 ##
-# @ACPI_DEVICE_OST:
-#
-# Emitted when guest executes ACPI _OST method.
+# @ACPI_DEVICE_OST: Emitted when guest executes ACPI _OST method.
 #
 # @info: OSPM Status Indication
 #
-- 
2.53.0



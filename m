Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A172EFDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26i-0005l8-PT; Thu, 23 Apr 2026 18:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26f-0005kn-V4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26d-0005vN-Ht
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSPkJC2cAzaELiZ9YI7x6z0UJhfhzxAYYdzqBCV/Drc=;
 b=OguXBFx9tkfxka83+F5N2nYRnqv3RP8Lxa3jg+S2ZGMIIjc//2vW16aApXuiry2fn2YWf4
 bCDsspeDsMm1E1mkJMZ+2PHPcQHq39k28coFMZc3d83v2xHB+XmEfku+A6kfJ5toBIyc8T
 bho7ZTn1DR0VMqaUBQkH3rNKkclAPME=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-OTj-ZPO3Ns61NM3O2u6VxA-1; Thu,
 23 Apr 2026 18:00:58 -0400
X-MC-Unique: OTj-ZPO3Ns61NM3O2u6VxA-1
X-Mimecast-MFC-AGG-ID: OTj-ZPO3Ns61NM3O2u6VxA_1776981657
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 023221800473; Thu, 23 Apr 2026 22:00:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 699EC3007572; Thu, 23 Apr 2026 22:00:54 +0000 (UTC)
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
Subject: [PATCH 09/12] qapi: convert intro sections for accelerator.json
Date: Thu, 23 Apr 2026 18:00:18 -0400
Message-ID: <20260423220022.2180059-10-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
References: <20260423220022.2180059-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/accelerator.json | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 0cf5e0f9d94..71047538ee1 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -12,9 +12,7 @@
 { 'include': 'common.json' }
 
 ##
-# @KvmInfo:
-#
-# Information about support for KVM acceleration
+# @KvmInfo: Information about support for KVM acceleration
 #
 # @enabled: true if KVM acceleration is active
 #
@@ -25,9 +23,7 @@
 { 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
 
 ##
-# @query-kvm:
-#
-# Return information about KVM acceleration
+# @query-kvm: Return information about KVM acceleration
 #
 # Since: 0.14
 #
@@ -39,9 +35,7 @@
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
 ##
-# @x-accel-stats:
-#
-# Query accelerator statistics
+# @x-accel-stats: Query accelerator statistics
 #
 # Features:
 #
@@ -56,9 +50,7 @@
   'features': [ 'unstable' ] }
 
 ##
-# @Accelerator:
-#
-# Information about support for MSHV acceleration
+# @Accelerator: Information about support for MSHV acceleration
 #
 # @hvf: Apple Hypervisor.framework
 #
@@ -81,9 +73,7 @@
 { 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm', 'qtest', 'tcg', 'whpx', 'xen'] }
 
 ##
-# @AcceleratorInfo:
-#
-# Information about support for various accelerators
+# @AcceleratorInfo: Information about support for various accelerators
 #
 # @enabled: the accelerator that is in use
 #
@@ -95,9 +85,7 @@
 { 'struct': 'AcceleratorInfo', 'data': {'enabled': 'Accelerator', 'present': ['Accelerator']} }
 
 ##
-# @query-accelerators:
-#
-# Return information about accelerators
+# @query-accelerators: Return information about accelerators
 #
 # Returns: @AcceleratorInfo
 #
-- 
2.53.0



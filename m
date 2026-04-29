Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260EECCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAZy-0007wB-T8; Wed, 29 Apr 2026 15:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYn-0006ht-3K
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYl-0007tW-OA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSTrmcdDV2VoMJthdCMHqXRFRr9NpkQNPIiunlsA62I=;
 b=BbLlB5pzA7hYCyaqBjxDMxJsDV670oFAL4iuGmDtaK2RpsSP4RAMa3Li7vHdzyJlqqPHhg
 mxuW25Rqy76TMRD8y50rwzYgU0a/UhOaQ1P+K490qq4wSOk1TSUH4IM00cHf3lBT3IKgGf
 kwXdjefJyTzjUqU2qG9iVnTfnlI8ZK4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-ZQ8QttCMOVKIUWwdOujvqA-1; Wed,
 29 Apr 2026 15:26:55 -0400
X-MC-Unique: ZQ8QttCMOVKIUWwdOujvqA-1
X-Mimecast-MFC-AGG-ID: ZQ8QttCMOVKIUWwdOujvqA_1777490814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED90919560A7; Wed, 29 Apr 2026 19:26:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FDB9180034F; Wed, 29 Apr 2026 19:26:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 09/13] qapi: convert intro sections for accelerator.json
Date: Wed, 29 Apr 2026 15:26:07 -0400
Message-ID: <20260429192611.1581223-10-jsnow@redhat.com>
In-Reply-To: <20260429192611.1581223-1-jsnow@redhat.com>
References: <20260429192611.1581223-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.54.0



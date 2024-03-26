Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B041C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KU-0004jB-Sa; Tue, 26 Mar 2024 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KT-0004i5-H0
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KR-0005OC-To
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIVOxC2w7Wn/kcJp/FXvScbTguULSLDlLZHfPoA3iyo=;
 b=aDtc5yxZSedJbZlBa9X3AE3eCugiVNZ4vin5eTvnqysGK+oYmRf4lDLYAsjcvLl8DJzNRT
 grkPAc6GH6gpd3gxxz/LBt7oelGq4xTOj/4QWcjXHmcoHzLuxHNSb7kD2DP5PCnqc6wwms
 zwKl8RuSU+2mBSv+ZmLwSf5lp/iNcPY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-c7K1YytkNMaVwPJ8ylKAAA-1; Tue,
 26 Mar 2024 03:34:36 -0400
X-MC-Unique: c7K1YytkNMaVwPJ8ylKAAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D438638157AC;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B40AD1074E;
 Tue, 26 Mar 2024 07:34:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7B0F21E5D37; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/20] qapi: document leftover members in qapi/run-state.json
Date: Tue, 26 Mar 2024 08:34:17 +0100
Message-ID: <20240326073420.738016-18-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240325104502.1358693-1-pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Capitalize "ID", update qapi/pragma.json]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/pragma.json    |  4 +---
 qapi/run-state.json | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/qapi/pragma.json b/qapi/pragma.json
index 92715d22b3..1a302981c1 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -57,7 +57,6 @@
         'DummyForceArrays',
         'DummyVirtioForceArrays',
         'GrabToggleKeys',
-        'GuestPanicInformationHyperV',
         'HotKeyMod',
         'ImageInfoSpecificKind',
         'InputAxis',
@@ -93,8 +92,7 @@
         'query-cpu-model-expansion',
         'query-rocker',
         'query-rocker-ports',
-        'query-stats-schemas',
-        'watchdog-set-action' ],
+        'query-stats-schemas' ],
     # Externally visible types whose member names may use uppercase
     'member-name-exceptions': [     # visible in:
         'ACPISlotType',             # query-acpi-ospm-status
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 5f07444b84..f8773f23b2 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -376,9 +376,17 @@
 ##
 # @watchdog-set-action:
 #
-# Set watchdog action
+# Set watchdog action.
+#
+# @action: @WatchdogAction action taken when watchdog timer expires.
 #
 # Since: 2.11
+#
+# Example:
+#
+#     -> { "execute": "watchdog-set-action",
+#          "arguments": { "action": "inject-nmi" } }
+#     <- { "return": {} }
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
 
@@ -504,6 +512,22 @@
 #
 # Hyper-V specific guest panic information (HV crash MSRs)
 #
+# @arg1: for Windows, STOP code for the guest crash.  For Linux,
+#        an error code.
+#
+# @arg2: for Windows, first argument of the STOP.  For Linux, the
+#        guest OS ID, which has the kernel version in bits 16-47
+#        and 0x8100 in bits 48-63.
+#
+# @arg3: for Windows, second argument of the STOP.  For Linux, the
+#        program counter of the guest.
+#
+# @arg4: for Windows, third argument of the STOP.  For Linux, the
+#        RAX register (x86) or the stack pointer (aarch64) of the guest.
+#
+# @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
+#        stack pointer of the guest.
+#
 # Since: 2.9
 ##
 {'struct': 'GuestPanicInformationHyperV',
-- 
2.44.0



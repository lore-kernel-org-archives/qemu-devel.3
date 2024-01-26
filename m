Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676ABC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 06:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTFhA-0005Kv-To; Fri, 26 Jan 2024 01:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgz-0005Cd-Cq
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTFgu-0001ld-K7
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706250471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGX6mTbZvV1IOJ+Vc7ozbEGlpGGzvO1hyUMZSRhdwF8=;
 b=jOurAZ0PpdD9yGU7naI6mz/eHNpVItB6pDGvsiZXusQeOshSzUTv4XHos/fLfnu2No2M88
 N5M359yNn3qVf76qLB1q9vNue52UhTq1ViQK0fD3pbmHbXxp58U+Z7amYQnuF6a9DeK5it
 rD2JuZb54ohkHJ7wkjnJb+oZOidsdkw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-d0bvaY9kNY6kzpWRru7c0w-1; Fri, 26 Jan 2024 01:27:47 -0500
X-MC-Unique: d0bvaY9kNY6kzpWRru7c0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 554D6185A783;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 181282166B32;
 Fri, 26 Jan 2024 06:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C85EB21E64D2; Fri, 26 Jan 2024 07:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 7/8] qapi: Indent tagged doc comment sections properly
Date: Fri, 26 Jan 2024 07:27:43 +0100
Message-ID: <20240126062744.265588-8-armbru@redhat.com>
In-Reply-To: <20240126062744.265588-1-armbru@redhat.com>
References: <20240126062744.265588-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

docs/devel/qapi-code-gen demands that the "second and subsequent lines
of sections other than "Example"/"Examples" should be indented".
Commit a937b6aa739 (qapi: Reformat doc comments to conform to current
conventions) missed a few instances, and a few more have crept in
since.  Indent them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240120095327.666239-7-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/char.json        |  4 ++--
 qapi/machine.json     | 24 ++++++++++++------------
 qapi/misc-target.json |  2 +-
 qapi/misc.json        | 10 +++++-----
 qapi/yank.json        |  4 ++--
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index c1bab7b855..6c6ad3b10c 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -391,8 +391,8 @@
 # @rows: console height, in chars
 #
 # Note: the options are only effective when the VNC or SDL graphical
-# display backend is active. They are ignored with the GTK, Spice, VNC
-# and D-Bus display backends.
+#     display backend is active.  They are ignored with the GTK,
+#     Spice, VNC and D-Bus display backends.
 #
 # Since: 1.5
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index b6d634b30d..aa99fa333f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1059,10 +1059,10 @@
 #     From it we have: balloon_size = vm_ram_size - @value
 #
 # Returns:
-# - Nothing on success
-# - If the balloon driver is enabled but not functional because the
-#   KVM kernel module cannot support it, KVMMissingCap
-# - If no balloon device is present, DeviceNotActive
+#     - Nothing on success
+#     - If the balloon driver is enabled but not functional because
+#       the KVM kernel module cannot support it, KVMMissingCap
+#     - If no balloon device is present, DeviceNotActive
 #
 # Notes: This command just issues a request to the guest.  When it
 #     returns, the balloon size may not have changed.  A guest can
@@ -1097,10 +1097,10 @@
 # Return information about the balloon device.
 #
 # Returns:
-# - @BalloonInfo on success
-# - If the balloon driver is enabled but not functional because the
-#   KVM kernel module cannot support it, KVMMissingCap
-# - If no balloon device is present, DeviceNotActive
+#     - @BalloonInfo on success
+#     - If the balloon driver is enabled but not functional because
+#       the KVM kernel module cannot support it, KVMMissingCap
+#     - If no balloon device is present, DeviceNotActive
 #
 # Since: 0.14
 #
@@ -1161,10 +1161,10 @@
 # message from the guest.
 #
 # Returns:
-# - @HvBalloonInfo on success
-# - If no hv-balloon device is present, guest memory status reporting
-#   is not enabled or no guest memory status report received yet,
-#   GenericError
+#     - @HvBalloonInfo on success
+#     - If no hv-balloon device is present, guest memory status
+#       reporting is not enabled or no guest memory status report
+#       received yet, GenericError
 #
 # Since: 8.2
 #
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 88291453ba..9195e7d26b 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -475,7 +475,7 @@
 # @port: The port number
 #
 # Returns:
-# - Nothing on success.
+#     - Nothing on success.
 #
 # Since: 8.0
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 3622d98d01..2ca8c39874 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -344,9 +344,9 @@
 # @opaque: A free-form string that can be used to describe the fd.
 #
 # Returns:
-# - @AddfdInfo on success
-# - If file descriptor was not received, GenericError
-# - If @fdset-id is a negative value, GenericError
+#     - @AddfdInfo on success
+#     - If file descriptor was not received, GenericError
+#     - If @fdset-id is a negative value, GenericError
 #
 # Notes: The list of fd sets is shared by all monitor connections.
 #
@@ -374,8 +374,8 @@
 # @fd: The file descriptor that is to be removed.
 #
 # Returns:
-# - Nothing on success
-# - If @fdset-id or @fd is not found, GenericError
+#     - Nothing on success
+#     - If @fdset-id or @fd is not found, GenericError
 #
 # Since: 1.2
 #
diff --git a/qapi/yank.json b/qapi/yank.json
index 87ec7cab96..60eda20816 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -77,8 +77,8 @@
 # Takes a list of @YankInstance as argument.
 #
 # Returns:
-# - Nothing on success
-# - @DeviceNotFound error, if any of the YankInstances doesn't exist
+#     - Nothing on success
+#     - @DeviceNotFound error, if any of the YankInstances doesn't exist
 #
 # Example:
 #
-- 
2.43.0



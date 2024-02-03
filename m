Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FBCC4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWBTq-0002q0-3P; Sat, 03 Feb 2024 03:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTn-0002pA-Ph
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWBTh-0007IS-Ve
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706949261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lv6MTAcKFZXeEXBIYL8uA5aUyLaqbm5tQiv7jWTn+I=;
 b=jFM8vWcn++QRzjUecycIITEqD72FvF9U8Qhz8zwGfyLRx77CPqU6/9oRR3VV3EwKE5NcrO
 Q2iY4d2CUmbc8JahVyw4uW23QVv4tEASy/jZpZkQroTseTKWeNJeqdOy2eBv/E9MTeOarH
 GM4LbDV72e2RSqXWHEGohZFkc4z1wbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-zHU1Hy4IOzGe4OWQgRSQcw-1; Sat, 03 Feb 2024 03:34:18 -0500
X-MC-Unique: zHU1Hy4IOzGe4OWQgRSQcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EB2D1013661;
 Sat,  3 Feb 2024 08:34:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D8BF1C060B1;
 Sat,  3 Feb 2024 08:34:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 061A521E669C; Sat,  3 Feb 2024 09:34:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 5/5] qga/qapi-schema: Move command description right after
 command name
Date: Sat,  3 Feb 2024 09:34:15 +0100
Message-ID: <20240203083415.2937003-6-armbru@redhat.com>
In-Reply-To: <20240203083415.2937003-1-armbru@redhat.com>
References: <20240203083415.2937003-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Documentation of commands guest-ssh-get-authorized-keys,
guest-ssh-add-authorized-keys, and guest-ssh-remove-authorized-keys
describes the command's purpose after its arguments.  Everywhere else,
we do it the other way round.  Move it for consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240129115008.674248-6-armbru@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/qapi-schema.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 876e2a8ea8..50b0a558c7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1565,11 +1565,11 @@
 ##
 # @guest-ssh-get-authorized-keys:
 #
-# @username: the user account to add the authorized keys
-#
 # Return the public keys from user .ssh/authorized_keys on Unix
 # systems (not implemented for other systems).
 #
+# @username: the user account to add the authorized keys
+#
 # Returns: @GuestAuthorizedKeys
 #
 # Since: 5.2
@@ -1582,6 +1582,9 @@
 ##
 # @guest-ssh-add-authorized-keys:
 #
+# Append public keys to user .ssh/authorized_keys on Unix systems (not
+# implemented for other systems).
+#
 # @username: the user account to add the authorized keys
 #
 # @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys
@@ -1589,9 +1592,6 @@
 #
 # @reset: ignore the existing content, set it with the given keys only
 #
-# Append public keys to user .ssh/authorized_keys on Unix systems (not
-# implemented for other systems).
-#
 # Returns: Nothing on success.
 #
 # Since: 5.2
@@ -1603,15 +1603,15 @@
 ##
 # @guest-ssh-remove-authorized-keys:
 #
+# Remove public keys from the user .ssh/authorized_keys on Unix
+# systems (not implemented for other systems). It's not an error if
+# the key is already missing.
+#
 # @username: the user account to remove the authorized keys
 #
 # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
 #     format)
 #
-# Remove public keys from the user .ssh/authorized_keys on Unix
-# systems (not implemented for other systems). It's not an error if
-# the key is already missing.
-#
 # Returns: Nothing on success.
 #
 # Since: 5.2
-- 
2.43.0



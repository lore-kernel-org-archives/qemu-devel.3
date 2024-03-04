Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3176FC54E4A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1ss-0005bt-DG; Mon, 04 Mar 2024 01:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sW-0005Xv-61
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-00008D-EE
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOjnZidORcDEQ/A5DM1wItaLmYEEvB17BaywLPOi69Y=;
 b=H8wJ+FIAsKwx8OMlXM9SG7NTd/M6aYGrWkQBJ8vY8+lTAmF9XiiIYmNnvzI7Qv62phWgRn
 u8fISgQjoRtvnmumonQtuaQJqETFBZ7ujOWaaHCeQfg45BMffTRUzSgc5H8ZtUPwFgB1sX
 wF1yOb1R/0cyFBJIEBi6dMwQxCHnI9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-aP4l2THTNtis9Xo6f4YYdQ-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: aP4l2THTNtis9Xo6f4YYdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32B5F85A589;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F2521C060B1;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 844F621E68BD; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 09/18] qga/qapi-schema: Delete useless "Returns" sections
Date: Mon,  4 Mar 2024 07:32:27 +0100
Message-ID: <20240304063236.213955-10-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-10-armbru@redhat.com>
---
 qga/qapi-schema.json | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c5f2ac8f59..636c2c5697 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -153,8 +153,6 @@
 # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
 #     UTC.
 #
-# Returns: Nothing on success.
-#
 # Since: 1.5
 ##
 { 'command': 'guest-set-time',
@@ -245,8 +243,6 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
-# Returns: Nothing on success.
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-close',
@@ -399,8 +395,6 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
-# Returns: Nothing on success.
-#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-flush',
@@ -1077,8 +1071,6 @@
 # transmission, even if already crypt()d, to ensure it is 8-bit safe
 # when passed as JSON.
 #
-# Returns: Nothing on success.
-#
 # Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
@@ -1602,8 +1594,6 @@
 #
 # @reset: ignore the existing content, set it with the given keys only
 #
-# Returns: Nothing on success.
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
@@ -1622,8 +1612,6 @@
 # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
 #     format)
 #
-# Returns: Nothing on success.
-#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-remove-authorized-keys',
-- 
2.44.0



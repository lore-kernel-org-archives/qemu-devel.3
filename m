Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65454C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1t6-0005fy-QG; Mon, 04 Mar 2024 01:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sV-0005XT-Fg
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-000081-8w
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/FXbU9k4Xbe6CQGPTK1P/C/8UWcPJ+aHRUxwKj2KcM=;
 b=V/tfhmOgg+IkXDQuGRKW0lXn1ObXt8GDhy0DdqrZmH7TbwSTiAD6tA5STi36653gk06YOY
 S7+IL6YudpvNaajudqxlH6E0Rh/0VhlIOuSYEwecBMf2Yt4pMHhzh3MTs4lUc3kzxFQG5d
 D5Rhl7CN3OVMfC318iol53lh2+vJXcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-DgFhCSR1PqOKoTJjkUnYdg-1; Mon, 04 Mar 2024 01:32:39 -0500
X-MC-Unique: DgFhCSR1PqOKoTJjkUnYdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3307884AE41;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F1402022AAC;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86E1B21E6828; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 10/18] qga/qapi-schema: Clean up "Returns" sections
Date: Mon,  4 Mar 2024 07:32:28 +0100
Message-ID: <20240304063236.213955-11-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

Drop "on success" where it is redundant with "Returns:".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-11-armbru@redhat.com>
---
 qga/qapi-schema.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 636c2c5697..326d324901 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -228,7 +228,7 @@
 #
 # @mode: open mode, as per fopen(), "r" is the default.
 #
-# Returns: Guest file handle on success.
+# Returns: Guest file handle
 #
 # Since: 0.15.0
 ##
@@ -277,7 +277,7 @@
 # @count: maximum number of bytes to read (default is 4KB, maximum is
 #     48MB)
 #
-# Returns: @GuestFileRead on success.
+# Returns: @GuestFileRead
 #
 # Since: 0.15.0
 ##
@@ -312,7 +312,7 @@
 # @count: bytes to write (actual bytes, after base64-decode), default
 #     is all content in buf-b64 buffer after base64 decoding
 #
-# Returns: @GuestFileWrite on success.
+# Returns: @GuestFileWrite
 #
 # Since: 0.15.0
 ##
@@ -379,7 +379,7 @@
 #
 # @whence: Symbolic or numeric code for interpreting offset
 #
-# Returns: @GuestFileSeek on success.
+# Returns: @GuestFileSeek
 #
 # Since: 0.15.0
 ##
@@ -723,7 +723,7 @@
 #
 # Get list of guest IP addresses, MAC addresses and netmasks.
 #
-# Returns: List of GuestNetworkInterface on success.
+# Returns: List of GuestNetworkInterface
 #
 # Since: 1.1
 ##
@@ -1247,7 +1247,7 @@
 #
 # @pid: pid returned from guest-exec
 #
-# Returns: GuestExecStatus on success.
+# Returns: GuestExecStatus
 #
 # Since: 2.5
 ##
@@ -1315,7 +1315,7 @@
 # @capture-output: bool flag to enable capture of stdout/stderr of
 #     running process.  defaults to false.
 #
-# Returns: PID on success.
+# Returns: PID
 #
 # Since: 2.5
 ##
@@ -1344,7 +1344,7 @@
 # or even present in DNS or some other name service at all.  It need
 # not even be unique on your local network or site, but usually it is.
 #
-# Returns: the host name of the machine on success
+# Returns: the host name of the machine
 #
 # Since: 2.10
 ##
-- 
2.44.0



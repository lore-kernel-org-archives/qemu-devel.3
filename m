Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B8C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKoZ-0008Ap-Qe; Mon, 14 Jul 2025 11:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUr-0000RY-4w
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUX-0003cd-Hg
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BoFyE5dL2mNyl4j/PQnX2SGzfHS9btqDC8HtT6vSAc=;
 b=eCJTPwetL+gIP8fMnB5PpSJyUfGXi7Z896hg5T8aq5MzKZqaB3HlfUkrNPn1vQW0zNZBU6
 8HUQJaqYJhw8w4fCgg5MqPB79pJonSs4J3m7U7j76YfqNNNImnRZMRiIJ9pSbqwwaaBxsW
 ya4z79ylZcGCzu/IX4K5oU/jbijHHcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-kl4wRxLlNPuGLs8mOGn8QQ-1; Mon,
 14 Jul 2025 09:45:09 -0400
X-MC-Unique: kl4wRxLlNPuGLs8mOGn8QQ-1
X-Mimecast-MFC-AGG-ID: kl4wRxLlNPuGLs8mOGn8QQ_1752500709
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B4919560BC
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88CB030001A1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34B8621E6147; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 29/32] qapi: add cross-references to misc modules
Date: Mon, 14 Jul 2025 15:44:55 +0200
Message-ID: <20250714134458.2991097-30-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

These modules don't have specific maintainers, so they're lumped in
together here as miscellaneous.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250711054005.60969-19-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/control.json    |  2 +-
 qapi/ebpf.json       |  2 +-
 qapi/introspect.json | 24 ++++++++++++------------
 qapi/misc-arm.json   |  2 +-
 qapi/misc-i386.json  |  2 +-
 qapi/misc.json       | 12 ++++++------
 qapi/stats.json      |  8 ++++----
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 931a860b30..9a5302193d 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -13,7 +13,7 @@
 #
 # Enable QMP capabilities.
 #
-# @enable: An optional list of QMPCapability values to enable.  The
+# @enable: An optional list of `QMPCapability` values to enable.  The
 #     client must not enable any capability that is not mentioned in
 #     the QMP greeting message.  If the field is not provided, it
 #     means no QMP capabilities will be enabled.  (since 2.12)
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index d45054e666..f0257955fa 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -34,7 +34,7 @@
 ##
 # @EbpfProgramID:
 #
-# The eBPF programs that can be gotten with request-ebpf.
+# The eBPF programs that can be gotten with `request-ebpf`.
 #
 # @rss: Receive side scaling, technology that allows steering traffic
 #     between queues by calculation hash.  Users may set up
diff --git a/qapi/introspect.json b/qapi/introspect.json
index be8511b067..53100714a8 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -18,11 +18,11 @@
 ##
 # @query-qmp-schema:
 #
-# Command query-qmp-schema exposes the QMP wire ABI as an array of
-# SchemaInfo.  This lets QMP clients figure out what commands and
+# Command `query-qmp-schema` exposes the QMP wire ABI as an array of
+# `SchemaInfo`.  This lets QMP clients figure out what commands and
 # events are available in this QEMU, and their parameters and results.
 #
-# However, the SchemaInfo can't reflect all the rules and restrictions
+# However, the `SchemaInfo` can't reflect all the rules and restrictions
 # that apply to QMP.  It's interface introspection (figuring out
 # what's there), not interface specification.  The specification is in
 # the QAPI schema.
@@ -56,7 +56,7 @@
 ##
 # @SchemaMetaType:
 #
-# This is a @SchemaInfo's meta type, i.e. the kind of entity it
+# This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
 # describes.
 #
 # @builtin: a predefined type such as 'int' or 'bool'.
@@ -82,7 +82,7 @@
 ##
 # @SchemaInfo:
 #
-# @name: the entity's name, inherited from @base.  The SchemaInfo is
+# @name: the entity's name, inherited from @base.  The `SchemaInfo` is
 #     always referenced by this name.  Commands and events have the
 #     name defined in the QAPI schema.  Unlike command and event
 #     names, type names are not part of the wire ABI.  Consequently,
@@ -113,7 +113,7 @@
 ##
 # @SchemaInfoBuiltin:
 #
-# Additional SchemaInfo members for meta-type 'builtin'.
+# Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -154,7 +154,7 @@
 ##
 # @SchemaInfoEnum:
 #
-# Additional SchemaInfo members for meta-type 'enum'.
+# Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -194,7 +194,7 @@
 ##
 # @SchemaInfoArray:
 #
-# Additional SchemaInfo members for meta-type 'array'.
+# Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -208,7 +208,7 @@
 ##
 # @SchemaInfoObject:
 #
-# Additional SchemaInfo members for meta-type 'object'.
+# Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -273,7 +273,7 @@
 ##
 # @SchemaInfoAlternate:
 #
-# Additional SchemaInfo members for meta-type 'alternate'.
+# Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -301,7 +301,7 @@
 ##
 # @SchemaInfoCommand:
 #
-# Additional SchemaInfo members for meta-type 'command'.
+# Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -323,7 +323,7 @@
 ##
 # @SchemaInfoEvent:
 #
-# Additional SchemaInfo members for meta-type 'event'.
+# Additional `SchemaInfo` members for meta-type 'event'.
 #
 # @arg-type: the name of the object type that provides the event's
 #     parameters.
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index f9dd743b52..f921d740f1 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -30,7 +30,7 @@
 ##
 # @query-gic-capabilities:
 #
-# It will return a list of GICCapability objects that describe its
+# It will return a list of `GICCapability` objects that describe its
 # capability bits.
 #
 # On non-ARM targets this command will report an error as the GIC
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 282bd3627b..c8c91a241c 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -26,7 +26,7 @@
 ##
 # @SevState:
 #
-# An enumeration of SEV state information used during @query-sev.
+# An enumeration of SEV state information used during `query-sev`.
 #
 # @uninit: The guest is uninitialized.
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 7dbc29dbd6..28c641fe2f 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -23,7 +23,7 @@
 #     "@dbus-display" or the name of a character device (e.g. from
 #     -chardev id=XXXX)
 #
-# @fdname: file descriptor name previously passed via 'getfd' command
+# @fdname: file descriptor name previously passed via `getfd` command
 #
 # @skipauth: whether to skip authentication.  Only applies to "vnc"
 #     and "spice" protocols
@@ -228,7 +228,7 @@
 #    Known limitations:
 #
 #    * This command is stateless, this means that commands that depend
-#      on state information (such as getfd) might not work.
+#      on state information (such as `getfd`) might not work.
 #
 #    * Commands that prompt the user for data don't currently work.
 #
@@ -255,7 +255,7 @@
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
-#    The 'closefd' command can be used to explicitly close the file
+#    The `closefd` command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
 # .. qmp-example::
@@ -282,7 +282,7 @@
 # .. note:: If @fdname already exists, the file descriptor assigned to
 #    it will be closed and replaced by the received file descriptor.
 #
-#    The 'closefd' command can be used to explicitly close the file
+#    The `closefd` command can be used to explicitly close the file
 #    descriptor when it is no longer needed.
 #
 # .. qmp-example::
@@ -475,7 +475,7 @@
 #
 # @name: parameter name
 #
-# @type: parameter @CommandLineParameterType
+# @type: parameter `CommandLineParameterType`
 #
 # @help: human readable text string, not suitable for parsing.
 #
@@ -497,7 +497,7 @@
 #
 # @option: option name
 #
-# @parameters: an array of @CommandLineParameterInfo
+# @parameters: an array of `CommandLineParameterInfo`
 #
 # Since: 1.5
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index b63a7369dd..151ac43c48 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -89,7 +89,7 @@
 # @StatsRequest:
 #
 # Indicates a set of statistics that should be returned by
-# query-stats.
+# `query-stats`.
 #
 # @provider: provider for which to return statistics.
 #
@@ -114,7 +114,7 @@
 ##
 # @StatsFilter:
 #
-# The arguments to the query-stats command; specifies a target for
+# The arguments to the `query-stats` command; specifies a target for
 # which to request statistics and optionally the required subset of
 # information for that target.
 #
@@ -185,7 +185,7 @@
 # Return runtime-collected statistics for objects such as the VM or
 # its vCPUs.
 #
-# The arguments are a StatsFilter and specify the provider and objects
+# The arguments are a `StatsFilter` and specify the provider and objects
 # to return statistics about.
 #
 # Returns: a list of statistics, one for each provider and object
@@ -205,7 +205,7 @@
 #
 # @name: name of the statistic; each element of the schema is uniquely
 #     identified by a target, a provider (both available in
-#     @StatsSchema) and the name.
+#     `StatsSchema`) and the name.
 #
 # @type: kind of statistic.
 #
-- 
2.49.0



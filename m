Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE59C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwM-0005rk-Oa; Fri, 04 Apr 2025 08:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwJ-0005qL-Kz
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwG-0005qE-GF
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BaBm7vzXaXVZ/BBtmGC2zL7uZD73yk8BYfS9G6HbH8=;
 b=L2kL8tT2PSVDpleNxtYrxQfJXxI3QkAhF75NPRUoOZ5Mqa4CfGHunwuCgJAW5vTclQD9uD
 M1MguJ03gL0nv8+5fKH/r1KvxhHQ0Bh/ZntIe3OrEr5evAax35ogoSdzynVEh0QvCCz+8I
 NPFgIJtKcmrR++jtFLcOE4eLnDyUEiA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-NyanbwtJPIi3YyjEOpz8yg-1; Fri,
 04 Apr 2025 08:14:20 -0400
X-MC-Unique: NyanbwtJPIi3YyjEOpz8yg-1
X-Mimecast-MFC-AGG-ID: NyanbwtJPIi3YyjEOpz8yg_1743768859
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD68518004A9; Fri,  4 Apr 2025 12:14:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A6161828AA4; Fri,  4 Apr 2025 12:14:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64D8221E66E3; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 01/11] docs/devel/qapi-code-gen: Tidy up whitespace
Date: Fri,  4 Apr 2025 14:14:03 +0200
Message-ID: <20250404121413.1743790-2-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Consistently use two spaces to separate sentences.

Put "::" on a line of its own when it's preceded by whitespace.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index f9cfe8721f..ad517349fc 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -763,8 +763,8 @@ Names beginning with ``x-`` used to signify "experimental".  This
 convention has been replaced by special feature "unstable".
 
 Pragmas ``command-name-exceptions`` and ``member-name-exceptions`` let
-you violate naming rules.  Use for new code is strongly discouraged. See
-`Pragma directives`_ for details.
+you violate naming rules.  Use for new code is strongly discouraged.
+See `Pragma directives`_ for details.
 
 
 Downstream extensions
@@ -1013,7 +1013,7 @@ like this::
 document the success and the error response, respectively.
 
 "Errors" sections should be formatted as an rST list, each entry
-detailing a relevant error condition. For example::
+detailing a relevant error condition.  For example::
 
  # Errors:
  #     - If @device does not exist, DeviceNotFound
@@ -1026,13 +1026,13 @@ definition.
 QMP).  In other sections, the text is formatted, and rST markup can be
 used.
 
-QMP Examples can be added by using the ``.. qmp-example::``
-directive. In its simplest form, this can be used to contain a single
-QMP code block which accepts standard JSON syntax with additional server
+QMP Examples can be added by using the ``.. qmp-example::`` directive.
+In its simplest form, this can be used to contain a single QMP code
+block which accepts standard JSON syntax with additional server
 directionality indicators (``->`` and ``<-``), and elisions (``...``).
 
 Optionally, a plaintext title may be provided by using the ``:title:``
-directive option. If the title is omitted, the example title will
+directive option.  If the title is omitted, the example title will
 default to "Example:".
 
 A simple QMP example::
@@ -1043,10 +1043,10 @@ A simple QMP example::
   #    -> { "execute": "query-block" }
   #    <- { ... }
 
-More complex or multi-step examples where exposition is needed before or
-between QMP code blocks can be created by using the ``:annotated:``
-directive option. When using this option, nested QMP code blocks must be
-entered explicitly with rST's ``::`` syntax.
+More complex or multi-step examples where exposition is needed before
+or between QMP code blocks can be created by using the ``:annotated:``
+directive option.  When using this option, nested QMP code blocks must
+be entered explicitly with rST's ``::`` syntax.
 
 Highlighting in non-QMP languages can be accomplished by using the
 ``.. code-block:: lang`` directive, and non-highlighted text can be
@@ -1466,7 +1466,9 @@ As an example, we'll use the following schema, which describes a
 single complex user-defined type, along with command which takes a
 list of that type as a parameter, and returns a single element of that
 type.  The user is responsible for writing the implementation of
-qmp_my_command(); everything else is produced by the generator. ::
+qmp_my_command(); everything else is produced by the generator.
+
+::
 
     $ cat example-schema.json
     { 'struct': 'UserDefOne',
-- 
2.48.1



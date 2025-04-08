Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DECC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23Gh-0007h2-Gr; Tue, 08 Apr 2025 03:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fr-0007Du-TY
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fl-0001YF-G2
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Bh1beKhXr+3bpFHooOG0Kd1sLdPBHXQ9gI3gm6aPSg=;
 b=BR8+Olmlv6zERknrt4a3E99hyoTLsrNbGBlYH2CM0aQPHIeQ2s5tofsVeYjdV4hiRDnzTs
 uwifPRJJUqMiXZwHen3HvbqurcmAguDPdvcMqGiBynSbaY4AonzvKWwXm6WnNvjhcKo5la
 xUZgMSJFrFCDNyfcjEhp26t1posr2aE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446--V1S4aitOa6cAXai7mTnWg-1; Tue,
 08 Apr 2025 03:20:05 -0400
X-MC-Unique: -V1S4aitOa6cAXai7mTnWg-1
X-Mimecast-MFC-AGG-ID: -V1S4aitOa6cAXai7mTnWg_1744096804
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 949DD19560A2
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 521381955BC0
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E68B821E66C7; Tue, 08 Apr 2025 09:20:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 01/11] docs/devel/qapi-code-gen: Tidy up whitespace
Date: Tue,  8 Apr 2025 09:19:51 +0200
Message-ID: <20250408072001.2518323-2-armbru@redhat.com>
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
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

Consistently use two spaces to separate sentences.

Put "::" on a line of its own when it's preceded by whitespace.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250404121413.1743790-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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



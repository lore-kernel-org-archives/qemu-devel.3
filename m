Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A413C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1R-0007WZ-2I; Fri, 19 Apr 2024 00:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1E-0007T3-Ss
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1D-0004Cq-AX
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOsxkzvTq7IGxliGWm/dx2GKasAtz6w02bAJhwB0Zoc=;
 b=KJzcAJGOtipIy7wQCLVPqYHN3V8Ft0kaW2uJHfHIEojFyZhe1WLhHa5O7k+4GAX/0/KU+a
 MoqqcfJ2fF9h7qYKZ4Ct4tGD6BMOYZq/2mHLNgfw5EmOK47XVLx4uPcXn7RTbU4S7seiMh
 sz8v+Di0t9cJ2wKYxhkDg3HFQR2gN/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-wAVLQq9LMBqcTy1WmDHpcQ-1; Fri, 19 Apr 2024 00:38:30 -0400
X-MC-Unique: wAVLQq9LMBqcTy1WmDHpcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F12C8948A1;
 Fri, 19 Apr 2024 04:38:30 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDFC840829C3;
 Fri, 19 Apr 2024 04:38:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 12/27] docs/qapi-domain: add "Returns:" field lists
Date: Fri, 19 Apr 2024 00:38:00 -0400
Message-ID: <20240419043820.178731-13-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Add "Returns:" field list syntax to QAPI Commands.

Like "Arguments:" and "Errors:", the type name isn't currently processed
for cross-referencing, but this will be addressed in a forthcoming
commit.

This patch adds "errors" as a GroupedField, which means that multiple
return values can be annotated - this is only done because Sphinx does
not seemingly (Maybe I missed it?) support mandatory type arguments to
Ungrouped fields. Because we want to cross-reference this type
information later, we want to make the type argument mandatory. As a
result, you can technically add multiple :return: fields, though I'm not
aware of any circumstance in which you'd need or want
to. Recommendation: "Don't do that, then."

Since this field describes an action/event instead of describing a list
of nouns (arguments, features, errors), I added both the imperative and
indicative forms (:return: and :returns:) to allow doc writers to use
whichever mood "feels right" in the source document. The rendered output
will always use the "Returns:" label, however.

I'm sure you'll let me know how you feel about that. O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 2 ++
 docs/sphinx/qapi-domain.py | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 004d02e0437..39fe4dd2dae 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -102,6 +102,8 @@ Explicit cross-referencing syntax for QAPI modules is available with
       isn't real.
    :error GenericError: If the system decides it doesn't like the
       argument values. It's very temperamental.
+   :return SomeTypeName: An esoteric collection of mystical nonsense to
+      both confound and delight.
 
    Field lists can appear anywhere in the directive block, but any field
    list entries in the same list block that are recognized as special
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 1f0b168fa2c..5d44dba6cd3 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -279,6 +279,12 @@ class QAPICommand(QAPIObject):
                 names=("error",),
                 can_collapse=True,
             ),
+            GroupedField(
+                "returnvalue",
+                label=_("Returns"),
+                names=("return", "returns"),
+                can_collapse=True,
+            ),
         ]
     )
 
-- 
2.44.0



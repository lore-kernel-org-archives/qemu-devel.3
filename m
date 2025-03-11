Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxr8-0003Wn-Vs; Tue, 11 Mar 2025 07:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqW-0003Cz-80
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq7-0006VQ-1C
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdvquLHI6GGmUASUDmeqDMm0k9Ul8PjFY+goxm/FAfM=;
 b=V8QEclNG+4tbdu1BZ+VAuElbDIwzJJ9vkjqdxpgWS4PYBd309hLbamMiCpSwU23kZDCMG3
 jaV0GTGHsLd1Y1RwTT1Ya8E8ibdC2/3zIYU5f66d14/VadLn+/aVcih1OaYKALsAFHwriV
 1YqwgUjvo+uFpdzLeTcU9eYdA/YJbj8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-3qWP5D5NOxCUrHPdUBpopg-1; Tue,
 11 Mar 2025 07:31:54 -0400
X-MC-Unique: 3qWP5D5NOxCUrHPdUBpopg-1
X-Mimecast-MFC-AGG-ID: 3qWP5D5NOxCUrHPdUBpopg_1741692713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEAFF19560B7
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 565B91955BCB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F015121E64FB; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 16/61] docs/qapi-domain: add "Return:" field lists
Date: Tue, 11 Mar 2025 12:30:52 +0100
Message-ID: <20250311113137.1277125-17-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Add "Return:" field list syntax to QAPI Commands.

Like "Arguments:" and "Errors:", the type name isn't currently processed
for cross-referencing, but this will be addressed in a forthcoming
commit.

The syntax of the new field is:

:return TypeName: description
   description cont'd

This patch adds "Return" as a GroupedField, which means that multiple
return values can be annotated - this is only done because Sphinx does
not support mandatory type arguments to Ungrouped fields. Because we
want to cross-reference this type information later, we want to make the
type argument mandatory. As a result, you can technically add multiple
:return: fields, though I'm not aware of any circumstance in which you'd
need or want to. Recommendation: "Don't do that, then." The forthcoming
QAPIDoc transmogrifier does not, in fact, ever "do that".

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-19-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 7535009078..45e69689d1 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -301,6 +301,13 @@ class QAPICommand(QAPIObject):
                 names=("error", "errors"),
                 has_arg=False,
             ),
+            # :return TypeName: descr
+            GroupedField(
+                "returnvalue",
+                label=_("Return"),
+                names=("return",),
+                can_collapse=True,
+            ),
         ]
     )
 
-- 
2.48.1



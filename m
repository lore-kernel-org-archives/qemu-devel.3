Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4FC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfjA-0005vp-Cy; Tue, 04 Mar 2025 22:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfj7-0005q7-0W
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfj5-00068C-8X
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLEE6Amwl+9tfhKr+WfSmS1kiZKCPAngGeUn8RMXjNk=;
 b=VkBYaci2PlA2b5DISq8sdTp472wUERXO+q34jTcebPOO4Jt7mo7D7Il0PTB5BOaegocSE9
 CUKzPliccJBjEZIlFqXSqM2CzzcJ+MHBMxaDnU0PSUdBDkRXS5WtD7TBCQBU8wtvrV7IcZ
 hwnvhb0AQwlb4myyUAutUwjN/1g1Oho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-386jWLClNfaDo6EaPENiow-1; Tue,
 04 Mar 2025 22:47:15 -0500
X-MC-Unique: 386jWLClNfaDo6EaPENiow-1
X-Mimecast-MFC-AGG-ID: 386jWLClNfaDo6EaPENiow_1741146434
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EE7C18001C8; Wed,  5 Mar 2025 03:47:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FF991956095; Wed,  5 Mar 2025 03:47:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 16/57] docs/qapi-domain: add "Returns:" field lists
Date: Tue,  4 Mar 2025 22:45:25 -0500
Message-ID: <20250305034610.960147-17-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 docs/sphinx/qapi_domain.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index d60cccb8e95..7531bdfbba7 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -292,6 +292,13 @@ class QAPICommand(QAPIObject):
                 names=("error", "errors"),
                 has_arg=False,
             ),
+            # :returns TypeName: descr
+            GroupedField(
+                "returnvalue",
+                label=_("Returns"),
+                names=("return", "returns"),
+                can_collapse=True,
+            ),
         ]
     )
 
-- 
2.48.1



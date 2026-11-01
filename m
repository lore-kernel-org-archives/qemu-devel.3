Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F383B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpO03CT4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzj-0004tz-Lt; Sun, 01 Nov 2026 15:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbza-0004ph-90
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzY-000793-Fx
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vx23Yp8oncTViPbxf1fUSUUsIWLw2zMupHM3JckgRZc=;
 b=JpO03CT4UF64CB90LHDQDqpeq8RJvl52d/1UtcUdFobfRYCygg/6oEabhMsM0B2gzt6jIV
 J710Uz6SbQC+i4MtKQN0NoklEZ4kbyOnQNb7WeVN/kSFsiSYnPmywIqRtwPH2BZi8VYLNY
 ZJg7flV1xkvCYSlRWKuU6AnOGuuyFXg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-Ip1e5_EDPB2duAZDuKCdKw-1; Sun,
 01 Nov 2026 15:17:21 -0500
X-MC-Unique: Ip1e5_EDPB2duAZDuKCdKw-1
X-Mimecast-MFC-AGG-ID: Ip1e5_EDPB2duAZDuKCdKw_1793564240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3A2D19560B1
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60FE61800444
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DE3921E6882; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 03/56] qapi/introspect: Simplify masked name comment
 emission slighly
Date: Sun,  1 Nov 2026 21:16:24 +0100
Message-ID: <20261101201717.3911097-4-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Instead of emitting the comment for certain meta-types, simply emit it
when introspection name and name differ.

This additionally emits it for arrays, which is fine.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  1 +
 scripts/qapi/introspect.py   | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 9bd5a3af28..1e89cbbcd7 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -2073,6 +2073,7 @@ Example::
             { "name", QLIT_QSTR("30"), },
             {}
         })),
+        /* "[32]" = UserDefOneList */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "element-type", QLIT_QSTR("32"), },
             { "meta-type", QLIT_QSTR("array"), },
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 644461560c..49d1ed2897 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -253,12 +253,12 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
                          Will be omitted from the output if empty.
         """
         comment: Optional[str] = None
-        if mtype not in ('command', 'event', 'builtin', 'array'):
-            if not self._unmask:
-                # Output a comment to make it easy to map masked names
-                # back to the source when reading the generated output.
-                comment = f'"{self._name(name)}" = {name}'
-        obj['name'] = self._name(name)
+        introspection_name = self._name(name)
+        if introspection_name != name:
+            # Output a comment to make it easy to map masked names
+            # back to the source when reading the generated output.
+            comment = f'"{introspection_name}" = {name}'
+        obj['name'] = introspection_name
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEF7C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRJ-00084R-AQ; Wed, 13 Mar 2024 00:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQr-0007tD-An
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQo-0001qI-S7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hb6845/ptUoZFt78sZpGJBHgkujHu+y0IDSvNrviRUw=;
 b=elcgw3ZdKy41LfvK6la0sO1Q4/d8gED7Esug9iK/CsJWZeOrxuy6/vDxTLEvy99MphDoVa
 rz327/ULMh0q3xLy9p8lgC4/xmoXPfOXty72ttFhJ3KzN2nWzAOCARpOnReYv5S3PsmkvW
 6cqEnBaQKMxe3J0AQPGkrI3irUG75bA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-XI8_zFdYP22GWwf_lE8-JA-1; Wed, 13 Mar 2024 00:41:31 -0400
X-MC-Unique: XI8_zFdYP22GWwf_lE8-JA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 158688007A2;
 Wed, 13 Mar 2024 04:41:31 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84BD110E4B;
 Wed, 13 Mar 2024 04:41:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 06/23] qapi/schema: declare type for
 QAPISchemaObjectTypeMember.type
Date: Wed, 13 Mar 2024 00:41:10 -0400
Message-ID: <20240313044127.49089-7-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A QAPISchemaObjectTypeMember's type gets resolved only during .check().
We have QAPISchemaObjectTypeMember.__init__() initialize self.type =
None, and .check() assign the actual type.  Using .type before .check()
is wrong, and hopefully crashes due to the value being None.  Works.

However, it makes for awkward typing.  With .type:
Optional[QAPISchemaType], mypy is of course unable to see that it's None
before .check(), and a QAPISchemaType after.  To help it over the hump,
we'd have to assert self.type is not None before all the (valid) uses.
The assertion catches invalid uses, but only at run time; mypy can't
flag them.

Instead, declare .type in .__init__() as QAPISchemaType *without*
initializing it.  Using .type before .check() now certainly crashes,
which is an improvement.  Mypy still can't flag invalid uses, but that's
okay.

Addresses typing errors such as these:

qapi/schema.py:657: error: "None" has no attribute "alternate_qtype"  [attr-defined]
qapi/schema.py:662: error: "None" has no attribute "describe"  [attr-defined]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index da273c1649d..8440a7243d8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -786,7 +786,7 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
-        self.type = None
+        self.type: QAPISchemaType  # set during check()
         self.optional = optional
         self.features = features or []
 
-- 
2.44.0



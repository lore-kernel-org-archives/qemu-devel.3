Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8CC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt20O-0006MX-Rj; Fri, 14 Mar 2025 06:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20F-0006Ir-2L
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt20C-00023D-Nh
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741947051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAOwRfEQX1fMHZemJle1vc9sdr0bBc0WMo88DueGw5U=;
 b=GzkCqZ5ZXFEpO+Zsw4pRwxbA+JvyDRC125ClW9eP5ckY9XY6PQHAFmpys2fu9kN3UQxvlR
 AeRL513gI7Dape4oTksgJ+zk5ZGt5g4/6tU70eNoSX4a1DCz6m4XVrnyYvxxL5RszaM1iw
 fcuOt3VkcT35/XMHyNS34Wfbsopr7ro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-A8X5GfHJPxSoD16vSa5bqw-1; Fri,
 14 Mar 2025 06:10:49 -0400
X-MC-Unique: A8X5GfHJPxSoD16vSa5bqw-1
X-Mimecast-MFC-AGG-ID: A8X5GfHJPxSoD16vSa5bqw_1741947048
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7669180AF50
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367C21828A93
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:10:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3CC721E64C0; Fri, 14 Mar 2025 11:10:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 11/12] docs: disambiguate references in qapi-domain.rst
Date: Fri, 14 Mar 2025 11:10:37 +0100
Message-ID: <20250314101038.2408751-12-armbru@redhat.com>
In-Reply-To: <20250314101038.2408751-1-armbru@redhat.com>
References: <20250314101038.2408751-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Before we enable the QGA and QSD namespaces, we need to disambiguate
some of the references that would become ambiguous as a result!

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250313044312.189276-11-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-domain.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index 4705ba255e..a748529f51 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -385,13 +385,13 @@ Type names in references can be surrounded by brackets, like
 ``[typename]``, to indicate an array of that type.  The cross-reference
 will apply only to the type name between the brackets. For example;
 ``:qapi:type:`[Qcow2BitmapInfoFlags]``` renders to:
-:qapi:type:`[Qcow2BitmapInfoFlags]`
+:qapi:type:`[QMP:Qcow2BitmapInfoFlags]`
 
 To indicate an optional argument/member in a field list, the type name
 can be suffixed with ``?``. The cross-reference will be transformed to
 "type, Optional" with the link applying only to the type name. For
 example; ``:qapi:type:`BitmapSyncMode?``` renders to:
-:qapi:type:`BitmapSyncMode?`
+:qapi:type:`QMP:BitmapSyncMode?`
 
 
 Namespaces
@@ -405,11 +405,11 @@ type.
 * A namespace can be explicitly provided;
   e.g. ``:qapi:type:`QMP:BitmapSyncMode``
 * A module can be explicitly provided;
-  ``:qapi:type:`block-core.BitmapSyncMode``` will render to:
-  :qapi:type:`block-core.BitmapSyncMode`
+  ``:qapi:type:`QMP:block-core.BitmapSyncMode``` will render to:
+  :qapi:type:`QMP:block-core.BitmapSyncMode`
 * If you don't want to display the "fully qualified" name, it can be
-  prefixed with a tilde; ``:qapi:type:`~block-core.BitmapSyncMode```
-  will render to: :qapi:type:`~block-core.BitmapSyncMode`
+  prefixed with a tilde; ``:qapi:type:`~QMP:block-core.BitmapSyncMode```
+  will render to: :qapi:type:`~QMP:block-core.BitmapSyncMode`
 
 
 Target resolution
@@ -444,7 +444,7 @@ using the ``custom text <target>`` syntax.
 
 For example, ``:qapi:cmd:`Merge dirty bitmaps
 <block-dirty-bitmap-merge>``` will render as: :qapi:cmd:`Merge dirty
-bitmaps <block-dirty-bitmap-merge>`
+bitmaps <QMP:block-dirty-bitmap-merge>`
 
 
 Directives
-- 
2.48.1



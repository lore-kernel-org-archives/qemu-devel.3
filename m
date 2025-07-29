Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51BC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugk7v-0000sY-E2; Tue, 29 Jul 2025 09:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7l-0000Gw-1W
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7b-0001Pc-F6
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753794715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OBT6BpD6efTf4+xkY/OKKH5ypgA5IIwwnTUobH+SWI=;
 b=Q2nGarFk+j5ddKzig+u8nGontFhf2JqwXVAl+YOwZtX7w5TWHb+Ofrmd6Seh4LDw1q/Pnw
 Q3ii3q5yLyZHxhXPPTDGlOCRhwWt5lUnpDXnMFwOOxS0nYmPG4vcEuM2QhSwJ/mypG9919
 GLzWFSwGrBrmLVgsCF+dxdl9zq6ZQfc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-vgDA7N1rNf2nmD4LEj5WNQ-1; Tue,
 29 Jul 2025 09:11:52 -0400
X-MC-Unique: vgDA7N1rNf2nmD4LEj5WNQ-1
X-Mimecast-MFC-AGG-ID: vgDA7N1rNf2nmD4LEj5WNQ_1753794711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAD4F19560AD; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4134230078C2; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EAED21E6774; Tue, 29 Jul 2025 15:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 4/5] docs/qapi-domain: Fix typos
Date: Tue, 29 Jul 2025 15:11:47 +0200
Message-ID: <20250729131148.3777401-5-armbru@redhat.com>
In-Reply-To: <20250729131148.3777401-1-armbru@redhat.com>
References: <20250729131148.3777401-1-armbru@redhat.com>
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
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250729091642.3513895-2-armbru@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/qapi-domain.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index b71890f660..fe540d1e40 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -9,7 +9,7 @@ in Sphinx is provided by the QAPI Domain, located in
 `Python Domain
 <https://www.sphinx-doc.org/en/master/usage/domains/python.html>`_
 included with Sphinx, but provides special directives and roles
-speciically for annotating and documenting QAPI definitions
+for annotating and documenting QAPI definitions
 specifically.
 
 A `Domain
@@ -101,7 +101,7 @@ without types. The QAPI domain uses this class for features, returns,
 and enum values.
 
 TypedField:
-  * Creates a grouped, typed field. Multiple adjacent entres will be
+  * Creates a grouped, typed field. Multiple adjacent entries will be
     merged into one section, and the content will form a bulleted list.
   * *Must* take at least one argument, but supports up to two -
     nominally, a name and a type.
-- 
2.49.0



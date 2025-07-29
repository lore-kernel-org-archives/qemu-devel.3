Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1620DC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggS7-0003pu-Qw; Tue, 29 Jul 2025 05:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uggS4-0003Yz-Aj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uggS1-0002Bt-Rp
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753780608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROyI85I83WhiZqvzKTcBh19/lvD8f94czS2goX0SmsI=;
 b=NoaDIQNLVU080n0S0RCVjZCAJ6psxxYl5sPmv1Pc0mufzGMjiv9XdReEey6/8KqYJbAlCF
 tkQxiQNfdRJv4m1sFC98mfubqGqv4qhpZriQYrYSm0D9ajUhc7HbOniI9p/21O8EZynKQo
 EQ9ZWXM6O090HS+7y5b0oNctc/MpSzA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-yjzQ7x75PuOMv7ReFQro6A-1; Tue,
 29 Jul 2025 05:16:46 -0400
X-MC-Unique: yjzQ7x75PuOMv7ReFQro6A-1
X-Mimecast-MFC-AGG-ID: yjzQ7x75PuOMv7ReFQro6A_1753780605
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C03C19560BB; Tue, 29 Jul 2025 09:16:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6C441955F21; Tue, 29 Jul 2025 09:16:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C45321E6924; Tue, 29 Jul 2025 11:16:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	jsnow@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH 1/2] docs/qapi-domain: Fix typos
Date: Tue, 29 Jul 2025 11:16:41 +0200
Message-ID: <20250729091642.3513895-2-armbru@redhat.com>
In-Reply-To: <20250729091642.3513895-1-armbru@redhat.com>
References: <20250729091642.3513895-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



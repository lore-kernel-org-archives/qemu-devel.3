Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5733606C541
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mg0RI//Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEB-0003zf-FH; Mon, 02 Nov 2026 09:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD2-0003AT-QQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD1-0008P0-8J
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nx+JQzVuV6SfoCUfbG7m6RhpcRShrhNZwmG6nyMCMQY=;
 b=Mg0RI//Q8aSNDefcPn2wTrjIzYZEUuiXLyUZRlyRAdIUKxrSaDJaNK2/Et3kIlApHX97xp
 Z4vRAcAOTbfmUebF4PU8D5xfK6OPNLY+hTV8Io1iyq1VTnEfVBx7pk8W1e8MSZGIMcAteD
 Zqj9/G1VdCJOQLTFIpaBhi/mDwHtLNw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-uz9Hewr3OJSB4qYiQH-Kbw-1; Mon,
 02 Nov 2026 09:40:22 -0500
X-MC-Unique: uz9Hewr3OJSB4qYiQH-Kbw-1
X-Mimecast-MFC-AGG-ID: uz9Hewr3OJSB4qYiQH-Kbw_1793630421
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C509A1977034; Mon,  2 Nov 2026 14:40:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5024D433; Mon,  2 Nov 2026 14:40:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EED2321E6883; Mon, 02 Nov 2026 15:40:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 04/74] qapi/control: Turn the reference to qmp-spec.rst into a
 link
Date: Mon,  2 Nov 2026 15:39:08 +0100
Message-ID: <20261102144018.3212223-5-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Add a new anchor to qmp-spec that allows us to cross-reference the
Out-of-band execution section of the spec directly.

Amend the documentation in qapi/control.json to use this new cross
reference instead of a plaintext "see also".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260929192403.2972132-1-jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qmp-spec.rst | 2 ++
 qapi/control.json         | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
index 563344160e..ea713a96ac 100644
--- a/docs/interop/qmp-spec.rst
+++ b/docs/interop/qmp-spec.rst
@@ -119,6 +119,8 @@ Where:
 
 The actual commands are documented in the :doc:`qemu-qmp-ref`.
 
+.. _out-of-band execution:
+
 Out-of-band execution
 ---------------------
 
diff --git a/qapi/control.json b/qapi/control.json
index ef63a8a261..e97fe317af 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -44,8 +44,7 @@
 #     client connection, used for agreeing on particular QMP extension
 #     behaviors.
 #
-# @oob: QMP ability to support out-of-band requests.  (Please refer to
-#     qmp-spec.rst for more information on OOB)
+# @oob: QMP ability to support :ref:`out-of-band execution` requests.
 #
 # Since: 2.12
 ##
-- 
2.55.0



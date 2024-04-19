Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A72C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1W-0007aH-Il; Fri, 19 Apr 2024 00:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1L-0007UO-CO
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1J-0004EN-LH
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGse/02Q0gYpHJXH+gJ0nNA2UseR1liYR+1bHBVp6ag=;
 b=JxSQUJJaZC8JxkXDDoX4rf3wcPdIczC5koFJpKgfhJ1I01nNHJLOhfqvlADewUnekN2BwN
 EAl6XX30ILOSQRHYeg5rFOj/+XyXHtWjyO49BYrhbX5lvNSpydhRCbVDEh0cv5hkWUC0pU
 NSc/8z1CuZB2nO/2NTE+XDKh6+9z0iM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ghUg9HZkPbySjCO8vzBQuw-1; Fri, 19 Apr 2024 00:38:39 -0400
X-MC-Unique: ghUg9HZkPbySjCO8vzBQuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13B22811002;
 Fri, 19 Apr 2024 04:38:39 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62E3740829C3;
 Fri, 19 Apr 2024 04:38:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 23/27] docs/qapi-domain: RFC patch - delete malformed field
 lists
Date: Fri, 19 Apr 2024 00:38:11 -0400
Message-ID: <20240419043820.178731-24-jsnow@redhat.com>
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

Cleanup of the last patch to fix the build before closing out this RFC
series.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index ef58dfc4bcd..8352a27d4a5 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -129,10 +129,6 @@ Explicit cross-referencing syntax for QAPI modules is available with
       argument values. It's very temperamental.
    :return SomeTypeName: An esoteric collection of mystical nonsense to
       both confound and delight.
-   :arg: this is malformed.
-   :memb: this is malformed and unrecognized.
-   :choice type name: This is unrecognized.
-   :errors FooError: Also malformed.
    :example: This isn't a "semantic" field, but it's been added to the
       allowed field names list. you can use whatever field names you'd
       like; but to prevent accidental typos, there is an allow list of
-- 
2.44.0



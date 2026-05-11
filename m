Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E59CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX8D-0001iK-9d; Mon, 11 May 2026 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX89-0001i6-NH
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX87-0001oi-CT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQqkTlEQmieIt3vcEkIAFkTZ4M54qmPsR29SRzNdARU=;
 b=IjJcj+1u5YO1lInmDrUkV5qGT1AqXgyMX7IP2REyxBodVTb/5aW9f8zqScKzBhp2WIGEnS
 DctVcJUqjpOgInG21JQK/o85C/38Ho8x3PtQDR95ap5BVsoFNGXGg5ZXwKhxz3sXuP6PWH
 pzo6UjV5Cb3vgoooP8N/CObBKu/ula0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-r6nI_DiCMbiCyiiiFp_F6A-1; Mon,
 11 May 2026 16:21:27 -0400
X-MC-Unique: r6nI_DiCMbiCyiiiFp_F6A-1
X-Mimecast-MFC-AGG-ID: r6nI_DiCMbiCyiiiFp_F6A_1778530887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B98B180034A
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:21:27 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13E8519560A2; Mon, 11 May 2026 20:21:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/24] qom/object: update doc about NULL values in link
 properties
Date: Tue, 12 May 2026 00:20:48 +0400
Message-ID: <20260511202111.3091440-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f40d8ccd4a2..2a2829343d0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1714,10 +1714,10 @@ void object_property_allow_set_link(const Object *obj, const char *name,
  *
  * Links form the graph in the object model.
  *
- * The @check() callback is invoked when
- * object_property_set_link() is called and can raise an error to prevent the
- * link being set.  If @check is NULL, the property is read-only
- * and cannot be set.
+ * The @check() callback is invoked when object_property_set_link() is called
+ * and can raise an error to prevent the link being set. If @check is NULL, the
+ * property is read-only and cannot be set. Care must be taken to handle NULL
+ * values for @val.
  *
  * Ownership of the pointer that @child points to is transferred to the
  * link property.  The reference count for *@child is
-- 
2.54.0



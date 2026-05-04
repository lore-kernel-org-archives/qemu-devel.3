Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F3CD342C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrb7-0007t7-G8; Mon, 04 May 2026 07:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrav-0007oW-TR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJras-0000uk-8w
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jInBZ8zsBzMh+z9fHsz/7RZJ4fPUd1yGMbptU2nQSvs=;
 b=euvALjr/izh+mqxUR9T6TFJBOpjuKSUdAxZdaBbzUnEbyPCEsvi5lYGyzu+VGuePyUywfQ
 nwQtWbEaslCidQzJBzfyUpQJGHbgqrotwutAhCFdJi/xz4etRISzKd2j7t+j5OyXKSYG7G
 e3Ul+hXnsvpheuBpq4r4N/IsgS66+jY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-lVM7APVWPWORN6DV0wgTnQ-1; Mon,
 04 May 2026 07:36:07 -0400
X-MC-Unique: lVM7APVWPWORN6DV0wgTnQ-1
X-Mimecast-MFC-AGG-ID: lVM7APVWPWORN6DV0wgTnQ_1777894566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D06F919560B7
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CE2B18001ED; Mon,  4 May 2026 11:36:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:57 +0400
Subject: [PATCH v2 09/46] qom/object: update doc about NULL values in link
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-9-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bitStGXg9RVRje1l/XipUpcpuZbWjuaVXhuCCEDOM8o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRs+nYJMaU0BzcQcAFfUJ7+z+Npmwpk/I27P
 jnDOb+lLRWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5f9ZD/9WXzwABR/dnstRi37QqjBlgvqEc6crYCU83gRZCPCJKM2FyFB4zDldpbMsbiJWeqlXsO0
 ANYJjamqsuDTJwzaRdUVLWAsHT29PipEjlvq5cmOdTtJxxJNF0vUn4qk3d/eR4xF8w/JCdu5ZF5
 oRgoJOsPa6Aa0OtxH8CDULQuAcjDcrGS2vcPom3Ub+8TZYOuEURS8xNioV90GYuDsdcQoB85EaC
 PJxP+ig4ZZ1vIGls/4XmeUHvKIbHGQX9meSsyeEATAXk4QDFOeZWrcJY+Nw5+GhVjOgstRVVA6b
 TxTqwKYr+7M7TVS8nj9fFV+2iLxxMGFYWlw/wPqgH17q6DxNtkCJeYn1t4Lgi0PTrE2e0QonJsM
 jWws/KyjMzovq0pRtBfs8PcdCxXofIWzn7tGwIo2cKqeA0kM305lSk/H9KTL/gym6IfF61OpcRb
 h+RjCukO5q40zvPbJ7U/LyWzRceM47DGtJuqy2VYUMsiNKdF3HC05fHD5LIG/MQU8WxogoQa/A9
 iHQPKz+Uln6to+S8n8T68wvZ9kbqkZEtjEPXwfECA0iVyrqpXezQTFkHrpXdMVREqTVnnRiLuNm
 t9H43GkJveh/OHilQHXYaPoGICDKnqJejFkyXNFth5ytjbk4BuCVhC2t7nAent1VYHvBwkIYJ5r
 bPYTOyO2yB90/LA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 510885218ba..0a82e160cd0 100644
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



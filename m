Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02415CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM0I-000050-Gt; Wed, 24 Jun 2026 07:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0H-0008V9-3J
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0F-0007p2-1Q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IsTLi+Y01BZWXxIXicDJycIYC+DOW8SnwVJnLKinfvY=;
 b=OZWDMf6Aw0cdvo+13JGBpeEgRrd+XAtmOpXPH/Q8nLNQNOv+hT3dtIJlFaCmotXo7vAsuj
 /IpgoyGoJj2F+eQteM4TDIpJ0nEmdUiEwbddcIdOQDlTCCCegnKWYXbJCUM+I7vykj9phH
 dFkVgGNGn+YxBKoYN+pKkQtjZJ6CHhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-hXtS7S49NWacDmCe583ZMw-1; Wed,
 24 Jun 2026 07:42:45 -0400
X-MC-Unique: hXtS7S49NWacDmCe583ZMw-1
X-Mimecast-MFC-AGG-ID: hXtS7S49NWacDmCe583ZMw_1782301364
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36ECE1954B07
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD5F01955F7A; Wed, 24 Jun 2026 11:42:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:35 +0400
Subject: [GIT PULL 13/35] ui/spice: remove dead spice_displays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-13-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6RWiRIl/EpCyDaXLKB7/6zQ9zTNxOh+9UhwoGmrHoQU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnDOb9KtReBvwQPPKlBx+0MYi086lydqF/Z
 wCAduF2bh2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5ZMJD/9VnLrkLKggJVt0j8BRUbEWS2Z0fIAtt+PZlTG+IFXaah7lVAhUbQ5/FKgYHFs9kiOS8NM
 hJRyl4BsHRqE2VyLpTbve5rQ++OdwNJaegS2J0RuSBgsXh1csExOkJX7ZgLgbKmDRMF5Afa0s6X
 VIL6Bhk3ubX7NNlSb7eKpDE6eCKL4bqlcnoQ61omKBbUnoKNgUEESEXMAd95Ff0OgzX3cBriald
 +Ck1xRIaOdWkXpdfWx4sc1TSnaY0svRarCAFHuwu7GsWsS2Runh0LfP9EZUcpuFYL3ZMIpONdkp
 AACFl8e7lMoHCh5ObMASzs+ZHzUtUmNSgKh470vlPQtS8PGNX3kYYCJFZSpdZCSlSr4intyvoDx
 XDfbxoCEfofwtfgnmdyqd5yI03VRube7UV9Ub2EXFvLJWgl5EmDSfPoDQN9bhnEQnLd4/Lb6XAN
 teK4nnB7e88CmLFVZgCAuGeVXM028CvBtSoroJepdyb5GTY136WlTtArVjpfBp8t2mV5S/MRdqU
 ygZKKNe/QavlhN84GQ/0L8Kuv8vPWrS6Jjx/N3CjGibzLFhrKwpfHOXwxGuBu028GEWUfqx51ww
 DOszTHlwg4pGvsRGk6j7xRfRyZLTWAwcBMUc4OapVo8EYHMt3lS6ZfzQZeF+UIjDitOhzKYRrPY
 3yVuy2bZAzdfCAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is left-over from commit 9fa032866da ("spice: fix multihead support")

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-13-4656aec3398d@redhat.com>
---
 include/ui/qemu-spice.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 111a09ceca3..59a68cd9833 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -33,13 +33,6 @@ bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
                             const char *subject);
-
-#else  /* CONFIG_SPICE */
-
-#include "qemu/error-report.h"
-
-#define spice_displays 0
-
 #endif /* CONFIG_SPICE */
 
 static inline bool qemu_using_spice(Error **errp)

-- 
2.54.0



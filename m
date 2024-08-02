Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A243C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsUC-0000UE-OM; Fri, 02 Aug 2024 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsUA-0000Mr-Ta
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZsU9-0002xi-8n
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722605900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=76X2gLmSh91Q7+zu1kNaeBaPwdxCniEJ0/G6OTn3N1o=;
 b=FOWnNRjD5AYq6DRSdkBQf9r8Zpqpff4GmelE3y7UZKmAZai0Es44gxs1E8WiSoev1GdGyo
 dg8Cmsi7IcEeTyMvJz6PncQn39lemrAfuQPnvINWQ0Xfl8pHtn/zvDaF4TycxwkljPOsDu
 cGRcHzWby+sEyEJL9dlFSBS9lzznGg4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-KRCKrrK1OCKyeIlraDWx0Q-1; Fri,
 02 Aug 2024 09:38:18 -0400
X-MC-Unique: KRCKrrK1OCKyeIlraDWx0Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 718691944B30; Fri,  2 Aug 2024 13:38:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B13F1195605A; Fri,  2 Aug 2024 13:38:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: nbd@other.debian.org
Cc: qemu-devel@nongnu.org
Subject: [PATCH] docs: Tweak location of qemu nbd extensions
Date: Fri,  2 Aug 2024 08:36:43 -0500
Message-ID: <20240802133811.2001029-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Upstream QEMU is moving the location of its NBD docs, as of its commit
XXXX[1].  Instead of pointing to the raw git source file, point to the
rendered html version built from rST.

CC: qemu-devel@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---

[1] Commit id TBD, I will update this patch to match reality once
qemu's patch lands, and only push this once the new link actually
exists.  See also
https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00223.html

---
 doc/proto.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/proto.md b/doc/proto.md
index cf1f60f..565fbeb 100644
--- a/doc/proto.md
+++ b/doc/proto.md
@@ -963,7 +963,7 @@ Namespaces MUST be consist of one of the following:
 Third-party implementations can register additional namespaces by
 simple request to the mailing-list. The following additional
 third-party namespaces are currently registered:
-* `qemu`, maintained by [qemu.org](https://gitlab.com/qemu-project/qemu/-/blob/master/docs/interop/nbd.txt)
+* `qemu`, maintained by [qemu.org](https://www.qemu.org/docs/master/interop/nbd.html)

 Save in respect of the `base:` namespace described below, this specification
 requires no specific semantics of metadata contexts, except that all the
-- 
2.45.2



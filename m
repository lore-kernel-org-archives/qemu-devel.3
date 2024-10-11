Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FFD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ93-00074Z-6O; Fri, 11 Oct 2024 13:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szJ5V-0000hD-UY
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1szGOw-0003q8-To
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 10:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728656032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TF00fTa6MvOpDcs7ABOjf8hKTP1XWeiqIDZz2APxFwM=;
 b=FtBfBVwkQhygfFvqcTlteWhdAt/fhscZs6jEJwpzSQIk1YFgKJGbn3T8nJ7pDB8TK0AxW3
 oSVdgldk34VVoN09euBLxSp2z8RYws17oyCSyXiCrY6WxQpxdoIGStKTMoWaxC7V1ZewAz
 y1V+iFMQrbYOjdHYM0c7uIP0azzWitY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-S5Vx6CG4M36yBKC-tBPadQ-1; Fri,
 11 Oct 2024 10:13:51 -0400
X-MC-Unique: S5Vx6CG4M36yBKC-tBPadQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3801955F41; Fri, 11 Oct 2024 14:13:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.77])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6ABF1955F42; Fri, 11 Oct 2024 14:13:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>
Subject: [PATCH] MAINTAINERS: A new maintainer for the qtests
Date: Fri, 11 Oct 2024 16:13:44 +0200
Message-ID: <20241011141344.379781-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since I blundered into becoming the maintainer of the new functional
test  framework in QEMU (tests/functional/) recently, I need to drop
some other duties - it's getting too much for me otherwise. Laurent
is also quite busy with other projects nowadays, so I looked around
for help.
Fabiano did quite a lot of work in the qtests in the past already,
and is also already a maintainer for migration, so I thought he
would be a very good fit, thus I asked him whether he would be
interested to help out with the qtests and he agreed.
Thank you very much, Fabiano!

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7a11fe601..d8e4d2d587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3250,7 +3250,7 @@ F: tests/qtest/qmp-cmd-test.c
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
-M: Thomas Huth <thuth@redhat.com>
+M: Fabiano Rosas <farosas@suse.de>
 M: Laurent Vivier <lvivier@redhat.com>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
@@ -3268,7 +3268,7 @@ M: Alexander Bulekov <alxndr@bu.edu>
 R: Paolo Bonzini <pbonzini@redhat.com>
 R: Bandan Das <bsd@redhat.com>
 R: Stefan Hajnoczi <stefanha@redhat.com>
-R: Thomas Huth <thuth@redhat.com>
+R: Fabiano Rosas <farosas@suse.de>
 R: Darren Kenny <darren.kenny@oracle.com> 
 R: Qiuhao Li <Qiuhao.Li@outlook.com>
 S: Maintained
-- 
2.46.1



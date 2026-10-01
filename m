Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E460CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUf-0008WO-69; Thu, 01 Oct 2026 13:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUc-0008Vc-Q9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUb-0006vd-Ax
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gOhUlaqYft9ZEwA3v6D1+kcKuZduQ2ieI8v0P5bHeA8=;
 b=LLPiZYbZiJaVFkzTLrusCa8ycnersu7xL0SYcD3KgNnhZhspLA1Ys3Ns6Fnu+zdqbEAe1M
 4jyv966iwf8g+S9/2NpgmZFBSikJOT6lMwHjsUXPFlFGz6sP2rM3EjsmL/eVU5OAYwd8tJ
 g5z7q/Rms955RTymoYWNr12pfqYf+gs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-JmispcK4MW2HovZbJTJMfw-1; Thu,
 01 Oct 2026 13:22:43 -0400
X-MC-Unique: JmispcK4MW2HovZbJTJMfw-1
X-Mimecast-MFC-AGG-ID: JmispcK4MW2HovZbJTJMfw_1790875362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92E24180058D; Thu,  1 Oct 2026 17:22:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7B591800348; Thu,  1 Oct 2026 17:22:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 01/11] docs/qapi-code-gen: change "x.y.z" to "x.y" for Since:
 documentation
Date: Thu,  1 Oct 2026 13:22:28 -0400
Message-ID: <20261001172239.2825745-2-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We prefer using only x.y for Since: tags, not x.y.z. Adjust docs
accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index b1cc5b5f0db..f276a2bc9bc 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1001,7 +1001,7 @@ indented like this::
 .. FIXME union branches should be described, too.
 
 Extensions added after the definition was first released carry a
-"(since x.y.z)" comment.
+"(since x.y)" comment.
 
 The feature descriptions must be preceded by a blank line and then a
 line "Features:", like this::
@@ -1034,7 +1034,7 @@ detailing a relevant error condition.  For example::
  #     - If @device does not exist, DeviceNotFound
  #     - Any other error returns a GenericError.
 
-A "Since: x.y.z" tagged section lists the release that introduced the
+A "Since: x.y" tagged section lists the release that introduced the
 definition.
 
 "TODO" sections are not rendered (they are for developers, not users of
-- 
2.55.0



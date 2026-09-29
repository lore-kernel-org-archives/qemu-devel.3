Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A184CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBdR0-000635-CK; Tue, 29 Sep 2026 15:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBdQw-00062e-Tk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBdQv-0006OA-HB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 15:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790709848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qKjtkE88rBpbuUTtSSwIflCDKVQMROi3jLqhy6XAi0E=;
 b=hx6GYxC9wIhPGXoLdZGKyuoWiQ2k3oy9q8zunKtaPMeQd0aAMgVBP1WEcQ1mdibbVcNJGK
 5ITQWoGCrxN43crbpTn1+D9LYvcm3UKXRODNiWIYJZb7TpZ1NdkMDyhSzao4+aefcX20zI
 srG3N6e7q4nNa0pQNVHAOCcSvDcdlRU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-x4syRvj6N-ykh_bs1H9NdA-1; Tue,
 29 Sep 2026 15:24:06 -0400
X-MC-Unique: x4syRvj6N-ykh_bs1H9NdA-1
X-Mimecast-MFC-AGG-ID: x4syRvj6N-ykh_bs1H9NdA_1790709845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96548193E8C5; Tue, 29 Sep 2026 19:24:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD6851956047; Tue, 29 Sep 2026 19:24:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] qapi/control: Turn the reference to qmp-spec.rst into a link
Date: Tue, 29 Sep 2026 15:24:03 -0400
Message-ID: <20260929192403.2972132-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new anchor to qmp-spec that allows us to cross-reference the
Out-of-band execution section of the spec directly.

Amend the documentation in qapi/control.json to use this new cross
reference instead of a plaintext "see also".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/qmp-spec.rst | 2 ++
 qapi/control.json         | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
index 563344160e6..ea713a96ac0 100644
--- a/docs/interop/qmp-spec.rst
+++ b/docs/interop/qmp-spec.rst
@@ -119,6 +119,8 @@ Where:
 
 The actual commands are documented in the :doc:`qemu-qmp-ref`.
 
+.. _out-of-band execution:
+
 Out-of-band execution
 ---------------------
 
diff --git a/qapi/control.json b/qapi/control.json
index ef63a8a261b..e97fe317af7 100644
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



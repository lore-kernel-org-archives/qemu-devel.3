Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8FCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprO-0000uH-5Z; Mon, 03 Nov 2025 03:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprI-0000tK-Rp
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprD-0006iw-3h
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaLSgC/W9sw4YpO294MpEdByW+rvygGfl6+ohgPZlFE=;
 b=f1UutzxeNwPDv2qmohv3PANvSJQIRB1cwNkekYlAo4kXEmN4fgDEpsYcbJJXGuIFsDiMf8
 sJMqWfLL8P94LUllfQL5F3WBTS3p4LycBKTGu6I5ppXSTtWn/PGFUXQdryn0f6IMn7GijV
 oBsqf95BUPxuajSTXxm6OHYyX0sHPAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-VXuWgn-_NQO9B2KQmDBL2g-1; Mon,
 03 Nov 2025 03:23:59 -0500
X-MC-Unique: VXuWgn-_NQO9B2KQmDBL2g-1
X-Mimecast-MFC-AGG-ID: VXuWgn-_NQO9B2KQmDBL2g_1762158239
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C061954B0C; Mon,  3 Nov 2025 08:23:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09C21800451; Mon,  3 Nov 2025 08:23:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC55E21E6924; Mon, 03 Nov 2025 09:23:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 1/9] qapi/audio: Fix description markup of
 AudiodevDBusOptions @nsamples
Date: Mon,  3 Nov 2025 09:23:46 +0100
Message-ID: <20251103082354.3273027-2-armbru@redhat.com>
In-Reply-To: <20251103082354.3273027-1-armbru@redhat.com>
References: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The description of Member @nsamples is indented incorrectly.  Comes
out like

    Members:
            [...]
	    nsamples (int, optional) – set the number of samples per
	    read/write calls (default to 480,

    10ms at 48kHz).

Fixing the indentation makes it come out like

    Members:
            [...]
	    nsamples (int, optional) – set the number of samples per
	    read/write calls (default to 480, 10ms at 48kHz).

Fixes: 19c628f2f579 (dbus: add -audio dbus nsamples option)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/audio.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 53142080f7..2df87b9710 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -76,8 +76,8 @@
 #
 # @out: options of the playback stream
 #
-# @nsamples: set the number of samples per read/write calls (default to 480,
-# 10ms at 48kHz).
+# @nsamples: set the number of samples per read/write calls
+#     (default to 480, 10ms at 48kHz).
 #
 # Since: 10.0
 ##
-- 
2.49.0



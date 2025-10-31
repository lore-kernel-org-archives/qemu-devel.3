Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5589BCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElkE-0000a7-AB; Fri, 31 Oct 2025 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljx-0000TH-3F
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljl-0006hJ-HC
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9L4ZCWT4UGbDU5iREPqRgIUnG5U6nLApLgwDN07p3cw=;
 b=OhOLDRZlcj/nS1F6Gcha16oBdPqyIK+KVczzbPTfGgIUqqpT2NbB0jNz/WQGA22/37QC5F
 riAL/UclIEYCAmVXS56/kNx3WgF5aHDrGunw8uw9KhY75OzOo2YyqxHwxdl0SJT8FAPc40
 mxievXTQ2xYaQLTOTS01PT0DDp7UcNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-ylW8pVNPNfuiNrbZn46t4g-1; Fri,
 31 Oct 2025 05:47:55 -0400
X-MC-Unique: ylW8pVNPNfuiNrbZn46t4g-1
X-Mimecast-MFC-AGG-ID: ylW8pVNPNfuiNrbZn46t4g_1761904074
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B4321955E7A; Fri, 31 Oct 2025 09:47:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6DF21954128; Fri, 31 Oct 2025 09:47:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C09521E6924; Fri, 31 Oct 2025 10:47:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 1/8] qapi/audio: Fix description markup of AudiodevDBusOptions
 @nsamples
Date: Fri, 31 Oct 2025 10:47:44 +0100
Message-ID: <20251031094751.2817932-2-armbru@redhat.com>
In-Reply-To: <20251031094751.2817932-1-armbru@redhat.com>
References: <20251031094751.2817932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480,

    10ms at 48kHz).

Fixing the indentation makes it come out like

    Members:
            [...]
	    nsamples (int, optional) – set the number of samples per read/write calls (default to 480, 10ms at 48kHz).

Fixes: 19c628f2f579 (dbus: add -audio dbus nsamples option)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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



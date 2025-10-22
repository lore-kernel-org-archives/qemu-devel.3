Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B57CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSrL-00022w-4f; Wed, 22 Oct 2025 03:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSq6-00014z-CH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSq3-0000LQ-EU
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9quFj1kc8GcFcrXgts+32Be2wYOyQrTvnJ7+W0o4Xo=;
 b=YbTOJAlz/jpYwDBH1W+6kxYLdiyqpiTSwWk9CVa1cnuSQ1j8h/hK08ccLR7eky51NacxIg
 9stzsMM3N+qSdXRlVa8JwDOhTwlPYJ0c34NWpav8arYGH3tvykz2ZvNrz+4NQAPON/IWFW
 priGf2LcwzPYiBkHoF3o0p6ZNaxGw3k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-dDruFRCINWetcAGN4OJ3JQ-1; Wed,
 22 Oct 2025 03:00:44 -0400
X-MC-Unique: dDruFRCINWetcAGN4OJ3JQ-1
X-Mimecast-MFC-AGG-ID: dDruFRCINWetcAGN4OJ3JQ_1761116443
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92FE81808997; Wed, 22 Oct 2025 07:00:43 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5555019560B4; Wed, 22 Oct 2025 07:00:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 42/42] docs: Update mentions of removed '-soundhw' command
 line option
Date: Wed, 22 Oct 2025 10:56:37 +0400
Message-ID: <20251022065640.1172785-43-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The `-soundhw` CLI was removed in commit 039a68373c4 ("introduce
-audio as a replacement for -soundhw"). Remove outdated comments
and update the document mentioning the old usage.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/qdev-device-use.txt | 4 ++--
 system/qdev-monitor.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 043ae46114..fb420da2a9 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -311,9 +311,9 @@ constraints.
 
 Host and guest part of audio devices have always been separate.
 
-The old way to define guest audio devices is -soundhw C1,...
+The old way to define guest audio devices was -soundhw C1,...
 
-The new way is to define each guest audio device separately with
+The current way is to define each guest audio device separately with
 -device.
 
 Map from -soundhw sound card name to -device:
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 9ed05d5d5a..f2aa400a77 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -73,9 +73,9 @@ typedef struct QDevAlias
 
 /* Please keep this table sorted by typename. */
 static const QDevAlias qdev_alias_table[] = {
-    { "AC97", "ac97" }, /* -soundhw name */
+    { "AC97", "ac97" },
     { "e1000", "e1000-82540em" },
-    { "ES1370", "es1370" }, /* -soundhw name */
+    { "ES1370", "es1370" },
     { "ich9-ahci", "ahci" },
     { "lsi53c895a", "lsi" },
     { "virtio-9p-device", "virtio-9p", QEMU_ARCH_VIRTIO_MMIO },
-- 
2.51.0



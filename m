Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC404E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdUk-00042z-OJ; Wed, 18 Feb 2026 04:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUi-0003pP-7J
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdUe-0000Lg-7n
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QlxcLRDQ69PV90o9Mn4CbxaLjwkLmtdD5/P7jjtqnc=;
 b=C7mkhJzJtQz8SzOf76CUNlROKErmi2Wkv7dqY1HXPYf5sgfJtic5SmLfo/h5C91p9s8omN
 uyXilOIDGymHKWArkfJm9xA9gnRQNLLpVl+wGgzoA8aAsjwCgMTIGxwy6Ukcieby9rYptH
 8p6tarpTZM40Vca5FePp2F66UCgYrMQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-V1XGf-TKO06yTJ-JaWSIsg-1; Wed,
 18 Feb 2026 04:05:07 -0500
X-MC-Unique: V1XGf-TKO06yTJ-JaWSIsg-1
X-Mimecast-MFC-AGG-ID: V1XGf-TKO06yTJ-JaWSIsg_1771405507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E48BE1800451; Wed, 18 Feb 2026 09:05:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48BD8180066B; Wed, 18 Feb 2026 09:05:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 31/85] audio: make list type declaration private
Date: Wed, 18 Feb 2026 10:02:31 +0100
Message-ID: <20260218090330.1476169-32-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

No need to share in a common header.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h | 7 -------
 audio/audio.c     | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 446ba1d52c6..08d07b17557 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -306,13 +306,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
 #define ldebug(fmt, ...) (void)0
 #endif
 
-typedef struct AudiodevListEntry {
-    Audiodev *dev;
-    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
-} AudiodevListEntry;
-
-typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
-
 void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
diff --git a/audio/audio.c b/audio/audio.c
index 16edc57e5f0..d8a54548274 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -68,6 +68,13 @@ const char *audio_prio_list[] = {
     NULL
 };
 
+typedef struct AudiodevListEntry {
+    Audiodev *dev;
+    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
+} AudiodevListEntry;
+
+typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
+
 static AudiodevListHead audiodevs =
     QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
 static AudiodevListHead default_audiodevs =
-- 
2.53.0



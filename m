Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A114CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrj2-0001ca-N3; Wed, 30 Sep 2026 06:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrim-0001ML-F6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrif-0006kx-RI
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBaBsITVhaWmU3m0+BVYGY8QtNPdQHs3jEgLgez/jGI=;
 b=RC5M5g9ypXccWVEnO951d/G/DyK8pkNyhUuHNlABvKsLZivVpzQLSqHosikrbBjfrdHytK
 bsLhucGDzpRse8Ys4clikMZ2vvAxpYg8SR4W+PYsfkuTOVT0P2mG/GGvHcchvB2mwpZVgx
 WuM80ScCPEkoeIDVFOBd8JfSs18rM/U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-FjsoAJh3NQGwCHwZc8EB_w-1; Wed,
 30 Sep 2026 06:39:21 -0400
X-MC-Unique: FjsoAJh3NQGwCHwZc8EB_w-1
X-Mimecast-MFC-AGG-ID: FjsoAJh3NQGwCHwZc8EB_w_1790764760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A070180215B; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B96171800361; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1222221E68A2; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 030/105] qapi: convert trivial intro sections for audio.json
Date: Wed, 30 Sep 2026 12:37:55 +0200
Message-ID: <20260930103910.3934848-31-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-31-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/audio.json | 88 ++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b9710..72190f2099 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -14,9 +14,8 @@
 
 ##
 # @AudiodevPerDirectionOptions:
-#
-# General audio backend options that are used for both playback and
-# recording.
+#     General audio backend options that are used for both playback
+#     and recording.
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
@@ -53,8 +52,7 @@
 
 ##
 # @AudiodevGenericOptions:
-#
-# Generic driver-specific options.
+#     Generic driver-specific options.
 #
 # @in: options of the capture stream
 #
@@ -69,8 +67,7 @@
 
 ##
 # @AudiodevDBusOptions:
-#
-# Options of the D-Bus audio backend.
+#     Options of the D-Bus audio backend.
 #
 # @in: options of the capture stream
 #
@@ -89,9 +86,8 @@
 
 ##
 # @AudiodevAlsaPerDirectionOptions:
-#
-# Options of the ALSA backend that are used for both playback and
-# recording.
+#     Options of the ALSA backend that are used for both playback and
+#     recording.
 #
 # @dev: the name of the ALSA device to use (default 'default')
 #
@@ -111,8 +107,7 @@
 
 ##
 # @AudiodevAlsaOptions:
-#
-# Options of the ALSA audio backend.
+#     Options of the ALSA audio backend.
 #
 # @in: options of the capture stream
 #
@@ -130,8 +125,7 @@
 
 ##
 # @AudiodevSndioOptions:
-#
-# Options of the sndio audio backend.
+#     Options of the sndio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -152,9 +146,8 @@
 
 ##
 # @AudiodevCoreaudioPerDirectionOptions:
-#
-# Options of the Core Audio backend that are used for both playback
-# and recording.
+#     Options of the Core Audio backend that are used for both
+#     playback and recording.
 #
 # @buffer-count: number of buffers
 #
@@ -167,8 +160,7 @@
 
 ##
 # @AudiodevCoreaudioOptions:
-#
-# Options of the coreaudio audio backend.
+#     Options of the coreaudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -183,8 +175,7 @@
 
 ##
 # @AudiodevDsoundOptions:
-#
-# Options of the DirectSound audio backend.
+#     Options of the DirectSound audio backend.
 #
 # @in: options of the capture stream
 #
@@ -203,9 +194,8 @@
 
 ##
 # @AudiodevJackPerDirectionOptions:
-#
-# Options of the JACK backend that are used for both playback and
-# recording.
+#     Options of the JACK backend that are used for both playback and
+#     recording.
 #
 # @server-name: select from among several possible concurrent server
 #     instances (default: environment variable $JACK_DEFAULT_SERVER if
@@ -237,8 +227,7 @@
 
 ##
 # @AudiodevJackOptions:
-#
-# Options of the JACK audio backend.
+#     Options of the JACK audio backend.
 #
 # @in: options of the capture stream
 #
@@ -253,9 +242,8 @@
 
 ##
 # @AudiodevOssPerDirectionOptions:
-#
-# Options of the OSS backend that are used for both playback and
-# recording.
+#     Options of the OSS backend that are used for both playback and
+#     recording.
 #
 # @dev: file name of the OSS device (default '/dev/dsp')
 #
@@ -275,8 +263,7 @@
 
 ##
 # @AudiodevOssOptions:
-#
-# Options of the OSS audio backend.
+#     Options of the OSS audio backend.
 #
 # @in: options of the capture stream
 #
@@ -305,9 +292,8 @@
 
 ##
 # @AudiodevPaPerDirectionOptions:
-#
-# Options of the Pulseaudio backend that are used for both playback
-# and recording.
+#     Options of the Pulseaudio backend that are used for both
+#     playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -330,8 +316,7 @@
 
 ##
 # @AudiodevPaOptions:
-#
-# Options of the PulseAudio audio backend.
+#     Options of the PulseAudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -349,9 +334,8 @@
 
 ##
 # @AudiodevPipewirePerDirectionOptions:
-#
-# Options of the PipeWire backend that are used for both playback and
-# recording.
+#     Options of the PipeWire backend that are used for both playback
+#     and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -374,8 +358,7 @@
 
 ##
 # @AudiodevPipewireOptions:
-#
-# Options of the PipeWire audio backend.
+#     Options of the PipeWire audio backend.
 #
 # @in: options of the capture stream
 #
@@ -390,9 +373,8 @@
 
 ##
 # @AudiodevSdlPerDirectionOptions:
-#
-# Options of the SDL audio backend that are used for both playback and
-# recording.
+#     Options of the SDL audio backend that are used for both playback
+#     and recording.
 #
 # @buffer-count: number of buffers (default 4)
 #
@@ -405,8 +387,7 @@
 
 ##
 # @AudiodevSdlOptions:
-#
-# Options of the SDL audio backend.
+#     Options of the SDL audio backend.
 #
 # @in: options of the recording stream
 #
@@ -421,8 +402,7 @@
 
 ##
 # @AudiodevWavOptions:
-#
-# Options of the wav audio backend.
+#     Options of the wav audio backend.
 #
 # @in: options of the capture stream
 #
@@ -440,8 +420,7 @@
 
 ##
 # @AudioFormat:
-#
-# An enumeration of possible audio formats.
+#     An enumeration of possible audio formats.
 #
 # @u8: unsigned 8 bit integer
 #
@@ -464,8 +443,7 @@
 
 ##
 # @AudiodevDriver:
-#
-# An enumeration of possible audio backend drivers.
+#     An enumeration of possible audio backend drivers.
 #
 # @jack: JACK audio backend (since 5.1)
 #
@@ -488,8 +466,7 @@
 
 ##
 # @Audiodev:
-#
-# Options of an audio backend.
+#     Options of an audio backend.
 #
 # @id: identifier of the backend
 #
@@ -534,8 +511,7 @@
 
 ##
 # @query-audiodevs:
-#
-# Return information about audiodev configuration
+#     Return information about audiodev configuration
 #
 # Since: 8.0
 ##
-- 
2.55.0



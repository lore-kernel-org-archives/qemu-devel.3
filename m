Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE60CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcCa-0001zH-3P; Tue, 02 Jun 2026 23:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcCT-0001jQ-96
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcCR-0002cv-H0
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780457002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z31RfUFoOPTVXn0OWibG2S+bAOrVagBG2khh+ZxyXL0=;
 b=KrPC+EBcqyI8iEAwmgQFkwden0/vKJAzLm1hKknmxPAZ4Oz1lvRh8EXEHG/4v/tkqEfQJo
 TF1Asj0fudrdpHgD9tV8VaDN8K7Yjep7fTuNmCSEVpEV7Jun5qQw6nDwPIeFcNDJ2soLGP
 C96vpX9yda2NNCuwjmidH2cLr3uq3R8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-N59WQh1bMXW_Qq8VVXmKGA-1; Tue,
 02 Jun 2026 23:23:18 -0400
X-MC-Unique: N59WQh1bMXW_Qq8VVXmKGA-1
X-Mimecast-MFC-AGG-ID: N59WQh1bMXW_Qq8VVXmKGA_1780456997
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BEFD195608A; Wed,  3 Jun 2026 03:23:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1850030001A1; Wed,  3 Jun 2026 03:23:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 16/16] qapi: convert intro sections for audio.json
Date: Tue,  2 Jun 2026 23:22:01 -0400
Message-ID: <20260603032201.993015-17-jsnow@redhat.com>
In-Reply-To: <20260603032201.993015-1-jsnow@redhat.com>
References: <20260603032201.993015-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json | 88 ++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b97101..72190f20993 100644
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
2.54.0



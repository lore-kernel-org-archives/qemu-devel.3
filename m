Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BECFDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26m-0005mM-3i; Thu, 23 Apr 2026 18:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26j-0005lc-BX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26h-0005vg-Eb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XiN9lkMfA+GHJWcM7MksfC6FyoKtwwBmXVuhnOqfuSM=;
 b=cGYg66uQOST4JslUE9TmStyGj5VzOfkY7XR4+DuVe50B23U7VtNV1YCgousj+shgBKDFVS
 bpGOB2Om43mSGvyusEXmk7lLjXi+V02ocRwvj9fzP1rxu2XWrL2I5puUOWc6cNFm7ifo5s
 sKZL1zAJcrdWqUcc/3q4r7pvN4PmbkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-kcMI3IPTPbW_TvEUsLbb4A-1; Thu,
 23 Apr 2026 18:01:08 -0400
X-MC-Unique: kcMI3IPTPbW_TvEUsLbb4A-1
X-Mimecast-MFC-AGG-ID: kcMI3IPTPbW_TvEUsLbb4A_1776981666
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C02EF19560B4; Thu, 23 Apr 2026 22:01:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45BED3007572; Thu, 23 Apr 2026 22:01:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH 12/12] qapi: convert intro sections for audio.json
Date: Thu, 23 Apr 2026 18:00:21 -0400
Message-ID: <20260423220022.2180059-13-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
References: <20260423220022.2180059-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qapi/audio.json | 112 ++++++++++++++----------------------------------
 .editorconfig   |   1 +
 2 files changed, 33 insertions(+), 80 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b97101..62d64eabf1c 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -13,10 +13,8 @@
 ##
 
 ##
-# @AudiodevPerDirectionOptions:
-#
-# General audio backend options that are used for both playback and
-# recording.
+# @AudiodevPerDirectionOptions: General audio backend options that are
+#     used for both playback and recording.
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
@@ -52,9 +50,7 @@
     '*buffer-length':  'uint32' } }
 
 ##
-# @AudiodevGenericOptions:
-#
-# Generic driver-specific options.
+# @AudiodevGenericOptions: Generic driver-specific options.
 #
 # @in: options of the capture stream
 #
@@ -68,9 +64,7 @@
     '*out': 'AudiodevPerDirectionOptions' } }
 
 ##
-# @AudiodevDBusOptions:
-#
-# Options of the D-Bus audio backend.
+# @AudiodevDBusOptions: Options of the D-Bus audio backend.
 #
 # @in: options of the capture stream
 #
@@ -88,10 +82,8 @@
     '*nsamples': 'uint32'} }
 
 ##
-# @AudiodevAlsaPerDirectionOptions:
-#
-# Options of the ALSA backend that are used for both playback and
-# recording.
+# @AudiodevAlsaPerDirectionOptions: Options of the ALSA backend that
+#     are used for both playback and recording.
 #
 # @dev: the name of the ALSA device to use (default 'default')
 #
@@ -110,9 +102,7 @@
     '*try-poll':      'bool' } }
 
 ##
-# @AudiodevAlsaOptions:
-#
-# Options of the ALSA audio backend.
+# @AudiodevAlsaOptions: Options of the ALSA audio backend.
 #
 # @in: options of the capture stream
 #
@@ -129,9 +119,7 @@
     '*threshold': 'uint32' } }
 
 ##
-# @AudiodevSndioOptions:
-#
-# Options of the sndio audio backend.
+# @AudiodevSndioOptions: Options of the sndio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -151,10 +139,8 @@
     '*latency':   'uint32'} }
 
 ##
-# @AudiodevCoreaudioPerDirectionOptions:
-#
-# Options of the Core Audio backend that are used for both playback
-# and recording.
+# @AudiodevCoreaudioPerDirectionOptions: Options of the Core Audio
+#     backend that are used for both playback and recording.
 #
 # @buffer-count: number of buffers
 #
@@ -166,9 +152,7 @@
     '*buffer-count': 'uint32' } }
 
 ##
-# @AudiodevCoreaudioOptions:
-#
-# Options of the coreaudio audio backend.
+# @AudiodevCoreaudioOptions: Options of the coreaudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -182,9 +166,7 @@
     '*out': 'AudiodevCoreaudioPerDirectionOptions' } }
 
 ##
-# @AudiodevDsoundOptions:
-#
-# Options of the DirectSound audio backend.
+# @AudiodevDsoundOptions: Options of the DirectSound audio backend.
 #
 # @in: options of the capture stream
 #
@@ -202,10 +184,8 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevJackPerDirectionOptions:
-#
-# Options of the JACK backend that are used for both playback and
-# recording.
+# @AudiodevJackPerDirectionOptions: Options of the JACK backend that
+#     are used for both playback and recording.
 #
 # @server-name: select from among several possible concurrent server
 #     instances (default: environment variable $JACK_DEFAULT_SERVER if
@@ -236,9 +216,7 @@
     '*exact-name':    'bool' } }
 
 ##
-# @AudiodevJackOptions:
-#
-# Options of the JACK audio backend.
+# @AudiodevJackOptions: Options of the JACK audio backend.
 #
 # @in: options of the capture stream
 #
@@ -252,10 +230,8 @@
     '*out': 'AudiodevJackPerDirectionOptions' } }
 
 ##
-# @AudiodevOssPerDirectionOptions:
-#
-# Options of the OSS backend that are used for both playback and
-# recording.
+# @AudiodevOssPerDirectionOptions: Options of the OSS backend that are
+#     used for both playback and recording.
 #
 # @dev: file name of the OSS device (default '/dev/dsp')
 #
@@ -274,9 +250,7 @@
     '*try-poll':     'bool' } }
 
 ##
-# @AudiodevOssOptions:
-#
-# Options of the OSS audio backend.
+# @AudiodevOssOptions: Options of the OSS audio backend.
 #
 # @in: options of the capture stream
 #
@@ -304,10 +278,8 @@
     '*dsp-policy': 'uint32' } }
 
 ##
-# @AudiodevPaPerDirectionOptions:
-#
-# Options of the Pulseaudio backend that are used for both playback
-# and recording.
+# @AudiodevPaPerDirectionOptions: Options of the Pulseaudio backend
+#     that are used for both playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -329,9 +301,7 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevPaOptions:
-#
-# Options of the PulseAudio audio backend.
+# @AudiodevPaOptions: Options of the PulseAudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -348,10 +318,8 @@
     '*server': 'str' } }
 
 ##
-# @AudiodevPipewirePerDirectionOptions:
-#
-# Options of the PipeWire backend that are used for both playback and
-# recording.
+# @AudiodevPipewirePerDirectionOptions: Options of the PipeWire
+#     backend that are used for both playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -373,9 +341,7 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevPipewireOptions:
-#
-# Options of the PipeWire audio backend.
+# @AudiodevPipewireOptions: Options of the PipeWire audio backend.
 #
 # @in: options of the capture stream
 #
@@ -389,10 +355,8 @@
     '*out':    'AudiodevPipewirePerDirectionOptions' } }
 
 ##
-# @AudiodevSdlPerDirectionOptions:
-#
-# Options of the SDL audio backend that are used for both playback and
-# recording.
+# @AudiodevSdlPerDirectionOptions: Options of the SDL audio backend
+#     that are used for both playback and recording.
 #
 # @buffer-count: number of buffers (default 4)
 #
@@ -404,9 +368,7 @@
     '*buffer-count': 'uint32' } }
 
 ##
-# @AudiodevSdlOptions:
-#
-# Options of the SDL audio backend.
+# @AudiodevSdlOptions: Options of the SDL audio backend.
 #
 # @in: options of the recording stream
 #
@@ -420,9 +382,7 @@
     '*out': 'AudiodevSdlPerDirectionOptions' } }
 
 ##
-# @AudiodevWavOptions:
-#
-# Options of the wav audio backend.
+# @AudiodevWavOptions: Options of the wav audio backend.
 #
 # @in: options of the capture stream
 #
@@ -439,9 +399,7 @@
     '*path': 'str' } }
 
 ##
-# @AudioFormat:
-#
-# An enumeration of possible audio formats.
+# @AudioFormat: An enumeration of possible audio formats.
 #
 # @u8: unsigned 8 bit integer
 #
@@ -463,9 +421,7 @@
   'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
 
 ##
-# @AudiodevDriver:
-#
-# An enumeration of possible audio backend drivers.
+# @AudiodevDriver: An enumeration of possible audio backend drivers.
 #
 # @jack: JACK audio backend (since 5.1)
 #
@@ -487,9 +443,7 @@
             'wav' ] }
 
 ##
-# @Audiodev:
-#
-# Options of an audio backend.
+# @Audiodev: Options of an audio backend.
 #
 # @id: identifier of the backend
 #
@@ -533,9 +487,7 @@
     'wav':       'AudiodevWavOptions' } }
 
 ##
-# @query-audiodevs:
-#
-# Return information about audiodev configuration
+# @query-audiodevs: Return information about audiodev configuration
 #
 # Since: 8.0
 ##
diff --git a/.editorconfig b/.editorconfig
index 258d41ab485..dcf8f6ded6d 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -47,6 +47,7 @@ emacs_mode = glsl
 [*.json]
 indent_style = space
 emacs_mode = python
+max_line_length = 70
 
 # by default follow QEMU's style
 [*.pl]
-- 
2.53.0



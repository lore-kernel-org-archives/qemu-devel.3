Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A858CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAaE-00089X-C6; Wed, 29 Apr 2026 15:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAZ9-0007DR-D7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAZ5-00080B-Fh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvQrrTZJip/bbrHJViDv7QteLJ2uq7tVJhjkIuaDuSk=;
 b=ZS7cNX8fSGRCd23T15k9CfdpWmCKWEMZBf7U5TS/oX76smRZ2C17wfP0aMjCUT7ol9/AO4
 y9UWo2l4az6xAdCfFVJWnQ6SwhKNXwEyC1My+QqrWy4Nf5Z9kCF7lOs7PbdFYRXd0h3Zi+
 8yf4nalHo5gYmuXqv71k9zaxvJpv524=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-dmwEv70RP6OK_uyN-fdJbw-1; Wed,
 29 Apr 2026 15:27:14 -0400
X-MC-Unique: dmwEv70RP6OK_uyN-fdJbw-1
X-Mimecast-MFC-AGG-ID: dmwEv70RP6OK_uyN-fdJbw_1777490833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E6371800352; Wed, 29 Apr 2026 19:27:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B75D1800446; Wed, 29 Apr 2026 19:27:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 13/13] rfc: intro starts on next line
Date: Wed, 29 Apr 2026 15:26:11 -0400
Message-ID: <20260429192611.1581223-14-jsnow@redhat.com>
In-Reply-To: <20260429192611.1581223-1-jsnow@redhat.com>
References: <20260429192611.1581223-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Revert some parser changes that had allowed the intro section to start
on the same line as the definition name. If we go this route, the
changes need to be back-squashed into earlier commits and the
qapi-code-gen.rst documentation needs to be rewritten and reworded a
little bit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py                  |  5 +-
 qapi/accelerator.json                   | 18 +++--
 qapi/acpi-hest.json                     |  5 +-
 qapi/acpi.json                          | 13 ++--
 qapi/audio.json                         | 88 ++++++++++++++++---------
 scripts/qapi/parser.py                  | 12 +---
 tests/qapi-schema/doc-missing-colon.err |  2 +-
 7 files changed, 86 insertions(+), 57 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 6b8e4ecd76a..985954164b0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -156,8 +156,9 @@ def add_lines(
         lines = content.splitlines(True)
 
         if dedent:
-            txt = "".join(lines[1:])
-            lines[1:] = textwrap.dedent(txt).splitlines(True)
+            lines = textwrap.dedent(content).splitlines(True)
+        else:
+            lines = content.splitlines(True)
 
         for i, line in enumerate(lines):
             self.add_line_raw(line, info.fname, info.line + i)
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 71047538ee1..05dbef51c5d 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -12,7 +12,8 @@
 { 'include': 'common.json' }
 
 ##
-# @KvmInfo: Information about support for KVM acceleration
+# @KvmInfo:
+#     Information about support for KVM acceleration
 #
 # @enabled: true if KVM acceleration is active
 #
@@ -23,7 +24,8 @@
 { 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
 
 ##
-# @query-kvm: Return information about KVM acceleration
+# @query-kvm:
+#     Return information about KVM acceleration
 #
 # Since: 0.14
 #
@@ -35,7 +37,8 @@
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
 
 ##
-# @x-accel-stats: Query accelerator statistics
+# @x-accel-stats:
+#     Query accelerator statistics
 #
 # Features:
 #
@@ -50,7 +53,8 @@
   'features': [ 'unstable' ] }
 
 ##
-# @Accelerator: Information about support for MSHV acceleration
+# @Accelerator:
+#     Information about support for MSHV acceleration
 #
 # @hvf: Apple Hypervisor.framework
 #
@@ -73,7 +77,8 @@
 { 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm', 'qtest', 'tcg', 'whpx', 'xen'] }
 
 ##
-# @AcceleratorInfo: Information about support for various accelerators
+# @AcceleratorInfo:
+#     Information about support for various accelerators
 #
 # @enabled: the accelerator that is in use
 #
@@ -85,7 +90,8 @@
 { 'struct': 'AcceleratorInfo', 'data': {'enabled': 'Accelerator', 'present': ['Accelerator']} }
 
 ##
-# @query-accelerators: Return information about accelerators
+# @query-accelerators:
+#     Return information about accelerators
 #
 # Returns: @AcceleratorInfo
 #
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
index 6a48e80082e..8db804df197 100644
--- a/qapi/acpi-hest.json
+++ b/qapi/acpi-hest.json
@@ -12,8 +12,9 @@
 ##
 
 ##
-# @inject-ghes-v2-error: Inject an error with additional ACPI 6.1
-#     GHESv2 error information
+# @inject-ghes-v2-error:
+#     Inject an error with additional ACPI 6.1 GHESv2 error
+#     information
 #
 # @cper: contains a base64 encoded string with raw data for a single
 #     CPER record with Generic Error Status Block, Generic Error Data
diff --git a/qapi/acpi.json b/qapi/acpi.json
index ea6ad2cd45f..82e82d7cf89 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -12,8 +12,8 @@
 ##
 
 ##
-# @AcpiTableOptions: Specify an ACPI table on the
-#     command line to load.
+# @AcpiTableOptions:
+#     Specify an ACPI table on the command line to load.
 #
 # At most one of @file and @data can be specified.  The list of files
 # specified by any one of them is loaded and concatenated in order.
@@ -79,7 +79,8 @@
 { 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
 
 ##
-# @ACPIOSTInfo: OSPM Status Indication for a device.  For description
+# @ACPIOSTInfo:
+#     OSPM Status Indication for a device.  For description
 #     of possible values of @source and @status fields see "_OST (OSPM
 #     Status Indication)" chapter of ACPI5.0 spec.
 #
@@ -103,7 +104,8 @@
               'status': 'int' } }
 
 ##
-# @query-acpi-ospm-status: Return a list of `ACPIOSTInfo` for devices
+# @query-acpi-ospm-status:
+#     Return a list of `ACPIOSTInfo` for devices
 #     that support status reporting via ACPI _OST method.
 #
 # Since: 2.1
@@ -120,7 +122,8 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
 
 ##
-# @ACPI_DEVICE_OST: Emitted when guest executes ACPI _OST method.
+# @ACPI_DEVICE_OST:
+#     Emitted when guest executes ACPI _OST method.
 #
 # @info: OSPM Status Indication
 #
diff --git a/qapi/audio.json b/qapi/audio.json
index 62d64eabf1c..72190f20993 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -13,8 +13,9 @@
 ##
 
 ##
-# @AudiodevPerDirectionOptions: General audio backend options that are
-#     used for both playback and recording.
+# @AudiodevPerDirectionOptions:
+#     General audio backend options that are used for both playback
+#     and recording.
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
@@ -50,7 +51,8 @@
     '*buffer-length':  'uint32' } }
 
 ##
-# @AudiodevGenericOptions: Generic driver-specific options.
+# @AudiodevGenericOptions:
+#     Generic driver-specific options.
 #
 # @in: options of the capture stream
 #
@@ -64,7 +66,8 @@
     '*out': 'AudiodevPerDirectionOptions' } }
 
 ##
-# @AudiodevDBusOptions: Options of the D-Bus audio backend.
+# @AudiodevDBusOptions:
+#     Options of the D-Bus audio backend.
 #
 # @in: options of the capture stream
 #
@@ -82,8 +85,9 @@
     '*nsamples': 'uint32'} }
 
 ##
-# @AudiodevAlsaPerDirectionOptions: Options of the ALSA backend that
-#     are used for both playback and recording.
+# @AudiodevAlsaPerDirectionOptions:
+#     Options of the ALSA backend that are used for both playback and
+#     recording.
 #
 # @dev: the name of the ALSA device to use (default 'default')
 #
@@ -102,7 +106,8 @@
     '*try-poll':      'bool' } }
 
 ##
-# @AudiodevAlsaOptions: Options of the ALSA audio backend.
+# @AudiodevAlsaOptions:
+#     Options of the ALSA audio backend.
 #
 # @in: options of the capture stream
 #
@@ -119,7 +124,8 @@
     '*threshold': 'uint32' } }
 
 ##
-# @AudiodevSndioOptions: Options of the sndio audio backend.
+# @AudiodevSndioOptions:
+#     Options of the sndio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -139,8 +145,9 @@
     '*latency':   'uint32'} }
 
 ##
-# @AudiodevCoreaudioPerDirectionOptions: Options of the Core Audio
-#     backend that are used for both playback and recording.
+# @AudiodevCoreaudioPerDirectionOptions:
+#     Options of the Core Audio backend that are used for both
+#     playback and recording.
 #
 # @buffer-count: number of buffers
 #
@@ -152,7 +159,8 @@
     '*buffer-count': 'uint32' } }
 
 ##
-# @AudiodevCoreaudioOptions: Options of the coreaudio audio backend.
+# @AudiodevCoreaudioOptions:
+#     Options of the coreaudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -166,7 +174,8 @@
     '*out': 'AudiodevCoreaudioPerDirectionOptions' } }
 
 ##
-# @AudiodevDsoundOptions: Options of the DirectSound audio backend.
+# @AudiodevDsoundOptions:
+#     Options of the DirectSound audio backend.
 #
 # @in: options of the capture stream
 #
@@ -184,8 +193,9 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevJackPerDirectionOptions: Options of the JACK backend that
-#     are used for both playback and recording.
+# @AudiodevJackPerDirectionOptions:
+#     Options of the JACK backend that are used for both playback and
+#     recording.
 #
 # @server-name: select from among several possible concurrent server
 #     instances (default: environment variable $JACK_DEFAULT_SERVER if
@@ -216,7 +226,8 @@
     '*exact-name':    'bool' } }
 
 ##
-# @AudiodevJackOptions: Options of the JACK audio backend.
+# @AudiodevJackOptions:
+#     Options of the JACK audio backend.
 #
 # @in: options of the capture stream
 #
@@ -230,8 +241,9 @@
     '*out': 'AudiodevJackPerDirectionOptions' } }
 
 ##
-# @AudiodevOssPerDirectionOptions: Options of the OSS backend that are
-#     used for both playback and recording.
+# @AudiodevOssPerDirectionOptions:
+#     Options of the OSS backend that are used for both playback and
+#     recording.
 #
 # @dev: file name of the OSS device (default '/dev/dsp')
 #
@@ -250,7 +262,8 @@
     '*try-poll':     'bool' } }
 
 ##
-# @AudiodevOssOptions: Options of the OSS audio backend.
+# @AudiodevOssOptions:
+#     Options of the OSS audio backend.
 #
 # @in: options of the capture stream
 #
@@ -278,8 +291,9 @@
     '*dsp-policy': 'uint32' } }
 
 ##
-# @AudiodevPaPerDirectionOptions: Options of the Pulseaudio backend
-#     that are used for both playback and recording.
+# @AudiodevPaPerDirectionOptions:
+#     Options of the Pulseaudio backend that are used for both
+#     playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -301,7 +315,8 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevPaOptions: Options of the PulseAudio audio backend.
+# @AudiodevPaOptions:
+#     Options of the PulseAudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -318,8 +333,9 @@
     '*server': 'str' } }
 
 ##
-# @AudiodevPipewirePerDirectionOptions: Options of the PipeWire
-#     backend that are used for both playback and recording.
+# @AudiodevPipewirePerDirectionOptions:
+#     Options of the PipeWire backend that are used for both playback
+#     and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -341,7 +357,8 @@
     '*latency': 'uint32' } }
 
 ##
-# @AudiodevPipewireOptions: Options of the PipeWire audio backend.
+# @AudiodevPipewireOptions:
+#     Options of the PipeWire audio backend.
 #
 # @in: options of the capture stream
 #
@@ -355,8 +372,9 @@
     '*out':    'AudiodevPipewirePerDirectionOptions' } }
 
 ##
-# @AudiodevSdlPerDirectionOptions: Options of the SDL audio backend
-#     that are used for both playback and recording.
+# @AudiodevSdlPerDirectionOptions:
+#     Options of the SDL audio backend that are used for both playback
+#     and recording.
 #
 # @buffer-count: number of buffers (default 4)
 #
@@ -368,7 +386,8 @@
     '*buffer-count': 'uint32' } }
 
 ##
-# @AudiodevSdlOptions: Options of the SDL audio backend.
+# @AudiodevSdlOptions:
+#     Options of the SDL audio backend.
 #
 # @in: options of the recording stream
 #
@@ -382,7 +401,8 @@
     '*out': 'AudiodevSdlPerDirectionOptions' } }
 
 ##
-# @AudiodevWavOptions: Options of the wav audio backend.
+# @AudiodevWavOptions:
+#     Options of the wav audio backend.
 #
 # @in: options of the capture stream
 #
@@ -399,7 +419,8 @@
     '*path': 'str' } }
 
 ##
-# @AudioFormat: An enumeration of possible audio formats.
+# @AudioFormat:
+#     An enumeration of possible audio formats.
 #
 # @u8: unsigned 8 bit integer
 #
@@ -421,7 +442,8 @@
   'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
 
 ##
-# @AudiodevDriver: An enumeration of possible audio backend drivers.
+# @AudiodevDriver:
+#     An enumeration of possible audio backend drivers.
 #
 # @jack: JACK audio backend (since 5.1)
 #
@@ -443,7 +465,8 @@
             'wav' ] }
 
 ##
-# @Audiodev: Options of an audio backend.
+# @Audiodev:
+#     Options of an audio backend.
 #
 # @id: identifier of the backend
 #
@@ -487,7 +510,8 @@
     'wav':       'AudiodevWavOptions' } }
 
 ##
-# @query-audiodevs: Return information about audiodev configuration
+# @query-audiodevs:
+#     Return information about audiodev configuration
 #
 # Since: 8.0
 ##
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c23fd26aaa7..8ff2a2c4c0b 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -530,23 +530,17 @@ def _get_doc_intro(
         line: str,
         info: QAPISourceInfo
     ) -> Tuple['QAPIDoc', Optional[str]]:
-        match = self._match_at_name_colon(line)
-        if not match:
-            raise QAPIParseError(self, "@name must end with ':'")
+        if not line.endswith(':'):
+            raise QAPIParseError(self, "line should end with ':'")
 
         # Invalid names are not checked here, but the name
         # provided *must* match the following definition,
         # which *is* validated in expr.py.
-        symbol = match.group(1)
+        symbol = line[1:-1]
         if not symbol:
             raise QAPIParseError(self, "name required after '@'")
         doc = QAPIDoc(info, symbol)
-
         doc.ensure_untagged_section(info, QAPIDoc.Kind.INTRO)
-        text = line[match.end():]
-        if text:
-            doc.append_line(text)
-
         return doc, self.get_doc_indented(doc)
 
     def get_doc(self) -> 'QAPIDoc':
diff --git a/tests/qapi-schema/doc-missing-colon.err b/tests/qapi-schema/doc-missing-colon.err
index bd5862b30f3..cbcea007153 100644
--- a/tests/qapi-schema/doc-missing-colon.err
+++ b/tests/qapi-schema/doc-missing-colon.err
@@ -1 +1 @@
-doc-missing-colon.json:4:1: @name must end with ':'
+doc-missing-colon.json:4:1: line should end with ':'
-- 
2.54.0



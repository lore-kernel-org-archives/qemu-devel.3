Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F15E83857
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcs-0002ck-Mo; Tue, 17 Feb 2026 00:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDco-0002bI-0e
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:54 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcm-0006cm-5y
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:53 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E90A78852A;
 Tue, 17 Feb 2026 08:27:50 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-BEQR34Gh; 
 Tue, 17 Feb 2026 08:27:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306070;
 bh=cW96GpRtxrwmpHjA3rFfk5LGg/7cNAQbpRSdRXk6Veo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=B6yNRU49+hngQyNX40/rrbl+kLZgpYohiOF6T4KqYn4Kr/dXS6Dt1d35WHr/Hqo+c
 VzuEGXtkuNzGCr0rBs//lq4FIblA/mCwQQowuFfnmYh8yOmfSocB30X5HnwaC/WSDk
 UxcVHRtLktGSjaMGckLcigkrHY25zTepq2aq+tww=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 8/8] meson.build: ignore audio drivers when configured with
 --disable-audio
Date: Tue, 17 Feb 2026 10:27:40 +0500
Message-Id: <20260217052740.114117-9-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When QEMU is configured with `--disable-audio`, we do not need to add the
audio drivers list to config_host_data. We also do not need to print this
list.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 meson.build | 80 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/meson.build b/meson.build
index 69aa7cd189..a1224c9695 100644
--- a/meson.build
+++ b/meson.build
@@ -2266,46 +2266,55 @@ endif
 config_host_data = configuration_data()
 
 config_host_data.set('CONFIG_HAVE_RUST', have_rust)
-audio_drivers_selected = []
-if have_system
-  audio_drivers_available = {
-    'alsa': alsa.found(),
-    'coreaudio': coreaudio.found(),
-    'dsound': dsound.found(),
-    'jack': jack.found(),
-    'oss': oss.found(),
-    'pa': pulse.found(),
-    'pipewire': pipewire.found(),
-    'sdl': sdl.found(),
-    'sndio': sndio.found(),
-  }
-  foreach k, v: audio_drivers_available
-    config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
-  endforeach
+config_host_data.set('CONFIG_AUDIO', audio_enabled)
+if audio_enabled
+  audio_drivers_selected = []
+  if have_system
+    audio_drivers_available = {
+      'alsa': alsa.found(),
+      'coreaudio': coreaudio.found(),
+      'dsound': dsound.found(),
+      'jack': jack.found(),
+      'oss': oss.found(),
+      'pa': pulse.found(),
+      'pipewire': pipewire.found(),
+      'sdl': sdl.found(),
+      'sndio': sndio.found(),
+    }
+    foreach k, v: audio_drivers_available
+      config_host_data.set('CONFIG_AUDIO_' + k.to_upper(), v)
+    endforeach
 
-  # Default to native drivers first, OSS second, SDL third
-  audio_drivers_priority = \
-    [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
-    (host_os == 'linux' ? [] : [ 'sdl' ])
-  audio_drivers_default = []
-  foreach k: audio_drivers_priority
-    if audio_drivers_available[k]
-      audio_drivers_default += k
-    endif
-  endforeach
+    # Default to native drivers first, OSS second, SDL third
+    audio_drivers_priority = \
+      [ 'pa', 'coreaudio', 'dsound', 'sndio', 'oss' ] + \
+      (host_os == 'linux' ? [] : [ 'sdl' ])
+    audio_drivers_default = []
+    foreach k: audio_drivers_priority
+      if audio_drivers_available[k]
+        audio_drivers_default += k
+      endif
+    endforeach
 
+    foreach k: get_option('audio_drv_list')
+      if k == 'default'
+        audio_drivers_selected += audio_drivers_default
+      elif not audio_drivers_available[k]
+        error('Audio driver "@0@" not available.'.format(k))
+      else
+        audio_drivers_selected += k
+      endif
+    endforeach
+  endif
+  config_host_data.set('CONFIG_AUDIO_DRIVERS',
+                      '"' + '", "'.join(audio_drivers_selected) + '", ')
+else
   foreach k: get_option('audio_drv_list')
-    if k == 'default'
-      audio_drivers_selected += audio_drivers_default
-    elif not audio_drivers_available[k]
-      error('Audio driver "@0@" not available.'.format(k))
-    else
-      audio_drivers_selected += k
+    if k != 'default'
+      error('Audio drivers are not supported because audio is disabled.')
     endif
   endforeach
 endif
-config_host_data.set('CONFIG_AUDIO_DRIVERS',
-                     '"' + '", "'.join(audio_drivers_selected) + '", ')
 
 have_host_block_device = (host_os != 'darwin' or
     cc.has_header('IOKit/storage/IOMedia.h'))
@@ -4660,7 +4669,8 @@ if enable_modules
   summary_info += {'alternative module path': get_option('module_upgrades')}
 endif
 summary_info += {'fuzzing support':   get_option('fuzzing')}
-if have_system
+summary_info += {'Audio':             get_option('audio')}
+if have_system and audio_enabled
   summary_info += {'Audio drivers':     ' '.join(audio_drivers_selected)}
 endif
 summary_info += {'Trace backends':    ','.join(get_option('trace_backends'))}
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08EBC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErnz-0007Jq-NT; Wed, 05 Jun 2024 10:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sErny-0007JK-Pm
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:39:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sErnw-0003ih-LQ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:39:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35dc0472b7eso6069568f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717598394; x=1718203194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t9uNihjaM4RGHONIp4P8/zFJvF76snLskCcdhKmg4yM=;
 b=NTTEKLiALlsFaPRzha+woDJMUH6o66wMDNBn0T6RQptOfLA5FqhLbT78R4JgVVqGpw
 WuePp1FzUg7sGMwsww76PEwjfowzMCIFDgoNyCrMyds6OyoajkXWIG17EtRNTuTUfllc
 SdJHYjEhjQURigdCELKRrC8t77MPKoHZdRv+NJ+oXOPGwr6N3f1KZXigDhPBbrdWTxaw
 Nb+t6dqZLaF0ms3P5yUjxfcK+YLvmIWpLoh4KZ34pOQrytINAYFMrlIHSRCA9XE+fk2k
 pDsC7wUJjSEu2MEiL/hq7Azslyjo6EuKGxVJdXW0BQbEGBSuJj7Yrw6vdGSQoh2LecZm
 0uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598394; x=1718203194;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t9uNihjaM4RGHONIp4P8/zFJvF76snLskCcdhKmg4yM=;
 b=qqScJLUXfWnf35PREsIoh71GJrubhPNw0Cf8mujL9/N6DQieW383uVhGtUxVDEhkSr
 9YOsOVXY/CA/LWJaBp0cCLMOD3jHcy3BiQzPUbRYRi+Qt8TkUus1V/nzC6946LJ2JHcg
 yeA1ntn1XtxxxyHb/Eiz4rKLqt/lEKL84HAVsf7kVMPenAY6B9HGzgXGyopiV20TIRyb
 lIDaWaru3d4ynSX5JH5/hCUOcI52A7ecmdBCd2YWA1HOgN7R/Tko6dRdzBDAVIc4BpaG
 RJMsRDeEpBLRroi7dm/LR7QJkDjEEq8pyETkkb1crfOpNAbnivfyHSBKIGal9CM7YdsW
 VKPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/qsBllsGWQr2s24JjkN3Zm9t6yViKS8eO9LTIFDA809+hVri+4KhCBDABY5AaWnloMqHBgzlGsgJ4ttTRi3caymFMYNE=
X-Gm-Message-State: AOJu0YykyarslboTeT8G5i43mmwxnBIMsF25BBzVxe1YL7ExLY5rH3aG
 pKzdQBkxm8YaIAqki0588v5As30uBl8JjDCFNOyw+UiSCR+mVkqV32g2ILgfARw=
X-Google-Smtp-Source: AGHT+IFcIKIdeNX+Q06F/N+f405nFNBc3mNhYBPAHxwneshXBdEAuVQH4iZb8a5RLxQJBxbD+levfA==
X-Received: by 2002:adf:fa82:0:b0:357:dbf1:1d3b with SMTP id
 ffacd0b85a97d-35e8ef7f4e0mr2090766f8f.59.1717598394266; 
 Wed, 05 Jun 2024 07:39:54 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d96f6sm14889471f8f.61.2024.06.05.07.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:39:53 -0700 (PDT)
Date: Wed, 05 Jun 2024 17:32:14 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [RFC PATCH] subprojects: add a wrapper for libvirglrenderer
User-Agent: meli 0.8.5
References: <20240605133527.529950-1-alex.bennee@linaro.org>
In-Reply-To: <20240605133527.529950-1-alex.bennee@linaro.org>
Message-ID: <em3eg.b7wu81h9k9h@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 05 Jun 2024 16:35, Alex Bennée <alex.bennee@linaro.org> wrote:
>As the latest features for virtio-gpu need a pretty recent version of
>libvirglrenderer. When it is not available on the system we can use a
>meson wrapper and provide it when --download is specified in
>configure.
>
>We have to take some additional care as currently QEMU will hang
>libvirglrenderer fails to exec the render server. As the error isn't
>back propagated we make sure we at least test we have a path to an
>executable before tweaking the environment.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>---
> meson.build                    |  7 ++++++-
> hw/display/virtio-gpu-virgl.c  | 24 ++++++++++++++++++++++++
> subprojects/virglrenderer.wrap |  6 ++++++
> 3 files changed, 36 insertions(+), 1 deletion(-)
> create mode 100644 subprojects/virglrenderer.wrap
>
>diff --git a/meson.build b/meson.build
>index 1d7346b703..e4e270df78 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -1203,7 +1203,8 @@ have_vhost_user_gpu = have_tools and host_os == 'linux' and pixman.found()
> if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>   virgl = dependency('virglrenderer',
>                      method: 'pkg-config',
>-                     required: get_option('virglrenderer'))
>+                     required: get_option('virglrenderer'),
>+                     default_options: ['default_library=static', 'render-server=true', 'venus=true'])
> endif
> rutabaga = not_found
> if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
>@@ -2314,6 +2315,10 @@ if virgl.version().version_compare('>=1.0.0')
>   config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>   config_host_data.set('HAVE_VIRGL_VENUS', 1)
> endif
>+if virgl.type_name().contains('internal')
>+  config_host_data.set('HAVE_BUNDLED_VIRGL_SERVER', 1)
>+endif
>+
> config_host_data.set('CONFIG_VIRTFS', have_virtfs)
> config_host_data.set('CONFIG_VTE', vte.found())
> config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
>diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>index c9d20a8a60..53d6742e79 100644
>--- a/hw/display/virtio-gpu-virgl.c
>+++ b/hw/display/virtio-gpu-virgl.c
>@@ -14,6 +14,7 @@
> #include "qemu/osdep.h"
> #include "qemu/error-report.h"
> #include "qemu/iov.h"
>+#include "qemu/cutils.h"
> #include "trace.h"
> #include "hw/virtio/virtio.h"
> #include "hw/virtio/virtio-gpu.h"
>@@ -1122,6 +1123,26 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
>     virgl_renderer_reset();
> }
> 
>+/*
>+ * If we fail to spawn the render server things tend to hang so it is
>+ * important to do our due diligence before then. If QEMU has bundled
>+ * the virgl server we want to ensure we can run it from the build
>+ * directory and if installed.
>+ *
>+ * The principle way we can override the libvirglrenders behaviour is
>+ * by setting environment variables.
>+ */
>+static void virgl_set_render_env(void)
>+{

Since it's a few lines we could also inline this in 
virtio_gpu_virgl_init()

>+#ifdef HAVE_BUNDLED_VIRGL_SERVER
>+    g_autofree char *file = get_relocated_path(CONFIG_QEMU_HELPERDIR "/virgl_render_server");
>+    if (g_file_test(file, G_FILE_TEST_EXISTS | G_FILE_TEST_IS_EXECUTABLE)) {
>+        g_setenv("RENDER_SERVER_EXEC_PATH", file, false);


  Return value

  Type: gboolean

  FALSE if the environment variable couldn’t be set.

Worth adding a check here.

Offtopic, but it feels weird to set our environment without creating the 
process ourselves.

There's also an option to launch the server in threads, so that if it 
crashes it pulls qemu down with it. Would that work with our thread 
setup?


>+    }
>+#endif
>+}
>+
>+
> int virtio_gpu_virgl_init(VirtIOGPU *g)
> {
>     int ret;
>@@ -1145,6 +1166,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>     }
> #endif
> 
>+    /* Ensure we can find the render server */
>+    virgl_set_render_env();
>+
>     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>     if (ret != 0) {
>         error_report("virgl could not be initialized: %d", ret);
>diff --git a/subprojects/virglrenderer.wrap b/subprojects/virglrenderer.wrap
>new file mode 100644
>index 0000000000..3656a478c4
>--- /dev/null
>+++ b/subprojects/virglrenderer.wrap
>@@ -0,0 +1,6 @@
>+[wrap-git]
>+url = https://gitlab.freedesktop.org/virgl/virglrenderer.git
>+revision = virglrenderer-1.0.1


Can we say "at least 1.0.1" here? Should we? Dunno.

>+
>+[provide]
>+virglrenderer = libvirglrenderer_dep
>-- 
>2.39.2
>


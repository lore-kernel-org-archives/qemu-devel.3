Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF78C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsW-0007zH-Te; Thu, 15 Aug 2024 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsV-0007vB-TK
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:51 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsU-0002D7-2G
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:51 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8385f38fcdso44073466b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722168; x=1724326968; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NLQUtwlH5ru+31+0LhHDTaTOLuXgK1ZwJpwr1P2FRCY=;
 b=CpRePxwG7U36K3cDowN6uQ3w+sIuOE2KGAfuZshrUmcXaSCX1VOSoMssyn2Qcnslso
 rWZumGy8ykwFIKqNiMUW7/OuSCL+/roReYaMgh/NUwEgp5DavkRh00i1Yaz/npzngETK
 qo7AqmLBFobiNx052bkAOka3IPCFSXiD/VI3RhMRNF/XtgdRabG254z54zuDgQJO+HfI
 aoNXuYRO0bjLL+g2Nk/gHhbx7zl0+XAQe+c0KZzQk8jhlA5h3q9Ue8np7xsB4R+iG/xi
 8Oh1lDd0+TiEGMa7ciahwn4nsSFLO0ZObuxTAVV+2w0R2goI20wMJ8WCnM0ehB9w8yfi
 IOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722168; x=1724326968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLQUtwlH5ru+31+0LhHDTaTOLuXgK1ZwJpwr1P2FRCY=;
 b=f4N1UpRQRuLHZS80NkhXjcTcYpFHfXF9/ktqMYyBzPHwP76DzN69YTlWHv32TQ1ORY
 Iuw35V9MFXiM46DSSS1D9ODsQF6SccmEwRNkOgq4pUBYWpa1QSEHn64l7xemWGaBm+u+
 3uv9HHUf9RFKliyi/l33TdXhd2nS7vvcW1fSq2prgvPxrkg3PxezfUSsbArq+sqJjoWn
 GHiehB2BCChOVSdTlPfDOJr84GbF68M+/HJDnypUSX4CoW44iuBCYsCMM0Wu1Ui5Ruyn
 cmRVB9r9u8iknc8xTL+XS4oK+cZOwYFMO0XLGi3JUVYuAsCpe8iq7j8BjnhjYFSMHqAr
 CStQ==
X-Gm-Message-State: AOJu0YwtVcM3xYZ1c4j2qsOs9oX/A13pREIZQHZ8Aeu553Bp4G4ir8gS
 FuHoAnBHzesHxehcCoPGdafrKTxUW2iwftshWMM9ADO2TQ6AVjL2mE/y7hEu8bc=
X-Google-Smtp-Source: AGHT+IERsraj+SrcVseP+cgiZcrfAHCBR4dNRpY3FpMeC3WLEio67G4chgDg13MNW0jagopDpKXJsw==
X-Received: by 2002:a17:907:1b0d:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a83663fa418mr387411266b.0.1723722168285; 
 Thu, 15 Aug 2024 04:42:48 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:19 +0300
Subject: [PATCH v7 2/7] build-sys: Add rust feature option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-rust-pl011-v7-2-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5382;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=BxaqJcEWLkToyju8S1kw437QUrcpEwLDC4lAb4m/ZVA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW11ZlNNdEVGMVkrQjIraDk0K2UrbmpHSVFzCitUQk9QSWR4WTBkWWxJbzg1
 NmFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJnQUt
 DUkIzS2Nkd2YzNEowRVhaRC80NUdlWmJVT2VHS0RpMWtMSVhuSndPWVBKYjM0SHhVbVd3cVNxRA
 pJRmVDU0dxbzdnQndRSWRPaEpBVVJLOGZONkU1VXl3NHAvQzdnTjliV3dkZXUrNnB2N0JjTlVXT
 2RVTWhhcERPCi93SGY3Mi9HckdXWUpNK2RMaGprbkRTM2tsZDZYSW04cVkvTHlyelF6dWNTd0h6
 UWwraE5vODVuYmk3SVdkRmEKbllYRTdET3pSbU0yTm56K1E3QktobHYxOHRtR0sxUSs0TUlRRGJ
 wdFBsYitPdXJIKzlpZExEU1cvbmZVUHprOQpTZ29DUGlEbk54c3BENi9vRGhVbCtua3J0Nnh5SF
 BZMzk1Y2Z2NXRyOU8zbkdDYnQ5dXF0cnpHMnFxV1VPM0FvCnJCaVRuRWtxa21FVVVsOTNFU0lVK
 2w2VXY2M0Ftd1RoaWxXMVEvbnlCRkNOUUswNFpQLzFhdStyb2hjYnNheTIKUzhMTWZjcUxKRmpS
 VlNVQ3R2MUhiRDJQbjk3dGdIeFdUaGI3dHZCNUxCTFV3bE1Ea2tCWkxjbTJWQVJ3VEoxUwo3MU4
 vTGRQSS8vVWhmZHdYQjBVRjhCTWxEWTc3b2RYMHFZYVZxcW5rSFBJcVowbi8yaDYrbnZ4b3FCTn
 pXM2k1CnFXZUNyUG9TaEhDZVpoTnFBMFZ5U29OR2UzMjlqN2JOeWR5WUttTTNEQjVnZ0VhS3R5O
 WhjbnZZVkR4U1lTS1EKcklHL2VJVnBGdTRTc2pYSy83TmM3dkUxWGhHQmJtR05RZE11RU42VDlt
 aDZtQU1mbWRjWjdIc01menhtYXR4VgozWlhTOW9MTDIrbThYMnJrc1o5ajM5OTlxWlNnbVJmcUk
 yMkdkRndObjg5MUlKTlpCNlFwenVLSVpmdWJPc2RuCjJKbHFJQT09Cj1nMGhQCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add rust feature in meson.build, configure, to prepare for adding Rust
code in the followup commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                   |  5 +++++
 meson.build                   | 25 ++++++++++++++++++++++++-
 Kconfig                       |  1 +
 Kconfig.host                  |  3 +++
 meson_options.txt             |  3 +++
 rust/Kconfig                  |  0
 scripts/meson-buildoptions.sh |  3 +++
 7 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6..0bc8e515da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4243,6 +4243,11 @@ F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 
+Rust build system integration
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/Kconfig
+
 Miscellaneous
 -------------
 Performance Tools and Tests
diff --git a/meson.build b/meson.build
index 7eb4b8a41c..67eb4eda64 100644
--- a/meson.build
+++ b/meson.build
@@ -70,6 +70,22 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
+if get_option('rust').enabled() and meson.version().version_compare('<1.0.0')
+  error('Rust support requires Meson version >=1.0.0')
+endif
+have_rust = false
+if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false)
+  rustc = meson.get_compiler('rust')
+  have_rust = true
+  if rustc.version().version_compare('<1.80.0')
+    if get_option('rust').enabled()
+      error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.80.0')
+    else
+      warning('rustc version ' + rustc.version() + ' is unsupported: Disabling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      have_rust = false
+    endif
+  endif
+endif
 
 dtrace = not_found
 stap = not_found
@@ -2131,6 +2147,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -3076,7 +3093,8 @@ host_kconfig = \
   (host_os == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : []) + \
-  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : [])
+  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
+  (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
@@ -4287,6 +4305,11 @@ if 'objc' in all_languages
 else
   summary_info += {'Objective-C compiler': false}
 endif
+summary_info += {'Rust support':      have_rust}
+if have_rust
+  summary_info += {'rustc version':      rustc.version()}
+  summary_info += {'rustc':      ' '.join(rustc.cmd_array())}
+endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/Kconfig b/Kconfig
index fb6a24a2de..63ca7f46df 100644
--- a/Kconfig
+++ b/Kconfig
@@ -4,3 +4,4 @@ source accel/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
+source rust/Kconfig
diff --git a/Kconfig.host b/Kconfig.host
index 17f405004b..4ade7899d6 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -52,3 +52,6 @@ config VFIO_USER_SERVER_ALLOWED
 
 config HV_BALLOON_POSSIBLE
     bool
+
+config HAVE_RUST
+    bool
diff --git a/meson_options.txt b/meson_options.txt
index 0269fa0f16..fa94a5ce97 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -371,3 +371,6 @@ option('hexagon_idef_parser', type : 'boolean', value : true,
 
 option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value: '1',
        description: 'tweak required x86_64 architecture version beyond compiler default')
+
+option('rust', type: 'feature', value: 'auto',
+       description: 'Rust support')
diff --git a/rust/Kconfig b/rust/Kconfig
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c97079a38c..5e8a225a6b 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -170,6 +170,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rust            Rust support'
   printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
@@ -452,6 +453,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rust) printf "%s" -Drust=enabled ;;
+    --disable-rust) printf "%s" -Drust=disabled ;;
     --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
     --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;

-- 
2.44.0



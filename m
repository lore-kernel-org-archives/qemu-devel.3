Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DEBC5478C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdt9R-0007Ia-K4; Sat, 24 Feb 2024 09:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9P-0007FO-DW
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:15 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9M-0000Ri-S5
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:15 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e459b39e2cso853553b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708785311; x=1709390111;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wkSK7HMotGBnad3jfIz/xzrfOJ05rzsV8RJd/Voy6w=;
 b=l1E/+mw4IMe9Z7vTH8MV890Yaa8H8flemSLA+g4oAoK9KcJJ5hrj4qSMbXNm70LMMN
 57XUXKXMHiFTxmuMYcqVM08Lvsuv/uFKVNRRrmEQQNWbPtcX4cdSGUwbb3C9TCRKmThi
 lqtPQhEBjOHMsgHLxpXsKcbcEJRJpgYSKwaUf5uGzXDDdT5cOLUS2HbC4hOt6+yLjLck
 ScqrjwB/dNWL1LwTQZemIicqMs19Y15+rSlYfx6+UbFI/hvBYsuiglJ3H36PanZRc2PS
 PF1z0P58aweiCl0CnQK/aiQ/XhocKLgK7gTOpz/jhjkwAiCfr8DeqSxusSdqXFRB2Bs4
 o52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708785311; x=1709390111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wkSK7HMotGBnad3jfIz/xzrfOJ05rzsV8RJd/Voy6w=;
 b=URBRaO8bFz0z16N3oXcSTpgslUrC+pYDsK49wZ9/xXGS0UVzFY2GfxPHGRL4V/kBWI
 ZFJsCyJICy1F8WGPNGHPCtO8HHRVPVWntM0/zQvW1V0ES+1WWa0uAvezPSoTC8zx9FfQ
 wZ71zA3f1VMHi64m6d7HW643LTe0lfNOPhEIdO6HHg+ICJeyAuXUueqYGUHh+VCvOeT0
 Qeov2z6SRMNayRu/ynOVCkMBQjnhfkESSJqoaK+KO5y4NXdVeHzQ+TsyW5RqBUHmYZXf
 rc5nthty3tw5Fw+0tYywHtK5qM02tQeC+LZgjNXpbQRb6aBYP+KZyr3McSfpdCgJFv1q
 Sang==
X-Gm-Message-State: AOJu0Yx0XaerwNPmy0EGW9AywVK/ihNUNgzfCAWc6qqUERF8RlZBcxV0
 0UT5unPAwV5tan9eQRQ0s0mT0oUf/Dhwr+OAOhuRTWaYfaOra/Ex/dstMfeAoAxEeT4tyNoH88Z
 pgXMu/g==
X-Google-Smtp-Source: AGHT+IHjTmh4tUEesL/iokZqtDaWqL4Yq1S221nIfW4osbvJZjQAsDG3I8hY6h2fG55Kzibe0P5/1Q==
X-Received: by 2002:a05:6a20:d492:b0:19e:4ab2:c362 with SMTP id
 im18-20020a056a20d49200b0019e4ab2c362mr4050102pzb.14.1708785310283; 
 Sat, 24 Feb 2024 06:35:10 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a632356000000b005dc49afed53sm1181887pgm.55.2024.02.24.06.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 06:35:09 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 yong.huang@smartx.com
Subject: [PATCH RFC 2/3] meson.build: Support GM/T 0018-2012 cryptographic
 standard
Date: Sat, 24 Feb 2024 22:34:57 +0800
Message-Id: <0623bdfb2ea1bdb66b2a6d67cf014ab721cd227a.1708527979.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708527979.git.yong.huang@smartx.com>
References: <cover.1708527979.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

GM/T 0018-2012 is a cryptographic standard issued by the State
Cryptography Administration of China.

The implement of the standard could support symmetric cipher
algorithm for block encryption. SM4 cipher algorithms could be
applied currently, so detect SM4 cipher algorithms via GM/T
0018-2012 API and enable the feature if crypto-gmt is given
explictly. This feature defaults to disabled.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/meson.build            |  3 +++
 meson.build                   | 30 ++++++++++++++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 38 insertions(+)

diff --git a/crypto/meson.build b/crypto/meson.build
index c46f9c22a7..dd49d03780 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -46,6 +46,9 @@ endif
 if have_afalg
   crypto_ss.add(if_true: files('afalg.c', 'cipher-afalg.c', 'hash-afalg.c'))
 endif
+if gmt_0018_2012.found()
+  crypto_ss.add(gmt_0018_2012, files('cipher-gmt.c'))
+endif
 
 system_ss.add(when: gnutls, if_true: files('tls-cipher-suites.c'))
 
diff --git a/meson.build b/meson.build
index c1dc83e4c0..cd188582b5 100644
--- a/meson.build
+++ b/meson.build
@@ -1693,6 +1693,34 @@ if not gnutls_crypto.found()
   endif
 endif
 
+if get_option('crypto_gmt').enabled() and get_option('crypto_afalg').enabled()
+  error('Only one of GM/T 0018-2012 & afalg can be enabled')
+endif
+
+gmt_0018_2012 = not_found
+if (not get_option('crypto_gmt').auto() or have_system)
+  gmt_0018_2012 = cc.find_library('gmt_0018_2012', has_headers: ['gmt-0018-2012.h'],
+                                  required: get_option('crypto_gmt'))
+  if gmt_0018_2012.found() and not cc.links('''
+    #include <stddef.h>
+    #include <gmt-0018-2012.h>
+    int main(void) {
+      unsigned char iv[16] = {0};
+      unsigned char plainData[16] = {0};
+      unsigned char cipherData[16] = {0};
+      unsigned int rlen;
+      SDF_Encrypt(NULL, NULL, SGD_SM4_ECB, iv, plainData, 16, cipherData, &rlen);
+      return 0;
+    }''', dependencies: gmt_0018_2012)
+    gmt_0018_2012 = not_found
+    if get_option('crypto_gmt').enabled()
+      error('could not link gmt_0018_2012')
+    else
+      warning('could not link gmt_0018_2012, disabling')
+    endif
+  endif
+endif
+
 capstone = not_found
 if not get_option('capstone').auto() or have_system or have_user
   capstone = dependency('capstone', version: '>=3.0.5',
@@ -2291,6 +2319,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
+config_host_data.set('CONFIG_GMT_0018_2012', gmt_0018_2012.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
@@ -4333,6 +4362,7 @@ if nettle.found()
 endif
 summary_info += {'SM4 ALG support':   crypto_sm4}
 summary_info += {'AF_ALG support':    have_afalg}
+summary_info += {'GM/T 0018-2012 support': gmt_0018_2012.found()}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
 summary_info += {'Linux keyutils':    keyutils}
diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec..4f35d3d62d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -174,6 +174,8 @@ option('gcrypt', type : 'feature', value : 'auto',
        description: 'libgcrypt cryptography support')
 option('crypto_afalg', type : 'feature', value : 'disabled',
        description: 'Linux AF_ALG crypto backend driver')
+option('crypto_gmt', type : 'feature', value : 'disabled',
+       description: 'GM/T 0018-2012 cryptographic standard driver')
 option('libdaxctl', type : 'feature', value : 'auto',
        description: 'libdaxctl support')
 option('libpmem', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..e116e7b9ed 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -106,6 +106,7 @@ meson_options_help() {
   printf "%s\n" '  colo-proxy      colo-proxy support'
   printf "%s\n" '  coreaudio       CoreAudio sound support'
   printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
+  printf "%s\n" '  crypto-gmt      GM/T 0018-2012 crypto backend driver'
   printf "%s\n" '  curl            CURL block device driver'
   printf "%s\n" '  curses          curses UI'
   printf "%s\n" '  dbus-display    -display dbus support'
@@ -282,6 +283,8 @@ _meson_option_parse() {
     --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=false ;;
     --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=enabled ;;
     --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=disabled ;;
+    --enable-crypto-gmt) printf "%s" -Dcrypto_gmt=enabled ;;
+    --disable-crypto-gmt) printf "%s" -Dcrypto_gmt=disabled ;;
     --enable-curl) printf "%s" -Dcurl=enabled ;;
     --disable-curl) printf "%s" -Dcurl=disabled ;;
     --enable-curses) printf "%s" -Dcurses=enabled ;;
-- 
2.39.3



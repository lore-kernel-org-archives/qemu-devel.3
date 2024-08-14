Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C134FC52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 23:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seNYB-00024M-56; Wed, 14 Aug 2024 19:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY8-0001uI-Ly
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seNY6-0006Ws-Rt
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 19:37:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso273299b3a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723678621; x=1724283421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88ldzGJFn7KJzwoVt5WZkhf1Vk0R2+WAedFjkHAyIrQ=;
 b=K48EKCOZiqaOEnnrsAxehpKQQee4Xd53aDD8XexaqAVE4E3n2RN9B102AMf/wv+zrL
 eHpSpbNr2T9heS/H8YQc0JXGsXc3bqF7mxXfn5jYyPSuqwQBjWiKPuz64nHRWALfyCa+
 coFvQ5bYcCCdyO8+mMdI83stQTrPvOV5Ll4Hwt5gzOTUpqKHh1yvBnLHs6wk+0pIfH8O
 pVVArkbkMJVwicQDt7kro+6RQit464eUnn5NMTilI4SAN1TyRAqv2lIhiqRtoPThQY13
 wX21eA9IYjVPiv3VSH/PbV0JyIsZ2kP6NUxBF4GaSKD6B2eLoEepKrGoYwiQrVoZp2DM
 PNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723678621; x=1724283421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88ldzGJFn7KJzwoVt5WZkhf1Vk0R2+WAedFjkHAyIrQ=;
 b=hW3JorGDnA5z23NTW9mjjA5dli3kM/XS5G74DX7QQ17jmhCl5eokPfaJ9E9vAdW9vS
 zd4JuGYkBqGuhz5/M9N0IzhgbEB29T5ybN7BZugbzOFWdmFCNso4NQScky0fisGsoeuM
 VWCedHwPi9zVu0/zX0i1x2HQAix601xHyCwCQNX2BO8V1A5gIo82EqW5ex0daupgTsZN
 b6fstnDx8uI+ONpbPTT2y1owYbNQR9xC0e0q9h2M+Qsm85zr7nB/0mu6eMjWm0pEFbIT
 aVhIgmh0C7jMPIMImh4kz3sKUgbHqSPQjNq2F29dLSFAk5FsBZe5oVL7SsTwmhA5Asnv
 FZXQ==
X-Gm-Message-State: AOJu0YzRAxqNbO+EoVCGt7lYX9JXfOiaA/h1eTmFQp75BbI/3Urbi1MY
 oN3BexRu4UuOXpWBfzI2i7NmTYztIvIBBfLNB2ddKnoYMrUsSWJMhKQiqbgmle2C6yQJZXXE127
 W/vI=
X-Google-Smtp-Source: AGHT+IHTpXB1r7SxrWpLyZCf18ZQfm08NLcPLsgct9EyGMm8FW1vHPtTpw424UztofHbop/0WqlDww==
X-Received: by 2002:a05:6a20:85af:b0:1c8:de01:e7e5 with SMTP id
 adf61e73a8af0-1c8f85c7766mr1325780637.15.1723678621299; 
 Wed, 14 Aug 2024 16:37:01 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef57dfsm112164b3a.115.2024.08.14.16.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 16:37:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] contrib/plugins: remove Makefile for contrib/plugins
Date: Wed, 14 Aug 2024 16:36:45 -0700
Message-Id: <20240814233645.944327-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Now replaced by meson build.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure                | 18 ---------
 Makefile                 | 10 -----
 contrib/plugins/Makefile | 85 ----------------------------------------
 3 files changed, 113 deletions(-)
 delete mode 100644 contrib/plugins/Makefile

diff --git a/configure b/configure
index 019fcbd0ef7..2c0f708cd0a 100755
--- a/configure
+++ b/configure
@@ -1030,7 +1030,6 @@ if test "$static" = "yes" ; then
 fi
 if test "$plugins" != "no"; then
   plugins=yes
-  subdirs="$subdirs contrib/plugins"
 fi
 
 cat > $TMPC << EOF
@@ -1531,7 +1530,6 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/avocado tests/data"
 LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
-LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
     if [ -e "$source_path/$f" ]; then
         symlink "$source_path/$f" "$f"
@@ -1614,22 +1612,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-# contrib/plugins configuration
-echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
-echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
-echo "PKG_CONFIG=${pkg_config}" >> contrib/plugins/$config_host_mak
-echo "CC=$cc $CPU_CFLAGS" >> contrib/plugins/$config_host_mak
-echo "CFLAGS=${CFLAGS-$default_cflags} $EXTRA_CFLAGS" >> contrib/plugins/$config_host_mak
-if test "$host_os" = windows; then
-  echo "DLLTOOL=$dlltool" >> contrib/plugins/$config_host_mak
-fi
-if test "$host_os" = darwin; then
-  echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
-fi
-if test "$host_os" = windows; then
-  echo "CONFIG_WIN32=y" >> contrib/plugins/$config_host_mak
-fi
-
 # tests/tcg configuration
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > tests/tcg/$config_host_mak
diff --git a/Makefile b/Makefile
index 02a257584ba..e474fbe50de 100644
--- a/Makefile
+++ b/Makefile
@@ -186,11 +186,6 @@ SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
 $(SUBDIR_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
-ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
-.PHONY: plugins
-plugins: contrib/plugins/all
-endif
-
 .PHONY: recurse-all recurse-clean
 recurse-all: $(addsuffix /all, $(SUBDIRS))
 recurse-clean: $(addsuffix /clean, $(SUBDIRS))
@@ -306,11 +301,6 @@ help:
 	$(call print-help,cscope,Generate cscope index)
 	$(call print-help,sparse,Run sparse on the QEMU source)
 	@echo  ''
-ifneq ($(filter contrib/plugins, $(SUBDIRS)),)
-	@echo  'Plugin targets:'
-	$(call print-help,plugins,Build the example TCG plugins)
-	@echo  ''
-endif
 	@echo  'Cleaning targets:'
 	$(call print-help,clean,Remove most generated files but keep the config)
 	$(call print-help,distclean,Remove all generated files)
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
deleted file mode 100644
index edf256cd9d1..00000000000
--- a/contrib/plugins/Makefile
+++ /dev/null
@@ -1,85 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# This Makefile example is fairly independent from the main makefile
-# so users can take and adapt it for their build. We only really
-# include config-host.mak so we don't have to repeat probing for
-# programs that the main configure has already done for us.
-#
-
-include config-host.mak
-
-TOP_SRC_PATH = $(SRC_PATH)/../..
-
-VPATH += $(SRC_PATH)
-
-NAMES :=
-NAMES += execlog
-NAMES += hotblocks
-NAMES += hotpages
-NAMES += howvec
-
-# The lockstep example communicates using unix sockets,
-# and can't be easily made to work on windows.
-ifneq ($(CONFIG_WIN32),y)
-NAMES += lockstep
-endif
-
-NAMES += hwprofile
-NAMES += cache
-NAMES += drcov
-NAMES += ips
-NAMES += stoptrigger
-
-ifeq ($(CONFIG_WIN32),y)
-SO_SUFFIX := .dll
-LDLIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
-else
-SO_SUFFIX := .so
-endif
-
-SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
-
-# The main QEMU uses Glib extensively so it is perfectly fine to use it
-# in plugins (which many example do).
-PLUGIN_CFLAGS := $(shell $(PKG_CONFIG) --cflags glib-2.0)
-PLUGIN_CFLAGS += -fPIC -Wall
-PLUGIN_CFLAGS += -I$(TOP_SRC_PATH)/include/qemu
-
-# Helper that honours V=1 so we get some output when compiling
-quiet-@ = $(if $(V),,@$(if $1,printf "  %-7s %s\n" "$(strip $1)" "$(strip $2)" && ))
-quiet-command = $(call quiet-@,$2,$3)$1
-
-# for including , in command strings
-COMMA := ,
-
-all: $(SONAMES)
-
-%.o: %.c
-	$(call quiet-command, \
-		$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<, \
-	        BUILD, plugin $@)
-
-ifeq ($(CONFIG_WIN32),y)
-lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
-	$(call quiet-command, \
-		$(CC) -shared -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-else ifeq ($(CONFIG_DARWIN),y)
-lib%$(SO_SUFFIX): %.o
-	$(call quiet-command, \
-		$(CC) -bundle -Wl$(COMMA)-undefined$(COMMA)dynamic_lookup -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-else
-lib%$(SO_SUFFIX): %.o
-	$(call quiet-command, \
-		$(CC) -shared -o $@ $^ $(LDLIBS), \
-		LINK, plugin $@)
-endif
-
-
-clean:
-	rm -f *.o *$(SO_SUFFIX) *.d
-	rm -Rf .libs
-
-.PHONY: all clean
-.SECONDARY:
-- 
2.39.2



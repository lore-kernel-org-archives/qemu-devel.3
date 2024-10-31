Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C2EE68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQn-0003iO-LW; Thu, 31 Oct 2024 00:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQi-0003eU-Ba
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQg-0004qT-GI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c8b557f91so5319605ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347501; x=1730952301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8/FoORAU+MbCzBkiE+YK/dNQraWToWCvs2DtBwW02Y=;
 b=M+u9yDEEMZfeVUY41bCuihIlEqXL3E744K4MGrk+PF7YhSNnXFx7cin8upM+xipYo2
 HjqwMJ2LUkn0FAx4sg0KeA+TWW5LZ5ORhDvcIrbRpXxqk5vyOPrleDQfAgHWCoM1+nAb
 87hJFpyt8Cuw1/ALbDu8KU8wbnrWc4iph+EXOSba4vaRgoChfngXnWPHw4OdDaAP6yS8
 qdOaL2TgyzdCLz2KzYY54BYLi5ZMHy/f+gFasU2Az6a3TSpXTqCWT1o7Yn7DuawCDwzQ
 xdzJM8kGalI8GQLc2wAmsLWGVjLc9l3Jg+teWVg91gPyeAdL+qnpb1sgBqxtlWgEEVTE
 laCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347501; x=1730952301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8/FoORAU+MbCzBkiE+YK/dNQraWToWCvs2DtBwW02Y=;
 b=SP0f8nKuw8Jgj9kmbPRcqblDhr2gTwyuK6iXoTn2l6tQUkmj685WZfQdfDEeWuwhgO
 e/Wg1LsfUCA5oJghGynUjpq5MYG6NKMVDe5TZmmvZO6Xdkxjd2sk9u+RQ1Zaj0ez5Adn
 aJydUtoN3OrJabZs1bKw/r7MScDWk6KvNoXmt7g/QYbcDCiSPAgS5dDFIR7hxL3z36Ci
 aoXtiDpl2UT9tgPZHMexaTJJkGaDn92PaTH1NeZE7E9ETnXt5FhH/tiPEotSO/YbTK95
 f1Cj5J9YZ5uFH+yhDvO1COgmn4kyVjRMGxzQGwDqYO8NkhpaYfVDJb8nx8tUnJyU05dO
 9ULQ==
X-Gm-Message-State: AOJu0YxZH7Q0O9NQXvZGuhyJyIAynnCmgsBkJumG8X1VOKUGGOdv/2zd
 eSYZDnUXj4jwAxsmbMmCvfB605tmWwRHfPtVbRL1Ogl1YyeKBG8ZM+LxLEsy0FY1JCnBPrwSWqA
 wLHZePw==
X-Google-Smtp-Source: AGHT+IG2rAYEErvzHSg3m0qkWXFcFOScpXKMPZL5dHjMebkKHgSGcvDogxFZVUhdAVzXSb4ClNN3sQ==
X-Received: by 2002:a17:903:228d:b0:20b:9062:7b08 with SMTP id
 d9443c01a7336-210c6c6e7edmr287969295ad.45.1730347500835; 
 Wed, 30 Oct 2024 21:05:00 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 04/12] contrib/plugins: remove Makefile for contrib/plugins
Date: Wed, 30 Oct 2024 21:04:18 -0700
Message-Id: <20241031040426.772604-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure                | 18 ---------
 Makefile                 | 10 -----
 contrib/plugins/Makefile | 87 ----------------------------------------
 3 files changed, 115 deletions(-)
 delete mode 100644 contrib/plugins/Makefile

diff --git a/configure b/configure
index 4a0159e1832..8f0ba505187 100755
--- a/configure
+++ b/configure
@@ -1073,7 +1073,6 @@ if test "$plugins" != "no" && test $host_bits -eq 64; then
         plugins="no"
     else
         plugins=yes
-        subdirs="$subdirs contrib/plugins"
     fi
 fi
 
@@ -1704,7 +1703,6 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/avocado tests/data"
 LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
-LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
     if [ -e "$source_path/$f" ]; then
         symlink "$source_path/$f" "$f"
@@ -1790,22 +1788,6 @@ if test "$default_targets" = "yes"; then
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
index 917c9a34d1c..b65b0bd41a8 100644
--- a/Makefile
+++ b/Makefile
@@ -187,11 +187,6 @@ SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
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
@@ -307,11 +302,6 @@ help:
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
index bbddd4800ff..00000000000
--- a/contrib/plugins/Makefile
+++ /dev/null
@@ -1,87 +0,0 @@
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
-NAMES += bbv
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
-NAMES += cflow
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
-clean distclean:
-	rm -f *.o *$(SO_SUFFIX) *.d
-	rm -Rf .libs
-
-.PHONY: all clean
-.SECONDARY:
-- 
2.39.5



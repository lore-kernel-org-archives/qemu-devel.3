Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D19ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so06A-0000LY-9x; Tue, 10 Sep 2024 08:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so060-0008Rz-AS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:50 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05y-0004r4-8R
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:48 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f75e5f3debso28856151fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971744; x=1726576544; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/p/YzRh+Qza96Ha1nUOAfe1Sc575l7UKV3VGGl6ZupM=;
 b=hBGt4IFQqadnOFjgleVLvP2sgVtzmtLAgVE3s+hd0jAIgKY4iFlasSVGvoNcqE+z3w
 K36RPzgc2pZzo36MwAy+I4aK+lNIYLIIWe28PZIRIFth/13Hpbr45EpOvS+RHVZp0DBT
 WxoW6e7xp1NYHbyixjJI0PuuLAGT9bYCs5yYoRiACYlj+ZiAPywSSZvcjYmcBclPRA4S
 lDVziNyFClynrRdNaLS/d4/TBMiOksHP55BfhtxsvMCjVUbdj8TrlPzHM7U1AvTq26pt
 z23+MB7ULha/QkB3We7Hhmzd9xjVy/AOZPBqBmoP/jlRma7s6mGriqbQ8Bexxj2ck48l
 6N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971744; x=1726576544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/p/YzRh+Qza96Ha1nUOAfe1Sc575l7UKV3VGGl6ZupM=;
 b=UnSM/rkPvY0NCvT5Yl7ew6LhZ+Zv3nDEyZ5rZ3+Ty8eTbBVW5HzKyXnf7DCcys1C9W
 KRe0dSrdnI5d1rJSo3pok1tRzKTtNv7qpjMUy3pUC15eXdxSgvScxUtJ1eGWQbTXlZ9K
 yvBV4PYSJrS4DD/By7BjUpwTTKNYmTY3Ss6LFN9Y9vhCMcC+uvInDFZK+MP78hslzj62
 BcoBYo4HtzNAwfyVmW1vTuW8EDVfrfIRDDvwi5jp+4kvJuAre1jZmDlsCueOX07H0D8N
 v/44sMDHQsmznKZtp+ogX95llpWr/hK7+NRNisGoNvjhs7vwdXMylH7Xw+frjoUgT6p9
 zjew==
X-Gm-Message-State: AOJu0YyAxe/Vyj0q7jlwllIyee5xIHdlQVZAMQU7tnwVd/EpZxPKJycs
 asWj8Angu3Hd8B/IPSxcu7F6GZ3rkD4KJkvkMdDNpm8QVGaUEIqythXzGpCpp78=
X-Google-Smtp-Source: AGHT+IHBaHrtZi572QPsoordzSGSjIbcx73H1pxyLVlLXOWfuK7Mx6oAoYXPBY+ejfGD8ZdQrfGqSg==
X-Received: by 2002:a05:651c:556:b0:2f3:eeab:7f17 with SMTP id
 38308e7fff4ca-2f75b9420a8mr81868301fa.41.1725971743654; 
 Tue, 10 Sep 2024 05:35:43 -0700 (PDT)
Received: from [127.0.1.1] (adsl-234.109.242.225.tellas.gr. [109.242.225.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm4242994a12.3.2024.09.10.05.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:35:43 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Sep 2024 15:35:12 +0300
Subject: [PATCH v10 6/9] meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240910-rust-pl011-v10-6-85a89ee33c40@linaro.org>
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
In-Reply-To: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=2438;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=z+DYU/VsMAumDk8UU8SzrDji8IQmGTT50i4PLUQ3KGo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm00RDBNaEpCR0lySElSYStBVTFJUFQ3cUI4OHN0ClZKMzFCOFNuWWp4MGpzVkJX
 Wm1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnVBOURBQUt
 DUkIzS2Nkd2YzNEowTHdvRUFDY2x1VURFT1ZvaVAzK1hIZUk5NGlEbmlabVcrUjBZVnJ4amE0ZA
 pzOGE3UnN0eGRPR29md2wvY0xSMWU1M3VqMFlGdkh0ejl4WWtlTzc1KzJsREx2NjZORFZBWDBCe
 kUxM3JnRVJJCk40eGJsSkdaYXRVM3g1Wkc0Tml5bFo3ZWI2Nis1MnlPd0RsNkR2SzY0ZUY5YVVL
 SUtZS005QkVQQ1FJbkRURTQKWlJnVDAzYnVKS2J2L0ZNWU1MTy8rdzl5blI3SXRmMU1aeEJETTl
 YU054am9wOG9mZUN1YUt5c1Z6RkU1b3MrRgpSZ1lDZGNaOWVIcTRvRG5zNTNFbDhNQ2hOY1hYR0
 pJcnFPZmwzSXQ4aE04M3Z1RnFBU1FydWJuSzZWSit4aWVYCkhmRmN1UVlFa1NieFV2M3NmR1lTS
 XlEdlpCWVZmMnhmaEJGSncxbFIyNGlHVXg3Wmp6ZStnWllBeEVyWTNZWlkKQjkyWmN3bHBWNHVU
 MGh3YkllZURyTWNseHdHL1RLaSswZmNPWjVOLzRHUTdVeXlGQWJnbXBaYkpWQVdyMlJHNgpOTW1
 ESXRkcysxbjNFbVhhTnlVbmRGUlFvblJZQlZkV3FLQ0I1YmNwb1hhbGZ4T29wbnZ3Z1RiekxHNW
 pZa283CjhLd05DS1M5SE45SkFrOE5SUjR3RllMREFUL3dlWW1Kb1lkK2JONzl3eVYxNG03eGlFa
 0V0UHdPQ2Fjc3ZhZmoKV0xKazdLTTl2eWYwWVlYa3FYVkZ0a1lyMDFHTUZWWmxwT1FXLzd5d1B4
 UndYSW1xYnlWbXh2L28yREJJN0JJbQp1dVdyRnROR0pLZCtVTklxYXBOQTUzZHNZdnlBQnR0UUo
 0TVFxYUZhN2pIUE92ZU9peDZmaGp0enE3bjgrSWFlCjBGbkJMdz09Cj1GN0dXCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
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

Rust crates, introduced from the next commit onwards, can optionally use
the glib allocator API and need to know whether g_aligned_alloc etc are
available.

This commit adds a define in config_host_data that depends on glib
version >= 2.72.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1a03f7e15f639799889933c19bf17c2b8f00d879..0c9c2d4f60845d5f959b10424ca2b11b655cf51d 100644
--- a/meson.build
+++ b/meson.build
@@ -929,7 +929,9 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 ################
 
 # When bumping glib minimum version, please check also whether to increase
-# the _WIN32_WINNT setting in osdep.h according to the value from glib
+# the _WIN32_WINNT setting in osdep.h according to the value from glib.
+# You should also check if any of the glib.version() checks
+# below can also be removed.
 glib_req_ver = '>=2.66.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
@@ -979,6 +981,9 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
+# Check whether glib has the aligned_alloc family of functions.
+# <https://docs.gtk.org/glib/func.aligned_alloc.html>
+glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2508,6 +2513,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
+config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))

-- 
2.45.2



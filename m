Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D839DC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tparE-0000pN-0X; Tue, 04 Mar 2025 17:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaqk-0000Wo-Th
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:55 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpaqi-0001O5-0C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:34:54 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac0b6e8d96cso383500566b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127690; x=1741732490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JeQtbLiYtOLbCRF+mM5h0mscE6W4z+gp/D6Lf7IWuI=;
 b=PnR7vJqEUUL4GwcFYUhtFBQfk+/FUQHtIrlaFAKjUnehWUu2j+apjBW4a0zPhJ4flJ
 3/vcqo3N0oxMVU+vIqQ9FQAPDH/qHt82egPR6ibLc/X4+1B8S3n8HCF90+LG6Zm9xpms
 j/R94aA+YWgaL2wApzHpcVY0m/TqB8lUBOGrs4fKa1etH47oUpPlr0HEvkfEklbJzKbj
 pI5Vk0UkdytL7DUU7qZ5B6hxNj129z8EOWg5z4g+HWxuEludqvhaLkp5zt2vZ+fBr3um
 IKkNNMf06LfggVjwETHLbLXd4UuWcdH9Ndz7lU2bb1sfvBgxrg1DKlyzqtJvzu7mg93c
 QbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127690; x=1741732490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JeQtbLiYtOLbCRF+mM5h0mscE6W4z+gp/D6Lf7IWuI=;
 b=TRb6DbfO0vPyUcKZBvsL+w35s0Ip1pyxxVZu3jCcl4nDjz9oGsYxGJGGBQQt1uYAXD
 VdEc5fvI7xM/3/JE2SGZ9B5QS7Pc54wmScSCxIMwMgQqfY3DQcnZ32q+vxBQ/3c+cxBn
 qluLTg0E1oOiLXpMBUBuUnWNts0CwhcHZX8tj4uI8ZeXpo/BvzSUZkK3Q7AS06dGHtUm
 jXzSGhJPNkDUhEndvXlStDAnuWBBOomJr1rIX+l2qlqNMs1UGIycb/8wI6iZ4uaveNC9
 REtEcRWnwUyK5XGTvFomXMnW6Yt5f0QEMJ0MmQv9QCHFPmmHW7oLhBjXFfPbI7Pzj8k7
 4egg==
X-Gm-Message-State: AOJu0Ywvdu0cDMMQ3rIdhwQECVnJ2Y8LHhdq061x+YfWWDlku7ubCNij
 CVsJGC58vW0lQ33mGFzEo1PZkncswbowytVJCpjbupMQ67dYzfHhRr64pICdvjc=
X-Gm-Gg: ASbGncsSZOjOON1Qo4AB3C+yjWrxWODgghgkIsG//KAo9UCCP9xEo4HhUAwkasuQEcI
 fHVzpuz/xjOveTMdBhAqU2atfbx9DWB3EbzmTSNTXsK4K8fd9ujs1MFh7HrEZ3u70e9D/hDW6bM
 A1nZVzBiHkc2aLjwZHSXXCtrsmHWsyjBpgZH/FiHZdFUccWrwI5oBewbY19DLCadtAfAo5PQyWH
 D8TqpSEvwH8db/vFMgTiFhYg0IuwTGuFPaEHKvc4/UecZlgKptU34d2tHrAV9zS1G/jVMGiyOqn
 to/qzCRgI6VQFf7/3evMyyyyJtDwxXiz5Cy0z+mNhAolCMA=
X-Google-Smtp-Source: AGHT+IHhk+Jn5oDf4hZbTDw4XTbhPFaPVQmQFbxyIzcwcaxxvcySrhssqEKfWar9DkzSIY0HsfCmgA==
X-Received: by 2002:a17:907:94c8:b0:abf:44bd:8326 with SMTP id
 a640c23a62f3a-ac20d8bce29mr83331366b.17.1741127689992; 
 Tue, 04 Mar 2025 14:34:49 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf40a603b7sm785796566b.170.2025.03.04.14.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:34:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A13C062604;
 Tue,  4 Mar 2025 22:24:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 32/32] meson.build: default to -gsplit-dwarf for debug info
Date: Tue,  4 Mar 2025 22:24:39 +0000
Message-Id: <20250304222439.2035603-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to 3.9G.

The --disable-split-debug option allows distros to keep all the info
together for ease of packaging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - add --disable/enable-split-debug
  - move to option_cflags
---
 meson.build                   | 7 +++++--
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 8d0abe7f12..36ffe1b730 100644
--- a/meson.build
+++ b/meson.build
@@ -363,7 +363,7 @@ endforeach
 
 qemu_common_flags = [
   '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
-  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
+  '-fno-strict-aliasing', '-fno-common', '-fwrapv']
 qemu_cflags = []
 qemu_ldflags = []
 
@@ -4589,7 +4589,10 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
-option_cflags = (get_option('debug') ? ['-g'] : [])
+option_cflags = []
+if get_option('debug')
+  option_cflags += [get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']]
+endif
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..3432123fee 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
+option('split_debug', type: 'boolean', value: true,
+       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..aca6e68830 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,6 +504,8 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
+    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
+    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD6C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDxS-0000pq-D7; Sun, 09 Mar 2025 06:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDxB-0000Bq-F2
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDx9-00045r-Cb
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMUKogfKyzAz46Y4Z8OW5xUGWyWP2F2XLF8CrapiAvY=;
 b=S1F9lOjCctdCtdqIPB9Jry2i/riAmjCL79E/orUy3hvaRDIXQIs20yczyrMfDXaox4ETBG
 jUHpg/vpostIhSgaekFd/+QStsyjv9ZfDng9+5p08sm+mEUrTSCQm3C0dBZXDDtZg7xEsd
 BxZa3fy/NP5oWgI5fnbWVCZrRBoZQbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-STkgT4KGN5m1HWmZ2CCzfg-1; Sun, 09 Mar 2025 06:32:13 -0400
X-MC-Unique: STkgT4KGN5m1HWmZ2CCzfg-1
X-Mimecast-MFC-AGG-ID: STkgT4KGN5m1HWmZ2CCzfg_1741516332
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so1391965e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516332; x=1742121132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMUKogfKyzAz46Y4Z8OW5xUGWyWP2F2XLF8CrapiAvY=;
 b=xK8wfSgDiv3NZ7d/XSSLzflAJj8ug+f12XWYUmklKtS9q0YB9Mf2E+EWwGXcpeyYQT
 K3Do665ywQwIIcNOdHS7v+SKQu7tX6Uz8oAw2RLUSPSYRy/tm7zUYiF7MtBhLwF/eQQ1
 /V6SnW77vs7w7zz/5p/Z3rJgThmpKBQaDjPIPzOQ81pWebILzqXQbN7nliJn1qNL3Ssy
 3bIRsAoTo1Vi7IhFzaE9YDXhTWwDmzuRceLpZlXntrDQ1+phxRFt5WLyjSFT1YD3dla0
 9hnf381sUUb8YwiqF/F3vQbCOEbzGfvxIys70D57MKMrfKrTIiwwF22EG5oMncjugUyZ
 Wydw==
X-Gm-Message-State: AOJu0YzCZLEow6RZDjpO6okyNKkfhw9gNu3LxEP0N/P3MWtzwFXeI5vf
 3gfW+sW+4N8kfYH1gCiaJsBABX6fU/1dDpgTOGk3ABr20kjSxBEcRrRRxwQMhnCuGsufS0ImK+q
 8+Uktu6GLbsi5aifarpl5u4uFkqX4j8J+nLB0bCpUV4jzYolhKGaMzJ1etnDY3ZZZY1B6A+f8BR
 cj8vSq4Ehj4iduCe4RrTeO2vCijk91uwDnk+X+pMY=
X-Gm-Gg: ASbGncvd/doq8C1ME56KJOUrGzy1e+6jK07gg4QejOcEwpHAW1OBdw+rLab0PRPeWB6
 /6kxgjcOyTIZUX3CGXcMfXuxFU+3hMuPxCKdYhBrvAZEn1Qf4CUUoEcXfXxDEcELZlc6B8ME4Ca
 Yxx7vZsnecaJa5vwixwEP+VERCGzlsSFIlAQWNT6enFN3BelCkSPBPC+rdc0ust4vkwZ0jB13/N
 wFR8U/FM1msP5Jyr9Jyj7I5XgQyw2vVHnkx7+kudT41cZwOz20j2MFxjzFTZdB/xjaOgsJnCLvI
 1BXt8eNK4IFVHesx4hA+ZA==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43cf1b81b78mr9503155e9.30.1741516331920; 
 Sun, 09 Mar 2025 03:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3i7HQ3BfMVkTqOhiH/ic9cHN5EaI1ROqBFR5mD3dFqHP7nZMruL9PBgJiwzGxWf86YzeFIA==
X-Received: by 2002:a05:600c:19cd:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-43cf1b81b78mr9503005e9.30.1741516331476; 
 Sun, 09 Mar 2025 03:32:11 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm58130275e9.12.2025.03.09.03.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:32:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 24/25] meson.build: default to -gsplit-dwarf for debug info
Date: Sun,  9 Mar 2025 11:31:18 +0100
Message-ID: <20250309103120.1116448-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to
3.9G (vs 1.9G for --disable-debug-info).

The --disable-split-debug option allows distros to keep all the info
together for ease of packaging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20250306161631.2477685-1-alex.bennee@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 6 ++++++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/meson.build b/meson.build
index 6da4eb317c2..4899d896de0 100644
--- a/meson.build
+++ b/meson.build
@@ -601,6 +601,10 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
+if get_option('debug') and get_option('split_debug')
+  qemu_cflags += '-gsplit-dwarf'
+endif
+
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -4583,6 +4587,8 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
+# option_cflags is purely for the summary display, meson will pass
+# -g/-O options directly
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca00..3432123fee2 100644
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
index 3e8e00852b2..aca6e688302 100644
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
2.48.1



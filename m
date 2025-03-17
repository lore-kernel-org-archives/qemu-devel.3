Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79CC35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCHO-0000Vt-Qm; Mon, 17 Mar 2025 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHM-0000VK-Qp
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHK-0002bt-CM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742224880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jG/Zv4feCbekspzVUUTIkdZ0XHo9PzS/ZISlUZ48iZQ=;
 b=U5Ich1sHRNRRqCGrytZ/tjyaKZl9XYO4AYykEsAoiyKx9Pje6zECPO/hSnJ4iRFi392YUy
 izwdB7fNDaaPRNXgMULHLbfediF0Org4JMNfRguAIxtLwqHdxyyum1imIdfpsLRebxmxF+
 vdO6btrpj271/ZcT/iLZVAGMbtrGeNU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-X-rbWKhLNeyvVobvGhaOvQ-1; Mon, 17 Mar 2025 11:21:19 -0400
X-MC-Unique: X-rbWKhLNeyvVobvGhaOvQ-1
X-Mimecast-MFC-AGG-ID: X-rbWKhLNeyvVobvGhaOvQ_1742224878
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391459c0395so1983015f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224877; x=1742829677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jG/Zv4feCbekspzVUUTIkdZ0XHo9PzS/ZISlUZ48iZQ=;
 b=gMb7ApyhFI8LQp/hvkHzBLNoPoQS0ydQflYe728vWBhuxJS8+TQMGRL8/zwkhWwjjO
 UDdhR9ACddPHY+QQAC4jYpvh3UFwcmQc6llP5iUpkEviCVbF8mVL1nhGQVApSw/0BWcS
 tH6jkC3tMWhVptjB/krH3aS/PgkcWxnuajSz645u5Emf0C4RiJdpeYDWuor87az4RtK5
 voVqLdlO4rddug9ywTbAdk9xc+j+YFXdmU33wOiZyrsRHXrBNefABlcaqNquuS59kq2R
 gJCOprFU06WbfvyolR4E0vq2gXBTjT1JWrtYibGZc1vKOWHtkWWUiZWQyXm1+bPBqdww
 1Wnw==
X-Gm-Message-State: AOJu0YxR1j6sTRgDilGO6fDuws2wKfUBVCtWjC6uklbNv0P40N+XPmQX
 59YJfsaf/y9H07uVNogAGnqYbpCL3TLgc6KkZuqsX2IBK2KBmNy/1CKUyriytB1uAaHowhgYmLw
 fyfamLApr0dTIrZt1+J3kKCoW+bDLtLjyKw+d7Z5W5D8QhTEoroRhb9zsGCBuE3e2kn+Dpj5/zl
 v7D1YPcjYX7+uxDUQd14GJvwjwisLzkJW5+M9Q
X-Gm-Gg: ASbGncugtJyEKrw9DwYCp2wZhVACbX5SUDhEZ0Upg1RzTjkFCcRtCEIepTdAinY2mj9
 rDdpt0V4UQ1Nhr3wWFSNqb6ssvTYhdYoC27QvZXtSb8wJgQibpUwle7yZS/6V+M1EjJsvEu6ssA
 vUTAXBKqPs/mQ/Kgi0dzmQ+OWfInyeannMZ3XI8QEGNW8+4Kv0O7dBeuojRgOQWhPOk5ZXPV+Lr
 G0oeS36RmQgHfYnG//SdZ4qbODNYTv7IwjTTTD87QnT9iEImE6XUeH3oU9Vwaj3ACIt4TBQMElY
 q5PDHymlCh/dezyeavUi
X-Received: by 2002:a05:6000:402a:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-3971ddd60femr14075444f8f.9.1742224877212; 
 Mon, 17 Mar 2025 08:21:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBPCaZyh99v9AklbkIeSK+KetkeMMfOIlWyn8TGdOHHovYJdOC6DR8XXmyLdZyulVj+abzOA==
X-Received: by 2002:a05:6000:402a:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-3971ddd60femr14075418f8f.9.1742224876777; 
 Mon, 17 Mar 2025 08:21:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm107185005e9.17.2025.03.17.08.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:21:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/2] Revert "meson.build: default to -gsplit-dwarf for debug
 info"
Date: Mon, 17 Mar 2025 16:21:11 +0100
Message-ID: <20250317152111.316627-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317152111.316627-1-pbonzini@redhat.com>
References: <20250317152111.316627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

This reverts commit 563b1a35ed1f1151505d4fe5f723827d1b3fd4bc.

Split debug info support is broken when cross compiling
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99973).  People
that would like to use it can add it via --extra-cflags.

Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 6 ------
 meson_options.txt             | 2 --
 scripts/meson-buildoptions.sh | 2 --
 3 files changed, 10 deletions(-)

diff --git a/meson.build b/meson.build
index 7f75256acf9..41f68d38069 100644
--- a/meson.build
+++ b/meson.build
@@ -604,10 +604,6 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
-if get_option('debug') and get_option('split_debug')
-  qemu_cflags += '-gsplit-dwarf'
-endif
-
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -4599,8 +4595,6 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
-# option_cflags is purely for the summary display, meson will pass
-# -g/-O options directly
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
diff --git a/meson_options.txt b/meson_options.txt
index 3432123fee2..59d973bca00 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,8 +362,6 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
-option('split_debug', type: 'boolean', value: true,
-       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index aca6e688302..3e8e00852b2 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,8 +504,6 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
-    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
-    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.48.1



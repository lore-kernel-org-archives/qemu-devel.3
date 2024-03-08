Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECD9C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehq-0007BY-8H; Fri, 08 Mar 2024 13:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rieho-0007Al-JQ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehe-0005nj-05
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSLSAV6AzeUGqChFbxsNaHAkQhSsp716NDVyKQt1iAM=;
 b=XiiMMfEJmsdY5ZpJEeohpLn/Edzpjc40ig3pvvHYr/ae5mmcdQ6hlSU83dsxycBzo5iETm
 U90VqnJLVxs6uCowGp/E+Ycu4yiq9mrHyfBdlJS1wDbWOo72prcEnH118HEpSZFiLSp0NU
 EFVUCiaE1AFWagjRmS62+6qtE8vZWtI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-cmEtV2S-PemMw9SV7S3FXg-1; Fri, 08 Mar 2024 13:12:14 -0500
X-MC-Unique: cmEtV2S-PemMw9SV7S3FXg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a3fb52f121eso160594666b.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921532; x=1710526332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSLSAV6AzeUGqChFbxsNaHAkQhSsp716NDVyKQt1iAM=;
 b=cbjwyngxZ4YbKGHtvSoGdsgafTytBf26MsqEOYzqRvuC5417TtR9sKhH/1YDh74eDK
 V7WoE8906LZEIh5zoHc0mXmo4R8KXmWT/YMm9ud/xgLVLuO+AtKnY8qI74XucyOLqMoq
 UwafRwCw5G20YaMRkSRRlJ8lVV8JwxG60hscHu27crbXJOCn/y1L8KSleS8VwMgDrHvA
 5jXYw2fEK/l3iE2YOfUXRd9dp9isHqemHjdDzIc3TyqRkxhCwqymmd7CwJN8bmuj4ZyQ
 UeRloWv7JkZZTMXi6/e4RRXbiu9t/HZRXVk5waTomW2F/naa36sjmrgkOyeQxNJgn+1t
 Qi3Q==
X-Gm-Message-State: AOJu0YxsqIGrw+QDgt81ZFbgGtBqwcchT5IhUV9LYAKzF4SRt/bUOCdK
 WCEmI4mLVNYRhKgEpbb5avrbwVyE7rjbrJiztfSiOJ5YnLXuAzy5DmhCoMtR4loWOT2jsEGRfkc
 VsLk/dD6e9ZgWSeq19UYIetkr9MTA7hQntNTbnh0ibKw5eamH7Vpk5MACY7lu3WaM+FEBzlFGlE
 41NeGqVRoqvqNMG3HiyMVb9xQXx7sEnnQr9lvh
X-Received: by 2002:a17:906:55d3:b0:a45:ae8b:eece with SMTP id
 z19-20020a17090655d300b00a45ae8beecemr7403456ejp.59.1709921532401; 
 Fri, 08 Mar 2024 10:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFej94m18XeJGwayhUbLTLyfuG5eHDVsXiw9n/XdoERJ+y/irFVZR8bGMQL0kyXcOIPKbUzQ==
X-Received: by 2002:a17:906:55d3:b0:a45:ae8b:eece with SMTP id
 z19-20020a17090655d300b00a45ae8beecemr7403436ejp.59.1709921532051; 
 Fri, 08 Mar 2024 10:12:12 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a1709066d1600b00a451d07711csm40056ejr.82.2024.03.08.10.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 3/9] meson: Remove --warn-common ldflag
Date: Fri,  8 Mar 2024 19:11:55 +0100
Message-ID: <20240308181202.617329-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

--warn-common ldflag causes warnings for multiple definitions of
___asan_globals_registered when enabling AddressSanitizer with clang.
The warning is somewhat obsolete so just remove it.

The common block is used to allow duplicate definitions of uninitialized
global variables. In the past, GCC and clang used to place such
variables in a common block by default, which prevented programmers for
noticing accidental duplicate definitions. Commit 49237acdb725 ("Enable
ld flag --warn-common") added --warn-common ldflag so that ld warns in
such a case.

Today, both of GCC and clang don't use common blocks by default[1][2] so
any remaining use of common blocks should be intentional. Remove
--warn-common ldflag to suppress warnings for intentional use of
common blocks.

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85678
[2]: https://reviews.llvm.org/D75056

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20240304-common-v1-1-1a2005d1f350@daynix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/meson.build b/meson.build
index c59ca496f2d..f9dbe7634e5 100644
--- a/meson.build
+++ b/meson.build
@@ -476,11 +476,6 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
 
-# Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if host_os != 'sunos' and not get_option('tsan')
-  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
-endif
-
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
   # virtual-devices.
-- 
2.43.2



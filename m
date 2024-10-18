Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08236D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCH-0008Cl-Tt; Fri, 18 Oct 2024 10:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCE-0008By-8e
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCC-0002aU-RZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OzN3eaQprVpp54M3KGLNllwys/lfpHPukyEKJkQaBx8=;
 b=BGQ2llHOl26IlSiNpVMUCGStO+jg911aqzDV4bn78LcgRjb94FFk3zIdZT4wG49xOZVdAg
 4K66iC6Ve0NCrGp6Mw6ujispKqDcoYbAZkV3ANhk7c8XkJ6M42Z8VW0guTgtZ2HoMhFJiS
 U06Y0Yo3c+OsL1gYLHoNcjcAegsvN6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-J1TnjE_7Nqmaw8fHiE1twg-1; Fri, 18 Oct 2024 10:43:15 -0400
X-MC-Unique: J1TnjE_7Nqmaw8fHiE1twg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4d51b4efso1048993f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262593; x=1729867393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzN3eaQprVpp54M3KGLNllwys/lfpHPukyEKJkQaBx8=;
 b=ADNct4qOoFchLuM4BBvQGmEn71Ewl0MdEoa1aGNt2faEv2Y1XBWqdoHzVU2cnVBP7o
 5MYgLfLpB0cXGbgO5YWjmXQIWrR9+LwwqZLQRjl0T/TVqK2l9xLXuNTX0b7kt7E9qLZK
 8oKRPuvadZ31vdkrFjy8SK7cVFG5XajCGdJr7/pKwS0vLKJHB+/7BOvEIMlluDMMuXAy
 YT6e3Q7tP3PG8qk4KjjBbDDQjTbfrzKeLQsX4t6cSecYM37gKCJmij2aANaPqy/1sjIK
 ZqEVkMKwsFahCr8NFrzSqcwpnrwrZO4rJXW6xvhcCSMqnXpCofOCPSWNfDxRS/XARSo5
 /4Yg==
X-Gm-Message-State: AOJu0YzroF+RPeayLg04vyR1Yf6jGiVzG7aENuWYyCo4STKJO0BfSJkY
 ThgFag4sUDV4Q4/HwVvvlH4zh/n2VMAhvTZCnwheh0E4samZ+TK+Jxou+zEpJclNrk+/NUVz/yn
 rCuhW/96CrnkpfKXaiKB4aE03WY538635+7EgHQ52JcTlxYXXpR4X38zjHpEsl4HkX9ZXRahuPx
 mcJFGLOSLPbMGHFLSdGouaDeB8EIUl9QpPRCjjQeE=
X-Received: by 2002:a5d:4581:0:b0:37d:492c:4f54 with SMTP id
 ffacd0b85a97d-37ea21de09fmr1880695f8f.3.1729262592683; 
 Fri, 18 Oct 2024 07:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQRzme0GwT0Pno2T65dD4dsZfkWgwu+d7+hO5ptwthRcIWEkT2p4FCDwDmj5hQMm+CY5FCLQ==
X-Received: by 2002:a5d:4581:0:b0:37d:492c:4f54 with SMTP id
 ffacd0b85a97d-37ea21de09fmr1880673f8f.3.1729262592173; 
 Fri, 18 Oct 2024 07:43:12 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf027b94sm2133165f8f.2.2024.10.18.07.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 01/13] meson: import rust module into a global variable
Date: Fri, 18 Oct 2024 16:42:53 +0200
Message-ID: <20241018144306.954716-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                      | 1 +
 rust/qemu-api-macros/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d26690ce204..ffd78b6cbb3 100644
--- a/meson.build
+++ b/meson.build
@@ -15,6 +15,7 @@ meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
 not_found = dependency('', required: false)
 keyval = import('keyval')
+rust = import('rust')
 ss = import('sourceset')
 fs = import('fs')
 
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 517b9a4d2d5..24325dea5c2 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -2,7 +2,7 @@ quote_dep = dependency('quote-1-rs', native: true)
 syn_dep = dependency('syn-2-rs', native: true)
 proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
 
-_qemu_api_macros_rs = import('rust').proc_macro(
+_qemu_api_macros_rs = rust.proc_macro(
   'qemu_api_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-- 
2.46.2



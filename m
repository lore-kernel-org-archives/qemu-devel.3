Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B012D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzND-0006BF-7X; Fri, 15 Nov 2024 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzN7-00069s-BV
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzN5-0002IH-JW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0jH9GG4Y9DVdkqF6zGXUYSm5Vmv2IR3Nw21G/qghzM=;
 b=XEZzG78UR/GBztJBa12hl4YzDU1wkqSpTr665Diog+DMG9UN53FAnR9w+xzCk7y9gBoQFN
 AtDWzAgY+kn+tBhc8LiYff7unstpPND8dPiLjTuTOWdkBa38ZVqfindPd3bPvs55CofGt8
 nSYXaE77nhDwu0VZDwRBynCkuK2/JGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-KCK9K-OVMpSnh7tqZv_bnA-1; Fri, 15 Nov 2024 11:40:33 -0500
X-MC-Unique: KCK9K-OVMpSnh7tqZv_bnA-1
X-Mimecast-MFC-AGG-ID: KCK9K-OVMpSnh7tqZv_bnA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159603c92so13679235e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688827; x=1732293627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0jH9GG4Y9DVdkqF6zGXUYSm5Vmv2IR3Nw21G/qghzM=;
 b=eBu8XMfvEm3hiwHdsnw+bZEj9wsEB0jaQGKloBBjCc2/qzZISpM7OWSmh/0ZFSo9DP
 j4ieHMqf82WIlZnlCgVy/yfjI93Q8GewFJIAqz/XCj0Ci2lmgYIXRnYZYk9wmQUWAoRh
 VG9nDB7IlhON7TtZnVPK9I7w3fbVvqwlYKqxG/W3ETOVVAqGOGkEVKUprpe5cNG6GOYP
 oVUm0ceqQd+KWYZhIFgabsBsJs1HtcQ0sBK8/yF1uJ/q940P/dSUJv4IJK4nqHwbGqt0
 Nntf1EyWziX4rTg1aT2bHRr2SHTAjqn848a4rVEYOWlMcjO+d+e8VqnbhXAiE1U3Ib4I
 sr7Q==
X-Gm-Message-State: AOJu0YxFzeirfvh8zpEmD6fa8Gg21wDpexeMXTTj6ki1ZRP/LLVtwWme
 Pf+1FqwAEDCJU9kR/DoEjNQM9saRsldeBfKX71LqmAopwBwDTJxuI2mdpmnfuIImkL3DUZZCYMC
 r9geNtGqConoik8Yv9fsj4pTrXMys//XxNcDee9c/Vr8uDVkGcAQXrssx3UoRgPUVUHa7/adR0W
 /hjAqd/3h6K86njBFXd5FsIT7PZBUGoGDb0TJl+CY=
X-Received: by 2002:a05:600c:c08:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-432df741a8bmr31015985e9.12.1731688827310; 
 Fri, 15 Nov 2024 08:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBKskmKUgKodxYS6R/cBZhBf0NpqATQwq/de+/8v91CxLYcSq5FmIQyXdc0P7L+2GmjRASdA==
X-Received: by 2002:a05:600c:c08:b0:432:7c08:d121 with SMTP id
 5b1f17b1804b1-432df741a8bmr31015755e9.12.1731688826890; 
 Fri, 15 Nov 2024 08:40:26 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae31083sm4767995f8f.103.2024.11.15.08.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:40:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 01/12] rust: apply --cfg MESON to all crates
Date: Fri, 15 Nov 2024 17:40:14 +0100
Message-ID: <20241115164025.1917618-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

We might have more uses for --cfg MESON, even though right now it's only
qemu-api that has generated files.  Since we're going to add more flags
to the add_project_arguments calls for Rust, it makes sense to also add
--cfg MESON everywhere.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               | 7 ++++---
 rust/qemu-api/meson.build | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index e0b880e4e13..a6172524287 100644
--- a/meson.build
+++ b/meson.build
@@ -3422,10 +3422,11 @@ if have_rust
   # is safe; https://github.com/rust-lang/rust/pull/54675 says that
   # passing -nodefaultlibs to the linker "was more ideological to
   # start with than anything".
-  add_project_arguments(rustc_args + ['-C', 'default-linker-libraries'],
+  add_project_arguments(rustc_args +
+      ['--cfg', 'MESON', '-C', 'default-linker-libraries'],
       native: false, language: 'rust')
-
-  add_project_arguments(rustc_args, native: true, language: 'rust')
+  add_project_arguments(rustc_args + ['--cfg', 'MESON'],
+      native: true, language: 'rust')
 endif
 
 hxtool = find_program('scripts/hxtool')
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 6f637af7b1b..cad9ac4844e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,4 +1,4 @@
-_qemu_api_cfg = ['--cfg', 'MESON']
+_qemu_api_cfg = []
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if rustc.version().version_compare('>=1.77.0')
   _qemu_api_cfg += ['--cfg', 'has_offset_of']
-- 
2.47.0



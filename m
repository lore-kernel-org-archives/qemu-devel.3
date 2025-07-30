Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8073C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEvo-0008Ki-AL; Wed, 30 Jul 2025 18:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvT-0007xT-Qy
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:32 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEvR-0002Ih-IO
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:05:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso187521b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913128; x=1754517928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98pntvYuQznppxjRtjI3xXWWjmHlHvMSZIbn9K3Czdw=;
 b=dKxzOo6NVWOCh3/ONqLf+3Dgr8w6YFpLA36NuggQp6Ms32lmpP5zi3KPGJBvz4A8Lh
 JpGUA7XdHcxTXrurw8Sm6c11IvU59MrvvdMdOPklM+AIhLEGTD+iFw57QLW4vteG2vB9
 69z7lLKwwkUpPyoisjoht2CjDz6XLnyFfAbgOnwevNlwXZqp8CMp8eXMU4x4/IPTu72B
 eF8Ud/Wrwu9ZjZmiqBsvmJKnxwYlkZoCzinoc0LXnYHOZdXAHguWW/vBjDcFZmqo3OZg
 cfiufVyHN/WgulPUydLSDkO9i3Uz7FydfyC+4D35YKSrZGDM0p6XbBFT8BsEjDKM36TK
 LD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913128; x=1754517928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98pntvYuQznppxjRtjI3xXWWjmHlHvMSZIbn9K3Czdw=;
 b=Dybh33VyjfYW9HX3YwWCvmo6C8HBopKtGlJZ4MDiOorsP8m9IXQIeCFns58NCbUtk+
 aBuhSoFFsXa0f+ifKRc8xQf1qeXaai6+uvD/HTVZ/LWqfKHJwE98K6/U+1CJ/G9kWc4b
 whWr76sbA1BrPsfm46lPQ6bzjojx6JgvKwWTdtoD+55hsWHO6wvbXttCo8H4OoykWXst
 v1x1KhHZ3wwD5awCilwOUOg6BV4xwNEzH8MawZLzpSOFjZ/2j4OXMOCr3tXTdGARM9kB
 gpiXdeGKB9gzwZEUCTe1scxJVyHZxAm1MLVHrgkW9E/gqjSCFEwMEZE9JyXp9Psu9/Hf
 Xn9A==
X-Gm-Message-State: AOJu0YxNGPobJaIDnpz9cEdpKVtKjq3ytU7ZKTkiSpyGNFm3/97B6oEh
 0RyjmNgD2mgVeiHFvP1b0SE7v7pORZ6Y+YNZfSY0xqOqoB7uZNckOPVv2Kwdo4WFRthuz25Xzau
 7NKHX
X-Gm-Gg: ASbGncus3Rvjj9pWfIwAq5VXeTI1aiZjrDATP3mM7J1PwcmLZEyUNkD0wDixjHNGcgz
 r2nlSHLRmDCjHQm4Gs140+CYSpae2IEb88axbSJBnydbHZwo/aknyB2rUJoi507ZlWGbg8EPGCd
 avmi5PpUOobV3V+CAxo/lHXXxZuoIsO3Cwk1ytuwMQbNVca7aduPMoB0t81V8nicTLLTBNKu8yG
 s+Mqy+dCDDtqdZPARxdJW0ZDThht27pZc5K9NLT6V5/6+lpwmtv4MC+j8lAwVsxqM3xK6blqOGN
 5e0iqIxnDjhtgJL99GhegYriMoY+pHCDZd+HapZCw6fJGPuX6w2db/w5cKdIacX0Y40Jnx5uPvu
 fCNTI5AEJ6Q5qcHZXVwBloQ==
X-Google-Smtp-Source: AGHT+IEU5eNwFJHvBra+T4boIIjhmLHVcGF5DxzrDkOD9WuLEeCdxyUpyheVaSZ0fQCTAF5o8QWaGA==
X-Received: by 2002:a17:902:ce05:b0:237:e696:3d56 with SMTP id
 d9443c01a7336-24096ae52cdmr72371225ad.32.1753913128014; 
 Wed, 30 Jul 2025 15:05:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241afb7037asm1266325ad.0.2025.07.30.15.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:05:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/3] system/main.c: compile only once
Date: Wed, 30 Jul 2025 15:05:19 -0700
Message-ID: <20250730220519.1140447-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
References: <20250730220519.1140447-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build        | 4 ++--
 system/meson.build | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index f94209bb301..b72d4ce8618 100644
--- a/meson.build
+++ b/meson.build
@@ -4420,14 +4420,14 @@ foreach target : target_dirs
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
-      'sources': files('system/main.c'),
+      'sources': [],
       'dependencies': [sdl]
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
-        'sources': files('system/main.c'),
+        'sources': [],
         'dependencies': [sdl]
       }]
     endif
diff --git a/system/meson.build b/system/meson.build
index 6d21ff9faa7..f358c2c446d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -18,6 +18,7 @@ system_ss.add(files(
   'globals.c',
   'ioport.c',
   'ram-block-attributes.c',
+  'main.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.47.2



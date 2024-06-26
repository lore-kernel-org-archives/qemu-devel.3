Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D8C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 19:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMYeu-0007Kx-GY; Wed, 26 Jun 2024 15:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYeo-0007Jg-8I
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:18 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMYea-0002gx-0E
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 15:50:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so4398433a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719431395; x=1720036195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vMo3UlLl6VRZdyC9VDGZj9tzgWdSUl3nVhPo3xSdwU=;
 b=YLkr1d7DHIdGWi5IRzaGTBwuffiwWStXzo5TKaXy+rJGHO+UXh4z7SQqw6SBqeYElj
 Syt73TgdySianV37fIrzKKr/XqQwxAUdZzSkFA5sRVrlAS5vYqzei0+k1bf70J879JiW
 Y+PQmt+APdC76kF3F10I1txXmoNuj3Ue0F8J5/rJfWxDp55zAyBbbm83Y7hmhjbS2PcF
 AnbyETkwX466sryNZ6nA8TAoZRGQVayDjSc9g3CbIQREbeLNjC6auFa5zIHewC5SmqeI
 bqf7WHyPf9qMeLsIVEafAnXZ3axLKiUr5jGxKIBZlUS/ED0l+n7l9+1Svfs1bkv5HgmF
 7wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719431395; x=1720036195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vMo3UlLl6VRZdyC9VDGZj9tzgWdSUl3nVhPo3xSdwU=;
 b=n1pOmQDym0RYIYnyeXh/E+0JKesDiJvC46yyM5FYAMa08LWCxoy4LV5X/kLakhlKiG
 NSm0SBUnFVLMHFgTkZTekYUwHgsMZGsklQQxVN4p1+yKnnHu+Md332FGi7AKKDEQrndK
 k1GMXimBttqNnYsL6/oKIPUKIqwykuqX+N3xMdPKj2S+4+5OI8FWpC3zA+tUoOoG7Q6s
 4nWA+jcQxYLJp4iiZYS+3zT13hXvlU6FYpzcXAecnqW56Vg9mHrIcTZWSAah/2/hd1nI
 5gS26JGDlZNxI2ybCkWuaK2HSr28Ni9dvBEfyLFSZmCP4iT3uCY0481mOHs+WSTgzBjX
 EJtw==
X-Gm-Message-State: AOJu0YxLzXxDvryO8+xLeSIB8l8YuUYu13haBjGwh/cwoWuakJZIrnnc
 TPakDczQJonEh7tKBcKm12kgeg9buKL+xFpInp5uxUAGGQP+lB5oFptR5M6vAhEkJX1jnBSGHJ9
 G
X-Google-Smtp-Source: AGHT+IE7vlfjXqm0G4JjyZb39a7ACOjemljBHjSvttpVJoIvSXdbteFGxAA03Dm1OncSa/BFHVnRCg==
X-Received: by 2002:a05:6a20:bf02:b0:1bd:272c:d17c with SMTP id
 adf61e73a8af0-1bd272cd2ffmr4267989637.12.1719431394810; 
 Wed, 26 Jun 2024 12:49:54 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb2f0318sm103734625ad.2.2024.06.26.12.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 12:49:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH 3/3] target/i386/sev: Fix printf formats
Date: Wed, 26 Jun 2024 12:49:50 -0700
Message-Id: <20240626194950.1725800-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626194950.1725800-1-richard.henderson@linaro.org>
References: <20240626194950.1725800-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

hwaddr uses HWADDR_PRIx, sizeof yields size_t so uses %zu,
and gsize uses G_GSIZE_FORMAT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/sev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f96301f81f..74ed9948ca 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -932,8 +932,9 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
 
 out:
     if (!ret && update.gfn_start << TARGET_PAGE_BITS != data->gpa + data->len) {
-        error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
-                     "got GPA range %lx-%llx",
+        error_report("SEV-SNP: expected update of GPA range %"
+                     HWADDR_PRIx "-%" HWADDR_PRIx ","
+                     "got GPA range %" HWADDR_PRIx "-%llx",
                      data->gpa, data->gpa + data->len, data->gpa,
                      update.gfn_start << TARGET_PAGE_BITS);
         ret = -EIO;
@@ -2146,7 +2147,8 @@ sev_snp_guest_set_guest_visible_workarounds(Object *obj, const char *value,
     }
 
     if (len != sizeof(start->gosvw)) {
-        error_setg(errp, "parameter length of %lu exceeds max of %lu",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " exceeds max of %zu",
                    len, sizeof(start->gosvw));
         return;
     }
@@ -2184,7 +2186,8 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     }
 
     if (len != KVM_SEV_SNP_ID_BLOCK_SIZE) {
-        error_setg(errp, "parameter length of %lu not equal to %u",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " not equal to %u",
                    len, KVM_SEV_SNP_ID_BLOCK_SIZE);
         return;
     }
@@ -2221,7 +2224,8 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     }
 
     if (len > KVM_SEV_SNP_ID_AUTH_SIZE) {
-        error_setg(errp, "parameter length:ID_AUTH %lu exceeds max of %u",
+        error_setg(errp, "parameter length:ID_AUTH %" G_GSIZE_FORMAT
+                   " exceeds max of %u",
                    len, KVM_SEV_SNP_ID_AUTH_SIZE);
         return;
     }
@@ -2287,7 +2291,8 @@ sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
     }
 
     if (len != sizeof(finish->host_data)) {
-        error_setg(errp, "parameter length of %lu not equal to %lu",
+        error_setg(errp, "parameter length of %" G_GSIZE_FORMAT
+                   " not equal to %zu",
                    len, sizeof(finish->host_data));
         return;
     }
-- 
2.34.1



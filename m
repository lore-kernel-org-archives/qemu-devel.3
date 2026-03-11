Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9BFD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09Iu-0000s4-7n; Tue, 10 Mar 2026 22:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09In-0000rX-7E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:01 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w09Il-0003ut-KR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:28:00 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-128d2e3082eso2183233c88.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773196078; x=1773800878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiG3n0FUiZLtCy2V6pbAyek4IfD7I/afMmGQ4E7hyPQ=;
 b=IVNPjOXdOGnjyY2PEU5z9ea7FmmXiC6Jj+VZLaE3zmJmZjJFhNK7e59Z16621w4fIG
 Bi0l/0r2CJ+C/FkqejRmEADZKrFZ0rYOxX1nnHWboHx+duSNusW3Ifm/3cCw+iPQR7ZV
 2MGzPp5F3khVuymCMYScPSh6uAZS3DoiAXk9XsZK6yyGVaic45gvA7CC8DpjzB40HMCy
 0whSfWO0dAruZ8FrYNjhOU5DRwf5jKmf+RPQtNQIK+buaUvIO0bTWE9hbSthdXnMxObh
 ZDtyXaDSqc5E/0q/0hLD5yVpvX0FJ4WcDhtq1HgmTtSChIjjnnF/MxuRbMDuBZwGOd4N
 LWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196078; x=1773800878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wiG3n0FUiZLtCy2V6pbAyek4IfD7I/afMmGQ4E7hyPQ=;
 b=DuEH9w6NplippqfwVDwnILGo+fMzmvD/DlOIBbJZia6kLXCeDDyLK2c6nz55AyGXVJ
 HL5bvwvy5w0jasMIeUIKMv2T/IuwtrVOLIKOT3tRXk3pvuaUpnvfnzJhqYY5wnREX4JW
 ++/ZfIaRBCVxAvWMJ/UTWaCpZV+eUA7JwbxQRU9ebQJ0uLAKEW4NCxLD2MuG04g1Efs0
 TC4oUpm4OFdtxNR8J4AiYLKEKnSSaGhAy1N0owoZlhv3cfewkZBrj+J+AYI3U3RjD0xh
 f5sn7Arx96RouKGCdNqjMRGhwac9HIwFuNktANm4nhGVWFAsMGkfalIUZCpBXgdFqgkm
 E4yw==
X-Gm-Message-State: AOJu0YzZY/R47J6OSjfmrz8+6Aziy+tKbGcvx5R+kCNRPJKQDS3Qo2FR
 iiqokVFmhvHWFVBydrYqU7O1zZ5KioGYZLqAa8At/bCaE7tb4Y4Sv9mMcQV6nQ==
X-Gm-Gg: ATEYQzxVI9v3904UqD7kmYq4mEQidxYbMaCtskE2O8nA+RSleMt1FLlM96WVlRyHmhY
 12tuy5Ogd0F3ysemToe5O4KURGYk8xFzglrPPXtJngW4MzeUb8xPlnak+UWCTC6uPJ2suzuGMWn
 qFPxRUz/IFBVbEzvp2IaQ18EAfmuZ2cETOPdR4G65XrvPwUjb7CzpJgL3mJXnKX4UlGInc+9ulr
 wjZ3hjj7hQJaqudyoKryCb3kFjrzWrNPkUqspNFmBT2yXL+08WCfTjVfYCmO47d8Aoff8NUuqTB
 O0jIqNRkuMwCnUdwGojQfgDzPDgfyDEfssqUYAXGEv/1TTvREoW8aTYEyieehOnjqoEIgVB52HL
 9V9v06a3MYTmkFRRKYGp4MBqb94I+6uTd4YYQSavVv3mrfzv3poIYgKy+5JHNkNdKneNre+mY7W
 TQCw4kHHs2Tq3joMMCDrZdsKxXjeDc0cQ5HXbO5YGRV6XdDUx7hMI=
X-Received: by 2002:a05:7022:6ba7:b0:123:34e8:aec2 with SMTP id
 a92af1059eb24-128e779ef68mr477285c88.1.1773196077863; 
 Tue, 10 Mar 2026 19:27:57 -0700 (PDT)
Received: from 192.168.0.29 ([2804:14d:4c71:86dd:80a9:8ba1:b664:ae3d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128e7cd6aafsm915123c88.14.2026.03.10.19.27.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 19:27:57 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v2 1/3] ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
Date: Tue, 10 Mar 2026 23:27:50 -0300
Message-ID: <20260311022752.64192-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311022752.64192-1-lucaaamaral@gmail.com>
References: <20260309214930.92616-1-lucaaamaral@gmail.com>
 <20260311022752.64192-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dl1-x1235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_BARE_IP_2=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Define GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
Vulkan scanout support.  The compatibility check currently returns
an error indicating the feature is not yet implemented.

This prepares the display framework for direct Vulkan scanout
alongside the existing GL and DMABUF paths.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 include/ui/console.h | 2 ++
 ui/console.c         | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 98feaa5..6b8bbaf 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -361,6 +361,8 @@ enum {
     GRAPHIC_FLAGS_GL       = 1 << 0,
     /* require a console/display with DMABUF import */
     GRAPHIC_FLAGS_DMABUF   = 1 << 1,
+    /* TODO: require a console/display with Vulkan scanout */
+    GRAPHIC_FLAGS_VK       = 1 << 2,
 };
 
 typedef struct GraphicHwOps {
diff --git a/ui/console.c b/ui/console.c
index f445db1..76d54bf 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -594,6 +594,12 @@ static bool console_compatible_with(QemuConsole *con,
         return false;
     }
 
+    if (flags & GRAPHIC_FLAGS_VK) {
+        /* TODO: check for Vulkan scanout support in display backend */
+        error_setg(errp, "The console requires Vulkan scanout (not yet implemented).");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.52.0



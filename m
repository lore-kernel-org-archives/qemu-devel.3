Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD60ED0D14B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXvV-00018L-O9; Wed, 07 Jan 2026 13:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXuX-0000ZG-GH
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdXuW-0001Vc-2M
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:05:33 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so19619375e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767809130; x=1768413930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DzIy/XHm97e6BW77fesceuKuTKdFh/p6Y6ja+JKUoE=;
 b=eueZxttrcP/5iWzEUyKl2afeqBlBOi83px+1WTPpJyFU4kEaL+lBhErbG6iZ4Lu7U3
 vOttcO5lEVvO6JKp47DbKI0jh9lC2uAxxlM5yMP1lAEJqiJl82q/DwC+U0+gNwbxnVQu
 kbHYYLcF+A6+FS0lKiOFYjJA2OVi1l/TyMDCbjP7Z37lViwq7qMih/O0qZlfBS78bFy0
 B9KiZfBQ1UfHPlLyPIV0sd9pelw+ZjQ+mGOVxakzRSZSC4/vQuFTp0x9QjXTLX3AQ9C/
 lG8jK0YdqMg2MYgOMTD+60Ctcgk6KdSHcU3aXphf6s01/x5U5kxd14+Nn8CVOBpgu6kE
 CYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767809130; x=1768413930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3DzIy/XHm97e6BW77fesceuKuTKdFh/p6Y6ja+JKUoE=;
 b=v63LAdta0HOuTN829iQsF0bWa1tGRgk08fnrcyZwbzvWSO2rOa44OX75QryEWVckNS
 tyLu6YCuvLIv4OYkVODT84u1s3LJOk4CrnVIxwcQfdngylOMaeLObsfBGlj1BS29T86X
 l9D2aGWDVjgMGrLR6kzWLq6gG9U2xkLE8K6oVrX5nJjROrAXE2pIs3z8k9WDz1y7lbLt
 A5ztm8tXMe5s7BNxsiyHLg3xPvp946pb5UPd53SORBzrpsXBcB33fTF6KUsson3UG+yv
 1941+wtwM29ucl+lw47TY68xmVkOdA9R3eYoFSS4UK8C+rGbkjS5Y9MUucsorY4V1n+L
 a0JQ==
X-Gm-Message-State: AOJu0YwrNbHHT5d/bBITHIIVMKvSldZXpOZQcLYOzxBRtXRvjjc4Phg3
 oKI69h5NdcsSUi+2hH6CEJ8UDAKFgXE+r2zUrEO1OZlXHWg3bDVMFVgTwtSjZMefnIPvF0Kr5zN
 NWbSIF9w=
X-Gm-Gg: AY/fxX7/ZvSAaqRBNyZkLoeisUqLN1R+nVLOOUVfcd8Ykh0E+Dyf7HIyHj2AMAKrdo3
 BROIs0+Rwm2K/JLm6EFR6uiYMF11UsqTyowB+hqlNPDxOzcbRUBBhkbOL5qru2LLgZ9iEo7EzcB
 EIjbXH7Xsj2iFUQJaaZ97ANvy9TsT6Uc558wcGfGJ7IvEowusg5Ej6oNLoCJv2FhLJ07+Hq02L7
 ONQUWnyjFMX0+cZ4PNbogvTg4AOrAbWBzshr1aUvw5XLh7Zndj3gmu2TdCUBRO7id06ZaavdCup
 1U8iZK+6nsI9JLmHXq73u+PpUzNClbK5DK3xgpGcMKKAJRDDTPSn0Z2QfiDlMb+EoHv2l6Q6Knx
 +InfJc8EKn9XnI4hsqthKq9+CR3CPKD69iNXqn4TNegJXNkLbEK/HzFVjORAUiQD11XeCiaGiAd
 NkGaITFm7B8FPs8zHLWcZgmFDj3+CmPYN+gWrKVWE07+KgxoYSl/Ijt3gZFDH3
X-Google-Smtp-Source: AGHT+IGMMihLCLawKP3rJmukb2C81Yb6l/qmuA8X0CILtBPhIvGXZBPF8iB013ZZJD2gT+WyAznWKA==
X-Received: by 2002:a05:600c:3114:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-47d84b18954mr39230925e9.2.1767809130122; 
 Wed, 07 Jan 2026 10:05:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm113035495e9.1.2026.01.07.10.05.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:05:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] dump/win_dump: Abort in create_win_dump() on non-x86 hosts
Date: Wed,  7 Jan 2026 19:05:18 +0100
Message-ID: <20260107180519.50820-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107180519.50820-1-philmd@linaro.org>
References: <20260107180519.50820-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

win_dump_available() reports an error on non-x86 hosts
when Windows dump format is not available. In that case
win_dump_available() shouldn't be called, otherwise this
is a programming error: abort.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/win_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd487..6e07913dfb4 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -489,7 +489,7 @@ bool win_dump_available(Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
-    win_dump_available(errp);
+    g_assert_not_reached();
 }
 
 #endif
-- 
2.52.0



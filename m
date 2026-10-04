Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB04CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 07:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDGfL-0001RY-MZ; Sun, 04 Oct 2026 03:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfJ-0001RN-Q8
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:45 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xDGfI-0006Cb-Au
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 03:29:45 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-33be7dfcfc1so967341eec.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791098983; x=1791703783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W93lTEJmQ+iEzwt2QXIwYHNqGIqs3rPxrdymVNr2LiI=;
 b=VwTzOWYv1bahmWGWh0qA3NG9jUO2cTQF7Piq07/WlgOx17gnhEA8OngDdIv3boBnKu
 8SgCwdcNNST6/YLif2DmpJtb0Oo8yg3xAy1utWdtV8WjegcwOUSQHiEgESQA8cGBBo86
 czS4KndAUzeiLy1xkyBKYB32KIIRkT49kyzdGVwyXSVB6mJfCDAvbi8Z7g21DDAin13m
 8XxHDbBEQze+WTKgrRUDoBpV5PDBohjil/zuYsd0x3EiibqmbyI61nYAzbHT6bI/qGSf
 b119RWn7mC6KeAOE9w1wX//lRZaXBH8zuCcjOj98VxmYM1L797b6lRTS/EL4w6MOSefq
 ZHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791098983; x=1791703783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=W93lTEJmQ+iEzwt2QXIwYHNqGIqs3rPxrdymVNr2LiI=;
 b=eOgFWF7Ei5cB+TFHxw8El/kglFIis8pcYtL940YNuSFXfuHJZhTTqzhdrwDIgSyzD6
 F0uxBp7FvODsrfO9tRj9Q+qTEzLQWTDqth74rtH+sGE3CcYoiMr/D4zRvTwwWlMETFsS
 JD0DdfjJ0/r2TUXbD7MRsOtBjU4z5mikIw2HhrcgoFDmQyZrvQhgqOGOJbXWydgabt5o
 Gj8oUi1OdgShHpL6aWVEHAF1u+s2N8ERJ6jELe8H5X6sV9Qsh8Hc6BslkwR2w0b/epG5
 g5X6MVoEG+5pLAPCkgaLCK0jPS92Wd2E9RbH1Ex5QuTXhSK+lPfN8k10UE6m0yf5BlBu
 vBjw==
X-Gm-Message-State: AFq9FYJOQWs9DQhAR+mO+PO055M9vanAyfY/16pmTxbcUq4DKcfgXcbW
 +C8fkQph73024WCRuiC7FY0Sb9Yt2RFFYQg9NLbXv+34jfspG21T+ieTS29Q1g==
X-Gm-Gg: AYBFou0bUCR2ChtQmPCZnwFX6xGuIkY7hkBqtvtRCR9J1nelV0gwEfwb5NYBYBw4OZm
 ihTVAyuFslkxw0EUKpB5un7ELw25UyXrHx+jZHqP9fMKmkaFDHY2GHHwXzhhy5rxo2JDUf4Ifnu
 TY0eSC6F0LP34gIuq6oATh1eBKVDyqF0H5QLhl9VQUH1VmE24P/sYefuNGqX3GEkaoX9j1itpTw
 J2m/Yv5MD0kT3GFsJXJlVivTaiTrYQjSi5PlfkGy1FzJwrC0frgJSN+oRTYIMiHf/DFPl+16j1x
 VcbMvUSJmEzRXU3FsuIGqeQg4MNS0X4fDnLSWN8GtHN5vB8FUXXcCh9ixqaXIyFtRopGCdrTH9Y
 +US0+KVe4YzzrTqTugOUn8IJw3NVRWbNyFv9hK5zi/AR2wtyaCWnntx83LrpMMzwzOseqv6jL8F
 SO/jsBP9i/ZVTza6tWOkcap9U/Hi9n6aerjsLJv7bfJR5aQdJH0fitvXfR74feLt+dbdKZt2+EF
 qOvEXtJJiGhOG/19g==
X-Received: by 2002:a05:693c:8854:b0:34b:c18d:c28e with SMTP id
 5a478bee46e88-34f1509eaaamr9041853eec.7.1791098982901; 
 Sun, 04 Oct 2026 00:29:42 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-351270204e0sm3036770eec.1.2026.10.04.00.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 00:29:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/4] Revert "meson: Add TARGET_ARCH to config_target_data"
Date: Sun,  4 Oct 2026 15:29:24 +0800
Message-ID: <20261004072927.1142-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261004072927.1142-1-luoyonggang@gmail.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit f87f7e145d63f93315e0f0e00fb9ba0b6ee8570f.

Fixes: e934c624f3 ("target-info: Statically initialize target_arch")

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index cae1591cd2..cec12f109f 100644
--- a/meson.build
+++ b/meson.build
@@ -3282,7 +3282,7 @@ host_kconfig = \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
-ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
+ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -3372,8 +3372,6 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
-    elif k == 'TARGET_ARCH'
-      config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
-- 
2.55.0.windows.3



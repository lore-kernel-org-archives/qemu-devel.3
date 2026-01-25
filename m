Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BEDD7237C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 22:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk8oG-0003RV-OD; Sun, 25 Jan 2026 17:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cingel.marian@gmail.com>)
 id 1vk8oE-0003R3-L6
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 17:42:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cingel.marian@gmail.com>)
 id 1vk8oD-0000Td-8Y
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 17:42:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee2ea598bso1985145e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769380935; x=1769985735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L2OhobGTV2SuDpKLlE0vqJOklwRhk9R23qqLgwH29TE=;
 b=Zi/Tva6rIyixPdzX+QwcEAz6YiQRN4NcBjSnDfy8GsvnNDQT03rBXbX1jfXFmwgOJq
 ifUm/ygh3tZNfFvvNE5L9xcRs2gFegx+BcMl4OQQ5wB2zL6AOrOtAU8rW6ggD1JXN3e+
 3iLEIlOaKuK+7hSC2jVZhFYefU8IffJUYKs92VIcI6Hx7+sw0ecr87k+/ZtSsQx/3sTF
 m7CpbWLEQuT7L6c9m3JAAUDD3HA9hh70hzba0O5oPp3eWhO1W9B5f7C6+Iu/n1KdXUd6
 nIibrlWq4QiXgAkXKRGh6n9Lue3Y+GWylHFcojCQ3aaY18qdWU8F+PD9RC5VYic4KxDf
 ZKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769380935; x=1769985735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2OhobGTV2SuDpKLlE0vqJOklwRhk9R23qqLgwH29TE=;
 b=ZbRXnDVdHG5q5BG4TTBmTqAG5K+Bqcsu3GTpr4I3JEVSwQa5ma8UHhdKztKhAtbiKS
 j2/BQg44A7HsKxnEjnf9K1Kc/a578R2xkuDWw/eduMR46yd+RlbmxHyuaOoOe1TxFFAD
 HiQiRa1rqScdiN8Pw5pS2AbvydSM6mVuuOMJJlv6atvXC27wVkMc2q9yN3f5Y1wkFydG
 NhPFUOXBSg/f34/H3agstdF3A/eqqveCE5cDlSHqA7t5N/C2VGchElqqM0bn2CDyOOHZ
 UXxiTSaH9E6ySUwCSYcS8zx/tw6KOdGi6kDGL++6fBUtceFZktuiy/TjA1oSEULPnxlY
 glqg==
X-Gm-Message-State: AOJu0Yw/mDtBzNsnqhqPh+19fvV0PxqGYeUAV+Ss7QvDwMEB+73bEZoD
 3e8JNdcWqh+2MS0QDkHpxXBH9SwWOeBh0pa8L7Al1vyTiiJG9uIaCeg+WVNluP3S
X-Gm-Gg: AZuq6aLMGCFMv7ieBekuKqc26x29CAiYpH+JjU6ECiK7wLI0iJA+MiIobpro9VN8B/F
 8Q3vrk8UMggfBpThzIZZ/aeRVUb/hEeF/RzlguEANIcghgsV4FOrK+Ci8CPqjGlv+xHISzxF0nD
 7hMAH+lRkL4JYP80Uot3DdG4kyMuo6btlhuB513xnFJn2h+VLrb/XF6n3vwDic93mivfOF++B8Q
 PMQ4KKoWSHTxMtLsvIoD75328r3EcE6a8Rl4UMcxv1pW/4oarB2QGMB6f/pP2RQUouv4UhPyxQ6
 HN8hZcaGh2oJGYf3+66ZxU+96ZMJ/gGwkDA/pbgVsxOXk2NyGE0qIefKQzr28eh9ZZG9+Sl0OH7
 4Zb333vDD6+woGpm1brmkqccjCuVS4fBM5QkuLVfG4CDspte88O+F33zoH9+tOLMRLELDmO6prB
 g2PpgyhOvyPYVEHIRw2pRJ49W8Flpz
X-Received: by 2002:a05:600c:8b0c:b0:480:1f6b:d4a2 with SMTP id
 5b1f17b1804b1-4805d06b097mr26638335e9.7.1769380935164; 
 Sun, 25 Jan 2026 14:42:15 -0800 (PST)
Received: from localhost.localdomain ([178.143.191.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470bfe42sm303115505e9.9.2026.01.25.14.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 14:42:14 -0800 (PST)
From: Marian Cingel <cingel.marian@gmail.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, iii@linux.ibm.com,
 Marian Cingel <cingel.marian@gmail.com>
Subject: [PATCH] meson: FreeBSD: make inotify dependency optional
Date: Sun, 25 Jan 2026 23:36:51 +0100
Message-ID: <20260125223651.798234-1-cingel.marian@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=cingel.marian@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

 - 'libinitofy' is not a base package, therefore installed to /usr/local
 - 'find_library' invokes clang, which by default *does not* search
   '/usr/local/lib', so even when libinotify.so is present in system,
   the detection does not work and 'configure' reports an error.
 - tested on FreeBSD-15

Signed-off-by: Marian Cingel <cingel.marian@gmail.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a84f14258b..ac1c02d7da 100644
--- a/meson.build
+++ b/meson.build
@@ -2661,7 +2661,7 @@ have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
 inotify = not_found
 if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
   # libinotify-kqueue
-  inotify = cc.find_library('inotify')
+  inotify = cc.find_library('inotify', required: false)
   if have_inotify_init
     have_inotify_init = inotify.found()
   endif
-- 
2.43.0



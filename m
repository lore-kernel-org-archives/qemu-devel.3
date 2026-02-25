Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28395FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAv-0007aj-Hu; Wed, 25 Feb 2026 18:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAn-0007Xt-G6
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:07 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAl-0003iF-NT
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso2342695e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061602; x=1772666402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QVDyuzhc97t1LUNB97ThaQf4XWW/8DfX7b92ae1+c40=;
 b=YTIg7oYCQTUYamFZ4cyd5NChjDzyty3coT7cghfT4SKZ5Q4OeqRw9PqS6NkToYer+T
 +Qb3x5GeqBaeap7I41LLot9uVQld/jAt07F08Gf4acA84CQXdlHPv/Pv2pIYMy97ga9+
 +gOGhOXOESHO5idUbyU1KDQO/2XoRsq2gJqYSpc3a/suTvhHTSGd70S64HxbXNRG9ee8
 Uopgrfz2t2D2mTFMJvBqY2EZcxBYYE4fUGgBPQTG8OMcPiN7oEs8vV/UcA4sF/p5BjLJ
 usWe9cOWsVVkXWH+8ejF9C9077JeTbXFUMRHCqRsrujZmX6O5Bdd8/ZVRoEVgX9xwJnx
 AJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061602; x=1772666402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QVDyuzhc97t1LUNB97ThaQf4XWW/8DfX7b92ae1+c40=;
 b=hcA+V54rSLTSzUGo2YXzmBBuouZUoYbWtac78312xgDI7XzDx5qjHsVbjEB3t8oOMP
 PSxiBVuDIj9FGTQOBKMV/RyMB4Cmy3rwur3Px79JzhBM6iZZldqCrbmvLxRkXzK2IGxk
 tE3xQLKgDwkvUu+wCrZm3Qg45v9p4sOvfZRC8cQZPhsOB/ZDMgJ60SqpwUww6+7rR5Qv
 0Xpdd4DFVfpqc9EBY/nGLkYNXupfQkHrJWLwJ0Bnm9Ln/acHajKUUwUz8B7J+91+GVUn
 YMaoghH6z7KEHYiJ4q37cEz8mw64OofTG9YFHohhiPxX2WSBHs5wzDHIKIliToEJE67D
 bBkA==
X-Gm-Message-State: AOJu0YyO7rbgDpk5EyQ13GQ7vS5FDI6NdnZLJAnhkSmTAw5a33wEzyEt
 NfH8oIQF25Y9GUu6XZyCrSGhZmQ7TxDxBi9oA/uuyYQb4m2/BSZCAPO4pk2PpmI8VsaST/BrHwa
 fKapOEgQ=
X-Gm-Gg: ATEYQzwPmA3tofip6AMy90S6aQ/yKUIHrxGz1iwdALRJ3p0XVC27R+qbXqxHLiGHMTQ
 qEV4hWVU4n7ozx6vPb3Xzw5/IsXRjorZW51hHINspetynq9W3z7LKFXrsCUlttgQuXG4w8Dx5js
 QifjmPfVNInM9IROvU/oIFVRMrcReHBha/tg6dEjQBEkc8WxfU38JRhvkO6ZIe/KR1bKJiZ40rv
 v5pBnQasf3v1SGrQPMnQmUaj7CyEK7muOxZLwKDWPBxLTSkG1uWBaQ+1dJ1XgwyHZ+QBZPoBJi0
 D3fMD3EH/4uhEgcajJLQcQ82STRGUY6O1QfX0hMZjgDVFVNQBc5WDnPXBGQOFhzowUoIJqnIqlK
 tbG4ZGYiAzsyTR3tGg5WL2CocWf8R2wiTQtuCCqpmbI0XgtBHQsTIhdBUes869quVJzXsaI5J6b
 UT7NaTVziRODtPxcbvX0z5yagZErYKqss1+gI/Mku+2sTaJXgp3aNxkCn1yhEUk/feTYVyc1xq
X-Received: by 2002:a05:600c:1f06:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-483c21764e8mr31451095e9.11.1772061601857; 
 Wed, 25 Feb 2026 15:20:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7030b9sm83195515e9.4.2026.02.25.15.20.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/70] target/alpha: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:51 +0100
Message-ID: <20260225231411.96482-52-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

There is a single qemu-system-alpha binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-44-philmd@linaro.org>
---
 target/alpha/meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 9447f8020be..818256a1c31 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -2,7 +2,6 @@ alpha_ss = ss.source_set()
 alpha_ss.add(files(
   'cpu.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'helper.c',
   'clk_helper.c',
   'int_helper.c',
@@ -11,11 +10,18 @@ alpha_ss.add(files(
   'vax_helper.c',
 ))
 
-alpha_system_ss = ss.source_set()
-alpha_system_ss.add(files(
+alpha_user_ss = ss.source_set()
+alpha_user_ss.add(files(
+  'gdbstub.c',
+))
+
+alpha_common_system_ss = ss.source_set()
+alpha_common_system_ss.add(files(
+  'gdbstub.c',
   'machine.c',
   'sys_helper.c',
 ))
 
 target_arch += {'alpha': alpha_ss}
-target_common_system_arch += {'alpha': alpha_system_ss}
+target_user_arch += {'alpha': alpha_user_ss}
+target_common_system_arch += {'alpha': alpha_common_system_ss}
-- 
2.52.0



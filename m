Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180B7107637F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7wet-0005Lb-O1; Wed, 01 Apr 2026 10:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7wes-0005Kz-FB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:35:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7weq-0007Wg-S5
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:35:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso10860725e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775054099; x=1775658899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Md40+5kYZlfKnMTHjZ2kpDgAcX0IqvvYMq/j3/reLv8=;
 b=SI3VglIj4CvP8GEZoUrjMp2tEn40REZCw2bIUteqeefj1rFc1VTQ+XWCBlKhSgWbpa
 9Ll5nubEBdDItvhWSSG7XV4HHiOA4FTdMcATzxUg33hYvY55h/s2vfS8T1o81Wi31Kpv
 vkHK7yqINFhPDa9y4xj7Q8Y5rtDaDtrtG/M9G2w8sSc7txYLnZZKGOEA8YePV7ILy3Al
 CXt5Unuw+LaIPwGWnxJQXQtmoTgYh/CQcUKPD8ZMzSCsOYqy4Z7XrIp98uQIDehkKwsA
 X+a4XPmzW+ajAgtlDsMaNWIjjdAppqFeUw2plGW86vfbl9Cls0yBUvtcs2brROQLRvLb
 Rzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775054099; x=1775658899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Md40+5kYZlfKnMTHjZ2kpDgAcX0IqvvYMq/j3/reLv8=;
 b=Qm6PYLBw5Bj0t+kb8AnIDjDW8IJKsD7mwOlibvFTS38IjSRUWj3LCV9wdRZQTLN1Tw
 4Ufz5lwkhdXgXm3Kq37AxmAaCnOeFi4lZvjCbPNOpbFCf/rV2jhd20qCEgg1iA6okrZj
 NpMPq7GUeCZZqVgYf2Zt8QRN6ewQ1C96bl7I52F6P/oi3VOJQ5xJmlWrJqlkRQRittcB
 S9doygIYhU9Y4/4HJociQ9eFIp3s9afIBdfHl3FubEJvre+8ZPFOci9XMjZX6aZMk8/2
 fSfAqlx9vd7vZfnyI9z3cADKHJCI88V8xbny5vLkyEzmSpIYmfDjcw1InksSEwwRTXUw
 wzmQ==
X-Gm-Message-State: AOJu0YwCa+Ifc0uv377TyqGGgF5JowAVgq7eXovG6VsHvrqWeq5gt7Zg
 fmDSuMfOVFKmzGpfT+/S1fM4oCWZETCmvLVq/WHzBgQDL4lmAynFLN+RdYyiSNzry2iHf4tm2A4
 L3NO5pas=
X-Gm-Gg: ATEYQzxPt0zehZHOu2iSItFq0DyHYQjCbi81mDeLChOMuJzuKmmxBNTkOyow1noWzAU
 5u7AaQf6UJmF0pFU8XbFWIGl9GT9SNuvouIVSnkn4K1kIg9aQixOEI+AUpq6F8syaeICqVytBMK
 nVMt1SjL4mWH1c6KiWrxgY1PAYW7xMgaTJez8VwBdjrPq9JEXizVKDCIELJDRMw+oPVVFDYI2Ax
 wyCpt+cT4jK7eNjL3+H5VCA3F2QwRCRBnpei0jglouDuXMXXUh2vyZD0zHeTg2atoJbsh3eeIfF
 3D26ejgRgTcTMmvjHJj6MwtIiL80PuJstbELatUsRwtGY6DBlhcEqmFieUa49RjYX8drovzP/Yy
 3rCGeTuVouHpIYDojTzWN1EffAKVay2u7kOLzWXmszIo3Iq23sEagt4kqWt/HrZ9ZMYE1apZs4g
 dCvy/KmnHYQUFoQiNCya5xie+6xGJaRds6FxnYRYytIn/8q//7hnBKJ1Hl4z07RAZeFoafzrmw
X-Received: by 2002:a05:600c:1551:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-488835a15d2mr66049565e9.10.1775054098647; 
 Wed, 01 Apr 2026 07:34:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a705ebdsm2517665e9.10.2026.04.01.07.34.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 07:34:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1] target/arm: Replace target_ulong -> vaddr in
 guarded_page_br()
Date: Wed,  1 Apr 2026 16:34:56 +0200
Message-ID: <20260401143456.79843-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Following commit 15500df3b3b ("target/arm/tcg/translate.h: replace
target_ulong with vaddr") change, adapt guarded_page_br().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I know this expands to uint64_t on Aarch64, but vaddr for $pc
seems clearer, since this is the type used by callees, i.e.
probe_access_full().
---
 target/arm/tcg/helper-a64-defs.h | 2 +-
 target/arm/tcg/helper-a64.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b6008b5a3ac..3c3c5dddb7c 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -131,7 +131,7 @@ DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 
 DEF_HELPER_FLAGS_1(guarded_page_check, TCG_CALL_NO_WG, void, env)
-DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, vaddr)
 
 DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 2dec587d386..a7372aa6bb4 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1735,7 +1735,7 @@ void HELPER(cpyfe)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
     do_cpye(env, syndrome, wdesc, rdesc, false, GETPC());
 }
 
-static bool is_guarded_page(CPUARMState *env, target_ulong addr, uintptr_t ra)
+static bool is_guarded_page(CPUARMState *env, vaddr addr, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     return page_get_flags(addr) & PAGE_BTI;
@@ -1765,7 +1765,7 @@ void HELPER(guarded_page_check)(CPUARMState *env)
     }
 }
 
-void HELPER(guarded_page_br)(CPUARMState *env, target_ulong pc)
+void HELPER(guarded_page_br)(CPUARMState *env, vaddr pc)
 {
     /*
      * We have already checked for branch via x16 and x17.
-- 
2.53.0



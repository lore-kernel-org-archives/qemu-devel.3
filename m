Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5264F10F284E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJs-00077X-Qu; Fri, 27 Mar 2026 12:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ4-0006ef-HI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIz-00039k-Nk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b07069e2efso14418265ad.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629901; x=1775234701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvXc5w4/HrhK32EYEuNiFYOfrNSSsMEH7KaGOeb7ixs=;
 b=UW1ZJq+dBmZXXBlWNJW75P64+aIbJgPBeZeqRU2lO3bVmvIhJzAmeMrf8BY5vbFCbW
 vWhdDBwSJbO6Lg4cfaNjwwRqSigJZWYdrPDeSlJBTzw6Xh9oiJbRDkfAWF22h7Cj0P8U
 UeNqX/W6e7lmvoAkb1Ox5IuT8MGkG6G2Nbl6w3YgbaMyV8rE2U0GxBLMUtwPLsfTURfc
 ygx+A37/2X3SAA6Ivio4FDeAZGucpTJRFRWZTGzCPRHC/pMWGwlEXVe7dxPuElCPucNr
 dWgZ9VKdy8nL6q8TCB6vWobSAK9UvlWl5dpuC4BJBVBekaNjwc2xQYJNKK8u53xHiaex
 GFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629901; x=1775234701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GvXc5w4/HrhK32EYEuNiFYOfrNSSsMEH7KaGOeb7ixs=;
 b=ok7MyC6UtSvsbiu5GO440sDUxvYopaIqdniS3+cvygBU0DhMuBmeW77rfz5vxAhfoN
 PK2iBttLFvptwHU/Aw7qkxZU1g8bKHBRuv64bQTPpGyrj8r8WPWHwYXbwE2puYwRowXw
 HbcdgTByyqRkhghon8FiYoj5Rbo0W3koOWx1FzRF+KvX+0n9Ya2z7kCJNj84IDWQDpX2
 UiuMF6ayqY0x1cVASTDAVxjT4kJGbpTh7m25glzlZUcIrBb3JKVFX7NCQu6KIMVn7OVS
 h1KgcTfqCZg2AilfwiXhDRyJRS8QTS+je+id1yOPb4Tso8YNCHpu2SsLFJca9cehhp1n
 ZH1w==
X-Gm-Message-State: AOJu0Ywb3+CSWCK7EKMPgdp1GbRPEItrrVIt7vpGoM4fNKMv1Bktefl0
 whs1jQ6JMAiHLOhHUIhztHIvm7471QWbtC9Vih+w7GxOemO9oSJyypblKfBJImK40yK6KxAZAwI
 qqn/5k/U=
X-Gm-Gg: ATEYQzwgRd8CS6w2BI2yRs/8NBHjV8X3jp78hmHsGnl8ExSZeChRKh4Ym+mHyQzUR94
 buDd+KhA5lNxKNeXDzT0CZJGDeARpyGKUg9MeUj6ZQxs/zgJHuNtf4cz7tXcOu7P79IM9srI2iL
 DBh3SfswYjlqFEl+zLnK4IRxaAZ+c+ClcoBcDQYftIx4V+Hsv+0OO2Kxhn1qBroV3UoCArQg7f3
 BF4yObpJP+WN5WiQ0eG9VsZzP2iCTtnQ1er1dfqxBYMauDp/MQP2vGZXkyDWE5GlW1W9daOz+l4
 HttXuizyV4oFFCqK4feendjpuvD/0ATujt6i3m52cX/vRfm8WQyhvNfCqFG/wtviGtC3agTPJzn
 f12/X7X6dAvEap8M/Sz2/kNcKBaedXbofbphINrKeiPENgOvLYL3ji++mKg1+pKyZmnyjnfXPVh
 H3HGD0yA/a34mCp1yk5MQJtrRPQvzPO9W5NYw1LjzJWHPKavfTIkgqaZER8S8u9Ir/wyYnl9ZGu
 yX/iBH8EvVs+18=
X-Received: by 2002:a17:903:46c7:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b0cdc51c8amr36148555ad.22.1774629900611; 
 Fri, 27 Mar 2026 09:45:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/12] target/arm/tcg/translate-neon.c: make compilation unit
 common
Date: Fri, 27 Mar 2026 09:44:43 -0700
Message-ID: <20260327164449.596767-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 46bf4a6d76b..c14c9242df5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-  'translate-neon.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -60,6 +59,9 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
+  decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
+  decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
   decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
   files(
@@ -70,6 +72,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
@@ -79,6 +82,7 @@ arm_user_ss.add(files(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-neon.c',
   'translate-vfp.c',
   'vec_helper.c',
   'vfp_helper.c',
-- 
2.47.3



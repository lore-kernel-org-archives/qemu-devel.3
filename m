Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB9DFB5185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wBV-00089T-1B; Mon, 06 Apr 2026 22:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAs-0007fi-0a
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAp-00072X-23
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b23f90f53aso41001625ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528893; x=1776133693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORVqq7WCFruM46EY98e+6CRQ1R+UbFwjslRhvZQjaGI=;
 b=SM49y+eJtFsupmJOK2O6vfwFeK8AnjMC/9r3yCyyhJeyiIq6pahZ6Q38P/W57/FsAs
 UxnrgQ1KHNl9SIJqvP1k01+3QLqC4snFCR+5Ub4gw94Uhs0MmH6SGunUGdpJCi64A6pK
 DnMlpNgXLpLdsEs6x4zO+LRcMvJ01qSPLO8wkYDvSpfSX7m0UVP/hBiDh5x7s5B/Wxk+
 okUYnKHZHFt3Fr5VqRB/sGX8JcQ+wUnwFuxtLNms5QmFoUx0Sg4gM36FvwR3Aek99Gc+
 emYKMpAx8jTOp2ilfYko5+fa3X3vK0NQHBK7JPyTRBOiL4LxIfOVT/6cdYw2en5ro02m
 2IZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528893; x=1776133693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ORVqq7WCFruM46EY98e+6CRQ1R+UbFwjslRhvZQjaGI=;
 b=E/mgdYshfkDJI3ZlRWK7dXnHLbmvUo4O+IjyHUqlCQRpP9bstJBFRV8xlFhrPENiJK
 jqAXf/otpsm8gW2o5BSw/ZOFmqZAu9U7I4T3Mpcs+BlkU2I39KdqaGYOIIjA7s5amVbZ
 zz4LQJVdwUZxJqlEO5iXQiqnohSzq++3EtFhFb+eRLYQox94y2pMyjIZ0R6qduVaqSj1
 TCYeTZw8VfgEbE7WLmBhMbX8tg/kUs65MWYi2q1UGNwWXHVeLeauXYktWd4DDMKclLvB
 HPxmNpYMlz3CdaN+KAxR6BJIZEEoU0admxmyfvKG5amxoO5GDrrFs4WhtDObDovCU9BE
 rdJQ==
X-Gm-Message-State: AOJu0YxiPRwiqF8J9BiVR2pfztP5uehfJVEvx311HXLcN7y8yhyBm+X+
 fE8yu6ZrJOiDmSNF7SAaS/nFKrtKDH+E2rIUVB/kxY27IRCJyZsaDXDLErhzdbqBa0e+S8mTKy4
 wFgAvNThyrg==
X-Gm-Gg: AeBDieuRZurzKuJ28HX/BpEjYeSVEKZsTiDXn7ztIIEmgtzKoQ7cJqrBphyDFcw8RSh
 M7Ep+512HGDAa3cHZFW0vsovuiaf6Hm6lvKnJvRyEj7dYk9X/WAur1UxKQ/fCE7fOZJh007Mn8G
 d8+qHv3LSBsoS/PBfXpOmHNus72C7UBBV9fCaSi7G4gqA0jjOO3wtHmtIgmiWFymTlPEYYmY9ou
 OTa+KQLOxpNjZbFtM/9kldfBb1Qa2xf1CfD0cy0kfHAmjIpVU+QFlnJ5c/k0dUBRwQ47QYUem7R
 MHTecH6yHxkiHAL+4nPhIKgc7IiYaeVZm8KMDMC+GBdM8oC7YnSaabLIWya5bGECAngIFUQMnaO
 iXJbIVG8x3ieMzWfdl92Sv0xavUPGvulqghvy5odFzKaEJMRgG8vch4RVs+GOr8l75D9Et3kHTI
 kJFiij9BXzHidPnS8ELKyxjWQl21jj7foSxdDeu+ViBbO6iTt6lNujH7jFBgJH0UORdzY9WyiMM
 9KC
X-Received: by 2002:a17:903:a86:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2b2817995b8mr145036085ad.23.1775528892715; 
 Mon, 06 Apr 2026 19:28:12 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 20/20] target/arm/tcg/translate.c: make compilation unit
 common
Date: Mon,  6 Apr 2026 19:27:48 -0700
Message-ID: <20260407022748.57629-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

We removed all target specifics, and can finally compile this file only
once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 0740de92c1a..506f031f1aa 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -20,20 +20,18 @@ mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
 m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
 
-gen_a32 = [
+translate32_d = [
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
 ]
 
-arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'translate.c',
   'm_helper.c',
   'mve_helper.c',
 ))
@@ -66,6 +64,7 @@ arm_common_system_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'cpregs-at.c',
@@ -77,6 +76,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
@@ -88,6 +88,7 @@ arm_user_ss.add(
   m_nocp_d,
   mve_d,
   neon_d,
+  translate32_d,
   vfp_d,
   files(
   'debug.c',
@@ -96,6 +97,7 @@ arm_user_ss.add(
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
+  'translate.c',
   'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
-- 
2.47.3



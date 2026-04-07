Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E969FB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAo-0007bo-NC; Mon, 06 Apr 2026 22:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAl-0007Yn-H5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAf-0006y1-IR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so40741975ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528883; x=1776133683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=pgLpy1KfO3h5MJkq95T673olfBvPAZGvDygv7q1JMO469ArDh3TRX0mc0eJbzu9taU
 kvhQQ/EUrzAxnDcuFA5/bU0nnbyFOhUxtSs7Ff4y1gx8pXaNizDnNSOLEJll5/xN0teH
 zKPo4Fi/AZEzigwpRaE2BTsKpA678+SzroQoE7BF8zo7jwQok6BcjRs4IxQBn/q7j3PE
 i+wjvhdUlCnswoyr8z064YHeLiveTVUxP9EMwkQO2Dp3OtzNgnjHiBiuP2ecVsz97gBD
 NRdPgHO2ic05nw3Q72iqRZMpGUvdFo5FTOs68XrDBskjnIXMwTpnQEg3enLDQwmcacTP
 UtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528883; x=1776133683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EreTPxkuDGzkWgW1EVVjJMJZdSsPzYH3Oe6Wk0cickk=;
 b=h+76uaRJQk2wme2dgOvMMGd3vU29MpcUqZFcbseRJEzkjO6qJ9Z4mpywF8CHy8nY39
 H6EiPO24QEhvhGar2KbAaIVFNFwep7lAy14N9KFgxgjpWQCFaa+E1h4J7lnENi1vouCD
 Olrh93raybCy9yQzO7OPW4jwx7noDxsDsssBvh9RyG7ccklsbK7ULKrv2HgB0pazaAOB
 m/wNPiihu+TfS9MvIml5fPl3n295/0WoctCDoCka9iXPwHOjvFVp+ydtDn9YcGuuAxyH
 VM5pDvIvV4sHj8q5qbW0PgQFMnfjH5IiorPx/gMrbcdYUdOzHB2Avwir0VJ8RtzixotJ
 /lLA==
X-Gm-Message-State: AOJu0YwD7X+USor8nGB86xD7teCw6eV2YcBv55z17b3sQ6Ag/rxeWMH8
 VfRoi1pmnWiCDpjnN62laHm1yrnUu1buQQRTXUq1eKJ0QnGXTW5zNFJvm2cgHlSZXnOB0FGUKRW
 yiYPUJ/0jwA==
X-Gm-Gg: AeBDietOACP/rBTgYWzKx1nsxnhp2dWUi7dMwZe7aUI7NudNYbPnMXssyB3DfeT/HHo
 Yg+OBTS052FxLOMIdN7q3QVvY5r93LGMLsTRqHB08gKkuH67xDme2X8/Kv+EPazr6OVGbEF/0gf
 Vwdj27W8mHNU9d8V7+KZ2xG7Yw7osdpFzdZeoYAaNsnIEMPBVA1BPxgIKgShbcLFD7IazcRH6bs
 h/HnT32J60F9MlAvFh77xEVkqtqxZ7p+99j/8vn07x7FN5YRRsf/Ei6WJPlKa2BdOm9D+hLbPc+
 mE/mdJxnau1ep54Psn87ypAxXG7/RLIFGGYNujbtiIUfCzXVg9CJhuVKoa5tP1LgUM25q6ZLDgY
 8OV6OFH0XvHkyF+KkTW0g3eMALqnyCL5UiqVH2DjEWdUyN5EQo+gDfH89vyqvLDRnP6CGmALa41
 n0aF/bSYLHfMJvWyrVQT0BevDq0fWgOzKW8glC3bKZpAp2MjXWMlPPJgQ0eslqAdfVAmaGlR5uj
 53i
X-Received: by 2002:a17:903:38cd:b0:2b0:5cee:c421 with SMTP id
 d9443c01a7336-2b281672acfmr168511665ad.4.1775528883155; 
 Mon, 06 Apr 2026 19:28:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 08/20] target/arm/tcg/translate-m-nocp.c: make compilation
 unit common
Date: Mon,  6 Apr 2026 19:27:36 -0700
Message-ID: <20260407022748.57629-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 89c3b476822..70beec7a6c9 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -18,8 +18,9 @@ neon_d = [
 
 mve_d = decodetree.process('mve.decode', extra_args: '--decode=disas_mve')
 
+m_nocp_d = decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp')
+
 gen_a32 = [
-  decodetree.process('m-nocp.decode', extra_args: '--decode=disas_m_nocp'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
@@ -34,7 +35,6 @@ arm_ss.add(files(
   'cpu32.c',
   'gengvec.c',
   'translate.c',
-  'translate-m-nocp.c',
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
@@ -65,6 +65,7 @@ arm_common_ss.add(files(
 ))
 
 arm_common_system_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -76,6 +77,7 @@ arm_common_system_ss.add(
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
@@ -83,6 +85,7 @@ arm_common_system_ss.add(
   'vfp_helper.c',
 ))
 arm_user_ss.add(
+  m_nocp_d,
   mve_d,
   neon_d,
   vfp_d,
@@ -91,6 +94,7 @@ arm_user_ss.add(
   'hflags.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'translate-m-nocp.c',
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-- 
2.47.3



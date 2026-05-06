Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2D5CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvm-0003zi-Qs; Wed, 06 May 2026 10:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvc-0003vY-Gx
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcvZ-00029k-Kz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso50231815e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076518; x=1778681318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Cpu8qLZGCubO9MhUb+BAJDaMSuLsGH2ENsBOZgkNkg=;
 b=NzuXFMHcqEO4EPKmIezQZ4QBLjxUW6DFPSzVcg1yHUbgBaULNqIGVW3iBDAB85g7H/
 3D4lRy2EeEvo1HU00JDjBTYLGI332aq8r5oT6SMomipiggOCxgIDUEvzVaJTAYMy13O8
 gxdaKfcGHZDlEGef6Shdh532qEbOgEQVFLWIK/gPSZjCdgvyiGHyUPxd8GDFFIjbLnUn
 GOoUUxCf1/DRtIbPLhpOMdjLFjdSv+48GeRxw/Qss4yuQllVp9iew3HauUdoUFki93TV
 2lkC9fiu33sdmh7PDQ0DiBao+90m1t21Hz/Toc/92MGJ3S/xIiGvOOVoqN6EbSRSD9H1
 XtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076518; x=1778681318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+Cpu8qLZGCubO9MhUb+BAJDaMSuLsGH2ENsBOZgkNkg=;
 b=aZKWHu5mnhPEtQ30Ss2rZdNkck1rwxJqvSu2VHk/6kOXDasuRvUYHLY0jPb5pgvyyn
 VDBm+/Ap0pq4xsWVF/oQ12mSq2Bj2X0ktwcQ5J8NbCheFgY8FC7A8r98ME1lnxSO7hOu
 nVAHgmbLwPwwCE3EdLk6cxgqnHtLX4dmK7N6xwMI1ltdBAOuqQ8dLic5PTbHg4kMont2
 jBoE7ewDn9dNM6vzZAzaY0i9nfTSd+oT/c7q34epf+tJgH2EUc30PZgIqAvY/RM3OmPV
 apSKgBr48QetH0CowD9gmT2GSB/o+6oe7j5I+iBgw4fiPDDP0pFV5IG9u/tRgEctoOQ8
 BsBw==
X-Gm-Message-State: AOJu0YxhiprBzDQ32rW37i2afvS8xfszF7F7AmuHxGJkOHtUuQytGS4n
 NY//bMdNwbToJuxg/sK3KWxUUbSrOJ5YtMJW6qdIKOp1rJgNJHTrtIh/FI5bEHxYfeXPjGxxpAk
 9vEm9NNw=
X-Gm-Gg: AeBDiev92jAyca2EdrcJUVjM2UaUpZfjTuXW/UoBqoETQ0CfkjLShtToVcT4FF/VooB
 xWhgStYwgdODExrELOnPCSE9jCOkRi/N1FSwX6DA9owYZQilhSMm0tWr1uOYjTRDRAlbSTSIAQs
 oU3gvWH2ekY2QzHb/72tfCbkAWbwEIEEDDELecOyELse15bS8ut6s6PhU9ogNKzXjUralz/9P5A
 usSOkKHi5pquaG8U9XrIo82KoLc4E0myIVRinefFqA1V0lOS5VGcaaSjBoFYWHfumKFhr44Iv5Q
 fmmMe6wvwbX+B6bzJA/p+1IyGMDB0CsWB2vUjIiy1edkbTvfKDj5JkYV4DfH2x52LXQBasRXf03
 6G9Xr2vfwOvBdOBdTBZ2w9t3nzp5qYk/jLpaMCy/EYLCiX99gaRk5itnsERx6t8zQhcb841FZ/H
 J/bnUCQsDC8YL61qyPMHZfdt2wgoLQ1R3pDnittEaRjEMfiqk8KDQDdXxyhWE2/MMHdCMx8y9pg
 SX3EnUzFLM=
X-Received: by 2002:a05:600c:26c8:b0:489:1f04:96c3 with SMTP id
 5b1f17b1804b1-48e51e0c80dmr38823955e9.2.1778076515630; 
 Wed, 06 May 2026 07:08:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5313b023sm28461295e9.5.2026.05.06.07.08.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:08:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 100/110] target/xtensa/core: register types using type_init
Date: Wed,  6 May 2026 15:55:12 +0200
Message-ID: <20260506135524.20617-101-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Instead of using a static constructor, delay registering those types
until we call module_init(MODULE_INIT_QOM).

This is not yet a problem, but since we will start initializing
target-info types before any other, without this patch
qemu-system-xtensa* fails with:
Type 'dsp3400-xtensa-cpu' is missing its parent 'xtensa-cpu'

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260430203842.29156-4-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/overlay_tool.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 701c00eed20..b9eaffa4871 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -451,13 +451,14 @@
 
 #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
 #define REGISTER_CORE(core) \
-    static void __attribute__((constructor)) register_core(void) \
+    static void register_core(void) \
     { \
         static XtensaConfigList node = { \
             .config = &core, \
         }; \
         xtensa_register_core(&node); \
-    }
+    } \
+    type_init(register_core)
 #else
 #define REGISTER_CORE(core)
 #endif
-- 
2.53.0



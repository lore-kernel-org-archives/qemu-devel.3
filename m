Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA410FD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XV-00042J-4i; Tue, 10 Mar 2026 21:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XH-0003xM-FF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:59 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XF-0004pA-TD
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso59295335ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193132; x=1773797932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNt+J1gjdctUZp0lO0pO9+cAiO/kwbXqrf6b1D0HxB8=;
 b=Fssicxn4O6Zs4b6DRBOtGAiwJQW7UhZ8Xlt7s6cVKDAf7O2kMOLNpVD8GfFa0jzhex
 9G6jLZmmI62MKJt6iZ0ImPyWE95yDZjgyjrF5diRSUkDiS02VmaVRfUMNuIqPBoGoD1r
 4IUz7wJvdWFox14JdtIAbS6cPKEsUULO3oy6OOsafliaCDU0LQm/4U7g6WKR7JAoOrl6
 eNFTMrWXoN+aafRDfCKcOPGt+B1NebpGyDpUqjINbldkr7uhYwJIOiinscBoaYOy9dT5
 lWwTz89uoShWRLk2PvBxrbF9flbXbU/f8JVAWsshH8Bsp0SDPzDvsEu/F+H9y26TsjwB
 KHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193132; x=1773797932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNt+J1gjdctUZp0lO0pO9+cAiO/kwbXqrf6b1D0HxB8=;
 b=HFb51L7e5ma0YMWJ8wI+hvhnGj/++lyZXfILQCpaD5jHnoQkxj0j3OfeBB6MijMzND
 40tiKYI0k1MFVf1MFUebBV1slEhQSyc2HSlyeYWFoOuUo7RKW4SwyylMwjASaNmpcjqQ
 yvZjq7Bk0qKdAEIexMN3dpwxkemFyFJA+KU9hzA3gSr7UFXgEAee1lh9Ku/FKhhQxRRm
 q1QU/MmeZJy8J/ClEaOpWKx7Q/3I9geC7/jfaYhk1cmzOe3ZNVsUABl6tWkPKvO9iPq4
 +mj2I8TpJZxuPTxUXlhrntztjB2HUbHlRBVmCUxhkIZt63m1l+7OAIe6DmyhtSOY+xAQ
 a+nQ==
X-Gm-Message-State: AOJu0YykZjwdfQXPZw3jd1mfCE9/fQwz/F4LdiMDqeVgrp3qS7SoIIN+
 dLJSaP+8kEN0ngeLe19uJSqmPs+Yg8N5p0HAR6IYC0d4pIHbCnPezhAdJLeRLJ8dz/zIDf/ftOR
 hEeSI
X-Gm-Gg: ATEYQzwar8intQkssVxwkJM0RQPOrt/bTVF5evkBgeeXxYh6TB1TqikeqglGKInDt8m
 tZpCcTt34Sk8ojmVufgxbvVtna7V5Eff/es/gvRAsGp/EbwT3Hc/m7G1GG6Z3frMlN1mcwKPY2I
 59KYDAxM0mW90i80dwFUIO6Aas5KNcPCfIQcbMBt1wHJQKj/kA4zxzCfxHRwEo70m1Ohf9AX04r
 1xZ99u0qdRwkrTTaPfjoijr/G+W/JyY4PMezFrmIyo1eQUJdHXb7y+tN7NfdmQj7jZnjU4IUxtG
 aXUNvgwRHZW0O/S5q0YpTUEpYrnSDZOKV1z6zWZ+RCl2TOz5f/ThPKO1p3O9hJ+twakQQTPsDU2
 YsJM7wCmpiJSTfpYphNNvOqX7f+hJnnc5P1WqEe2H9Ari6Xa7Bya+qwUahe7DbaQhvIsYbVtMif
 Nw088xjoh578F6lVejHXnTIl1KK/wUpbDjr71hmUcBzSFptvDvGBSkTVdQluFMjqqhGQtTWGgzh
 P5J
X-Received: by 2002:a17:902:e805:b0:2ae:a9c2:6aa with SMTP id
 d9443c01a7336-2aeae8935bcmr8701395ad.32.1773193132462; 
 Tue, 10 Mar 2026 18:38:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 05/16] meson: Restrict gdbstub to user/system builds
Date: Tue, 10 Mar 2026 18:38:26 -0700
Message-ID: <20260311013837.69945-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Limited builds (tools, documentation) don't need to generate /
build gdbstub files. Only process the gdbstub/ folder when
user / system emulation / acceleration is built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-6-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 1867560da63..db8918dd303 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('qom')
 subdir('authz')
 subdir('crypto')
 subdir('ui')
-subdir('gdbstub')
 subdir('semihosting')
 subdir('audio')
 subdir('io')
@@ -3805,6 +3804,7 @@ if have_system or have_user
                          output: 'decode-@BASENAME@.c.inc',
                          arguments: ['@INPUT@', '@EXTRA_ARGS@', '-o', '@OUTPUT@'])
   subdir('libdecnumber')
+  subdir('gdbstub')
   subdir('target')
 endif
 
-- 
2.47.3



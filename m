Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D63CF884F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 22:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swqve-0000sC-7n; Fri, 04 Oct 2024 18:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swqvW-0000ru-1g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:37:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swqvS-0004Zt-Oe
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:37:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718d704704aso2366028b3a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728081449; x=1728686249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=InT+9+kbEpZt6rHNxMmMOCL/cu96/bNQ8jsBSgWm7nw=;
 b=wWHfr9Ucd4ISZpUO/3BBz7HJZR7OghCZbJvrEn+zljanY3qvN27oz54lIUYmPO37mY
 KPer91XBx131uBSZuhOGhHkzXxk1r8NK2hRjAhV3hDzr7l3N4/AGHoz04IHJ4NzqD/zf
 DWfOmhr5Ga4ocgzPiyPVJZB/3EqkVsZ4CdQj9YExp8rFiBehCmEsdz/SQr7nWMS0bkVg
 a7b496AVTfMsfHB+hXDxl/bPlcgd7s4sNw8TImoldAPRHn2hSdVusXDIjCuHZyim8cHM
 23jKYF/CoYmskiDun2uri7KmLftnvr68+mU/SkRov41qLsIt1pSbpxCg4xwhkxEe+XgK
 uvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728081449; x=1728686249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=InT+9+kbEpZt6rHNxMmMOCL/cu96/bNQ8jsBSgWm7nw=;
 b=wzjmD6TAk4KGM8y9yZpf4hqYcAM+hI6xBcZl1ijSf+WAqkZxmVP4igofsHV5+ozR2K
 SvCgM3ZP+YpbrQKhoexj4WLC2VtVuJ8iaCqGNMcR7FRnweHGAgQcWH1AI9AQ3sXnGoVq
 WMUYXbw/p8aMzuSK54zBW/JD4Pl0ypOrXUNkyF9M9QIe3m1gaopqJw3rGewG/1is8YX+
 sk4hBMsNn3tkT3uW2Y6fJpnvbyMfCNmvrm0EpZQxJzA5mEVnBxpHPfWZ+bSdWrKBaYFu
 qp9aFob4E65xAoKV1I9d8FPKAsAcNMu4cKiG5sWzve/annSXNDREtUTBUjdag3KsB2vJ
 NYoA==
X-Gm-Message-State: AOJu0YxNEnvh5CkwMfpnNeCpwZAu0qkVi6kdBhdBhJvoQLwuSO5Tnv1y
 R5Lday7L2LwWoJHgl48jiU2mrGnZOaejqZ1wDJdFs8FUnOgfciXd82MKZCLb1wmXzq0Mtl1URFw
 4yho=
X-Google-Smtp-Source: AGHT+IHYGCnYeZMF2IswxxEUiyIhkg8AEu8gVkrbXKfhdd4vAzXLcUldjFEn3a/5ZgpHD75duGixcA==
X-Received: by 2002:a05:6a00:2ea2:b0:714:1f6d:11e5 with SMTP id
 d2e1a72fcca58-71de23b720cmr6520906b3a.12.1728081448634; 
 Fri, 04 Oct 2024 15:37:28 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f680c732sm504807a12.12.2024.10.04.15.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 15:37:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] meson: fix machine option for x86_version
Date: Fri,  4 Oct 2024 15:37:15 -0700
Message-Id: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

s/mbmi1/mbmi/

When configuring with -Dx86_version >= 3, meson step works, but
compilation fails because option -mbmi1 is unknown.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index af2ce595dcc..ebd914628c8 100644
--- a/meson.build
+++ b/meson.build
@@ -362,7 +362,7 @@ if host_arch in ['i386', 'x86_64']
     qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
   endif
 
   # add required vector instruction set (each level implies those below)
-- 
2.39.5



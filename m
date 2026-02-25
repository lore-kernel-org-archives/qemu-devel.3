Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D2F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv63E-0007SZ-8I; Tue, 24 Feb 2026 22:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv63C-0007R3-VN
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:59:02 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv63B-0001m0-GM
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:59:02 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-480706554beso74136635e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991940; x=1772596740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFo60btb70m5vTMgMlEJD6jjZzoyfwsU8IfJ3mxUKLk=;
 b=Qxnmv+QiUxJsbCeRSp0PeVgtqQJA58C58RpnjfH7xGwOloKOSfUiEVKuRg33hYGoGT
 fU2amP0QU+6MPngjvcPPw5rbj/xbj3U4rbN8foiNC4uMQD7GhyIJLIgDXYBX42KKix3T
 Ks1v8vC8GR1JnDG8PnlsaxDk6iLtZ4NBh989Wk1WKP0Y9MxmBIgZ/WHGAvKXiIMNYevH
 rHpwgXoDQrgyUnCKK5r/Vpq3K2aTsg85H4UhgLgI6HHaWxVl5R3luvoQY2Ht9UW/yWHB
 ekFXqeZce5NJT5Dvc/L+mWvYj52pTTXeAncIEpOHNaQfGx7IYZoVv2TR93bagGWoi8x5
 qgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991940; x=1772596740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFo60btb70m5vTMgMlEJD6jjZzoyfwsU8IfJ3mxUKLk=;
 b=iKqdDpQxIgd1GGPfgwNBwDe33l8bcfdDW4tCLR5Ve8jWZdgC1S/5OirBpOOmTYSRCw
 YcVpGRZl8sqVqEMXRmoXZmeduZsZCKDTKX18+IP5pgOxioGgq65TwqaQUSZXh4qO8dGA
 H1fOOvfQNQwCLKJZGYfXAK/hcPHExde2h47VuP5mstqtU/PT+bVGMv+i7snBwDlB1jcP
 v8F/9zih6MYqfknBVCrMi1kodeIs6azAU4QrxhPXl+QxjyFL4o66yZDWzg6wPBSc8FuL
 aP86ShGSvQcKxK29RVMtT4Dyw8blam4tulcokBaj70OgRvo7twJAGRKFT/gF0guEjyfZ
 SQ4Q==
X-Gm-Message-State: AOJu0YzSRdmsogpkwn5yDc1YUrpy6Q6FU4YSQ8Pdui0NpOfYQB+JVBxX
 vEcmRlAulXH8FuVifTLpg2PsSk0rzcoa4cKhGyx2lwpFWlWi88HK9ENkSsZ5214UHVLAP16NZiK
 A+16lwIs=
X-Gm-Gg: ATEYQzww4bTfE5i46iCrPt/tHULMYjgZN07j9e4gojQqwpxzwVnh3Hep7Ik+MHc+JGS
 4vHqhwUG6REE0B3izA044c1IKymu1hybsJa8M55Q2jHhHkcmLDfYGGDzFu1c9YMFZ5fu5YDdyiS
 Ltud8PvlY4QCkDy2vMKE8OFtIVwFuY0HMUFB9w1uUfGSJhZj+LMsFc5XM38cJTxN4AkeaQjLDZR
 x68wftVbnhtE6NlfrTI1feeKgCvumSwwK0ootG1NNqGW2YubWnxOcASV8s+uSkokO/Rb4MZurCR
 xT1OnBihziLZ5bYmLpW6w7OlIldoTajS4LwHrdWZrk7M+SDgNSWGY95+pq6QR5FLg7RplEs4tkS
 tkLIka8pOPP8k4AqzX4mbu4zl4WmMgH1QmpsIqxfIKI6JmATyElIIbk5Rm4Qd5C4xkQzU2Yuu6C
 BoX54Ugqbdv7DQenljHzL/6B3H3Xy8j1/9L0T6PhDjJVzcMEi6jWidCrB/dwzR1G8ep+wJ+Mid
X-Received: by 2002:a05:600c:810a:b0:483:6de6:37ad with SMTP id
 5b1f17b1804b1-483bef677e6mr13049255e9.34.1771991939675; 
 Tue, 24 Feb 2026 19:58:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfabb84esm4853675e9.0.2026.02.24.19.58.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 11/11] semihosting: Build stubs once
Date: Wed, 25 Feb 2026 04:57:39 +0100
Message-ID: <20260225035739.42848-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/meson.build | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 99f10e2e2bb..15e3be26989 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -1,4 +1,4 @@
-common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
+stub_ss.add(files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'user.c',
   'guestfd.c'))
@@ -8,12 +8,13 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'guestfd.c',
   'uaccess.c',
   'syscalls.c',
-), if_false: files(
+))
+stub_ss.add(files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-  if_true: files('arm-compat-semi.c'),
-  if_false: files('arm-compat-semi-stub.c'))
+  if_true: files('arm-compat-semi.c'))
+stub_ss.add(files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-- 
2.52.0



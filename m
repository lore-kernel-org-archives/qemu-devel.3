Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D04FA3755
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 21:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbn0k-0006mx-Cn; Fri, 02 Jan 2026 16:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzm-0006g9-2n
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:46 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vbmzk-0000KW-Kf
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 16:47:41 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b8e49d8b35so15181964b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 13:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767390459; x=1767995259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOkbwVMERK6pZqO0u7uJFvMQBMZKL1x7wpoiTvhRVB4=;
 b=Lus46W/+bayS02n6n71pFalGccFLAvlpI6F4d635fWZZhdQO4uAcSI/J+BsiSLPEZe
 0Hs1JNEk/KsBC7ZBSoGEX2oongtDTl5tvEoQjUz6zER+WqjX7jeEpjzx5BVlzE5roiEC
 wnZJFe8rAusfRXHv9hNB3Dk3hQ6hqG1GWpPB5+CsTrKx5Fu5k1na+WqLdnIWrm3QC4a+
 h9DUpaVGfLUIYUV7E02OfYZvKWj7HbX8INr8aEt8I4zBzSH3c9x0CpjGvLsbfx6+Axs3
 o/BxCZ5Sivy+BuUYBCjIymB+fA2gELEmGqrVCjjutKYEvrzrk+zfqCNGpb/fzRX45wNc
 qRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767390459; x=1767995259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HOkbwVMERK6pZqO0u7uJFvMQBMZKL1x7wpoiTvhRVB4=;
 b=LcUyxiwLFDbuDXl4/vMuW35Zjy3Revf4AMxdJn4hVr8VOBXq1rqqnwVLhxSp0t7dnJ
 xBd55acCyOC6XkXbOCjLwT3R9CWS/thvK4leCcQCzUQ4MKc36QGhfHwA3MWbLDpqx9jJ
 sRK5b/9uFkxYbme8BfSFtjlzk7gVuffu7fNwiaNnlHMCWGeppHyEjIPQ0JRTBIaE8jPY
 ipIwoXtY3DbnbpSPHeWafu56jZcXcSKxXBaW7Y2CcRGPVIPJaUuymHkK0NMVrRCFo91r
 JmcLCiULJmRD5X2UFBKiOFC9GGUlzuWl6j9xtqotN+pW1uGUBBsZwhhKWxiPmme7Bx1J
 ud8w==
X-Gm-Message-State: AOJu0YwSbt2CZgK6dNstOGi0smWbM4+VeO2WqYo+QIiXAsQEd/WDK8o6
 EYp4kelD77zLAHPtA0yXWwWp3AbYS7xPcj44sAB5vLGmGELb0p6Rz+khwkLVf+GSTqNk3RPNtFS
 NaKrK
X-Gm-Gg: AY/fxX6fEeOM3hjwHpC4MXPXmLKh/aEolDjpNmW402bhb5OQR89tvOqYN5gpRp7d0Se
 pH7TCg3tT6cr+LIY/2HIRopCYhvDj8jeagJPWXLd2fWEIBfWGbwb8OMipwyKIOf7EscE9TvY/qP
 s2ogeoXM2B36P8nbMwB3Ll5HdBnnpm5GVB5roywtFnP2gyEVHxIBNsraaNEhF89OGMPwcO7b3+z
 QEYisMQbJ8UJUsugo3kC1FiLZVc4GNJPTYO5TKrN25sJlLcKuk1t2MsY6HxH7oq8LJSbA2qLg5T
 jEx0wOErtXxh78fAaBO0eIRPeCzLtH8hqL8qzFwBtSCNJL/soDNrZSOFVK3PHFeBjmfyasntMQ0
 aKM4T13qP40FQoGIKwi+yV3aAhLiEA9t33GpExgaRDPxZt9DiTEmRp+1Ad7Uc91/Y0gttONDD0k
 D51E+0rhn1ezYWUqVayXKNH1TKoMcFMe/gtzv+v8LWPkDrA1DPVH7laKVhx+D6k0X1
X-Google-Smtp-Source: AGHT+IElzGenGc6qk9JdeU4c1PWpn/r8lAxZt7YYejcpwYoXnsxTwLQ0vFIu00xGngVf+FO6quGkpw==
X-Received: by 2002:a05:6a21:339c:b0:334:9f66:5273 with SMTP id
 adf61e73a8af0-376aa4fc4f2mr39987706637.47.1767390459141; 
 Fri, 02 Jan 2026 13:47:39 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f476f8f3fsm62925a91.5.2026.01.02.13.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 13:47:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/11] meson: update C++ standard to C++23
Date: Fri,  2 Jan 2026 13:47:23 -0800
Message-ID: <20260102214724.4128196-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

C++ is evolving faster than C, so it's useful to enable new standards,
especially for standard library.
Update to most recent standard available in our build environments.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 38767c2c68a..564cdde9153 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('qemu', ['c'], meson_version: '>=1.5.0',
-        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++11', 'b_colorout=auto',
+        default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true',
                           'rust_std=2021', 'build.rust_std=2021'],
         version: files('VERSION'))
-- 
2.47.3



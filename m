Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B217FCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQnv-000574-H0; Mon, 12 Jan 2026 17:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQnp-0004Cg-V8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQno-0003jM-Bj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so42737405e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258462; x=1768863262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2eEvojl3ZguflhozJGDkOioVRPqXh0rRcDbJpetc+cQ=;
 b=Si4qxvnEs0a21Lc2OiAH2O0YKapSn1Z791tvNtvEnigngJ7QuG6kil1y16Pt10qS1i
 NUMEPoofVIYh6wmU/apL3GsUTTctf22t+/AZOv7FwT7GazlefY033fpdS1PB2wJjKPdE
 U9CvX0PDZp6fVPD+/PrT8r3rErEM5DuIlj1LYMv9ikKclab6JmpU+bH6W2J1RGfo5E1E
 D6qlD5lAPZHjVVWHBzqhAoacfxvCSK/8zWiUZehDfonAXwzK0bfzlK9XrLc2vxKFbCd4
 9CQsa07LT/eyB8JxZlvtMI0dLSe9X/ajuEXjmy6aLbGAL5gKPP3nWgYLYjGpcDwgbOLx
 6rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258462; x=1768863262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2eEvojl3ZguflhozJGDkOioVRPqXh0rRcDbJpetc+cQ=;
 b=k3XodnLhx4KGnOeZ0IG9RH3Upl6IzBlSA1NzjMkZWZGXpSAvt4C5ogWILcGlZ2Y5hE
 woH78LSsoK5FVKAw9hoajYl9DelJbBL0eLYvjNMd6aV7XifzSyFcyn4QnE9die8BekIR
 WYzgZ/8eTPPnH81uBdaCathNRVrlfNeCX3bQZ0BXUQ0dXjf4H37yToPHHKYX2Uf5/ddR
 zwcRvCp8OKMXQ4CI4PJ4p2eJTryZIy5wbivsJgN3i+Z8LZ94e9h8d09bf8ZGlydwlDCQ
 MekoLGryCA7q/StN49CoTkQEK8I9awALhJZmoV9U2T+2IrhsvwjD+9OtW2OYruEMAgF7
 yHvw==
X-Gm-Message-State: AOJu0YyFMXkrnpLhX8xFnZs0Kc64B9+Mkjaqfnk4IfQA5w+BqQNp5dFE
 NnBFPlY0oZp28FCgAuPaO2JoZMfAvrhT/WE+WTthri79iKZLAW6MsG/HYZnIrPfjOlSIR53bX1T
 V4s7qgHE=
X-Gm-Gg: AY/fxX5JNwH5cwPnFAFQshGigC5gpg/PktFyurnlEM6a6Tq9KvcbjFMd07JXOqCmJnY
 oynXXi0LI+G7prxku5JAVQOCS0Sj7JanPzA1Pvgs3aJQ2WGql+JZhGBv+5mCAt23KQTtasvA7zK
 esQPCELwa2Ji10mG2iA3Mk4gBN+9JnJIubltgNG9GfHkWIOqb9I8EwKEGTlR1TYZF1Yzs9U3qg8
 2mPN9VDy4XG76L3ysqQ1njKuVWsnplaSYSnV8eo3JSka3Kwnaddrvw0dD2shNUqSxBxhXqtCQOY
 KgCcmhEeU6eWYavKqskv/eSbBtebJPwfbqbyCi4jzAjK5hj2NgIFT195e2PO1y9noQJw67u3Rk5
 jtQb66gYrrezUuE2VICwjM4DZ5yzOLOSEt39VrjuBO4PnlhIGeQcV4i5kWRwRGlLCfm7Cx+xB1N
 cHF4Fy7PVuRlZcg5Xy40zNc2FNUvB8J565OTYpY4WSGQXoNchi/wlZEbvTYLzj
X-Google-Smtp-Source: AGHT+IFF8saigesk4e0HTjEOqzMZwwEyAem2rIS2JafJy8uqwKhj3+3zjoXYBgB52ZRo9j38Po2a3A==
X-Received: by 2002:a05:600c:a08:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-47d84b2cf97mr222369055e9.14.1768258462565; 
 Mon, 12 Jan 2026 14:54:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47eda0fb425sm1328295e9.6.2026.01.12.14.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:54:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/61] target/rx: Build system units in common source set
Date: Mon, 12 Jan 2026 23:48:42 +0100
Message-ID: <20260112224857.42068-48-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Since commit range 2982b948a9f..86114e43ffd we remove all
uses of the target_ulong type in target/rx/. Use the meson
target_common_system_arch[] source set to prevent further
uses of target-specific types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260107200702.54582-2-philmd@linaro.org>
---
 target/rx/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/rx/meson.build b/target/rx/meson.build
index d196737ce33..86dc231eb0a 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -13,4 +13,4 @@ rx_ss.add(files(
   'disas.c'))
 
 target_arch += {'rx': rx_ss}
-target_system_arch += {'rx': ss.source_set()}
+target_common_system_arch += {'rx': ss.source_set()}
-- 
2.52.0



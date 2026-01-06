Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD6CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9SO-0004dJ-Jk; Tue, 06 Jan 2026 10:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SM-0004KF-4N
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9SK-0006ka-IL
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso7053885e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715127; x=1768319927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU1qPLi7V3iHSoMptT16Z6RgGX5P/muNEJTKJG4e/8A=;
 b=TRgsH95oHXVNpORilXDzikfeqrpxlQxk0pOjEOv96uInqHo1XC7p1aT87uqI9plKUW
 H97TLpZor1aA96FpjW+PHcTlmADGtwth5PUtdb7COVJUBfok43/AXPEd9CkoEVorJ55Y
 iIONUm1eWGkUNa07G5nXCI/vYRAzPcsf8SifhNExjVKZIj+KsG/7blZEqK3nJBPsALDy
 a6bgdgchUtcREoNO7EcGthkmuZH12BlpOCeZRkx8gtueY+UsEACChNnOsuu0XDXo+Dil
 GVRjMitV9nuwLGZ8o5vZ4epUyY/sG9KpkvxkpQnA0nPIa1nLaufmF4JDHRtsgOLNQ/IG
 IL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715127; x=1768319927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cU1qPLi7V3iHSoMptT16Z6RgGX5P/muNEJTKJG4e/8A=;
 b=SNKPxhWlX/SlHOqeG+xIbX+ZBlO1r684ejvcymNfcuY0Fi8mhKsWqMTSco4TgadkCa
 Y95UeCGtdZDrbUHi5qdCK6imundAbWdohsyUybx2mMnAMlsMQqeaSzt06+/+MlisdfDu
 bqkfnPkJdxdV4pzNpVkpGiklFTIlmRX52IyMtawx2GThopdnZF8NEpzG4bhcw7BtX/ix
 uWLqp/QB858eC3dpQ+bCaLuWOnEFn8l+gDXOohX6urZo1dBc3pEqMZHpXv1P40JgUUIr
 zH3CPZn18I/TSijB4xR62Fc1vHWfA6xZFlPsitWkeKUAoQlTl6HIMBDZIH1Uh+6jr6qD
 4rMQ==
X-Gm-Message-State: AOJu0YxB9WyskCU1xVtg66VwukFUQ5nS1uncG5oDWjpzs/gXnn2HtDMS
 wDgbQJoC/JRltrJx6P3mUXVnz4IxUwYnBfCKzdm4X4AC56MmPGXgtooRTAbtFA6zYd5H4G99BNB
 jhpNJzX4=
X-Gm-Gg: AY/fxX6UP+OQT5Vffl2Lku1tWadieip6vj1fewlsIOHOUwJMFwPYgLV6cYyyObeGHjX
 qyWQQ0TDknK61tntWeDrvY3oDS5knmXlA6YVzX1KRuMBZNq4UYwVpevnac8pLp5BavL4F+xNiYi
 aDTvKmtAlrCDUseu3OJozOZRNTRjbjR4yDz3769yBLE0YyR5xe6gdiyj7YDUt3tKi9f+DPItAJB
 FGOY23R+ZUw9sXe+c3ovgb0cy0S8F++dVlMUI/JLa2ex486MxSq1rzdgQ2fg1jbQtgYjo054PiG
 fwwOHRDmwdNj0zDPHunixn/UTNye/K0e/pxWmu2ZM38MZlOqFjQfd+ujFvhaUxSGVnHwW+7xCiq
 jaAy6FaiFfKc9yvnVtN1jH2Z9JMPuojUXrp9Tu2hh9JTb1c/LDshVDYct/7C4hbyCiC2k4xjiQd
 U2ssAN+uIn53SP2itfksX7MnZFu6VJkTXoRYWkJwOGdakBD1ObVpHromXTZRht
X-Google-Smtp-Source: AGHT+IF7JMm6yaYLqs/4cSNJSty6b08BDjfbBoAxO7agsYa9Rv7fmyt3oM1X9dA2BZ8DhM3THARl8Q==
X-Received: by 2002:a05:600c:848a:b0:477:9dc1:b706 with SMTP id
 5b1f17b1804b1-47d7f09c98bmr39800575e9.19.1767715126808; 
 Tue, 06 Jan 2026 07:58:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm53336535e9.9.2026.01.06.07.58.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:58:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/8] configs/targets: Forbid Alpha to use legacy native
 endianness APIs
Date: Tue,  6 Jan 2026 16:57:53 +0100
Message-ID: <20260106155755.53646-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106155755.53646-1-philmd@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

All Alpha-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/alpha-linux-user.mak | 1 +
 configs/targets/alpha-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index aa25766236e..ee505e16ef4 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index e31f059a52d..22fbbf0cb08 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0



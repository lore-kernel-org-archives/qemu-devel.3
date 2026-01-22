Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5F4D625F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTC-0007yw-Pt; Thu, 22 Jan 2026 03:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTA-0007qX-KC
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqT8-0006DT-VN
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43596062728so1165875f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072109; x=1769676909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I0V93sKC3Sq6BpXvti4qFxTZI6OR3pXk2FZqId8VzaI=;
 b=itS9zYsS9IALtZRRvC/ggBtlb+fkm92vDVI3Qg5JOAbepTWdLDIzD2EJMYNOsR3254
 kg0T2To0hWi25mQKD/NcElb8joIXsZCbS78aGwrXbAOgkAg5mxXlyvuZgbG29Xl4MSKq
 ILb/coEmr/0r9amqF0d2iVaOHCqG6HvKp277i8mLxT+BbT+YwRoAIyOPawJfA2qtvyWr
 SXYrsZSkWV8jmKmDWsy8L7GynML3tbTSzGZj9DrOzAPEDWe9Doa0GCDA6Plnt6yYN5aV
 QqQhwuRMDW6NbNVDfX+/IOz8FyVFh3gEhLjFFhf6ZtdKNExTad36H383lFXyBpJlIva9
 9uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072109; x=1769676909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I0V93sKC3Sq6BpXvti4qFxTZI6OR3pXk2FZqId8VzaI=;
 b=X1Bs7hFlig9LoxDtiEO2KcCfwBru79JI6pVfnmFl+WDO+soYkF63aVqM3lU/LoM9jc
 si9Bg/OOenfILx8ZJH4qhP7bmOtIpHS7k9Igvgzak8hDKgMjAm3AsCEzLQ57oC6ORH2M
 DQIrelLCyfbpLAv85Qel+Ipb/LVfBSyxi9e1QHIONMzCkjttU5GdxlbrwGdrceo4V1Ud
 haS8+5ZNma469kSRk2sdCXTvYKrt+5X9p1Jhn6WIFhVQb8HNcCMgENA8dEyZVXXudUmy
 d+5BLfUOVoFxdPOXZOPYfWJ8XtGm8mDKtAOxpjfMt5f2d1dckupAkLGkkqeWat3XNGrl
 GgUw==
X-Gm-Message-State: AOJu0Yya6tR6xcrSrP8vjXLYagm0KAa1umctmzCicOfPTbI9x0F/9lSd
 abs3KQZTfLZOgYrpDb+Lqg08iip/WSSrEREO3r3mnreAWR9UCin0ye6dFJeKjYNwe14vQSXJT0y
 gidzKZcg=
X-Gm-Gg: AZuq6aKlsld3dyTJAvj+CtgCUkxTRbPLz/sJkT2X3UQqNGSkLnq8jX98EvYQ+x0w+Ng
 vnIhWFvDHz+rYkvujM/+KO6hyRewp60bpHRATnIFrvha1LRzplX32pdJfd6NHuIT9xmYMNypp/F
 FraKvyCflATjY44tfHtHHu4ZS92r7cEyXcX9XYuywin1T6rDV5TZ54Kax4NEQpV0YyRjWyscDli
 aJrKU8OLz7QFbUcTxZ/9LdUejF40gNzMHXZFp60LJZHGKMHJBbOnyCPp2ynhPanrUeQRcWqQIZU
 B2giT+vo4u9OIWOL+4n8iDS8gtz1xc7cyegd61TlmOvbpdfn8ZABBsPp09Xr+j8R6oxyYlpsLQp
 3bpoeXJLu9Hvo7DnDXn+btHHm8aNqUaR8I8y+EC8rOTHB8SdAvsn4jQR3dJbrU/ZX38yUHCqYIB
 5SAFOujITl49byqY9btcsjL/rbb5OzJqtXni5h6uJHc/XVFkfnoDv2JWlUefRh
X-Received: by 2002:a05:6000:1acc:b0:430:f736:7cc with SMTP id
 ffacd0b85a97d-435a5f4d7a7mr3294633f8f.1.1769072108910; 
 Thu, 22 Jan 2026 00:55:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm44922484f8f.6.2026.01.22.00.55.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/31] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
Date: Thu, 22 Jan 2026 09:52:43 +0100
Message-ID: <20260122085255.95035-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

All HPPA-related binaries are buildable without a single use
of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to
forbid further uses of the legacy API.

Preliminary commits allowing this final change:

 . c77d0e90093 target/hppa: Use big-endian variant of cpu_ld/st_data*()
 . 75498b3f7b9 target/hppa: Use explicit big-endian LD/ST API
 . bcf5e5d3e33 target/hppa: Inline translator_ldl()
 . 7307ff95581 target/hppa: Replace MO_TE -> MO_BE
 . 6c1c734f786 target/hppa: Introduce mo_endian() helper
 . 64d1c178513 target/hppa: Conceal MO_TE within do_store_32/64()
 . 0807994a0cc target/hppa: Conceal MO_TE within do_store()
 . e3da4367117 target/hppa: Conceal MO_TE within do_load_32/64()
 . 4eef4dab502 target/hppa: Conceal MO_TE within do_load()
 . 714dd08fed1 target/hppa: Explode MO_TExx -> MO_TE | MO_xx

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229225517.45078-6-philmd@linaro.org>
---
 configs/targets/hppa-linux-user.mak | 1 +
 configs/targets/hppa-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 59190f63358..a0c7398d599 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 # Compromise to ease maintenance vs system mode
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index ea331107a08..003f9f46dcc 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C155C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E71-0004Xv-UU; Tue, 08 Apr 2025 14:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E6z-0004Xc-KK
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E6t-0004Ci-GK
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3657140f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138545; x=1744743345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jJkudB3uEF57VonwdP4mQn1d0+k2UD0Vk/ydRhbRYA=;
 b=FYUzL5+Bypn03HIsSzO5PgZ/0yw9ht/uSzw5fM+i/FulhGLydKcWht5/eEDUELarWh
 73kNmbbJSRJwIf0SGu34cWmZC7oGaPHqZS/n8/UNuQcMY0142JgIIFe/uUVZ2cROoyZR
 t6N5lWteirmITheqYOFf4SgI2QFEgi2n8DYJuiRW0AgBaaom9Ff0mXd3B+w3KZ6uwgDb
 duQYLjCz+AgWbJOJ1fe6XWE9D48HZczjLn+ninEBZAd8gRT2AEjQm6u3FElRQU2eXFsA
 Z1g543Jtcbw7naTwOyp6UgLMnKT2/okcqmWAEqXLRwsd/JxGnTYVrbe5dGvC0DQte2nK
 ueoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138545; x=1744743345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jJkudB3uEF57VonwdP4mQn1d0+k2UD0Vk/ydRhbRYA=;
 b=cqWzcgrbeM2zdbHJj4rW4Eh4ZKnEvykWbiHuom2jZZGjatXdzLq9XwDt9fUAp8LQS4
 pAD4F+I1M1qVbuChmrgOPUGtWDvY5e41sW9e+a+AV1StxQC1vdNnGXMRxXrz+UyUiUjK
 C8SJXK7S8Mo793cZHea5hG2/bUZ91I67ylZvqFXeiurx63/nAH3voy+UOQQL9il0IfDV
 pprZwXPX/RG9Vtot8/N1HuJpiHH1S5rFs5esRtM1R5BGD1L/o78CQh2vJRI/ezvMZgmu
 vh2MdN7fRD3SOZyau0DnuLuoSPf5hava5fEkf3YdYTTczE+lPn2jz5hTzoR+F4luc10y
 L7Jg==
X-Gm-Message-State: AOJu0YyNAu3ablBArjIGAiN8mXjb9tFIN5yMSaZ+OriVQxDixxhW/awc
 A88Cu2iuv9gW6VNnmVap2wJky/wEiGVOQe6Kyna3zeXc1knrvEs9MQK50Nv5Ox2MS5gPxE4jLWE
 0Ap0=
X-Gm-Gg: ASbGncvYXm9iDJp5RGQrojFYek/yFh1b6tt4Kz7r8warnslq0r/J/MInjsK4B3BDLC1
 Zs6qZLVLpi6Pgh4YVrUeih1STMUZxRuD9Xz23ZEMEoBrGVshBgOlCjSY8rVwcIAK617JiOPfdw+
 e0yVrfiFWoqpfneQCEFZqpYNK0IqX1w6vYs9fGo6UzsRY25ESa7H5Q1wmeelZltdCKx8MRqyC4U
 /LEumMqoekCtXstRzMcR5dCGiCB97GBk18nWHam4tDjPYWK8nFzSSYVjimEC0n+PZhQ+RUdINTJ
 9xQdLC8VJA1faFtYKXgvUd0IjJTTsQvJYgnPwlyk78YMuExvC+bIa1y1hd/Pc0RiDBg6qV21EZ+
 yklInrY/Nw7j22yujxEBXhvwHSoEvrA==
X-Google-Smtp-Source: AGHT+IHB0J3BPaWpZkom0IG8pReMRSoSIEehPb/xArGHPUL42cUbH9n/rPrZhST/ABDvn6tWdctgBw==
X-Received: by 2002:a05:6000:381:b0:397:3900:ef8c with SMTP id
 ffacd0b85a97d-39d87adcb11mr255946f8f.35.1744138544792; 
 Tue, 08 Apr 2025 11:55:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1794efesm173791295e9.28.2025.04.08.11.55.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Valentin David <valentin.david@canonical.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] smbios: Fix buffer overrun when using path= option
Date: Tue,  8 Apr 2025 20:55:31 +0200
Message-ID: <20250408185538.85538-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Daan De Meyer <daan.j.demeyer@gmail.com>

We have to make sure the array of bytes read from the path= file
is null-terminated, otherwise we run into a buffer overrun later on.

Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Valentin David <valentin.david@canonical.com>
Message-ID: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/smbios/smbios.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 02a09eb9cd0..ad4cd6721e6 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
             g_byte_array_append(data, (guint8 *)buf, ret);
         }
 
+        buf[0] = '\0';
+        g_byte_array_append(data, (guint8 *)buf, 1);
+
         qemu_close(fd);
 
         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
-- 
2.47.1



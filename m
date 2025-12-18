Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7FFD6E2AE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 22:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWMIo-0002m7-7f; Thu, 18 Dec 2025 17:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHq-00021I-N9
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWMHo-00075q-Kz
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 17:15:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso8039725e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766096151; x=1766700951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsUp1MmG6LxP68J7b+lmwDBxwNtYNVBOG5/4xZJXmUE=;
 b=HEreFxTvhV5g7NBd4R88OIxP09/FV3oDzpFN3DbnuG7cHzhOJsQhF1Pur6uZgv5YBc
 e0uymD0SsjgKDNjhfK/awQNA6cDxqn77nVuQR2JEVY7cwFg2bhZQlajdjbXwqnFwsSO3
 bmrg4hVPLQ4gGN245gzulpEoo72LH0xmwqy4edPbunXvhGiy1cWUkRvg25sB6TaioLzy
 EGEz1DkwW+6yXvk9ktAHwUxO9jxzr+bmgrjkPjMr9hPCR7w5r9YhCtoRw9icsaw7bk0q
 Dd85fAyS9U2q31baaAluRXGtvhokqiC0nCfxmY8rtggglj3EVxZ/0XyXdbfEJ8BzKYds
 ajqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766096151; x=1766700951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsUp1MmG6LxP68J7b+lmwDBxwNtYNVBOG5/4xZJXmUE=;
 b=ULbLu44GIjypTgDYLZ9lAEFUvphm6OsTZ8N8aIRxnLLVaSYtCc1mAr6/x/awDRj/a1
 y2omhIvIRkFaCZiiXVXq4gI/tpo46DkrxOM2g3z91ZleZXR2AQrTKVywvw78Ee8KIpkP
 ZNR3Z+g3B45xXkdwxCFzklSBdiBOltnlJZ+0XcKmOqCfTZrG3CCDtdXRolWMhuRAUoSa
 RVexHj9chrVvuoAUsDyf9ENcPqG++MTZ6MdGlLJ5CiDVisg5Yaa22WPDsQxir0XnoPQy
 jw5m6zCjw/5aL3b8PfOWlJngtsoSHwO+rW8lNGf8QWiErCJ0UqVRp+wVayMPCZnFhaiR
 ggAw==
X-Gm-Message-State: AOJu0Yy+rOzvsy392MfyT3ciHI3ZndBf46xZtE7RJwTL+OH37RrLhlWH
 +P8ls+xb6ahRETIZiPJdn0GIwRLE0IOPCYGjJr0Iv4JeP0KtCQzZdFe0bxZXRynOEKDyiktAoYM
 1FJShPIw=
X-Gm-Gg: AY/fxX7MXhLFrhRAxz57N11ZVgGp6AQ3JhVv0Ld4KuLE58Q3xsEIoTuvyOi2yJ8vH/d
 rFMyv7W4LVFY2uZPsRMA5kKBWmtbtspj/4ggHSrZlo/m/4y+GxjuTZIJTlzeZLYoAs6+pYvXwuv
 X3xWi1AsaS3rnxfPSFs3nECDoH3f3eVq3kOxnCCYDabfLofdVDMJNqDa+htWZTMJ7hJylWO9J3C
 jWTxwYPJ4WCfKHKnqFeBKyJCY7Tq0kO66V6lhV650nNz5uIP8i/Fu9TFzzWhcQq9f1kEt2DJjnH
 oggSIfLCpop1pa0QxJko+zoszDTwQaZUr6WjKO46SZuHm7magcLAzsILSPB0c8DTgAoRkdgoUtd
 ml7jfzCY7jZ2RSQoFfbeCVUjTjZ5JQ7IKbAfFljQIxnh5P/BzmDBW8AMt+q+9I/16pU7dzEBQth
 EYlZ3kBFWmFjAWDPOnDEfgVJnTkmzvPoVDo3HXFMcIh/+oN3P66fxtNKGJOUYn
X-Google-Smtp-Source: AGHT+IEchQlRBaLX94GdssBYf3s4IY/Yz2eEcWJ4UgIzfIk2HDyYDgD+n11Jh5LBvvo9ksIHfwYLiQ==
X-Received: by 2002:a5d:5f91:0:b0:42f:b871:66b9 with SMTP id
 ffacd0b85a97d-4324e7042cdmr1055149f8f.56.1766096150825; 
 Thu, 18 Dec 2025 14:15:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2267fsm1165453f8f.12.2025.12.18.14.15.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 14:15:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] configs/targets: Forbid SPARC64 to use legacy native
 endianness API
Date: Thu, 18 Dec 2025 23:14:57 +0100
Message-ID: <20251218221457.73341-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218221457.73341-1-philmd@linaro.org>
References: <20251218221457.73341-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The qemu-system-sparc64 binary is buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc64-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 7b5d475c85d..d9d51d21e59 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
-- 
2.52.0



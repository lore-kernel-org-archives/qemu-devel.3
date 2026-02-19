Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC60E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eS-0002wB-4A; Thu, 19 Feb 2026 14:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eG-0002U2-1M
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eC-0000ff-PY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:15 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483a233819aso8360645e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529111; x=1772133911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZi0vTubS3XDz3bBcydoXNBVcbtnQ4yUgID/nOPQIIQ=;
 b=sVVP9WXos0ptZhw+w8xSV0FJMTHvA6Hn92fnD8pqmYIc3MEWdylzQlqQSRs3u2mBMs
 5t7nwVzajsi6SQR6Ce5rosbb9XhWL8wOeonVv3XsSL9Ddk70zn4nAAFkqbI2RkUFhRwo
 gzt6FfwlBlmHR1JkG1er8eiE3U/7XAWEuIXp6bvREJt5n40aAyY13x/n7OUCVsXXNjp5
 NR1mUtOKZDUYTa/zcMehQZQOfdw6h+K4eeLfId3AxaisWE8XcbdOcMosYgEQcOcSCtJf
 nQzrDOBzTsnof0Ejr8fn0y1bwuQrn2QmWNgeEVooYn9DeQ7wSBGhSb0Hvx8A50OjHH0p
 YxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529111; x=1772133911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZi0vTubS3XDz3bBcydoXNBVcbtnQ4yUgID/nOPQIIQ=;
 b=oUwCjR7u65vSPU1kqyfjfUkdSIGK6dt4g4Uu39zSk4tv91/OrxIu95oUfho50yeGlZ
 2Qzjex2TnWN075QioeSaB2sjTjkG4HSSMMEd8CGMdVZTZjyN0SwaAwcPR/15RxGQ2Za3
 k/4OT6gZrGHjYhWNsFS9l6JiR1Qu/tduZxlqued3HkzCskP7N3msQiJWUPxe9Ar5eTMN
 6Z+WU9UCC6VC2ByUC5qTuywkyh6Ol1kO117UEwnvJ9o8VqR7n250xFxD//UprrjoelP3
 B0jJql3SnAwnlkWZv+nMM1nOINShoBPRJDJV/JN6aY/dImSQzOPtb3qw/uvxTW0X6Lyn
 hcvA==
X-Gm-Message-State: AOJu0Yyy+1aCKEWDkoBTSYyfRCMpOoBblCwkhjODuzmeGWu7Way6oTQm
 ydb3Htnsc2XIWBFhuEgmnmCn3kuPwRXNOp56Q6ENsUy0dm1ABCLtGVkWWMLkebFfylTwSmrRX2F
 nB+uy2pEiwg==
X-Gm-Gg: AZuq6aJDkF6DpWWN7yGy2DWRyxwdwsKFjIZqp5eGdpD4o7tUxxc+ZMWqlRb2+LVR4bq
 Ahxx+hHuWOoS4oiYSb3dw1Pu/NKWhb2VOXTsLp96Ldcjyxv+wn6yu0gmthMAnpgGaJxe5ERMq10
 dNjYTWOgGKzq+ExTZqV5Rp1n+LapeUlPwj6JYnuyvbif8TP8pCT7MA5yV1lBU5YcihkV0849wNH
 wa6E8eqJxIz/y1ud8hNYgkM5jYkEKEfu47EFDLOrLOQF/mianIbUFp8wTqwzbpnBfrrYnDU8wjR
 XJIjy6ly4TXYL4DNIoZivPY+GnITWvL+ZrHWtykDPH5uSuZIX/97/+f49ajlCLS4qfIzzRAClKJ
 C5nsiDOLflyANHf3OrE6FLpH0IjawuAwmtnEu4XF4xUmKksavKfj7Q4XIiPoXl1qhFpEXkxnkoz
 0/svdilNOHCi76ubyx5i1SJUlpdEFcnV2sn3QBFMPW7cFxIvaOaXnY3K2j+1+50090Ekr3RcVK
X-Received: by 2002:a05:600c:3b01:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-48398a678e6mr107895665e9.3.1771529110956; 
 Thu, 19 Feb 2026 11:25:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1b4sm48892881f8f.14.2026.02.19.11.25.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 44/50] target/avr: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 19 Feb 2026 20:19:46 +0100
Message-ID: <20260219191955.83815-45-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There is a single qemu-system-avr binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/avr/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/avr/meson.build b/target/avr/meson.build
index 3e172bde1ce..af5e7d63741 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -11,10 +11,13 @@ avr_ss.add(files(
   'translate.c',
   'helper.c',
   'cpu.c',
-  'gdbstub.c',
   'disas.c'))
 
+avr_common_system_ss = ss.source_set()
+avr_common_system_ss.add(files('gdbstub.c'))
+
 avr_system_ss.add(files('machine.c'))
 
 target_arch += {'avr': avr_ss}
 target_system_arch += {'avr': avr_system_ss}
+target_common_system_arch += {'avr': avr_common_system_ss}
-- 
2.52.0



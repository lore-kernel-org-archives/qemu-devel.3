Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FA9CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mvf-00086i-3s; Thu, 16 Oct 2025 08:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mup-0007Es-2t
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Muc-0008G9-BU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso391479f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617001; x=1761221801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EG22ngCCy62QgMdqNsP3Zdu5DfGyJ4YhEJz/Fzevipc=;
 b=Ae5DQ7tWcyzxDF39Rro6lcugqZjl/8o+0OSzgZLtuyJWYgNtX0pRnIdU2Bp9kQNtdk
 2sEd9fVP3LHkb33U9Dqrb+zKEp6BdudgMsuYIMP+a6nPHv1py6wGOmAN/LXtGtlsDuvZ
 mlhOF1e/upqAN4c6Njtsi3jD4OdxJrckgTQgzMciZPvskl903ss+P5tyYu5TZ8sJqrcG
 Dv3dpzjXLsBRNmjFDwoO4yOfeNZGP+DmmuPprWotLzZyRZ8W7pPQc+bRtdSCKAW6V0L0
 3RzCTmoiFynJwRvFj9Fc9H/FOcTJFmxDdZ4l7US06KX3oyZ7MNXNIol/uKkulHXO7l07
 vBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617001; x=1761221801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EG22ngCCy62QgMdqNsP3Zdu5DfGyJ4YhEJz/Fzevipc=;
 b=fwr5mUdIng48lmageLFTvxXhjH69zFPPyb7jrgG4PottvZdXH4ahxT5u7PETC5/qN2
 reH66r7/NPvHx5y5QcIqd2prsidkqCBE2StNAnkTwhg8PzFDdFZMFxmbXWMrR4pQB2FU
 JNnMNhy0uMCOUF95AMtZ5pPjpEm4JNGloh2ZOCZdAoKphE+ftV7+hFnLWxpg2Hko93Io
 M+8Lym+IvsOuR8kCE3/jtL4lNmCM4yf4PwKtw8/fXCR6vYOOBIAgyQX+TuhNso/w5nLK
 a4U8Sxkup6V1O2qRHhQtlk8Gh9jWftzlFrLfJaht8i4hUi23ffMk8yR2iBPxfSgWXZoE
 Gn0w==
X-Gm-Message-State: AOJu0YyGD1/5nJZUR0EKxokeBuoF9mXM0AlLtQyr3WvdReyxUJSE1/sb
 ujsfKMo+w9KZOScIvjhYSzp6mQDat6qyN9q1m8NtQ/UBQIqW/2OTl9f7n8qn9qHF771WD4oOsz8
 tXa3lVh0=
X-Gm-Gg: ASbGnctB4LLhqBegjDmkakzYPuZYwrByU60voPAr7v3TjoR5wvuMXjPdsHRTAyFq/rs
 nY4OkvRPH3atoHqzQCZPgzQXF9HtaJGbJw0M110/4Ds0u6n2HOYeebgjfFsHc2vU3PJYJHu0MqF
 DQPZqMZQ+d706j0F1KkTG4SDAlZUlkOwe3cevgfBDW4ZAEjcFvRDqFeXokLjDtvi7e1Qt1fqFvg
 9tmOrbDykiL6Zh5GEnifyauLxwxIlTBiQJo+z2PxtliifpP2sqJce6Vg6xBuwcezSbAxVzSLRAo
 EtLVEmlzUKrOYOjIvNrZy6CI4X2Rh0zGqasKOzr5Fhh6FqjCY1oGp1hogfGh9qd+PGNhn2+Vrgf
 vE38R9HXtrmetvvNwDIt3w630EzNLwkC6Kjex4LEJcZ6PiL+rVVOEvd8yg2WXLTnHSW30VkSnFC
 O8e3KfFEDRRqjCLgTMTa6QFGKhyCf0R7rDXlIYOWa+xTytg88D2tWaCNxg3xUz0wNy
X-Google-Smtp-Source: AGHT+IFWGibzj7b2fNBUdOR70jjnuYDaP6kZ44VUgXJH+KFYT0X7OvqguG9ZWMcYogTEFESTyCAIfQ==
X-Received: by 2002:a5d:5d88:0:b0:425:769d:4217 with SMTP id
 ffacd0b85a97d-42666ab88damr21780461f8f.22.1760617001350; 
 Thu, 16 Oct 2025 05:16:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0011sm34928384f8f.31.2025.10.16.05.16.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/75] target/loongarch: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Date: Thu, 16 Oct 2025 14:14:30 +0200
Message-ID: <20251016121532.14042-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All LoongArchCPU::pc and LoongArchCPU::gpr[] fields are of
uint64_t type. Use the appropriate VMSTATE_UINT64() macro.

There is no functional change (the migration stream is not
modified), because the LoongArch targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/loongarch64*
  configs/targets/loongarch64-linux-user.mak:7:TARGET_LONG_BITS=64
  configs/targets/loongarch64-softmmu.mak:7:TARGET_LONG_BITS=64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250925004327.58764-1-philmd@linaro.org>
---
 target/loongarch/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 73190fb3672..0366a507637 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -191,8 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
     .version_id = 4,
     .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
-        VMSTATE_UINTTL(env.pc, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
+        VMSTATE_UINT64(env.pc, LoongArchCPU),
 
         /* Remaining CSRs */
         VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-- 
2.51.0



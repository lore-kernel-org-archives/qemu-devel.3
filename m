Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAD1C0218D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 21:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcGx-0000c4-Fk; Thu, 30 Jan 2025 16:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcGu-0000aq-0q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:40:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcGr-0007t2-8x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 16:40:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1204743f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738273218; x=1738878018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fomha6UOHnqjUpN5e8RHj8i0NspAm/QVvEPupC/Ks5o=;
 b=XgcMUOd8tThenCQwop3uqmU78UQvqJbaZdzRq4JK/NBptD6vb5eHe4fspytrIJV+4u
 gd2V4ILkEPnZDFVhllB9wvVv2DmF5CBsjxAI/C9zCdrrAujagPh6Hv14zTjP+1ONch+j
 kFdVeBAWJxnoK3g96kYJrlX3up0+jWqzkmWR0ABFYF0nCcCjw63Q6SuV4765f573NZuT
 KubykkxB1VgfjWHT1kKNJrrQ6jlyFiuDJHKlF7XKWp+Ap6c3TzpeA7aX2fU9e3vvjXrJ
 KWwx9tqvezB3VjU5Zn/Z624vBpgmT3xljQuuudapfBqDDEJimjuGJ32bBVc7u3who3Qy
 OuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738273218; x=1738878018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fomha6UOHnqjUpN5e8RHj8i0NspAm/QVvEPupC/Ks5o=;
 b=BVY8nxfnarNAgoUG//gGxKajgPdggKJu5RLEEVVzAxP5i5A0VlUHaoDKvgFsjNAKhc
 avG+fDU9Fiq3TiFlUfDPFUX9CPdZc5B9khza2DnBhqpMWGUZNkW0GlSnDPPHzOMoAjw3
 2teyf77bU1LDHeCESlYc6TQTo4tAqVzgH59qcgFPHqkSQs6igwsawB6/7nCdQOXGgcjn
 RTzbuO0fodIS34+oM176dwz3fQMKLSqFGlo4Az+T/VBiMTbgDo4XWVMcVBg5VqsSU/US
 h0Gzb2WWzrw0MI7GtjAWVysIr88Zsz9jrxNjQEVfRvAlmasFdL5LIu+amp+BMoZvg/U7
 //gg==
X-Gm-Message-State: AOJu0YzSU0e9qoLWdpME8raAL3QzaIP+7AIGctHi0RJYWYDx+bxkDX+L
 3TxAjFdLIzT+XTbbczC5ZS1oPJCcBkDhmI2TWSZ1eZHfZQxSwxSpoe5M4TefrrBCtRXqch8NF8M
 Y5tg=
X-Gm-Gg: ASbGnctBOVz802k0ElvggqvvQtE9hReeW03nFBcy3ume6nPy2ADFTGMCTK5cNWATQdN
 acR3WYJ1oIzu7mRlXray+FXRLSC6cPMIPQcnWZrMncP+IGq+rnhqxu4+IpMEBLqi5ej000V2+JN
 4kyJPo79Qvvs5h++TY3lmK+YSCkaOkDj05PJX8s5Df+wAo5HR99z+NeT0OvLaUnibjQKNZy3aNh
 DPzCHjqz3zHy1bEtktgOTLnpfsz7sHOJ2EKFEszbQHht45/smzolZRajP28TAFV8p5cAX7i4MSi
 9Ehl2yHuzmTO5DPeXG2A4lpMwzOJheSQ2wbOoK4W4DRb6Hn7SOC1xRwQKcc=
X-Google-Smtp-Source: AGHT+IGZeeN30Yt3ZRYOdFanKxmxrUAqYiIy+BXSMhawt7iheGzI494E44s/cABgIWF7TVgZ7egNXQ==
X-Received: by 2002:a05:6000:1f8b:b0:386:407c:40b9 with SMTP id
 ffacd0b85a97d-38c5195dd35mr8041825f8f.28.1738273218516; 
 Thu, 30 Jan 2025 13:40:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b576csm3081576f8f.63.2025.01.30.13.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 13:40:18 -0800 (PST)
Message-ID: <25300fda-9d87-4cac-8b68-19d0cc5890ef@linaro.org>
Date: Thu, 30 Jan 2025 22:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/loader: Pass ELFDATA endian order argument to
 load_elf()
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250127113824.50177-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 27/1/25 12:38, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (6):
>    hw/avr/boot: Replace load_elf_ram_sym() -> load_elf_as()
>    hw/loader: Remove unused load_elf_ram()
>    hw/loader: Clarify local variable name in load_elf_ram_sym()

Thanks, series queued squashing:

-- >8--

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8afb2d6cf35..fd25c5e01bd 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -445,3 +445,4 @@ ssize_t load_elf_ram_sym(const char *filename,
  {
-    int fd, host_data_order, must_swab;
+    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : 
ELFDATA2LSB;
+    int fd, must_swab;
      ssize_t ret = ELF_LOAD_FAILED;
@@ -469,7 +470,2 @@ ssize_t load_elf_ram_sym(const char *filename,

-#if HOST_BIG_ENDIAN
-    host_data_order = ELFDATA2MSB;
-#else
-    host_data_order = ELFDATA2LSB;
-#endif
      must_swab = host_data_order != e_ident[EI_DATA];
---

>    hw/loader: Pass ELFDATA endian order argument to load_elf_ram_sym()
>    hw/loader: Pass ELFDATA endian order argument to load_elf_as()
>    hw/loader: Pass ELFDATA endian order argument to load_elf()



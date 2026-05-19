Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E4CCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 18:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOpm-0004eP-Ic; Tue, 19 May 2026 14:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOpR-0004cr-7z
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:06:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPOpP-0005S0-9r
 for qemu-devel@nongnu.org; Tue, 19 May 2026 14:06:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so42851915e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779213960; x=1779818760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sxijLjaWFQBE273Li0ByjRT44fJpDw+PYzNs89ZcIQQ=;
 b=VLmzCQReItTL81M+QHK/4UxNkrTvt8wXkjJ5L1uJOKysPdrYHcuPM/B1ZNN90SqfxI
 G9xRoeStxy4k1B3JwZtbzUAgmqW+hqYvsxk3QCoiyMN+UKQ9C2vjZPXem3TYCkFxwsSF
 1x1Cd9O30fZAq+2vtXbkCcgC/9Or3teN2ivxcXxSkoW/NnVvwS6AYBKYreyL8v85pRI+
 BscEZF5Z58m1DgERz7ywm/2nWHPNkbY8cB9bXx/ijrSHovs2owOimjTJB+Ea9c7MO4ul
 UjJBCjU4nz7sBJXv1SDxjmWo8S6zpnkoPHcjd9ZV+pPxRTi9M0xhpa05fgK3iMFpG6LV
 4lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779213960; x=1779818760;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sxijLjaWFQBE273Li0ByjRT44fJpDw+PYzNs89ZcIQQ=;
 b=BaP9+nHMlsmzxgQ2XOwznySmnp7ihljycavZthmMXrulGRJ97ZzVpERXPuLn9uOUYn
 VUmNtTay5juY9L9XzvrdDoxnamf/7Tcs5G+dojMZzaDjm9L+bwtjXUmPXzn3sbBqyLx6
 YoP1KeGVKrhrERhLNCjhy8qUXsMk0oOz6Qm2Fnci+dnjc+xldrOB9TSPKCMC19qWrymJ
 NUWMbK+lYHDmvAvmtLLpZ1hz2bKeQE9kb/5kMzglhu8QIK1R3FzWTGjxWxqaNWUYfPWO
 fS77WRZyM4zGROB3bw5BmolQnKOtdJ0WMODLMkvurv5l2leMNC8Gqd0GQb3xU8rnRqkf
 6o8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hl7NDpnYbB7p6R6koifcC8DJ6mIdaTm4ZlAxOQkjg6WNZBVC8OP3H/zKVd9hcPHldVmo3q80nr3ls@nongnu.org
X-Gm-Message-State: AOJu0YzvNw3IxUSzU6ZYYr47gWnoeRAkLynZAac3sXDSYwSj+Kt7JBy1
 soDvarJYe5I7A5IcYWkZIpFGtelXhuvJx6pUtoIttUl2EmZBFTakhcPbykIB9O3TdyA=
X-Gm-Gg: Acq92OFexO8NoP6iDZ3oyYaz+qnOPFmSCebCSW+un1fb1nmNYYnmKV7v5nR8A/1luLI
 5564ygaIVLOOuMZO56JaEcwyebnEvod3img4jY0GcJPZizo7YJKxjxqYseIJcuOgUeDyGo1R0zl
 BGEb5s2SMySD6g3wN+hgvB4SlLjvEA4f7Kn+n1JEh81Jy3b0Sk3sR2OT4DMYgEC1PmXiv5m2CNh
 gKqv6OryoO5B1h9bLbQyQ5odVe4oOExU6aSMz374rlXfWabGqO15a0rWrd4whyiZQyoF5u4bhnG
 1HwAnqmQ6sizzTQ3KjNYWIhhFfv89/Li5dnPwj+Q2n57M/uV4mjIxzvphJOCYQf4HBEqkzESLX9
 xACADKVy94PVz/6XgQrR5Z0OdyiEz0xYLW2iyxT/4GZufWhelnq+5Q4sFutoPYAOejB9ZLcti8j
 a10ObTUg0W3XmlJLivuq3tHJxE8kNNU9NpwOQcHW8lPCefkSmn2tAwnCTkJ/M2eavv5Q==
X-Received: by 2002:a05:600c:8184:b0:48f:d1b8:9aa5 with SMTP id
 5b1f17b1804b1-48fe60ecd7dmr315389475e9.8.1779213960367; 
 Tue, 19 May 2026 11:06:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694f2csm343268685e9.4.2026.05.19.11.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 11:05:59 -0700 (PDT)
Message-ID: <b777d379-4c88-4d98-8a79-69b25f14d7b2@linaro.org>
Date: Tue, 19 May 2026 20:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/40] target/mips: add Octeon VMULU instruction
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-18-d7dd735ecddd@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-18-d7dd735ecddd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/5/26 18:22, James Hilliard wrote:
> VMULU multiplies the active Octeon multiplier state by rs, adds rt and
> queued partial products, returns the low result, and advances P[0]/P[1]
> with carry limbs.
> 
> Expand the two-limb accumulator operation inline with TCG so the result
> and partial-product state stay visible to the optimizer.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> Changes v2 -> v3:
>    - Split VMULU out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v5 -> v6:
>    - Rename the translator helper callback typedef for clarity.
> 
> Changes v7 -> v8:
>    - Use Richard Henderson's v7.5 inline TCG translator with
>      tcg_gen_addN_i64.
> ---
>   target/mips/tcg/octeon.decode      |  2 ++
>   target/mips/tcg/octeon_translate.c | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


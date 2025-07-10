Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E94C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZt5y-0006jv-AL; Thu, 10 Jul 2025 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt5l-0006Qy-8u
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:21:51 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZt5j-00025K-IU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:21:45 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3226307787so1028013a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752160899; x=1752765699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=amuIooxmdQ6Vls2FAyQEa1uAT17Y/FmWIkMrObH7Y7A=;
 b=tRaXF6+gAyi8+zeqs0awqOLq5qo2oHHrHvQBdodKRG/R1FrAlmyAoRwIGMFudihi2l
 QLFw203ejbcFzJJygqbIn6x+p3q0fsug5yTwr/ZhCnLSLsQ0QmoiVrLa1NOYNV46fg2x
 WIh6eGdz1WlleGMoj8R9UN8lyCsIEK86b9t/ebo/KbSiZbykOBMRB0nJaF2tldb8wOYg
 B+z88I0slGfpcJrCGvnXANZIDPOLarnh3dpqeuvmHnLHRzp7Bg42/bCIwjhwI30MzIpV
 P+25KsQX3X8rtVH0JaFJREipBEmOxFJNFMUDb1tUqSmL/bog8skANGM7DcpHhhMCen/i
 2e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752160899; x=1752765699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amuIooxmdQ6Vls2FAyQEa1uAT17Y/FmWIkMrObH7Y7A=;
 b=iw3DhNBa3H+RoDDGwhcjx2Vw2mFXf/yFZql8c7kJZXuUesWnry3eFoF67wbFa/5OmV
 pqnhQ+7QxfM8D6eyKn71gr5JwvHG+hEeRhKGpIeANGSgSX3s2zNp8XrwNpMspHwETxY/
 m4hMMWMC7iIo2A3/Gf2IZUy44U1YO4T7PpvcVLd70B9KD0HlUWf8421IcbPQ/INLOfR5
 h9ZR0aAx1QPO5jzWHThnK6TbbhtXIQOIqL6ofKsX8Y3Un2cdZqzunlBG7aVnCytawQg7
 DjqYCudyv25UTonVNRET8jVMSD+vmyizuO8v7bRLyQJ4iFBN2e2fDd0HSe5rI5EkRXTQ
 WmWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAKrZR1qGganTqBNVWvkztQjlmMR6/IKfxN+U+YZIALX0t/oQzpPplHdXndKIqIGwl+W43si3taaLR@nongnu.org
X-Gm-Message-State: AOJu0YzIJM1qTYuKXO5B0Fnzn8mrMSDIpFw4lKbG/N3hPW3BWrUZ9fHA
 GOlt4xeU3bbr+MhfeuV2FAfv3UivosT2UTBbF2bV38xBc8JODlpX4CilH3tWzoGJFJo=
X-Gm-Gg: ASbGncvHUo2d20VW7TX+GPJ9UWE+XtDk/D4Lbxq5mJp8hMHiLBaeH5wrO0AvgoYbOWb
 aHlBJE0/wRhwqlObmxdoJzWrjd8KNpNx3+Le6AWImtNTuqjmpV58tqmnKMWaTA0AzyKJYjvVwuy
 AwwlDvcaSRsmSozxAphD4FgdCuYHGD7jhNcdJjZn3g2NbyNzZN8FhE95zdD5A9dtoI3b7HBg+0e
 xatntibVacOzwm33qL/noWIYtvCRwE0dRQ+B0/zRxjgF3BED6Rp0syZDTvCACUoL0afrlATaUxB
 rRhQzJWYGGfA9nQQU5uUf6VBVqTPGytBBfy0wbBl3DTX04y/kjGhe0cNjhe8Spj20gwAdlukuCU
 =
X-Google-Smtp-Source: AGHT+IEazxMcukHFt0MEZ8rdSTG4T0kB38aGtdyk4BOGKpvX6PZUJhQEKPXzPj+O+eNnoSbE8BSFCg==
X-Received: by 2002:a05:6a21:99a3:b0:21f:bdcc:843e with SMTP id
 adf61e73a8af0-230040daa3amr4616445637.11.1752160899088; 
 Thu, 10 Jul 2025 08:21:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e069b7sm2817307b3a.55.2025.07.10.08.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 08:21:38 -0700 (PDT)
Message-ID: <f6c75047-d074-4200-a33a-c864e7beadf1@linaro.org>
Date: Thu, 10 Jul 2025 08:21:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/execlog: Explicitly check for
 qemu_plugin_read_register() failure
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250710144543.1187715-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250710144543.1187715-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 7/10/25 7:45 AM, Peter Maydell wrote:
> In insn_check_regs() we don't explicitly check whether
> qemu_plugin_read_register() failed, which confuses Coverity into
> thinking that sz can be -1 in the memcmp().  In fact the assertion
> that sz == reg->last->len means this can't happen, but it's clearer
> to both humans and Coverity if we explicitly assert that sz > 0, as
> we already do in init_vcpu_register().
> 
> Coverity: CID 1611901, 1611902
> Fixes: af6e4e0a22c1 ("contrib/plugins: extend execlog to track register changes")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   contrib/plugins/execlog.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



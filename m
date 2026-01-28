Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF576D35663
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vku0J-0003tv-SS; Tue, 27 Jan 2026 20:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku0B-0003ky-Jj
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:05:47 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vku0A-0003fP-1F
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:05:47 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso3403536a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 17:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769562344; x=1770167144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSTF0NQiQFsPZYRp1IMFEPI0U22hlOW6gIVvYY0wowA=;
 b=QFwRLRsjQdaEkwxa0udyr01/WNGk0yM0lON7/3r8D/eB0rLz3RApWDMijlDEToNL+L
 OU0GOaqsXeVMXHYd3fczBC6vdj0KCNmpA/qfdC+fcdS9kh75k7TiN81RQEwkr7rI85bI
 fi3jM7x5Sp/3bN7JVY6N21dHC51pBqnSzwUwkQKDKrmkScUiPZAHtCoYM6Q09/5nrZIt
 g3J/ezRBuLclMmgAigHpepnS5QenQ5GRerdK688QKI9rQX/ttrRKN9tvU3AvwBKqN8Ia
 n6SxDQ0xik6cRw/YRoTwcyT6Q4wHexXnOxQujcqgWTjJYQYq3741+GZRu1VjJT4fL1or
 Dzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769562344; x=1770167144;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSTF0NQiQFsPZYRp1IMFEPI0U22hlOW6gIVvYY0wowA=;
 b=tw+/kf1cwYxrfLzL8sY10myZxzE1rmFXXfnSNATd2tFScEDpnNxQ0Z/KW6OWbOIxEF
 115HXRwcPK2EuyIeN8FM15I7SfJWp1Jpz5tMmOBIjnQFkXLIVZEvXFwmocGMviQu9x8a
 njDy2WcF32Gfp3xFx0SZD9BsTfvHCe7H7or96f9XKJUceWO7N6srC5XBtiquXurtNwUx
 Jk8jthfEvDp8X94F44creTw1zYQm0bFv29CeSjxnrSzCj2G7197pqfctuZOy4aXgUZtc
 q+5YlBXnMssJbVkIw/QYSLlT0e7rBDPYERh8ctyzCm9A8oZXHYgktMqQiyFqKlAjMgoA
 8HLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1+VkqWfGrQd+J+7oCH9h4ZDPv9q5MwjTT+gNBJ6WFyotcQGbPyRgQOkXen7IOWiEsTiax33neYFWN@nongnu.org
X-Gm-Message-State: AOJu0Yz/La0a6NgVOmi8oIPxVoCTcAYcnICS5Mv6+zCN5kpJSmILHPCr
 LEocsLCanDQhe7HBSewmUKQU4nfhpQEGUwhO84hTOe6TD9bT+Ktmtfmb2L9Ar2/IWQo=
X-Gm-Gg: AZuq6aIqblcn14IElOTHVCiIuQC6nny19UEQIF+atYToUnpxZIsIG2XyHXhvMfzhLCc
 219Z8fiVAto4kitVncj5I8RHm1gt2I9YzJbl9KqCC6+Bd2WFL+9C6eE2h3D9ta5QvIBfTinPteB
 T8bPWblSV8g/1a+n3PLRBfkBJwEGIAjOPD7v8W0j9+OW/vaNgOg8uef43fVNz4TS8fc92mPy1zP
 dAB/blyouy9o8K5YIsPY44cgM0xj9448vDQSDHMhehFScQQYyrSC8vXkIUZGBesT7lMvfc9K2Fr
 TPR16MVlt/8c2avoGALFILI+EEKSECEGFckUSQHDGvvC8jpjFJk3hiZIZOxCb166noDt82p01yN
 w7Vb/5vo3ZFbbwegelZpkq7WqMZV2cnB/vA4pOf/fAHZmmc8R++kIcJTwzWCd0uMroVStbwUB1v
 TyyV/CuE07SGBm94TXjUOry6CrU9Y5dw==
X-Received: by 2002:a17:90b:3c42:b0:340:6f07:fefa with SMTP id
 98e67ed59e1d1-353fed74b0emr3175343a91.20.1769562343539; 
 Tue, 27 Jan 2026 17:05:43 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3540f5e68cfsm330304a91.1.2026.01.27.17.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 17:05:43 -0800 (PST)
Message-ID: <459ffb4e-c831-4694-83f3-32ea610f72a2@linaro.org>
Date: Wed, 28 Jan 2026 12:05:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix uninitialized host_pc in tb_gen_code
To: Panda Jiang <3160104094@zju.edu.cn>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20260123091505.20025-1-3160104094@zju.edu.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260123091505.20025-1-3160104094@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/23/26 20:15, Panda Jiang wrote:
> In tb_gen_code(), the local variable 'host_pc' was declared without
> an initial value.
> 
> If get_page_addr_code_hostp() fails to find a host mapping for the
> guest PC (e.g., when translating from an I/O region), it returns -1
> but may not update the value of 'host_pc'. The function then proceeds
> with an uninitialized 'host_pc' variable.
> 
> This leads to undefined behavior when this uninitialized pointer is
> later passed to setjmp_gen_code(). This was observed as a segmentation
> fault (coredump) when running QEMU with the '-d in_asm' logging
> option, which enables the code path that uses this variable.
> 
> Fix this by initializing 'host_pc' to NULL upon declaration. This
> ensures it has a well-defined value in all code paths, preventing
> the crash.
> 
> Signed-off-by: Panda Jiang <3160104094@zju.edu.cn>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fba4e9dc21..140f100cca 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -266,7 +266,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
>       tcg_insn_unit *gen_code_buf;
>       int gen_code_size, search_size, max_insns;
>       int64_t ti;
> -    void *host_pc;
> +    void *host_pc = NULL;
>   
>       assert_memory_lock();
>       qemu_thread_jit_write();

The uninitialized variable already violates the contract in the documentation for 
get_page_addr_code_hostp.  I prefer to fix this elsewhere.

Thanks for the report.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5C3C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 19:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trMV5-0002y7-1g; Sun, 09 Mar 2025 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trMV3-0002xc-8d
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:39:49 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trMV1-0006gs-7N
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:39:49 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so7388206a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741549185; x=1742153985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GLbu3KyXotsCoBa1QuTZBe4rqaUMhyZKSiWkGUUrAk=;
 b=PevtAJmC+zZCRBvVnMfo7UQRJKUsyXNMOaMa3AKtiVgwmDabZNTMD8E7CeP+cyu5m0
 qnDbp2SaNm3aQOLZvzr1yuyI+JBZ2P1bMC6kEaXjcqIOPOwyBgQpjDJGZBYCByEYDy3w
 RZIan1Quek2vVuR/NshmVCWaJnEzO8iyN4MSGVA12UHqlH5YYwypFkcFx1G6KikaFxAd
 kfPanqTEbel/XJYaKsdDPmN0+5cT5CwBfa9P+RrGopiM+xQziGXjVdbIDfXPb4kye08g
 toUR3oA54iFD5ONlL9JaAXSi6lZmvxitujtjR09dKG+EoH58a3tqf/cok9Rp9ZO6UDHk
 zpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741549185; x=1742153985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GLbu3KyXotsCoBa1QuTZBe4rqaUMhyZKSiWkGUUrAk=;
 b=wuw6lRywLdrgIkCQnnbBxgNJP8WSffrLu3XzMWnTK8Elrmzdo5SuVOF5Rms7lLzM3j
 XR6Z2xK9o9Fn1CT0nQgKJOnRe+I6pX87M64o55xF7PeNgSA8YWj2vLM3LWVqRbCdMCWf
 xWgzdBd/J2ctLvLYcomGROklLk5oVEAa5jaJkQhHvwh+Y4HtaUfgfuowgyzbaU3oaoYF
 DMPJrE1PMquJiltHxNiKbXZMlZEhJmdoYZITD/BVQG94Ftyd5B0HAmSQ6j8qwU9bP68K
 blFfmpk3bKtMCX6EhMVZ/n53R5b8Y0VPPkSqz4vO1nYBWnB6+CWOrLM60F4zHadkkDVA
 pdHQ==
X-Gm-Message-State: AOJu0YxNTqrCTCxLl4sjENSb/RzdCSS2qg2t+E5FxkCY4QU11YAGwChR
 ZPNQd7zi4Q8yXOqrxFpLo1JF/tSIHbzTtY1rKaUGAp+MAZAMl6vHOwZTN4Fu9AfvE3Vy0/Ydiw8
 s
X-Gm-Gg: ASbGncsIn7xWLLTleF+ntaWBedgyz8Xh2/6d9mUlqpqj8xNep5cGxvmB3pPRpJv3aKT
 uwyOvNXHuiiN5DEOaeao0UYrSnQ2YxbjsksZQX4W8MnZPWJiOBp+TiIy3wY/DUrlaN6GSrpF0fz
 PHapEl6cWQeQjvj2RwgKec7dFpi3Ww6YccFAkqFH5XDJcB3K0YCtWnZ1VyOvnZT7UWL+Qm8jFPK
 +hfttI6a9DjGp8p4vLyhN1kAke0x3zsheR1j5lXKOFIsho/UQAMjdyjCW7gVefWBuJBenyPQ40z
 T7SiK5YPKu36h11yIBVnywWq6KQgxg512DRPustERp1ShDJPBIaIyADrng==
X-Google-Smtp-Source: AGHT+IHpxTIpMt521h3ZtiPaAGQbvwh/VU2tPjYl6WME5mcjZ/dCFCV2nKl/h7ocKM/ZlZFUo2LZgA==
X-Received: by 2002:a17:90b:4c44:b0:2fc:a3b7:1096 with SMTP id
 98e67ed59e1d1-2ff7cf128c2mr17429601a91.27.1741549185216; 
 Sun, 09 Mar 2025 12:39:45 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7ff9f7sm8365919a91.33.2025.03.09.12.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 12:39:44 -0700 (PDT)
Message-ID: <f039cefe-e1fa-4c58-9eb3-0f7b6f22cf83@linaro.org>
Date: Sun, 9 Mar 2025 12:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: initialize target_page_bits as soon as possible
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/9/25 12:37, Pierrick Bouvier wrote:
> Allow device init functions to use it, which can be convenient in some
> cases (like hw/hyperv/hyperv.c).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/physmem.c | 1 -
>   system/vl.c      | 3 +++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 8df9f30a0bb..c5fb784a9e1 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3281,7 +3281,6 @@ void cpu_exec_init_all(void)
>        * do this much later, rather than requiring board models to state
>        * up front what their requirements are.
>        */
> -    finalize_target_page_bits();
>       io_mem_init();
>       memory_map_init();
>   }
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03a..c64f8c8e808 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2848,6 +2848,9 @@ void qemu_init(int argc, char **argv)
>       bool userconfig = true;
>       FILE *vmstate_dump_file = NULL;
>   
> +    /* Set target page info before creating machine and associated devices */
> +    finalize_target_page_bits();
> +
>       qemu_add_opts(&qemu_drive_opts);
>       qemu_add_drive_opts(&qemu_legacy_drive_opts);
>       qemu_add_drive_opts(&qemu_common_drive_opts);

This is related to a very recent change merged.
58d0053: include/exec: Move TARGET_PAGE_{SIZE,MASK,BITS} to target_page.h

Regards,
Pierrick


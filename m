Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32F9C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 05:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td0nv-0002py-BS; Wed, 29 Jan 2025 00:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td0nt-0002pq-Cc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:39:57 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1td0nr-0007cJ-IZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 00:39:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so154594225ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738129194; x=1738733994;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtVTZ0lUjv/EwwEHhHcHaoUj+ZO+T4elwz33a0HovtM=;
 b=uzDvzXS/o0wCt08rXHFf6nB0PBz9qI1+mq3JtC7PcjpORo+V4SOaMeHYqIb2qDiU99
 7austtrSZvJkqdSrwHDPWfifj7Zsn6nLF9XGLHMjHYlmMztLmH4YrpzvMimDChOYWTtF
 CDZwem1ArxZDVXb6d6nANiZdK2aNVv04g8AyOUNqrE1iJ3QpVBzOw+BSonUQ5Io6O9Fg
 GXCQ6MXKt8uXdrpSv+DzoW4fzHWH0KIUKcTPMSceX5zwL4d+XDZkTLZdr2JTJmwqfhaI
 luzc0NZ4tVr+xDq0oN7Y2a25xTHGkFDF4miMzsVXBgABXhqAVLDBYhNZ+A6ziVEdAGJ6
 8ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738129194; x=1738733994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtVTZ0lUjv/EwwEHhHcHaoUj+ZO+T4elwz33a0HovtM=;
 b=sEPYoUUTuurdjmDlFkC2+CFqmesXJcJEYlEHNAUbILcwa8N7GzytwEzJhcac73ohkj
 VWUllwVwYIFjXXAGTa66lmOD5/Hzwgj2otNQ5ahbD0OGbmeHfIBx/tp/Ov5P9vE5Q/5p
 EQBggPQ3DLR+1dsmN14Pj+npO71fj160P3+cUoGAlhUwcdevilVTfp143fOlAoBgpH9C
 vr4Q8z9o/zsHl9ykUUCEGUAwtHp3c1/QHm5ItB9yFxfVGVUVhEL2+xZ5A7gR3QK9oDGy
 PSc3HwpWoAOkAFFtiYi9qVgdkkxR1jbgxBL1N3HUG3HllRXqn538T8gI79/xGYCXqEZq
 HcGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcoe7CnSF/inI/Xy7cpRVr0ucZjW/x/9PCs0WXoy5Gx1aDG/NUTiU1k8zZ5LFSkDZWlYagfvmSm2Hy@nongnu.org
X-Gm-Message-State: AOJu0YwuupLRJefNsNmtFScG0zinOOBS+LjVKqhxfK3qugL83PhygtvZ
 18oLqqVqnjnueJA0peKvWaGZqtQR46T7xgqPk2UfWilIkqtctHXGq5diD9ApVXZVpWbTM8lbDaz
 qhqw=
X-Gm-Gg: ASbGncsgBzdhDN98gsxR4oLTBZ2EDUv+sO/CAH4pnIocz2a6YUj7lUgKVwif1FYWYXG
 qucm3yNRneG2tw+zj03UUCd43p1IB2ZuVX1sYmq0FtZWe4oCIgk8CUe41xSXt8gxRlWaXNW0UOd
 3jo+0KUCctVtehYnsLlGDxQKRkySPqO65+nIEQo1strfqRqgh1QTY9HxQaWp2Oh7VEDq15vibyB
 SL4nQvlDD5iz6PiNcPxizqdnEFcIlk5KZZG1kWONVEV9l9iJvPtfJAAbPracKUEkdo4hwkR9r3E
 GGL5yRrIXUhnWaE8rixu7tgG1O81
X-Google-Smtp-Source: AGHT+IG1Nr872xkmuoqDWTq/9YSOhqsyyxxn58yWTbVfvuBHimxMH7xeIsj720m6vtWb66dyN201lA==
X-Received: by 2002:a17:903:98f:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-21dd7dff8c1mr34036365ad.44.1738129193795; 
 Tue, 28 Jan 2025 21:39:53 -0800 (PST)
Received: from [157.82.205.237] ([157.82.205.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea1f85sm91243065ad.55.2025.01.28.21.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 21:39:53 -0800 (PST)
Message-ID: <f77e2f82-fc96-407c-9bc9-5bd4762a0d93@daynix.com>
Date: Wed, 29 Jan 2025 14:39:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] tests/qtest/migration: Run aarch64/HVF tests
 using GICv2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-7-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250128135429.8500-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2025/01/28 22:54, Philippe Mathieu-Daudé wrote:
> GICv3 isn't supported on aarch64/HVF, but GICv2 is.

Commit bdb0ade663c7 ("tests/migration-test: Stick with gicv3 in aarch64 
test"), which set gic-version=3, says:
 > Switch to a static gic version "3" rather than using version "max",
 > so that GIC should be stable now across any future QEMU binaries for
 > migration-test.

 > Here the version can actually be anything as long as the ABI is
 > stable.

So I think we should always set gic-version=2 so that gic-version will 
not vary with hosts.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Test eventually timeouts :(
> 
>   tests/qtest/migration/framework.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 5629b8ba4e3..30808de14e0 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -266,7 +266,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>       } else if (strcmp(arch, "aarch64") == 0) {
>           memory_size = "150M";
>           machine_alias = "virt";
> -        machine_opts = "gic-version=3";
> +        machine_opts = env->has_hvf ? "gic-version=2" : "gic-version=3";
>           arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>           start_address = ARM_TEST_MEM_START;
>           end_address = ARM_TEST_MEM_END;
> @@ -303,6 +303,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
>           } else {
>               accel_args = "kvm";
>           }
> +    } else if (env->has_hvf) {
> +        accel_args = "hvf";
>       } else {
>           assert(env->has_tcg);
>           accel_args = "tcg";



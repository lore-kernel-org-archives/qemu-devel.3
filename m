Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A74C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkwU-0007xp-KO; Mon, 24 Mar 2025 12:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkvz-0007pl-47
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:46:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twkvS-00018U-Rl
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:45:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-399676b7c41so2459912f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742834721; x=1743439521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bp8xeRYI2Mvm4SOedu+lA0vJWJYO0zux85Nk6Gw5TQM=;
 b=PnaAO0BLCfjz/l2rI6iYkefI8QrmIdXifftDjQNlgll4I8TE2k3Oz8tE4mkdWgE9HD
 6aC2GvXGsAJw74qbOO0tkdYqBaMgSa9KZnZClty82O0zzsfyVGeypwupOKJXfIkxP5yk
 gHecgeNHJzGjvMcI9zVClCot5f2+RBW0BSz5tBZF2jEgm4DTVWqDqvWjYrw8K/theY/H
 MbmOF7DanKxjygdQQgsIaSMcY0nakw4efoRBjYiKz3dslL5OkUMe1yWSN23UGmZCsfFb
 haH4OmLhrxjpDkxOHY0oQ+Ge/Ogcq5FxSAQyyix0nXtqbs5ojYQD05W3GxuJ8mNSrjsd
 L1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742834721; x=1743439521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bp8xeRYI2Mvm4SOedu+lA0vJWJYO0zux85Nk6Gw5TQM=;
 b=t1QTbSpSGTG4HQ+19oZxC6Wy6lQH1wcFmXW5NLUG4qOeW6nadUzyAHkzhr/mRdVQng
 IaBwZZItjaX/cqGkgLw5BSEWUA8EjgkhSOn2Pcjobzg4xmboHTOwifY5USt2mjlWj0OC
 LEFvOUq+7QWBLMevsH1/fQWNWpUyLF1ZwXVvoweDHC2o5KrQP19+a4SP0ewtPK9Nr6xj
 EDfzwVKWRgTSJhYJQVMksihvmRfTY08+5OPtf7UOw22isBkxXnLniqnx6ao+DfdMzzt3
 ggxHmue0x6sAwYCxhO/JnFjoZBClU/wxporU3MUG/fw2uh9HSucpiLd/RpfCD6sIW++z
 /dcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUvQtmHj2N8WEF2ltfJQxTvcW4uLHjzERG3Z/cLw5NHf99l+7wusHeX0Eh9BTZsUlzZk/GXzC9uK0l@nongnu.org
X-Gm-Message-State: AOJu0Yy5NqPqJf2HnoSb9dYh+CyhHFXVQ5D5lcnpCnFONZSZceZ6FkCx
 g7JFXHFf374rqsCmOxJr4jivLbipV86w8yr0iGVcNn1pUbfXvcEH8PLOT4kZdvI=
X-Gm-Gg: ASbGncvdyIfwcF9kemBS9Yn/lC8SDHy4htwxnRVIvj1hXQBmnrFR6MkhWR3XNIGMlkR
 /PnwlmKj87NHjkecqbSehUi90dWo+6URNuL5vUr2NDvlnpK0e38wMkhdrqjbsnFYTADP1yoIeGp
 nYQQwAnldbcpaodcqvY9gvZWj1eq/f5sZw1nzEkM0ZEDQAWZDMclQA43XsmUzGZIE9qZqwo7wZ4
 4xYIzgxw6HSgMzOWDueWp/Z+15iaXg9evdV3QjQWyHlrLFXvTbxIIi7OP3NwZ7xTHw2OLcJvYDY
 ivh+ypA1FMy2HuLVmwNidh5xDUX6RmRmfughs4oYyffdb8lrGS/KE8ASDVKLq0kE9EtCvxs/vON
 NV5KidydDZAU5ASqCzNc73JJZuLjn
X-Google-Smtp-Source: AGHT+IHwqTdblpPgrJemQaN3hNrCK+s4VCxRmwdQY+W3hj6KH2ZvxklHrIMWUdQqXYIhG4/OVvepsg==
X-Received: by 2002:a05:6000:188e:b0:390:f55b:ba94 with SMTP id
 ffacd0b85a97d-3997f8faeb0mr12844092f8f.13.1742834720858; 
 Mon, 24 Mar 2025 09:45:20 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fdbcfaasm124251195e9.35.2025.03.24.09.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 09:45:20 -0700 (PDT)
Message-ID: <519034fa-3336-4317-ad20-2c4574488e0c@linaro.org>
Date: Mon, 24 Mar 2025 17:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] target/microblaze: convert gdbstub to new helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-11-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250324102142.67022-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 24/3/25 11:21, Alex Bennée wrote:
> This is a pretty simple conversion given a single set of registers and
> an existing helper to probe endianess.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - use mb_cpu_is_big_endian
>    - use explicit MO_32 size
>    - handle differing size of env->ear between user/system
> ---
>   target/microblaze/gdbstub.c | 49 +++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 27 deletions(-)


> @@ -50,62 +50,57 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>       CPUMBState *env = &cpu->env;
> -    uint32_t val;
> +    MemOp mo = mb_cpu_is_big_endian(cs) ? MO_BE : MO_LE;
> +    uint32_t msr;
>   
>       switch (n) {
>       case 1 ... 31:
> -        val = env->regs[n];
> -        break;
> +        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->regs[n]);
>       case GDB_PC:
> -        val = env->pc;
> -        break;
> +        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->pc);
>       case GDB_MSR:
> -        val = mb_cpu_read_msr(env);
> -        break;
> +        msr = mb_cpu_read_msr(env);
> +        return gdb_get_reg32_value(mo | MO_32, mem_buf, &msr);
>       case GDB_EAR:
> -        val = env->ear;
> -        break;
> +#if TARGET_LONG_BITS == 64

Not necessary if basing on top of:
https://lore.kernel.org/qemu-devel/20250212220155.1147144-5-richard.henderson@linaro.org/

> +        return gdb_get_reg64_value(mo | MO_64, mem_buf, &env->ear);
> +#else
> +        return gdb_get_reg32_value(mo | MO_32, mem_buf, &env->ear);
> +#endif



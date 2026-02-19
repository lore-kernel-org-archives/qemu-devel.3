Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F935C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBLE-0003M6-8B; Thu, 19 Feb 2026 16:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBLC-0003Kv-RD
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:13:42 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBLB-0004Y1-BQ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:13:42 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso746885b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535620; x=1772140420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/IRZOYRhscUq6voDan6WPABBOd1g0Mr1/BB9LatgV60=;
 b=iOsf9Ju9Z7/WQo7yvYpv65w6nEilWbjtzl+hSHZRALFx5xiSnjuo709mvM60tWEeeL
 oti0lBDvzPQD20s3fXzJkDnC3Is888wOMYltzlyekIPGKJa4dhvf/Bkq8oTv/2OVPyn7
 NX56ydo3Ho+MYq6Mlln0MqtumoVt7pqCDo7PUprj+G8Cu53PjmJ4r/d66LbdawhXEzXX
 HYYmsfD5BmLUp7VChT4vJed/kdyQMq3HCdpyws4zu72etLRoNCqIH44oPRax/tUt7tao
 RkqU9dtG8C1FAH7a+3xHInYwIg0M/acQtN5cZKto7OsKkYruh2oicuIUoKZbYamPj4gq
 oKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535620; x=1772140420;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/IRZOYRhscUq6voDan6WPABBOd1g0Mr1/BB9LatgV60=;
 b=MkpRmkhg5QLjJLZKnniQtZqIZkwI5ihAXQFGqIShj7oRtnuKR6LyaL2FV4IsYyRBcZ
 h/IunBYlfmZMOXXeyqm7MRyiCon64PWvfqLerJ76z82tBxEHFR3qhKmLaF7v5qIa93kW
 OHUgXhYgIjoKa3iH25B+bhZUfD3Y08u8VbXBMxyuaPuYzFgUKL3DiJmmy+eryVKK89Wn
 4VgcI4oeqd2CgZoL0CkvdDaWC0mpfZWXrZ6QKTjdxJBQRNvEcy1gyGZ0jP2+qkc16NNq
 3SunzxFLuUeUvAOgz7ghcWTKYKn69qAcRGx+9gxjcLZdsHVwnAzWXHnBA6eAVPSKQI2T
 GzHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYa7bcGh/wY+FkPWqlThQzwhrPO3H0DfIqbAPU/acK7AQkLt9Aj6dwYsBJiPkn7kzZfMAm8QbQQRz@nongnu.org
X-Gm-Message-State: AOJu0Ywk+eKxTy7sHase9qllnXQW3uW+ZxalCLJodn7ppQ2nr3XM4oET
 rsb2e3glXOrDh3w9AOLz1c0vntOibJu9GwyqHjbzhlEoNBuzYcWi5uEpkr2iB/NX27PeK+KkUX0
 b8gVn
X-Gm-Gg: AZuq6aLEHOeABt9vj+iaE88e30TDozu75L6uuGDsMxaYvcLk/Pw2Pw8UXF0PQNl5mn6
 b2rOkU6/YbhwFB9UQzi4IXUNIGXhi0biAHTJc4DuHlmhM5jTQ7eUe8AG53f8ldF4kSQQUF0rKNI
 PcSPoCzSgtF9hgb8RAB6i3pocG28gYfbGQ0r6eSYNSxJ9VQbez58PWtNscLyEIVMbW9yQo7yJ3Y
 xjUpIJfhs/i0stLOCqhgCFZBAeFeV3gtayijSGsoUJq6kV5f8ljl+7yzh83rhJWf4+KNNPXGSdw
 aWv4Y25K4Ln7EcrSnSWU1ty09aHxczBzaVbHRPPDvCDuHud3UZ19SUBq3CC/gI9SvjrGyMncq7A
 4+BMv/nsmOFgyv+BB33yl5jlLDMC7qF2ot+ai0WzwfwcMHbNuijU4c7NAq2Rx5LWQHQd+rG7vdy
 Vpe3ga1YX/c1HAvGlfudxMqogi6ofA01S2i7l+4SZwWNUFKqe8WqbBSKxAAz28zrk3lt8ToO2DW
 lGdTOY=
X-Received: by 2002:a05:6a21:6089:b0:38b:d9b0:e944 with SMTP id
 adf61e73a8af0-3946c957bd6mr18849472637.53.1771535619948; 
 Thu, 19 Feb 2026 13:13:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fd0c81sm18093175a12.4.2026.02.19.13.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:13:39 -0800 (PST)
Message-ID: <31a427fa-54ef-44a8-a93b-7fb1c98b6f93@linaro.org>
Date: Thu, 19 Feb 2026 13:13:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/50] target/sparc: Expose gdbstub registers to
 sparc32 targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x443.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Import gdb-xml/sparc32-{cpu,fpu,cp0}.xml from mainstream binutils,
> tag 'binutils-2_46', found in the gdb/features/sparc/folder [*].
> 
> Register them by setting the CPUClass::gdb_core_xml_file field and
> calling gdb_register_coprocessor() in sparc_cpu_register_gdb_regs().
> 
> [*] https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/sparc;hb=refs/tags/binutils-2_46
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/sparc-linux-user.mak |  1 +
>   configs/targets/sparc-softmmu.mak    |  1 +
>   target/sparc/cpu.c                   |  2 +-
>   target/sparc/gdbstub.c               | 13 +++++----
>   gdb-xml/sparc32-cp0.xml              | 18 ++++++++++++
>   gdb-xml/sparc32-cpu.xml              | 42 ++++++++++++++++++++++++++++
>   gdb-xml/sparc32-fpu.xml              | 42 ++++++++++++++++++++++++++++
>   7 files changed, 113 insertions(+), 6 deletions(-)
>   create mode 100644 gdb-xml/sparc32-cp0.xml
>   create mode 100644 gdb-xml/sparc32-cpu.xml
>   create mode 100644 gdb-xml/sparc32-fpu.xml
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


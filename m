Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B7C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFOD-0000Gc-HZ; Wed, 14 Feb 2024 08:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFOC-0000F7-2k
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:33:28 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFOA-0007be-HZ
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:33:27 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7c475a6d81bso64184239f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707917605; x=1708522405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+OSqXY2YITzUypdZsJoPPlD9DZPpKpzGakzcJ9wkpQ=;
 b=a+gmkDnePrkaO1/p0Z3Ejh46GuQ87r/S+rB7PI1E+Z0lLzA9v6m/pObZe2PesQos8F
 UCfsoOEtQ1+6wNkArQ7gsrvDNCGw79CsFl0TdCUfJVaynufTmG4IWSALvUQb3r9hz38l
 8cHKtgRGaioXXd8YDnjQGCdLbfkLvctgTLcXOx5ZYcgtaRaQfPD5iW/7RikwDRH01nJq
 Ez/QIaEIGApFD+USXiMssat2b4M98BkbOsxXFkGZvH+sOiiGcpW20cP14F/U9OYcyqus
 h4PMcWRzl5qd6BU7nxyIHFo/Yh2QGKPSOpGJS3kZTWz4LZt8my3pe1V/9gTegHD6XeWs
 MpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707917605; x=1708522405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+OSqXY2YITzUypdZsJoPPlD9DZPpKpzGakzcJ9wkpQ=;
 b=P+bGVQ2ljQdLunj99eN8Fq5HAnSQg829q6HffO8NAX6dEJYqQ9vamyWks7IeIXc+08
 +xSffGePEzHgucjfsHQ1f4KfeYfhvMQzc9yKJ+ys5syUBr+B1TUvNtWjrG5jWOrcKPvD
 9b3SOqMZK8D2K7rCoVScHwykuaekoZJJTTZvPDa7VAK173Ul9MiU9OQYGzRb1Kd0CLsv
 JeTdtmczw1vOR39ZBi4ZkNj5BKtwzzU4wplWttp/mOKeb0AIf/Kvtl3iV7xvPbs4C+Y0
 ZgENiQYxyWepakeMhz4yJ0sz9MNXAIsoOzxtgy6+ONaxyRYIy+g1xqDvb+oRsRO7rbM5
 ZIuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc0pe8sJskgM4FFONV1xs0evDosUFKECHUUhLRZj2+SmKPYqV8swwF2NU9OAy7N7rbZ2TyCD2/2F52VZc2E6lld45M5Q0=
X-Gm-Message-State: AOJu0YzufutSs3rNO6A8hT5jpziv+I6cQjMyBQ39+fkwRrzXmspywka7
 cTRMjAsVZRYZRbHX/ztBz3ZSpR5Xz0qWVgXh9KuWH/56KN4t2fLxkwwpNEf7Qjg=
X-Google-Smtp-Source: AGHT+IG/tDnRnHGAm+fRyynGjoSh0XEkpI9zpQEG/UNoHQjIX+CeXJAh3045ztM4w03bbiPoumphDA==
X-Received: by 2002:a05:6e02:612:b0:363:d88e:e111 with SMTP id
 t18-20020a056e02061200b00363d88ee111mr2604819ils.30.1707917605250; 
 Wed, 14 Feb 2024 05:33:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXZs1qkxeasK+Qu+6sBuHjVwGIz/nrclupdq97rVdMXfYgVvZ6eTEH/PgpZ4opLMAZQT88uMoXidDF0fSf/6Ld5JJsV/QgqGpI5hJcGTz1uqzv1C0IAL4XHVqLpkrv83+46m017gHc031Kc/WjwyL5Icy9/TsdkOYuq4sJpoR+6LmFjdJaZ3HnZD4kTu9Wk6aP+OXPU8w0sAg7bhENZCUSFl/EzpBWXqRVufIKOoTR0KPxpitRc7wfOAI6piqf1CmBv+y+N4J2TVRTrkc/qUTdGBfNtz6QRs0xEQyMFwGfOF/P+j8IkUgAkIKRUsACBiIXBMBY=
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a637d12000000b005dc36761ad1sm4222285pgc.33.2024.02.14.05.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 05:33:24 -0800 (PST)
Message-ID: <86cd1a8a-8ff0-467d-9991-079d6ab9688a@ventanamicro.com>
Date: Wed, 14 Feb 2024 10:33:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/riscv: Add Ztso extension to hwprobe
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
 <20240207122256.902627-3-christoph.muellner@vrull.eu>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240207122256.902627-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-io1-xd2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/7/24 09:22, Christoph Müllner wrote:
> This patch exposes Ztso via hwprobe in QEMU's user space emulator.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   linux-user/syscall.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3ba20f99ad..24fa11d946 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8826,6 +8826,7 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>   #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
>   #define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
>   #define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
> +#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
>   #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
>   #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
>   
> @@ -8940,6 +8941,8 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
>                        RISCV_HWPROBE_EXT_ZVFHMIN : 0;
>               value |= cfg->ext_zfa ?
>                        RISCV_HWPROBE_EXT_ZFA : 0;
> +            value |= cfg->ext_ztso ?
> +                     RISCV_HWPROBE_EXT_ZTSO : 0;
>               value |= cfg->ext_zacas ?
>                        RISCV_HWPROBE_EXT_ZACAS : 0;
>               value |= cfg->ext_zicond ?


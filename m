Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B9EC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiKw-0001AY-GO; Thu, 27 Jun 2024 02:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiKt-0000rW-FL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:10:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiKq-00043t-Hx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:10:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so60899455e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719468617; x=1720073417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcOz/jskmB5idT/Yqkwvwg8m4yrHkNZ5eQt7EIzDXIw=;
 b=h0QX/QtQJdUf8JgDDsSQ+Z+vjiv3T4AJH7/sRPd/xJekYf8OdKJtz3y9wabJFEuZ/T
 jtrAzqWCX244jCnkEqPKb3L3OwcKe6RDN4CWdQ75+9WlgftyoZMZcB9lzIHhyLrN8f59
 zGvgfX1JZPRJxWvyQDcGuNoaHfmjAD8gsC7JaBsH8EAkhUSyPn+YhawlXXjfdH5uFpzs
 PJM4suLTr3eOdp6GZccyY5UnSUxUo4sNZKmXEMG5tW1qbBsz2WdAe0fHBCHkw2nYZGUy
 SSCUXrVEnGO/e8UVumr9Id37+ggDA+WMS3U9YAbVpLrqIYBipeB7wuvgOjokDioZCx+D
 4EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468617; x=1720073417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcOz/jskmB5idT/Yqkwvwg8m4yrHkNZ5eQt7EIzDXIw=;
 b=LkEht7YumvnsaiWoky4kBth2DENTm9d74+UrfKWGiVq/fy4dZNtfwmayDCC9DSz1B2
 vm2hTOLCp9pehtvhlt7Ml3eoShBFJuZ3ngYnHPrORpMyLUv26EYbOBE1KNiusJb2+xtk
 ubJ9JVo1RyxKUfiGEpYhQfWZ71wrSA564AmKw0I0mhGVk1sIxGLO+0N+l9ZZ1ilbjQOd
 7/71yFkPlrtK4KaeH+18EryFF5S6cc//01vZTtt852I1SHsV/ivtl12jXh14ikZ4RmWR
 r3GUp4LqNpoMkKm21/nrnP/hqdw47nEwtKE0iSqw4QRG1eEc/WWNS+G8u6lD+FWPJqDx
 j0gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUogo2oYUyiKZ+ocIj4pHztN0zFDjIYXxUkVF/cVo0+7IZY9r7YLn+tbLkAEXFLmJwx+HwZ5WibuW93qeS49S3EX1ylMV8=
X-Gm-Message-State: AOJu0YzpGVRFAJzIXx5ltP7Nnuzg20cnrmY8Mh6XLcUbRbtU4JYf3Dja
 yc4JndI9cmA4SkGJISsFKKuzadMePgGSqzfDo6lFng8ySwlPSvHgcRWobknvDZw=
X-Google-Smtp-Source: AGHT+IET6RljYami7NK/ucEBwOh5zbfhhGBAr2LX7Z2tstY2NLCoArWp1DppEvtE9h8YHMhKJgLEvw==
X-Received: by 2002:a05:6000:174e:b0:367:40b9:e9e6 with SMTP id
 ffacd0b85a97d-36740b9eademr576297f8f.21.1719468617646; 
 Wed, 26 Jun 2024 23:10:17 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743585276sm774647f8f.62.2024.06.26.23.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:10:17 -0700 (PDT)
Message-ID: <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
Date: Thu, 27 Jun 2024 08:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-8-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627041349.356704-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 27/6/24 06:13, Gustavo Romero wrote:
> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
> are not confined to use only in gdbstub.c.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   gdbstub/internals.h        | 2 --
>   include/exec/gdbstub.h     | 5 +++++
>   include/gdbstub/commands.h | 6 ++++++
>   3 files changed, 11 insertions(+), 2 deletions(-)


> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 1bd2c4ec2a..77e5ec9a5b 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>   /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>   extern const GDBFeature gdb_static_features[];
>   
> +/**
> + * Return the first attached CPU
> + */
> +CPUState *gdb_first_attached_cpu(void);

Alex, it seems dubious to expose the API like that.

IMHO GdbCmdHandler should take a GDBRegisterState argument,
then this would become:

   CPUState *gdb_first_attached_cpu(GDBRegisterState *s);

Regards,

Phil.


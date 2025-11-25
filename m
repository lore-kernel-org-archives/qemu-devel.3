Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F790D0EE24
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzr9-0003Vs-Vf; Tue, 25 Nov 2025 15:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vNzqW-0003BO-Se
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:41:12 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vNzqT-0001ji-L9
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:41:07 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-37b8aa5adf9so46140941fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764103262; x=1764708062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hhg2CcbYsOQKALEuKn0ZsVzNyiMZf5R15g2UhIv4xZc=;
 b=F2/1XnfjI0joc50DetLmzkM0H7Btd9QTU7XLf9m8EWwjPp9YqP2z9+22rUtthWIVqc
 oVso97R4+qj/0bMle/GzD8kg8mt6Mrpof1YaVI4LeCQ/q6dCHFU4kKmBVUJ35WkRpOxD
 3vFKkkXp/oD10of6TsWy21asFm3VGOfHA/MDLQCCoHK88riufuO704nqbpHU5GvLApfI
 Ou+Y/tHEG63LaK2Uq1J+UgI0nF6MOgNRaTRoA7pN7yJTq66ltoGN/DFrIQcPegUbQd8C
 mqI06C8+rE1RZz1J7vMux37HnkcG+O/ux3VAP85/ys+SwwLpzSdtTO0stp77rRshSc9j
 /nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103262; x=1764708062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hhg2CcbYsOQKALEuKn0ZsVzNyiMZf5R15g2UhIv4xZc=;
 b=eFhytXkBHg3fgTA1n8KTisVlDL7yxhgbkgwPgJ9Ae2KMFqilYCrF6snBhX9e0JNroO
 arHKdzLk2EuM7fuO2sKlbwZJgojVE/leCr/gqs08Tg25xdx/+gae80HyCcSdrfIjxhuL
 L06Se49/8DOYhEPkI+4VHCXFYkEXHp4I76J2V4t30sxW0mDbVhoPcRkzKqbQGArN0Pvc
 mOU4PELN4JkQcb+X6+tDMHCWAEaWY0HcWh//D2knAcjk/VInFce+TlQoUfro34qjuXPD
 GK2BGZ0W/NqO2K9qilWXEFUw2HIseyVU6vF9agkeTP+DS7Z/pxD0oGkjl1akimXd+c5V
 BtGg==
X-Gm-Message-State: AOJu0YySbwAJ3gSmn8R2bhobe+xhpSiApcSwFQ6GI9fznXHc11qXcdHr
 P/O0rbS/PFLn1/hlpSnArf6AzUNdExxZZHQVlf0+fpirt0OUAXlkFN+c
X-Gm-Gg: ASbGnctt0zwC2fnnKpGgXr99xnQtirCOwuxp+pZ9rOovZm8p1L/PUdzBHn0xPJW8HfR
 l5qondyjnPNhvrvdkt4Enc8twD19fh25xT7HC1sLvuivsp3pAFy6clfg/Tere0pQcjRszYc2nPJ
 bhg9TGPYFYzTB4FxUxkpxiC1I6HKbR7cZu0snQ1vb5MyPfkMdsKtoVHji/PNJe/He50ngc/xC6i
 Mq8o1HQ1+mcZtONlNn7NLkEiIaddH4dnYsmkgvkHbZKGflFeJGZWie8Les3/3qvJSg90jfUUoiG
 xOXSgaHentDwBHlAMGqxKaJfkev5Z2LPs4q/mw+Li2XIYBMhdyzym4w1jQZTAJX3xc1tgSyZAL+
 EitekwGoqXsaz9NwnOJpOIyv4nO4+hqVEXgElNU+QS4DOOrBl4sJ8aIMqpaaWgRVT9hyyCdxcDx
 nu33wz2wWXPM54lUVW2c3Fsw==
X-Google-Smtp-Source: AGHT+IE3HlphSTiOUz90TcXZD+ocnuI+S0CKjhoYo5t6+mc+EEbyd/Vv4t8AZmg+lDZ2aRscniZgeA==
X-Received: by 2002:a05:6512:2316:b0:595:9d6b:1192 with SMTP id
 2adb3069b0e04-596b50599cfmr1671244e87.3.1764103262102; 
 Tue, 25 Nov 2025 12:41:02 -0800 (PST)
Received: from [192.168.88.252] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969db83484sm5311554e87.27.2025.11.25.12.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 12:41:01 -0800 (PST)
Message-ID: <88fca96d-c083-4fea-a5dd-619d3e053812@gmail.com>
Date: Wed, 26 Nov 2025 01:40:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
 <c9461c73-fbda-4963-b96c-3fd4b2d6ce41@gmail.com>
 <20251125195819.5bf1e051@bahia> <13893778.uLZWGnKmhe@weasel>
Content-Language: en-US
From: Andrey Erokhin <language.lawyer@gmail.com>
In-Reply-To: <13893778.uLZWGnKmhe@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=language.lawyer@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 26/11/2025 00:31, Christian Schoenebeck wrote:
> On Tuesday, 25 November 2025 19:58:19 CET Greg Kurz wrote:
>> On Tue, 25 Nov 2025 19:21:00 +0500
>>
>> Andrey Erokhin <language.lawyer@gmail.com> wrote:
>>>>> +    native_symlink:;
>>>>
>>>> Still has the terminating but unneeded semicolon
>>>
>>> I think I've addressed this in the v1 thread, with links to the C11 draft
>>> grammar. Can repeat in plain English: a label shall be followed by a
>>> statement. (No, declaration is not a statement)
>> My bad, I didn't see your answer.
>>
>> It is funny that I had to pass -pedantic to gcc to get a complaint (in plain
>> English as well) if I drop the semicolon :
>>
>> warning: a label can only be part of a statement and a declaration is not a
>> statement [-Wpedantic]
>>
>> Cheers,
> 
> Yes, I noticed that as well. GCC compiles fine without the semicolon, clang 
> OTOH errors:
> 
> ../hw/9pfs/9p-local.c:481:9: error: expected expression
>         char *dirpath = g_path_get_dirname(fs_path->data);
>         ^

I use clangd language server, so I don't even need to compile, I see the error immediately in the editor ;)

> Anyway, Andrey is right of course. The C standard defines a "labeled-
> statement" as
> 
>   identifier : statement
>   ...
> 
> and the subsequent line in the patch is a declaration, not a statement.
> 
> But I also understand if GCC developers relaxed this rule. Because it "feels" 
> like both, a declaration and a statement. Interesting, because usually it's 
> clang to be more relaxed than GCC.

Probably GCC allowed mixing declarations and statements in a block way before C99, in C++-like way, which has statement → declaration-statement → block-declaration production
(C99+ uses block-item → declaration|statement)


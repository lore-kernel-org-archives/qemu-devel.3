Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC06C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 00:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujSDj-0007bN-DD; Tue, 05 Aug 2025 20:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujSDh-0007a9-Fu
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:41:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujSDf-0000rA-Iv
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 20:41:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so5205779b3a.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 17:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754440884; x=1755045684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbDnrL2j/rr3eGxe/QXv6bksL6YcdiGSzx7/jG0wmZU=;
 b=ASgqfP13ZS4L9BdIi/bR1Y3ydf/5xTJnBDVz6/INs8/mL5zoQqekqxDd2PA72+0ac7
 WQ4UsguQqY7Sk4OQDCJwFH43qaEJQS+LN63wJbcHZYkzeG49rGTH5hNO/a0Cyuj2AL+4
 GE6Xz9/F2ijvsi2lP54uuQ+QJORm55au4zLRRxvMvbHzNpJRcDpP08iGqWvD7ez9Ao+p
 OCYXkYty5mxw82b5SfQ8LXAGb3NbJN2LYcMHSlGrIEmcJhJxcS0fOj+MhAT52Lfd1esP
 gUtabMTm+Nf7YAJMmbw00/kN7MKPnYQv84YNsnBVfypYi/AvehMR3XAAQvo+gOUiWcSC
 Pq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754440884; x=1755045684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nbDnrL2j/rr3eGxe/QXv6bksL6YcdiGSzx7/jG0wmZU=;
 b=OmLky4+hHmwAk/sBMO5M4b2Jnv72fvp5/4IR0rnKpWS3k7mPFAy6qrI2zZKgd71azQ
 DBvGjI7bBU9GY+CY0zB5PjhIqKQ8ikqupC3HHbgkF8PJUoAZDSebYZuhM6CYsf+XHXOw
 ngVCSs9L3gzgEoDvCk4btItuyjNeeh96Bln2aQHcX1XNEHUkAkh9OxVU2bMqpNuhtg83
 mfV5n8PdJjFqlO3Ao8cm7gtisV07wOyvObJPUDhEHNKN99MIZrMKUbjEa8wRyAGjYe2+
 djAUb2b6Bp+LYjmn8mqptS9VBzFydNs6ABOzRkQO5B/A6wUQBYNK4Ap0egNtL0m27Nui
 hpag==
X-Gm-Message-State: AOJu0YzeUJu1o9pmBXV4Qgm2ufBAtyksfcghadDYHP4bNYuVlTp+sJbM
 yStsZTPoiCJttm710Tz4z9xxUTLmG0mqHHnXh0Rh0v2kpoisID9EVuk+2JdO3zEgIsk=
X-Gm-Gg: ASbGncvJwDn1eQ8UQcw8RuFfxizvqaWJXB+lD9ITop18FBHXlOgmIElaF28pmZYFUe7
 /oOUbWmPK7FSZUcDwP+CJVSQRYm3CvPg2BjZ31AFfnXSmE091oQxraKJgYHhmiuzclY3MyaTYNn
 H4pyShSSaFM4uJ6uZskbQYQkur0O8DmuiQf96iJkTEmZMkthxBZqq5GUnFz79q8xz2eSjvn0oZA
 bQPYeUw051h+zFH5Wkc0+e+YKYNLiSzzinhaYXPuTwnUiacN0eIerX937EnCJdAu3LoZQ9zAokh
 gu5IsxhIT0xL5ply1nrsNnSZ4aaY7JOUxs6IIrCY1uArXZqKkzwIxrjSTXCEqoJdCvu1gdxN7K+
 J5xlBGCMp9yEFGA7zukMUT0iOTsfnXpNSh0c=
X-Google-Smtp-Source: AGHT+IG8zLjBOCaGzlvFeeLOA/EtPizlfIxIcQ0bQu7Sii70DRTn5eogeqFoSpWX1cN3fqA3S2R11g==
X-Received: by 2002:a05:6a00:124e:b0:76b:ffd1:7722 with SMTP id
 d2e1a72fcca58-76c2a93df78mr947310b3a.24.1754440884217; 
 Tue, 05 Aug 2025 17:41:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd73a2sm13935404b3a.108.2025.08.05.17.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 17:41:23 -0700 (PDT)
Message-ID: <3dcc35e8-f49c-4dc4-a613-b57d57546b0d@linaro.org>
Date: Tue, 5 Aug 2025 17:41:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] contrib/plugins/uftrace: new uftrace plugin
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
 <20250724204527.3175839-2-pierrick.bouvier@linaro.org>
 <871ppq5bl8.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <871ppq5bl8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/5/25 3:04 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> This plugin generates a binary trace compatible with:
>> https://github.com/namhyung/uftrace
>>
>> It tracks frame pointer during execution, detecting function
>> calls/returns and works in system and user mode.
>>
>> It's implemented for aarch64 only (adding other architecture should
>> be trivial, especially x86_64 that share the same stack layout).
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   contrib/plugins/uftrace.c   | 630
>> ++++++++++++++++++++++++++++++++++++
> 
> Is it possible to break this down into smaller commits to ease review? I
> appreciate it takes a bit until you have something working but this is a
> relatively big plugin.
> 

I'll post another version breaking down the first version, so it's 
easier to review all the different structures used and methods applying 
to them.

Regards,
Pierrick



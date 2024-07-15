Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E47C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 07:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFzT-0001cY-0z; Mon, 15 Jul 2024 03:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTFzP-0001by-TP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:19:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTFzN-0001u6-R4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 03:19:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fb1c69e936so20093015ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721027952; x=1721632752;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sPaY7wkupCQEckTmNbe4Y6uhk6t3JOj3nverGf+ee2s=;
 b=LhxYt+eTTw6s48mS1FJOxtFF1VHM/Zz+2JA89aKFl7snMFEZ7b2OEDIghG2VGDXclh
 P3Nww8YclTwFOoy0WVNtKqzLIWAMeEkm2yjOjXuehJGix5KVBmt+hD/5DKxHgnHGi9Z7
 qiVndCDWJagAa3DxJ0n7Z7VfnQktDIjxMVVvV3NFwutAaoohw/L9C8rCrFLpM/A6aZ+N
 2IxM+okWslk/MLBTGfVzTtSA3dtSjlSaoCj68wuKPMQObiHwDdqrLDXXLbZoQ95iy/Kg
 vJiXaQ4WpeN/V8OIFiiF1R81AQ5zSZVafGqiZudFOUt0+CtWfJ7+D/jqUe3ZJEjdBZj6
 WjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721027952; x=1721632752;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPaY7wkupCQEckTmNbe4Y6uhk6t3JOj3nverGf+ee2s=;
 b=BZ/J16QAkYcBOnjgDV0JrxJ1NDA5cJ6RPmHYgGp2dC4qsJ/+aGZoiz2Xoqcbagd3v3
 nFugxAXEC+n9huhmP0jhQEQMOZodK1gBUXOb/W1q7nqI/HA84WziVV3EQ3yU9WSz5e06
 SysXaqSpKCU1fxR/FIuwd2RILLT1dUZ4MldNZRZI6KJHtuwZrfOtNPCmrXt+RmmI10R/
 8fXlvjvNYWR8UBxfakgfKCUDtarf7ptbfYGq20SCt1dLJNzZPxyDH6eme8vCj7kBShE/
 jeVrSvTwdGtUUc9fFyzNI6trZjJ+3ChAMhqReS+n/9xvAOIbCjnJwKzn+KOMfUiLN2Mi
 2tmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJLXjjBpN2taJRaiHH4BAbQXaF7OmI/OtCwoUk6ijYzFqqve2QIoroc1HOJkBiLt4RhEb1rWKNAeupnaoTyPIdh1j4T6U=
X-Gm-Message-State: AOJu0YyHsSU4iy48Lk5CnG94e92y+54cLFS6Vn9mf0dTo/doWJkjLsfn
 xXPTb5rGgA4yVFc71yPna1RHc+yCp2YOvN9+DIX37wlD8kAEPatvt4lTbUH6nLE=
X-Google-Smtp-Source: AGHT+IEEKDgsKZnWkEuGhWqTqbXqriincyZ3Woouob0iYVlS+VgpG15EcqoseHz3wdq+t2EIl9aa8g==
X-Received: by 2002:a17:902:c1c9:b0:1fb:72b4:8766 with SMTP id
 d9443c01a7336-1fbb6ec3dfdmr109872475ad.49.1721027952298; 
 Mon, 15 Jul 2024 00:19:12 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc59ea6sm33671045ad.297.2024.07.15.00.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 00:19:12 -0700 (PDT)
Message-ID: <79e47721-d642-4ffc-88b9-283bf78a00e4@daynix.com>
Date: Mon, 15 Jul 2024 16:19:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Use -fno-sanitize=function when available
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240714-function-v1-1-cc2acb4171ba@daynix.com>
 <878qy3166i.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <878qy3166i.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/15 16:10, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>> -fno-sanitize=function in the clang-system job") adds
>> -fno-sanitize=function for the CI but doesn't add the flag in the
>> other context. Move it to meson.build.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   meson.build                | 1 +
>>   .gitlab-ci.d/buildtest.yml | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 6a93da48e1b5..80447833f07a 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>   endif
>>   
>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>> +qemu_common_flags +=
>>   cc.get_supported_arguments('-fno-sanitize=function')
> 
> What about checking the other hardening flags?

-fsanitize=function is the only hardening flag that we decided to 
disable for now. Context:
https://lore.kernel.org/qemu-devel/618857e6-dd88-4834-af1b-561228fd7dc1@redhat.com/


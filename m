Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0B4C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvPX-0002Kv-CH; Wed, 03 Jul 2024 04:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvPW-0002KS-4k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:32:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvPU-0002rY-I3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:32:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so36376585e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995535; x=1720600335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJiaifbYCOj/DzTdzRuPhFPYVdt7SwziTFO8nBrN+94=;
 b=RKcGGn2ROdSHmYluIOu98CEB3NBQSRT0h5sP2fu6cSDV0/pun7qg2OlIHORwVYxoeK
 UQb1QJBBR7jsFySoDDxpZvOgukyzjG4yCnimovKh8F9Qp9UrBPJA4HU950LZ9U78OsRF
 rUm7+RAodSi7VSU7kmqbgW3nig7I0Pcy+ZPxL5j4FoNdJykMpSBQoI2lqe1mPHQ7Y2/6
 B28+7zS/3TmCyqzT4jDZL/CzCXNpcWvTsvBbp/9IBjEG55pbjHnWpAJonqEX536leGzo
 WR3gGmImTRR9mKl2tx6Vs/Fo6MeqtmPFcWQozSi6HQwQEKoQznkAUBrhrTG7O37u3Z3u
 terA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995535; x=1720600335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJiaifbYCOj/DzTdzRuPhFPYVdt7SwziTFO8nBrN+94=;
 b=gyOc1BvbcJlF1MxbRLVm8XZpu3NoLymxF7JRAY+oN5z3G65Jv3sH0gIHnvagOiPIQG
 gOYeF34xlRosllIsHcuhTeNzPNedHJ8NaK/yN76AYf9d2+c8mHT69bzGD7S03iIYzB+1
 XJKsVRIlVhKw8NKJFfGHCS7K6J9Vq8QlyREkjl/bYzi6vtgRZG5vI8e4gyJ+iq8geIQh
 u5z7dw+Jr7r+AQJhKMLktFPz3eSHZU+gXpisH29eoNy6l+JSgbDVdFPZ8c76AZZiEUPT
 SApeXhgJe2JAUHqQ4jj8/ZUXAc0EbMUKNmtzAiA+M0SVHclFEy9EsI/UJFHQbIntDLJx
 vyhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb2y998NF+63V/KKzGbthBr2ux5Tzy0+K8IpaOm2yNAlBshZY9qQx/y15jWhSjToH6XTeajLOIp7FyKeSmy3YaoRGn2Go=
X-Gm-Message-State: AOJu0YwEOueFjZy5PIy/fdb8BNPA6yYd0VmpsF1buIPvCOBHcEGfyJ/h
 IWo1/ZSrdtPwix8vRGAnWoi3mFFogPAAq/TcJ7MD/zoTIdDXAaIuqEfnZ6hv/14=
X-Google-Smtp-Source: AGHT+IGi7VmhWu6kCFVdSUgBvXodZrvWt9W8agwcEf2Nghzkmwk7/OtpRs3PgIyYsy1aJH3LQeqHeQ==
X-Received: by 2002:a05:600c:310c:b0:425:7f74:b6cd with SMTP id
 5b1f17b1804b1-4257f74b7f0mr45054505e9.40.1719995534988; 
 Wed, 03 Jul 2024 01:32:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3f14csm231420855e9.6.2024.07.03.01.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:32:14 -0700 (PDT)
Message-ID: <ff9fe894-ce4c-4f9a-bf4f-eaa292a42f0a@linaro.org>
Date: Wed, 3 Jul 2024 10:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] qga: conditionalize schema for commands
 requiring getifaddrs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> Rather than creating stubs for every comamnd that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the network interface command on
> POSIX platforms lacking getifaddrs().
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>     {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-posix.c | 13 -------------
>   qga/qapi-schema.json | 15 ++++++++++-----
>   2 files changed, 10 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



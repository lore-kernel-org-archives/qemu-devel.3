Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127ACC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX7yE-0002Kj-Em; Thu, 25 Jul 2024 19:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sX7yB-0002K6-7e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:33:59 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sX7y9-0000ed-GD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:33:59 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7093b53f315so19999a34.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721950435; x=1722555235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xtS9Gd1EgXnCAGn/W+q0Hr9fOH1TgfmmxWFIDC/32eA=;
 b=bBO3b7Cn5Q+oPxty8bVWPdaN7SAKJCDXvLPAeC28zdYTGYyH+a5WI/uHB4ouPTIvCd
 1fIFW54oKtze50QN3uXUPvVQBKkAPaFEOSyKxHyHqJ1Ud+btnBRg0NK1QkuDlUlZ2P84
 MuUh8F8pyd0EU5paAwwdrmveO/cOpl/f6BNB+ZHj+QLSRSEMTQ0Eowo9AcgPipUP04an
 FhQ1WFEEwDaeFaEoGarHvamvqdl/ZdMwjieIFtosQ4+B+tKd8olakC6XPXZ0qvXz8W3C
 eIrpqnMO230mE5H7AmcnupRTwaRxUVpXJDAIBG5IXrLCuP0MgvkdYvDKawNFSrzbO9XS
 /KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950435; x=1722555235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xtS9Gd1EgXnCAGn/W+q0Hr9fOH1TgfmmxWFIDC/32eA=;
 b=FzVbCdkR4upFtd084WzL6E5+5G5S/qkYyzSqwDD5/YVIv2ViIBgfajUbPOnvXX7ZNS
 CSZWTJSzF0twqg6P64ZMiQpPlhw95dGMglUFnZBrlCGxabxZYT3jsFiDy7hTF5nO41KS
 RUN2QARBFOSXZyDrTAvSBOAqfLjFD6AT2PJgn6hgMx6dLjVXI/mFxdkPJSIPphV4od7O
 USyeUdyRSG1loHyacW7DlZu4rZOcvzeV7UD8guIbT2FbyyXmnOiKjATi2tdyQFLWudXl
 CWgUXTlUQH2zbKVopyoTJm7OEJSWGkgt/n5kBmN0Uu/GljgiEu42s5/V+hN5Lk9Kg6Tx
 eLgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoYUKidC9+VAYLGBG0e/1qU+1YFJhOy2K+8dUzeW6eAX4mv+UV+QLlR8SAEU5M1zQcKx1B6U8Po7U9QBzH1W7A5tCETQQ=
X-Gm-Message-State: AOJu0YwxrhVHUNx9iqa57Jv4Y8VtDq6p8qYA4P82SMmdyu+b99umCKXL
 fKuWUMtxOF0jfcG7RF7ddYEQN6M0okjQXSdC+/3iYigK6b5T1+AgwY9jC5iEk/w=
X-Google-Smtp-Source: AGHT+IF8qinMQAiDvEr2aKQbQPBJwL3oaYwETuqx60pZpFDCmNnwxijnw768ymgGisxWLglzsDUUoQ==
X-Received: by 2002:a05:6870:1647:b0:261:1a17:c813 with SMTP id
 586e51a60fabf-264a10992e5mr5222255fac.42.1721950435543; 
 Thu, 25 Jul 2024 16:33:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8122ddsm1636975b3a.133.2024.07.25.16.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 16:33:55 -0700 (PDT)
Message-ID: <bd367b1e-1858-4344-97d9-d0ed0d1890f6@linaro.org>
Date: Fri, 26 Jul 2024 09:33:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Use -fno-sanitize=function in the clang-user
 job
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, alex.bennee@linaro.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240723232543.18093-1-richard.henderson@linaro.org>
 <76357626-9714-49f7-9ca5-d2a42cd56ab6@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <76357626-9714-49f7-9ca5-d2a42cd56ab6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 7/24/24 16:08, Thomas Huth wrote:
> On 24/07/2024 01.25, Richard Henderson wrote:
>> With -fsanitize=undefined, which implies -fsanitize=function,
>> clang will add a "type signature" before functions.
>> It accesses funcptr-8 and funcptr-4 to do so.
>>
>> The generated TCG prologue is directly on a page boundary,
>> so these accesses segfault.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> What happend to Akihiko Odaki's more generic patch:
> 
> 
> https://lore.kernel.org/qemu-devel/20240714-function-v1-1-cc2acb4171ba@daynix.com/
> 
> ?

This patch does not work:

https://gitlab.com/qemu-project/qemu/-/jobs/7432239478/viewer#L4956

I presume this is an argument ordering issue vs --extra-cflags.


r~


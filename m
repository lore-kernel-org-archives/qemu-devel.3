Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D2FE7719C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW109-0005vK-A6; Thu, 09 Jan 2025 17:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW107-0005v0-I4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:27:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW106-0003sm-0k
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:27:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso9478595e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736461656; x=1737066456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2A3/hRtCtyWIqGeK5SwuKAvx7AqF6RwYbdQxqZ3bIHw=;
 b=AiA3c7xEXLWslOeLzyf3xx0/Kww0Zr3y4Pv0igmm4ckwmgfcdAJjrmUa1pM/qHS5h3
 VImYbOeSIOiswviDzA0bHHEYXSjqn/wCTWXJMHaeajn6dYSFF4GO0ZBYV0LQDAEpVJ9q
 ei6yHW+ChGKqb8LdfMQMAfwm0XG1P0HJXVoxqBQM2Rw51XPsFyX+nmp7Vo8yWjOmi+JI
 Kw1c+t2fWZoJctEq42u6pzTN5+m20n1VrbIvfgePngIBxZfCSOQ9f5pI/tp7ywcqf5HZ
 1yA9oCMwcO61m0dM6uLy6ladUVsJVbgAOBqi1njWfz9ghUPpbAcOcGG4dVmwBk2Uvn1y
 2N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736461656; x=1737066456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2A3/hRtCtyWIqGeK5SwuKAvx7AqF6RwYbdQxqZ3bIHw=;
 b=HfRngjlpC2OE0po3Sjpl0aadXqixCxyI0JXoFhVoBlpFbBg5zutE0cmMlKmz/ajW4W
 N+BOQYJQ392dFCoNXokwt9LGwTpf0APEOM0jtW1QdEb8ug1Z1iuJfvhBiYTbp4A1Lp32
 VsBCzY3DpQSmDAicocoZVWWwwDlIywWQBU7y8K/6TTWTRip+s33bICthhM9LwCFnPBjU
 wshmv8e/gN9Y7OnNgzEp9gOkcS3L7tC0FmnSj7N/zPQqCEwwkf+v9HkhiJ4xJCF+Soyo
 8DCJ+NcnjFBQZMjxPKN6xeDJEIXV30rxfTW7Q64Ar/hoLc3QBTOrT7Mt4MqFR8imleTl
 1W1w==
X-Gm-Message-State: AOJu0YwC3gdO26zC5QU+BRLo1V64pL2FVe+GQmahvbMV5PvBXZ73dWVJ
 PV7vcNFxCGWvb37tS7LpmfxHSf63ZUiwm/xTrUwOfcVSGZ+wUhJnk9u4BF+hq+E=
X-Gm-Gg: ASbGncspRstnIJUaYqk4owBJYXKnplQHss/844EO4bF33TWXfBMtdc3PoPdw/PynI07
 9CTDBP71APQxQf9XIaiZ10T7+bXXNN8YqEwmf/IqVxzQ/d3Rialw7VfPTD5xHNrLBS1Os3aOAFA
 CxPbNfS7cBJHK63IPegPhc4khaRJiN82afZq7rmmSmOJzicDQQX0kbPh/4r/8qSRFbogpzxY/7l
 kn4DGah4UKULXgt/3+R3SRt77B6sW2+eXiFzJ6PLm5N210YWJd0Ygd2WIBtq73LTC55kC8V/0Qj
 m4LZCaPeYGx0clVnRga6gjVftnE=
X-Google-Smtp-Source: AGHT+IE2Xvf5guDu4uooh4NL9rVcfGNXM5AahnQ8lW9T92bQP5kgJloSSZXgUf6sxhF0V8RpWiy4LQ==
X-Received: by 2002:a05:600c:1c9b:b0:434:ffb2:f9cf with SMTP id
 5b1f17b1804b1-436e9d80fc4mr35942935e9.14.1736461656348; 
 Thu, 09 Jan 2025 14:27:36 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d69sm32955605e9.30.2025.01.09.14.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:27:34 -0800 (PST)
Message-ID: <b46d7d01-ae4d-4c47-a3df-93ad46ff6a1d@linaro.org>
Date: Thu, 9 Jan 2025 23:27:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] system: propagate Error to gdbserver_start (and
 other device setups)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-11-alex.bennee@linaro.org>
 <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org>
 <87bjwf6abf.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87bjwf6abf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/1/25 20:45, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 1/9/25 09:06, Alex Bennée wrote:
>>> This started as a clean-up to properly pass a Error handler to the
>>> gdbserver_start so we could do the right thing for command line and
>>> HMP invocations.
>>> Now that we have cleaned up foreach_device_config_or_exit() in
>>> earlier
>>> patches we can further simplify by it by passing &error_fatal instead
>>> of checking the return value. Having a return value is still useful
>>> for HMP though so tweak the return to use a simple bool instead.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>
>>
>> <snip>
>>
>>> -static int gdbserver_open_port(int port)
>>> +static int gdbserver_open_port(int port, Error **errp)
>>
>> Did you mean:
>> static bool gdbserver_open_port...?
> 
> yes, yes I did. Will fix.

This is returning a socket file descriptor, why bool?

> 
>>
>> With that,
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 



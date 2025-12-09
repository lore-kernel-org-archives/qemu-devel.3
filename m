Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C1AD3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3zT-0003bU-Qw; Tue, 09 Dec 2025 15:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3zR-0003VJ-Rd
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:07:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3zP-0001PQ-MP
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:07:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso50571475e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310834; x=1765915634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VLbY6+YjBVJO4YeroQUa9sCygXP6wh/abFzZZm99xIc=;
 b=ygvpb7H7GocIkPD+BerttXdzOXdmmXhcB15UtxaDvXK5F0GXMGWIxk9KYNOuA7KSwe
 +exLc9lQ/CBMofECB+vqmsn9vLziKs4G9MDUXMRny7HlvxNtvK3lEHHn1PfDht1S8KuK
 N7EBE97pkEqrWW1kFv6y8Q+NYupwIw6lbwgyLabASQ1fqjtEH4SupoW9w5CXMH8p/kUa
 8Lj96hrByZF47W3eZeLgDtiFiJSxBnPOdOQRs40DJbQH5JHbvHhTq3waZeF8bb0iiuBj
 4jwlNGa1K5H1FNXSfCQ4DK+MJS7zFmZvROmHqpLApkNhYXoggSrFRydYj6aKj3Z/BBRN
 BxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310834; x=1765915634;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VLbY6+YjBVJO4YeroQUa9sCygXP6wh/abFzZZm99xIc=;
 b=mO0nEfH+hcXfNQ+3brG5zOgopq0eEbAg/z2f/SBUFjC4bE8Eh215YMyiEVYAImbNtL
 FYYxcD40UyLAZZLf6MoEoJCSC+2KFf0GMD1nnT+cD5/XTE2NwjkHbiJU1E+/sAcob7yS
 EfkL1MMSYd2ArY5Xf3Vjc5V8J1oThy3FOuouWlqCRqcikphZOF2SDmhWTYxAVUNcNLe1
 hjo4hvQR2NsPL9+hk8YlZfiQLRioqXgAp+Ba4CYdsxdWJMPD62HFNdUEdYsOwNjiL0Lf
 rwDON/ko6n26Eov2bBdel26SHnhHzcPgSwgt2fieGOxXlFXADk9W1yXYIU0GxjcL0SVY
 im+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDiz9NDTQ4sFbTrxfQtTO6ihicGJY9i0VRWGxPXG0P8zQBYVCdYWM6lH2bzTt+KBmD/Su0TGpdS+Hk@nongnu.org
X-Gm-Message-State: AOJu0Yzd+iSP8doo5aOvq2CRTgRzYEt3qbbaHzCYupg++ZzaGajv6zvN
 1Uqb5ZxgFlpTsc6jd3FfOaAYl8PgSsByesFYDyA+0prgtpbk7vjLvf9aR6orKo+R6NEvmFzCifh
 3Nt9iChw=
X-Gm-Gg: ASbGncuIofqNa9gUNJv3w1NLDCvcbzgkf2gVQVV/Ru1n/zZD2HrPjP0FHWyY+CyWnJX
 Dx/GyQo5xLJXJLx75xCE0IFPBjFjTGOcmjGZ1bZ4UiX7JkRKXjdepzaMkY2/Pfh5r72WC9Q/PnR
 A/ZgmoQbuNJ7KY+6VbTVV8xfBaw87NJPYfsf8+XwFEdBRqsV0y7XJjt/FWdwBwYXnh6qMUU+x7I
 hPu+mSLQ1rVOXVm3JiGn5T/0F6RqJnFYytE6sIfn5FqMqQlO8xm10A4+7+ZbIEwepv+yfkoGAUr
 7b3lnMWwgb8tf0wQyHieW+yuBPE/AoV79tpHY8X8Gq9IIamTtkgq5f3FbVGDr7wOjjSw6eLuPeE
 msYTz3qT6E8vtX8P3lsEFt3PElm7EovVHgS96epjJGKo+I2NAj0CLGRXwIEEIxLejugOdogD+xe
 0LrWrRi9A+KC8q89yrQ8cn+bj7AJVpcYNoNtgRDVJN5/zfQyiG3LCc5Q==
X-Google-Smtp-Source: AGHT+IFuTa+2odf823au2Lar6gV0qyDcH4Tvtc9yYlGiMSVQswLYs3Xs03OypzExAv8piNhT/FskPw==
X-Received: by 2002:a05:600c:a68a:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47a8379de88mr647965e9.15.1765310834170; 
 Tue, 09 Dec 2025 12:07:14 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a838126f5sm917215e9.14.2025.12.09.12.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 12:07:13 -0800 (PST)
Message-ID: <d0f06e40-27e1-43a6-9fed-3c1d0eaa16ad@linaro.org>
Date: Tue, 9 Dec 2025 21:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix const qualifier build errors with recent glibc
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251209174328.698774-1-clg@redhat.com>
 <788f9e4d-86c1-4830-8eda-dd70d8fec7c4@linaro.org>
In-Reply-To: <788f9e4d-86c1-4830-8eda-dd70d8fec7c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/12/25 20:17, Philippe Mathieu-Daudé wrote:
> On 9/12/25 18:43, Cédric Le Goater wrote:
>> A recent change in glibc 2.42.9000 [1] changes the return type of
>> strstr() and other string functions to be 'const char *' when the
>> input is a 'const char *'.
>>
>> This breaks the build in various files with errors such as :
>>
>>    error: initialization discards 'const' qualifier from pointer 
>> target type [-Werror=discarded-qualifiers]
>>      208 |         char *pidstr = strstr(filename, "%");
>>          |                        ^~~~~~
>>
>> Fix this by changing the type of the variables that store the result
>> of these functions to 'const char *'.
>>
>> [1] https://sourceware.org/git/? 
>> p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Most changes are straight forward apart from vubr_parse_host_port.
> 
> Better keep the vubr_parse_host_port() change in a distinct patch (the
> change isn't really what this commit describes).
> 
> For the others:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Queued without the vubr_parse_host_port() change, thanks.


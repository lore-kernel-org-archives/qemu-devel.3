Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEB2C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0R6n-0001m8-Lk; Thu, 03 Apr 2025 16:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0R6l-0001lr-SJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:24:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0R6k-0002xK-72
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:24:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so1107728f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743711851; x=1744316651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xni7N/yLix8QDGRYeZeYSl/Y46YkM3M4BhZnSJDZ7CQ=;
 b=i89XR4urcK1OaM5LwkOOIruzThsJB+yzoV+kvZuIpkp5bjDXQ3q5gQVJ5X2apJdlON
 HsvRVJZ/mjL2J0D/7hqxVmI/yBma9LdRsxSN9wFut3W5uO58xsJBVvOlfUxKybOMP8tE
 Et0WlA/BUf3UKul0Ms/tCXM2lZFihrtY8wYwEoMum0XqAI+sJDcVTC8RFgOYMQkO0G6L
 1hu6TWLFdgBb+CVQqG+fzLPmMA5wE/2b9vr6nLYxWHZ2h99/NeRTzwFAvFRfzivcgiUO
 mrc6WYjWQtvFxqHiqMW5R6huVRpx8lftLeNmivCpvy2iEosvFcr6hOD98/9dq28qFfrw
 KULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743711851; x=1744316651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xni7N/yLix8QDGRYeZeYSl/Y46YkM3M4BhZnSJDZ7CQ=;
 b=tBQ6zAv1FksDW4gvVG1N8cFh4cI3oOqNA7o382IEt/3SWcMVIWcHO1xVl1v350qoB2
 vMZn7bPS3PQBZp/XIgsyOefvui26mzgSp0HaJAoPfI9oRpiZd02T+oIIGmbwqnNbZXZY
 BD4afN3A6Ypve19HY8e9cmBWhMxWVuSqopbe+jQFxelZ1HGkyppXbUBIvwk6mUOoVVV9
 dbue6yVePQAbJfqZBQpihkI88esuhcpyvBDBZECBQjzPoptEBdJwOafVglxDtfyKwfs6
 ExgUoL2DM9MQFZdiTK1wCyskfvCucxiCXKYavKWr6yp6+RaIinRiwDS0tjY1Ip2/frE9
 M9vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVftJn7cKuJ/7qLk2gN9QOZEMb3NgmjfNcoHZ1ycTFPh+6G+yPWiauESGOGLI9OJr59mazs001OczbW@nongnu.org
X-Gm-Message-State: AOJu0YwiYP7mdPwmnlat8Bq+Su8YTGeb2/J1BNj46H0URJotcRMr2Pvy
 tGrT9eMI2tiwrgBpFgDYnHbBr6xMD0enGEef9TiVLFxZG3eOhpQnn6nxKk+uy30=
X-Gm-Gg: ASbGncvK35O/qgKsZhNOGckKte+Ak5AEgz0u3KzLJ0f2Q7vEcqJfUkneHQ5ky0GnoZZ
 SrbxEdA3MRFBVz1Ds5kXe+Bbpg15q6qohZN6RYUxW6fC+bMG1cgkJkiMi7KHqT20xdsdN/Jk9uB
 IZilRnoWzLumMk/LeL/oB6Ao38fkhWxRXNubmTtah71AiTQwybFXN6QZoXfHb7LLxz9TBVW6Ttn
 yrvOAeHyGkYudIJ/ZtuWtPdET8KMA3McGcaZJQXUbLmQ34CIqmxbQpsPNdQAaduk5PObNJ4gUky
 oW91cIvbBi8jr1my1h38T5mAalBgazUeuCMb4iehbz5FoHr03NH64OPpsrycXBndheP1ET6sJqd
 6iLk9pF81lX9CvyrztQ==
X-Google-Smtp-Source: AGHT+IFv4SQv7wzMuYU8SmOGJL4AK6Ob6q5MVY6jDpbZmEUWVco1or4MZpxb7Nk2vuBDv40rDo5EmQ==
X-Received: by 2002:a05:6000:40c7:b0:391:40bd:621e with SMTP id
 ffacd0b85a97d-39cba9827c6mr524282f8f.44.1743711850858; 
 Thu, 03 Apr 2025 13:24:10 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6796sm2685806f8f.31.2025.04.03.13.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 13:24:10 -0700 (PDT)
Message-ID: <5e032473-6b6b-4169-bc3d-325b35536de6@linaro.org>
Date: Thu, 3 Apr 2025 22:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 06/14] hw/arm/virt: Remove pointless
 VirtMachineState::tcg_its field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-7-philmd@linaro.org>
 <291a5458-4859-47f1-a9f1-c0daf8205784@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <291a5458-4859-47f1-a9f1-c0daf8205784@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/4/25 19:36, Richard Henderson wrote:
> On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
>> VirtMachineState::tcg_its has the same value of
>> VirtMachineClass::no_tcg_its. Directly use the latter,
>> removing the former.
> 
> No it doesn't.
> 
>> -        if (vmc->no_tcg_its) {
>> -            vms->tcg_its = false;
>> -        } else {
>> -            vms->tcg_its = true;
>> -        }
> 
> This is a stupidly verbose not.
> But at least the names had correct logic.
> Therefore all of the uses you replace need inversion.

Oops, thanks.



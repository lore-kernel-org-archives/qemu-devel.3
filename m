Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9149CC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWhd-00069E-AW; Mon, 26 Feb 2024 03:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWha-000668-8l
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:51:10 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWhK-0001CA-NC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:51:09 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5129cdae3c6so3599513e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708937453; x=1709542253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGwyQbthrjPNuUCfvxGXFp/oA+cFnxc3NXUPZfla71c=;
 b=Jh8GejOUxBAQFH9Zq4r+wspvmdAZ4jro9iwwp04f1GBkdH5axBIdtl18B02YRtA3nJ
 oVbq5Ccc+MdYeZTf0PBXQCRDJ6167kuB6pHyCA8sx4NLu0cTf0ZmRZUy+v3S8e6Acsdb
 7Mm4pZQo7FFSy7a+aJn7iUamE58H/YXSosp8Oiw101b7IFBrcp7rC+Aqs2m2zScTCRWJ
 rAApTr76yl8JM2y6HMuqDL9JheIS76iemmfBO/cngn70jinb9A4xgY1qXV78NfeJRVQT
 q0vuaN7aRQqt37vza57q71XN9q5OplqCb2UTN+/wIp7zcYmPcgte4qit/Rw9xSmpeaUF
 YT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937453; x=1709542253;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGwyQbthrjPNuUCfvxGXFp/oA+cFnxc3NXUPZfla71c=;
 b=JSS/a6RzzXDnKioo4NApyXjycBdazoEENwrmKWYWyOyjnMocIlSaV5lwvNQfIFdewK
 RJv6y/L4akiVdYD6F4Is8ivwSzPSE8F3+zOhVIfYF99C0ByPkKfG9m/gmLDaW/Kc8Qwe
 OZmj8m2T3aQUV9JKOkNUHqGSvJObglHsy6GslG68xCnif49Z7Xl53HkWG/PohcnDFqme
 H/B0SfwIZYTakgp0toVPPjhDOj5BHvvS8uACcG+5ZkwbhBoT8ITl5r0RXSfMJltynyNb
 iKrohSJ6hWV4rVycJbjuemuDyTRmu6K1Uxv+RYvd1e/rvg4oxGr8EGh7A/P5k+njGxbi
 vPzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIbiA8meA0pgIlDtSWqWgNNoo/axu9N12fk5E5Jy/JwAO5dJGM/Pa+f9mdi8wYKgaLffc1QWDqBT8JT5yZcFbmubzs2xg=
X-Gm-Message-State: AOJu0YxzKyKTnRJOjHSL40y+BfBDBx2cMwBptkCnzLvC/ucv4vxG0FUK
 6ZTSpQm8fD4ZrHtACpzI93HsiiKgA7/CgjMmLbsvXjlBj8xW5jpcYj3RPmRaG1M=
X-Google-Smtp-Source: AGHT+IElQw8xB+oOBomtQwUvV8moNUhlvrvJWjcjD3yGI7A8VP7yA3LnS99JqyJ8WfMpzlf1NShy2g==
X-Received: by 2002:a05:6512:239b:b0:512:fe25:550b with SMTP id
 c27-20020a056512239b00b00512fe25550bmr1414534lfv.47.1708937452936; 
 Mon, 26 Feb 2024 00:50:52 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b004123b049f86sm7684697wms.37.2024.02.26.00.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:50:52 -0800 (PST)
Message-ID: <365082ea-7835-4ff2-b1aa-48bb89cc1c8e@linaro.org>
Date: Mon, 26 Feb 2024 09:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ide, vl: turn -win2k-hack into a property on IDE
 devices
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240226082941.90364-1-pbonzini@redhat.com>
 <401e7d32-c39b-48dc-b06a-97a4af16e6c8@linaro.org>
In-Reply-To: <401e7d32-c39b-48dc-b06a-97a4af16e6c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 09:45, Philippe Mathieu-Daudé wrote:
> On 26/2/24 09:29, Paolo Bonzini wrote:
>> As per $SUBJECT, one less global and one more syntactic sugar property.
>> Like -no-fd-bootchk, this could be deprecated but it can be done
>> separately---and would slightly worsen documentation, so I'm leaving
>> it aside for now.
>>
>> Paolo
>>
>> Paolo Bonzini (2):
>>    ide: collapse parameters to ide_init_drive
>>    ide, vl: turn -win2k-hack into a property on IDE devices
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> (This series will be queued in 24h)

Need a rebase :/


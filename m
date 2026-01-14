Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC20D38FE6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3Yl-00025D-2w; Wed, 14 Jan 2026 11:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3Yi-00024L-Qe
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:17:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vg3Yh-0001HM-CG
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:17:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432dc56951eso16872f8f.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768407440; x=1769012240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcnLbp5a4QNe7bcaSOCqcoZcGmpQVNn4MD+3WgY9XpQ=;
 b=RD1i7J3PkWYo1zKWTk6lUogPs2N7AZ3WRaoZkwhdbMnQJpsee0xm3mFCKnVzLgm7sa
 3y/CPr5rNwyF36zK0zsOIYHXJdk5M+H24pT8XnZEIHrOJnZhhNPgmBoLZOhA2Z2Nzcay
 4fu33lGbRxcQCHs96p/Y0kP1vNS6rWQDwyz+U/g9LwgIKfRr+2IyttjtNIXMaKgQW/uE
 HjyG0sT/M3qZp+UHKaAiqmpkkKRuCTQ8CF0nSgxm/CN/FxHCV5TUOBMQizWA93NNBxVj
 XXZ7Y7t6VRVAuiX/qgdBoAjLvQjZZclMxK6fy4YOyhxNh/jMm/aN7dZyd2T0r+GrQf+W
 0ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768407440; x=1769012240;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcnLbp5a4QNe7bcaSOCqcoZcGmpQVNn4MD+3WgY9XpQ=;
 b=LcHBM8Z7ZDFcQhwt9arL+UMkMbEX9Q/TZAoncXknyspeuBjEbzvL4ql5hsoDZRHRx5
 +bql4LKplLP6E1IGEruxucAp5r10CV6d9Zu+qmi/OcQa4FwIIzxa5O+jc0KnPNr8P/EE
 2gQyWuWIuS0X5Es/4PwKpZFR0OJvRkNnmLRGG3j2brTsKHv4ZFlZ5GW9Q64DsHWB/mXL
 jMxtPO7bkbHm7vtk+1MmH0OTUS3TgZfYIciK35SDrk3HcXrNEV5xJ+8H9F64fXJrRcz0
 2aubCcuXR5pA9HX3LEpHnlMVXy7rp9cKWnf4r+QO8xHEuLKgAQVwSvNQ4oe98gvHyf9g
 Mylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1SSn5p+/hpTu4GVSRGtyq/+HmOpDqmKY1cKY3a8GDD06IWIhUodyuRr5eSh8fcn4VnR0IOqJ6MQu@nongnu.org
X-Gm-Message-State: AOJu0YzdQ+u5okrBsoBYX/pdt8oN6Is00wdT9yWzvpbWRgnqybfBXrgK
 xwXPWjlBwDxZdCSM26BX2HqX0kNAfcoIBu3vHCexaMDCBZXHWPeQZxpwyaHPHBP/un4=
X-Gm-Gg: AY/fxX5Lz6r9N0yOGH3xqLxCZgHyGWQmVE+LGOLBJ/e6CyAo1/jhmEwQn8/rGLmhwpw
 4IabQWDgvgB+3SZeMko6fEoq+LDgGBU3pPUry3tihh1LRgaM9O9voNMjfHA3iDm7LftCqtvQwXt
 j+4gFSmXqPlDQAshonYczhhornmWUPmZvbNpROG8ohbsuN3hVFzvzcX2QkZy49EiSnKZ2zwTR0l
 /jUC6Vele3aNNr6OeIDUqN94Xxbly96x/DZzYU0jrlgowpvQNwSzlGEINWJCB2N65sNWXNksiEv
 q8na9vg+aUvKRXvPSZBXnnQWngVaHvlLvxJywDRHXRlVOJ50XWSaQSQPaP0o8TXO4CMDOaVKOsY
 5hJlHMRlHr/07cjlFgMfySeEgdSfejHpHLpQR1oLM/xBCIB09LtpM1TBemKmkG7O7zUAW0J78KL
 XMvFxtaXxy6gq8rm0QmXABt3P48GKn9KNML53sOVzsRdhfBMNrK8uvIQ==
X-Received: by 2002:a05:6000:3103:b0:430:fdc8:8bbf with SMTP id
 ffacd0b85a97d-4342c570dd0mr3247756f8f.59.1768407440318; 
 Wed, 14 Jan 2026 08:17:20 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af653560sm137082f8f.10.2026.01.14.08.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 08:17:19 -0800 (PST)
Message-ID: <d3e22480-a55b-4dcc-a89c-e5ac0ae60289@linaro.org>
Date: Wed, 14 Jan 2026 17:17:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20260113203924.81560-1-philmd@linaro.org>
 <1445b33e-59f4-4b73-b591-3babd13ed28b@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <1445b33e-59f4-4b73-b591-3babd13ed28b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/1/26 16:11, Michael Tokarev wrote:
> On 1/13/26 23:39, Philippe Mathieu-Daudé wrote:
>> Fix typo to avoid the following build failure:
>>
>>    target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>>    target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no 
>> member named 'vcpu_dirty'
>>      988 |     qcpu->vcpu_dirty = true;
>>          |         ^~
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Fixes: 2098164a6be ("accel/nvmm: Replace @dirty field by generic 
>> CPUState::vcpu_dirty field")
> 
> Hmm..  This commit is in 10.1 already, we had another
> release since that, 10.2.
> 
> Is this code being used at all?

Apparently yes, in NetBSD. See around this thread:

https://lore.kernel.org/qemu-devel/ea1e0e45-f864-4a43-a40e-48fd82c26c56@redhat.com/

> 
> Maybe it should have some tests?
> 
> Thanks,
> 
> /mjt



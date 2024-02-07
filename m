Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD7FC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 00:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXVr0-0003w7-RZ; Tue, 06 Feb 2024 19:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXVqx-0003v1-PD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:31:52 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXVqv-0000wO-Uc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:31:51 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e067ececb1so58459b3a.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707265908; x=1707870708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BONeK30GqVnoNEUpJM1FuM61R4Zd07UbTKqDWL3MnGY=;
 b=hcNOIJ1/dulqjoNMazLM8FSTXT9ANyJyiYPdNnHdxu376F6Sb1b3e5qBsnDYgIuBlN
 DOc4vpE0h4M/HHMJqmJJkpSgMLDgsavzhbcCohgmpbL7PuqTskyOSc+gVbBiXcmx6iZf
 3Atvx7HLteyK0C3rZ+zW695jZrrZ2to6MJJRL7u9PzpRU8sqTG6V5oP5NvN83qg0NaDM
 ja7oBM2+yrCC9ByCu/E20+x5FRUjb/kWtoXXQZT008q9tcrHtbBgkzFJZTu1Z63UOfsl
 wuEVuYIm/S5NRxMQPBxBvGGdCJxyGQ1Dyqzr9S+chIJ4DKQHwjZRk0r/3Lo6h1vhio5b
 relg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707265908; x=1707870708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BONeK30GqVnoNEUpJM1FuM61R4Zd07UbTKqDWL3MnGY=;
 b=ItWFAxJC0zAXJa+uXGNPyy5vnKBgYB7hcZzSRf0IR1FvZQsImn+VEnFLAiC+BNW+qK
 2LulSf26yNDPe7vGJZ2aDwspv46PbQ7PjFoJU7PYJbcvdoZRtvoMJFQscXJPDb0PzWh5
 +Q99wUNVT82Np1YOT+zMHB+7jHB9TmqVHPUx1sE/u4y1mDhFo4nbD+jzhplGk/iFe6EE
 mke2Ris6XzdbAtMiLsLl5U9DNm5CGmIwr91EA/pXinHL1osD1X3YWJawxjSzCfVGlB6o
 Lw8/W1JH7OvVHRA1G8nb+mtGFZ6VpthyCTMKWOCKQY+HVf99Qqdiibtwh2le4h2Uoj3v
 q9FA==
X-Gm-Message-State: AOJu0YwZWMxeYa4ngzncIGbhwE6CRW0hfXMkUp7GTM7y7yYJQFxmUvaE
 m1dA/fz1umpqqsmgjNCMcu0xafRL9dgNhQ3tWbcgqyj3Tiu4ISrRsOmOCClMSFw=
X-Google-Smtp-Source: AGHT+IFm6wwziBoWkJMCQq+xa/AUKOWyGBNF/sJyUpTGiYgKXH9msYmNA0vIIYQ1sDFZokjtn4hnxQ==
X-Received: by 2002:a05:6a20:8f18:b0:19c:97c3:8a5a with SMTP id
 b24-20020a056a208f1800b0019c97c38a5amr3849641pzk.19.1707265908152; 
 Tue, 06 Feb 2024 16:31:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWZA63gdSmkLEQnF4fNwtdrLkjrAUjYBb0NuN9gJ9Wk+yzjn381UvZsBNBwI4DGir5wLlDeP+LI6hz8m7sdJ36+n6ha7bKbTVSoysX9Z8kdqcgGkBOtrzRwxDXnMJ0g
Received: from [192.168.0.100] ([43.252.112.155])
 by smtp.gmail.com with ESMTPSA id
 sz14-20020a17090b2d4e00b00295b93bfb24sm156367pjb.22.2024.02.06.16.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 16:31:47 -0800 (PST)
Message-ID: <d57a4146-d7f5-4ba1-a11f-67e51d407423@linaro.org>
Date: Wed, 7 Feb 2024 10:31:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] linux-user/aarch64: Extend PR_SET_TAGGED_ADDR_CTRL
 for FEAT_MTE3
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-2-richard.henderson@linaro.org>
 <CAFEAcA8AuQZNbT=7WFXVPDzDywPPp1YZ=Bkow7Dgq2pC9=9X-g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8AuQZNbT=7WFXVPDzDywPPp1YZ=Bkow7Dgq2pC9=9X-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/7/24 00:23, Peter Maydell wrote:
> On Tue, 6 Feb 2024 at 03:06, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> When MTE3 is supported, the kernel maps
>>    PR_MTE_TCF_ASYNC | PR_MTE_TCF_SYNC
>> to
>>    MTE_CTRL_TCF_ASYMM
>> and from there to
>>    SCTLR_EL1.TCF0 = 3
> 
> This depends on the setting of
> /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred :
> I think you only get asymm here if the sysadmin has set
> mte_tcf_preferred to 'asymm'; the default is 'async'.

Hmm, I missed that somewhere in the rat's nest.
I suspect this is over-engineered, such that no one will understand how to use it.

> For QEMU's implementation, are there any particular
> performance differences between sync, async and asymm ?

I doubt it.  Getting to the error path at all is the bulk of the work.

I think "performance" in this case would be highly test-case-centric.
Does the test "perform better" with async, which would allow the entire vector operation 
to finish in one go?

I suspect that for debugging purposes, sync is always preferred.
That might be the best setting for qemu.


r~


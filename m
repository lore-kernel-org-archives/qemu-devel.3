Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC02D41D46
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBYvg-0003Y0-4O; Thu, 14 Nov 2024 07:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBYve-0003XK-0X
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:26:30 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBYvc-0006xx-EC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:26:29 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7f71f2b1370so365477a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731587187; x=1732191987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6+xLKBDHLhgPMFCSoABBMbJcyE+9GkQP3z+ZLeU8bRc=;
 b=pPYn5S/iCYow0fzY0kg+5LKob55Md5p7ZZaHbzkeQ4eCk40zLDvzrFj3J+Xeax5UYY
 ejk/VYRz/GQOGIRtRd9Yf1rb9WfNxTpHFLS8W0270Z2E3DRzeDtQ0w00z3n98AB9i9bB
 ig7vde1EQGo2498EdnuWjjKplJ2dFXL0jCyryN1FAMbEIeXW3SSDcEwf/K5VfWX4FtPy
 ck1VeMRbRVTZioc/AmltkD2j6CZLuUHtxD29smRFjKN3Fx3e1JnInWAZ8XU/ewfch37v
 q2E/IIJYwNp42PwA67tQR4y2KFO0bM0wjv+1rzR7G6RAqh8Mr+D8cudRpLETrtaZJVul
 Enag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731587187; x=1732191987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6+xLKBDHLhgPMFCSoABBMbJcyE+9GkQP3z+ZLeU8bRc=;
 b=kHBplEUPACfN9N4CdV+wHaOpr/RaOxLHTsWHgdXEX0KfzAcG8hUvps7H16IcJXqDRu
 v4zs//KsLDgEIRKTPxpGULlanPUhD7riPX3ZLm5SdmMcaZLYX0o0psvp9rbjFSKf6Xd4
 LFTT+odikM4E3czI9mxbzFNB1uk6TXtJhqE+hfxJqBOTG6jKXd7pQJzkURb2W2TX5Ugw
 ZUmZqmqj2WN/aNHhP6fQssOjDrrGZZcMK8MqQDCgHNQHbEh/mSPDjtUygbYMN0HaSV+K
 O22axTOk0JNxFBGvOFRo2XY6iRQ6nuZu+j+Ns3+yJtbM5ONUQaz44TfhSlZuE+YSNO9S
 YtAw==
X-Gm-Message-State: AOJu0Yzx05UM1sogikRTvWCBmfedsSQkUotwbhtX/xeo3/xr6dvKbbhR
 D1i1pBOcHoZkne/6qdY0SqztoRaTaNJBo9s4BqX6Hn9cWsKBN8hVz1qNJIx9CJU=
X-Google-Smtp-Source: AGHT+IHDmWpkApP4B3ULYH09/OMKOUJNfC0MrRwcXqk4ZOWJBt3o2IJWH2ZP67N+DggbWd0cYlHyDw==
X-Received: by 2002:a05:6a21:789f:b0:1db:e82e:c802 with SMTP id
 adf61e73a8af0-1dc5f9a3df7mr12382480637.41.1731587186958; 
 Thu, 14 Nov 2024 04:26:26 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024c06fbsm1181589a91.43.2024.11.14.04.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 04:26:26 -0800 (PST)
Message-ID: <e210893a-e875-497d-9dc0-aabf3fa291d0@linaro.org>
Date: Thu, 14 Nov 2024 04:26:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2] target/arm: Drop user-only special case in
 sve_stN_r
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241112141232.321354-1-richard.henderson@linaro.org>
 <CAFEAcA_CsWCNKOqNKJe37JRXnOPikLSRq9FyMR+T0sLLkAidLA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_CsWCNKOqNKJe37JRXnOPikLSRq9FyMR+T0sLLkAidLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 11/14/24 04:24, Peter Maydell wrote:
> On Tue, 12 Nov 2024 at 14:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This path is reachable with plugins enabled, and provoked
>> with run-plugin-catch-syscalls-with-libinline.so.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/sve_helper.c | 4 ----
>>   1 file changed, 4 deletions(-)
> 
> 
> Applied to target-arm.next, thanks.
> 
> This looked like stable material to me so I've added the
> cc-stable tag; let me know if you think that's not
> appropriate.

It does seem good for stable.

r~


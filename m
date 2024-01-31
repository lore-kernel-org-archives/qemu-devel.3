Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9DCC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAMt-0003N2-00; Wed, 31 Jan 2024 08:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVAMp-0003Lo-Vo
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:11:05 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rVAMn-0004TW-Cq
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:11:03 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-511234430a4so1395209e87.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 05:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706706659; x=1707311459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7OPCkwG/gvsqQpO1tu+2stXtgS4Zap4Jusq0Jjc8UX4=;
 b=sR8rOzn1D3Rn25uo/d06pYyVE3iv7tn18E9ktPDYZClTf6ouoQqBXSOu8mMfAgTYUn
 mgRbsSqttp/5Xz2xirN/mIOE+aTp7Evv1vxAimOlLH/Lng2McwzBTMq6B0yt4Gs2ZJ8R
 5c0NLcav9CDGlOGM9jl3NpyyQgDPHAAc2MqblshVk9f2WdQiQYdQ1cx4V8XWwP9RKKtj
 BMkV+5Njy8scCKCvzLjSLMwJd5wjFTFTK15TMdsu+FcPKTDERGjT+HKxAhDKiezaTmGv
 koQW9OFRJVEfFes4JzkekgI5sbXkFsYFzpF4dErJDsA66BjxtygG2v8W0v5/0Dqe6o9g
 Bb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706706659; x=1707311459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7OPCkwG/gvsqQpO1tu+2stXtgS4Zap4Jusq0Jjc8UX4=;
 b=rWS8rJaSEVq1M3gukdwgTCqa/0x8EozLr5fZPzI/5JnRF71qo1pFr1ulsc1Hs94OFO
 FK5ypCP4Y2//HfGvbOSMijzoL1XDBRRv0WActjvucqFJElTgIoIHyw5DOFF43K9JOEBW
 rqoiVOWoyqftTpQnUw02kxnKDWURtliyegd14zEGn6/KzfHPyWxJC97VlkNvkaPso/vt
 rRcFqCzZ1Eq2jlcoSq1ahKJfxWmWpG7OWSL72Hwuvedt9hZr9Iw14D9s+4YJCkjx8Dkt
 ZkS6RPOWy07RWfHA9HQjlxS0MDLIUFydOCFkXclKauM5EIABd4BwraCiTqguk/+cSGCD
 kiMA==
X-Gm-Message-State: AOJu0YzZn9cf01sIQWG8DxmHHD7pwlkspq+WVBGi98NGxgEFVVx0Le6V
 cYGccUtXhnhO5d77Hkyl2wTCROrpNGkuL0qNRj+G+qkoS7G92ptmFgqeTqJ8ynHQnK+xulAwfKV
 EDTo=
X-Google-Smtp-Source: AGHT+IHgH/8IRfoe0ZWCotZziM9OMBZeNypvS4dJx+5+3wF7mvYVlyZjwMPyYnfI6kN9Y1z59J5sSA==
X-Received: by 2002:a05:6512:2241:b0:50e:7a91:7e93 with SMTP id
 i1-20020a056512224100b0050e7a917e93mr1406175lfu.44.1706706659038; 
 Wed, 31 Jan 2024 05:10:59 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX2JD9flEV9NEZhBBnRujt9QGFIJXJ6isz6Rd5iDnZecOvUrwaKkiCn4zSY6aJCXwdgDtlNFJEGGLnWiw7/iTqWLb0KoyvxAWYOWlevXrANwGWuItBDzzQQhi84ahjDHJWCostE3QwZLmzMuPLuItr6
Received: from [192.168.237.175] (77.red-88-29-104.staticip.rima-tde.net.
 [88.29.104.77]) by smtp.gmail.com with ESMTPSA id
 r11-20020a05600c458b00b0040fb6973b02sm450905wmo.27.2024.01.31.05.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 05:10:58 -0800 (PST)
Message-ID: <f39cb7d6-beaa-4365-bbd8-7fc8546cf655@linaro.org>
Date: Wed, 31 Jan 2024 14:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240131001851.15932-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240131001851.15932-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 31/1/24 01:18, Ilya Leoshkevich wrote:
> Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
> calling thread, and not the entire process. Therefore, implement it
> using a syscall, and not a libc call.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/syscall.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



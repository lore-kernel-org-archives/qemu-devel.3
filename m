Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2679C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWK9-0000yJ-I1; Thu, 01 May 2025 11:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWK4-0000wn-7F
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:59:40 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWK2-0003Xw-KE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:59:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33e5013aso12989515ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115177; x=1746719977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nDhqVermge8BIUEv/4fbIfyBWCW5ZSe1IdEZtmzrPwg=;
 b=BmZeK6qsRge+Be1yDKDfScu0wLkE8m/L57S6IkqIpMtRHTLQITlrowY3DieS/HvJ1P
 COQI94Rw+g2XapNKYL+57dYkhxGa4dDQsZDSrh5Les7kk9zI+2BUXPGJPWOWrG0luTAx
 DosGaw06ujPC3Agi+8td6otpLDIP4ksriWR27y2U84iRLV1fv8UZNp5TeqPHLzvCoKb2
 /5Pjf85WwtZ3Xa6512x5Kr9Akne3KCyOCSrKgntOl43y2Yzr9riWCiFbqOHWei4gfzdm
 vPnzTqPw5fLEsaSpp4/8LmdVXHqDSVYIG+UvGBtV6seecydy5GPY6R74Bm7d36UZDMKT
 M3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115177; x=1746719977;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nDhqVermge8BIUEv/4fbIfyBWCW5ZSe1IdEZtmzrPwg=;
 b=E6Mi8F8g+JH7o97BuIOAmVoTpLS/PeB1mV2PwHWxSKbuL6SDammO3RZJY5VJGuar7C
 iQAzNVeqH+w6uK2343zOigWjgrPMW2BcZE6IcQ+s/nCKqGO/5Djzea38kbwEd3uV49L6
 e9FfOhJq4es5pk1aDqGMfNwt8qtSsYN0T3dfaeuEr6w/e30XZpHoWU7op1wx2xVDEYCp
 A0hA41wpQEVlDVj3oQ0HXfQvPXwSE9DuLKvZ7sUt2KqfM4owOzzQmbaH9xr2T9HtY04D
 UobDAs3ZGBr04abA8LR4+sg3KJqFxQvsMEpJuxqW34I1Rtkw5MWs6UfiJJVOZvw9pekh
 SBkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq5NWFktxf34cqW0RfwyH1BXpLc5yG/sli3XtlSn74R7YpjoAy5Bj9PyiHRoCrNj0uoRcN8ZsKFrcd@nongnu.org
X-Gm-Message-State: AOJu0Ywo5+WQ5WxStANxBnRIy9u4A9qQFmdwOdtjXHdf5KdWAIl6RuDq
 rQqK79wtQe3XoG08U1wYvebfCCJIs6Wxd/EraTghZ6iNmiHdRR5LDQcfGdzlFVHaEMeqkarpuV8
 p
X-Gm-Gg: ASbGncuccPtYJeCWhg7HjzrMnkY95a5DIzHlRdiojTWjaW2JVb8mbwudK5Xb8xsZdRI
 /Wy+z0Aa/xrj/7GpcFPE0qRThNENt2AlSebeQncekXidEOiWo+dYj26jDcrfP0th7r/WGABGm+C
 T6uPZZzTDXX6qlRZpWolJtCOLao1yoRzGGaX+lc3yukCo8/a5pMgDOo8rhHJmL+f7XnroPjAGPo
 39w/Xr8UHMT//Ggwdbkp3duLgDozCXuRBH3Zxn5uFHZyWso4Q59wplwHXiYOQB5SunrB0aosX1A
 Kf+pKxSeqdWXSkfeQgerqrx2LSHUKMyavxZcVypO0jQ9XZdbLq21dA==
X-Google-Smtp-Source: AGHT+IExHLmNilAVuTG3puKlnMy1mFrqm55GsH2e+kP9JmNOOGPZMHCsOlD10lLGxgSnjy/Sex0PHQ==
X-Received: by 2002:a17:902:d491:b0:22d:e458:96a5 with SMTP id
 d9443c01a7336-22e041258dbmr56270085ad.38.1746115176785; 
 Thu, 01 May 2025 08:59:36 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bc88938sm8271105ad.214.2025.05.01.08.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:59:36 -0700 (PDT)
Message-ID: <10ef0c77-c0c0-4abf-ae80-7016e80b7649@linaro.org>
Date: Thu, 1 May 2025 08:59:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] accel/tcg: Move user-only tlb_vaddr_to_host out of
 line
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> At the same time, fix a mis-match between user and system
> by using vaddr not abi_ptr for the address parameter.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ldst.h | 8 --------
>   accel/tcg/user-exec.c        | 6 ++++++
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



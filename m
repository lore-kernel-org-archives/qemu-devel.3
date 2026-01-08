Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C923ED1D492
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx3Q-0001DA-NF; Thu, 08 Jan 2026 15:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx3P-00017V-FD
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:56:23 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx3N-0002tL-SB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:56:23 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2525453b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905780; x=1768510580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nRLfedqpBRrH0vwA4noxT+Z2Qu+i7ZP47VTYyJ9kX+Y=;
 b=MoQZVWkUUtz237dCIJ8TIl8T+H0Fd1sCOVnBDl+RAeVkPXekvpI1ADJH5ePk8g11Bh
 dVLHowAZ7jcqeuFtxOqUmWJ3beRXIDo1AI8ZOyWoHwhCgw85JxiLXVoEPyoiSD2uRc7M
 QSvX4C2HxZaQAeRi44SrxMF+WX2IZ9nUQ5kd9NWph6ErP73wpDZSyo23grrwbxKQCkue
 l/TR8zdvT5WsiFz6zqeJHDWoquwk7coNj3y1358TPDi/565y/Lskklan2fugIYpFu456
 69WF5so8h0xclLsPNrSqEn0fEYCNLwu3natW7abr7o45K+G8HWAwa/hFfOkopxwS8+HJ
 d7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905780; x=1768510580;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nRLfedqpBRrH0vwA4noxT+Z2Qu+i7ZP47VTYyJ9kX+Y=;
 b=S/5PQZ8kgFuXroHxcQ1cBBH/879tHfybLaswJuA5r8hA9v58lodVpIe2qbGMQEEZHF
 mhVzdf1LdP8zpPu9KvjZPSJw5Erzg1QZzwC8H12Zk1AB+sTpV9l7o/UmAKAi6na3vbdx
 48SHNgPVjKkTZAQQPZHy8nfQ/Bk2yJGmEHWzkqsKjV0udCkj+OQyOtj9At6fuiNlK6z3
 1Kw/DC7zIjCUCoEmstpHxRr1/PULCXkgEJv0TeHD/fTXHG1cImb/29+jUeq6hSpZPZs7
 7qzyaZblcxunS41TlXwchhanylj2E/7YHhpvbDS1bq1hR2sGp8wWTYJ2cifozZZZazdA
 J1PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN29eRZkBS6rdoHm9ELpBOAi3JDuhOv5aGZspO43kx6EheOM9274EMyCUDv0KiE4w6hDPISpuBGagr@nongnu.org
X-Gm-Message-State: AOJu0Yy87DFtzYsu9RMDE79K/VGF88E8gyJOia8DSU37g0DzACEKjwzZ
 epLFbo/YDmi61Pqvmj6HhoZRkQ/PlV1J7dQOmRp0g/h9THAuVm2OCGs2lQUqHtGsC7I=
X-Gm-Gg: AY/fxX68eh6fWcFV69bf19+lBtPFUntcyrugl+bFDIH71tKCGJ3zf+suNF9pvKkgGmC
 TA2JnDV3eo8IfQKM5pB81JdlyDuXs+QBENDOxuLwZCf65HvliFOo/0eoq3HLSw3cs1PZtWjy8wG
 xw7bQp1PAn7fcEpllNO/Ym8+Wd9gfSaRA+5ENew0kE0be/InDxQE43+PKgwHwZ2ELTjc/Ft07Ta
 kXv4zXiMI9JcUZFQ78+p1J2hM1TDkY79lSZpBUv2E7M2MPRxhBbHt2Iv9n7RmJY+NKZdgrBftVw
 Mf8IyyDJjdLMe0UaVOyEAqELP+UNvWHUAQq6m+WOKobPcB2qx85EfKhxhIdPfupMjaEGY5ghlE0
 9mJc5VgZ1IEIqzmCZ1tgIlbNJ467b6lEVyF68ARLJrofm6Oe8c9QAKHnTBqitRrrXGD+ldCEhHj
 D9W3D2nITfETJT4zaoyjYxWgrl/vW5dEt061xCk8zXOKAgFbh+OXWiuOXR
X-Google-Smtp-Source: AGHT+IGigNBSqlUJH+EM6G/Wd1I02gG/PixJmQzWM34nAj/OcAAnU8wkP9Y6weLkI32jgC7UEgbImw==
X-Received: by 2002:a05:6a20:1583:b0:364:14f3:c536 with SMTP id
 adf61e73a8af0-3898f8f3b25mr7843906637.7.1767905780385; 
 Thu, 08 Jan 2026 12:56:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b7b3e7fsm2758286a91.2.2026.01.08.12.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:56:20 -0800 (PST)
Message-ID: <18ee8709-ba35-4bf5-bca7-f3a23e13a079@linaro.org>
Date: Thu, 8 Jan 2026 12:56:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-27-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-gvec.c | 49 +++++++++++++++++++++++------------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


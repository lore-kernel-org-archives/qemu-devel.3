Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71DBD14880
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 00:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vde6D-0002dO-Qj; Wed, 07 Jan 2026 19:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde6C-0002dG-VR
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:42:00 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vde6B-0000k3-HM
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 19:42:00 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c4464dfeae8so1756162a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767832918; x=1768437718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MgOvnLYIceV4k8k6KHWPtWo7gpdcavCzGbF6loDSRqU=;
 b=RMxUtAAxeNJ6djuQrjvA4t+KiVVRT24At2/+7ZCWCydwyIWHJE6w0m08XgA4vlNjC6
 ASGXJ5Nzjy2nN7C/p1GF8duLvsJULXKI5uKPBsRZTlDPtdTIV787org6TrFxKQ98CnaQ
 YqM/L6MfpIfVtWIeTAiJctfhBinWIuF8I3LbcQaxhLOVLtWYVEoAiFSPXD7iLqEFDdgQ
 2fr+hjrdXYV/FER6GKrglyD4Qv96iDf92U01CM9cDAwUB2WhGgelGYrqSgfo+mTDpa8s
 K2U2UNfyCtY1pyr89jW8gVbaWTLXcnLeaBXhbbR0KpQ5mFnqe/BospYfuXinmzaPbhF/
 dTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767832918; x=1768437718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgOvnLYIceV4k8k6KHWPtWo7gpdcavCzGbF6loDSRqU=;
 b=lS4tAp/BI7LO71lrY+aPSGSbEOaNXhN2yfq50dx3MZpDDp1z/39WWQA6Jf+Ql4dgQz
 jMLtPrEiMGXsxmpr/AlS5Q32iJBx4iSVNwzFSq9QXAQkmN/oPHuPNxeLoWc5k5G9Rjd9
 Ybw7qqSA1IFn0iR1i3vPnyFkaktVsGUVNed9vE0hgNa9qeZZEioEfWATiEthFxAJJE15
 SQT8cw9e9d6EsE1cTNrHLDzRas2Tcx9AakBAkqPPw2CL7JkM2sZAsO0MflCIUo1QMZIU
 jixfBCBLkAsnAXMhS2Ovzm1zwvSCU7UJr/HzQPryePs/H6ptgvWNWXarRcBx6nOusCWG
 qUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMwysyWdRWp3q0JfYixl58cosPGoXwYvxKKtPDyqirtFNr6oQPmzjEIeHcWS9HWeoiEYja6EM9s5E6@nongnu.org
X-Gm-Message-State: AOJu0Yw5DuTJddp6cl8KnM+DcwlXV+ysyWeVPC3Lev0dJTnVIqJXXP3e
 pL93ug8t+T2SG9Q5tgA1iK/l3zVCxlr/0UuLP1gWUOXs9slgNFr5emJKaghqbBYAz9zZJLjABi1
 jnokg
X-Gm-Gg: AY/fxX7yXiOUPajjRVUy1e3L6kmWQSMLeu4QD8aWHxmSDdv/CKksnW0oQJnMbS0lfYb
 Cy7Sx75BMeTsbl2dKxF3/lMqjoQ9aLM9ba05AMG/DFrFvAMwfa8EY8HBik2t1py5N27QCx2oQVw
 fqMJVTlzebO+E5E1r+3vndWcnxcBYGVhcpo9VSpHuSZxoFVtr8+84Ir2iMknRItJS9Yfxj16tqj
 mvFjOwLuhAzgNjwncCqo9rqULod4g2KBhnB8zRBYHd4CwBF8zfrz7jhl0EWg27V7L+ojpmEalK4
 a2Ny/tlrYp97PEMMifMjyaWDn5IUKpzqC+GBsWXfeh6lypY3C6pUXb3A3/wrT7XZd4IhzmAZ14m
 cHT90wBOHNt1CCFaoQFOrK3VIdEhBTxPZL9Q98agkMbgsKk72kP3bfvazBCB2m+wq6qm0/pJPAU
 K0x6yBb9gJj/4SPJnXxGUMVO9VEJ/9AR4kUek22waOGEh4DlsCtvHt7jg7
X-Google-Smtp-Source: AGHT+IGwuSIerD5D8e/aZsE8Yvb3WzgBpRqW8gGHSCgWZ7pP805CszsCuWxrklni7bgQ3Idse2wMlA==
X-Received: by 2002:a17:903:11cc:b0:2a2:bff6:42f5 with SMTP id
 d9443c01a7336-2a3ee41510dmr32835645ad.8.1767832917933; 
 Wed, 07 Jan 2026 16:41:57 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e7a3c6fdsm50719345ad.15.2026.01.07.16.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 16:41:57 -0800 (PST)
Message-ID: <29267bdd-64f3-4ac5-b9cb-8561ab121aec@linaro.org>
Date: Wed, 7 Jan 2026 16:41:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] target/alpha: Replace MO_TE -> MO_LE
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260106155755.53646-1-philmd@linaro.org>
 <20260106155755.53646-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260106155755.53646-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 1/6/26 7:57 AM, Philippe Mathieu-Daudé wrote:
> We only build the Alpha targets using little endianness order:
> 
>    $ git grep -L TARGET_BIG_ENDIAN configs/targets/alpha-*
>    configs/targets/alpha-linux-user.mak
>    configs/targets/alpha-softmmu.mak
> 
> Therefore the MO_TE definition always expands to MO_LE. Use the
> latter to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


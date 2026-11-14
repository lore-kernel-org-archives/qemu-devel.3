Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726D606A329
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AvVHGDDT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSFVB-0003V5-FB; Sat, 14 Nov 2026 10:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xSFV2-0003Om-5R
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:17:04 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xSFV0-0006d1-JC
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 10:17:03 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-706113e92f9so1924016eaf.2
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794669421; x=1795274221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ztr/ufpPwgm1eTxfpDpM0sKjyPATXBSU3kVh4E3UsQA=;
 b=AvVHGDDTAtF79QZlL8XBF/ckrbwKtogaaN+5QsJcMwXEUlNnbJJFHhin5eSAZ3sfpC
 gK+4Gu0R6EUA1gJW2ai1XfKa9HSU5agMlVjDATTHxgfdX5ApdZSzzQCXnnAFg+RioMaY
 z1Y0dRSR8pfHFopIX+M4Jte6UDAbbuqzV7opDc6yvb8JkyRUAteWVkSHP8IpVQPs6BAq
 VugUqJcOLb4J9XLVByzUMuINQ2Q9onHCRajVEVmw8aQNAClonTwZUheJAJ2TRL8yXYhm
 oWCzbQaEMuzzqiWS0EK5vrpw7G0sW8R1hX6TvhkgmwoOsxW/H+64+2Ga9DfzD+yytYzP
 ZZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669421; x=1795274221;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ztr/ufpPwgm1eTxfpDpM0sKjyPATXBSU3kVh4E3UsQA=;
 b=fvWyyFqu5i1jMGccP5qHJoKe3U8Smrr2appg06wA89CbIoETFnhOHiwOQENPjkDJkc
 7Vv4UpdlveQL4X7GspvJ9gIUfuTNPZx62+6YB4sI1Sqoa60AcOUkCu4NmXgUqXuAnTbZ
 25LonjKCu3W0jrM3dmhTltYLn4ioUDNKjMOCte0RFo6cY9hNOKRKcUCQsps9kWIrkQSj
 JvUkCUKDW5/szvMKdq4VWQQQuf1fgU0qtBrHLDYJ1Kq+Ro8Iqd7HyQnhfDW03NeCkzzt
 OuWC5/rWicpl9kz7Hdi6wXCmuy8kUa9PJ5NijinvyF2gNW+VXDN+0uV4D7OY9zKxfr4r
 IrIQ==
X-Gm-Message-State: APuU4Z8X2HGgzmDyJCWjbfx6avJ2zRE4LwR8KW8HbG/MlhBnChEmBfl3
 GhMjCW97jOlI4nZprNWCkF3PnM36/d671EZrh1d2Dloq/LOPiQwzaBFdzpeipyxJwao=
X-Gm-Gg: AYBFou2/ZxToVevB3DKdM3aUfSH0NcIrCnfC4Wam+RHyx0zwpro7hEfwWCCBHZh1I4l
 TzAZbe4sLg7gm0P3a++ZEjeBzv4aLx+po1SRgxWdWKN45HN2vVCpkRqD6kfWApLKn/qZOy08H26
 FYqjGhXO+M3yLhCTa6CTCNgyy67RCC4XX37QXAyDmRAmaSmlkcdN+JMX9xsXQ6oNeNvqzCHcVaW
 l8smFrkr0LnY7mRrlPLN354oM6CW3Kc6OUVtEh8cnPY0wzGJloadQNylmKYDgmsNqAbXVPsWGIN
 n2IcsaI9R9T5gxYWRQ1O3Ekmug6XWLWRP+evYH3GysVXRBy2nFaRgBcBFZJE0WlP+5iLg3C0Mzh
 mZ/rVUfPhsLcabj23oKPb6+DSkaNk/cDdzpHQLKxKD524l6wfmdKkW3Ps55geRUvrVjjacx8pUa
 gPoaR7lPo47ctDAI4QiSkeozjO4ry3q4JpWjDAbH5/oma1IhNSl6Mf4aVG6IJJsrLhSinDf1mqU
 AQCaciBzH6G535aFalqqNZwPGi78mcKa6+FFew6gZes2Doc+1QsRoBsWZsiXHngSE2xmdYzOY3x
 IKdaj+GUezSROs9n5PiTE8vD5YCMPwtOst6iGv83DSI=
X-Received: by 2002:a05:6820:3410:20b0:6dd:3534:478f with SMTP id
 006d021491bc7-71ab5096ba1mr2311970eaf.73.1794669420810; 
 Sat, 14 Nov 2026 07:17:00 -0800 (PST)
Received: from [172.31.6.233] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ab428b337sm4538815eaf.4.2026.11.14.07.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 07:17:00 -0800 (PST)
Message-ID: <e2560b96-2c36-4e00-8187-308e379ff1dd@linaro.org>
Date: Sat, 14 Nov 2026 08:16:57 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: use gen_goto_tb for vsetvli
To: WX Chen <wxchen0913@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <e54b27f6-7130-475c-b2b6-b7a477de48b3@linaro.org>
 <20261114075803.58854-1-wxchen0913@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261114075803.58854-1-wxchen0913@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 00:58, WX Chen wrote:
>> Did you mean TCG_COND_GEU? Surely dst very large results in vlmax.
> 
> Hi Richard,
> 
> Thanks for the review!
> 
> I think TCG_COND_NE is correct here. The `dst` value actually comes
> from the previous `gen_helper_vsetvl(dst, tcg_env, ...);` call.
> 
> According to the definition of the `vsetvli` instruction, it will
> set vl CSR and copy its value to a dst reg. The value of `vl` is determined
> by the relationship between AVL and VLMAX:
> 
> AVL <= VLMAX:
>      VL = AVL
> 
> AVL < (2 * VLMAX):
>      ceil(AVL / 2) ≤ VL ≤ VLMAX
> 
> Otherwise:
>      VL = VLMAX
> 
> So, `dst` here is either equal to VLMAX or smaller than it.
> That's why TCG_COND_NE is used here.
Ok.  I didn't follow the logic outside the patch context.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC871C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 20:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9uO-00022k-06; Wed, 15 Jan 2025 15:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9uM-00022c-Is
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:22:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9uL-0008GM-60
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 15:22:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso156387f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736972551; x=1737577351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wv6wy8EOuoU4LYP0/b9rzNWiK0/tS4mN1mRfgKaMddI=;
 b=GOLWzqjk75n7Fw7EnooF0/nRoxUeGew5kb7ICKkfGjWU8TGLk8ka4ngQpJPf/6VelK
 5q5NLeaPra1a+GQ829zQC9j3FwybkwlHtznytci9RSo06r9OaiYnfTCyZ7J5BmB5ESYm
 Nn5FBnaNUbnGWx5F+jr2JhmC3aRTN6uJHKdK1liXcxR9gbA7aNQ9ZO/61E+vCj64a8f8
 s4pxj7a0pAWojIAXa5I1eyJl5r3bhrEPjkywxzchvEmQAiDJ8kDqg9NN2/zMSyC6GMbz
 WEesx+qqR7L4VcqMwaFd0s166I4DltQSOeyb7HQ2lR7B11+94XLKwudIqHV065MVBpBi
 irpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736972551; x=1737577351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wv6wy8EOuoU4LYP0/b9rzNWiK0/tS4mN1mRfgKaMddI=;
 b=ZvkmNuyCYM+K/a1Oe+B/V84han0sfMtHYfCI0q1f+eST71xrEAx7GlkdBeA3gnX4LQ
 c1wvNK1+W7uXUiqQxf8MvpQY5H5vJGrnW0OiZed0WsYIuW8Z7jvcq8f+t4Xx36nDrUb5
 oor5oY4VbgItG0BR0IG/mf8tZe81LWZuo4Mw0km/hwoEazBoy8+TuIqlSpP7R7YkJgoh
 9SCAVNELfOb6cGJomyq4Ur2G8MyZmE5KDxLhxTpcaFHpnLMtoEBKaQnFnYhPrfPlwaX/
 oYIpPHJvx+94J5LK2tlSawEmQwrfhUgyXLRHZAkhE/41egFvHORpa2zQPtnaIf4q9xV9
 GP3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVysf0rUnDxxiTmwgQOTNBZDQax0L5Bhrf+SYJV9yetUSvdJetCCM1YfGuYRufKXbT2m/zH2jOuh5QQ@nongnu.org
X-Gm-Message-State: AOJu0YxejlxQr3Qk6quvRhCy/pP85GrgoMCJzC/35mrNw7kHbYP7kh7s
 HDWo0lW+gev4EH8BsEL6gZnwIkjn95txdMk20drsuhTMZif90nJZydGqXPx6KhsaFz54u+y5RHZ
 Q0xM=
X-Gm-Gg: ASbGncs6vtrE+O467+/cTH5f3dYI/63NEu/sTIIOdonFfZ2tXkHtmRk0Wsw8iTE8uH8
 ZNc3qGZuNPhNDeDdHnjdtsskqQz0ZyXJk3C3wYF2iW6yz8u+KzQ4kmu3i81B4t59zkIp0J1RQhF
 Z8+0LZSe0n0ioA20S6Z+PgPqU4e1eJfNcVmifXRSuFfKHXCJcR7o4v+AbSckhWcnE12nRPRRFqq
 hfg9mTXixjTleht2/mRKLxtegirduxbCV2JhlW/U8KJutQy4xNTJB99i87BykYYZRDRhKAxGva8
 BiQrmTF4EdHGewUI1KBJQ1Py
X-Google-Smtp-Source: AGHT+IENa0JEvKQ5v8jY83VyBCCPBeIburqrfNmGWZjrP1oFlWkPwYFuHFzrNG09ltBj0Scy4o65AQ==
X-Received: by 2002:a5d:6484:0:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-38a872cff26mr24554762f8f.9.1736972551558; 
 Wed, 15 Jan 2025 12:22:31 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b44sm18702338f8f.90.2025.01.15.12.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 12:22:31 -0800 (PST)
Message-ID: <6ab372bd-c668-43bf-8f5c-9c57130ae121@linaro.org>
Date: Wed, 15 Jan 2025 21:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 72/81] tcg/loongarch64: Do not accept constant argument
 to nor
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-73-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-73-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 09:01, Richard Henderson wrote:
> The instruction set does not implement nor with immediate.
> There is no reason to pretend that we do.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



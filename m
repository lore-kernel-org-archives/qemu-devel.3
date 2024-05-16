Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F2CC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7XOa-0001tT-7s; Thu, 16 May 2024 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7XOY-0001tE-6W
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:27:26 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7XOV-0002jX-Lx
 for qemu-devel@nongnu.org; Thu, 16 May 2024 05:27:25 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2dfb4ea2bbfso5843821fa.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715851641; x=1716456441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfbPgDIy5AeUMz0qyUIuKnxBJ+BSDS2PaZdQRATznRg=;
 b=YbiSM+XnfTChl0StcfcAZcbIsQc8xFL01xYWRQqRx6LKruvCVd11folfZl/sx23kXX
 r4+B4DSJZbMaMj0iSDaHXgFrArXjgiQNVnwYX7Z7TV8VMj6yridx8YeRvxo7z6kAFSgf
 WvPHQqpAms1QpJrbIgprbmlvTwHYSy/UP6fOTUeLUX7pNVOHDqEfFft33roeTnUhkUhU
 AfzPRTYR02AkKZBRoQHOmmkrkkAVGf6AU9ZmSFyEL2iKk84dt9IfIk7EAG1WNPKW1uU9
 bS2KNsZSz10/BWMqi5MEUck3z0Vhz1qKQLUBagyBIQJBLKwAwYhZcUw9cKjqrdKlJebZ
 VmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715851641; x=1716456441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bfbPgDIy5AeUMz0qyUIuKnxBJ+BSDS2PaZdQRATznRg=;
 b=qBvs9GReR1+0RvpaiMTPz8a/8UbWosm711whyxZxLfHFIzzgnLDsUY09lLRUYjHtQS
 8hC9nSczJDIqlGPYk+SMqof7HzwoYhFB8G3oE0Sw0cmIrsT5hg+jG8mFPfpsdaOoE1V+
 AXRYNpDes4w/nXm7LTKC21rL5LUa5raGScETg9mpjRtZIeS5k6Ts+PQPwhejubZF+oxN
 haLF2+SpB91rSdjRsOTgAgW8qm5oGySWBk1IkuGcVrRKjmYlYS6vvlKRKgQ4WQErTCvB
 hra+3TlSTH5Cl/CwOpQmbtam5GY6DngORvFUFcA/f4H8I30nqdxGPTajginkKvuH3yPL
 zvcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWunchoEk/HYhSHBdpfO3fmupZH9Xl3tABd25o9WXhgScCL1LNIHhrfK6Gs0a9gs2aTVKJ0LugAcPdCw0gFqplr/1uKt0U=
X-Gm-Message-State: AOJu0YwPmnKRFEQP3zoIjz7AQ/VKGZ/7gli225il5Q9+qi74obPtOjNr
 ge20RtYfI32Vk2FLoRlwe1lx8+OUC5stJd1Pjj2G99nYrPLWxotx7wi9egsI9Sc=
X-Google-Smtp-Source: AGHT+IGR1wiPqCU5qDqGOPxf0ocEYImldau0n6gwjHxZzqdGjNqC5x3rsmRthdU/NQl9HRSp6xtbMA==
X-Received: by 2002:a05:6512:3ca4:b0:51d:67a0:2433 with SMTP id
 2adb3069b0e04-52210074979mr14686448e87.46.1715851640741; 
 Thu, 16 May 2024 02:27:20 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42011bd013asm171849025e9.21.2024.05.16.02.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 02:27:20 -0700 (PDT)
Message-ID: <8e405362-6e98-4ef0-95e4-ac4e0ed2a9d5@linaro.org>
Date: Thu, 16 May 2024 11:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/11] testing and plugin updates
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240516075931.868035-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240516075931.868035-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22c.google.com
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

On 5/16/24 09:59, Alex Bennée wrote:
> The following changes since commit 922582ace2df59572a671f5c0c5c6c5c706995e5:
> 
>    Merge tag 'pull-hppa-20240515' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-15 11:46:58 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git  tags/pull-maintainer-may24-160524-2
> 
> for you to fetch changes up to 09afe9677e6aeb7629eeeab5abccc17f67cb4875:
> 
>    plugins: remove op from qemu_plugin_inline_cb (2024-05-16 08:55:23 +0100)
> 
> ----------------------------------------------------------------
> plugin and testing updates
> 
>   - don't duplicate options for microbit test
>   - don't spam the linux source tree when importing headers
>   - add STORE_U64 inline op to TCG plugins
>   - add conditional callback op to TCG plugins

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~



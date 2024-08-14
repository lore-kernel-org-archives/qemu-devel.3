Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D2EC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMHA-0007xO-H0; Wed, 14 Aug 2024 18:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMH7-0007wH-L9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:15:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMH6-0003K4-3j
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:15:25 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fc692abba4so2997085ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723673722; x=1724278522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2cY50dsXpkdXKTLeC2u/+lFS8nWrX++bu9ay5TQ+wW0=;
 b=TCthJLpXJMrGLFkAIxPdu5FXUD3nDZrx9WXXXThKDqiqTHVV9g8L8K5tGIiZou+0xr
 kGJS5jKKgEc3ytInNoqbVfktaRYyIepnkmA6iW1qfpREnl7Qv245zVs+xxJNcx/zP1cq
 DhTMeJ03aWpOmfBCSNz2a8xHc2zlL9ZbASHeUS48uIds1wdS3TkIaM/DqohYxZNJc9tw
 f6nVlAKz4h0+tFaZ4mbyPTIMvKZDnMhS3hITExEXqdUmYhy3xPUvvNUlZdzsZ56+qJX3
 aKMx4JxnbSfVkQQrxIQi/UTBWOq4kZqOZfIiJ+mJPZ3mFixZq1XgBYeR4sLf0ko/NfWe
 mlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723673722; x=1724278522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2cY50dsXpkdXKTLeC2u/+lFS8nWrX++bu9ay5TQ+wW0=;
 b=xHPuJVv1nqbL52l1Z19nowpa60MYSy+KdMPTkfLGvZHDeMmAn7R39P8lEfI34hA5sv
 hY8zFvNmVOoHozZ2hyLM6UxodeDMLnBqNWaAltOrzT/0QiQ3l6Vjg2EiEeKQ70KdM1CV
 goIkA+bNtWQAcKJ69JGNKf7LyBdKyUCFqSfsD/60Wvmbe05yjQsMMEM/0NMg1tP5JN9u
 zZZBHrOYxddb0mMPsSYXR9VoAogMbAPCPEKoWRpgXVX2l8CSFd83eoVyzawmjAKOvo+d
 BbZaQDh6ojFPsZ8OvQXLeNDEezw6RSnjd3dTzJHzT5uDXZQw77pPwzBsSpvl3WnZ4WJP
 GQzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBx6EpJOch4CxTBixlb2ZdKV3Mb+4OSyi80uz8nysuAR7UpeSDOfhAyAhypL4cYOxjnwN5DyVtzR8Qnza56uXtS9z5zms=
X-Gm-Message-State: AOJu0YxQsg4kQ36bbuDexpFEdGGiH4QbQXFqQFsGy/iVjUQwiKUfs4e2
 eyMOWIxC8aYfcGM8wAT3n738d2PtCIcIVZ6Dv/ovn3nh/shT5x/ChcX01oqwpCA=
X-Google-Smtp-Source: AGHT+IHuJA+jeUoXKzEvFKmxYBp/aJS758N8o5BSa91mC5leBqtYDVXCiMPr3NvMadaocc9ByrTkzA==
X-Received: by 2002:a17:902:e888:b0:1fb:59e6:b0e5 with SMTP id
 d9443c01a7336-201d63dc35amr52342175ad.19.1723673721572; 
 Wed, 14 Aug 2024 15:15:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0378952sm1072515ad.133.2024.08.14.15.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:15:21 -0700 (PDT)
Message-ID: <525fc6fa-293b-443f-a795-5282fd49e1db@linaro.org>
Date: Thu, 15 Aug 2024 08:15:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 1/4] linux-user/mips: Do not try to use removed
 R5900 CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier
 <laurent@vivier.eu>, YunQiang Su <syq@debian.org>
References: <20240814133928.6746-1-philmd@linaro.org>
 <20240814133928.6746-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814133928.6746-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/14/24 23:39, Philippe Mathieu-Daudé wrote:
> R5900 emulation was removed in commit 823f2897bd.
> Remove it from ELF parsing in order to avoid:
> 
>    $ qemu-mipsn32 ./test5900
>    qemu-mipsn32: unable to find CPU model 'R5900'
> 
> This reverts commit 4d9e5a0eb7df6e98ac6cf5e16029f35dd05b9537.
> 
> Fixes: 823f2897bd ("target/mips: Disable R5900 support")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/mips/target_elf.h   | 3 ---
>   linux-user/mips64/target_elf.h | 3 ---
>   2 files changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


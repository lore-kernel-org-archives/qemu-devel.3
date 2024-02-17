Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEBDC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRHv-0004U2-Lq; Sat, 17 Feb 2024 15:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRHt-0004TV-SK
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:27:53 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRHs-0006RJ-D9
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:27:53 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-59fb5b09cc2so182162eaf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708201671; x=1708806471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E4fplPCHWBpLLV9Pt0Kzz0VA1xpzvnKrgo7iV2TG/6M=;
 b=nZu6rdkpRbPy6yo5KMRJLuZMqz2EoYE78u+oXgRZbd5bqA/rG2+hRHFJj6PLjm9s7Y
 Jv6Z2WIM5LxjaTZLBG5UcF1PFoJbraUt6ElrbsjOI7Ow1xLFek5gxgzLEXlidSFnbqtb
 0PwWmF+sCMZ6XOjYHPMvCg+bF7xYpVoBiFlCSTLqpfQP69upNtKoFk7hQjZt7pd4ElTL
 aV078rbQEFcYQ1Ecyo/jGJLzOAfMjoxXFiU7G3XeCWA42/TMBc7zWDCVka0d9f4Luj0T
 3HtgzVIO8bdyooCUUw9ZP3z0pZIN2STyqDM5qMemgz5OuwnEIWhJ6vN/Sif2y/Ptj9Y3
 RV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708201671; x=1708806471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E4fplPCHWBpLLV9Pt0Kzz0VA1xpzvnKrgo7iV2TG/6M=;
 b=aI/DjR0Mx8mKtBftNUHHM3M4RBw3x4KYj14U2Qc/yjO9cwAI+hXDwr0JAXNCcqQyR7
 8G8VUDIFln/neQ56kPW+RG2sBPuTZ7rVlVADc80w4aZf6XEX02ruIACsh/xFmFH5WwrM
 zVfOmtNQWxlL4DmGkUaOu6+UZ3pziOR286LXN39L4/XPv2kAPKpeklvo57CmmccEBjS6
 3YF5sqTlkUB7eKAu4wF7cdMPwwdsmmFEt+1cCtOTbKPbTYyaLAJp5yAD0af33OBEcJIO
 5tvXnNUKadOk54Lr1ekLkM9H2hSEU9dtqJHLTGc5gK6ajrN5x1Sn+7HXtcqdelXgB/zD
 QPnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3iOSUVS0OtUkoJIe0EmB3Aw6KU+fYN5fkoAJtUurR/v1VvFBI9Ho/UoUWVVACXjuWDPzcJS6pvwifRHQyy4nTXA1En48=
X-Gm-Message-State: AOJu0YyR7dVckNguMo7er1C3hWsCfbY4OVSx8WeU8S/C2/Yg5YamFsjn
 8E/s/krTZmHa/C1ugc9VRyd5agvTvC0R53FoHoJcpQbicNjuso2cmjzQXzc5zTE=
X-Google-Smtp-Source: AGHT+IHoH9kxJqHDoQ1LqYW4EIGYZduQeSGxk0s3UbxgQvapPxjCZ1oxZ5W2yT0kV83XpSOLLaDgag==
X-Received: by 2002:a05:6358:e497:b0:176:d2dc:5115 with SMTP id
 by23-20020a056358e49700b00176d2dc5115mr9572391rwb.20.1708201671007; 
 Sat, 17 Feb 2024 12:27:51 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 t4-20020a62d144000000b006e3b868b8b8sm738940pfl.130.2024.02.17.12.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:27:50 -0800 (PST)
Message-ID: <5aff894f-4c83-4a8e-9a3b-84c7b844e158@linaro.org>
Date: Sat, 17 Feb 2024 10:27:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] {linux,bsd}-user: Pass pid to gdbserver_fork()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-6-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216130817.369377-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 2/16/24 03:05, Ilya Leoshkevich wrote:
> The upcoming follow-fork-mode child support requires knowing the child
> pid. Pass it down.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   bsd-user/main.c        | 2 +-
>   gdbstub/user.c         | 2 +-
>   include/gdbstub/user.h | 2 +-
>   linux-user/main.c      | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


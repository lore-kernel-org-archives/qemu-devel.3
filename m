Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B3ACCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEAQ4-0006LQ-VD; Wed, 29 Oct 2025 13:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAQ0-0006J6-Lz
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:57:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEAPq-0006jl-1P
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:57:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso100744f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761760610; x=1762365410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2V822TFvbY+NBxCS/yBTmMmzRXa9R2+PR+4CeoavUI=;
 b=BrcnoCKGhOqV9rrEh6HMFLKI+6ArtAsazMxyywAiStX8P7uceLtxRc9E+wjBODeant
 /Veyg5VZdju8Vy+pcW88J9nZsFpo6GXRUcEgPk7gYQKj5852oMkhydDTHuC2GKAg0d04
 Lb+iHRBOIoqRLQucOMQ/q4usRil42RyUX7qSqqQEYTDhxLKpsi5KkQH0e7+rtXU7o4aR
 LY1BR1rjemRUN/4B1XWM750Qy2kitDgJxukSDxCV4nMigjKbNsFxURzgfWaeN0Vrxs1H
 dEBb2I8t1Tv84+43lDS2hJXosRsEG53moVITGuiL0DjqxRxvQStFzBEcNfVgjhqPCD2G
 dcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761760610; x=1762365410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2V822TFvbY+NBxCS/yBTmMmzRXa9R2+PR+4CeoavUI=;
 b=JGubjufjXO3iKXFkRJEUxse7VoGNAAwGMEje+fUkVaDU8mHBzvLznLKYyVaRtC6e2J
 n8lBlXdoclyp/wkE9MtPFHjWAR7Oe7pBksUl20bSoCmJEz4StjllY7Kc9g6skNZNCYF4
 xXNucHwvqR12Og8gWdphu41dFvLdZH+puQPzWzS9o3ZZWGI8MTvVEyvKvk9YbKs4o0XV
 VIE1QFeJr3veQeSdKSeV51Ga2Y3HYZp6BJ/+bfhYcYaE+OAfdrPgKryXuTqUH6N1ihU9
 4OfBHCZ6g33YezF0ubk3mbx6tsd8TziZ0Uu2FS+e6tYob2KQwDejQsngiQTTZ6rVHxZz
 IhdQ==
X-Gm-Message-State: AOJu0Yy24OONaJCUgU9LH6w2TFzc1T4c+15NPTgK1aBPyloq/QAqr/UA
 ferePRMFsUXQ1eZhRXxd+gO/FjG7UifpRQWMzotPG1l6PeO03vxOKqxJXuqjbqncx3St6bMpRUh
 cs/b+kM8=
X-Gm-Gg: ASbGncvegB7btWwgGsCyJoce5H045rFe5GAV0eBXcmriBNNYqV1Ey5JIlO9tfDvxqpc
 NphjVktyBLiCAt9DwJxRzKwY+9x4bTZgmm0n1rJHC0BPIdBO4UmbfBXeIxhv/tBCGGlzXkcxrlv
 VuGxPEn+Pv8IHlbhcyQekCqUh8FHDSGpRJeGBSaqGt2Ps5uv/Y3tPDKYxuPrf4uoqflHHOZ9FSx
 Ca2jqBHAEf5lp4WK4J2+nfXQJehywF+iogcoMF2ckdcjWnjhjLZCpfmvvFumIlqlNryoc3NHl85
 q6cuTmoO1NWF0gnZxK4D8QrVa5Zutp1w2rqJUTmdXawCi/pH90AXGiNP+yNQ/ymvuxclmK/4Xce
 +bbhLbvc4ZNrwBK2gEK67Qfnt0YwKATrWWOJQQQIfzqua6KaDQScOXpfKWIhlq+zlkFROaQA5Bl
 A56BX19k/47lat5d0ZaQYfB4qfJmhxiDgEMxmzSV7ZP4ozipin+ABjoQ==
X-Google-Smtp-Source: AGHT+IFfjbOHKm6CBjOyzfTpsRFfbOWoyvaYtvmUbcagBG9QE3JgYEbGn9N/9ccSLrcaSW8z77bQQg==
X-Received: by 2002:a05:6000:2f8a:b0:427:6c7:6703 with SMTP id
 ffacd0b85a97d-429b4ca57bamr388302f8f.63.1761760610146; 
 Wed, 29 Oct 2025 10:56:50 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db9c6sm28019582f8f.36.2025.10.29.10.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 10:56:48 -0700 (PDT)
Message-ID: <5e4627f8-ae34-4b02-8540-a8fc008e0816@linaro.org>
Date: Wed, 29 Oct 2025 18:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/tcg: Trace tb_flush() and tb_gen_code() buffer
 overflow
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925035610.80605-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925035610.80605-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/9/25 05:56, Philippe Mathieu-Daudé wrote:
> Add trace events to better understand the changes introduced
> by the "accel/tcg: Improve tb_flush usage" series recently
> merged.
> 
> Philippe Mathieu-Daudé (2):
>    accel/tcg: Trace tb_flush() calls
>    accel/tcg: Trace tb_gen_code() buffer overflow
> 
>   accel/tcg/tb-maint.c      | 3 ++-
>   accel/tcg/translate-all.c | 3 +++
>   accel/tcg/trace-events    | 4 ++++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 

ping?


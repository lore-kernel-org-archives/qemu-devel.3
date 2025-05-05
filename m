Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C7C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBz4E-00084K-8x; Mon, 05 May 2025 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBz3d-0007Y2-04
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:52:45 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBz3a-0002OB-Sw
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:52:44 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5f6222c6c4cso6735982a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746463961; x=1747068761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FImkIypCDpyfTgrDHFbuhhFYZtgpyf1V81QuGy9CyI=;
 b=kj1qUf5bhs1UwySulretk5r4Rq6vUZ8NB1ySl7tzTW3hmj+FMJBPPIbIsZMZ94+Tpg
 dO8kFB5GAFpT5SlUlttvtSso5HnZrBZzKjKa1K1fNUVkZ+LXule8CXBALkac6J728S6A
 vP0f1qWMXFNy79OPAk+v427WQR8/wiX0sFgGCJLQtIhTeS8eIufazBj+YynVBztfGJqU
 0MGZR7rRJSbm5BWodac5VJQZ4lUD8BGSI8psza44YjWTrGhYogNWC0OqNC3A51YodH19
 zPYOGuW7xKtCx4TojHaE6Ppz6GGTkbjfRoqeCVEN0Mz0WDdctH7jEVwfDcDComXYN7GB
 SWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463961; x=1747068761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FImkIypCDpyfTgrDHFbuhhFYZtgpyf1V81QuGy9CyI=;
 b=HtkBXRHW8j8+8L9byUbV82SB0ScUT/ZIxd8BcYLVMooifwBXv/lt1W5isspQgsiqHo
 d8vxoB8BVbJnPLoFsoVNFzauup/NEsthtbU2OcVu5XAmae1NyGfKAJUVA9Yq9DPuB22v
 Q+eYIQgLUupiSeuFAikUFYVFFWQbiETV2B/A7RVhvvOSToZLNx77PLxYcpwoik6r7yDo
 Ao9Sd013U7ac15Srv5w1DUKTUTNB6EYAf3F2/Wyd4GR5qRHSR622Gbdglj4VY9/BBleF
 P0hT8gXrPlBiuFg8OgOZ6enqnCBcEoZN84EhNN7BJ7ZTARPIsDNlC6JkzRJAJMD6Lxia
 utng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAMOI0y5vWHuG1aFxCPokwzE0y0c51y4pjl9Lhl3FDq+8NQeFcMmmaqlukJ6wpTmSiGHoKwdjqz0KT@nongnu.org
X-Gm-Message-State: AOJu0YwddEKla01d4tVf1A355VJb1sF9FkeRNCnaE/Fwb2N/cErCASIr
 tmWnlFyPcS42S/YKh4lKbmcO3XJXh8iwbgJiDDMUf/VIH0kVELkxwTIx7YE7YFc=
X-Gm-Gg: ASbGncudUc8lYrEmT4dVCvF5iXZyKOoA9N0KUm3lXUtLpRYGJt4KC+cx+FGzkH6iXjR
 jcCLH8fTv1WcDffwjT9QuuSqJ0O6uzEF+ntbzUZOBd/T+639r9Rhf4lRhEYsJvWdWKvXTDYcNvZ
 lYenLyFSoAXsHwEv2/S1YsAjNWnRlyBv9FHWrTEXGVe6mrSiZ8B+MHrQMQxeLueJZ/4r4LEcm6o
 DxV2phZKliV3RXeaXBbCRAJNJZDXGYdmMEjDP0Ee6kz0vwNK6bBSz1tLi2iut6Sd7fIOqqKhBoB
 eEshCktBH2x/ypDQM1U/bifSFDFhsIDdvLi3du9IXw8+D8ae1xoiLArioZiqGIcK8Vop22GXuk9
 Q
X-Google-Smtp-Source: AGHT+IGJrkULD4ymQNkp6HvrvX5uFQNx8e/i8lsnPKJutkTwl23DWH0u5AfvnVSAthWDndLIsviMmA==
X-Received: by 2002:a17:907:c389:b0:ace:d95f:6582 with SMTP id
 a640c23a62f3a-ad1a4b3609amr635080566b.53.1746463960931; 
 Mon, 05 May 2025 09:52:40 -0700 (PDT)
Received: from [10.194.152.213] (69.21.205.77.rev.sfr.net. [77.205.21.69])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a3c69sm520829166b.59.2025.05.05.09.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 09:52:40 -0700 (PDT)
Message-ID: <35f13b44-52c4-4383-af84-5e6271a50117@linaro.org>
Date: Mon, 5 May 2025 18:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] target/i386: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check 32 vs 64-bit state.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/tcg-cpu.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



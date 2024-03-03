Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F2BC54798
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgba9-0006fF-GJ; Sat, 02 Mar 2024 21:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgba7-0006f4-KP
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:28:03 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgba6-0006Bp-3B
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:28:03 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso3177988a12.0
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709432880; x=1710037680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XXD+enmUEVU2SApJ7cc9SX31pWsl46RlsYAeVBo44Y=;
 b=GAOu9A+0in2/helgrcrROn3wkYXQWasb1KehkFm9smXuUOY4p4E6rMM5T5zPKFe3dx
 llt2HJyU4XtvrXebI4P3wnxmex1Ef96olzqtCsgUsr+JQu5HBjXKRnJd3qzp8p+KCHhN
 N5KqROnIXtoXgeS+tWwRlBuGmkMfUeSQQnHV1tpoAXP/7JdjQPT85Q+VqM/FE+PCJI5f
 5JDXdOPEtrQPdWhD6gK/bE5pt+m00MTHL3VuGdQmnXOdLL6srQ75oxss5xa8iWjNBGF/
 F02XERdeSVCLpqoLNrhYFvrsQgXfzSOZmJa7xNLDWWJ/+yKB0cV9E7H9ValJQwtf8JJa
 H/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709432880; x=1710037680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XXD+enmUEVU2SApJ7cc9SX31pWsl46RlsYAeVBo44Y=;
 b=BHbv6TD0HLIbBx5jVXzQf8eV2l3ETjwbRk11FYg7e/tasSHWE6XFOL9/5AG3YrtzYQ
 xErRTWih0I9GHw4B62tmCRFcB/p44FI67u1+HeO/h20gq7/9pPStpAVTS6EaJTX7+Hl7
 Lz4Y2HEybcKUw7eeE/fdszp3R1EDX0qVx5ZKPdQbrUaLNaQ7zGa1G/9zHnxuIN4bpmB2
 DBqL2EvCi2ytJD16kIknLd9GWib3zeqm78IAFaFIDzbrP4geTzPn6LSsJBxlHNqakKq7
 usGNz7AAS2VXK9EyudGP9lslsJVALuichDKMNp4JLgH5THUwok+BDQYql/NyZjRqlbpc
 6ArA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsroHger2yfzRo/+GXTHkiEfQNrPHSJqAlpPTLgD44LDrCgXIpt282acRnXdPBQiH5NTBKiD0a7CK43nhzGMRP06hzAiA=
X-Gm-Message-State: AOJu0YzBw6FkpRP7eGDmTmqYrq5Y45idoVvQwV8wogVeIi1ryhLnsTXj
 1gW1iHiS6oAFGUrOCj6+95eJO98t+ql1Imt1KQ/usZ73YUp3CGdSsA0sz39ntCM=
X-Google-Smtp-Source: AGHT+IHx9/Cy3FQKBYyNLZ3lSgBeh8GRVR7wnxMy5PrRedzDKM/PHI6B+LJTEidHG1EdA7cIcjKltg==
X-Received: by 2002:a17:903:2409:b0:1dc:a605:5435 with SMTP id
 e9-20020a170903240900b001dca6055435mr6060350plo.31.1709432880635; 
 Sat, 02 Mar 2024 18:28:00 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p6-20020a170902b08600b001dc30f13e6asm5827636plr.137.2024.03.02.18.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 18:28:00 -0800 (PST)
Message-ID: <5b08c6e0-7242-4b87-908e-e13c8e680b96@linaro.org>
Date: Sat, 2 Mar 2024 16:27:57 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/hppa: Restore unwind_breg before calculating
 ior
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-3-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302223524.24421-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/2/24 12:35, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> When calculating the IOR for the exception handlers, the current
> unwind_breg value is needed on 64-bit hppa machines.
> Restore that value by calling cpu_restore_state() earlier, which in turn
> calls hppa_restore_state_to_opc() which restores the unwind_breg for the
> current instruction.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Fixes: 3824e0d643f3 ("target/hppa: Export function hppa_set_ior_and_isr()")
> ---
>   target/hppa/cpu.c        | 3 ++-
>   target/hppa/mem_helper.c | 3 ++-
>   target/hppa/op_helper.c  | 3 ++-
>   3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


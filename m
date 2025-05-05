Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48077C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 15:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBxIn-0006OZ-Hk; Mon, 05 May 2025 11:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBxIi-0006LQ-KV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:00:12 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBxIc-0006JK-34
 for qemu-devel@nongnu.org; Mon, 05 May 2025 11:00:07 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so763879866b.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746457204; x=1747062004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxhLTXmJ0AJQAwAnZJU2eDKfxi5IxqiJLmQpm7J5aNc=;
 b=Uw6D2R0MBQ1PFGnqjwhHVTrCo9RZSmYqzpK9vuGyjbC5eSOSujabDfSRQSa3BjYF80
 wGEpn3xaotAakAG9cAKqWOloFyx5GIxwWagJO+0Ggi07hc7fvwSbwh+TV9Hi5V3J8VhX
 LMeY0Rba9kKGaQRCNZnVbWLuNxtnIDZdwwsI4NQyaON5EAhkYYXC6f86wfAe7N/pAeIT
 m943khvgc7TVBBdRJFNc6ICLmiFUaD4Smt8aOJH7ugIqz9gQgpNlnn1bWJlixbFHYy5i
 XczrpWSxyoGTBNvZZCJS03H2PY3DAA/WvAsYi8/HDet5mEqrN6iLECX78IW0K1IvTnvI
 t1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746457204; x=1747062004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxhLTXmJ0AJQAwAnZJU2eDKfxi5IxqiJLmQpm7J5aNc=;
 b=tSWNY/YrlmICSOXwWf7jhucy5LQi0WF7YDDZWGuL0k6/4AjCp8bTNv8vXPm8d8kvh1
 sXgl2Dt8cPVR9ZPImAC9q1GgNi6MHBY+rVKFj9yKP+cHj0ARbHNpR/aRCmcz0yzbLauX
 KRDp3V0cBSnpwp8esxaDK+VGh5yDkLvrkhxJF9L4z7OsVawDtdCPudep8a6+2dZjzHmQ
 p4fcgg/okxMxuL+X6Qv3E0eJ2aexVVsjSTrql6/QgbCk7WAGKM/b7M/TCRsCtgkJRx9m
 oaW3g+PieL0Lfkf89TG/36K4A+1ZDzBQGSzaHYsgZGRfwDw0HT7jJPoJLtkYUMaGeeyF
 A8mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0v0VHZZNVXNmsLKNaV7SQ0/EvR0Qo7KlqvaNbmRECprepkEwPPTpf0PAV173IQqG92wlZR4apjIxz@nongnu.org
X-Gm-Message-State: AOJu0YyevfYGEb0JVkewKkQFps7CoHbCUFSdFaIcz6z6mi0H9Fl9nEu1
 TaSnPBT5//pZ0JnLJX30G5XZe4RoUybQnvzk/OVaeCRKzBzhw6peBCx9lMC0CrU=
X-Gm-Gg: ASbGnctyxxTtCvhor5+Wv++FONLNwivTc+0QgU3sMQtemc4QJOLD5gwEXkMOT496AB+
 bmB4BwyZmxVt7clldjcOplb+jkSxQvtGl+13cNaDKDTIQh48Fxc/9FUJxGsELimm8slbOFoLhF8
 PFRU6gvWS8AKT/rIQLSJP6a5JcwHXuI8afR5XJyvAD6g9s/tqHXTe/8Z7uCrHLCcDkBFx/33h2h
 JzBJfCwV0ZRgjyRwIPWnWI0vjDNVCo7iPnfwyTzKjs/YlRDW9M0kZ+H06drActykOtM3YYy+HU1
 ZnfGhnVVmqW9Jwxpde4Yi3z3YlmbNQ5MRdiMqxIPoxqRLZbZq5iDrPTowf5fkvpGzN7/syLUR/z
 1whY=
X-Google-Smtp-Source: AGHT+IGOntcp2l3f3Nm9fhgijCDbbZLcb+qL63wWRkH8KANa1xS30JcpaW7u4IaTjz6tZp/vB9SK1A==
X-Received: by 2002:a17:907:94c5:b0:acb:32c5:43ff with SMTP id
 a640c23a62f3a-ad1a45beadcmr688074366b.0.1746457204050; 
 Mon, 05 May 2025 08:00:04 -0700 (PDT)
Received: from [10.194.152.213] (129.21.205.77.rev.sfr.net. [77.205.21.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a2d87sm503791966b.45.2025.05.05.08.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 08:00:03 -0700 (PDT)
Message-ID: <c04dad69-7727-4e16-ab19-6f8188e3738b@linaro.org>
Date: Mon, 5 May 2025 16:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] target/mips: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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
> Check 32 vs 64-bit addressing state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



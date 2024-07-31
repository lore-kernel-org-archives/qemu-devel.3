Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EBBC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8k1-0004ND-Mw; Wed, 31 Jul 2024 08:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8jz-0004IU-Cq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:47:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8jx-0006fz-Sc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:47:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so5312705e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430056; x=1723034856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yxa4PqNr/CWUA9AOOHRBKUGY6CKzSEVVdZH/iEs9xdo=;
 b=k5oGd41mBtMZDPUL0ie43oyhESaDJqyfkQdYo0J8ANq32VtuAUQZzo9KAV6qwunrWO
 z4LAnlm2kFdiBCA1rqMHNAKFKXKD/DYRi8n85wXXqgHp+mbgD3QxmnzH79q4FbnP8IKR
 odkl4KNjo+k/Sdlcdd0/crjNQLWY/Vyo3yBbVGEE4pOGPhAuaTGOIXmgjZWskwPxHdp8
 WeWXVntN9Ul/NX120iHhL2PLYGGHrbWtuoknUq2vD97fYhFDcebTvNrAdzrW/vgFP+nI
 n9Q9jwVW/XXWVsHjfPqjAifBVz+Wpnxm3Khu21UrMb8LQr+6uGIDUAA/gJnpdUR2yj4U
 EtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430056; x=1723034856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yxa4PqNr/CWUA9AOOHRBKUGY6CKzSEVVdZH/iEs9xdo=;
 b=eeKOVzbQc+fHdsWQt4RLsJazE2uK088sqUOeVAb1aMsXPRc0bHWbHykgRwYCPCvtro
 sQW3jRO6XZxWk7poibkgASIZ0raiUyKg+jBmClfPlz3dXj0PqErWF9dfAc1/8t9OBagI
 /sgY2zMaVFJceyCRqbFrE1IJVbegkxq2HV/RD71wsTr7PywBE3pRQOjVJmQcc7XftI89
 vlTo998HXYu8XZFbzBiN8z846N2dzjyUv0V9qzqqq847+bKFlHc/x6pP+V5D6/C/FuwK
 QnhCRv6FQ4682p82qq2RrobogUtMj4IwZi6+wKgfeWuraDpbJKB+QAF0BaoHZjG7j5Kg
 HLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXYFy4IXqU9tq31L2sN9nBSPCO2k7sCt18SdNZoo1k6+T9GjFiWimIOaXSM4+IAgVwG5HT9a+LdtPcv1uxL+iQuD3XnaA=
X-Gm-Message-State: AOJu0YyIA0X6RZ2nT4cMuig/QOu/c1uujoSXj6XU1kJNQMQ1c6Thq3TM
 uYG7FUBRuPceNUz5tNsLA144VCmZ5alNbq092WFTV1J/uVfi/lcsPWtT7MmGO/I=
X-Google-Smtp-Source: AGHT+IFlbgmyRB0c4CSYWUvzsKm+i5De0Xw17lb0vZz4HrSCKokvnht16yPIt0crlAN3T4CcM7TnFw==
X-Received: by 2002:a05:600c:3b17:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4282439538cmr38229135e9.0.1722430056005; 
 Wed, 31 Jul 2024 05:47:36 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282f382abcsm2930395e9.1.2024.07.31.05.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:47:35 -0700 (PDT)
Message-ID: <470b5073-7082-416c-9364-292efd2c1d96@linaro.org>
Date: Wed, 31 Jul 2024 14:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Set ctx->opcode for decode_insn32()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240731100953.14950-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731100953.14950-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/7/24 12:07, Ilya Leoshkevich wrote:
> divdu (without a dot) sometimes updates cr0, even though it shouldn't.
> The reason is that gen_op_arith_divd() checks Rc(ctx->opcode), which is
> not initialized. This field is initialized only for instructions that
> go through decode_legacy(), and not decodetree.
> 
> There already was a similar issue fixed in commit 86e6202a57b1
> ("target/ppc: Make divw[u] handler method decodetree compatible.").
> 
> It's not immediately clear what else may access the uninitialized
> ctx->opcode, so instead of playing whack-a-mole and changing the check
> to compute_rc0, simply initialize ctx->opcode.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 99082815f17f ("target/ppc: Add infrastructure for prefixed insns")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/ppc/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



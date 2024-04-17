Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27204C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAze-0002u1-Pw; Wed, 17 Apr 2024 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAzd-0002ti-5L
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:30:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAzb-0002EF-J8
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:30:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so148400b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713382250; x=1713987050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6zKaSsUxtM3dKKWm9uj5tLtFiZ3ilY+cMnb3Cmwh780=;
 b=nNn4AlTWV1AgoyczmvOp2ljqRbDgQL8DYdzLrr8H0UUXZRKel9wUpxPw1nN/LlmlBQ
 Ei200eEnUQPs1Z/lee4J0z8e5Bjpzu4WHJuV8Uf2NASA3DPmpmUjfy2gO99LMkUpfzLD
 tFtMqiMjKs3DSbC4OCm7OGQbHXKObEdbBJrk2O7CGu0mfufJnxIUNM0QsqEY55lJIT22
 4O4KIcQjOV7Nt4tBiUU1SqHRvWgWHfOn74KrHlZQU5aqr+bVbZr+yFvGCCixA2rzrFmM
 C/4QY3YGdw7Q10uCcAiqJikNNR0j+qXDKiLTGsrv5oFutuCZWCeEh4kx0nCKENwjp9wF
 OlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382250; x=1713987050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zKaSsUxtM3dKKWm9uj5tLtFiZ3ilY+cMnb3Cmwh780=;
 b=IxyL/GzlNR2lhS/hiYqUQ/Eo3REHPRNTn1vo3eKSlvHaq2PH6DMKBW95ks26/zb0e5
 5CWzOfLQcnVkY8goqAbczXpKpUa+u1iqGqddVUbdtX38g8J/TpBXcf9ulD4AT9UYGfOi
 mJwN8s+QQPvyp6NOPsVB52V3WyFC/ZkpyVkvW5sMe3m5LzwWIbrrEmA4+2irMTXud755
 zFR56APWyRemX3YMRAMWMs1l+wiSvm1+VF9cM4iRlgRQTvDRqyOkpy4Nl8Z0FP1DK/Jg
 b9a0xIlAxt8xOE0f0M2FopR9TmDiLPFultV9sxVmFvKRNPt2zLvwElHOzb9s2r1+Ujqb
 XPdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK3SjIbVmPaCR46f3nZRih0Qngo24eF/Mzl42c+8CTdBdFQlkL9RFvx46Cur/KtcDNAuXA0PznkQjW9xR2dgukofzyVEU=
X-Gm-Message-State: AOJu0YzKiI9e+vHhrXnYlBeqThhOlRfbi9wRpTyUB3puxoEJAzKNlaDM
 HFP5sqxTx5nZK5I4YEsyL7B9NDvZyESv61C9RVy5QCxr4v0HJj76vfPRibtwb5A=
X-Google-Smtp-Source: AGHT+IEPoGbzAxSUJRxm8r9JXKFBEEzH0RFjWZYs+Wtw2u6Zq4KcX4J3rj+zG2I1SabfU/qNw3x04w==
X-Received: by 2002:a05:6a00:a19:b0:6ec:df4e:96f9 with SMTP id
 p25-20020a056a000a1900b006ecdf4e96f9mr705099pfh.12.1713382249937; 
 Wed, 17 Apr 2024 12:30:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a6567c1000000b005ce998b9391sm9166012pgs.67.2024.04.17.12.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:30:49 -0700 (PDT)
Message-ID: <f86171f2-3604-4da8-b07f-8eacd2489be2@linaro.org>
Date: Wed, 17 Apr 2024 12:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] accel/tcg: Un-inline retaddr helpers to
 'user-retaddr.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
> set_helper_retaddr() is only used in accel/tcg/user-exec.c.
> 
> clear_helper_retaddr() is only used in accel/tcg/user-exec.c
> and accel/tcg/user-exec.c.

Typo here, repeating the same filename.

r~


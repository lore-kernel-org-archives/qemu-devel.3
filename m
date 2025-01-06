Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB1E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUvBM-0005mr-Hc; Mon, 06 Jan 2025 17:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvBK-0005mM-Cu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:02:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUvBI-00073z-Na
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 17:02:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so106590895e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 14:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736200958; x=1736805758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RY8sOE3ZoEA8kPEJmoKoP0R20WqR/mF8LvQBtm7eKGc=;
 b=WfQGs+B3nn8ydPwqNJDCklreAZrrM1Zf5eT13nSwjzNOd1oSTSxD6By501FadwJPFI
 Hu5qEoJ5T5nr42ozLuANi1AJUI/oeYuI89RxGMuGDXcH5WrCIIl0K14C9JBaRnCXv4nC
 pvxftEgYdAv5K2hjQ8rysYhQs/CXR3BBTH/QC3Ge8Opgtwr8xL1NiPlelZDqmx6cOdSq
 HJR3ncr5snqwVZkm5ksnB/LgJPVOPjHMHQLH9JrcmbmSX6vzHESABraQvfxiog8aHvnG
 mq6/547vlE43dNXecpJJhdx+X501gEwnuoYAnGrOkgJbk8D9xa+fPGaUxhIcMeJ9Uu+g
 6N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736200958; x=1736805758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RY8sOE3ZoEA8kPEJmoKoP0R20WqR/mF8LvQBtm7eKGc=;
 b=vxhPoT2QjUUrFEjogLrPL3YVet8B+SGCbBqIGKg5Vai9+cwAbEQwRYvVnOTXWChnoD
 V5g3dvq5RbI2iHWNbPFrxrjX24AFj3BE+MK7kna5L7Eu/pCa++2z95/sl72qMvcUIsjU
 dCwxr7Y7EtMR8MTN8wP48QdNTYf/fIcUuPsfppRMG5VlyvLRGiGkqBfJ+j3LVe7J1/Am
 NKoYnhyb/HVhMUZlXwtNSiGROUiW31/lpwCU0JICg7PpBkECdXNhaAc/0bCnBiWLcxmp
 4+oRiLWzhFIHuN6m1eHV552Szqo9bb0cZsk/6K5MV9aFnFTWk+Qe6hYVm78eMO+lcYO9
 sPeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm2Lbb0vGXYmcuJ39ug4RmVgzC/7OkTPOXmhYD0Xb4o8Uuu4s8aywGr246zGhzfjDqsGvgQOLtXnD4@nongnu.org
X-Gm-Message-State: AOJu0YzIGbaskallFuv7OmTT+oB2ZOV/tSaABMDOiF2df/qPmiexay0s
 phnBXbwHOIDUtZ5znTNffVx8Mpgk3DlQv6CmTDjB3dG85zhp2Fo125kf8YI6vJFl5HMvU9ur35j
 QLSI=
X-Gm-Gg: ASbGncuJffN1ptg/2PiBRFpcTBgQkw+7Cu405ecqqmYSdWL1a/FAspmBZM7iZ4cfoIz
 fSldkSMdy+mjYYI/RWxlvstHZq335W7Yf1zzz4+L4JZCX+A79L3G0pA/6K0QYMGFJHZGytsRhGM
 y/e1kbbwtxNenp+0nahI1uxfGZSUHw+Gg7/tLqqeHSPjunA8lYTyQSQayye8if1YKwwxa+t2rCg
 7CcHTfvU0+Wh66FpXTwY4SNCSXqZFT5RBQDakuSfy5E7OGZovu7EqOagaW2BdDRM+JY6iA4SJAW
 8sDE15in6KtvYbNjv28bsJiS
X-Google-Smtp-Source: AGHT+IETw2IiqeBdQ9jqllx3n+7digostXudWcQS+PowbTGiIfgbf4Nce8WVRzbtcs3su84XZPfcuA==
X-Received: by 2002:a05:600c:1d03:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-43668642e70mr472431255e9.8.1736200957946; 
 Mon, 06 Jan 2025 14:02:37 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea47asm579245105e9.4.2025.01.06.14.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 14:02:37 -0800 (PST)
Message-ID: <0b3567cb-559a-4828-a93a-a6d3a7da1235@linaro.org>
Date: Mon, 6 Jan 2025 23:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 53/73] tcg: Use C_NotImplemented in tcg_target_op_def
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-54-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/25 19:06, Richard Henderson wrote:
> Return C_NotImplemented instead of asserting for opcodes
> not implemented by the backend.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        | 12 ++++++------
>   tcg/aarch64/tcg-target.c.inc     |  2 +-
>   tcg/arm/tcg-target.c.inc         |  2 +-
>   tcg/i386/tcg-target.c.inc        |  2 +-
>   tcg/loongarch64/tcg-target.c.inc |  2 +-
>   tcg/mips/tcg-target.c.inc        |  2 +-
>   tcg/ppc/tcg-target.c.inc         |  2 +-
>   tcg/riscv/tcg-target.c.inc       |  2 +-
>   tcg/s390x/tcg-target.c.inc       |  2 +-
>   tcg/sparc64/tcg-target.c.inc     |  2 +-
>   tcg/tci/tcg-target.c.inc         |  2 +-
>   11 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



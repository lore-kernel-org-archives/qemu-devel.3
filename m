Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5544CC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl1Gw-00025J-KG; Fri, 15 Mar 2024 02:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl1Gt-000253-0P
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:42:27 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl1Gr-0005KT-8Y
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 02:42:26 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59fb0b5b47eso601922eaf.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710484943; x=1711089743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XV0/rfi9+XnuHPOrvt5YSLUSgCjiCBnapvaJA46FE8k=;
 b=huWRB/DpVIscM0lzzqqcZuL3Sj6TWD0rNfiyFho12O2eoAUkBxHlJCIOYiCR6Qutgy
 AB8TOxiM9iZ+c0k1C1upFwLHoTADLDJzplgtbPmwtStnx72vr3YbZbutYHML4LQGZI3s
 oIlRG+2d6HvHpTCj8DhDshnz2bKtlsBY9HkUpqS/pLCpbcZJN1ubESVre6+M6WW9kkXt
 3xUHt6DelU/Out3Zl02EMZxzHlDPdr9jdVtCh3JnGl3utLdic6rm8dEJNhbY3+1nMnKn
 wIrjZtJXTbG2zpo553LAWQi1m7uAQzuVwStYgAdgkJHSE6C2EMinFUZM9Nkgs60mBtB1
 S8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710484943; x=1711089743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XV0/rfi9+XnuHPOrvt5YSLUSgCjiCBnapvaJA46FE8k=;
 b=IbWohA3MInaifzLLyi60DrUuBU/90g7bilqF2FGH7JRULHuVZ0CdT3wLM1Ouw2GOSv
 z561gzBiIICiuAInxBlUaRp1HED2gCxcZtcomrhPmpZ21ELezyQZIOBMYDTGG9oyEatD
 qtOIXVFo5TFSFxoUVZGky8ZHi58TBZczVnn8CcnXkHrLIzVBcvWt6vfN5cn6jLArrelO
 VJHCGN4PvvvNtx3/NR1lFPd0pVpX5g3YKD4MIjNUKJ9+m3a7FPm9MNK0ymBmoWnfzqMT
 qzPGUcTNFdfZDB9SHzMScl56FE32aTaNLfe6xMsvbMQys5gic/1vE8FP0fN5+joH1bsG
 z28w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUYi019tP0k2cQ/2+ngZRgUeXMJlrY29azGt3Ybb7Ph0vqiMSWietFySIWKBMgrl2RZnkn3d+jVX2Tegc7DeTOUCvn2qE=
X-Gm-Message-State: AOJu0Yz0aoCFtQkjyJ+pRcmNOUf0rtYiucVofjWl0hsKMUvv6hUZgu9E
 7Y8T2p/LDZnMEYEElhvCIuy0wn/1dJe1athAhkU5QX6g4oApeVjjF/y9FjzhwKI=
X-Google-Smtp-Source: AGHT+IH1Q1qGVgomlDchiMaPkPmrwpvRXO7EBDM30O4WKNb8AO7Y2MKtKdiFQLjt1gF8S2Wn/oPf4g==
X-Received: by 2002:a05:6358:2799:b0:17c:1c76:84b1 with SMTP id
 l25-20020a056358279900b0017c1c7684b1mr4735979rwb.14.1710484943114; 
 Thu, 14 Mar 2024 23:42:23 -0700 (PDT)
Received: from [192.168.0.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g20-20020a63dd54000000b005ce998b9391sm1785164pgj.67.2024.03.14.23.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 23:42:22 -0700 (PDT)
Message-ID: <fbca036f-ecb9-4b14-9c02-73d85b6de0af@linaro.org>
Date: Thu, 14 Mar 2024 20:42:18 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 01/12] accel/tcg/plugin: Remove
 CONFIG_SOFTMMU_GATE definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> The CONFIG_SOFTMMU_GATE definition was never used, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


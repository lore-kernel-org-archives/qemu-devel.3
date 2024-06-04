Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUP3-0008L1-Kq; Tue, 04 Jun 2024 09:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUP2-0008Kq-Rr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:40:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUP1-0000uS-0b
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:40:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso25061685e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508437; x=1718113237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjISUfUS/Rg/ial7u177DX+eWX2aSQqxf+OHlB3xl1c=;
 b=HjPZhykCm6chxR2aedWG0lHK4CE87mwbr01ORAyFYOq+ftgnQnwoyZQg050KqG7wrW
 pwp2FhYUS/2fYOnGJAZp161AvAsHg8M7hOeAYBr0p1mx6at/TNDFA2LwLEOPtzIaixfq
 hmDNQOohBW7vyY7agxTUGwqSzHnJ4BiuvfR6krqlZdSzz0YNypL+bbDzHHMiTrAYk968
 P7DT6qYlYeQeCP1LyLFHRPFUSHgh0//1NlM1m1CocdvXmiijb8zIuAyS7KVtN+RXFpJ7
 CT1+DH4ugOlumNZLs30wdvR7Iv3o0nNZxbg4uOb0DCkMrc/Jr6+IJVquIDzFMfPRw/PJ
 frsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508437; x=1718113237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjISUfUS/Rg/ial7u177DX+eWX2aSQqxf+OHlB3xl1c=;
 b=coRHEbbPyeV5EavNgQqCOp69K893168vjFzzYhtph5Tx1UN8EQKx2eDs5Ip4943wM5
 mDqPBbJ38C+fk3KG7W8tGaZZ0KcnapxSdIdbo211ysPTeHsw1v3p6tWYjmEws7D/PUkR
 VGIOudpoEG6uqx6PGWai5a1zuB0l7SDF5k5c1Ty3cZfwZQCtqiZbL/3zQaTKbDtpYGnR
 Sy3hmsy0BD08uv9/dB/lizR+m6cEp6WSRtGIoQzIaVqAUCx1UloJ2PA1LQzc6vtHb0Oq
 6EfxsKCCBS+21tYTImmORn3LMAFHeqlxwxPcyKEv54EhCEssebeO5qQI4Qdw7pGy54W/
 qYFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAX8x/Sb0h8T69vATfcp2/Awz+QsKYFdW6HxTyorLR5ljCgk354kfqVJZctz3OKOwzoZslZ93/k5S7d00D0V855apj3c8=
X-Gm-Message-State: AOJu0YxwKw05nigNh1waB3zOHgsOmuBVfcd/Dal6CElrhRhzGBeEwj5B
 ZpbAXODE8+dXzHTYVT26TwCBrEJYw4XtIJNAq3eB0rfZ0/ZKzy/15q8SbHjcBqs=
X-Google-Smtp-Source: AGHT+IFEmSrXXmwgPJs/44H+1doMLgqLv7b+2XSJkTvzDCi3cbzJBh2bhTD1bUQtUghjHmuSY75hVA==
X-Received: by 2002:a05:600c:3b28:b0:41b:d4a3:ad6a with SMTP id
 5b1f17b1804b1-4212e05f2f6mr118695625e9.17.1717508437237; 
 Tue, 04 Jun 2024 06:40:37 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42155a3305esm1262455e9.31.2024.06.04.06.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:40:36 -0700 (PDT)
Message-ID: <31de9463-d88f-42c0-bcdc-414f61811d4a@linaro.org>
Date: Tue, 4 Jun 2024 15:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/37] target/sparc: Implement UMULXHI
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode | 1 +
>   target/sparc/translate.c  | 8 ++++++++
>   2 files changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



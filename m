Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC07CC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSP8b-0003bA-Md; Tue, 23 Jan 2024 17:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSP8a-0003ak-Or
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:20:56 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSP8Z-0000CQ-BL
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:20:56 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d41bb4da91so28038875ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048454; x=1706653254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KiFWQe73L9isja9FL5U4GGQ8oLvzi+J7vJEo5cSihp8=;
 b=Pqnac6NlhnWYBAgCTiNpaEOSl78ix5HcS8AgQiYOzrZAWBjbHtsqv112bwrJbnoIz4
 5Yu7hAMhkBNGTUT5JWD1Qeg7HZTzbCrVsmkWYccZ6ae6AvGmOlagbtPecsePEOU4KFPs
 ZiHZ0DpU66b2kaNLdcylRymHZD60MYcnxA2+JSgZ3hZzRo3QZ2UIHQnnlR5v6Kx6+IFY
 4wre4tizPifCPHTXQyVadIYP6ugr3KFULEhjkWnPgRFOcyq2lMEg5ObZp+8xv34OGCMm
 /Llkb8QtspMO2Xaj9uyg7dKnraHNv92OQwMOMldAKxtD/Ny41WpQZaZ+b1VoCbhHoz5T
 8HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048454; x=1706653254;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KiFWQe73L9isja9FL5U4GGQ8oLvzi+J7vJEo5cSihp8=;
 b=Gf1G/pKgml/I+jl8uwbZ/mJLWPJ25iyzHOfqnJ9Uo1sRsOJRiJYmb0lvDwRHgm58Aj
 u5HzAJ+rzQkWIuEdwHThAAMe9xzMQ3Xr0ozncR6h6/0TLlTQzLlyb8/ZqsKUAyRJZEMx
 one2SiCYlavT06z8XTKRRrIg1OwNG2zCGvZcm3LnQa+AkrUC6OSUf0AlT3GX1mvIGxdF
 tYiMt8DZ8QY+Y8qpn+bOQq6S/S7V49JQDkqHk7EUOhJ5ZZPFj/aSKvT4nTIBHyxfHsaI
 5eRjUEmcaFpVGSBMjEll+7dc9L/OOYGm39Q1LRiBrMqBn5bcG3GRnnNQgESRZXhiPHlW
 o0Jg==
X-Gm-Message-State: AOJu0YzwGpOdUVK2F69452WAV1xFq1oL0qcNaWK+woDDoUHsd5fFM5bU
 iYG/JFU9Z83QmWyz+Uc3XKqWMLhvVlKp5J2+HdYfVFLNzThCPE4bzeYheU0iVwU=
X-Google-Smtp-Source: AGHT+IH4IvaVkvNzD3tyqwETSA6ezghTYZ8CcKDz1oDC9pnU0fqCSLLL1gawcuknIJBbQQa97oPtog==
X-Received: by 2002:a17:902:6b02:b0:1d5:8c0e:2d05 with SMTP id
 o2-20020a1709026b0200b001d58c0e2d05mr4346615plk.135.1706048453789; 
 Tue, 23 Jan 2024 14:20:53 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902ee4400b001d3ffb7c4c7sm9288030plo.40.2024.01.23.14.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:20:53 -0800 (PST)
Message-ID: <c26c7b28-f5ea-4a2d-84d7-60345e6ca9d6@linaro.org>
Date: Wed, 24 Jan 2024 08:20:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/34] exec: [PAGE_VARY] Unpoison TARGET_PAGE_* macros
 for system mode
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-5-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> TARGET_PAGE_* are now target-independent for softmmu targets, and can
> safely be accessed common code.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


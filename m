Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 22:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scBnA-0002FL-JC; Thu, 08 Aug 2024 18:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1scBn8-0002EC-Tl
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:39:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1scBn7-0001Li-BG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 18:39:30 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-70b2421471aso1069213a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723156768; x=1723761568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VAzxzfdfvPKL0Bc9QGJ7yZhjM/y6z4h6EYmfcP1wmRk=;
 b=HtMCzgKybFqtBbg+wF9S2fkF2ovizgcHV8Fqw5g7VOwZPDWrXWXXy2faIneeyGp8Px
 qXEXP76ubUBQTK4FYdbrE5pHqUL2YmxoMat60Vw5WeZDf3t3YhsnCPRR+Bdyw1Cl93Dl
 FtZGkZ+zW7ws/8jxqX4B3yrK/kFyKw/f3f6e/JkU22pGptE/5beH+x1MA0T1jrBaQH+W
 NAmwImRpOVElhiix8Cyz00a5cCDFF4rbLn3uRiMQ5ip8o3EyKs5H0ja+noBKqf50nNud
 dfVRr30aV0gSe2GVUAh/vLZkIpIc8EyN05D4nKcAhjKoMLyW3rohe34N5Zt6KBKZJDDQ
 UINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723156768; x=1723761568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VAzxzfdfvPKL0Bc9QGJ7yZhjM/y6z4h6EYmfcP1wmRk=;
 b=v6IE27jCx3/2S/S6RKizduB820dWcFfJFV/bd/VNUH1VpbR2bq6JW7sPGmxRaUPzYe
 +ej1HKQsiuh+oiLj7vhEjh/VFVNYrTJlo6fTYICqrouuaqC46sICkAJQZ2Qa/xohTGjH
 hd+hVngfMxT3QBJa3xAnVdVGbZjg8SN/l5mlwTqpBlQ/hN6SMPgCZGFw8Z/LmrqTHu1h
 oaDxEx4L2LADWZ6boJd3wqM66lRCUqmV8WqjtR9j6uSWKDso4i3niWeVMrlA8JLmMrAO
 yaVTGo5G/pUNR5vH3Tqql/HligYVlsPXjskUCk4jAkBbLvL9B5UFSMbIYr315pXfnqtE
 OXyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLv9CttqwtHNjjDRW5ZTgFa2F96EFXsXXCNLSX4UEITQjhmRyZfoYpw9IRsnntMwgiTsYV46QcSQmo0I/gpyb/OQR9yEU=
X-Gm-Message-State: AOJu0Yw8LqYaUPZbS3tTm7lejlvuEzQTIRsVkD7VWK1ZC5XcLuIj9L++
 VfFZojLTlZupPc1iLdS/PqS8YX/GyURxJTKxbc+iKSUsCgsxkjKEOOJ/LsbWrCQ=
X-Google-Smtp-Source: AGHT+IE0qusO2vdD3R3fI5hMMtZ+MJ8sVNntXbkzfgwYxVWlm/wIX4pfUwxaVhR+srWU9UkEj09NiA==
X-Received: by 2002:a17:902:f551:b0:1ff:52c:34ce with SMTP id
 d9443c01a7336-200952d2b50mr50252045ad.53.1723156767492; 
 Thu, 08 Aug 2024 15:39:27 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f56ff6sm130518885ad.87.2024.08.08.15.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 15:39:27 -0700 (PDT)
Message-ID: <ed7c7a20-7d32-456d-9cf7-0b706bb07955@linaro.org>
Date: Fri, 9 Aug 2024 08:39:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] hex queue
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20240808034244.4139757-1-bcain@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240808034244.4139757-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/8/24 13:42, Brian Cain wrote:
> The following changes since commit 4c395ac42e55ff8e9fd4c992e351a04b10785503:
> 
>    Merge tag 'pull-tcg-20240808' of https://gitlab.com/rth7680/qemu into staging (2024-08-08 09:07:00 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu tags/pull-hex-20240807
> 
> for you to fetch changes up to 47f3361a3af9d709218038a23b8907525310d2c3:
> 
>    target/hexagon: switch to dc set_props() list (2024-08-07 20:37:21 -0700)
> 
> ----------------------------------------------------------------
> Hexagon updates: lldb preds, v66 CPU, F2_conv* fix


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~


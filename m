Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D05C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 06:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYgjz-00076H-1P; Tue, 30 Jul 2024 02:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgjy-00075j-11
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:53:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYgjw-0005Mi-Hd
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 02:53:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so22902905e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722322423; x=1722927223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/3m+twV2hKpEclg+agHhIxvSGVfR4ban/62bVi7xfPY=;
 b=HkCYEgykhg9/zuspzwJovAheZMmA+wkxJPvnAfxPB5IuiWbKsvtmIOLVEFy2+OH54t
 1uQZlIfA8EdfeFW3L1pu73Xlv3Qtdw5AljL3PjOSoKHGoti39EdfFa2mEQfG9D6at08T
 casNpJmzTDuy1ObX1qKSM21bJEtQMvV3jwS51g/WuBuE6BMowkTtvh/LBrEzNMUgT8w4
 b4MY/FM3HR20vxsdyoxdMmeLwEipIbN5MNok0McRKe+tMLa1QgYkSlqHYFkBw7Oy7rje
 RLwtJio8UvKTFgzZudEPTyEUn+5WRMowxgZ5U/JO9lNs91XQE0yeVv+NwbOM2xiM/ZvW
 1Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722322423; x=1722927223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3m+twV2hKpEclg+agHhIxvSGVfR4ban/62bVi7xfPY=;
 b=fOPY6g2dDy9l/y5F4jjSfVTC6G/oaZt9PmEls/T6C7HMcfa+rQQKr1D5xBHAO4qZRq
 tEokc32QXTEyTUbbJ1V4NCmk2aaxthJe2/TXl3VR+sCUvJH2UJhe2WwqGd5u1EgQR07d
 S4xn+tZjs8MocNI2C8Q3dDVAaypnPnhNGXLdEeYiwhGh1ahQcqTthK5zVWu9fgwWrklg
 37lnK9rIRIwOe9Xmm06wC9MG064cZWgkohh5PKOFOmxBYM9gQdVB+Cc8mCkM7dzu42sd
 UhUliwRetqcb/KwqJ5R2YdQP3PPIXsPEgovnpRc6HMbia8ukrIqwwbgKdFhTl4giEd1H
 fZ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsy1wsXwghzMhLJXx8vOtCg+zXLX1dOgDoLsbyM/7XTrcFOMWmwZea+2Pi9r0/w+mOsIdidzVz68PbLTHbAPJUUxWMqWU=
X-Gm-Message-State: AOJu0YwHbRBni+HpCvkWN79iHAtThu2VLCDLvDTJhVbrgt4qJtOR89zT
 87pcXogoIR/iytkA9hl6ztg6PQodCFAhf5XEqDo5gmZSlXEYunvIUKpluo7siBI=
X-Google-Smtp-Source: AGHT+IEatNWV5UD2skUeJyaIHDfEYyEdMUBrJDV/m35UCn/Za8Q5jLfceaHlM/gG44AxjNG3B+O2TQ==
X-Received: by 2002:a05:600c:4847:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-42811da0967mr68391435e9.20.1722322422605; 
 Mon, 29 Jul 2024 23:53:42 -0700 (PDT)
Received: from [192.168.38.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937348bsm243792255e9.18.2024.07.29.23.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 23:53:42 -0700 (PDT)
Message-ID: <d8add4cf-6b59-41dd-a5b2-60f77acb3332@linaro.org>
Date: Tue, 30 Jul 2024 08:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] tests/vm/openbsd: Install tomli
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240730011202.480829-1-richard.henderson@linaro.org>
 <20240730011202.480829-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730011202.480829-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/7/24 03:11, Richard Henderson wrote:
> Tomli is now required by configure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/vm/openbsd | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE63CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkrI-0002fk-JK; Tue, 28 Oct 2025 10:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDkrA-0002ew-GK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:39:29 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDkr3-0003wG-Av
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:39:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so108755066b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761662354; x=1762267154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EXt259YuBfadOH1lDpfgQiRnIoeCkfp8taYmmSXcWIo=;
 b=oT8m3F4w2b/0+HB4fgVgVH/6G6fY/YL/uWVbSoJDAjfV0L8Lg/v9PUd9/XrwpULk41
 jR8a4Lh9BfAiBEJE9Uk0YnEJjjnwf+290BjBS4SOyj5qnInY71wMgKn2alfD6e2edf6c
 YfBGUWndr+ZNYDxl+uQjL7I+VZAifWL7qe1D5GW064sDZTvpJ1SI2qyO3pxRtY9YS8ZO
 bCzYN3k0Q4wlvoFayTbsXFAJ88DkErDMpPIKTE7pUkt9IaZDGpTIgviY5dv8SUPtgrUO
 qkFKIIfHyzACLaHe4GZr4G4qxzIYdE5CIDF68U9kMI9f7ZqXPdONkRoCSi2vAYTlCAcK
 a7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761662354; x=1762267154;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EXt259YuBfadOH1lDpfgQiRnIoeCkfp8taYmmSXcWIo=;
 b=MZqjZkW+zqjyFjOHwS8eivkvSkEq1MZKLA0QwWg4jU/xptpR9HuvqDasu6Y5sUg9Rt
 XsMrBJ8tiOH1PiJuPXeer1rSF1A1m1lrT8PuZpXcDAI21308pz2CwhstDD/aA/ptxWp8
 KHd6WtRFI4hxKv4LTOJslG9ZPep9k9D0pQ+/IXk6eEK2BUG8TShNWh1VyJhcCjc8JYrR
 gTYuJbBVyMTcuhexP04U04TRd7esQLVx5YuwykYJfIn1B/W49x96NBe4bAIN5qe+DtbG
 qiERuKiT1dtxIOnrCQoHhI3D2bRkK52R7w7zPl2+kjUDcRFvf/RWVJOuaWmIAGD7x5wf
 nj3A==
X-Gm-Message-State: AOJu0YyBEQQ/aPJtaLq5Kl8kDOzol82DiLQDlNtZzm86SMGz5/GcHOMr
 t88aKeighmr5pPQsWbyUXI0haDj5I8v4j8k+/gqHSjvzLWdgUUm4jj7isDBhBAmh4jeUObU1wNN
 YEhIq6DU=
X-Gm-Gg: ASbGnctzyjBMVaDPy9zXVk9dIL/W7FOWrpldNY5ybJuVC/nNzua7B/F8gZgIB++OmoH
 NjR4ZkBJFVfVfz4Mywl629+cOSsSXw1eoxdKaT3eAiiZbVLcrQS/WGHYnIyY6d+m80MtyUWJQOi
 hoJlAINNClYvCz6qHRAeRSqyLujn964ZIIC5hapmQblEupNatLz+VGIuEcezMZdca1QJvFOTf8k
 x6l1jKszCiPikbL60GuokpveQn2Vm75PJRjKHY/x5dpFGZXHqaLLb9YvHHG7jgZomcvIro5Gij8
 adKOsxyskn69MiFko6LlNwxWO83cUKn1mdHewQF9jNn4MoS3UJuPQ9S/z/IL/eNo/al+ZTGIdaA
 1jqTrHAfsmsUczi06FldPDfrdvW0XpkenvDpANYtOOAglm8RmmUyssq9Oq3uiBI7HfQqZ3bPDaW
 pS8FIOtwG9dMnJ8qZK
X-Google-Smtp-Source: AGHT+IEBtALiFGdo41uao0HFKjCFVb+2yYyK8UVzv6XwVHKGhRiyZ9dvrmrPI81tVm0wx7rHMhjqVw==
X-Received: by 2002:a17:907:1c0b:b0:b50:a87e:efe5 with SMTP id
 a640c23a62f3a-b6dbbf72685mr410492666b.19.1761662354453; 
 Tue, 28 Oct 2025 07:39:14 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f9a0fsm1104953566b.50.2025.10.28.07.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 07:39:14 -0700 (PDT)
Message-ID: <686b4a77-cf53-45e8-9b75-2b8dd9c4a67f@linaro.org>
Date: Tue, 28 Oct 2025 15:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/37] target/arm: Consolidate definitions of PAR
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-21-richard.henderson@linaro.org>
 <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/20/25 15:31, Peter Maydell wrote:
> On Tue, 14 Oct 2025 at 21:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Create a function define_par_register which handles the 3
>> distinct cases for PAR.  It is easier to understand with
>> the definitions all in one place.
>>
>> Make the aarch64 to be the primary definition, when present,
>> rather than being an alias of the 64-bit non-secure aa32 reg.
> 
> Doesn't that break tcg-to-tcg migration across this commit?

I don't know... possibly?
I guess we have a test for this somewhere, but it needs setup?

I'll experiment.


r~


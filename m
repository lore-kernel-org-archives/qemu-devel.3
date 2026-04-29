Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A8CCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9sK-0006UO-Ij; Wed, 29 Apr 2026 14:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9sI-0006JX-4B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:43:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9sF-0001Ue-L6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:43:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so635515e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488181; x=1778092981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqcYmg0HN0ISE9jriVaAPy9WKvFvuqscYoo669QaoJA=;
 b=GsbemXVqAUaIR3UbsF7F7pL96meR17FTDyacuNPuyOeuwnwFEdkW501CqJ/j/YXp0x
 pJtCrNjCwBiwyJYaLZTGrfh9qIQW6V7JekDfJsWX/4fIBlCQ/ekBGs1cRmX9cilKrq6s
 q3KhZ2z54MTt5XQtghyQtN+wj8kL6+mIsyweqJeX4WKELamSqgZZ0a0APi1W12ncqFnQ
 AGq+ILK92epvTA4r0N8ZdW+7UpteZ1kyo9AV+VBSAgXYHuCIDzcE77sOgA0hZwuT6vUD
 aytxGS7SZ+dXI5CEXfuEeIWgbWMT+7ocriDiEmHnVjRw6xyuWBcGIUh+VtnyZOcJI9ee
 Hxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488181; x=1778092981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NqcYmg0HN0ISE9jriVaAPy9WKvFvuqscYoo669QaoJA=;
 b=cCK806RZz7z16nl3TczPHKFXWK1Oygmzg17Q4AiGqRhanB4ntv9R5ponHSsFl9d+OL
 Q9aTHqYH3z2Q3xf5unfEcr+NseyXiKMkqOR3CcKXRD7RFYlOpWpnQIg94m8f0+w/wkoy
 nF+ET3qhsEsT35QcyLnnajKIL5vLExYTP4jthtD4ZoXDSJmRJhQxjcBcYKT7cpqU9k0J
 fMvFnycZGvD5CfgmToXdMs3Ip/nHBLKv43CKomgfNnrYiTAuJaUb/R+/+zMQwlsszkJI
 afGpKtJ/gz4BShzcORdH+3RCvNYN+HCkwt+uXE0qlAgB9qkFC08oUV5i3u3EfE7fdHbY
 y7IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lcY6VngZRlX4pUgVPqiAFXBckWtPFykRGqaKIFVR1V0yNIpz4rkHx8UPv5NZyjRptRzzbNXQJXcyP@nongnu.org
X-Gm-Message-State: AOJu0YyaeXR+1hWZJRvbLHLsESGK60WnBYaMwlIC1LFYurpYP+2qtRZT
 FVhAn4/QrvZnlfV6L7MXwV2jO9vl9Le82SeDMJZVRP4IiJ9z2h8ipfmxWjXEzykGeRk=
X-Gm-Gg: AeBDietKnlQAcSWJpbnFnXjvmnL49zZrIz0r3rX60fScgY8Rdu14tCjgUOmJDd/sFX/
 761cbfyG4ofCdMA/wF7IxybBgj3Dw2+UTGMMJ4si5lOV2Hxhb+axjR61Tjv5VvrbbRLb5q4ve57
 GL98EQ4y7blLDzA7f3Z6ZUt636ssqQ26GBZ2GLEXTIZBa//CHDL2RZ313JHFFxRRP/sNdNmFs9L
 +JeqouiLLGeG0rKuK1Y2yoLkSxbmsSomZJ8SXOICnZGdjbDqsN9JhFdURd711FEnpQuSiAPXB4l
 hdJnVXl+OYA38CnYVPTyZ94YqgSWqplKKP9MumzWtOCLIW5HnTEUpHamrIg/mWk5/LWHYS61nV3
 ZLNnoakxBaWcOWiwILLC+8WJmT4imeWmSv2qUCgnocvltRAU6HLr06vR9aHIykF5AFaexP+Ucpg
 vsv7F9r34AKgAfYEYjNjBFaBE6a/8wpO+omNasdDW2xoxQdY5n9UUkOY4mlSGiZ2YuUyr38OcnI
 NB8
X-Received: by 2002:a05:600c:630f:b0:488:9fb7:376d with SMTP id
 5b1f17b1804b1-48a77b1b815mr141801815e9.28.1777488180548; 
 Wed, 29 Apr 2026 11:43:00 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822c832fsm16183185e9.10.2026.04.29.11.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:43:00 -0700 (PDT)
Message-ID: <5824e3fc-8938-4b76-b830-d49bd6e76b7f@linaro.org>
Date: Wed, 29 Apr 2026 20:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/84] fpu: Return struct from float8_e4m3_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:39, Richard Henderson wrote:
> Inline float8_e4m3_unpack_raw at the same time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A34FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJYY-0000vw-O1; Thu, 30 Apr 2026 01:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJXH-0000Ll-7W
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:02:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJX9-0005p7-AA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:02:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso2775445e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525312; x=1778130112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cKTcwmboIwsN4mXQj7nvy4Sy/N2U63Ompg1ZL6O4ydY=;
 b=nnpNUVrGiZxc0IrdRUh+3ICD2YRpPUPzinMBirQfGvPhLmtIIWfQFMf83Qn0EDG0ZR
 7om2H+5fbp4FlVU/FeA0hnlkWSUqUrkC6OX/4YFfs5nh8t2B00tv7eQ6YmyjNrMbLhWN
 8Jrb+2KI5DcbHJL49Y0M09kSaMl/xSB7UDq9DV+1IunTNPfwHh1JsE4PsNY2fEDnrBMw
 LNRlzzYFQqgMLdDncmTi2zC76xlKnGUHxT8+9AmRHsiRaYsloM3vmGG8qozKLB7sW8qk
 K6qT7O19kFKpiP+ahMzb9YDt+kId4l2XlVRWm94EWbLCtM+qax4HB2Hyl2eCcMpcBc01
 oVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525312; x=1778130112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKTcwmboIwsN4mXQj7nvy4Sy/N2U63Ompg1ZL6O4ydY=;
 b=J/V7Oyt6c4dr1UAXZex/j+qplWGUTKhMsPeb+ckKZh01NcuU+Hw7gFp0mP1304Rtbk
 dOVVZ3o0lSJypDsRptTMGy1WYlEXGde8jZk5olhjzLx6yCnUEBJ6caPeU81dQ1AmI6pB
 DUc6UaSecx88Bb5BNL1CslWm7BC+GFjf27coHd4/+4G3R0XBDQ5vt5V93SYjOdCXBt4V
 cf0D3nPe9tztNmDzJaExu/LYr4QshSk4Qbm6lo6ctvCeXxwF+cMEfarkEWuFWhGCMSae
 1NNWwXOc1YiDTL0ZKpVZihNDYrMgMOu1vVG77XaConFMkf7bwmJgum8AON0+MghvRVB7
 iMiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LGW5+xLavixEs2+QMQSnmhnPvy/S7UPIMKUtinsYEU2c8rP676nsZ6yzNfrII/m/JTLAv6/k+Rebp@nongnu.org
X-Gm-Message-State: AOJu0YyXvcebVz8EAVOs6Q8K5E8Ofz5frlmw5oQORuDypOJ38HZm4itc
 et5oPIvimlWgHXnvYFTFxqwgbw74B/4rmvDcGmalmr+A5/kSF935vee4uxz88sCmHzg=
X-Gm-Gg: AeBDievojjBVm5Fkrzb4+0wpCIznPIDA5izanetuuBv460EoJBk+oXCzrbApG16qBYA
 Gt5oxWMW1ElVFAH7T4nPxTVHIN5UrKC8bZH8pckI5V5Ku7oh7hdoEzJnBZakedOOauBbg0ZCPeQ
 MYqdmh3tT2fzjuWoPcIofIi9UrKsPXKEOIYKoNSQOSqIU+fBD1yy4nlDUaFvSd2XY0kGYCLFV7f
 7WQI5dQ//S2eRy5Q6v4RQh71b9NT38nwQ3TMTAdohpq/gRAGfSXQMMbJIMW1C1oB9jEMKTgMtq6
 fj3FQGKaQTvF9JRYH+yMDshdQUTjfodcSeB6kDPhZhIZ8dMigfvisKs8yN7FJGlWOvgQ7A5skC2
 GVShqFrICQfB1kLe7QFlc96RLFcyiQ3Q4s3R9VqYp2RQdQMya1LxQLg0Wajnlr/JnLBHz6L6hhJ
 IZYYLGVoT4zeaYB+IJfnEXIkfvL0oy3y0zaR5U2xQUcwh7cyTsTGXIme8trc5aBb9aX81oNHEJQ
 T8E
X-Received: by 2002:a05:600d:8408:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48a8452cd4amr15966845e9.24.1777525312300; 
 Wed, 29 Apr 2026 22:01:52 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b8c1f65sm36535775e9.0.2026.04.29.22.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:01:50 -0700 (PDT)
Message-ID: <bffeb1ba-79a1-4515-9ccd-9a930f245422@linaro.org>
Date: Thu, 30 Apr 2026 07:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/40] fpu: Return struct from
 parts{64,128}_pick_nan_muladd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


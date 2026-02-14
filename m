Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC75EF99EA
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5Xx-00047W-Md; Fri, 13 Feb 2026 21:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Xw-00046W-Tr
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:38:12 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr5Xv-0003Os-5E
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:38:12 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso814734a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771036689; x=1771641489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzvuY8mXIHXzD/ElPpK2odFOR3uw329zckcQAtcF19w=;
 b=L9tamhUS47mJFz8r5Fhj4oSCSc+OlJh8XHq1Lti1OqkXdUnD9BUW4c5S76GezYZcjC
 RFkIHvph5hSjxl6X0OwOs2pRCz4oMbwJCkrRtfs3B65CBCEMMLVuliIa1jUWKXCw9Hbs
 tBUsYHm5oM4P8e+QMwxwlHcgzcq6Ism4nwsUb5QjYDhKTRP23unsFKLIofMMsmhq4SMv
 IbmtYyx8RVWqzgqHV6vvVIN3jMYkUtr2iLUXOe0JlGNMEUfa8zl8+dgv+dvLpefp3/9H
 kcORindNqLB/8NcGXh2qK40dNRQ1g1k0H8WYiDecXUvBWnZjYbw2D1zUHb0d2Pkh5qje
 37Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771036689; x=1771641489;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lzvuY8mXIHXzD/ElPpK2odFOR3uw329zckcQAtcF19w=;
 b=cJFMii4iwu/P8NZcbTETNpOccTwtECPsQeziZDv7ah/IzW4VePOGX+izknPrOTcKCU
 29PL83U+DjosF5gWM3hb0+GC074aik6i6kXXOYkWv/I+2xVV4H0sy43MurfTFxIEu0m5
 hI8oe7Om5bB5nt1+stvI6Q4nMoJe03OaZd4AWjiUrDOnm2N4ggGNxhNUqW4Z1BlfyXQR
 Zt1dk9y+IPl2sXHi1jxnHAXABt93ZKZhLRJfL2DhTWvwQ7clFovOK4zuyPUly2i2M89V
 obZvGbCH2uA/FvSaz84MzNwWDOvwdKPjXYwhHdfcjKJslpvvJXETliHvnd2/PoUXZ8Li
 7QXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbydoha2mNSQzEOU784RSix9ccS6Qii/Ic81U65MqjEx6ExlXqnc+0CGIQHs7XIyIkvTGeXPnX1xTU@nongnu.org
X-Gm-Message-State: AOJu0YwaOch+v5NHxFukXWLLZMlIPROTffqpdQgsYwrqDOm1qPnGzAie
 1V7tgAuOhq5bAxynwChHiXojy2/BuCoWxgomWNHrVY2Zu3f4mr+OpsKvDDwSy4TYu7o=
X-Gm-Gg: AZuq6aJTa42qj0Ob5e78bFngTI83MpsZ230P6ohlsUScUF/MchBSr29dMOZYbjWmNBM
 R3dXWCAg+Xrfeh+Bw3M3+OGu8qyPUStKyNgb+6r/80MHz1k7hZpGQoTIA+pUYCKAndqJFtX9VWj
 9eSoHgk0mfcc1pPIqRZrQps8sLnGDizR9cYnPZwEx5H5SevDg9eO2v/e9ZM0SP7bFSsw7kZL8CC
 MQe5j7J8/f7UVKshi3CzYcJcCh2Mfn5kolwsIkGSUoKIa26sBvIJ4N9YDMrouGJPnrO74SzubOZ
 b1PeVcw7kxkL1pM9mG+jUHHCIJcUnrky6rFt/c817Mp/35excG/o0SXr98Tcm6FgbG/bc1kpnkk
 sauNeQ2pPrFX1VOWFzsiMXKpXQET7D3IMxFRjlkoB6Taky8+Ehm6lprVEcOV1bXoDZMG+r6Kats
 xWGhhpMvPib6u19vPx1LISrIMx2mGF5o00sfWn2H7OhLVJ07HTcuUDQYDSHSlXmKK2YTpYhMblF
 nSHqcg=
X-Received: by 2002:a17:902:f68a:b0:2aa:f9d7:689c with SMTP id
 d9443c01a7336-2ab4cfa78a0mr46321835ad.22.1771036689306; 
 Fri, 13 Feb 2026 18:38:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d5bdesm4415045ad.55.2026.02.13.18.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:38:08 -0800 (PST)
Message-ID: <67873123-156c-4a1e-bc6a-90a5514147f6@linaro.org>
Date: Fri, 13 Feb 2026 18:38:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] hw/m68k: Set graphic display dimensions generically
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260214021240.58657-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

On 2/13/26 6:12 PM, Philippe Mathieu-Daudé wrote:
> If a dimension is not set, have the machine init code
> (q800_machine_init) set the default value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c          | 6 +++---
>   system/globals-target.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


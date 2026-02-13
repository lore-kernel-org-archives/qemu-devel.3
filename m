Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D772EF99C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqy3G-0002hd-JQ; Fri, 13 Feb 2026 13:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3F-0002hK-Ri
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:01 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqy3E-0001U4-ES
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:38:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a95de4b5cbso11552505ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007879; x=1771612679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XHmxTuSzEGqUnmolxjyvjaXcdqEgGh8fZb2LTi5af3k=;
 b=rGcHb0fvYCMAw5GOuBuJczuBz31G6ON1FPt97EaHGTY+OsHi8l6DfXDVoBnQhayTf2
 QbJxFZp0wBoXtBKKGgWa2CxSl3dRJ5sf5gdazgkWNjSms1KPFbUYqM0yO/z4rpyT2+1m
 dk40Qs4EGEBcCmjX9gv2mW62soX5fZFxdhPlR6gmlrkEtNqDVzY2vwCrldlG25om5UVd
 zj1cp95eIj0m+Wj4qdy2n8bRKg3jt8ra1N1jk0DiT2adLWnwlwtbLXBrj45C3OkpiAP2
 cH8v3gV40nE86omri5FeBRbmjCTWlx/bbKvXGKw03qXITm75YSFrs1Pw0PRUw7OJIwPY
 kQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007879; x=1771612679;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHmxTuSzEGqUnmolxjyvjaXcdqEgGh8fZb2LTi5af3k=;
 b=SrYHBW/EyhSi8o32g2BTeC+AZG2IoJ4C4BSHG4x121lIh/D2JlJIYvBiP2oJ/NsFL4
 +CiW+0Qwsm3NGGiC9CEPIE445PUtNa6Nb7pLm1IuEB+sXWHLDbncQxTc6k80d84tDR89
 HrAR4S4GvAEI+pw0mE1JChDYzs3OStw4cTqDbruPGfAKl6NGcHVcuKiQZQFgKQYlFiYh
 Ju7b1K4GOn4wF1R8cPjXYIRozv74b27G3xoUf+dwFxT99k3Ubr71fZd3etC0qOisMKIg
 f7gxEdiCtZ6VDuMPZtJZ6VIge3iAxwISE9CFOA9lqvm9F3UOmU80dFUjHMvgT0kupltt
 Yu2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGWNN+b2CqcCTafLpfxE2aiFj+r2pjiIdFlifq+eVP0jpZunZfljUgJhQy+4yKkXopDJkQEhYp+zaE@nongnu.org
X-Gm-Message-State: AOJu0Yz0o0PJM0aaLWg4YEH5cpn+Yh0UCS1N0Ly2ciO3OiateNQCTKoQ
 0SGSUdX4tb4N66KQwDKXp179gr0J/KN0p44qcJyDkQBktZ84HHvfzmkT/W/ktzbgMLs=
X-Gm-Gg: AZuq6aIRwSNaHKTMnUf1NrxiENItPvpmP1dksPF4YErbuFTI4v/3WlQKHCgM77/DKb1
 1TqbxGDb39us+LGYhVYoF6Lr/92eG/xAPpLFe6X/Mi+awoqpHjF1qi5MSyEcrLTCu6Q8a0pLHjN
 qOBoQAO1XPODFC+rWfm2R42XOm26/hy7L6FBKAKa+OPLIp9jfUIukBbYnKaw0wACI9Wo2nybt/t
 bwPX+Xj5DQ05bnFAKc0qTRo4GjSA+NBF699+5+Yd/u2MF1hruMyZLUYVMZuXD4kWRT0tYi70B89
 vcld9jddsrv3otJ4TW0jczScnOigBE/zAfh27tf9BS2TaDuNk7iTxS4bMT6TjklYgAu0A9igxLq
 JOK+eu1BeM2HAJ5k4hgnsdQDy32P3a4I7la9dwbKtr6KL1w94jsPwiDaBVfVea+mbsxPyfu+D+z
 7LWrCuC7bzt2qiH9Zh+w4f4CYiHcCC8j4afXRiqXkELf3zhwbfd+7Jrbu4mArkkZ5kF49O
X-Received: by 2002:a17:902:cccf:b0:2a7:5751:5b30 with SMTP id
 d9443c01a7336-2ab4cf4f481mr34621255ad.12.1771007879067; 
 Fri, 13 Feb 2026 10:37:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab2997ac92sm86159805ad.69.2026.02.13.10.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:37:58 -0800 (PST)
Message-ID: <bd676643-0f57-4c67-a156-6479d414a845@linaro.org>
Date: Fri, 13 Feb 2026 10:37:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] page-vary: Expose TARGET_PAGE_BITS_MIN definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260213182713.44924-1-philmd@linaro.org>
 <20260213182713.44924-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213182713.44924-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/13/26 10:27 AM, Philippe Mathieu-Daudé wrote:
> We'll use TARGET_PAGE_BITS_MIN in page-vary-common.c,
> so expose it via "exec/page-vary.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/page-vary.h | 14 ++++++++++++++
>   page-vary-target.c       | 15 ---------------
>   2 files changed, 14 insertions(+), 15 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


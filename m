Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB2E107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Ym-0005KM-5b; Fri, 13 Mar 2026 12:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Yk-0005Ev-S6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Yj-0002Yq-D0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:40:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1870067a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773420020; x=1774024820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dn4Qze4pQdbWSH2JSGG6nfJZdth8dSYMuC51TQVNGNM=;
 b=km1lJIKKHVeOiuegkRQiYJy49xfctGG+DiFhMnfU7p7Xq1Xtah81+15S7Ks2hRnq/x
 2jZZRYgttbBqXrObYPD+IhMZHLWasZkfYXQ4F5dfA7pvsWKwN47kclcOj4mCCKGCDkYr
 aRbKkX/bE2vBIsYOWJ7hoC4QktqFeTqdxz6gIYbtr1hr38Fz8t4yMFymtFfnZYKZR8KF
 +ggD5hW3/6OFzJ2c9AKD/nFZXOMCmIJQBXxktrJsWlfBGFVSLrcbk3qY9M3/GU1mlQVj
 ibSdTIA80uvyQ/5Cc+pZvPRYj1ehI4Y7Y3F22VAo4L+8WW1LnfdIXeZoOfrSWC2nUnlU
 WSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420020; x=1774024820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dn4Qze4pQdbWSH2JSGG6nfJZdth8dSYMuC51TQVNGNM=;
 b=K9PlHtWmSORNKMfotv86DR8MP9dNhQPi8eJ8nX7Eja5/QvhKa5qme20RzXxVuDAZYI
 5DPTmJH8ut/ICk64zezVTXVaHwuh1ywOk1wGoGA5YkN2OuhcF3gWan3jdnAhPY8r77YF
 H8oOZyOpxtgV+DzI0NvaeCi4LCdQ+4e/wuLN0NzSMfyCBAGZnCRxnPN84aM/Y4hgtf6j
 XCW52kYl+SDCbU/qqgzQ50MUEPPcVL1umPMsr4F1cfeFi/ga4AHrSiSTtx288cK1/CH9
 mNaooB2QTvm5+1ntUwhT7LXWcCJQPtWaGjRUB0FjRSj4F1iKuqU8t9JlZoMs03KnlFmb
 PO3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDhf4bwTs647/ps19kgJfPzQQLlUTDr+5JnDt60AW/I/GEGB4KPyDUUAI0y1hZSMMQZu1KGykaJsY@nongnu.org
X-Gm-Message-State: AOJu0YxgeDjHOcs20Hb+N46PXAHMogx+SxIGoSQ3i+gBdvs66B3POBV6
 tiA3vGWxtLzM1l4AcE0di1VHRY6o4lZ5dCY2Kv0NLw/MNAQL5rSxYpKZNh58Pi44jx8=
X-Gm-Gg: ATEYQzym2+Xp2P011RrbUdzRx/RhPA4eqr3bO84nV4yb5zNEFhzVJDhAam6rvWAyfd4
 Adri2XclToFTJX3y4NJw9dd/hCGUpKuhLhSKf1GbB4pBeB+LXYTTxQE8AXRVWknioS5Q7QfmOCB
 GB5g8Y7ogCviCTB4nYrViQ5dAFB7Z6tjZepS8snHRAu5EH1Z034WNxBZQVbZHb/zaFacCezyX0Q
 mQQ01/pV8rsk1tBS3/YwCWijaSXxmwSARYcxrI2+lArKrIOD85B+iGxH8Xi8TBUSadFV8sIOpb8
 8vHVphSOUu37eSpPSHX6yfyfm7zh1wgjgf+BFj5WMTaQA1KARGHc2eyRW1qK+yEnQcemj7CvXn0
 su4KJU70yFH0KGP2ppeSxIcYX6E0VHKqSX0x9/kPXzKtu/HKp1hLkvuyqTeIfkyAiii/VQ/I8QJ
 D4iF/inrb8G6GuBSBx2C67nknDdKi/sgloRmYwzqKF6absehAheXZzgkDO+mnHU5cyCRef
X-Received: by 2002:a05:6a21:6d89:b0:398:6b9a:6764 with SMTP id
 adf61e73a8af0-398eccbda66mr3680165637.38.1773420019810; 
 Fri, 13 Mar 2026 09:40:19 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0727c1d2sm6561895b3a.25.2026.03.13.09.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:40:19 -0700 (PDT)
Message-ID: <ded520a3-d4a3-4b9e-aae2-5c1f386466b7@linaro.org>
Date: Fri, 13 Mar 2026 09:40:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/38] hw/sparc: Include full path to target 'cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-34-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-34-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/leon3.c     | 2 +-
>   hw/sparc/sun4m.c     | 2 +-
>   hw/sparc64/niagara.c | 2 +-
>   hw/sparc64/sparc64.c | 2 +-
>   hw/sparc64/sun4u.c   | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


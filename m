Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3913C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKl2-0002gU-2H; Fri, 12 Apr 2024 13:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKkz-0002cZ-UZ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:32:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKky-00041U-CP
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:32:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so12654065e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943125; x=1713547925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ppe/IFgqWSRwmGZlaqDQBrpp3cJ6ShUPHLYgN0DnFfU=;
 b=AYqxWhru9eTXK3PBU7pPsGZPBVTtykObN3zcOn5i7hvQdkaPj94DsX0NYggVzwpm1L
 KePkfyQyxoxQZ8UziZWoDFCdW6HpykAcvvV9rwPWmzVH+w/hVt13E8wAdKOYtLCCFoG2
 2wZaxMFuGt944I/cFP62XZYnkejsUCoWQQuRnIGWKmjIj0PMeY3+ah+Emj60VqLT0SOF
 Dg5gYNU+mNLgQ0x55FvEQy7Mk+Pl0bs9KdIq9d1q102ySB4Yu/EdFEgIYQtVIRaOTNfK
 c+TOUnveUUiiTZVB8ztkcPC8ActeD8neALR3cOquszfC/vNjEsDFK7OGi32SPQXohXwf
 D8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943125; x=1713547925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ppe/IFgqWSRwmGZlaqDQBrpp3cJ6ShUPHLYgN0DnFfU=;
 b=YICu3g1j3F1U8+w0liDnZ1lAcjRnszkYpXbi1jieezD8ZCgyIR9VvKcw/eMO0e+94O
 8251587p85BxllZ9r0Bhs80MaXJiaHrE01fJMBK0iypRDMKivjire4UhQMp7QF6LH8Fr
 uDWY69lGce4MPHi5gvDuDuz0FIKtaupTM20SSVB/8lYu+jiqUvYI+D55948pkyfUSrUF
 bCqQXIN3jMrUSK0UCYLdnwWZh7k29NLrGsiE0dsehd9mVEZOwi8axnOdKJLuAnVOhaHS
 lSSMhm+dmmXsYuQ50ANAiPdppBLi9uCcDzfSXpoFon9rOHYcwc88rD2Tupz9LNSJREKq
 S/OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUwH23nxcAonwJjdtzQqTjDLOGYWt75edlv008dQkDtgukge0M+aonUr4FScgam8h9PCSizeYBpi5Om4/kpnTnKpQf0cI=
X-Gm-Message-State: AOJu0Yzhmq1j5ahQ5WL9DAaTPhoQ+hM6p62DF+DwSC4lk3nmfzjqwVFB
 Uk0DHD5qxkdqB7q9Ilr7n+uHzBjGqctDc76wwiZTEw4yW3PM4/uJ4ZixovF7OT5Bk3vnmY1OvgD
 0
X-Google-Smtp-Source: AGHT+IHfsFiinPhSbJ4l5rO34hdxITn68aHskdJbZzHnMVTXIFsHq/ln+we0R174fLGhru/h3hk9Gg==
X-Received: by 2002:a05:600c:5102:b0:416:9887:9581 with SMTP id
 o2-20020a05600c510200b0041698879581mr5797781wms.5.1712943125645; 
 Fri, 12 Apr 2024 10:32:05 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c4e9300b0041628f694dfsm6339392wmq.23.2024.04.12.10.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:32:05 -0700 (PDT)
Message-ID: <6c2c0d2a-4acd-4def-843b-185b2720c4ae@linaro.org>
Date: Fri, 12 Apr 2024 19:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/misc: Don't special case RESET_TYPE_COLD in
 npcm7xx_clk, gcr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412160809.1260625-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 12/4/24 18:08, Peter Maydell wrote:
> The npcm7xx_clk and npcm7xx_gcr device reset methods look at
> the ResetType argument and only handle RESET_TYPE_COLD,
> producing a warning if another reset type is passed. This
> is different from how every other three-phase-reset method
> we have works, and makes it difficult to add new reset types.
> 
> A better pattern is "assume that any reset type you don't know
> about should be handled like RESET_TYPE_COLD"; switch these
> devices to do that. Then adding a new reset type will only
> need to touch those devices where its behaviour really needs
> to be different from the standard cold reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/npcm7xx_clk.c | 13 +++----------
>   hw/misc/npcm7xx_gcr.c | 12 ++++--------
>   2 files changed, 7 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEF7C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2dL-0000dG-IR; Wed, 29 Jan 2025 02:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td2dE-0000cE-6T
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:37:04 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td2dA-0005aW-NN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:37:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4389083f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738136219; x=1738741019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/vGaMm1E5Xy7WsML1MCY3mqlHDi6fi4haF/kV5UQOqA=;
 b=cbHun0SwvNS8jNLkTSkYVbsxa9JgpaTdFfPczr21v96S0smxcJvPE8rQ7d7z4gkLlw
 CN+nNKqk3cXqgmWI0JGM3tTlm3RW4SKCmUCmhCFCqZ1pR+Ad7TuH/mpE+yMcJBw2GuBF
 v7v591R+ypLelB/bwWyFsIo1E5sHTSo9JxJblYiPKDImR8DYHzU0mZsbv+WR0cFPnVrA
 gmfVKyf9RuqlwJaRD+BkvaVzRTXgKHdZNcqY6zsUBHDYa2vudiBJ4M8LH3mW4rYxETzN
 AyRvbMm8db0XkSPZaTjpDUUawhTkZfeM/TpGkjkAGPNE/GE4Ttu988RWRyZB7RBgsHnU
 PaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738136219; x=1738741019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/vGaMm1E5Xy7WsML1MCY3mqlHDi6fi4haF/kV5UQOqA=;
 b=oBtB0b8AKSHgej8RrHUhlgSNGCcZ4MowAQWB2bZg/DpUgUCaA19X6ts9gPLkL3gNwE
 v+yjYiL9x5zX7QF5hO2GspvvcWHJKTFhErA+wp60hNKip+N73LKmsNpL+NIVx55UK1SB
 mmUU4nXdJttyObt3VG7ufPoGrzy91039OhOQycC3mC99+luDNWgp9ZhwPb2H14kW7joP
 n7lSDiULnGbxvGlrg2xI5isLrNYvMtus8JftxJO/laVYW/T+KI+rPOPxhtc+PNQx8ghf
 LHH+Vte4TFrrv0AI94i4WBADWbRfQaVX/0Xo4d8iRLrye2DVg5bsvsh/Wni0gcDxrxHr
 301w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjgkG8Vr0ihkqo102sPywpmkieivB/9vqfvkGpZ9/tf7Zka66NjUd7edOhFvo7wthkQ+unhy90aO29@nongnu.org
X-Gm-Message-State: AOJu0Yz6A+RX6Sye7HM9zA1Srf63gEo295oKBnIvL7QJNbxD7cXwtRYM
 qdLY1rG01EdlN3Uhr+ZVj+8glkgIcAinyp2ub9Y1swlQL2h7Texd1f+BFDKq7UY=
X-Gm-Gg: ASbGnctI+MzDTRuPVyk3qrSZKxOjHgZMDs7lTJ52MEBsNre2bU5At86SRjc1R8GWaMX
 RBVepLhc9EwVQ4Aa/bqYCH/IwSLPqhVKrdTZbi276md3dvbP/ld7RWORmu0k4WoDqaN6RJ81ZjY
 m8K15pvgJhW4V/pPUJ94WUr2BWBhH/I4tcakZqLsU+ZErLox8DneAADIpQkLjDSHpyd/7rqVi64
 xeeMKPwSdXd7mmQuzx7t1GGHnC9kvvbn7rqmi0zqsUWsRrLPJTO+4AZdc5p6/nSaq8Sd3LsKEH1
 5AWkPqq5BiD+pdNRhP+wPIHQcouD+n3iF1inYZwWjmlxO32X3+yiF5ftMCY=
X-Google-Smtp-Source: AGHT+IGenOvZMMcEdzcW8XoNX77vVNQhsixYCFS+GAmCK8IT2VvEaDpw51j9PABQZpxK/doE9wfeWA==
X-Received: by 2002:a5d:6d0f:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-38c51e8de58mr1367157f8f.36.1738136218791; 
 Tue, 28 Jan 2025 23:36:58 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm16554121f8f.69.2025.01.28.23.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 23:36:58 -0800 (PST)
Message-ID: <89f5b481-2bcb-45ec-a180-349431838fc4@linaro.org>
Date: Wed, 29 Jan 2025 08:36:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] hw/sd: Remove unused 'enable' method from
 SDCardClass
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-10-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/1/25 11:45, Peter Maydell wrote:
> The SDCardClass has an 'enable' method, but nothing actually invokes it.
> The underlying implementation is sd_enable(), which is documented
> in sdcard_legacy.h as something that should not be used and was only
> present for the benefit of the now-removed nseries boards. Unlike
> all the other method pointers in SDCardClass, this one doesn't have
> an sdbus_foo() function wrapper in hw/sd/core.c.

See commit c759a790b67 :)

commit c759a790b672b0c5bfc50520dcc93565b55732b3
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Feb 18 14:16:18 2016 +0000

     hw/sd: Add QOM bus which SD cards plug in to

     Add a QOM bus for SD cards to plug in to.

     Note that since sd_enable() is used only by one board and there
     only as part of a broken implementation, we do not provide it in
     the SDBus API (but instead add a warning comment about the old
     function). Whoever converts OMAP and the nseries boards to QOM
     will need to either implement the card switch properly or move
     the enable hack into the OMAP MMC controller model.

> 
> Remove the unused method.

Never used, indeed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/sd/sd.h | 1 -
>   hw/sd/sd.c         | 1 -
>   2 files changed, 2 deletions(-)



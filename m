Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17674FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSd5-0005l0-BC; Mon, 27 Apr 2026 16:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSd3-0005jJ-IM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:32:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSd2-0002ll-2r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:32:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so5654860f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777321946; x=1777926746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S6EkR0R4g6DjyArhFcSnQbudqDs5dkIUUBDhU6GnVvs=;
 b=JVBQw960ppoZNh5DDnc/4aEmPw0z7WOX1YVdc6wX1kSi5AE3XC/2xsqhsTH2uskvMx
 HHEEao937hqG60azuctkqIbOW5MKZzUrQTxELinWgqj+xO/C4QuYdYnFsEPjLlvbVc4U
 GwU8Ub5Y35lzN6CqTQdng7rsoPNaXdfBO1ZrI1a8PfcDrva9iG2jZ4V8WITL41Z7QkcY
 QExwY9muBW9ohyEUSzzWPAubF7Im8LAzJIoPDA2MvS+J7XwPnbYNSHuPNo40Lh9kJ5Ep
 dmvXuihEJ29C1oT6YJuBryhZpN4dX9uj29Ht4Ul0GqEQ3NliYtXou4ULbambgXfrHS/e
 pGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321946; x=1777926746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6EkR0R4g6DjyArhFcSnQbudqDs5dkIUUBDhU6GnVvs=;
 b=qC2gp3ddOcFYSEK6E5+HzfbqqIWSkk31mamf/cr0Krdxwzs1WvEDPhoN8hobTTtDqX
 zM2eQotp39l/RBYLMU8r0vrIBfn/L3klJGcGgkSXa5GMrIxahh+gH07rxAu3PqZ2li0g
 P7lCGnsMThEBEaG0dToSeWZPNPFmyMhINizhF4mnuTHAT0uA3Dld/AJfutn37/2WtPur
 NyI1bE35TcC1HX8hHCrqPgnx8LZ9UBaIhvZMBV3Y6YQpq/6sTrfpawA7D0uDnpGMqAgS
 oCj/UbgGHNz3v6XuNY6tCU8m2FBnxRwpxCC/yJGxwxkR+UCOz1oIH6S69d3RZU17fH7K
 VF2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OKZ/rKN4GmhKrjd6ll7QK760YgQpHClWqQTcx6XHYXHx5bA+/LNASG6E2hxGST8yrby2fKrtEy4ci@nongnu.org
X-Gm-Message-State: AOJu0Yy6H7Yia8RGQx1WJHXwPmyrPqioExE299olRE/wN2HqzcAy+e1x
 65kkttBJpAwM0fKKGSFOPS87ouGCW+kmFTqslJyc/VHeJMPKODQIbgFtLVAKptU28Pg=
X-Gm-Gg: AeBDietsNGOa9trKMBD+NStDPhCmwex1UCDwDoDroRu5KhXWg1m7TiK+t6idZ7KgHf0
 wP6FfO5DRS+RAlnyUYo8wzrPeaClHJycEL/cGQPp7KehfJ/fJscbBRW05mCEnQE50EJQJAj4CVn
 /jRYGA0Y8Ql7qA+1sVd6/gOuAhsgqmR85R6VeIF3ftxNjmNucNPUQLr5SknzBwscPdvY93DOSO+
 +7t8v+Q2l1JSLWOTa2lhlBKmAnr0ml8/SKUwQSN01KT1ffo3n7S7sKYcCwTVuya4B2jNmPOfeEw
 O6S/0pl6DXEM5XP6u/DS72YmffSSRmTnkQQYhl30dY16VZrNj+a2YWj9UZghKM643vfEur20sYN
 ZcqcEf0ciNSEg5ZMUpQd5cgUXcVM3vVymVSUBCNiLjffMxUH1wNJ6E7mBBqgntUCCrXLb5v/6Ru
 BI4gUolU0CSh8Nw/FKBcjdUl1wgYQO7HQtf7wSG6Zj4lQmywLB+RRNHjNlRpMjXJx4pduY8o5J6
 8Yw
X-Received: by 2002:a05:6000:2283:b0:43d:a37f:8d5e with SMTP id
 ffacd0b85a97d-44647ec67bamr568433f8f.18.1777321946284; 
 Mon, 27 Apr 2026 13:32:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463cb59d5esm1023533f8f.7.2026.04.27.13.32.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:32:25 -0700 (PDT)
Message-ID: <ed170a9a-90ec-4154-8321-8bde8c408f71@linaro.org>
Date: Mon, 27 Apr 2026 22:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/84] fpu: Drop parts_scalbn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts{64,128}_scalbn at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


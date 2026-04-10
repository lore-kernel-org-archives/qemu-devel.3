Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003ADF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGjj-0007Bx-K6; Fri, 10 Apr 2026 14:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBGje-0007Bh-Ed
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:37:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBGja-0006ou-PC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:37:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfb723793so1633915f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775846256; x=1776451056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eB7mS78cWJjiwaXFZoRSuwSwbYksJx65WV2q0b6vgZg=;
 b=BsvgZy9gI8/t66ZtPdY9N+1c8xC8+gZOHDPuyz1CEj7y604UFUG462Q5IqXaAaLwl9
 wRsMSdfoYP1O8oHtUKdj8m0/A11MsYnHUyl3gzo5P14u+Q5xhXTsvxHH5hljUowiTuW2
 aOA7gvAyaK83xMu1uaz73eAEnHfvB5a2zwdGLuIdLGLmso9ODtI1v7KXTFuqjolJdUYh
 LImcQhifzAKkxIMBSZG6H9kwH2UqGpx/TS2S2VErCAAaFCzQhsheNhAp7EihUAxFGJlp
 PEKkBBz7IrLJa8SIUR41GphTZVBfTKK4QGHgM7K0C+lkcwIV1baNNFJqYAyfmEgZ7ccr
 n2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775846256; x=1776451056;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eB7mS78cWJjiwaXFZoRSuwSwbYksJx65WV2q0b6vgZg=;
 b=KqWPl/56f8zrXJbvGxvPNOhZP2TgzAy+oUdu4M9KKI8AMHa5pdS+KpK0w05XsLDb4y
 N7Dj6EYo8JG2BFMrAf/HKgF5K/V/gGWrJGJdjcUpjNxNF4hf9HjnmU9dThLkGfsNPJe3
 wX4tlEu7/HLcNeMQ6hlbH+ifOv8ATBUK78o/TpGTbVNaJ6AwiQu+oedJv74hw5aAJ6cS
 hr9ZVs1kjMEnEsp9/BpCY3bHr3/pHJrT6iPpHfY7jYufRzjQ+XoPCm7/QlnpXEN9JvQ8
 i1fGONyEkHnlFEGQeM6oas2MQIzm58cVPkOgW95dRCWONCqLF+dhK06J7mFLnpgfeiUc
 ECRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUIXk6eEWEBOQAkOY923TA4Qiich6wq4/W4BwtaLRG2HAysVWQG1Y/F45ZdW8zlMzso3kmB8BDAmAa@nongnu.org
X-Gm-Message-State: AOJu0YzTDbXVA81lqL37p70up2ms4qwqYusvlWIzdTavLHOZy+Ycq4WI
 t04EoFk0JOURylIytBLe1GvlWntRBBRYN33qkahB8SSIgfHtgcuJbSrbfQVi+ZxCawwonLu4sA0
 A6r6F6N8=
X-Gm-Gg: AeBDiesOU88DHPkdquPBxAXWJ45CV3obyyOsmiQDGygTwOMIsqDZR0fNoxEqZwqaOW6
 mAF8pYtgwHjQit0UJnYR+7LsAesAvnzR/ZclStKXV3tToWaTBkJlpy7xcdqZBET/fDrc+SSXNfY
 w/R8z5rKHSeAhdIvazMWWh60EHra8I/zbFvpujqhPvvIZ4c5sSWW+5vhjAVFn3ts+q6e5EkI5nP
 r2LHYvv+JH4ZrtF+jVNT8/zMV599SAsWh/Z+oysqXoAnXQGSyMiM0sJRiZs5i0jYxlkSS0YMwGA
 /hXe00dOW5It2JmY8yYZiCMq9cgrvfr4+ePKKUyAy0BOJZlwWodKsffyLyqhLYPpAhilqw7ABDS
 nRLJzz0quvM8i5nhCqW6xcMdKFzV8xhKiBm8GIlEV2W0Gg9MNW/tisn488ilYrcZYwptghV/7NO
 sc4nWIi+eLz4ftRnAcOR+L31XyUF2vN1deQauBoKfNj9YL8IBOVaXx3pmauhOQ22Uaww==
X-Received: by 2002:a05:6000:4284:b0:439:d242:e8fe with SMTP id
 ffacd0b85a97d-43d64289c7emr6737794f8f.11.1775846256458; 
 Fri, 10 Apr 2026 11:37:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2e4csm9977725f8f.2.2026.04.10.11.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 11:37:35 -0700 (PDT)
Message-ID: <8912bb9a-6efc-4239-a29a-c309afc82228@linaro.org>
Date: Fri, 10 Apr 2026 20:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix missing spaces in screendump help text
Content-Language: en-US
To: Brian Knutsson <development@knutsson.it>, qemu-devel@nongnu.org
References: <20260410151818.817298-1-development@knutsson.it>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410151818.817298-1-development@knutsson.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/4/26 17:18, Brian Knutsson wrote:
> From: Knutsson Development <development@knutsson.it>
> 
> Signed-off-by: Knutsson Development <development@knutsson.it>
> ---
>   hmp-commands.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


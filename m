Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453C0F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcoE-0004rG-D9; Mon, 09 Mar 2026 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcnz-0004mS-P5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:46:05 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcns-0006Z9-QU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:46:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso7591556f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071154; x=1773675954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0b2/JxJOl7wyuu1Pfe7smzA+MwUE4eVMe0jx5hxCI8=;
 b=ca/G3xCCFxWdXO5JNPmghD5fXidAQDt1YtRBdfDXu5XW4mPUiPp+dTnpUvFu92cojx
 dpvR04dfllnCpcmWe96gXmXn5xANCsOv/+2zLIErGr2KkOvntGEGzAvpSY0Fi0T1y26E
 XvtGO62hiHgU2RsgQcYfH131CrXl85MV5YH0knGpDwrSZdxzD9C5CymCkEbbyNboQkzP
 6zmJ+sVrBuea1c9W0nos71hjYnSonoMX1lc2PpERwgDQp849uFjFGLzAZfsRwOlbqQHd
 Xo8Sc9F1PpgdMuWOd4GnAalhAezjas5Rk8NhyAKRFNGgdAyTv+3PWeYB4K5Q/Kv0bGWt
 nfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071154; x=1773675954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0b2/JxJOl7wyuu1Pfe7smzA+MwUE4eVMe0jx5hxCI8=;
 b=F+YK6RzkSSvEIforSt2OwFXIV8UAXFtSSRSLbqLDn/4n0S+HNQpVFYx0MX/Iy45hXD
 6sOiq4SqFPyZgPB2N5p0vo3XuBrpYH9yESeby1WbenW/Ev/AdcfQldzVh3lzcasrr24o
 j96UnD89aPubAOTjSurXjJD4RieLZEx9IMRYlzuCh76w5WgAZsJ3yOmoNVpsISCHD4FX
 8vPvzZ1dSm67nMYk3bYCuyJ9HPpOfDyLJZUEhVTtlnxxvAVIVAOZtvCqL2DeMzq8D84d
 2fxpgywWTC0Gev0WkhU1ryuFG0nMHnXm0Kt+ltF1ro0qzlOP4LoL3wQ+jJ5OW70icwbP
 aQ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGIVGs83TBI7Ww3mDepgcbaye93lHVLntjBYTzcvxCO8EuYoTgI7S4RU3wp4jBnthw+JVj+IJIHYzZ@nongnu.org
X-Gm-Message-State: AOJu0YxwxzfIyFur5lpoNlrGEF7IConM1jA2zJ74SABGefvgpGdvvAkS
 G7lE3zHKDmhjFtTqMUTT77IOGBZb2H6MIAo6w308mm4DqlYSt+Izd6/qR6YUNfjOF+0=
X-Gm-Gg: ATEYQzy27NN+AkjV5WIO411QBlUrA6XRSHBIXPMYaHH+IYRtADexNp69Olr3sT9WDuX
 iqQJ41p4kOA/GrumHzh/5k1udE3f7naMzndbyn3Vc8Vl1lvq1EhHysMyfZopqXv66JljpEmE65/
 9CSM+rgAij/ut1AFPkmoS/SYMbGYW6BRL9kR+tQxS6vZSKZg+0n1ghbrbn+KB4RQwTV+Q2dBfhu
 ezAw9Z/UkFpJE2zyKT8NMtaE41RS5cYshLZbLtUTjaliJyF/vqDaELQkwqhEecTrJH1iEAly4MS
 YhTPThBz9m4e9h9KwBv7JRE//PBAirA7ggBDa6WtWZ7X1Y9zl1lK2cgEicR6VAvXdMBhTIvE+fa
 wmiBBdNtplAAe3/W94oo1nn8yVOOL93ZOukCR9ztfC/zAlnv6cHdyaHLxVpVWk6lHPbtlZI+ecp
 PCeXxg92tydik/58ItmpJY7FB7V5oDuW7VRwxFaZVuP3cRkEbsz56cgQO0RHgV0Appqg==
X-Received: by 2002:a05:6000:1884:b0:439:b940:8bfb with SMTP id
 ffacd0b85a97d-439da6632b0mr20447199f8f.15.1773071153807; 
 Mon, 09 Mar 2026 08:45:53 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8ec97sm30259630f8f.5.2026.03.09.08.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:45:53 -0700 (PDT)
Message-ID: <57e6287d-3d9f-4232-8999-6f3e56e5d4a1@linaro.org>
Date: Mon, 9 Mar 2026 16:45:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw: fix qdev_get_printable_name() leak
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
References: <20260307155046.3940197-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307155046.3940197-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/3/26 16:50, Peter Maydell wrote:

> Peter Maydell (2):
>    hw/qdev: Document qdev_get_dev_path()
>    hw: Make qdev_get_printable_name() consistently return freeable string

Series queued via hw-misc, thanks.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE3DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzF0k-0003cA-2X; Tue, 23 Apr 2024 08:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzF0h-0003a4-NW
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:12:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzF0f-0007Ic-Nf
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:12:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-345b857d7adso4415665f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713874348; x=1714479148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2l7PltlWdJDwWp/74Dgpbb8SGt7xm86vms3Vm5cSd1E=;
 b=n3KDW5RohaLbG+KPOrLw8RMo9/piYC3FBQX5HewKQDrhj2Md42C+UjJFLNHTOCMZCa
 O8aAyRXee5ZJWyLN25c9coeEQe9sJ2QXkmG2NGgMz8kHBuhzboCIozZxJtZSB6yaWNvk
 iTkxop8ed2fHpEJU2e7/0dEt5LAL1H6eLZakQskSaJt2u+nvRxhmKUd+t64aj5e7PPdQ
 bkJhCsc1pQJxLvi3G75n4Tsbz1I2Flu01bud+XBBaRYsczLlwqeCb+eIyaw72We9ZE6D
 dbwEN6IlBIStHXZmc/XUye4FvofdtLxb7xjKgDQHwYnUuRujVrtBMwCk9ZR3oSAfE4Bu
 tcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713874348; x=1714479148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2l7PltlWdJDwWp/74Dgpbb8SGt7xm86vms3Vm5cSd1E=;
 b=TpecB4w77zPKn7QtWRXyTikhZnmPAp1neyNQR+vBDx7/mgstAV/Qs5Z7DkNOhvvi4Y
 B+v5/D/Wz8zVNjyj6tXE9TNW3ShomZVZjtYWr1SEwPY9elLxF/D0xzGu3pIFMehzkfbi
 7VhFGRdtUQ+zbRYgO9rX85E9wG/4vOhn696s41cKAlIt5BMs4gmjiUcJm6OkTMWVdOBD
 J+50fGqLdSSb9Iugwve1KaUjbF0afLtUVBtH4DhlX+ejgXSs4mamzjfq5pnq4fSrOoRf
 nKpAt5QqdQ2oPZaUO5DzCc/o1cYxpLqqeuyCBRoBnEyTqyeUVgIKqsc7aOO51p8lP/lI
 hYgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+EM1e7gEL5iiThWzE9xQLSBr7vgkhwnTzlcFxM+MxcNuaLeyVWKTOPHDCsNPOab2iqtfcL1app9dBpzABaVHQgyyDzGE=
X-Gm-Message-State: AOJu0YyqPygw7uzCDl4Hmnm9tFbMwB4fYnoiXQJuhHu6EMxpPFPrU/EO
 RV12BQJ7A95c694rnUG+V+0WPlJBR0ZmfnmsCpZIB72eEZ1zSWl+qGwV+ITXqQo=
X-Google-Smtp-Source: AGHT+IG1VdM8eYxCFJ3orE14TiA/s99vwVcdpdOZ6YTjSdRjSMGHc0M6la/EcdOA4sH6q7Z0Cr8ThA==
X-Received: by 2002:a05:6000:11d0:b0:341:ce05:dba5 with SMTP id
 i16-20020a05600011d000b00341ce05dba5mr8601607wrx.30.1713874348076; 
 Tue, 23 Apr 2024 05:12:28 -0700 (PDT)
Received: from [192.168.175.175] (228.53.205.77.rev.sfr.net. [77.205.53.228])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a5d6b45000000b003472489d26fsm14517690wrw.19.2024.04.23.05.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 05:12:27 -0700 (PDT)
Message-ID: <69fe13c5-8351-44fe-bde5-88015b4f2523@linaro.org>
Date: Tue, 23 Apr 2024 14:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Refactor default generic timer frequency
 handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240419184608.2675213-1-peter.maydell@linaro.org>
 <20240419184608.2675213-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240419184608.2675213-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 19/4/24 20:46, Peter Maydell wrote:
> The generic timer frequency is settable by board code via a QOM
> property "cntfrq", but otherwise defaults to 62.5MHz.  The way this
> is done includes some complication resulting from how this was
> originally a fixed value with no QOM property.  Clean it up:
> 
>   * always set cpu->gt_cntfrq_hz to some sensible value, whether
>     the CPU has the generic timer or not, and whether it's system
>     or user-only emulation
>   * this means we can always use gt_cntfrq_hz, and never need
>     the old GTIMER_SCALE define
>   * set the default value in exactly one place, in the realize fn
> 
> The aim here is to pave the way for handling the ARMv8.6 requirement
> that the generic timer frequency is always 1GHz.  We're going to do
> that by having old CPU types keep their legacy-in-QEMU behaviour and
> having the default for any new CPU types be a 1GHz rather han 62.5MHz
> cntfrq, so we want the point where the default is decided to be in
> one place, and in code, not in a DEFINE_PROP_UINT64() initializer.
> 
> This commit should have no behavioural changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h |  7 ++++---
>   target/arm/cpu.c       | 31 +++++++++++++++++--------------
>   target/arm/helper.c    | 16 ++++++++--------
>   3 files changed, 29 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



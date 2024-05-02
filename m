Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEBDC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 00:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2K8M-0000It-RQ; Wed, 01 May 2024 20:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2K8L-0000IV-OL
 for qemu-devel@nongnu.org; Wed, 01 May 2024 20:17:09 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2K8K-0001z6-6P
 for qemu-devel@nongnu.org; Wed, 01 May 2024 20:17:09 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-234db9dde9bso3132843fac.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714609026; x=1715213826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75uTeGVmMeSa8zwPqloLaRC9fOP9T0eokl39jYzKJPo=;
 b=hDdpm9vLdzU/ApGLVbIZRBg6n0KfX7K9C9OxI+3ZkwUgqypGEaZ7Gl7WWe329YnexV
 Ce4FObXkNy0ZMbJSMUbvEwpump/4EKxuHtaSbk/bA9KHm8MkNaOIfrXEi+D5vt6hnIXf
 pPDDBBoBtgQqlTfvlG0ZK8jj+abbYXWUl51Ziw/jOS2jtkYLgoT24vqF/lBZON6YUf07
 C+qzAlt4seLHDNoGMqHIWK2vddipybOd1IGEuDzdp4SzgGoX8lk1cKW7cfglnHAtiXEi
 UATRBo6h5Jy57aaO/J/RPsY/8AJvyDGJjfFKdta3yBwb4zE8kzEsg0iHh5a/o/YLstvZ
 Ilew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714609026; x=1715213826;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=75uTeGVmMeSa8zwPqloLaRC9fOP9T0eokl39jYzKJPo=;
 b=lWP+xBeilR1hm/h25eAHmmjyL+M5yuV1NM+vR5cfuhvEno2Xfbi0lBg9KFZdKcMLzi
 js1sC4zYAL7HkIS+FwkLo1JJ/Jl1VuKucHbot4te6XWizccXhZ8mPvKLf46DnKU7GqJg
 4gtpaO3t+HWN3YAvPVYh0cvRioYzBIOmBBBboDQjxaFwv/TYSwUZnxsy/Bz3cA3ylVOA
 FEDTthgZaDELsuA56FvP/wVpgFMhcC7Kfv95FyoCdP2+L4Sn3PGraVpvUX8Lg3xTsTBu
 g287epqFSig7dXieM4uEN3wXgW69CCx1I7UOgwCfzeb34YQt6yI3TOoEKHAR863ReGAs
 A9YQ==
X-Gm-Message-State: AOJu0YyDpVrIiH2rAYivRSn2iay4fm7+PVDsqIRvOcFRjhm6Rrgp5ac4
 Vv0Dro3AdSbboCXmBjsBAvuKJExe7lCkh3b4LxAaVGDcdx6i09XUZUlmXj4mmjhQMnZib56gOtl
 a
X-Google-Smtp-Source: AGHT+IFPMHTjAiBr9eM6Pfxcyre4p7k27Wulk0nkK10IkITWZDcFwLFgLsJZBhG+iTcQlnxAJL2M2A==
X-Received: by 2002:a05:6870:8a0f:b0:220:873d:dbcc with SMTP id
 p15-20020a0568708a0f00b00220873ddbccmr769475oaq.49.1714609026305; 
 Wed, 01 May 2024 17:17:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 81-20020a630254000000b005f80080586asm20842079pgc.93.2024.05.01.17.17.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 17:17:05 -0700 (PDT)
Message-ID: <b6d1892f-d84c-4960-b913-80b984fb4b26@linaro.org>
Date: Wed, 1 May 2024 17:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240501143739.10541-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 5/1/24 07:37, Richard Henderson wrote:
> The following changes since commit 9c6c079bc6723da8061ccfb44361d67b1dd785dd:
> 
>    Merge tag 'pull-target-arm-20240430' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-04-30 09:58:54 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240501
> 
> for you to fetch changes up to 917d7f8d948d706e275c9f33169b9dd0149ded1e:
> 
>    plugins: Update the documentation block for plugin-gen.c (2024-04-30 16:12:05 -0700)
> 
> ----------------------------------------------------------------
> plugins: Rewrite plugin tcg expansion

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C69D26D7A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veG2b-0000kG-06; Fri, 09 Jan 2026 12:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1veG2W-0000jS-GE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:12:44 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1veG2T-0004AL-5O
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 12:12:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so21336795e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 09:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767978758; x=1768583558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=67AWTeughWk+XTjbkf90tukpyMx6/QDr7JxjAsH5P4M=;
 b=kTuX85djO686sEAyeldzTm4y6SRqbPMyXzIv5uVNqKxNDNyrG4rfBlGnXGk2Aidx/u
 2gSNOzmubsSz8YYTqEmKjJ2/Q0yfMzNd8eJHEHs1DvaBS1vrcPkKPKXZXAxBrnvvOTpB
 zm1fBSAJ15vQS2CuoCdf7CwHOLn1OfChGcTs8MrP/HKswFTB0Sf4tDsb44GYWt873ZRa
 dz5G+EwugpvGY1/6nKdovzpJzlkLmtXBzCCTY6id09vLetxXwkKR+4ZniGGPcU75uZe0
 ztUn5DqcY3PllNG7Ngq20gjJB25900TP4/6HNR7SCoYKnay5IpBR1tcCLLn03MOdECEp
 VDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767978758; x=1768583558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67AWTeughWk+XTjbkf90tukpyMx6/QDr7JxjAsH5P4M=;
 b=Da4w45m7ieiSlLqMgqiVdzuc4i5XcuP+wN0ImrmAlrHPbo1Wir/vuMSpS7ZffMqFrc
 1R93xdpt83AVp+uXe/H8zxlEdOMZ71hj24fbUpnBe9gfDjEakKveX/cfOqeQ5tYVKyLp
 xjG4cV8Du7LPP2ZMyaCxVPxVwx1vsx9LGY/tqTriq/4xis5a5N33+JcQYvQqSnYRRo0J
 vPyrZKaPpkR4n+9tVcAU4vb90MsCdBQf7dbHrDzLagHyRWg2YXLwfYh1+eV7uQuwUwRg
 sJNawKy59bF5vcAWWUobD2UQKWPWf4tEnzNbIuGPUrWpOCckTZW6iyEeBgDRYq1eDUvz
 JhSQ==
X-Gm-Message-State: AOJu0YyFMe4+th5yh7x7bkIs4wCDPfxSN5dkcVUWZ7fn4OA7ApHnh9QM
 YjnpwBKZs+ux29FEZwY3sn3tnLFPGWZaiDafMo5lK5qo/XlqQzwuaIXqi9qYRk4POCYquoNvK0T
 kqOIw
X-Gm-Gg: AY/fxX46YeHbb9mOel0zZRIygdHjOlOI01zga/2lIc9hhX6BiLbUx3xYWNaOHD4QIV+
 fF8LjIL7o8BhfEG829a1yKZBOhpSAIeTLNCRLORR3KEMvFdHWMEa3EdR8JNCp5Fiyz6nT7y2vVW
 mI7aZeTeem+VKvYPA6muOIDnXwaqyBHCSA9yFFCJtsxhTXvm0eOYtQZN0KekNKVG0MsDIawAhLJ
 z3xGkosAScX0nPxhRhQq21cpLkd3q6vFHslA64oUl1RCFOaYjIxVFrgJeWHzl5sAVjfgYMthoPy
 FnfzKCtGwSL3BbQhhbTLautzmFrblqf0ccgTSZH5ScHtB0QPWibVo5818p+f2zvT7BRN6w/oCvI
 aP/OlZe5w3gKobOeaA6+fyt9b9natrmvpZTYkuNlu/RcL/oNSn7zKIRqu0Vfrvw6w0ub2f8Yoa9
 pTwun4fTXBwK9Rao7QzxPDYBuegeyzblMWn+WoihyDWQqLVyRLca9hhzE=
X-Google-Smtp-Source: AGHT+IFQjlRpjhJhJOPlnzFXzIx8hGKdmwEMAxyN4W/10M+nvThntCANlyQLFeq82h1BskkQxkXQmA==
X-Received: by 2002:a05:600c:8119:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d84b2ccdcmr115854875e9.9.1767978758144; 
 Fri, 09 Jan 2026 09:12:38 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:c170:c5f6:f3f7:a97c?
 ([2a10:d582:31e:0:c170:c5f6:f3f7:a97c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f65d9f0sm226040395e9.12.2026.01.09.09.12.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 09:12:37 -0800 (PST)
Message-ID: <922751c7-93ea-4eef-9808-6ef332104468@linaro.org>
Date: Fri, 9 Jan 2026 17:12:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] bswap: Use 'qemu/bswap.h' instead of
 'qemu/host-utils.h'
To: qemu-devel@nongnu.org
References: <20260109164742.58041-1-philmd@linaro.org>
 <20260109164742.58041-3-philmd@linaro.org>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260109164742.58041-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/9/26 16:47, Philippe Mathieu-Daudé wrote:
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index 34a75b7f43b..0621a6c4775 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -28,7 +28,7 @@
>   #include "ahci.h"
>   #include "pci-pc.h"
>   
> -#include "qemu/host-utils.h"
> +#include "qemu/bswap.h"
>   
>   #include "hw/pci/pci_ids.h"
>   #include "hw/pci/pci_regs.h"
>
I'm getting a compilation error in ahci.c:

     ../tests/qtest/libqos/ahci.c: In function ‘ahci_hba_enable’:
     ../tests/qtest/libqos/ahci.c:252:52: error: implicit declaration of 
function ‘ctzl’ [-Werror=implicit-function-declaration]

ctzl is defined in host-utils.h.  (Build platform is Ubuntu 24.04 x86_64)

Jim



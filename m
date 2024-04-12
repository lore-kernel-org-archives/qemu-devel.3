Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB6FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvErK-0003Kr-Qq; Fri, 12 Apr 2024 07:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvErI-0003KU-S2
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:14:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvErG-0006kS-UZ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:14:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-417d14c3411so8442245e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712920453; x=1713525253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8IsO5LZ3WBcUBOwYbHPBR56scuaYOlQlJqyc8Z83gg=;
 b=j+oXN2vzEsEpXjH7x3hHqeg92CTXsfRMeev/a9ryf7kPCddjQb0AIRMF/yRja0KqMV
 c6xw4dq0GYrAXgJXPrYzGGcPEiOY1KE5oX/Lbv1ESsCza5MejyUjb95pvgvWryLN7gyE
 wnq4bT1Pgd81PJ5mQPGJEqirqJ3HSpf/EfNeNvW6Ok253t5osUUAXEu12+E1GJcmdg9j
 7+xl6Nqvj6Xez0MkeW/PvcbJ16jT1FE4POr1NZiQHqyh7ATTW3lWCaaar2wNo3NqjFSV
 y0ZBS2HLKQ/ULhmS+yp/+edteK23BDMXg4ChGSV3cjeFXCCbgwbXTt/oc/WAZp+ZrbBg
 Mbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712920453; x=1713525253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8IsO5LZ3WBcUBOwYbHPBR56scuaYOlQlJqyc8Z83gg=;
 b=h2mikw2nDpT0DU/flwa2krLMZo5Ob1niwoK9v5FEJDRJFn0WWsj7JBJ0aCSYm7fykr
 6em3TWaSRa1u6NEF10VcjyzXNi/0xKAP6XLI26yTMEHLn+PHi1g/He0ftAwGWZNVXDAR
 Ip/cS2FL4rZqi5BWFbkvTPxyviAkZ/H99V9m7hOLUNryPvLo5BrWKAXVV9cUPL7AQX7r
 V2sZb6362+hAOxuQM7uQUT2CfpTSV/jTUJbHlusGc860wzhQL2fIvlOc/yzLXVyhVqMp
 QgFbyD5RqeSJdZQN9hFcII9U+unMTCQ0PBN2ufsjAXYPiOR7NeBqc8y2Y6kB9uxUWNdV
 n5Ng==
X-Gm-Message-State: AOJu0Yz1V49h/P31xcHS1gGfISXV4sWlwr6wvsErUmysRSjQpOFdvRsf
 f1gfqD5fBpACoZbNbPnsu7GsFDsatumcB9DYAV84+uKjKjhplU83IuI7wKc4Lvk=
X-Google-Smtp-Source: AGHT+IEJyzq8RQSIslDLUU7tO4EAeHKl+Gg7v85lA6Bal3fFreregzR6sShech3gSSAY+YlC1G7sEA==
X-Received: by 2002:a05:600c:1c13:b0:416:7233:9d1e with SMTP id
 j19-20020a05600c1c1300b0041672339d1emr1850771wms.28.1712920453079; 
 Fri, 12 Apr 2024 04:14:13 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 z4-20020a5d6404000000b00343b09729easm4038980wru.69.2024.04.12.04.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 04:14:12 -0700 (PDT)
Message-ID: <921ae82a-3007-4435-af7d-91a08a5acae7@linaro.org>
Date: Fri, 12 Apr 2024 13:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
To: M Bazz <bazz@bazz1.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240412021509.145502-1-richard.henderson@linaro.org>
 <CAMFqb-bp48=Kd23AzwZ2U3AsPbnwUBUiyv=37ua1V_RDQ3wdyg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMFqb-bp48=Kd23AzwZ2U3AsPbnwUBUiyv=37ua1V_RDQ3wdyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Bazz,

On 12/4/24 06:18, M Bazz wrote:
> On Thu, Apr 11, 2024, 10:15 PM Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrote:
> 
>     Reads are done with execute access.  It is not clear whether writes
>     are legal at all -- for now, leave helper_st_asi unchanged, so that
>     we continue to raise an mmu fault.
> 
>     This generalizes the exiting code for ASI_KERNELTXT to be usable for
>     ASI_USERTXT as well, by passing down the MemOpIdx to use.
> 
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
>     <https://gitlab.com/qemu-project/qemu/-/issues/2281>
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
>     <https://gitlab.com/qemu-project/qemu/-/issues/2059>
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
>     <https://gitlab.com/qemu-project/qemu/-/issues/1609>
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
>     <https://gitlab.com/qemu-project/qemu/-/issues/1166>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     ---
>       target/sparc/helper.h      |  3 ++
>       target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++------------
>       target/sparc/translate.c   | 49 ++++++++++++++++++++++++++--
>       3 files changed, 95 insertions(+), 22 deletions(-)

> Hi Richard,
> 
> I see this is in your hands now. I agree with your take on leaving 
> writes alone. I'm also grateful for the opportunity to collaborate with you.
> 
> It brings a smile for the community members who will be touched by this 
> amazing contribution. I see them happily realizing that this perplexing 
> bug has been solved, and in our case finally able to use the debuggers 
> we love! :D

Does that mean you tested this patch and it resolves your issues?

If so, could you add your 'Tested-by: M Bazz <bazz@bazz1.com>' tag
when committing this patch?

Regards,

Phil.

> Thanks for the proper fix, qemu sensei!
> 
> -bazz
> 



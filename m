Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C0C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHN4Q-0002o2-NR; Wed, 12 Jun 2024 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHN4P-0002mj-9T
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:27:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHN4N-0001r6-Ba
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:27:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4210aa00c94so57074285e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718195233; x=1718800033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8aHKRDO8rLoTibpVTgW67jXrAJr6wJ4OYhiGd5p21jc=;
 b=bAeptOrCqTFI/IbUgUwdNiuc8UPIlPCqIBjebEv6JPpemkAz3gj6TDMxbuW4FC31oV
 vOPzPrl16Y6ho0oJVlUMUQ/y1flD4zbQpkB8fm3kCevqOzvTxa9NombpKpHwWZrmeZnA
 SPw2tsAZiBmMqhcmcJv3hweP7sCG+pIV+Oe5K5uXpSa8rk9jQk1+ws27WSckGi4EKIDO
 AiUuKuEw88A+YiNSzTdhDfqWRLBnJaMR2/tnHY8T8+tSqtuZ0ppVldn+JqM4YZl/+2CN
 9EBi2DIUU0ZXerE0GBxIdAzfcHyHcl4s352frLNN/2wGHBPAKMlVOygyB5K9zzJojSo0
 tNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718195233; x=1718800033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8aHKRDO8rLoTibpVTgW67jXrAJr6wJ4OYhiGd5p21jc=;
 b=DENOBTI8CvsnvsGB9JegvjFwWN2RGMc4KJwRhLpiIKD5l6ktENRW+NEtSl2JVDW8ZN
 sPKBOZgoxjFAXghRAqin53McPVB1/HTOGRtFB32NvjKMzXslKfH7qSfJARf3TLGLoZ+7
 5ahZ0TDNfoE11JKGdAeN/qzuOC8whU9CgFPhvYaRxiMngXn63OWOuiUuWykPfCQIBisY
 RMJWxAbbpi0fhzdP/fWGYEybYwOg/AFwEjTi2NbQYNMIH1I0NkPlI1O6Cusf6MfM8MbV
 PULc8Iyg5c7S4F21UPM9CaeeuQhkljNMlMW8U8AmtvGaqlBJQWq/vrBgLqsCWTTAm3HX
 xemA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXszBPt18ryHZuVYUI5MXS2hWmxugv3oREzcq91jsKBtiL8Rz4ujTsa2QHm15iz4j/fgxbmdKj7vWTJrcfldx1dGW2/QRI=
X-Gm-Message-State: AOJu0Yzi3Zs6pYaSnnG2he2Z5Uqb01L5bhKiU5+pluukOf93VrTPtNtf
 WXK7uM2wne0vvAItIb3c+M+LHjj3c6MluMxjfnlrTIdQUGTCXk8VQ6+1vfKudq0=
X-Google-Smtp-Source: AGHT+IHZShDHPE/iNOKzqkkLukUH/c9f63tQiCRp36J6DsRt1UX+0BOjjkzsdE+j5xj+qdxfCzF6sg==
X-Received: by 2002:a05:600c:3585:b0:422:62db:5a0d with SMTP id
 5b1f17b1804b1-422866bc360mr14300325e9.29.1718195233214; 
 Wed, 12 Jun 2024 05:27:13 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422871eb9ecsm25301845e9.35.2024.06.12.05.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:27:12 -0700 (PDT)
Message-ID: <ef483031-499e-40ed-a2e4-67350a702069@linaro.org>
Date: Wed, 12 Jun 2024 14:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU plugin past, present and future examples
To: Robert Henry <robhenry@microsoft.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 Julio Gago Alonso <Julio.Gago@microsoft.com>,
 Vinson Young <Vinson.Young@microsoft.com>,
 Toni Juan <Toni.Juan@microsoft.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <DS0PR21MB3907C54A543A8540AAD1DA8CD6C72@DS0PR21MB3907.namprd21.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <DS0PR21MB3907C54A543A8540AAD1DA8CD6C72@DS0PR21MB3907.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Robert,

On 11/6/24 18:53, Robert Henry wrote:
> QEMU plugin experts:
> 
> A few years I wrote a plugin for QEMU that saves the instruction stream 
> to a file for offline analysis.  QEMU could fly along at about 10MIPS 
> and the disk would soon fill up with large protobuf files.  The offline 
> analysis runs at about 50kIPS, and does a variety of analyses, such as 
> simple disassembly that includes kernel source file name and line 
> number, popcount analyses of displacements, Markov chain probabilities, 
> etc.
> 
> To get the speed up, I narrowed the scope of the plugin to only work 
> with ARM64, although there's still a lot of support for x86_64.
> 
>   I have not kept pace with the QEMU plugin API changes, if any, to 
> support vectors, masks, and so forth.
> 
>   *
>     I did this work for my current employer, Microsoft.
>   *
>     I will retire in 3 weeks.`
>   *
>     Nobody in Microsoft seems interested in picking up this work.
>   *
>     I'm working with our open source office to get this more widely
>     released.
> 
> The plugin code that runs in QEMU is complex, but relatively 
> straightforward. The offline analysis code is idiosyncratic and somewhat 
> fragile.

Thanks for trying to share your work with the community!

> Do the QEMU plugin experts (cc'ed here mostly) have a suggestion for 
> which public git repository service has worked "best" for other plugins 
> that are not currently part of the QEMU source tree?

Cc'ing few more developer familiar with plugins and the source code
organisation.

> I will try to get a repo in github.com/microsoft/ but I do not know what 
> is involved.
> 
> Robert Henry
> robhenry@microsoft.com
> rrh.henry@gmail.com
> https://github.com/robertHenry6bev <https://github.com/robertHenry6bev>

Regards,

Phil.


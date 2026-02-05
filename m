Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DFAECD980
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1SN-0007rv-0G; Thu, 05 Feb 2026 10:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1SL-0007rd-El
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:39:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo1SJ-0005ga-MH
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:39:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso9447205e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770305981; x=1770910781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0QMMAt7u/W3kURzsiue9Mogq0i0g8HCQ3UJiZn7/BdI=;
 b=rppfmYb5O3W6LoJFfYcRCI0g7QlbxUVxuMeDGTIZbZ4bG8GlFx0O1Uuy9n/uI6jz4E
 6K59JGqizbqa/K+60aWFIlbNSadKqdaLnS9Im1Fxbe4Qqpfs2sFYyJwW0QRZCkUX+ynq
 cqu1Ug47x28ygD5QpIKlIvl0EQ/HEdeuK9NKdN33xvq2bzCLU4clCnm6RfI2IOR4dDkv
 j1FY8iVTS3gkrmuckS94YOIrPcQvU10dT9YJhBv7Eg9KesnvPTZQjZGkDcozxQ3373A3
 /gIU1av3WXYc1n20ZTkvmMeMRzQRTUDofkhQK1yzkpu2ZNApVhuid06a+GjwptH66upG
 bn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770305981; x=1770910781;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0QMMAt7u/W3kURzsiue9Mogq0i0g8HCQ3UJiZn7/BdI=;
 b=SuseNmjJYt/BCxhg5ZqMpmNjQBT95hOzUX3xEeUKn8QSYyZuSExRvz7Ya1elKNyfqj
 Gw6NRYNFVkf0hm4y3upiLllC3B0wJkbKCHu2kIwrhKFP2pg1g2vC9cmt3xHz+iaFH8xb
 f4HHZYmlqhYRTOFAztJ63gw8R4UJBCslOXe4lMs+kVKSo/Yk/nU6AGi7GbNdntQUHBDp
 Jm8KnOlUoBtpNj7s0MywVQJLd/X4qAciDejGdk2l0JJkj1Vpfpg7XoEGSHyJRsHMex7C
 clBHE8YlEhjHAS/Wl1yh/C9qX7vLrWNCtQGCPT9MHKKnK/D3WF8gCfHutknwqazNVyoH
 Hv3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrolT/l7x4G0V9vTmKyEDaMOOICkRbl//f4/0M/D+ngoipYF4w+iyEP05oJFx99GM03GpDypoZ/ukF@nongnu.org
X-Gm-Message-State: AOJu0YxEQ3hjF9fww6CTDhZ9GhzCLzEy/1v78mJGvyWHrOD4PtpgGz82
 b8St0yA+I95OlnoiWo/fUiPjs2s20cmqiVfsmSIxYDsS+KUqnT+6WGy8aHNLtqkVhnY=
X-Gm-Gg: AZuq6aILq6HY91Fe6NJmnYESM1o68hgSeHnGws0UXxxGn8bqlw1WhDW27XiCr/QXFmz
 ULpHZqF3d8OGr2x5+bMD1bRJIMtcWKh3O3WdaOQsuTzTYpY7SuhQbCrG3+ihNw+IKaHYQgU4olR
 sGo+GdD0sGhAgq9AmpGyuYJ1OiyzbYQi0U97MqBO+DvtqCW/az7+sHlSuF/UFfrnaq99V9KKjAK
 GliUbkASgmiT8iY7R+j2MzrVKP3Rx7Djh/7bNEfnCYvkr0A6OEF0Mh5R2w6C8e3w9FTJzma0XNE
 Jdnro7qWfRrNhrSgifP1lObBq2RbW/xVEICmzZbIH4xcz3XLERpkPCfNybHnLYdGg1/PGwnsLsK
 XkJSbqujgDOe92bY0oW46ozlTN4NUIgPOtbPCpBID5oAbjFt3mbZTdP1ex9oa6I/G4AIKoSQbvU
 q3CnJ+G2j/E5RgNLWI/00GyohEK8mdoMlQiwKAKPCRYM/yNLYHS0MyOw==
X-Received: by 2002:a05:600c:628b:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-4830e931e2amr97658925e9.15.1770305981222; 
 Thu, 05 Feb 2026 07:39:41 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm61415405e9.13.2026.02.05.07.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 07:39:40 -0800 (PST)
Message-ID: <ec2b9446-df98-46e3-b7aa-f486eb189dd0@linaro.org>
Date: Thu, 5 Feb 2026 16:39:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] or1k: Rename the architecture from openrisc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, shorne@gmail.com
References: <20260205030244.266447-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/2/26 04:02, Richard Henderson wrote:
> We have an odd mix of 'openrisc' and 'or1k' in use.
> Standardize TARGET_ARCH and all of the filenames to use 'or1k'.

I was confused thinking OpenRISC is the architecture, and 1k
(or 1000) is the first (processor model) implementation; since
there is also the 1200 one:
https://github.com/openrisc/or1200/blob/master/doc/openrisc1200_spec.txt

But then I read digging [*] I read "OR1200 is the original
implementation of the OpenRISC 1000 architecture."

[*] https://openrisc.io/implementations.html#OR1200


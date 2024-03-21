Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8E3CD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 17:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnM1E-0004al-MW; Thu, 21 Mar 2024 13:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnM15-0004O1-B3
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:15:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnM12-0006yP-TR
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 13:15:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso1491116a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711041342; x=1711646142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oSYt7LsVH8jFKn+JCFIJODpA3VsWy3bMjgZ/771cPy8=;
 b=Uyo7eOfBI2c7tpQRypYvSsqbRxWfxxqDO0NsiFpfhmkJIv8K7+U7BPXGrJbQWxSl4C
 kJTdklrQXHTjh2P/8+K+MLsLF5/kd/iW/iCQukYF04E/VSNwLXRnNv3gG9fqBop09gw+
 dLpaIYsMcaDSOVcQolFcwqEUmmj7xWP5Gn5X7X5SB2A+q4RwEJUmQmtMbgBp2lDqbgOW
 hi0RD3Lkg+hiu82aPPPnsRXNgcjQYcQqxdYXhJM8RWy3a7KhfoHBpd4swB47v3Ofpb4+
 iMEI257KT+U9bicgm31zcORV3F9lR7X2O+idoQexzmG1uy1gG6np0A+cADH2Mgw+05Az
 vzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711041342; x=1711646142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSYt7LsVH8jFKn+JCFIJODpA3VsWy3bMjgZ/771cPy8=;
 b=w6qhhY716CcE6n5uhBfcsq06IQZydmlQNzqzWVYRGZHdJfkt6wvRTg7+RSb/9pqux+
 x1R1tSDB2vbpD/Z7EO4EsIgRVYfol/fh3DeCiBrBXSeUU88hqK8kT7n7DAHP1gnlZuDf
 IIRPuxT+1B2AfJnwe+++wrDIgzf5gp89mhbqvQRhqFadgpbnFJMgBtXRoOqPcVMQqu7c
 C3IX2rUIYLFLUNUXZwtqJi35/B4ntxkT+bzL71AXYp78zsslTRwEaEWXlVsbod9+Tviy
 7BvI3U0asWq125Q5n2H+cuj0pHS1n9/lH1nRG6OhW4xGy8mrZDjLwTqB7EbcGXPubOdR
 rqNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3winsHCpOb0GnBt95LlUVKpsbSfhFv7s69ShNNEovAwoedj2ymND2RO8DWdYC5pNbCk/tRh4TvMt3LJYDSP1NRWswYh4=
X-Gm-Message-State: AOJu0YwUL0xKKJenhL3Z3Rk/whzI/hxzBF6ZJY4Y3/NcCWN1YSMkFHpT
 TU9Fjd7Ic07BlNPxNxSK5ADJeGBhbSSdfrboH2CaxZ9LMAIMB/bFuua6jNuAzVA=
X-Google-Smtp-Source: AGHT+IHD7+xQhV5YiKsfSYuI3JGeSOJm2M43aKO2EgTgvnGpvbnx7Z50TQnEqX6gFbBJCQ5eXwG+xw==
X-Received: by 2002:a05:6402:1d2b:b0:566:41f4:a0ea with SMTP id
 dh11-20020a0564021d2b00b0056641f4a0eamr3447353edb.37.1711041341967; 
 Thu, 21 Mar 2024 10:15:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 el9-20020a056402360900b0056ba017ca7fsm76589edb.87.2024.03.21.10.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 10:15:41 -0700 (PDT)
Message-ID: <f74d141d-69aa-4d7a-8536-5378e4353db3@linaro.org>
Date: Thu, 21 Mar 2024 18:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc/pca9554: Fix check of pin range value in property
 accessors
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240321160154.901829-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240321160154.901829-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/3/24 17:01, Cédric Le Goater wrote:
> Coverity detected an "Integer handling" issue with the pin value :
> 
>    In expression "state >> pin", right shifting "state" by more than 7
>    bits always yields zero.  The shift amount, "pin", is as much as 8.
> 
> In practice, this should not happen because the properties "pin8" and
> above are not created. Nevertheless, fix the range to avoid this warning.
> 
> Fixes: CID 1534917
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/misc/pca9554.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Isn't it the one Peter fixed in
https://lore.kernel.org/qemu-devel/20240312183810.557768-5-peter.maydell@linaro.org/?


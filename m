Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074CA10AB80E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qdl-0002Fz-Dr; Thu, 26 Mar 2026 15:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5qdi-0002Ca-D5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:45:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5qdg-0005Yv-GV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:45:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b0c8362d93so4772435ad.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774554307; x=1775159107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/2WRlAg4RzvQgIx6BJ2MQB/f2608hLUgN4CYPnAxAw=;
 b=BJlLQzkSK59gx2szMyVGY0htqoF2G45SW7at5Kf+/7O46/jYbITlFxjtryWzD1b2PI
 qZAWO3tw/erpSiNZK0JYpQS/B96oLjnE3nHZA3reYOfx0cC8Po3h7LejUDx07SAJqnfc
 mruXWxcNeh2tNGykucHRT+9pUVj5cwFWaMQriZ58/puB3KTWtKyKpRm4fy58cvfuQCjL
 KDWoOjSEF6kDcfzwDMAFQsLdL836TdKgktfjfvPWlhl0w/Xtrf5xDPV0Wj7JVmsPozo0
 ZfMlngvcz+i+7aEn3xzFrwIYwWFzqpGJf/1NwrKeIjg4Dk26mLgyBEmxHhB9pLHOXDDk
 gWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774554307; x=1775159107;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/2WRlAg4RzvQgIx6BJ2MQB/f2608hLUgN4CYPnAxAw=;
 b=q3YkWmVg28s1GvWgaTHXXExi0egd4qN5YzfP1nHHpfHCPWZXVO68hiqlM4NVIY2GGo
 VBb7NzPf7lYpciWwygeulHUPvyj3gXgUv6gFb7I9GsqAflOqPNNG3/6pogBjKdc1pqyu
 v6gKqjbHn4daVmrL+nXsi/ChhGoooS/5XSbzb8dEPp8TTRBm/cOQjBj98K9VUykEvceb
 OtZ2ACA+wg+uubX1dp34VlUGCnLX0F/MsyBbwn7EtvMUjmY7pn51LVHSMUT2RYbH+pWQ
 RPIucy1yf9Uz2nj6L1i/KQIEM9AfBrdAITddvS9A96Ccm8OerdGKuR6d9YBizkjzhTub
 dpEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWoVvJMIAAxnGxt36S3LMCCn715lIs4HCXeW2+pzPIiUWSZWZJPxwt7KVewqzJ9nzSd20mtpTD8Je6@nongnu.org
X-Gm-Message-State: AOJu0YyUdaYWvuhRSygBSTNuOcG+hD6LmNl0ji6q8cT2wn0t1MqE/Jxa
 VQg9UsfT6ku8qTZjanb3DjpXbpyPqg4VkgaF3G/WuzcuonwdpRjLhUSD6y5hXzP7hFs=
X-Gm-Gg: ATEYQzxvppQlIgh7KWArauc+1UVvizRFmAhDMII0XHcx2hGot2uvrBhkde45Ev7BkyQ
 rvXs1QfHAsBKo2StZJFFVVlBEJaFBfYtPaBQkBK+VMZ6eMhLVnENe0Y5meR+IAyJEQmceXmEiH2
 QgaP27awclDjS/kPOmvUpiIyIcJMTT799ZOE9SCyo0pIczuk2UKAoSzfPSSyno9TTLYYCgDuanY
 TP/L0S5Bzvj1agurTgcgJzzd4a2I6x23ngM6vfs2l1xYSF63DoXLgKVHLV2CG+Oy8haUHL/IV3a
 U8jlwB1/HkTtH7dfIl4mkg5SLvd/X+2VXJ/X5w+LbT/tg8XO2nRpkvuBXxwEPWVxq/+ibvk1d5N
 5Dg38L00RAQq9x37OHBn22OCHrghQjJYwHjd4B3eWdgurK5IRR00KX2nnSCurhE1Ch/79mdupNK
 44MyYqBnS5fhdm1MPDkNe/+l5I/vRsQkMPGc76pnzTRvGRlqMmi2NCG6J2n0iYxyMI+NMdfmDyy
 rjEgM4=
X-Received: by 2002:a17:903:41c5:b0:2ae:ac0c:5a1c with SMTP id
 d9443c01a7336-2b0b0a403e1mr96822335ad.15.1774554306905; 
 Thu, 26 Mar 2026 12:45:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc9176acsm38493545ad.82.2026.03.26.12.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 12:45:06 -0700 (PDT)
Message-ID: <3f295cb4-20ce-498f-bd11-64b397cb2075@linaro.org>
Date: Thu, 26 Mar 2026 12:45:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] target/i386: emulate: LOG_GUEST_ERROR for
 read/write from unmapped MMIO
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260326193358.97858-1-mohamed@unpredictable.fr>
 <20260326193358.97858-4-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260326193358.97858-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/26/26 12:33 PM, Mohamed Mediouni wrote:
> ReactOS's install ISO does a bunch of 4-byte accesses
> to 0xffdff124. This doesn't happen for the boot ISO.
> 
> It looks to be an access relative to the Windows KPCR
> which is at 0xffdff000 but mistakenly done prior to
> paging being on...
> 
> https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr.htm
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/emulate/x86_mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


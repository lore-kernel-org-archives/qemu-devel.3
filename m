Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB4EFEC0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57K9-0005FM-Px; Tue, 24 Mar 2026 15:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w57K8-0005F7-IC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:21:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w57K6-0003ae-Nu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:21:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4870206f73bso24775415e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774380112; x=1774984912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIASM8q/q6lH5xs+H50lh7SABHLA+Ey4wC8TjuO3eII=;
 b=aIeU1CUDyDo149pEXD7+ZTAod2nPWz1FZW1/7wBecO/2iDs9NhVCyF09FlSR14Tq80
 t8dhoIYlv1hqYCpv+3o5BQxgExnV75k8wpRJPzaF6p4Yj3NYg4KwAZzC+IxkIuqzMRbj
 U03PVBrIkEU17l748qBBTO3i0JU33Xm07TPR7eF/fHwXuG7n30rKJZMz2yt53juY61Vd
 rNNEbW3PTzKz0xfE+dc89LVFhHAI/7QuGyYt7k+O9yFeZEaMXpenW7hyNPDZRVu8o6Xp
 WWsPOPpaH98KB/pyQUBMcYtoPetiBGl4wI2Eas/PnF5DWAhVp6H4RNm15SszOg/NutZF
 BYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380112; x=1774984912;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIASM8q/q6lH5xs+H50lh7SABHLA+Ey4wC8TjuO3eII=;
 b=ErCESZQi+/5XTWXnEYjcGDY5Bx6HGeeVYCmyjoB2JErnDFSH/gwRv7BqX9Gz/yCnW7
 G8UgQq6vuEdPiZSi7OmWQlxUG55p/AdYj/h9dBVr1lFLF1q2r2q9NKGNDRGYx/+D9/qW
 LR5LgExLCctydBMUoqqp3BstyaHq3uEbaSRTuEXjSG7WXk4t/REpFsFeDyoEABbHq1sZ
 OqL25oPavAXj21Awov316ZFlhLJmR2Qu448cnWMGYg5ZBO2XD6wMGh/fMcTrgm4A909p
 0iVBxqPqavAHlmkeGR4S4u7Nt+/FwM+pTCPbyazTKMwxTiEyvThknNCUpv64LH8vA9TZ
 A46g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwhQQUddZ03ldzMfF6H+H9k2LiWW5STLgAr2dU3SrsomMq1NXxDsxln0cHQcHhiZJLjZgqnIyjzcJY@nongnu.org
X-Gm-Message-State: AOJu0YwxVXugVU7caFeP+yrII5G5NlUXubbJEphL6krXfaeNVnscyk2w
 pPw9rNEpfNKqRKLNn4by05PKZtQbqjO4nXY2OrmWi98Jf3mEUgQ0LwGLR/4SZ0aZ0tjS4oJ12up
 sHweOKu4=
X-Gm-Gg: ATEYQzwnFAYuuGTAIvWmSf1xfLgB89dgC6t7t1chuPal88Gdlyg219H3eLUqX2Zitm0
 kZwKTsWufjVjwMbXTxAPb6n5TXmKjUPArRGHkrRnziC3v6UrbFdQm2V34kRRGyB6vbey9iwFlJY
 ocJLeqfSYxqxAY54bTbQPMah8Jmo5MPyHbENpwRnmzx0NUwOr4VLkwnpcTV3xRpkCagXBF1piiB
 Sak/ScSsENH8KeXPSSDggtisO31/ZbgTz5XqUFixdHR3Xv8g1SmFqwcK/a+CSiR4aiFNY6nDEJP
 dgejCPiCA/kRbLAlZuBakxIy+hkAxOL3hXYsV7rMlrRqBbXzZcbsq7PlXDtt4H93cG8twn6DZmK
 kGOaXDj/rJbcY+LLa4ClvAj5Lyy4cP0iSXDzppjIlgzoPNITO1Dbx/PZzdHywcYdoCDnmXsFvlR
 PxPjFlBO9hhoXnpRf5hEmanV7F7Hc1uqyncdstuTQIngM6eu3HfFxbP9QKs+yuwBM32FSmiyC2B
 OcU
X-Received: by 2002:a05:600c:1f86:b0:486:fb5c:3b20 with SMTP id
 5b1f17b1804b1-48715fef819mr15089335e9.13.1774380112460; 
 Tue, 24 Mar 2026 12:21:52 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871174f2desm90940085e9.9.2026.03.24.12.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 12:21:51 -0700 (PDT)
Message-ID: <e5d54af3-e3c7-453c-b087-d0699d5241e2@linaro.org>
Date: Tue, 24 Mar 2026 20:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/27] hw/net/ftgmac100: Improve DMA error handling
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20260323165218.96607-1-philmd@linaro.org>
 <20260323165218.96607-26-philmd@linaro.org>
 <37e7a5da-9fa5-4602-97f4-d3190f638b01@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <37e7a5da-9fa5-4602-97f4-d3190f638b01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi Cédric,

On 24/3/26 09:03, Cédric Le Goater wrote:
> Hello,
> 
> On 3/23/26 17:52, Philippe Mathieu-Daudé wrote:
>> From: Cédric Le Goater <clg@redhat.com>
>>
>> Currently, DMA memory operation errors in the ftgmac100 model are not
>> all tested and this can lead to a guest-triggerable denial of service
>> as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.
>>
>> To fix this, check the return value of ftgmac100_write_bd() in the TX
>> path and exit the TX loop on error to prevent further processing. In
>> the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
>> flag as appropriate.
>>
>> The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
>> AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
>> Nevertheless, since it is supported by the Linux driver and it should
>> be safe to use in the QEMU implementation across all SoCs.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
> 
> 
> Philippe,
> 
> You can certainly apply the fixes, but I don't see any email from you
> about it. However, I indicated that I was applying it to aspeed-next
> as part of this series:
> 
>    https://lore.kernel.org/qemu-devel/20260323125545.577653-1- 
> clg@redhat.com/
> 
> There is reason for it. The SMC patch is required to fix issue 3335.
> The patch should say so, I agree. My bad.
> 
> I see that some VFIO patches are also included. I appreciate your help,
> but please contact the maintainers before, I believe I am responsive
> enough to requests ? I will rework the aspeed PR I had prepared
> and update the VFIO tree.

I understood your aspeed-next branch was for the first queue to apply
after 11.0, not for fixes before, and this one felt worthwhile fix.
Indeed I should have replied to the patch with that justification
and you'd have cleared any doubts. I apologize for having stepped over
your maintenance area. This shouldn't reproduce.

Regards,

Phil.

> 
> 
> Thanks,
> 
> C.



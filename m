Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E699C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 16:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRDX6-0008Pw-CC; Tue, 09 Jul 2024 12:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRDX3-0008Id-71
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:17:33 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRDX0-0007x7-CD
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 12:17:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so27673255ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720541849; x=1721146649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQV9IqPRxLGXxLIQTrXSG6o4U4NPQXcg+KnhPigLzPU=;
 b=Qf0xGbHLmYxaSuUWzOJPY1OLswLa6Hwv6yl2TrVXLOYbAZZbPaNRsWRdV03XuBnE+Y
 Je01S2TYCEPaGjQxqvioE0+V7qbsPXTlpYgQXx5vdlWTxz/Byagc4oidUNd3DlItdeEB
 AJlwLa0a/YsxPdGtM7Ds/XQow5Ksp0rXDtBt8+hFfoidlplGbIRJKgfQhtC21/lS7+8h
 RzqPK/c/BZnrOv6fskQfPYTTus8awtLRoyiVat/Q2H6xQrkEsntiYjvDSz44f3KoelMG
 mByCIzv+pguKJu2S28QsDklC8xT5SViVNbwipo48Lcg4wTEArSglNRqEudp+WbYmsbzo
 pSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720541849; x=1721146649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQV9IqPRxLGXxLIQTrXSG6o4U4NPQXcg+KnhPigLzPU=;
 b=M7jz+4la3r1vJtVbTf93OUCJYjhfT3DGGDx2f+rsql3+BcmoOvg6UnoU7RhqXofEaj
 ZkHfd+O5SK0y0fmhMp4zbtSk8WM5v5XV1EaeCFA+ZApHPbIldwWsLnpRyU4M09Ws17YL
 4ctWeUQofH8q/OvJSGNAbZm+ftGFbIyW4vifaZ3pRgSQUs3j0n0ytBdG9kddrjfFkwqF
 xfy/S9vpvhKcs1PixxE7JbNCBhEfA3gPsThIs0U+LH+7zLYLSHA5veKH6SnM4CDPq+Dg
 wYsnDmQ/lCw8An2R9JZorKCH77Hj7+M/5gEm3UOHuAk1IamHZTEwxTgUz1lN0bnGEdiM
 Xfcg==
X-Gm-Message-State: AOJu0YwJ2bw5c3leVM6eEu2PF4CpNW9xhCMjk5RYxUV11NzDy098YqB4
 CGgTbD2w3JkIBpayTyn5zfHTLVe8VtEAdYdntrpnaS55dYMV/7wJeJP3BhP422w=
X-Google-Smtp-Source: AGHT+IEqFn9mBS8Vt5+bZmKCg22O2o19XY4dner4uzIPBbR6wWU5BqfknXoUk5K2jxTlKdi5XqvRyg==
X-Received: by 2002:a17:902:ea0d:b0:1fb:a077:a846 with SMTP id
 d9443c01a7336-1fbb6d253b9mr21822865ad.3.1720541848968; 
 Tue, 09 Jul 2024 09:17:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a122a1sm18490235ad.45.2024.07.09.09.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 09:17:28 -0700 (PDT)
Message-ID: <c5c033b3-54f9-4c2e-95f2-060e2bb63842@linaro.org>
Date: Tue, 9 Jul 2024 09:17:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 iii@linux.ibm.com, david@redhat.com, balaton@eik.bme.hu,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <CAFEAcA9+EP88kUB_3qpiFdsf1Lqb1NmbqM=+hNaC_5=kYWiJ9w@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9+EP88kUB_3qpiFdsf1Lqb1NmbqM=+hNaC_5=kYWiJ9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/8/24 07:25, Peter Maydell wrote:
> On Wed, 3 Jul 2024 at 00:43, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> While looking into Zoltan's attempt to speed up ppc64 DCBZ
>> (data cache block set to zero), I wondered what AArch64 was
>> doing differently.  It turned out that Arm is the only user
>> of tlb_vaddr_to_host.
> 
> riscv also seems to use it in vext_ldff(), fwiw.

So it does, followed by a second probe for read.
That's quite wrong...

But you're right that it has a similar race condition.


r~


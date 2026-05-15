Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7820CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtON-00017C-S7; Fri, 15 May 2026 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtNz-0000zP-Pe
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:19:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtNx-0006eE-LR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:19:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso79610755e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854768; x=1779459568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MyKNIeXW+HwYwkdHVi332gxDhjDWVKwOyG+rFvAvTT8=;
 b=juvUuLKKvkhf6MQqb2Q22b7517/qI/BJZ2RGH+LjYaqaL/44m2UMGsgFvKKcVc4/St
 ExrIQ4t6/YBH64nqBZ2/r7awwS5DW8u5p/TQv8zmNyl9Czvld/xp9dYvpGYEQ0uxTh/Q
 s9ogKyRXse/s83AcRo0YiV+Vtc3k1Km+qO7bRUwkTSW9149eyFwgB1/yw9LQdEVFFZlK
 cUcUdHdPxlj8vPLvp9IGyqBmhbd2GTpk7dLhoWQKA1A2P6jlPOGT4MO2j/ukr0DYEp/t
 d8yQkpJ+tzPEmhSV/yXoxTRP1ToHwOEIeQ2+tsjqB+mPrj1PIxdAZyghvHHqwtXOY1xR
 2pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854768; x=1779459568;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyKNIeXW+HwYwkdHVi332gxDhjDWVKwOyG+rFvAvTT8=;
 b=hLKyc/xQpN9WecDJ2eB44mB3gaDLiMxQ/91naDMHrCc3QD14CKaWO2ND6p1JFUO2Bh
 SQi+/KkQFMPBZXjHp9Uza+DtABHag4WOE59gZ35lG/l5waPph6ubplNXBrz5TGCZRQKb
 jZY/HeodyQfXJ7AkY3BKu7kM2R482NFjNIDIpEsnuZ+NH9P4KC2oIpPKvs8CCsVEAL/T
 isHYLhC9+389BBE0blF5xIh6Ykv/BKB8MU/RLb3ndc7pZdToUrjcXhLbLKMI3Wv5zKwc
 a6aNKF6QHmEfwlx8XeJsQAiICbxfeRxuM+2n7uGaoM0MtBSVLJqdExCra7QCEY2Qkg5c
 gOvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/k0basHv6ANvJkUILB1+PwJJtrCNbLskbPQPk/xT7h5iulE3zPEYRuj0HT7aKT7E9bjth51iYB6Vu8@nongnu.org
X-Gm-Message-State: AOJu0YyqBzDr5HbjUV2sak0RoGydcImla6E545qobZPujseZiZEe+Upr
 m03/BzobcsFlspfOiHFaht4YO3OK6mwuiHKUojoxgBD4v1SGKtO+m5JfCBwQRYDMtGbhaFywX33
 7phteBCI=
X-Gm-Gg: Acq92OGSFarPzavC6ymQbP1/MRbm34LDr3SEjb/8xLRg4eewl48YvMA6GxRg2iGQ6vY
 x/xpDufCFs77gLURRsNtKggq7OJerxVHrHImCraEubkDfmiscNNa1RITUxq+V+DDugACGE6nQzB
 IHrZj2rRmjCcIUosXmCpYPoAR78qaVV2rZBchE7xiP45vJSJQrZrqPnsdh6Bkzf7xafTdb5GtIY
 0KdWq+69zuC+2Th6HWP+j7Ldo+eDDRHhlxxkLk8UJehc+m7BYquk/ExzsoUXC8VWj4L1TTqMPiC
 gTRbr3BLu0LFd1i4tD0NrGTEdUPFGypNUk10TNnka9v3cHTBv3rxS+DfQsfUB50vYWN+0EngLTJ
 ed63mVt8BexvUzHnhiOrHWHS2hrDaoF2/VmE6zS7AroWRXqKEb0WKGl+88KuhkqKYPRHO3LpZq5
 s/KMY89zy4f8bZDLpL+Tl8dokO7ltMuW5d3ni2uwNLScX+lpiGoenoQzd/RPTh1kyInA==
X-Received: by 2002:a05:600c:a406:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-48fe632a02fmr53110425e9.22.1778854767837; 
 Fri, 15 May 2026 07:19:27 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6faeasm14468715e9.26.2026.05.15.07.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:19:26 -0700 (PDT)
Message-ID: <50c7005a-3b62-48ec-83e9-10e013f89a3a@linaro.org>
Date: Fri, 15 May 2026 16:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core: Remove
 SysemuCPUOps::get_phys_addr_attrs_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515125727.349675-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 15/5/26 14:57, Peter Maydell wrote:
> No targets use the SysemuCPUOps::get_phys_addr_attrs_debug method
> any more, so we can remove it, together with the handling of it
> in cpu_translate_for_debug().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-system.c             | 11 ++---------
>   include/hw/core/sysemu-cpu-ops.h | 14 --------------
>   2 files changed, 2 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


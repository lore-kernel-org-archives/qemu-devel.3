Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D40C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuSA-0003Cx-Q6; Wed, 21 Feb 2024 16:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuS8-0002wU-CV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:48:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcuRw-0007Tx-5u
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:48:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc418fa351so1807805ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708552097; x=1709156897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hlxAVMQey/7xdYaZGT3WiiNZ5rWp9+/Qa2oiSDnORXc=;
 b=bCnCZo+uyy+2xGEtQNuGqmzfbnQCOzXD5QlHoQlg7UJiwrTmu1+FIGb6wPftLwTfX/
 EU4605k/L1AuZ07xyU+wd9xgdOT+DMRkpmP9eShqEPx96rlJcIfEk62TPNdDCsU1omjm
 dlVBSsTRq96fnOHSbhiuxPnK8IsMKLZiyXeeVQRHg2kwqD0L9YflNAuxOvQtRy3Lb861
 AYDmPAjdUfCCjoTV+iPbIB5m+zVE8n3o4yu619nd6ry+0XCOrQyzKyoyZMs9Bj+Ug5Gi
 ryR9/NXkRXKLCQDda84x5QsveBOqlAZ+3d2R0GRYuHicjYi62QjuywWvZmSIBtJxaoQC
 Yyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708552097; x=1709156897;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hlxAVMQey/7xdYaZGT3WiiNZ5rWp9+/Qa2oiSDnORXc=;
 b=NJrcM2q9y71eh6T4LzHw/MRLqUz2DdH9F+enYe8AkIDdDxCZewqBXF9Rcscwiju+Zc
 Z9zX4m33YxwdpAlDiMjb+D6VHPUqROAkKU8kjD3ttxVeumcplqQzIRObjX8Gd3awJr1w
 0ATxSAGL/cZz8MtRixTeBObGmynuJT6r1BRgIi9/i8fFacsu0T2nU3+Mg+aLAOnYsuwN
 1beJj460Wit5zxC16ALIiCGQKxgAswlH/3M/g9VwEHjqRBylLZKdyMekoFdUKBRrQA6Z
 c69yXaLgsmtiX9PgrJSu9q98lgRMs40SdwCXtBU5QmiQndcRm45AUgKgBh3dveT3vkU3
 T5Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbULW6oPtPd7KDHnULSIk+RV66ZTF4AfVTwIsGluOcUS+mckzFbas8zCfETweTcJo4PpClo5QYwihhLCCf/Wf5Vym7aOk=
X-Gm-Message-State: AOJu0YzdGdMcA2dU9mbnjvggZK1d+qGtfoQ4I3mHCEWwYB9YE3B7obwo
 zVaA4LD4PjJLjrhU3KRfU7vapFBU30KQujGUfrA7thY99eNDs1WCyYwZ15L0jhw=
X-Google-Smtp-Source: AGHT+IHdnitkhPNAGHhCQuyGQ84AVqtwv+Hgl5KMpUjDTfleiW4P/AAtMckmW0bX59szMXa8fTdUTA==
X-Received: by 2002:a17:903:22cb:b0:1db:e41f:bab with SMTP id
 y11-20020a17090322cb00b001dbe41f0babmr979199plg.32.1708552096832; 
 Wed, 21 Feb 2024 13:48:16 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ke8-20020a170903340800b001d901c2087esm8577345plb.302.2024.02.21.13.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:48:16 -0800 (PST)
Message-ID: <d2f050c9-070a-4cff-b9c0-754f5d30afab@linaro.org>
Date: Wed, 21 Feb 2024 11:48:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/22] hw/intc/arm_gicv3: Add irq superpriority
 information
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-20-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-20-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> A SPI, PPI or SGI interrupt can have a superpriority property. So
> maintain superpriority information in PendingIrq and GICR/GICD.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
>   include/hw/intc/arm_gicv3_common.h | 4 ++++
>   1 file changed, 4 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

Though this patch is mis-ordered compared to its uses.


r~


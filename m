Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0E1C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZB7-0003X3-Bv; Mon, 27 May 2024 08:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZAt-0003RL-1S
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:10:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZAr-0000WZ-75
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:09:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f32448e8fbso37918205ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716811795; x=1717416595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A13gMQLP+DY4Ikb1gNTczd2i+ELGcp1MR6U9ROsyISU=;
 b=GScTzIcP1kAfkysRhd/hCeUAHGZ730EcDSJOWdj+d5bPnFkESalN6VXDeflkW7e2ng
 EDa6GL33qDvZZMOZYumexuM6lmTC8pavpVG/0jlm20Hwae6ICaQ0w3eNKLmOUnOIFfTe
 yBnnttbDEuYz8kQNV5xUh73woP2UvlTVn9TLJ9kleRwMkDzwzRwtq3HwuKsuurg9tGrX
 2UKmfeiFuJE+/DBwn6t7N+4hJ3AdrfC/3Oc3i3XEmjpyMj8k67BHtWUDeJfGz98MjDeR
 BakntcN6Oxs9H4IRgQMWM4eZcBio6As8vmXnaBlez+o6s2cEve+hyY6KsTSBOeKt3lI7
 Z+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811795; x=1717416595;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A13gMQLP+DY4Ikb1gNTczd2i+ELGcp1MR6U9ROsyISU=;
 b=jjPAACTReqeMSArRG1QiH/t4oCYtjH/TVQQV+34HJpjKM2w9jorqcBmQ1RkDuWkT9y
 /5SEfMvTEn7oEuQA8cIya/h/cadbF9Yd7La3lpHQyTHw5e/FhFQjjSqhhGscb9r2kUPv
 uh4gl7+xPHLaQN1SuKhp+AB4iW+RJW1Y7KD48b4MSBuzTqGAtdaNDRdxhvHLHVEQgJHv
 CvThVDnLj5tS0j32285YDKc/cYUL8MgQZEXus5nmN7LukMdjaMTPiPmWHSzS4F6Z9dxA
 3M1hSW535ef0r/Hh5e1OtYvygW754x0zXy18QSGOhL3NXr0uDi0UGMJvOJzo28MP7bGP
 vC2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV62/lXqQ4IwsDU0wzZL3Hvt1u4YA3IANFXile1w4c6zQ9EIJYEZnqktk5Eye1no5O8NRyDHQc8ko9Nlrq5kiVmNeNGzLE=
X-Gm-Message-State: AOJu0YzHAWUqLbxMeIJtveS/0nvL2TowVNpEbJrLeDW8rL8cbSq0+mRb
 DGJdjS2wyxZiPfw9jevf4NZfGXYHdxDIod7B5NevhmB2xVRKhL8822ix7LjjlyM=
X-Google-Smtp-Source: AGHT+IF/QbS5GJCSuhbcKTwALFrD7d0FkSA3Z2DYXc2FZX3zcKf4P/0UvNwcKXRD75IdpjUpQDvRAg==
X-Received: by 2002:a17:903:41ce:b0:1f3:ccc:7cb5 with SMTP id
 d9443c01a7336-1f4498f4067mr104781605ad.68.1716811794964; 
 Mon, 27 May 2024 05:09:54 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4724a47e1sm37991275ad.194.2024.05.27.05.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:09:54 -0700 (PDT)
Message-ID: <6e46adc9-9e0a-4488-938f-fbf781e72996@ventanamicro.com>
Date: Mon, 27 May 2024 09:09:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Support RISC-V IOPMP
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org
References: <20240207093444.249112-1-ethan84@andestech.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240207093444.249112-1-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

Hi Ethan,


Did you send v7 already and I somehow missed it? This is the latest version I
have for this IOPMP work in my inbox.

If this is the latest, do you plan to send a new version? Most of the comments
made in patche 2 are simple code style changes and there's no technical reason to
not get this work merged for this release.


Thanks,

Daniel

On 2/7/24 06:34, Ethan Chen wrote:
> This series implements IOPMP specification v1.0.0-draft4 rapid-k model and add
> IOPMP device to RISC-V virt machine.
> 
> Patch 1 add config STREAM make other device can reuse /hw/core/stream.c, IOPMP
> implementation will use it. Patch 2 implement IOPMP deivce. Patch 3 add IOPMP
> device to RISC-V virt machine.
> 
> The IOPMP specification url:
> https://github.com/riscv-non-isa/iopmp-spec/blob/main/riscv_iopmp_specification.pdf
> 
> Changes for v6:
>    - Rebased
>    - IOPMP: Fix MDLCK_MD and ENTRYLCK_F did not lock correspond registers
>             Fix iopmp_write for ENTRY_ADDRH and ENTRYLCK_L
>    - Refine coding style (Daniel Henrique Barboza)
> 
> Thanks,
> Ethan Chen
> 
> Ethan Chen (3):
>    hw/core: Add config stream
>    Add RISC-V IOPMP support
>    hw/riscv/virt: Add IOPMP support
> 
>   docs/system/riscv/virt.rst                    |   12 +
>   hw/Kconfig                                    |    1 +
>   hw/core/Kconfig                               |    3 +
>   hw/core/meson.build                           |    2 +-
>   hw/misc/Kconfig                               |    4 +
>   hw/misc/meson.build                           |    1 +
>   hw/misc/riscv_iopmp.c                         | 1202 +++++++++++++++++
>   hw/misc/trace-events                          |    4 +
>   hw/riscv/Kconfig                              |    1 +
>   hw/riscv/virt.c                               |  110 +-
>   include/hw/misc/riscv_iopmp.h                 |  187 +++
>   .../hw/misc/riscv_iopmp_transaction_info.h    |   28 +
>   include/hw/riscv/virt.h                       |    8 +-
>   13 files changed, 1559 insertions(+), 4 deletions(-)
>   create mode 100644 hw/misc/riscv_iopmp.c
>   create mode 100644 include/hw/misc/riscv_iopmp.h
>   create mode 100644 include/hw/misc/riscv_iopmp_transaction_info.h
> 


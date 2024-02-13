Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CD7C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvha-0001rq-Ru; Tue, 13 Feb 2024 11:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvhP-0001pg-5W
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:32:00 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZvhK-0005A9-Dt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:31:57 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1da0cd9c0e5so32529565ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707841912; x=1708446712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNBniDHZtZTYKnGUutiaEEMZsE98aaJqH+XeNDPQ/M0=;
 b=rxD53UGPS452kSQlmEiBnk6EyHHZ6wbg2+gdJOrBtRakxsmLTMo9TcTpTSDZ2N2zoP
 SZBdxMK7IuiUQd7ViJP5f1xJrkG0q89fofhnTv8GSnwUgj6IqGsYoE+BzR/FfRnblKq4
 5EmAwAkYcKaLRlDj+3boVQRyD9LS5NzngZxfwmXsNwJMyUYJL3sTFaY+dg8ITIiSaskH
 NIwrRZY8CMkoJfvLPcezu4VcIpdSc/MCa7SX1eSioJouVf3XG18LVHbJOln+nkG+ivdP
 uyah/eo0Ub8dJKk5I5R9xu0cNrkSJbMoUGg57nFMoaalOFivDO90JOhtfBP88OYpJGqX
 JcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707841912; x=1708446712;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNBniDHZtZTYKnGUutiaEEMZsE98aaJqH+XeNDPQ/M0=;
 b=XXyGMBAtzUAPVS+o7wia+EEQoSQ3Eo72e144aYVvUICSlnWGmUCYAmsWayPpttaLSR
 KHY3KpJep3YgQ/JnCso2ZQ6RPhJGbbCiZVW+mxmxPhTnpFJ9y/iCi78aHHSE6vvtEmqg
 MLtSU1chtsmtEtu7wKHFHovPWaHqTS24JSCZzayHg5E/V3JVbf4C2CADeVWJILuEbZFx
 91DbYM6x7gfT+eW8vTvBhoWzXYZjy2ZoORDs+AwkvCINM6aTSPMd8O/SX+adGjhIwTT8
 jZVn6ZWgSR1MNGIMl8slDT97YT3TyFgR3q+NrVEQlARr3/8wKZjV7qX7yo9UnI/UpGNG
 o94w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe1q5yl9cEJ2djm/fx2B4twIkPG+rhTaZ1lVpvGLS7ilqrpic9S6utXVp28fC+CQXZ8wUJiPC73pbF7YUV/5HsUNFoL68=
X-Gm-Message-State: AOJu0YwOJX1O7jPwIXJ0LSw+C9r0Ko4YJvRbxO3QgcaNNI6XZfhBl3zl
 1VXTA8Rfe+l8xaU1WF2oUNTI6bYEWnUHWWeHxcQT80AXwLdhW2evk1fM8DPd3bs=
X-Google-Smtp-Source: AGHT+IEWAlW/gTpSMV6oQlrPCb+M75c78ktaQbTxlqVRREX9MZu/YHieFmMrVrvuRm2sICA9uCSP6w==
X-Received: by 2002:a17:903:244d:b0:1db:2ad5:562b with SMTP id
 l13-20020a170903244d00b001db2ad5562bmr4866783pls.22.1707841912639; 
 Tue, 13 Feb 2024 08:31:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW3hQSfojGFsCLbaZJFppKjAopQFhPOkNkjv2rg8LVOsm1z1KTp/iU56PpWd96RYV6PAzq1RN3GrDQgT6sme0UF74ePk0w=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jx4-20020a170903138400b001d741873e4bsm2288247plb.95.2024.02.13.08.31.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:31:52 -0800 (PST)
Message-ID: <ef6c0f5b-52f5-4d16-bf37-cfbea8cb4d8a@linaro.org>
Date: Tue, 13 Feb 2024 06:31:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] hw/ide/ahci: Expose AHCIPCIState structure
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213081201.78951-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
> In order to be able to QOM-embed a structure, we need
> its full definition. Move it from "ahci_internal.h"
> to the new "hw/ide/ahci-pci.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ide/ahci_internal.h    |  8 --------
>   include/hw/ide/ahci-pci.h | 22 ++++++++++++++++++++++
>   include/hw/ide/ahci.h     |  3 ---
>   hw/i386/pc_q35.c          |  2 +-
>   hw/ide/ahci.c             |  1 +
>   hw/ide/ich.c              |  1 +
>   hw/mips/boston.c          |  2 +-
>   7 files changed, 26 insertions(+), 13 deletions(-)
>   create mode 100644 include/hw/ide/ahci-pci.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


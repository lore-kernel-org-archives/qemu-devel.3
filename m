Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3771C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T3i-0000EX-Cf; Thu, 17 Apr 2025 13:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T3g-0000BU-DE
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:29:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T3e-0000m3-IN
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:29:52 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22435603572so13100785ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744910989; x=1745515789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ff2G7L2C25G8onm3yIFbfgTblLNgw7wKbsY5vlfAxPY=;
 b=w5KgYA4MZKxvVP6+77GqvMo4vwaFHoIaye9SVKIq8m0V/1u1VXDUNbSH3SoI8/Sl8e
 NP6DFOqUyMBAGPX/zqC14d/wnQRubwVs4oI3/oeTKA6OIdZJfRdIcL5olEexv8HBiCkQ
 FpaVvNYHVEhC3kNGI6kIm9C8B90qmE5gRwkCfLKd53O9g71GewcsI3walRR0wJuQDPol
 KIq+nBex+9fA1FBBg5VTOL//rsBc0c59TnQ1zVtIzKM1DSbUIP5lK4a0ox9T+RqsDnmn
 52UN3APXaal8Mx6OwAk4voESms7/+0E1F0FAKcMZ65Roek/Okzv90DasPLEQm4QnJnSk
 VBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744910989; x=1745515789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ff2G7L2C25G8onm3yIFbfgTblLNgw7wKbsY5vlfAxPY=;
 b=h9LNle5Uqzh/mUenmY1dJ04U1sz754ecjJH8q0Cqt8kpQQ+iChPPAtEAHUHCbJYkSk
 QjrhZ7UiDZjmmN43nSS8eJAxeh3ttd82mDvXoZuSAGZUV9e5zDc7xKPPbrSwtED9L2o/
 y4vDWFpimzTEe4Pv6q9v7/15LAwufB6+EGocbIbaBuvXsma9Gm4WuCnKk3rme14sAc54
 /xk3nYwWermcjzJlnhjc4HzPJkrYdTNwl9sj/VE0bX91hwWnFBu5ca/EK/tZmcKQXfNk
 kgOU44xo1pBtWPs992bM7DgT61wzCSjeH5y9mobpbE5HzAZdZWL7E/8B2DData91tptd
 KgdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4FjocTtgYpGT+Ok0MFnZ1yi0CsXTnCCPZXZ2tWVl/tLovD0K44zyovYzyjEC59pELVSJp9/4oPM55@nongnu.org
X-Gm-Message-State: AOJu0Yyww18t51T/rbiIU+fvuhKMbltUxSiE8i8BNYahmt4YCc8Albmk
 emvnff0CqXwd+FbNsWovZ+pZ8WReafZ2HDoSVVeSpaVNKQYkFoBMUQxRkW0WgOC3bMRd5W6uN6r
 k
X-Gm-Gg: ASbGncuVZBlGJZ8gzBvvu7qLRf2mR4Cpvo11A7X7/Kv3skjq5fzLzGUcIWmp8ZMI/lW
 +ehA7omrt5KLBljey/2NVAJ2X/YhgiS+FlCJQS/9HB/xg/cHv4fdDGNv+AnrrSy7qDbJczYbpYO
 cYewvzQLKmxMlr+2w5JHKnvgP/Z2yK8xCFLzWgg0XLf8UzmZycLGaiLrK8SjiMKeyTDrMpVvBot
 J1x41Ww1TB8GxVOj21gbVRIppm2wj2hbwqRVWQiwqw7/8ClN1UK8c+2m05HkVf/bqclbvLl4ODh
 z7hkZ6n5NNF4HMVuvEKHjLMHZZBaJ0qN8aMeraf9twMP8hh0urko
X-Google-Smtp-Source: AGHT+IECQTgkNplQ6HE5FwxDdQW7jThzBn4pyDv1wf0M5rlYpf1TzNG1VAJMxXrWExA2QIhj+9FjfQ==
X-Received: by 2002:a17:902:d4c7:b0:223:33cb:335f with SMTP id
 d9443c01a7336-22c358bc546mr80984395ad.3.1744910988929; 
 Thu, 17 Apr 2025 10:29:48 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4a46sm2541035ad.147.2025.04.17.10.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:29:48 -0700 (PDT)
Message-ID: <52e9a4fe-e29d-4368-b320-36e00243a080@linaro.org>
Date: Thu, 17 Apr 2025 14:29:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 02/13] test/acpi: allow DSDT table changes for x86
 platform
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, alistair.francis@wdc.com,
 sunilvl@ventanamicro.com, ribalda@chromium.org
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411203159.2917-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411203159.2917-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
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

Hi Annie,

On 4/11/25 17:31, Annie Li wrote:
> list changed files in tests/qtest/bios-tables-test-allowed-diff.h

nit: List


> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h | 42 +++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a1047913af 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,43 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/q35/DSDT",
> +"tests/data/acpi/x86/q35/DSDT.acpierst",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> +"tests/data/acpi/x86/q35/DSDT.applesmc",
> +"tests/data/acpi/x86/q35/DSDT.bridge",
> +"tests/data/acpi/x86/q35/DSDT.core-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count2",
> +"tests/data/acpi/x86/q35/DSDT.cphp",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> +"tests/data/acpi/x86/q35/DSDT.ivrs",
> +"tests/data/acpi/x86/q35/DSDT.memhp",
> +"tests/data/acpi/x86/q35/DSDT.mmio64",
> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> +"tests/data/acpi/x86/q35/DSDT.noacpihp",
> +"tests/data/acpi/x86/q35/DSDT.nohpet",
> +"tests/data/acpi/x86/q35/DSDT.numamem",
> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> +"tests/data/acpi/x86/q35/DSDT.thread-count",
> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> +"tests/data/acpi/x86/q35/DSDT.type4-count",
> +"tests/data/acpi/x86/q35/DSDT.viot",
> +"tests/data/acpi/x86/q35/DSDT.xapic",

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo


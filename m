Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12AAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje1l-00009r-Fq; Mon, 11 Mar 2024 07:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rje1h-000099-N6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:41:07 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rje1e-0000xq-8S
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:41:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so4051081f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 04:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710157260; x=1710762060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8vUd5KfbFoBaAiliTWUqGyk2zBH1QdVhLKHsod/A1c=;
 b=PivpBQHsWX3niIxd15GVislZ4LDxuCUScIB5AbahRflP1Mn1oMS9cecGWlI+8pw6jD
 Ab/SdPPTGBf5X4tllhRfoMtM3fC09z+oHuGDvYuiVFUmagoCIRYrU9R921LbMmXaBSqw
 CDeIwb/Bte6JtvhozQ5ZpNkPqvvCAsABFqP1kA0f3M7h7MqT9wlX7mB2n50J8Uz5wn4r
 fytyx8kgeUmgEwmMf+TCUJgm0vkwpfMwhk49DgJEhAHPtkgvoZ6lowwsFVqDw2e54LDw
 qjRgcFps0HnyKqWL46ygqGsc5ApaKXFjrE/obur3Cqoqru3mkpwLW9ftP6SNM4+Rg1hg
 NQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157260; x=1710762060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R8vUd5KfbFoBaAiliTWUqGyk2zBH1QdVhLKHsod/A1c=;
 b=OIwdnNb6Q75oh9iOhcuZSoyXkjPlbzVEw4B3hQmYOA2y1TnwxF3tHyjq14lemCwxZT
 3PGWORYMD+LCInO/KuMwIWLLMdWd1c7E/cyjKMFrRWhT7AiEWHnooK9pbsjR7JyDe4Q0
 bWytXcbBa9Pq7zHNUtlRrW2CP0MF7eF7uQZU51wgR8p/rjtTULiy5DEwOEF86efItPZo
 d8a33FjZxOdVrBvEYez4LHrR/1T6aYtTPgmguBtQMe02S84LX5xs0DmRMCj1jLk1UBfP
 BgMxANjeXqv/r53zv91k5WJET66P5NAUGBYv3/sTifCSlqxqwQY8wC8AtIjQB4sU2nYc
 pLkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKwDWDoDM3WwzQDkzyakO4bkxj331Llc0pcL9TNprcpxknU8Uky7Ycy3jloI82CTShxzY+4rMyE/U7EVxP2xqBdiGIK7c=
X-Gm-Message-State: AOJu0YyT649oAp31cbETyN3k+jkjFyTZxecRb2ErpFSKm7Ho/kGIHUk8
 fOFnoZstDDUx4hsmXtW4IuhSWO5mphR4bqY83fJ2+DpDpWQ1Xo85J6GIV0iLRZQ=
X-Google-Smtp-Source: AGHT+IEjZ3Yf7EfRPpzCaekWi5FOzfI3wEn76u4T6MPidEeEpBMEKmruuzHxyNxznlb+6afnK+9JKw==
X-Received: by 2002:adf:ea50:0:b0:33e:48f9:169d with SMTP id
 j16-20020adfea50000000b0033e48f9169dmr4389996wrn.31.1710157260108; 
 Mon, 11 Mar 2024 04:41:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a5d424c000000b0033e48db23bdsm6239299wrr.100.2024.03.11.04.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 04:40:59 -0700 (PDT)
Message-ID: <2b81b7be-f3ee-49f0-a01c-2b5121865ddf@linaro.org>
Date: Mon, 11 Mar 2024 12:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] hw/core: Cleanup and reorder headers
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/3/24 08:56, Zhao Liu wrote:

> ---
> Zhao Liu (3):
>    hw/core: Cleanup unused included headers in cpu-common.c
>    hw/core: Cleanup unused included header in machine-qmp-cmds.c
>    hw/core: Cleanup unused included headers in numa.c

Thanks, series queued.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CF6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWM1n-0007TH-02; Fri, 10 Jan 2025 15:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM1m-0007Sy-0i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:54:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM1k-0007g1-Fv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:54:45 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso40991255ad.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542483; x=1737147283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wnI45Gafi5e94R2yPfTBP3ItS4HN0Haa93szS2IrM74=;
 b=JMXcSjgnTDIasUJg5Oe5WLQJQGAr6voR2p2Y3LvEh4K4IpOsWAe3Bttf7tywICh3Ly
 9oE+JhDZ4wHhskOWUy3kMeJr2WC8I4puEVCVvJdrQ0oMlnHb18HiAZOh+r7X+odd5M8F
 JiOv+zf7N8jcQPvPU3E+MAgLq3sTXj7Gl03lPmzFHJf7WrZ2GtQcw+VUbZrQEutvHxlI
 ChjTJexftyvd53hioPRahLXfeNiSkOQ7pU8jgpSADv9/graRbg+pAY9Xg4ALIDeodZiE
 fzCqfaKv7DOe+ak9iTjJ7Phgt8Uw/xcSoyrx48HxV+SoOib8VmOpUBkqDws9M23msN6K
 XpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542483; x=1737147283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wnI45Gafi5e94R2yPfTBP3ItS4HN0Haa93szS2IrM74=;
 b=P9LPftJkMhGH+s2NANjR6BLm/srpqsG5Y1sGv32SyLqVuSMtp1pVThQ5bUanDAojod
 pHCIi+7/MSyWagQ3wFSXdMMm6uAu5QShLElK0xszvVocis1bWt6b8gmVNLxjAGRwcMup
 jKPoOtQc6tkLPFTUiScJhNMsvfTSzOTLk5oCXQdriYbg5DOzoOXOXMrvWkpN9xnTSypz
 gpocY9apTI6UricTGKLg7hGKLEbQR9h5aleinJzjkCO6rNGfvYer2sQ8ESk03aTT8TB0
 R726su/OmHA46d2FKzpMD1M5gC1ov0LNEEGb6i+3AMND8UmuJNQ1CeB4XyRn748E5lZl
 lqfw==
X-Gm-Message-State: AOJu0YyFuB7pQ1tex3xPw+XQS/wIG508rrqkyZ3OiHBYmnjzs3U6dUAj
 j7kclGPrAD4D55JwfB8bZQtKfFjc6v1RTzbTvVMRjUk9lIGtgvlGdo2NXVtBzNM=
X-Gm-Gg: ASbGncvADKa+5Ve3nWVwDlbKaWg/zXXLL7uMAeD13GJHT4aUzVOV+r/LnXWmOlZeWkP
 hynOfMKo+RbTXbzVibhE2fUjhs9hNpgpWrm5bIHDWTqGPg2unTJsb1twezDTtkRMkeJxaKspjAt
 xY0PDWbioBmhsG+ptI25CTeQ6sL2/gp0UAo1ndU/brRcKqlDgvEMPFHvNituSR7Hfwod6WY9O6t
 mfTT9tWnYEbWScnW4SP5+/2PbiScNWvWloCeuT3jIlvhlx3P8I4nhd0MmTo9zEQ8YLz2A==
X-Google-Smtp-Source: AGHT+IGv2jkM/DKa+O6BfPbdyUHiuYK/x5j8lJh5bUcZeZX/EeAIWsFQtN8DDXRmuW+G9QxvMu+P2A==
X-Received: by 2002:a05:6a00:35ce:b0:725:9f02:489a with SMTP id
 d2e1a72fcca58-72d21ff43e7mr17143661b3a.17.1736542483180; 
 Fri, 10 Jan 2025 12:54:43 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40680e5csm1998402b3a.143.2025.01.10.12.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:54:42 -0800 (PST)
Message-ID: <58e2f5bf-2312-4064-87e6-4dedbb7f060d@linaro.org>
Date: Fri, 10 Jan 2025 12:54:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/10/25 08:28, Peter Maydell wrote:
> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
>> spent up to 50% of the emulation time running it (when using TCG).
>>
>> Switching to pauth-impdef=on is often given as a solution to speed up execution.
>> Thus we talked about making it the new default.
>>
>> The first patch introduce a new property (pauth-qarma5) to allow to select
>> current default algorithm.
>> The second one change the default.
>> The third one updates documentation.
>>
>> v2:
>> - ensure we don't break migration compatibility, by using a specific backward
>>    compatible property.
>> - added some documentation about migration for arm virt machine model.
> 
> Other than a minor change to the 3rd docs patch which I'll note there:
> applied to target-arm.next, thanks.
> 
> -- PMM

Thank you Peter.

Regards,
Pierrick


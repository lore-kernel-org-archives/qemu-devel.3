Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F775EB1043
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzugi-0007TT-Jd; Tue, 10 Mar 2026 06:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzugf-0007T5-US
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:51:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzugZ-00012v-TV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:51:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso6922766f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139893; x=1773744693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9BFDPJeEipnTeKr1DdjSKsoZZ3Ms94J3OmXJewjlfc=;
 b=L4cogArZj5WvHaoD4QfwP/HNqB7+mP8Sbmil0UOWgL58exCVnF7hu3sqNTstZCmvg3
 XYLmq7d71QARQH2cCAztJX76AKJ3GP7AosUQe/AHufRumtY6Pr52L7C9KBQMwCl6O+Rv
 B43jUIxB8S/u32eW6xqveujcx9YQJAIFb32/Oz2wvyRBIgHaTaUtMplWVR4ThB1xeITH
 eYi4wv/23TFCEqSU2Ld2p3dTTVt4adFaaj7XDTKAmyNzOZhmmz+VCEMFuHxy11f/9MTT
 GPdsIFUlG+O9CNsY3N3Qq8Y4QRCz+CtlrNwp5gEZe3h5uIFMy630xF53ZqAqI9tZIxcG
 WbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139893; x=1773744693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9BFDPJeEipnTeKr1DdjSKsoZZ3Ms94J3OmXJewjlfc=;
 b=tC0hTqtdVYliTsyV6AlEd6shf7XrbNB7DpaK5ZS6wx4PUMmaWmYwo/hutqhFQ58jPz
 r/bldgOe1NCDE3h0/sIJXNfd0eS4Q3FRKstEfNSZxNlOqsIZdirJexbv8mNnkJZZeajK
 x3YZRmxH+5WKtqU28yWdhDuiY6IpsGoeynuTKhe6LRdE/LSFQou8T5TlUAyO7FYgaiO7
 poO3Jm+5I5mnVaO4VJWSpcdqnVbDfPVCD/cINdHEcUXFgPN5nBLcB5SurQm4m/uqFYoB
 c5gnSJ014YcFA7jHKd3bpk1X9gCyA8xMfSzbsEXJkq4oORLK/epa3Peq1eia7aS/P5ib
 lWmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUrGF6OQOls1jPt6ICugH3fHm9a6LQanDWe26sDvWKlU+3JWb2PKnl40i+DxWBFcqfV17kZiGbpXsz@nongnu.org
X-Gm-Message-State: AOJu0Yx0neA4YRpgSkE7v7FOW+gEdGJCbQ8Egrk4Mt06YYGfO0oAHnsp
 LMPSVIp5yxyzNvu4CdRJtU85sUoh0GPYrDsPd8M8iIHFgp6PkxW8/feBZCgDIzw57tw=
X-Gm-Gg: ATEYQzxyysI1CjBntO4VUh4g4PA0QvSJnxUFrWzqHPsWFUi9UOc4rpVnx5/xUYwwSCU
 584WaEigED316aRI+/HkSiUKHK86Xf73aQT3UWClhvIpiiLG2CnrP6SK/So9Epq1708JaNaelMX
 C8OvWrngDkCGo0VKwKF4k5Pot+MHetBdS4lEvZyJOK1gkZwP7MtSr+BS0qJJiO+c4bGSumJvJtS
 aWcIr/wiElnwF1l+Vom0CKq+WUZpt+81UM9x+VrO1Ot/o6qjpHZ3OyNN0H5wgp4DWhUqWIDkVsU
 JxadIlMCyOq1Vj1xgjbzBMIurfdtWrijMjNMxucucxC2bSZ6JKMx4KTisSTdzY9yf9ev+dSRNdB
 1LBwKCj0+kW1WaSoChRNCFE/sPkhoFhyHk3q/Pl7KqN+5MGp3nbjtMOnGf61FgpKOiMlHcCNAf6
 6+Y56RO0/zGlQ275JRxgSJ2shKf5tPYMEBczqwv+v0ZvkBmYeBUWDZNdHPrYBAkJmoq9zeLEy24
 6zt
X-Received: by 2002:a05:6000:1865:b0:439:bcab:405e with SMTP id
 ffacd0b85a97d-439da885f29mr25090380f8f.35.1773139893109; 
 Tue, 10 Mar 2026 03:51:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae46353sm40749991f8f.33.2026.03.10.03.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 03:51:32 -0700 (PDT)
Message-ID: <18f79379-1b9a-4cb2-8baa-6c10a2bc7830@linaro.org>
Date: Tue, 10 Mar 2026 11:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 22/28] hw/i386/pc: Remove pc_compat_2_12[] array
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260305105215.302571-1-thuth@redhat.com>
 <20260305105215.302571-23-thuth@redhat.com> <aa/uHBPRvmt3pZeG@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aa/uHBPRvmt3pZeG@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi,

On 10/3/26 11:10, Zhao Liu wrote:
>> -GlobalProperty pc_compat_2_12[] = {
>> -    { TYPE_X86_CPU, "legacy-cache", "on" },
> 
> It seems "legacy-cache" property could be deprecated later.

FTR I focus on machines and don't have enough X86 knowledge to
understand the scope of each X86 CPU properties, I rather let
these specific deprecation cleanups for developers more familiar
with the X86 architecture.

>> -    { TYPE_X86_CPU, "topoext", "off" },
>> -    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>> -    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>> -};
>> -const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
> 
> Thanks,
> Zhao
> 



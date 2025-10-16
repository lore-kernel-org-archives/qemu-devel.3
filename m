Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801D0CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RaW-0005eH-Gc; Thu, 16 Oct 2025 13:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9Ra1-0005J1-N3
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:16:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RZt-0004cQ-2k
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:15:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7835321bc98so1010825b3a.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634944; x=1761239744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uO3Yp50UwJMk/y1zHsdYq7Wk9EzSwK2Trqtqi4Eq1rA=;
 b=GVELwRkUW/IYNz+oxYD0GwXHNFvl14fuI2jHMpVahrBIUxaGXmP/9XE5KSc4sP2tNK
 ZFF6Or96C6ipuq7zlBUMmQnWKH/KLcYWP6eGXzVYN10Dtlfo9MyBpdITaz4Md8JobiFH
 AgJlK2BFrqxrjL+DlDltNSPfSd8drfULu1WXktgns5fwyLcchaRIOVSmdKfJURMiknOo
 copTZJ52eRyMoY5eQVwET6iFpxCy9xXI7jSS24B0aNLMz7hs9nxFr1ClfA69HCipxyvY
 vk4OiyCto0SwS3FwIbksxQcsTHC/TobnF8gjvv0vtPJkbdifKA2DUpg3M6SoRCCE+Yca
 FxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634944; x=1761239744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uO3Yp50UwJMk/y1zHsdYq7Wk9EzSwK2Trqtqi4Eq1rA=;
 b=IfZY5XAE06OT0xrhUB1e5rdW6iQr8NxtlIZsB8qIW9EmuLJ66dN78B8QVDXORtbsE2
 wCknl76xhvBoBZfaN/QQ34a5aqcWochiJlJUueVzSQKO7pNodYNKtIBoVuxDkPBEMq3x
 l9kkWPYQa5G+XrjMGRCPPu3U3p1NRL08cNjdgibZLHrXkOnczjkNQrLQdabX6+Nq2gZr
 rXkrcy/fMx/ahA5PcKqJ5FAkEZR1loMrOZoamQDWrA0nJfKhGaqEWaJXqHUp1ciRWioq
 zNFmf5A47QlbCb2QK8joYHGyY8ubblg1jQDSWufxROznbRTzBzutS07zpWXVAuWLJmhC
 BiMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrwS51h75U4fhiO6Jzwr5bXXK4t1N2J/QWD6kYSAq4eyiiv9fsk5uK+B5oiuGSWVxGsahoClY34MNC@nongnu.org
X-Gm-Message-State: AOJu0Yy3+q1YSwhzI94fq5jqfXt9Q3G0s0i2l0tTglK4UK2bCziAjKu0
 lKSnw40TCHvoSXZ+iWIXXXLarURLaDc94jh/I/NyHFfH8iI88QlwfbhXLS+GHZb80Xs=
X-Gm-Gg: ASbGncuqZTVzwVMutizSXPRo85qI1j0uxDJnrzs9XsH7dU11FuK/My0C87k4s6Td7iX
 V3+dfKoKufnv5cF7wPRszvq3Uw6Lgl3MfHCGWIbqUOusVixm/BUkV/yVZggV+G63+ZMwk9xDsDz
 JMRjlSM//kpCBBObL8K0HCSAdKR26byMC9vbpOvzRkY05zTnV8PpHc3nPllBW+6UfEB+J86ChAZ
 mVMQrQHqcjLVa8qYyJZwyC9MGQKUcTZVjz2t1QI9CmQcKy6Rn0/bklPlIsj0jTIrHTTccCLiYAb
 TosB1CNN325ZryW9nTBgDj8N7DVtFLchg9na0KOIO0RAW5983/xhUffmzh7We1JelDsvKfY8xS7
 0pKe81/tkD1ZfU14NajYIdbLGb8RnhXnu74UowsUv4m/Nh9BFkBUkCRdD29l1/3dFxnw4reYR3o
 X1e+1PQvCUiVLiQrMyYTzbY5U=
X-Google-Smtp-Source: AGHT+IG8ntzTeyqNtRo+ruJaIAP0uFdEsIN1dMzMYvlk3+/f4KRMCNbUa4vYTIfJVgyQ+KNmV8PtSg==
X-Received: by 2002:a17:903:138a:b0:28e:c9f6:867b with SMTP id
 d9443c01a7336-290c9cd4adbmr7484625ad.23.1760634944303; 
 Thu, 16 Oct 2025 10:15:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099ab474fsm35797705ad.86.2025.10.16.10.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:15:43 -0700 (PDT)
Message-ID: <2cbd9feb-2c20-46e0-af40-0bd64060dfba@linaro.org>
Date: Thu, 16 Oct 2025 10:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/24] whpx: apic: use non-deprecated APIs to control
 interrupt controller state
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-25-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-25-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> WHvGetVirtualProcessorInterruptControllerState2 and
> WHvSetVirtualProcessorInterruptControllerState2 are
> deprecated since Windows 10 version 2004.
> 
> Use the non-deprecated WHvGetVirtualProcessorState and
> WHvSetVirtualProcessorState when available.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   include/system/whpx-internal.h |  9 +++++++
>   target/i386/whpx/whpx-apic.c   | 46 +++++++++++++++++++++++++---------
>   2 files changed, 43 insertions(+), 12 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



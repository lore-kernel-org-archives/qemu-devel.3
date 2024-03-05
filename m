Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F32FC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhcim-0002pY-8p; Tue, 05 Mar 2024 16:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcik-0002oo-9B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:53:10 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhcib-0006AW-E9
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 16:53:10 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc75972f25so51867115ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709675579; x=1710280379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pN+jAz/uqt8BcB5VrIhGDt250gxQrv2+wbXBwbJPQ/c=;
 b=A9Pzu4hCOzot+zQ3Fh84VS87KmS7LVxR1lCbZJyyBT9A0MmcKzCCNbTL1KWIjz2oJ9
 p512Oi0JkGN/rJ8KhSgOcudenx7mdXzQNCqQ1TMq4LP/Zg5fCkH5qweLETC2okYFO2S9
 tFvek3P934AtVR7Vt5TDW5gw5052QEwSTBZHKiOC5WJ8kVHBfvjL/WBuAKFd/A14o/lG
 ygFtvhY+LcxDaMz50qUpgWoO1dDdF+Ys4qnUFgOphc/2SYo+LjeXvL2UVT5uAPv7bqhk
 NmdCTsGHslRHLUaFr5uOAbtnf+OxW/jY7EzKmR2vOY2xwP69+oVuFB7JM3q0/D5U5aT4
 jaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709675579; x=1710280379;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pN+jAz/uqt8BcB5VrIhGDt250gxQrv2+wbXBwbJPQ/c=;
 b=cEEzbJkliAdoUbE3gCj0WLValtxic2g4NxdIRrbNb/HNAJ/0A5K/Sn3h/Hfe3JpwSY
 L1O4qOrOyvuwwHQnaKmvx4S4NnKA00SbHuuwPVSInvnHy57/cdkoVHNzOlyafWaSTpIP
 0EWV5io6gQJ1LZi2WzFa3hdfV2O0MvWQoY4Jq3GupASq5Gj0rX1Hbdf6qgR/k8XtoUfG
 EVQiza3kqLNzg6sw5wwoNjjqlS1iazJ2s4HM+Y1L12IcVSWQY8Ee5yiggVqi0leFfGbv
 K7VBX+dzZ+6Rljs75OiVVuLRIUnJVAFCmOTMRB0zalTVxbGAeR6xgxUzr5VEvMj49H1h
 9WcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiISi26OKolz9xqnV21VGNF9P4F3CCR4NtO25Dz/YCV5TljB0MID3HZGlMoqP14IKbOFccENSp2U97PPLJDVIRvRYFEvg=
X-Gm-Message-State: AOJu0YyZ672li8D9pXXGCaT+P77xzVlCDZHdT67CNDg1CboRGZzsb23B
 dbhzPcz1p/Or63BhMuw1SG0Qx/rIRN+wLenkG1rfr7VFBdJtX+HHU/4KtzjbYso=
X-Google-Smtp-Source: AGHT+IHRwwlXA38AtI2z8Lw+67nYQhSBYnkYq8AfaXuKjfjXZ7P0hqcZBTaY15/u4dnwBxXH0s3c0Q==
X-Received: by 2002:a17:902:d590:b0:1dc:3294:f09b with SMTP id
 k16-20020a170902d59000b001dc3294f09bmr4100364plh.26.1709675579591; 
 Tue, 05 Mar 2024 13:52:59 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001dba356b96esm11131789plc.306.2024.03.05.13.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 13:52:59 -0800 (PST)
Message-ID: <dcd9fccd-63fe-49df-9af5-f78409576f68@linaro.org>
Date: Tue, 5 Mar 2024 11:52:56 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 18/23] hw/intc/arm_gicv3: Handle icv_nmiar1_read()
 for icc_nmiar1_read()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
 <20240305070331.2151131-19-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305070331.2151131-19-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 3/4/24 21:03, Jinjie Ruan via wrote:
> Implement icv_nmiar1_read() for icc_nmiar1_read(), so add definition for
> ICH_LR_EL2.NMI and ICH_AP1R_EL2.NMI bit.
> 
> If FEAT_GICv3_NMI is supported, ich_ap_write() should consider ICH_AP1R_EL2.NMI
> bit. In icv_activate_irq() and icv_eoir_write(), the ICH_AP1R_EL2.NMI bit
> should be set or clear according to the Superpriority info.
> 
> By the way, add gicv3_icv_nmiar1_read trace event.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v6:
> - Implement icv_nmiar1_read().
> ---
>   hw/intc/arm_gicv3_cpuif.c | 50 ++++++++++++++++++++++++++++++++++-----
>   hw/intc/gicv3_internal.h  |  3 +++
>   hw/intc/trace-events      |  1 +
>   3 files changed, 48 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


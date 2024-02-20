Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B93C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcW2G-0004cU-2v; Tue, 20 Feb 2024 14:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcW2E-0004cB-GI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:44:10 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcW2C-0001fl-Rm
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:44:10 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e45d0c9676so1787201b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708458247; x=1709063047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxxAiJVk0L3DMmaqxsNJbuVgD3c7yBtiNwg6tqs/Lhg=;
 b=V40psfU1a1ZLBbeiJEdI+qsGBg7VpNKrCokHCk1xJzrXqkJgmc0Ta/rMbuyhfhdY7g
 3tOANlNd/WgASr0A5vY85IHraZF4wHxKmAMWbirXfEAZ4vIq61VQdzssnoEfslCTOUPL
 jxERekP4rJGA5AD7PCDxWyHPDpA/rSvTFmARozFX/Pbb5OihLJIPwQzpUnvRYwH7FPWi
 Gnw6RJe6demWj1AYgU8L45CU87cWiLKUGqve2P9yoV9sYkEDCVKoQCq0+JqTkS14rmcB
 FXYX2RgLRp6XLt5/7hLZlet/8IvsUymoSc/MGMG6ATnvbbSa56op6nd6+LUjzZqLsAWp
 k1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458247; x=1709063047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxxAiJVk0L3DMmaqxsNJbuVgD3c7yBtiNwg6tqs/Lhg=;
 b=GV/OkYL57zKX4FUUM9eEIXHMgvxlU5vGGPpr+U5lTWtknS54czn2osBLeeOcbAFMjN
 xH5FAqRJWTJEm5mcBQQPcFlgfmqJ8MKbqVvd3cvt1VxlWXPlgP22nmMBJTANdlu3PfI4
 IYNVTPyJVVHjmTRhz67+zUhFcps1FxCX4XKtn3sqWJMK4/Pb9XbvFVSwTsz3cC3IVjp1
 siQP2rLRrMf/SQahAZn62pihQAeg5diNIVqjO28I1nOuzEoSQiEhWokJCG0YY42lSCS4
 NEpLqWm2733pTNn8Tfe7McbmIyOfP14FYf7yvNsKwLSROwC91WmEIa4QpAFvEexkn4xu
 rUWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLxvHIfEY52O5GG5irCB4m8ixs7ZOnYt0WytJ2291OfuR4L1cHvJYt/F4kgsjkWjv8XNImiLJgmK7Po6e2k9XHQUQ18/g=
X-Gm-Message-State: AOJu0YxIVAU8sTP1Q7vtfhBo8Dw0MIxknjnhzCh6g+jrlqxGkBK/ZS7l
 LSBt1AwHMUI42LWGyu8wV6MLrI7MbCwTjr/KconCDE7qR7V/rdg/tDykpSdI/HeNbnuwYH0ljbL
 8
X-Google-Smtp-Source: AGHT+IGJ6PkEsKR/EV+cG3o8phJBV7+UkoF2Mmn9fPO+1yCMlqG4UOd6K5bLtqcrPNtGUPbTq3UWRQ==
X-Received: by 2002:a05:6a20:d043:b0:199:7628:286d with SMTP id
 hv3-20020a056a20d04300b001997628286dmr22893761pzb.30.1708458247393; 
 Tue, 20 Feb 2024 11:44:07 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 v18-20020a63f852000000b005dc87643cc3sm6978278pgj.27.2024.02.20.11.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:44:06 -0800 (PST)
Message-ID: <75a4c6a5-8d13-4300-86cb-aba6235881de@linaro.org>
Date: Tue, 20 Feb 2024 09:43:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> Implement a ResetContainer.  This is a subclass of Object, and it
> implements the Resettable interface.  The container holds a list of
> arbitrary other objects which implement Resettable, and when the
> container is reset, all the objects it contains are also reset.
> 
> This will allow us to have a 3-phase-reset equivalent of the old
> qemu_register_reset() API: we will have a single "simulation reset"
> top level ResetContainer, and objects in it are the equivalent of the
> old QEMUResetHandler functions.
> 
> The qemu_register_reset() API manages its list of callbacks using a
> QTAILQ, but here we use a GPtrArray for our list of Resettable
> children: we expect the "remove" operation (which will need to do an
> iteration through the list) to be fairly uncommon, and we get simpler
> code with fewer memory allocations.
> 
> Since there is currently no listed owner in MAINTAINERS for the
> existing reset-related source files, create a new section for
> them, and add these new files there also.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   MAINTAINERS                      | 10 +++++
>   include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
>   hw/core/resetcontainer.c         | 76 ++++++++++++++++++++++++++++++++
>   hw/core/meson.build              |  1 +
>   4 files changed, 135 insertions(+)
>   create mode 100644 include/hw/core/resetcontainer.h
>   create mode 100644 hw/core/resetcontainer.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827D2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NaH-0002PF-I8; Tue, 07 May 2024 12:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4NaF-0002Ol-Ge
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:22:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4NaD-0001HI-79
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:22:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ed3cafd766so2521462b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715098942; x=1715703742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HeTb6/e6/0ZsAmScNtS89lM9ZO9xUsxkKcrZRXGJ0lU=;
 b=PCqIzszs2/WgauGLaxRnkIXQJLGkRli74onEde0z1hUh4+RSBxKjNdZ828jKpQ1kuc
 xzd28DBH1Rv4Ico9ypxGFDHdLCdzAFCrwMW0sj4+y+ChdFmwaE5qdFgCN1HdEEQsYp9R
 pBlPEn3hycbClDlPSvdeal66cI6mBnDqq+hpCedfv72ibriLW8RPYdrhNWgkgwGsl5NA
 GdVqIssv49TnIGU+xr4BfJCYiRjypa2ZqtCPV0k0xeYU4GFylFhGMXNWiIqztEyyYzVQ
 8OA5ne3Vdwdn+V1j3vHal6lqxYwXiz4lcI8vLAEBu0C1LPfrJooStX6ifufVYTss1vsU
 1Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715098942; x=1715703742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeTb6/e6/0ZsAmScNtS89lM9ZO9xUsxkKcrZRXGJ0lU=;
 b=FwEU3Ej2KFKHzQTST1f5NXqiXmhibFREr+Dkv7D2kkWut9Qvd+M7tAnukSdaF/fJhD
 Vr4jVIe8V4GCiVQBIs4Mvmj9DJKHXLNBw7c9D127fsCuwjQ0C+a8l+Hp2+N2vvxVkGxa
 wTLMh5Ir1+TMxCZHsvhUXikRF8xEkRx1sHOhNXRrq5WfzrWYH712I3MI47YK1Y0mYyI5
 l4ZCo+viiHUBM0NOR9Wt+q8CAmeR1nAus2xEuyw95iB0j+X1YAsJcm9q9Wvh/FkmjEjZ
 EEHlv/xXFAPzOVJdK+71q84gXZy2hHIJFa16S3aV9TaCPDyzxnKt1LuRsxaK7vTWH+O4
 IxQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwP7yVls4K6gejx0hcu5ErQUKXRh22R/UG9BfR0vOedsHcQOAlgOii0apWFnIortqo940AeBMTVo0DRoPrZXKVX7fgYYs=
X-Gm-Message-State: AOJu0Ywn2YJwBqAjeTl/5wB14RJd+RXvppthbiFOfXPnFisgrn6E//HF
 J+14dw2nixfd5wmU9ZGro5biob23glsa9+7J2Q7ZuCjQXk65HLn6zRYflPrp4WiCH1x01qaS1Qq
 w
X-Google-Smtp-Source: AGHT+IE3rfkY6c1G0gFfAGZ8Pr9jHLG6eMbthA2z2AIT+U5Na33WmJG4qZcpKRNx8WHAuusRJoOJ4Q==
X-Received: by 2002:a05:6a20:ce4b:b0:1a3:64a9:11e5 with SMTP id
 adf61e73a8af0-1afc8dea28dmr179852637.50.1715098941906; 
 Tue, 07 May 2024 09:22:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a634f51000000b00602a85927d8sm9997231pgl.73.2024.05.07.09.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 09:22:21 -0700 (PDT)
Message-ID: <e503852c-4a5d-439c-b4d6-7b67e44ef0f6@linaro.org>
Date: Tue, 7 May 2024 09:22:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch64: move memory map to boot.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507145135.270803-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240507145135.270803-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/7/24 07:51, Paolo Bonzini wrote:
> Ensure that it can be used even if virt.c is not included in the build, as
> is the case for --without-default-devices.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/hw/loongarch/boot.h | 10 ++++++++++
>   include/hw/loongarch/virt.h | 10 ----------
>   hw/loongarch/boot.c         |  3 +++
>   hw/loongarch/virt.c         |  3 ---
>   .gitlab-ci.d/buildtest.yml  |  2 +-
>   5 files changed, 14 insertions(+), 14 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DB4C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVp1-00042b-Jo; Tue, 20 Feb 2024 14:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVof-00041u-Ug
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:30:10 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVoe-00070R-FH
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:30:09 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso14242685ad.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708457407; x=1709062207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYLAWuYLscVyyFL7cmoAaFCNQY7kAVj3hjTzinkbW68=;
 b=pw+hSLGBEhY6o5IppEqqarGS9QTsMhh/6GtAxnD9YEyBS066jLWUg9dRnug98/aRca
 zDXkcA3+YA0D3y73Nusf55ipR5Nx0t3ouiE75TPTkZpR6mgPWP+ybti1R1CVhXuGWWub
 uXODj0aYTOmG+zoB+xFERjtZ1DV3kGBiyZjDqvCGEsa3lMCj05jcGvHVK+KfMH+JgWLc
 enJ8/ubRi0N7LaRTlX5wQ7JE3jXS7KK/+lDfI3NmKTwX7/o3frNbSH4pJXa0/2W6e+s/
 1CM7Wcb7hWkUzIp6B9AyN3lLSvBNBqUoptHm1hFoY1tobTvy+pLm2eAKAKJW58hi5zgi
 Fqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708457407; x=1709062207;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYLAWuYLscVyyFL7cmoAaFCNQY7kAVj3hjTzinkbW68=;
 b=JBHoxhpFruvW3HsGWJCZ8n7KLy4S2FjLMrUMI3FDFpH1dH6OyLpKqM+xH1yW1uu1Ix
 ZDeUdHYDJDaiykWlmpOMEt9DrbO4fdapmrr43gCMlfaecLk8CyM5/7YUVBqQqJTh/IVe
 9ytPfjpbFdVHCLsJhhnaGsKGRko4k4y2QulvbxzwHmWcZS36+b95jxQchN48hNnLCWni
 LYco+syfZI8LRE15UPm+wpHK6auvlJgfD64gmj2ybFhRtk0s9clj2z8gpdvCdxxH1Kwk
 cwwqJkjj9Dao9cuqSh6DbfOI57l65NUl/d44cUQwlTUpIX8fPvyb6QgNhCydttavsAby
 a/gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOF3IuuSXOwYHF+7wPrKcMoIIrVRbKIRAuzaDybTrXusHRkTsB+15xpok1n9byDzBTIXB9/VDaTTDHt0k0Zws17pHcqdc=
X-Gm-Message-State: AOJu0YzjAJQANH2gxME5IkbY2da0rAeHOSxqZkFu32SU7K6IpEhTegH1
 3y2ccmUUNZK8kxqSJhz7V4lB7xFrsJGboazhtS8YMXtYSUMej+wPbf/WhYhGuA0=
X-Google-Smtp-Source: AGHT+IEtIxJ+8XVdsMlC15qaScBAoeFEM3hN/r1d9CsETFDduF8XMXafDGDg6a9YvTa8Ns4B0m7H/w==
X-Received: by 2002:a17:902:e5c3:b0:1db:fcc8:7d96 with SMTP id
 u3-20020a170902e5c300b001dbfcc87d96mr7014247plf.14.1708457407016; 
 Tue, 20 Feb 2024 11:30:07 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kj4-20020a17090306c400b001db9c3d6506sm6661754plb.209.2024.02.20.11.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:30:06 -0800 (PST)
Message-ID: <7566853d-e9d5-45df-9fbd-9ba71ad83f4c@linaro.org>
Date: Tue, 20 Feb 2024 09:30:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/i386: Store pointers to IDE buses in
 PCMachineState
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
 <20240220160622.114437-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
> Add the two IDE bus BusState pointers to the set we keep in PCMachineState.
> This allows us to avoid passing them to pc_cmos_init(), and also will
> allow a refactoring of how we call pc_cmos_init_late().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/i386/pc.h |  4 +++-
>   hw/i386/pc.c         |  5 ++---
>   hw/i386/pc_piix.c    | 16 +++++++---------
>   hw/i386/pc_q35.c     |  9 ++++-----
>   4 files changed, 16 insertions(+), 18 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~


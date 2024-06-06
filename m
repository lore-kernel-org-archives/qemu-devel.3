Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0855EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFA49-00078T-Su; Thu, 06 Jun 2024 06:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFA48-00078L-C5
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:09:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFA43-0005Bq-Jj
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:09:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42155e7084cso8094925e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717668583; x=1718273383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vAnmkGM6G8vNWBmEDAXaTlqYcddxtTT1GEIR9ZlidOY=;
 b=bkScCfWXD0+B2yj1wK8eY2okYpqKZGvvfct//vhC92O0I/SCBj6NKdBrj3K3Olzrxl
 +4pmC2CW6UvLEnPBO7C7WUV8IYd1z6OnBIhdu+4TX/jq3x8s+DiNNAeCGTSxmzcoV0ql
 7nY83JZC1Yg/P3z/39sflkfIYT50JUzdgPCiQVObxLsAv39z5rC8ISeyThyfA5JQn8HP
 O5dtF4CBz3GDKvm1iZ9RRQjx4U93hWauopPya0vUQssLDz88Td1ODVqHSkVSN14JfzNU
 UqcNuL8yrrdmfnupWykV8u7Iqw0o38/PoWPnGEjCdS6DxJf/NrhVTXr2umy/KN/7Jp0R
 laFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717668583; x=1718273383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAnmkGM6G8vNWBmEDAXaTlqYcddxtTT1GEIR9ZlidOY=;
 b=OrK3VKdBLCL7sHpPY7VRX3lGYlr2mR9xVO7YlZz551vd0S+QM6C34EU9gRY7HXp8hx
 wax7LCchmV8ea95r+Sl8mvrzfWPMFOTSFeFaM7WNXBXs1hh2VqUB8dllnbMFu4372Crl
 gLTl+klrMXnYXvslDW936c4HdIgmRCuLOPpoypBp7h7xZb3e40ussS/zp39xF1Ktsg36
 As/NFsq5F3pHDT4R3UHGGbMkW55RXBdW0BO93uQaG4Qcm6C374smAUZ5LoscrF4XHyvD
 My4Dp7iMk6ReBsS2UPs8yn96xagXlQpO8rGGTGjmxuwdyNsWRnWsEGeJQ+OVPUOT9t3p
 g37w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN2vXf4pUpSDkbZ7GoNHHqAsSvx70v4gMDEvWrBoly1d9v4LVB08UTi1SurqG8s2StFJZIhDrcudPO9VgJBqLs1B9x3Wc=
X-Gm-Message-State: AOJu0YyogM9mCUrwaBXY3+15CXR2RZPHb7N3zkuLNssJ4Qi8LCV3GwLq
 nQcqIRxiDzOYWjKseeP8wlfw3ZmVwF5kukYq+R7p4XUs/pRZoVkDtnREUM7bMe8=
X-Google-Smtp-Source: AGHT+IGq6T2faJgVKM98EwJqciDhfoY26geoskdhVLNC4IqFXWarPsHznYw2Ts5LswNytmxH1kX67Q==
X-Received: by 2002:a05:600c:5129:b0:420:171c:3d70 with SMTP id
 5b1f17b1804b1-421562dd284mr40372775e9.16.1717668582761; 
 Thu, 06 Jun 2024 03:09:42 -0700 (PDT)
Received: from [192.168.183.175] (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c1aad97sm16190495e9.20.2024.06.06.03.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 03:09:42 -0700 (PDT)
Message-ID: <074a613d-b75b-4f24-87df-e3845c694a36@linaro.org>
Date: Thu, 6 Jun 2024 12:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem: simplify the code
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com
References: <20240606093713.2469676-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606093713.2469676-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/6/24 11:37, Paolo Bonzini wrote:
> No semantic change, just simpler control flow.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   backends/hostmem.c | 24 ++++++++----------------
>   1 file changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



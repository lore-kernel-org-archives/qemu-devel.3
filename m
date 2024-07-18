Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559D5C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMAP-0004aY-Jr; Thu, 18 Jul 2024 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMAK-0004Zj-Al
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:07:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMAI-0003ZT-8E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:07:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so153735e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721290020; x=1721894820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0i+00JPQzLxVdH7MdOkngcWVHWCAZznFXab5h1UBu8g=;
 b=NqS69+RRTKos6vU78TBXjMUbmT/LoJRohIP0NFoje0XI+cqaHr9M/gwKl9E+PDixqv
 sSipb2y8PBkWacrIo844eQMg3kNnxYVoZyxnAz4k/GaZJLyF0mGLa1Ti35C6y/XRkR1L
 jk/dIaL9qK0aTfgHoYXNl0oubCW4D4oshBA1rnX6N/ZDvsrh8ruQMwHaICqIDaa2Fva4
 SIbaD1JudiQ/rSIrH2TQrs8k/6YpBkVPc++mwtpwz7aUbl3hg8cqtCMROY2pCurO97lc
 UPd9asEZgd9jn+NsdNAA1KIDRtWzsOAFxzpnJDFnwEIG3apFjqlKEwzBrBV94c94TUFz
 eZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721290020; x=1721894820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0i+00JPQzLxVdH7MdOkngcWVHWCAZznFXab5h1UBu8g=;
 b=T77NDRllyLRw0I+3Ckkuctn8ehusO+/EjsdHW4VZepzXz8U8Ymyc1pLfmZ5PCJT5+A
 swzp20AjAyt5o9ocarMq16MzHs8r3ERmGkxjiwDyVbAI24xmpRr6YrZNJUfiP9OhNz8q
 Fof25qssYvdJD0bhxpHbpxdbMDQ8EkwuuxhcWpdSgRZ99exaKQ/dPA7eWyH8IRhtA7aN
 veYHRFiJc+rUhOtWO+bEEdjI8bigyEp7r3ivMHX3BVVk9HIxQZTMxcdQGe7z3Eyd66A6
 xGpEvWPTrxFtfCojVAKPDu1JTgRAuE4Q9LC9EQ0qa7PkSTsKCUjtqbW8Sw4RvbaM4nVo
 Zk4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdyDVtuxKRbzJeWnnU7+L8AdNCEiIrais+FxWP6B0tTL3AW8uQ2QCRbF0k37Kg0SGX5E3ZxchHD9/k9lW5cXQzr8D3c20=
X-Gm-Message-State: AOJu0Yx0/glw2Mjr/JUFdAeR8uaS9B7ILd1wvhqvheJG1Vg0ZsdzRehN
 j7VR8ZHGp8lgp0IDCzNZZFZqarhHgjqITbqbhlQvbdDoVI6qteBrkbqEL0ECGsI=
X-Google-Smtp-Source: AGHT+IFJ/zolD9UT/NFCS1iXSLa0S0YKGYCvUyImRFfPboILOEZ85wzDYdYmVPcvsEp6Dr59OLCKnA==
X-Received: by 2002:a05:600c:5008:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-427c2cb020amr25439765e9.9.1721290020227; 
 Thu, 18 Jul 2024 01:07:00 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b1331asm312235e9.6.2024.07.18.01.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 01:06:59 -0700 (PDT)
Message-ID: <d5ec3925-64a1-4be6-b318-f78af4eb9302@linaro.org>
Date: Thu, 18 Jul 2024 10:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ui: fixes for dbus clipboard hanling
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717171541.201525-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717171541.201525-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 17/7/24 19:15, marcandre.lureau@redhat.com wrote:

> Marc-André Lureau (4):
>    ui: add more tracing for dbus
>    ui/vdagent: improve vdagent_fe_open() trace
>    ui/vdagent: notify clipboard peers of serial reset
>    ui/vdagent: send caps on fe_open

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



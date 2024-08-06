Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E1C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 19:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPrj-0006By-TP; Tue, 06 Aug 2024 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPri-00064J-08
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:29:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbPrg-0006J8-BE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 15:29:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso527081f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 12:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722972539; x=1723577339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x9ggTlFpDeO3tzm3B+faf6LESHtYJaV4u5jSKjfZQ7c=;
 b=MPNY8syOuaM6sawOArRuugFhZUZMKQwYFkYxaMZ+tK5yVfha1L0V/gc6+ti/SQPzWt
 1yawxMRK7rEzCmsY2jF3G9p35FbsmR+nqX7nrdEJwV+/bwsp1GR5TUgTOeDH8XgrL0MQ
 UCMYv0ssXYsaUujVKMSHxUHFyl3cReAWllyvAlz2HunpDKpaFm1bifZHc/Nh1JlqW4Nx
 tUNpVVp1WQs8joK3OCClX1ciLNRlEdI5WW/SyIl2YP8jD2mF6iRmQjJtbNlTVy/rEoWW
 6vRNhNm4BxEra6nPjj3qnvV/zbMDJcQl2leqRwh+YjVFgv9uxPzx4OrXzYgKOyj2J7d3
 9Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722972539; x=1723577339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9ggTlFpDeO3tzm3B+faf6LESHtYJaV4u5jSKjfZQ7c=;
 b=PioSfl0QCvnDW4IuUCD+2de/kIS49vHwozijHxVzlPTNbQenCv9zmr7G66afYfuxdW
 7KGBrKd0+4moTaP0kOjlOJ5cQAJ5fUbGmZGHodvgvBgyVCU/fBCiuodDU7XTTVPfx9fD
 IkVyDMDh4Idxz1TR3Ooe62Hc0IhmPKgeguX2IX56HK1t/JNfXu0Frxkj22/G7wBuV4w4
 SddqvbRWs0/5ia4gqk9HMpvg5i30Z0zpn8igkR90I1SneYfNhM9XPx9F0kdIYLUyt1Z2
 e+ZYcDaCg5ULJycPQNMss/C2yLKkH+IKmxWQddn5vX8vxxvbV0eLxyve4iLHt6XLUpE8
 Mm2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc1GXEOjEcQ2q2PzvulHr4nes/O7Jw7DRDy1jPPJ1HhAGNOAXpWREYsXb+58gRssA2aG4m6fx5Vqznyc52tU6Zq2fS7dg=
X-Gm-Message-State: AOJu0Yy0ciElC5KhJTaxVB0zydZqTzeQvCy8EoeyUqN7wIhZceCiftoJ
 ht+QXs5vlCEdBRnIOXVbVGEiNNi5GOK0LmIMDEbAGx3CL9YvvHQPFcmuKUxdisQ=
X-Google-Smtp-Source: AGHT+IGL95hmR91RbPW7U18cwZze82jNZRU9+smHhYyTBI74N3P45y9f5389mZP9Wnej1IeYT+r52Q==
X-Received: by 2002:a05:6000:dc1:b0:367:926a:7413 with SMTP id
 ffacd0b85a97d-36bbc189bc0mr8767580f8f.63.1722972538773; 
 Tue, 06 Aug 2024 12:28:58 -0700 (PDT)
Received: from [192.168.69.100] (vau06-h02-176-184-43-141.dsl.sta.abo.bbox.fr.
 [176.184.43.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bc5a6fa1csm13026553f8f.78.2024.08.06.12.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 12:28:57 -0700 (PDT)
Message-ID: <640b97b4-583c-4fa5-8ea1-be6c120aea8b@linaro.org>
Date: Tue, 6 Aug 2024 21:28:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] tests/avocado: apply proper skipUnless decorator
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant
 <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Leif Lindholm <quic_llindhol@quicinc.com>
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-3-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806173119.582857-3-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 6/8/24 19:31, Cleber Rosa wrote:
> Commit 9b45cc993 added many cases of skipUnless for the sake of
> organizing flaky tests.  But, Python decorators *must* follow what
> they decorate, so the newlines added should *not* exist there.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/avocado/boot_linux_console.py | 1 -
>   tests/avocado/intel_iommu.py        | 1 -
>   tests/avocado/linux_initrd.py       | 1 -
>   tests/avocado/machine_aspeed.py     | 2 --
>   tests/avocado/machine_mips_malta.py | 2 --
>   tests/avocado/machine_rx_gdbsim.py  | 2 --
>   tests/avocado/reverse_debugging.py  | 4 ----
>   tests/avocado/smmu.py               | 1 -
>   8 files changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



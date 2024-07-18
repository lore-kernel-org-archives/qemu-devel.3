Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7476EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPLc-0002aA-Po; Thu, 18 Jul 2024 07:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPLa-0002T7-Ft
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:30:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUPLY-0004Gk-NQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:30:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-36786081ac8so444042f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721302250; x=1721907050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GC6B5R1pfzY359nD27E0dLm5dNs9vPh+QFw1Nt6VMiE=;
 b=OQrcwxJ86NVX1NDCEaxRLdUTXW7+ZqOuVkXGS/yVDj3mLYrU1ZrFWbhfaVmEXpAK66
 peA2h6jrczXdF8IYv36H3m4LKolmO6KOu1NhyEDpT2zq7eHV9Hfb3gqoYptj//UDPaLG
 Yhz45DEyVqTZkg5Roxmjie/+CWfcXh7yrAIiNrw0UUBvvxYvfvh0BVIW3k8TlIYJIRQt
 H7y9RsKyj4yPAZ2CjGCJRRTA2Q2uR69cWx0QCj7BXgM2sevasFdxT2N8mlJ5Wwdn6iHe
 UZ9JO8JS6FL8zbeKKVdBGMcZrXGh5UmFQIT9axf1L0LS+MeQ8GdfqjoymoA16mIzuMSm
 ioPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721302250; x=1721907050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GC6B5R1pfzY359nD27E0dLm5dNs9vPh+QFw1Nt6VMiE=;
 b=FDlghVtX7Xq8SwzzSSTNMfpv1cfoeQQvwR9szoTSCj4clBNaLWjLp4U35nS+B0tk8c
 nj7VjyWviYef8XrCIx3aCIuFbCX+hpONh+zhM9sasbvw/eYBgSM1B0D5o4Zl75fIvTGn
 wdao06bcGK0onkUIPpZL5FpOIK/RveBx6rh8t/6oHuR5iSVMQi2wfPIP7/KS5gg/fmNo
 bice7Y5CA/2zlUxXMy8vEXk9/yfoacV4nzDMRt/hDnhN4kWvwwAwj+xkViirNq4k/0PN
 RoTZySfRBtthHXIk93lD3r+iC8Kv8IzMLz9c/BzcbwkW2pVtzytX3YZPG1X/bIzFlBn3
 JKhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeUfreh8LXwb8qxJxUHMMyX2hPH4tFCr3BTq+zoQnKCOLrUQoYHpYa3yaeb07r4amkYjaKodA/E7UPCdvygp+eW/Akjls=
X-Gm-Message-State: AOJu0Yw0wZG7/Bdbd/5zTLkCQXLGIDjMkYMtK91ddCWCImVsKuhWyt3J
 uWU6uu4wlOYm87MYxcec+TIXZntAmmUYTZjo/BWoy1GVjvkRgnJMEtOPG8yOS7v4hQu7+6yksNk
 i
X-Google-Smtp-Source: AGHT+IHnaweuNNOtyRL96PoI9YJ2x6G7utTh+oysypBnhG9oHH3Jv1lCYu0RAEnJ8nw34bz7/GfNBw==
X-Received: by 2002:a05:6000:184f:b0:368:334e:2d2a with SMTP id
 ffacd0b85a97d-368334e2e94mr4371298f8f.18.1721302250489; 
 Thu, 18 Jul 2024 04:30:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368447b4b1esm2478804f8f.107.2024.07.18.04.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 04:30:50 -0700 (PDT)
Message-ID: <392413e8-dfc7-422e-ae9d-a5ee55c02a08@linaro.org>
Date: Thu, 18 Jul 2024 13:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] testing: bump to latest libvirt-ci
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
 <20240718094523.1198645-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240718094523.1198645-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/7/24 11:45, Alex Bennée wrote:
> This brings in the latest python mappings for the BSD updates.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/cirrus/freebsd-13.vars |  2 +-
>   tests/lcitool/libvirt-ci            |  2 +-
>   tests/vm/generated/freebsd.json     | 14 +++++++-------
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



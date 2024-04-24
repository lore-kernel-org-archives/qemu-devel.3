Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E257C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzZM2-0004L2-2A; Wed, 24 Apr 2024 05:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZM0-0004Ki-HA
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:55:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzZLy-0007lh-Pt
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:55:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-347e635b1fcso5446042f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713952549; x=1714557349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plBgM7Mzo/JhuzXa8aMMZ3nZa0XciMHnM8kXA2l9pkA=;
 b=xWVJni44+cfVC77JtAsdhRR1DIZx42aGBeVDipCt6rYdYc4+VXNpMOX9C983T97p/d
 FNBL90KP7bZP7czYc17pFuKXpueOk3XaDVzSWADCR1K6/NIW+6uC1BqADaBvtfDd6Omn
 L0uxkU1/Cg+UMtqXiPYVj4vihYc4oDM3H7MfXlCJABZOrcXILtujYi0/u7iL2LK6FSs0
 MbPf1+bvDyCeZoJZiy/hzxJ5TWX8R/T7/e7adDBRX4WKPOWmKWSBLiXoe9ZhcUgYLNhH
 AfE2GheIay4TWTutm0kcFjNoB2OR3ozSigrOxcWhJLq5c81N4Cz7sts5T6gdLX0Xh5Cy
 1qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952549; x=1714557349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plBgM7Mzo/JhuzXa8aMMZ3nZa0XciMHnM8kXA2l9pkA=;
 b=PGIPTs4NCFrd/4iIEbmynLmchdygVcsN3XkleDZCDU2IrQEXNgeTlDtA3axCYyQqmC
 ZOPtMfEZEvVaTNLI09Kf0SX6jPjNKABbxfswQx+kjNEUslLKIXYyiY5U0Qg1ppjfUMJW
 e1t2pC/WI+9CGG9fnPuw4R/dC39p/dwfg/6lTmgjgpZ99MCxXKu+H87U363KQADy5kqh
 1FFmCQ8sgGEvlc3A60dD20hWG/m28qxK6t/oBCY41tlt+TsCgXlrf5ZTR5zOq/jGgrj0
 6SqgSRr1L2s1AwpN1cL8OHsQJA//JISlGM0CbbQ9WGztj2ssBA5ZuTRTlb6kq1k5NfJD
 /p/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMN9WJY6bK52rezB+AueC6Z8LJeA/9K9O+IxLVsE018xFQigXoAEp4OTcC73ICsdnaL6JoCiNGpH5uWucP8siT1DDHm+4=
X-Gm-Message-State: AOJu0Ywds1xI9TUhbVJw3LTR4YhZcyCEt7a/yHLZh134iqDow/4gBD7x
 0RMwBNNYbwDcZ3pg+pQQjiM52lqNLJf0DUeAEkIhJAGpKqKoyERkjmWbqPsiwrw=
X-Google-Smtp-Source: AGHT+IGnn8+69RrPbwnJAXVNkb6ZqC2VXSWpV0sbr26lTVO6qncPhx10N7VGFhz8hx5wTb1X1qRd8Q==
X-Received: by 2002:adf:c04c:0:b0:346:b452:1740 with SMTP id
 c12-20020adfc04c000000b00346b4521740mr1308529wrf.3.1713952549029; 
 Wed, 24 Apr 2024 02:55:49 -0700 (PDT)
Received: from [192.168.1.102] (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr.
 [176.184.51.42]) by smtp.gmail.com with ESMTPSA id
 z6-20020adff1c6000000b00343ad4bca7dsm16755948wro.85.2024.04.24.02.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 02:55:48 -0700 (PDT)
Message-ID: <82079170-9d82-46d5-81e4-44d3b38b551f@linaro.org>
Date: Wed, 24 Apr 2024 11:55:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/kvm: remove sneaky strerrorname_np()
 instance
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, mjt@tls.msk.ru,
 ajones@ventanamicro.com
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
 <20240424094700.453356-2-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424094700.453356-2-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 24/4/24 11:46, Daniel Henrique Barboza wrote:
> Commit d424db2354 excluded some strerrorname_np() instances because they
> break musl libc builds. Another instance happened to slip by via commit
> d4ff3da8f4.
> 
> Remove it before it causes trouble again.
> 
> Fixes: d4ff3da8f4 (target/riscv/kvm: initialize 'vlenb' via get-reg-list)
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/kvm/kvm-cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80..ee69ea9785 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1054,8 +1054,8 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>   
>           ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>           if (ret != 0) {
> -            error_report("Unable to read vlenb register, error code: %s",
> -                         strerrorname_np(errno));
> +            error_report("Unable to read vlenb register, error code: %d",
> +                         errno);

Why not use "%s" strerror(errno)?

>               exit(EXIT_FAILURE);
>           }
>   



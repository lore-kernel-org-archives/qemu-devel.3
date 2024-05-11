Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB5CC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nvl-0000Ry-R6; Sat, 11 May 2024 10:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nBa-00006L-VP; Sat, 11 May 2024 09:54:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nBZ-0008OU-CR; Sat, 11 May 2024 09:54:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso24744065ad.0; 
 Sat, 11 May 2024 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715435687; x=1716040487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kdHKLaOVtfaxnRAORcg87sybvc+WPbNTZPszw0pZkjk=;
 b=UyQSMbHjIke3MWs0FrBsVTMmaBFOy8y6seDz0BjQZ7jAoOY9SLtFnaTWig01qsS0ap
 UjrkEAVjJ/e2vo+ctxwzCdWrZ5wKX83r70rj1O9NYXVDF7YgeV4o0sE//Ap9e5YMf8bM
 S5G/BJBom633WrFJ2QC4PuopiSeLRIbYrruUi75BUZ6VKhZnUGP1DvIeT1PoPQbKxF1R
 +pN+dDphvMJWeNo8RYTe8X1JSmMv8ulhVmjCDrVAd4F2D6LPNXuPuWWwgvSDMLopPf8Q
 zeIhDTmaeMjZHElHosWw49cUNiXD1PQ3gjtca2QDk7Vu1HO+sPxRtYVYZJxBWVS0lymr
 G6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715435687; x=1716040487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdHKLaOVtfaxnRAORcg87sybvc+WPbNTZPszw0pZkjk=;
 b=s9oxsHCu1/0JfWS/AsYpc9um7m31nn4bh8yuAcjCdPuAHI8DezLrRwdkOpd0yfsP2z
 2wuWjMKCVnMz91bsRDyc4cl5AboR9T2swyTpMWLFz6nSzA5Vkqv0CkrtB2azuP4wUqhr
 yWbpmyw4EbtQoaddAxT240gftX/Kj0lp7v4j11edWNTYbwo4NTcn6ZwHWNwaRMW/OdVg
 Ganf5V28KotxU0O9APyoBMz1EIUJjH+gsqXXyOctBfoV+71iVIr+83fKMcygROtdIDDz
 JXJzsKNdcXd09ca+fOs9CXGxQJsJQ4ftFQFkqy+VZrIj51HHpVwIn+oaPY1c/day14D5
 aRqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl9MASZo0BCrUNaOYtOV0ptVzc+ozJ7qfkRnTUu7U/PpGdjIwZ/a4fK5mxpVxpIFKeXgDayNWyHod5tY9E/beHfBY51/Y=
X-Gm-Message-State: AOJu0YwlPZ1TGIicWlpsMn90zSQ66OkYUXw7zSwQtxaWB84wtTre2gr2
 hZK1NnFtV9FzgFBnrn3PpUmOwWpSYFAiR3WkfxSdU0mSi/gnX4cl
X-Google-Smtp-Source: AGHT+IE3lFQEXUFyyLKRx+BF5cVYWVi1T3AgPGaZq9ueRCbNnPW+5JyAlBFKyl6JcaHCo9cJqH6DOw==
X-Received: by 2002:a17:902:b694:b0:1ea:5ac0:ce46 with SMTP id
 d9443c01a7336-1ef4404c16amr48593295ad.66.1715435686850; 
 Sat, 11 May 2024 06:54:46 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0badb959sm49277515ad.85.2024.05.11.06.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 06:54:46 -0700 (PDT)
Message-ID: <82a07ba4-bf87-4a9f-83d8-f355de6aa194@gmail.com>
Date: Sat, 11 May 2024 21:54:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
To: Yangyu Chen <cyy@cyyself.name>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Content-Language: en-US
From: liwei <liwei1518@gmail.com>
In-Reply-To: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=liwei1518@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 10:42:26 -0400
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


On 2024/5/11 19:26, Yangyu Chen wrote:
> This code has a typo that writes zvkb to zvkg, causing users can't
> enable zvkb through the config. This patch gets this fixed.
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to riscv_cpu_extensions")
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by:  Weiwei Li <liwei1518@gmail.com>

Weiwei Li

>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Vector cryptography extensions */
>       MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>       MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>       MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>       MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>       MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),


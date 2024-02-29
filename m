Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6A2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmYO-0008AR-UL; Thu, 29 Feb 2024 14:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rfmYH-00089G-CV
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:58:45 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rfmYF-0008DF-Rr
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:58:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dccb2edc6dso12664075ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 11:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709236722; x=1709841522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ng4x3d5/elH3/Y2Ah/5tOIHwHPg+FbzN/pHpquuSEQI=;
 b=ZIJ3QHxBB/JSed0S2RvGhkpbSeTuPSH0TG1chLyMIWHVXWwgU2nFDjjYVxGC+qRtvF
 CY4KeFOLAHNsdmql5LjkJIcz5d+yXeoEqwa/Y9nzvi2ovVYf0WUecoORMox7EoZ3lXKc
 tZ0kYGYli54ynkcWdn5UwXN7dow/yOL571rVxS6TMEzISHLLm+50UOtGpzwX8ltPVyvc
 fRusUgefxAO/5WFPPykyW1mFRBLkX4Yb657vNro1MiGWEk6QebtDIOl6MsckQR41PZ1D
 tubvOCyAP3qPt1Vx09U9lJ9iOcqVlTduMb8dPn4Yo8EaFQu47u4y/Lf5E+N+RXA+MIuJ
 Pd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709236722; x=1709841522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ng4x3d5/elH3/Y2Ah/5tOIHwHPg+FbzN/pHpquuSEQI=;
 b=iJsm0KEAKNa5k9x47nMXbEMx7Y8PRsSjPqJ8BWZk3kY1KArwllKIe4xNmU0A2MG4bH
 wG9Ol8Yyr2KQN2c96c1bFmiXwJQoDfut/I/Lrc6Xe+uJTykql9pCwaCMYZwzXSuK8oVF
 qCHg4m/eF1r3T5g4p4wqpnjV5AiAe+xxReYQKetTP35QPC9VzTLwcDtFxMkX0WnfQ8rS
 grZaTkiKp6s2Lc/+pZUYwzoLprEqZJy06F8yFKV3gxLI/LMe+zDaOrYTz/qSIklu8wZu
 2QalPfJdOWtuzaOtRIUcPA7RanBZIHn+Ug+a9UORNfef7UAGErR83WJD5/WDHJ6u1Qpr
 Z2bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTkMuiSi+PZG2qw+TBx4rRlOotTkt2syEtlDCCKIcq7aNddxAepFgjkXAHwrZPitlhgY2HSv0Fk+WFz5NOkCCEpGbezNM=
X-Gm-Message-State: AOJu0Yz2NFry4ZKkgUfKOIDEkkCpWIBkSDYBKLkAad7Aoy7HBPk3qwZY
 SvRWtklsxJsCl8gxJ6ez/zMylGJ+A5CMR8YblihKes29qUdCLgnOee76uC2axW4=
X-Google-Smtp-Source: AGHT+IF5IxF9jEuIxUV06LA9k5H1klFcU885SNieGCPZ7MHAd4tYOW1sK5Vg8lBsb6aN6hvupNZEWw==
X-Received: by 2002:a17:902:c943:b0:1db:e245:8c35 with SMTP id
 i3-20020a170902c94300b001dbe2458c35mr3504853pla.30.1709236721656; 
 Thu, 29 Feb 2024 11:58:41 -0800 (PST)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170903230f00b001dc3c4e7a12sm1905338plh.14.2024.02.29.11.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 11:58:41 -0800 (PST)
Message-ID: <0cabb840-f440-4c36-8e35-3ecad1446082@ventanamicro.com>
Date: Thu, 29 Feb 2024 16:58:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: riscv64: Use 'zfa' instead of 'Zfa'
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 2/29/24 15:06, Christoph Müllner wrote:
> Running test-fcvtmod triggers the following deprecation warning:
>    warning: CPU property 'Zfa' is deprecated. Please use 'zfa' instead
> Let's fix that.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   tests/tcg/riscv64/Makefile.target | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> index a7e390c384..4da5b9a3b3 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -17,4 +17,4 @@ run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
>   TESTS += test-fcvtmod
>   test-fcvtmod: CFLAGS += -march=rv64imafdc
>   test-fcvtmod: LDFLAGS += -static
> -run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,Zfa=true
> +run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true


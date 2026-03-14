Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAAE10706C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1Lih-0005sc-Dn; Sat, 14 Mar 2026 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1Lif-0005sT-E4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:55:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1Lia-0005kP-QR
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 05:55:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so2433163f8f.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773482134; x=1774086934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWKyiHq5mtWYVClFY/t3EznsLTfptV/x8EPdV+Gg2yY=;
 b=kq3dThqS08H0v7hN+UTy2nAypEjTUxGVhGCMM7Usej6P7BkhU6cWGAyDgQUtljf2pb
 6lmhzgjA3xXPmVaSg2CxIXnB4l1UkNBBnGEzZUJybRAk+wolb0xkQIP02G9ddOYvsPua
 csqqjEtfXYsGbwPJuw83eyedo5CJtY39cz8lvsIMLkxWCnvD8o0kMGeNOmasT14NmWoZ
 TofpFYN/ZJ74GJ1xpW9jNCyRoktdoAecZCN5nUOj4O4m9SdFdbAQjYqKW287g5agWrGN
 Ja2O9cm+CO95fBL+nLXLcrYl6DOqRP4vSyNLP3AbDGKlgc/iW+EDXt9bmt1Nn8O/HVAe
 5F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773482134; x=1774086934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QWKyiHq5mtWYVClFY/t3EznsLTfptV/x8EPdV+Gg2yY=;
 b=pW3v6Fqvg8iTWvV0KQo7W3+Y0SV5n8U/STIw2KgcRMh5fcdqNIQIQPtox+R62Pc4eD
 /cEUEC29bGq3ciZmFGR4SEJD7YJBb2EQw3i4L496Q40Nt2LhaFLnlONgd6uqRxQ37K/u
 Gw+N7x9J+WnKcJMvCQVfEjdhNjpvyl9c2N08RYGwzsM/OXewY/5ehBYCUKVpPRExzsIQ
 qgqv025usXy46LsMEoFidke0T7D7PVXhr1rrqiXt/kHKFgnE6GIfjSps24LhZ+Sm7pzJ
 CMFfmvshjOOyU0xwOZR2cEQTErhnNomFaGd4f+xCvcxNAcXzrKSpfafbqBi8j9vuRBs8
 p7rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNR8E9anE+H0q6MdT9ZJv5WJx2BvSHAXDo7xS+4CNcSPOfIaDPIYZ7lvaAGMrlASwfIsiFjeJYIaHZ@nongnu.org
X-Gm-Message-State: AOJu0Yxw/Q+AihnWhjanO2lCm2gHFdoim+mffaLULWZ/VUz58hIuTzyK
 iC7UW7UbfYvY9DfbRFBmwvyebJyJ2ZfZm28PnLNyE5swl1S4gpcCCr3mvxxSijsaLE0=
X-Gm-Gg: ATEYQzwmUF6bLLOvLTTgkGlYTvw8/FqIKPqQhfmnV4iw4T/+Ylx1gL0NR2MrGuyLKaY
 LoSoVhje+QbPZv1yD+6s1wmwEImVSYegk+QIbUSANma1WTgdCOWAr+bjCFarCc249ivcxA1vXTj
 f+LaNWHkOk2e2OURmSOCloaphxec84h6dd/AaNi6csUArgD1qEf2BsgeacJeANU1lgNJz7oS5V4
 WjYrCmhUTKttuDtdpkkhZkLFMtqkn/4wYZ8TKh6J5tbws85ZGDVZAz0++MJjwgYuxGgrbl2gqPk
 LGsz14J7uj4197hYZ3MM1MuVYGu1fny/zJpmbYD/ES9B99bUjg8JCeuC/auxuUOsU3Bci8qeijJ
 r8A1KtBX6uaxKRu3+TkXcEWRVu5hzlKm+se6cUWrCjZwgst1ihHRDrvcMJsYp5/a7+IQ8+p7sSR
 5d1sxmc8N/VnQ279YmrZGoDcAdWXDMu93ciTxwt5OI4EqCZGCUOL/emQpQm16MKMxPZg==
X-Received: by 2002:a05:600c:45d3:b0:480:1e40:3d2 with SMTP id
 5b1f17b1804b1-48556705301mr103757195e9.29.1773482134147; 
 Sat, 14 Mar 2026 02:55:34 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b66ffe2sm250097375e9.13.2026.03.14.02.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2026 02:55:33 -0700 (PDT)
Message-ID: <6afd7294-dac3-4909-9ee4-8cfb8ee344be@linaro.org>
Date: Sat, 14 Mar 2026 10:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] hw/riscv: Free resources allocated at
 riscv_iommu_instance_init
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-5-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260313182957.28432-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/3/26 19:29, Fabiano Rosas wrote:
> Add a riscv_iommu_instance_finalize() routine and move there the unref
> of the iot_cache and ctx_cache hash tables from riscv_iommu_unrealize.
> 
> Also start freeing the register state masks, also allocated at the
> _init function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   hw/riscv/riscv-iommu.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


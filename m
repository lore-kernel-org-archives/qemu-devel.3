Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C507BC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 12:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnHPt-0003Ym-QC; Thu, 21 Mar 2024 08:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rnHPr-0003XM-Uw
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:21:04 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rnHPp-0000T7-OG
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 08:21:03 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e67b5d6dd8so465124a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711023659; x=1711628459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=smbaW+oxfwCRvPY+XLMIWID+ZomlceLUnZxJdw0HKvU=;
 b=jDfE913c8id7vZpo2u0qC6lUtCFCTo/c+9yuJ6pOOWdGDFlbX8lZ8FHYZDk9cu+09d
 EKBxOd+x2zuw98/gdqXGrmBgHl+zp0TiM3Eu1OB/3IZJVe0BAzOKJopnOFKwScfGt2e1
 9FEbWue0VavwQ7W05A6Rhv1QO3q1Z9Xvyf0HDBc4p5iLT+G1oOgaIxLb7CZ0I9E6sUsa
 fMAiVFDG+au85tnOFaHTW440rZG8HkHd6CoVTMoG3MqprDv/hGNFklwdzPjac71RBYDW
 WUIABu65XYbHLnTRxMlhGL4cMCs/FQPaA6b/1iZXb4YuAONRUMDxQjrQgPWcwf6qZHfI
 Z95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711023659; x=1711628459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smbaW+oxfwCRvPY+XLMIWID+ZomlceLUnZxJdw0HKvU=;
 b=baCkk9komndCjN0wYwXpRwsL0ba3NUgGT0gvyAyYN1xPgzHPWcLUrkpkPEvx1kw5mX
 /JDWajgC3MlX5BAA7D0ACyRsJI2KPb6Rsd9CKjmCfsyiKPojgIMF/TM7+MGsyN7lVnDV
 3YVUzuAmVad4v+oARUnRM9UOxd+SKBleTQ7ZrT7LzC9ULCJ6dlPP3PIrbpK/Wm1a5jy5
 3Fx/FxN8k0vI078PfEqi6SSjiuKe464k9IsBfyRsfEwz1Q/7aBBB+IC8NhZmEH13NISE
 g+r5k0f6xifZYWanBZbfQfZfwWNnjrBmoTczBklhOvGGkIzsjzp+6e6gbDH18eNbI78D
 Ng8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQnAai0hDUbgvW0xSrX0yt5Iq0eulRXr/eNEE1LWUhPXEs8JMQIFDUjMwbZguX09+IrENhIn1OOhU9bA4JSwxSo9xInAo=
X-Gm-Message-State: AOJu0Yy9CT6GHNivyKrhDEYh8c7DGLd9cvsrCQw0zsK2F1QzOjnsjLkm
 Lb9YpIB4jJbUPkz7FIGxbIFMZ3vvEpiCR1Urz9HNDt0HH2w6+9rqsYqlFKtMeik=
X-Google-Smtp-Source: AGHT+IGRyflXXul0qYkoi/APMPzwmkVwXJCfhw8cy/6oHFH/dptreDtoFRcsDvfQQ8BHPzbCJtDIYQ==
X-Received: by 2002:a05:6870:c0d:b0:220:b9e4:a2bc with SMTP id
 le13-20020a0568700c0d00b00220b9e4a2bcmr5315023oab.42.1711023659338; 
 Thu, 21 Mar 2024 05:20:59 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a654043000000b005dc49afed53sm10977638pgp.55.2024.03.21.05.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 05:20:59 -0700 (PDT)
Message-ID: <f9aed9be-75bb-40e7-83af-0fd4161fce9e@ventanamicro.com>
Date: Thu, 21 Mar 2024 09:20:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/riscv: Expose Zve64x extension to users
Content-Language: en-US
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240306170855.24341-1-jason.chien@sifive.com>
 <20240306170855.24341-5-jason.chien@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240306170855.24341-5-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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



On 3/6/24 14:08, Jason Chien wrote:
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> ---

Please add the following tag in this commit msg:


Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2107


The link is a feature request named "target/riscv: zve32x/zve64x are not supported"
that was opened a couple of months ago. Adding this tag will close the bug (since by
this time we'll have both zve32x and zve64x) as soon as the series is merged to
master.


Thanks,


Daniel

>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8b5d1eb6a8..58b2a94694 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1473,6 +1473,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("zve32x", ext_zve32x, false),
>       MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
>       MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
> +    MULTI_EXT_CFG_BOOL("zve64x", ext_zve64x, false),
>       MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
>   
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),


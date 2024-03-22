Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF43C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 19:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnkr2-0008O0-76; Fri, 22 Mar 2024 15:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rnkqw-0008NT-JM
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:46:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rnkqo-0006kC-E9
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 15:46:58 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6cadfffdbso2083366b3a.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711136802; x=1711741602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OM1H2CpXGnBDZMCe31g2U+6JRULp620ZVjDnruiTPes=;
 b=oKa/UZYhhJaVN5EcGDJ3gaPUtASaGvvm7QuDxpOe8gOG2vcM1ZAKcVveXvqR2biAzr
 VIEBeqQpswD5bYmFuIuEhGNuKg5+KXA425w15Dng7WdixG6v5RCkRBXs6HPHx0unpYkg
 2fDBPgJL7fTDmzPfHytJ+iyQNFjOea3H/WnLwEgWgHT9h1Xvmd0PM3qd0g6In8Q+Z+ob
 Lmtv1e9m4NdoXpkrahJFu8HfzqHyTq/4k4bhE76+mkO4WBIgRlRvG5d96OZLJdzjN7/H
 NuSo6sWFvsQgA+UMkvnYwH6dtTqaFrbimz35ZPXRlIkbgh67A1xubioAVHa2xQnMcvfT
 +TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711136802; x=1711741602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OM1H2CpXGnBDZMCe31g2U+6JRULp620ZVjDnruiTPes=;
 b=nRuuULQILVP4dZTjtJp5GNnqHoSDTUpzE6Mmt6vAZyCpqtciHzPwok41d1bsJejsJz
 gTmvBowcsYEghfM+AnAsLmfK8v0owB+HCW8Y91GSQxxcN/gZwTWf4spZkM5IWmK8wOw/
 7rt3H6PRwN/0W/P+nIXAgMgCr80LzGkFwqsSclgzulmpLTdnfDJKZolkJFWWgoTdZ/zn
 prwy55aw1haw/yPXRCKvDOnHDd5HqNK/tSj+FdrYPbdoFupaeDSelItltOg6Zafeeno/
 QzTZW2RzlOqYGktWtsfk3jrZQJnPO3Hk+G9ZKBB3ilgidFcPtypp1smDwIvW1sYvBSlo
 Gi7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxBvxHX1drxJVuF4OcDDoxp+G+FOO6uIVb/zMKr1wxkpF2zXLuySwgIjmor8Tm51DG/OcjQ4uO7hDccMhCshZcur8YU1c=
X-Gm-Message-State: AOJu0YxJq2N++P0n4ITZoXFD4ABSQmDrSkYVxjKCWJfm3BO61vrJlVJc
 mv9ZT6kIDrJcoJAS7DhRKDFqMf6cYTHmsiALiE5Mc2JpC9jjOnUqZqtntGetMn8=
X-Google-Smtp-Source: AGHT+IFPEBIKiox5OB0tt+GX7dalgeNOkhk9CUAX6l95GdfysCJunoDp/h0L7Q8Qdfz0FRDeWJa8VA==
X-Received: by 2002:a05:6a00:84f:b0:6e6:f9b8:38eb with SMTP id
 q15-20020a056a00084f00b006e6f9b838ebmr796680pfk.21.1711136802040; 
 Fri, 22 Mar 2024 12:46:42 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 fk26-20020a056a003a9a00b006e6bf17ba8asm137338pfb.65.2024.03.22.12.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 12:46:41 -0700 (PDT)
Message-ID: <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
Date: Fri, 22 Mar 2024 16:46:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis
 <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 3/22/24 14:16, Michael Tokarev wrote:
> 22.03.2024 11:53, Alistair Francis :
> 
>> RISC-V PR for 9.0
>>
>> * Do not enable all named features by default
>> * A range of Vector fixes
>> * Update APLIC IDC after claiming iforce register
>> * Remove the dependency of Zvfbfmin to Zfbfmin
>> * Fix mode in riscv_tlb_fill
>> * Fix timebase-frequency when using KVM acceleration
> 
> Should something from there be picked up for stable (8.2 and probably 7.2)?

Ignore the "Do not enable all named features by default" since it's fixing something
that were added in 9.0.

The rest you can pick it up to 8.2 at least. Thanks,


Daniel



> 
> Thanks,
> 
> /mjt
> 
>> ----------------------------------------------------------------
>> Daniel Henrique Barboza (10):
>>        target/riscv: do not enable all named features by default
>>        target/riscv/vector_helper.c: set vstart = 0 in GEN_VEXT_VSLIDEUP_VX()
>>        trans_rvv.c.inc: set vstart = 0 in int scalar move insns
>>        target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess
>>        target/riscv: always clear vstart in whole vec move insns
>>        target/riscv: always clear vstart for ldst_whole insns
>>        target/riscv/vector_helpers: do early exit when vstart >= vl
>>        target/riscv: remove 'over' brconds from vector trans
>>        trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>>        target/riscv/vector_helper.c: optimize loops in ldst helpers
>>
>> Frank Chang (1):
>>        hw/intc: Update APLIC IDC after claiming iforce register
>>
>> Irina Ryapolova (1):
>>        target/riscv: Fix mode in riscv_tlb_fill
>>
>> Ivan Klokov (1):
>>        target/riscv: enable 'vstart_eq_zero' in the end of insns
>>
>> Max Chou (1):
>>        target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin
>>
>> Yong-Xuan Wang (1):
>>        target/riscv/kvm: fix timebase-frequency when using KVM acceleration
> 


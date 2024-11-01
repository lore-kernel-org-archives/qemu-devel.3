Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3782E6F06F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vc5-0003r8-QN; Fri, 01 Nov 2024 13:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6vbg-0003dc-6H
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:38:50 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t6vbe-00010r-IZ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:38:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e2cc47f1d7so1639929a91.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730482720; x=1731087520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CV1Y7oANaxQ/a/o/wO72sx3sFIO+Sg75sDPCy70s1F0=;
 b=B200mO7YeefXYFjmANzE/LH5gloJ1NugtrBJkGZA/uOABL+G38G29B3v7UnOKtmBHh
 6NhHSoCjmUubwjR1RIFxvmnaMpVv0BrySOvA2FiPniNdw/fxBGxExJwKUEUL155pNGuH
 D5+nf17okcebIpOzo4fE8Xsiu8SYf9f6eiPKHk4uBeZZCx/Wa2UeYW5TKMRop3IzzzaM
 4FhtqlEPCfOBmimPKSjID28NULIId9QQBtBe7NKhTpv7c83xgMH5KEUe92p2p7zfVjhU
 kDBcDBOiLGjYsOTr/D/DDK9QtfQCBA5qUQjcFFKrouh+yO29gjWdI+tpwAvbCsvbKd6j
 1C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730482720; x=1731087520;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CV1Y7oANaxQ/a/o/wO72sx3sFIO+Sg75sDPCy70s1F0=;
 b=H0pDadTzMrrqI1My7HEo57Pvk6UpoIzT/rNmJuiDd7NS+DjP7RpsZ9xRo23U9CGDXD
 QEViinEXs8Q3hQDWzC6zBtCDWe924RlJJpMfyzxmUw4tmMkbdsK95ZHyrO/D1nMdgZRO
 U0ysbIQ3EaON2/HdE80f5BoZ8yXGPn7Eq8PEP0DxuzwgXSlPkLk/NqQpFZosw36alIqB
 tDM/b90pv0XjvffgNJs4yU4QgzLIC430V4e1UCSYoHX8ExlbH5wp1HT/uKk5QUbvYmJp
 MC8nfYaDe6tCYXZKlFo5qNkBsobSTAO4dkIaQvZiTN8YPw1mDbuNyiE1YWAchiNM0pWI
 z8dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNwlsESTWw4Xiwn2TztPNKAyK38O9+tnEQt+ypogOdjUKwyzMppHayjzpUbzGQq0ur0DuuwOnqX8Sh@nongnu.org
X-Gm-Message-State: AOJu0YyJ0qAN6U3ihghyo2H5r0fgiClo2dfoPH3DS6S92LMViktbNKn+
 UIEYjn2iRoetr1EDZRYvgAU7LboCZxbWNDlDop1xBN5U/LkxOh9hbFdcZSeNnFk=
X-Google-Smtp-Source: AGHT+IFhevH29oI++rAyxIbCQcIg0+d51miWzjkKcHNe+v81Lhn+lk1invs5Beh4fVWJ/hgHcp8Ylg==
X-Received: by 2002:a17:90b:1d89:b0:2e1:8a41:aaba with SMTP id
 98e67ed59e1d1-2e94c23325emr6763242a91.19.1730482720607; 
 Fri, 01 Nov 2024 10:38:40 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db186bcsm3294118a91.46.2024.11.01.10.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 10:38:40 -0700 (PDT)
Message-ID: <aba7cd2e-ff44-4f2e-8aab-43ac3a47672f@ventanamicro.com>
Date: Fri, 1 Nov 2024 14:38:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv: fix build error with clang
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20241101170833.1074954-1-pierrick.bouvier@linaro.org>
 <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <2e1af830-a90a-447f-ab47-1c3d49463134@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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



On 11/1/24 2:35 PM, Daniel Henrique Barboza wrote:
> 
> 
> On 11/1/24 2:08 PM, Pierrick Bouvier wrote:
>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>
>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>
>>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>
>>        |                 ^
>>
>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>>
>>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>
>>        | ^
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


I think you can also add a

Fixes: 0c54acb824 ("hw/riscv: add RISC-V IOMMU base emulation")

>> ---
>>   hw/riscv/riscv-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> index feb650549ac..f738570bac2 100644
>> --- a/hw/riscv/riscv-iommu.c
>> +++ b/hw/riscv/riscv-iommu.c
>> @@ -184,7 +184,7 @@ static void riscv_iommu_pri(RISCVIOMMUState *s,
>>   }
>>   /* Portable implementation of pext_u64, bit-mask extraction. */
>> -static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>> +static uint64_t pext_u64(uint64_t val, uint64_t ext)
> 
> I suggest name it 'riscv_iommu_pext_u64' to be clear that this is a local scope function,
> not to be mistaken with anything available in clang or any other compiler.
> 
> 
> Thanks,
> 
> Daniel
> 
>>   {
>>       uint64_t ret = 0;
>>       uint64_t rot = 1;
>> @@ -528,7 +528,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>>       int cause;
>>       /* Interrupt File Number */
>> -    intn = _pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>> +    intn = pext_u64(PPN_DOWN(gpa), ctx->msi_addr_mask);
>>       if (intn >= 256) {
>>           /* Interrupt file number out of range */
>>           res = MEMTX_ACCESS_ERROR;


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3837CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0evW-0006Lt-UI; Mon, 22 Sep 2025 07:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v0evB-0006KN-4h
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:41:31 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v0ev0-0003s7-9T
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:41:24 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6353e91a04aso601537d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758541275; x=1759146075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WuLGT7NbBAiH+gR9lGV3KijyooEFYXSa7Esj2mlztW0=;
 b=RXdeB5AfM1xrNxhlJZ2dMrIg8TAnnRv410CYxRjXS+7Sx28CGi0kYSbU3TEiP2Sr+D
 rxravebgD6zoRcd0P1O4NtSZ2oDHrWy5Fzb6+zcSsXXEdfoLkh9J6p7aYVfr/THu7x0U
 oQYSQ5ksEdQjLIJqa73CI6w1JTiUKyofMqY9GVoO1PEUSOd5frXfVgwsMg4p6ViRXHcd
 oXs0AH1aYrAtwmFZNME413OBMhchRGSt/C4cj170MYCOGWRITI981JeAUepoTrbpZyGE
 hSKrofZFEsw1BxT/zEK52yDAhV1SAhao9X6CqKpegQN6O4IjxzosNUR6vhPJFTiXQs5J
 RUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541275; x=1759146075;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WuLGT7NbBAiH+gR9lGV3KijyooEFYXSa7Esj2mlztW0=;
 b=qNaqamL+9PEB7plEilN4ljppc9pJMq2feU3f3f6jPR7kcQR89BFTGifwMg5CjuYeMB
 furcH8ReTBQLJaK66rPq45ajHujLqffHzUBlutPwC/fASaPBGpifGY3b51BK0qgSLoaJ
 3ZhwlDU5ZrGgf+QiyHnjDt3Me4AvNlAKLdMzUK2+ljsKrRj6pNdoGj+UM2HRBKN+rXdW
 IZRPB+jf0/3ZZ0v1p3owzjRwZjuAvKTm1ztH2iYrvoCHlw3S7l4GfsaQTrdfDRNEn2LT
 xl7jVy04KqpPMsFEPNm2/O02oR00FzdsLu7YdS6/IZORhOdWE/22HY6MCF1Y7413A0BZ
 uR5w==
X-Gm-Message-State: AOJu0Yxc1ECyHCGDPagTiQMVyeaUKrUsFjoUbWSgupnnz+PqVjfNUGpo
 BZqkHJgeFfgbZU9W03IFaofjrYq5UngdR7YvVv4YhnmJIm3IH9T03fpPn7Y/u2tzJKk=
X-Gm-Gg: ASbGncv3/bhr7O3TQ1eyga4hvqwvcmTN9h/wV7rDJwx4pWK4Hp9ViWHMRnW/tUO77NZ
 uJ5x8UC5kubuT6J66zblRzciEY2T7Pp797h9T64MSzPzfaetZX9EgMWcLt46eqxnNyhUU/5Sn/d
 SyWHx2FLdbZdqamKdBL3DeEH0JTdlE9b4Ta+7bPPROYw+iJXrXCU1s3ULfTi4rw4nIICyGpSlrp
 i/jpqmEFDYuKujzMJXV3QVYVk4c7AyiUjrKLN1gA3wYcjeI9C9W+C9AqwbfjdAh8grQ1DnX3xao
 Y0pFWDYmmq4U0iiFdVgJmFnE0IAWEgYb7HJMhUYMoq+nKbR5H0RNznYyWNJvfhK5hyF5nossoRI
 YSdmeA6kOfc1uSG1k+zrkstdAQtHMjwpE4iHvCeX0GRRK
X-Google-Smtp-Source: AGHT+IHrxfUGMtywOleIxjQ+fw06wG4BwagZ+Zs1X6c/wGSkssXPAxiZxIyjzIamyRqGZ4YS06BUjg==
X-Received: by 2002:a05:690c:d0d:b0:730:5445:4b2a with SMTP id
 00721157ae682-73d3caa1e2emr110385597b3.45.1758541275205; 
 Mon, 22 Sep 2025 04:41:15 -0700 (PDT)
Received: from [192.168.68.110] ([189.79.22.64])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-74612b99365sm16383977b3.71.2025.09.22.04.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:41:13 -0700 (PDT)
Message-ID: <1128d12f-c518-430d-b90a-8e628ac69c5e@ventanamicro.com>
Date: Mon, 22 Sep 2025 08:41:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/8] target/riscv: rvv: Add new VTYPE CSR field -
 altfmt
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
 <20250915084037.1816893-4-max.chou@sifive.com>
 <26d72d8e-5e58-4a04-865c-34f6094e74e9@ventanamicro.com>
 <CANiaA1tzoM+y8vcFUdFaP8Po8Af2AGy_1gyuHzzPo8sG9rJ+Pg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CANiaA1tzoM+y8vcFUdFaP8Po8Af2AGy_1gyuHzzPo8sG9rJ+Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yx1-xb12f.google.com
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



On 9/22/25 5:03 AM, Max Chou wrote:
> On Wed, Sep 17, 2025 at 9:57 PM Daniel Henrique Barboza <dbarboza@ventanamicro.com <mailto:dbarboza@ventanamicro.com>> wrote:
> 
>     Is this correct? The 'reserved' value you're returning when the new extension is enabled
>     is the original  value from vsetvl:
> 
>      > +    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
>      > +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>      > +                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> 
>     The original val you removed:
> 
>      > -    target_ulong reserved = s2 &
>      > -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>      > -                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> 
> 
>     To preserve the existing behavior I believe you want to negate the conditional:
> 
>      > +    if (!riscv_cpu_cfg(env)->ext_zvfbfa) {
>      > +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>      > +                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      > +    } else {
>      > +        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
>      > +                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
>      > +    }
> 
> 
>     i.e. return the existing 'reserved' val if the new extension is absent, otherwise return
>     the new val.
> 
> 
>     Thanks,
> 
>     Daniel
> 
> Hi Daniel,
> 
> 
> Yes, I believe that’s correct. After enabling the Zvfbfa extension, the reserved field in the VTYPE CSR depends on the extension as follows:
> 
>   * When Zvfbfa is enabled:
>       o The reserved field in the VTYPE CSR: from bit 9 (VTYPE_RESERVED) to XLEN
>   * When Zvfbfa is not enabled:
>       o The reserved field in the VTYPE CSR: from bit 8 (VTYPE_ALTFMT) to XLEN
> 
> 
> PS: This commit also modifies the definition of VTYPE_RESERVED.
> 
> Because the EDIV extension is not planned to be part of the base V extension. Therefore, this commit modifies the default RESERVED field definition.
> 
> 
> Reference: https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc <https://github.com/riscvarchive/riscv-v-spec/blob/master/ediv.adoc>


Thanks for the info. That makes sense now. I suggest mentioning in the commit
msg that VTYPE_RESERVED was changed and the default value without Zvfbfa is
now different.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> 
> 
> Thanks,
> 
> Max
> 
> 
>      > +
>      > +    return reserved;
>      > +}
>      > +
>      >   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      >                               target_ulong s2, target_ulong x0)
>      >   {
>      > @@ -41,12 +57,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      >       uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
>      >       uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
>      >       uint16_t sew = 8 << vsew;
>      > -    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
>      > +    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
>      >       int xlen = riscv_cpu_xlen(env);
>      >       bool vill = (s2 >> (xlen - 1)) & 0x1;
>      > -    target_ulong reserved = s2 &
>      > -                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>      > -                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>      >       uint16_t vlen = cpu->cfg.vlenb << 3;
>      >       int8_t lmul;
>      >
>      > @@ -63,7 +76,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      >           }
>      >       }
>      >
>      > -    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
>      > +    if (cpu->cfg.ext_zvfbfa) {
>      > +        if (altfmt == 1 && vsew >= MO_32) {
>      > +            vill = true;
>      > +        }
>      > +    }
>      > +
>      > +    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
>      >           /* only set vill bit. */
>      >           env->vill = 1;
>      >           env->vtype = 0;
> 



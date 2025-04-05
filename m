Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0EEC3601A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zWx-00089e-8h; Sat, 05 Apr 2025 05:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zWv-00089V-Te
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:09:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zWq-0007MI-4U
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:09:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so2086013b3a.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844165; x=1744448965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3eTd+5TnHd7hLlK3FSxmtVSi10a/l6t/obHj4PhwPP8=;
 b=dtA5QScIJtuovwCqTyK4ds5XtbUm0dEDtiT05sTBRpEkLPXWO5kptvIYsD83K6bwtq
 Og5AIlC6yEEQV86TqIHspiUmffM6z6DWVErbtVst4Z5vb3qQtA9GEHsOySnHV+snYUeQ
 P2BICV19mQ1ZI/v4RUa2XzyeoxTK9gRL8zeERs+D8Ow8etuBeJCVX58Brgtm3H6WSVlc
 Xbrkmubx1ZHZ2yjNhxiAqLFgKiMd+aShER0NEgKBO3NKxDTZjJZRmhF4EDUXFXPloHP7
 iXyCvmqy83NFQ5KhCWZKiKTd2X7gyQ9uUuFyb2fgMDwq9E2izWK+LVBpToFUNF80ondV
 pJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844165; x=1744448965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3eTd+5TnHd7hLlK3FSxmtVSi10a/l6t/obHj4PhwPP8=;
 b=dIUKm66lfvEmebcZ1mr60bsjuDm/daq+MYd6fzpeKsL7REuyct8uoGvAvD4fE/QJXe
 D2cHD2OeTXE75Yyy8Fq1hJrSHistS5SeLXSZ5g8vSh+qU1jtEPO6mRLIZ4hE9Lxgma+i
 tLHIPm803IpB/94GN8/qLe1+ezmVRXR8BP8JtgN1kxd3wYBBy4vfWo0yq6Na4vAaoIw8
 7wrqCnOtwC+i+J/4W9NAh6Pmw9JVna4tYT3JQ8Cz4P0n+OpvOq/FQHwJROKlHjGWUQSF
 9YTsmCokux6TVKTa5yZKU4v/Rhlk32lPCK3uQPryfmj+RDjdhqDyILAwGVPoa4t5ZQhH
 IshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6cbQ5zcxaDpSRQ+LqpdGi24RKMAxIMhnXs2BPjyvVQCdSa1aNL4SSdSvqvwbXD1n87pEcsGt/yDA@nongnu.org
X-Gm-Message-State: AOJu0YyTgPuCTBB0OE+lxeY/DF3CFugxUdO3pM5Yy+qyr17OtaABDc1r
 RjTWphB63AfYgTipwPajQ3apjbP/zaVzxILrzRNRGzeijiyTOGYr/qe/2EBZauA=
X-Gm-Gg: ASbGncucNMGdD/SKOoyMKv4GTwn4kjlxINT1KJUB0mPIjoLSMBSBFXnHdQ7zbe+Pu6z
 qjk4/Cve7fmgtiXe/H66R1Hg7eBV8hFSGcbAHDzsKGusn6dFpP0/9Vkv71pmGmtcwEkkWJkRwBd
 3jN5X+uwyDGEfqzL/9WW+4fZ4WnTIe7YbrM57oAbFHp+LOSMgCT8735gxoQF1U2KouafK5JJ1l2
 oeVTsdrXhL29/R88+llrUc2y5D2a8wOtO/XJRXGVYm25ZB+3dKsH+6vX2Ok/2E+BC1rjbgtJRZ7
 jD879btDx2fuf/0WxHxFslWhqP0yUDjH61G4tfirNyRfpUvfQ1EHBj5/7UbArSTZ1cE0TRk=
X-Google-Smtp-Source: AGHT+IFNuj5v1kOXe5AAtvupygvatUu8Rd+2UgGqC5H8GrvRJinrKrqefmjbaBENZYmZXCy7Qn/gYQ==
X-Received: by 2002:a05:6a20:3d8d:b0:1f5:93b1:6a58 with SMTP id
 adf61e73a8af0-20107eacc49mr7532882637.8.1743844165399; 
 Sat, 05 Apr 2025 02:09:25 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee6b3sm4981067b3a.53.2025.04.05.02.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:09:24 -0700 (PDT)
Message-ID: <b554b45e-50c2-41e9-af73-5074bdfee0ee@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:09:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] target/riscv: Add vext_check_input_eew to check
 mismatched input EEWs encoding constraint
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-4-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-4-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 3/29/25 11:44 AM, Max Chou wrote:
> According to the v spec, a vector register cannot be used to provide source
> operands with more than one EEW for a single instruction.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index e630f8661e1..70c19c49ae4 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -379,6 +379,35 @@ static bool vext_check_ld_index(DisasContext *s, int vd, int vs2,
>       return ret;
>   }
>   
> +/*
> + * Check whether a vector register is used to provide source operands with
> + * more than one EEW for the vector instruction.
> + * Returns true if the instruction has valid encoding
> + * Returns false if encoding violates the mismatched input EEWs constraint
> + */
> +static bool vext_check_input_eew(DisasContext *s, int vs1, uint8_t eew_vs1,
> +                                 int vs2, uint8_t eew_vs2, int vm)
> +{
> +    bool is_valid = true;
> +    int8_t emul_vs1 = eew_vs1 - s->sew + s->lmul;
> +    int8_t emul_vs2 = eew_vs2 - s->sew + s->lmul;
> +
> +    /* When vm is 0, vs1 & vs2(EEW!=1) group can't overlap v0 (EEW=1) */
> +    if ((vs1 != -1 && !require_vm(vm, vs1)) ||
> +        (vs2 != -1 && !require_vm(vm, vs2))) {
> +        is_valid = false;
> +    }
> +
> +    /* When eew_vs1 != eew_vs2, check whether vs1 and vs2 are overlapped */
> +    if ((vs1 != -1 && vs2 != -1) && (eew_vs1 != eew_vs2) &&
> +        is_overlapped(vs1, 1 << MAX(emul_vs1, 0),
> +                      vs2, 1 << MAX(emul_vs2, 0))) {
> +        is_valid = false;
> +    }
> +
> +    return is_valid;
> +}
> +

Code LGTM but the patch won't compile on its own because there's no callers for
it:


In file included from ../target/riscv/translate.c:1182:
../target/riscv/insn_trans/trans_rvv.c.inc:388:13: error: ‘vext_check_input_eew’ defined but not used [-Werror=unused-function]
   388 | static bool vext_check_input_eew(DisasContext *s, int vs1, uint8_t eew_vs1,
       |             ^~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.


We want each patch to be "buildable" and with test passing to make our lives easier
when doing bisects.

You can merge this patch with patch 4 to introduce the new function and add its first
callers. Thanks,


Daniel



>   static bool vext_check_ss(DisasContext *s, int vd, int vs, int vm)
>   {
>       return require_vm(vm, vd) &&



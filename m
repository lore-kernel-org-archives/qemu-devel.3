Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31A5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVphN-0006Ah-CI; Mon, 22 Jul 2024 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVphJ-0005xo-Qb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVphI-0004w3-3b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721641870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hmYhr9um/j4/dPY2KVLvq77g3ZXrbiVnPLgeC8BCCwI=;
 b=EpkvHo2tUiwAl4nsb3/zoFpIFo7066sifk1Ol5+A4sU0uk42v4cre5lgWSngDEOJS3/Lif
 yoMHDrgtTl8WSchi8Oz8e0aPrThSpLwFHiLryw/dUQEa7qZ78aAWLN7U5zdCOnH2tW2pX0
 2JzFBW5ox9a0ZHmZCdXyORTJHlar4fU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-o41RhH8CMTy5sxR3J9hPbQ-1; Mon, 22 Jul 2024 05:51:05 -0400
X-MC-Unique: o41RhH8CMTy5sxR3J9hPbQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3687f5a2480so2233899f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721641864; x=1722246664;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmYhr9um/j4/dPY2KVLvq77g3ZXrbiVnPLgeC8BCCwI=;
 b=siCu9t/xIi/wiOw+7hqQnx6MvXsG7+Q19dPBJFimzaPQymxyDxGhukUf6POWPPQPOJ
 jqA2rPhoh42XsLcoM7ube22u1ESSq3qIHvQplCqb28WHjWWK4MJpQOJ7FYCPvGfodogF
 OJG9xmXePeix1OnL1jUOgtJ18RgdxYEIoOKhy6l9Q2ig1D4/b41erP+gEyeFMQI2RO5Q
 9yn7ltY4EAVGnkg0fr0hcCbuUu3dhdLc3jFgm+kMLzMUZrantgbv04DorJjAFLa6cVYM
 rXIVXYVzpF3Tb4RM+iNUyqyI7ZAQu25m0D06/YGhIFiNDxfvrcNdoAJCXTVcjNVkWq3F
 /sUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2f4dy/Mxjy9q0PaVG++w//8D1pd4lvlcUBcXWtR5GdKmjXOeRce0SE6OaDAsbNdPMig5mf5cZdKzRODwD/eldWBXiyoI=
X-Gm-Message-State: AOJu0Yw4rP2CSGwayG5A/WUWUGnvKKKIfmlncs2DenzdayNrPOST0Byf
 bSQLHLsIAwtM2OnQ1KktdBdnVh2xkastEftXlf/P/zmJ2g/YkhZ9KALtoT8eaP6uvJ4DvWZkMTR
 clN7+UKPUUFMJy3eB5RsG2gsHYv84NYfwklj2+nhsxVdAC4AkXibg
X-Received: by 2002:adf:fa03:0:b0:368:5d2:179 with SMTP id
 ffacd0b85a97d-36831755ea0mr9063635f8f.56.1721641864032; 
 Mon, 22 Jul 2024 02:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGmOq7xrdoduH83slEnaADkb4qnscIsenmBHMbWzNQ18MTkW4813eazznFebxYA1EQuYfRGg==
X-Received: by 2002:adf:fa03:0:b0:368:5d2:179 with SMTP id
 ffacd0b85a97d-36831755ea0mr9063311f8f.56.1721641849688; 
 Mon, 22 Jul 2024 02:50:49 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eced0sm7959079f8f.98.2024.07.22.02.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 02:50:49 -0700 (PDT)
Message-ID: <6da1bf69-5336-44ce-9014-2fc566d2593a@redhat.com>
Date: Mon, 22 Jul 2024 11:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/2] target/riscv: Add RISC-V CSR qtest support
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240703081939.498641-1-ivan.klokov@syntacore.com>
 <20240703081939.498641-2-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240703081939.498641-2-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 03/07/2024 10.19, Ivan Klokov wrote:
> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>   target/riscv/cpu.c     | 17 ++++++++++++++
>   target/riscv/cpu.h     |  3 +++
>   target/riscv/csr.c     | 53 +++++++++++++++++++++++++++++++++++++++++-
>   tests/qtest/libqtest.c | 27 +++++++++++++++++++++
>   tests/qtest/libqtest.h | 14 +++++++++++
>   5 files changed, 113 insertions(+), 1 deletion(-)
...
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6fe0d712b4..6d4bbec53c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -32,6 +32,8 @@
>   #include "cpu_cfg.h"
>   #include "qapi/qapi-types-common.h"
>   #include "cpu-qom.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/qtest.h"

Why do you need these include statements here?

>   typedef struct CPUArchState CPURISCVState;
>   
> @@ -813,6 +815,7 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>   
>   /* CSR function table */
>   extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> +bool csr_qtest_callback(CharBackend *chr, gchar **words);
>   
>   extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>   
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58ef7079dc..f4f5128c9c 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -29,7 +29,7 @@
>   #include "sysemu/cpu-timers.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
> -
> +#include "tests/qtest/libqtest.h"

Code in target/ should never include code from tests/ ... if you really need 
this, you likely did something wrong...?

  Thomas

>   /* CSR function table public API */
>   void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
> @@ -4549,6 +4549,57 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +#if !defined(CONFIG_USER_ONLY)
> +static uint64_t csr_call(char *cmd, uint64_t cpu_num, int csrno,
> +                                uint64_t *val)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
> +    CPURISCVState *env = &cpu->env;
> +
> +    int ret = RISCV_EXCP_NONE;
> +    if (strcmp(cmd, "get_csr") == 0) {
> +        ret = riscv_csrrw(env, csrno, (target_ulong *)val, 0, 0);
> +
> +    } else if (strcmp(cmd, "set_csr") == 0) {
> +        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
> +    }
> +
> +    if (ret == RISCV_EXCP_NONE) {
> +        ret = 0;
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    return ret;
> +}
> +
> +bool csr_qtest_callback(CharBackend *chr, gchar **words)
> +{
> +    if (strcmp(words[0], "csr") == 0) {
> +
> +        uint64_t res, cpu;
> +
> +        uint64_t val;
> +        int rc, csr;
> +
> +        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
> +        g_assert(rc == 0);
> +        rc = qemu_strtoi(words[3], NULL, 0, &csr);
> +        g_assert(rc == 0);
> +        rc = qemu_strtou64(words[4], NULL, 0, &val);
> +        g_assert(rc == 0);
> +        res = csr_call(words[1], cpu, csr, &val);
> +
> +        qtest_send_prefix(chr);
> +        qtest_sendf(chr, "OK %"PRIx64" "TARGET_FMT_lx"\n", res, (target_ulong)val);
> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +#endif
> +
>   /*
>    * Control and Status Register function table
>    * riscv_csr_operations::predicate() must be provided for an implemented CSR
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c7f6897d78..f8c3ff15a9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1205,6 +1205,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>       return 0;
>   }
>   
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args = qtest_rsp_args(s, 3);
> +
> +    rc = qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc == 0);
> +    rc = qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc == 0);
> +
> +    g_strfreev(args);
> +}
> +
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         uint64_t *val)
> +{
> +    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
> +                    name, cpu, csr, *val);
> +
> +    qtest_rsp_csr(s, val);
> +    return 0;
> +}
> +
>   void qtest_add_func(const char *str, void (*fn)(void))
>   {
>       gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index c261b7e0b3..7b547e5e2c 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -577,6 +577,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>                            uint32_t nargs, uint64_t args,
>                            uint32_t nret, uint64_t ret);
>   
> +/**
> + * qtest_csr_call:
> + * @s: #QTestState instance to operate on.
> + * @name: name of the command to call.
> + * @cpu: hart number.
> + * @csr: CSR number.
> + * @val: Value for reading/writing.
> + *
> + * Call an RISC-V CSR read/write function
> + */
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         unsigned long *val);
> +
>   /**
>    * qtest_bufread:
>    * @s: #QTestState instance to operate on.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86FC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 07:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJTYu-0001Ry-Nf; Tue, 18 Jun 2024 03:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJTYr-0001R5-9s
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 03:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sJTYp-0002OT-4b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 03:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718696841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mWLjwDR1vyF6PcOUpPbr80F0eiZXr7f3ee1AensZv7c=;
 b=OUqyVEYPMDfYmkdcxe7z9vHviEibD0EU+9zBDvf27knT6EpmaLSJFYmrXRLoTCGhxd3ufs
 0GrYvT4k7O1YVgXARZf3ibVleq1wLmdcr3iPWsvqPU8QAM5+PWLTdHoKbOaKW+CZS4gE08
 O7YSQw44m9n++810qmudnv0dkKMsBBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-aDhQ3GxxPcCVOw--0zQerw-1; Tue, 18 Jun 2024 03:47:17 -0400
X-MC-Unique: aDhQ3GxxPcCVOw--0zQerw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35f2030f868so3804429f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 00:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718696837; x=1719301637;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWLjwDR1vyF6PcOUpPbr80F0eiZXr7f3ee1AensZv7c=;
 b=dulvEJumvYZefxRZcCKjNfMjI+TWmzh09GenPq74s8fHx7Q4hPBxnav5tphB2/wjPG
 HbPLevDPEhjWgjmL6AL3NiU2XMOF5YyXDjjTbnZMJpnz/TYZFQAUfdnvOQGO9hX6rJrT
 I0H3EZFNC3NoeKur2bjR+aVxOlAh5Y4Ern+8s5+XG/WuvLX6A6q1nIPJjtEB6zZm20Hk
 Yy0ZVc0uTnLomd99BJ0R7T61i7xf8ZUIaOs2PfRUFOLTqfNeBoOqXZxWdNEvvJN8CR3t
 sFA+C/9O7vkBH0Zi5JLS0KD7IK/7ynVuFej41hF4NBvW2tyrnWCnLwb1H5VP/ZGrIBWT
 qXUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUySACjviW0JQ5ejQkGxqZxeh3tEZ2y2IKp+13PacWOtCWiU5Rhxbnv9BEYXME9K+TI21EkSY8tRQU1m4dGS5ng67AWIK8=
X-Gm-Message-State: AOJu0YyQiP1UR2ZCLRX1XxYkWxVwi8oo7G9KnZhOU5cwx96OE6+S7mEL
 3x6V+MN62ia2oNHuUxG12wZreCBA3NPAgCu6Nx9zpQv0QThh9Ca7BwvfUHj8kmIdvCQmBVGFzBs
 oQ8+950v2o5H3GcY149HsY57ka/hn27EYplo9012b8FOoKRiuG0wv
X-Received: by 2002:a05:6000:1fa1:b0:360:7a52:3078 with SMTP id
 ffacd0b85a97d-3607a7832d5mr12632509f8f.46.1718696836692; 
 Tue, 18 Jun 2024 00:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqtbqdb56B7BuC2CxnEOvGwfsELp3M46kMYgLQC7sn0bgXsQdznHsXAyOoojcw6WtjZrmDVg==
X-Received: by 2002:a05:6000:1fa1:b0:360:7a52:3078 with SMTP id
 ffacd0b85a97d-3607a7832d5mr12632479f8f.46.1718696836267; 
 Tue, 18 Jun 2024 00:47:16 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f224esm13434072f8f.66.2024.06.18.00.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 00:47:15 -0700 (PDT)
Message-ID: <cfb98ee4-00e8-4d2e-9a08-be63164b93b2@redhat.com>
Date: Tue, 18 Jun 2024 09:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] Add RISC-V CSR qtest support
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240618064443.6474-1-ivan.klokov@syntacore.com>
 <20240618064443.6474-2-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240618064443.6474-2-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 18/06/2024 08.44, Ivan Klokov wrote:
> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
...
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58ef7079dc..82540ae5dc 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -29,7 +29,7 @@
>   #include "sysemu/cpu-timers.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
> -
> +#include "tests/qtest/libqtest.h"
>   
>   /* CSR function table public API */
>   void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
> @@ -4549,6 +4549,53 @@ static RISCVException write_jvt(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
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
> +    }

Is there a reason for ignoring errors here? If not, I'd rather replace that 
final if-statement with:

     else {
         g_assert_not_reached();
     }

to make sure that mistakes in setting the right sub-command don't get 
ignored without any error message.

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
> +
>   /*
>    * Control and Status Register function table
>    * riscv_csr_operations::predicate() must be provided for an implemented CSR
> diff --git a/tests/qtest/libqos/csr.c b/tests/qtest/libqos/csr.c
> new file mode 100644
> index 0000000000..2dc52fc442
> --- /dev/null
> +++ b/tests/qtest/libqos/csr.c
> @@ -0,0 +1,42 @@
> +/*
> + * QTest RISC-V CSR driver
> + *
> + * Copyright (c) 2024 Syntacore
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "../libqtest.h"
> +#include "csr.h"
> +
> +static uint64_t qcsr_call(QTestState *qts, const char *name, uint64_t cpu,
> +                           int csrno, uint64_t *val)
> +{
> +    uint64_t res = 0;
> +
> +    res = qtest_csr_call(qts, name, cpu, csrno, val);
> +
> +    return res;
> +}
> +
> +int qcsr_get_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val)
> +{
> +    int res;
> +
> +    res = qcsr_call(qts, "get_csr", cpu, csrno, val);
> +
> +    return res;
> +}
> +
> +int qcsr_set_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val)
> +{
> +    int res;
> +
> +    res = qcsr_call(qts, "set_csr", cpu, csrno, val);
> +
> +    return res;
> +}

Technically, there does not seem to be anything related to libqos in your 
patch set. libqos is a framework for executing tests on various buses, e.g. 
to test PCI devices on various host PCI bus implementations. All that is 
triggered via qos-test.c. Your CSR test does not seem to fit into that 
catogory, so please put that code rather directly in your riscv-csr-test.c 
file instead. (unless you want to use it in a lot of other tests in the 
future, too, then maybe you could move them as static inlines into the csr.h 
header instead).

> diff --git a/tests/qtest/libqos/csr.h b/tests/qtest/libqos/csr.h
> new file mode 100644
> index 0000000000..d953735fe8
> --- /dev/null
> +++ b/tests/qtest/libqos/csr.h

Again, not related to libqos, please move it up to the qtest folder itself.

> @@ -0,0 +1,16 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef LIBQOS_CSR_H
> +#define LIBQOS_CSR_H
> +
> +int qcsr_get_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val);
> +
> +int qcsr_set_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val);
> +
> +
> +#endif /* LIBQOS_CSR_H */
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> index 558eb4c24b..a944febbd8 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -25,6 +25,9 @@ libqos_srcs = files(
>           # usb
>           'usb.c',
>   
> +        #riscv csr
> +        'csr.c',
> +
>           # qgraph devices:
>           'e1000e.c',
>           'i2c.c',
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 18e2f7f282..4667d8d873 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1200,6 +1200,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
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

Just a matter of taste, but I think I'd rather inline the contents of 
qtest_rsp_csr() here since both functions are not very big yet.
(unless you need qtest_rsp_csr() in another function later, then it's of 
course better to keep it separate)

> +    return 0;
> +}

  Thomas



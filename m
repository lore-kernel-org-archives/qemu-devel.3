Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F386CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpdw-0007UU-Tr; Mon, 22 Jul 2024 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVpds-0007TH-DG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVpdq-0004C7-LA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721641656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DCeWAsKq3odGACB0B5Rccn4aOJxgNiPYL+NRgMa6IzY=;
 b=CMVT/oF2ubBpvW1phJhescWh75ORJd8maeYDXeXXROtVxCCkGgDV8y4msE2qww3NHqX62x
 wfZtf1LcmmRvWbKsbJ9OQzf97HvdfMKbGLi0GHxFbq3D5K8xC/N4bVAhZ5EZ5JE5WTcVzc
 VNMCgK/upFnzjq5+IXnv9IZ4pkUuS2I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Avq9weelPzS97hUO1OWe9g-1; Mon, 22 Jul 2024 05:47:35 -0400
X-MC-Unique: Avq9weelPzS97hUO1OWe9g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427df7b6879so11640765e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 02:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721641654; x=1722246454;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCeWAsKq3odGACB0B5Rccn4aOJxgNiPYL+NRgMa6IzY=;
 b=nBAP8HvGSB1RcK5c0oXdILERxSDZFN4wnwGtSA+nTybH93ltjhn73Ouh8ZhfGc6Qpw
 KqNTnwjBqo/6mqnZF/esTmaVE6YoYq+60K6d2cr3DRZWyZMmQ7E9TA68jAZqZmhzTUvK
 aMbdydJemmV8ghVP2/+hwXxGGBJb2Ceuqv8GBPfEi/M7EMC8nrO7WNrUxhIAvs6HJz2A
 L39sbXv0GYiguk481EOl0wZQNzdAdFLUXCn5YmMx9EUkRpa5nr7owtYTzjO230vknFI5
 CWvZUmendhky16y1uSevg5UNx6Nyl93qyxsvlbMb1RK5Ww/HmpDj/bUy0ra8f5b/6NuJ
 PJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo2jXkV7vE9flTaXJXI64B5uaxYubL8rSGgN6a74/DGNUD6VusQoKhisVPa26o7m2xcDMTHnF1JbDnV5t+ncU+2crX6ok=
X-Gm-Message-State: AOJu0Yy2P4CmVIUQkGpUMn/XNo1xJR4o6o2T8Y/9D6V/yXn3Vg9IzLlX
 0CMuyy/oTte2CDR1GNw58nr6ErgkJ6hl2zKJ8z57E+qStjNWlfwbICnZ4C1y/u4LMvf6rHxNjIl
 KZCObBqMe7ThD/13nw6eAJPmMW2Sw7bbqesLFXdxh7DBZC3p4wWRF
X-Received: by 2002:a05:600c:19ca:b0:424:ac60:de6c with SMTP id
 5b1f17b1804b1-427dc51cec0mr44917355e9.10.1721641654145; 
 Mon, 22 Jul 2024 02:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsrauAQfeC3U6Hd+EL8XrYoLk3lOpgGvo2lezagyqHMxGQ1i9Af7mBs8IJ4M2DUof8cIBRwA==
X-Received: by 2002:a05:600c:19ca:b0:424:ac60:de6c with SMTP id
 5b1f17b1804b1-427dc51cec0mr44917195e9.10.1721641653702; 
 Mon, 22 Jul 2024 02:47:33 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2927e21sm91949025e9.0.2024.07.22.02.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 02:47:33 -0700 (PDT)
Message-ID: <b09331f3-0cc6-41ee-9d4e-22310943e2f7@redhat.com>
Date: Mon, 22 Jul 2024 11:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/2] tests/qtest: QTest example for RISC-V CSR
 register
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240703081939.498641-1-ivan.klokov@syntacore.com>
 <20240703081939.498641-3-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240703081939.498641-3-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Added demo for reading CSR register from qtest environment.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>   tests/qtest/meson.build      |  2 +
>   tests/qtest/riscv-csr-test.c | 86 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 88 insertions(+)
>   create mode 100644 tests/qtest/riscv-csr-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 12792948ff..45d651da99 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -259,6 +259,8 @@ qtests_s390x = \
>   qtests_riscv32 = \
>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
>   
> +qtests_riscv32 += ['riscv-csr-test']

Could you please add it directly to the qtests_riscv32 list above intead of 
using a separate += line here?

>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(
>     'ac97-test.c',
> diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
> new file mode 100644
> index 0000000000..e9af9ca724
> --- /dev/null
> +++ b/tests/qtest/riscv-csr-test.c
> @@ -0,0 +1,86 @@
> +/*
> + * QTest testcase for RISC-V CSRs
> + *
> + * Copyright (c) 2024 Syntacore.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "libqtest.h"
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

Could you please get rid of this useless qcsr_call() wrapper and call 
qtest_csr_call() everywhere instead?

> +static int qcsr_get_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val)

Bad indentation, please align "int csrno" with QTestState.

> +{
> +    int res;
> +
> +    res = qcsr_call(qts, "get_csr", cpu, csrno, val);
> +
> +    return res;
> +}
> +
> +static int qcsr_set_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val)

dito.

> +{
> +    int res;
> +
> +    res = qcsr_call(qts, "set_csr", cpu, csrno, val);
> +
> +    return res;
> +}
> +
> +static void run_test_csr(void)
> +{
> +

Please remove the empty line above.

> +    uint64_t res;
> +    uint64_t val = 0;
> +
> +    res = qcsr_call(global_qtest, "get_csr", 0, 0xf11, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +    g_assert_cmpint(val, ==, 0x100);
> +
> +    val = 0xff;
> +    res = qcsr_call(global_qtest, "set_csr", 0, 0x342, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +
> +    val = 0;
> +    res = qcsr_call(global_qtest, "get_csr", 0, 0x342, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +    g_assert_cmpint(val, ==, 0xff);
> +
> +    qtest_quit(global_qtest);

Having qtest_quit here, while qtest_start is in the main function, looks 
really ugly and will likely cause trouble when extending the test later.

Please clean it up: Use qts = qtest_init() at the beginning of this function 
instead of calling qtest_start() in main(). Then you can get rid of 
global_qtest completely and also drop the #include "libtest-single.h" 
statement at the beginning of the function.

  Thanks,
   Thomas


> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/cpu/csr", run_test_csr);
> +
> +    qtest_start("-machine virt -cpu any,mvendorid=0x100");
> +
> +    return g_test_run();
> +
> +}



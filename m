Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E22FC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNXu-0004A6-5M; Wed, 26 Jun 2024 03:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMNXZ-000451-44
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMNXX-0001AI-EZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719388682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O/Kdd+mCP5TS2mkaeif4sj8AaCdUJ5uKmHfrAQ8Qtt0=;
 b=AkWdCdIB0OhLqNddI6j47H2rabNMMcmsulVscKeZkE/MlWqg2gaZzO9oRpz2B/VirT/U7i
 QN4qZcbUnNbMNhSByc6BrkqlJut5OjQpsC928AfIjuhFSPO6MvAz4ZlDcsaW3ud7I7r+NQ
 FV2ezOMMLKcOj2EssFDEb0l4PmhluBM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-h5mdAdmFPdykX3Bmhgq1hA-1; Wed, 26 Jun 2024 03:58:01 -0400
X-MC-Unique: h5mdAdmFPdykX3Bmhgq1hA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ec4e579e76so37343871fa.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 00:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388679; x=1719993479;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O/Kdd+mCP5TS2mkaeif4sj8AaCdUJ5uKmHfrAQ8Qtt0=;
 b=Z3KEhP+jZTN+DWglZ/fKcBSuq/JgeToEkO+jspgdC4/2Bl0ZNUL10nYGPnpPnE+5i3
 kIk2qxGMeMSCoBtQALNxwFuALeZ4zpHrx0mWh9Q570D7cyft6GuDQUzF8gINQ9mMvdla
 sWEERj9yRSO7NuHEa9S8vx4GuTlDksdrwi5lqP2PgEyY9k1p/D56rwp3Tb9HnUcBLITi
 Lp8LRwO0a9ihAcwXApWz2mCt6ujHgW1aSPzXi2XQPQzwYgLmozp0TpaupRSjZ3aNbsY5
 AdDNG0p7b718G1dwbWGO86eKSaTlqsub91Zw5NdHbBZXEwo3S+3hZKQNIxlKArQ+35R9
 tqZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6N10YcYUCJPyuik3H+1HvZTJixlYpvJ5K6w+WOtvufVU2Wf+DqRzu3othyuTGGsAGjM3xyn4Xtoe9LFwdhgnH3lKmo0A=
X-Gm-Message-State: AOJu0Ywu3r16vUXRw+CLz9Uv48jeHEvMPisCYlflRfs0KU2uDBRjNrFk
 QJ+E36HGpvrE1fh5RKUS5UH/swnNqRDUwduZTA7xv1VT7xp8yA0a7y7q5JPXFEfCZy1LboDa7C0
 9Pt+zHzDVlkrcG2TvGYwa59VLh+G2nMNmMGqZQ327GnG3+RDcbWWB
X-Received: by 2002:a19:2d0a:0:b0:52c:dcd4:8955 with SMTP id
 2adb3069b0e04-52ce183ade1mr5865611e87.34.1719388679537; 
 Wed, 26 Jun 2024 00:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZe7IxS1sRaosP313/q2Xwwn9+tyu76Crs1K/yqHu/p01iucd58cv+SaJovN0qYArkdWjH7Q==
X-Received: by 2002:a19:2d0a:0:b0:52c:dcd4:8955 with SMTP id
 2adb3069b0e04-52ce183ade1mr5865603e87.34.1719388679128; 
 Wed, 26 Jun 2024 00:57:59 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c823c51asm15513375e9.4.2024.06.26.00.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 00:57:58 -0700 (PDT)
Message-ID: <f5fd6b6f-3dd5-4036-be29-10b5bd0a29d4@redhat.com>
Date: Wed, 26 Jun 2024 09:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] tests/qtest: QTest example for RISC-V CSR
 register
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240625153555.104088-1-ivan.klokov@syntacore.com>
 <20240625153555.104088-3-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240625153555.104088-3-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/06/2024 17.35, Ivan Klokov wrote:
> Added demo for reading CSR register from qtest environment.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>   tests/qtest/meson.build      |  2 +
>   tests/qtest/riscv-csr-test.c | 85 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 87 insertions(+)
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
> +
>   qos_test_ss = ss.source_set()
>   qos_test_ss.add(
>     'ac97-test.c',
> diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
> new file mode 100644
> index 0000000000..21a3646ae9
> --- /dev/null
> +++ b/tests/qtest/riscv-csr-test.c
> @@ -0,0 +1,85 @@
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

This wrapper function looks completely unnecessary, just call 
qtest_csr_call() everywhere directly instead?

  Thomas

> +static int qcsr_get_csr(QTestState *qts, uint64_t cpu,
> +        int csrno, uint64_t *val)
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
> +    uint64_t res;
> +    uint64_t val = 0;
> +
> +    res = qcsr_get_csr(global_qtest, 0, 0xf11, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +    g_assert_cmpint(val, ==, 0x100);
> +
> +    val = 0xff;
> +    res = qcsr_set_csr(global_qtest, 0, 0x342, &val);
> +    g_assert_cmpint(res, ==, 0);
> +
> +    val = 0;
> +    res = qcsr_get_csr(global_qtest, 0, 0x342, &val);
> +
> +    g_assert_cmpint(res, ==, 0);
> +    g_assert_cmpint(val, ==, 0xff);
> +
> +    qtest_quit(global_qtest);
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



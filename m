Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50226C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Ga-00033I-Lm; Mon, 19 Feb 2024 09:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc4GV-00032r-4o
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc4GS-0006Dm-Pd
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708351500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4xPMvllzBCgc7KYC5/MOa2eoS/ye7mk4rZsmxF0dPRQ=;
 b=YMZ4EnQFSoyRYUatqTNaYFxveifpqDjai10KGREzZyqxU98LdmK9+jimxhEnhvZDWCTByM
 yQ0mvEr45LOE1RlO6LLzhlOCwCkD2OCAThcWxle2dgYaF2Q9bJmlIdqpRrXGhh+GiIMzcX
 RAi5VCg5iDRvbywTKFRPr85XE+Wt8Jc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-XeLJ8mrBOHKO2O5pAKlH4A-1; Mon, 19 Feb 2024 09:04:58 -0500
X-MC-Unique: XeLJ8mrBOHKO2O5pAKlH4A-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42c7be54afcso57941911cf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 06:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708351498; x=1708956298;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xPMvllzBCgc7KYC5/MOa2eoS/ye7mk4rZsmxF0dPRQ=;
 b=BwkdyVH+gHxVCIWF6Qt5/8x4hQfYqKjk5daCm7S7xg9mydLAR8jL8rp69zXY6Xpy11
 4k1cZ9nW5w0ZTGi7dl5UtkUJhT3rDSFmb8Cj+e7/V7014eTSq4OdLpKYlT3cLgjeXoS+
 v1sSmjprZ4i60Mr4HBLf9Cd4YVMufUusOzVSxhc0Z0OsxuF4JIY1cYOZaLipKR2tw73X
 S2bWedlFYIdLjRQhHWAk0RQEw2q4IkVBanYdLLziImDyburtABsE6irkTQsjEm5LJvba
 mwO22DN/KWdSoDt5TA4AbJc9DYMQnqTwYgD0Dpb7RUiiQzXYTGhaeYdeR+I80hTWq2Ws
 hawg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw/VfPMeUxyBjqWHyHVlT2IzKM3YnugtrPzjIwEJj9mnzACV/sm0MissKY3jAP01hdCQ7jviPgZIXLi3I6XSkqHYRmXgc=
X-Gm-Message-State: AOJu0Yyl/CzTrU0iL0cKSZI14qxB5OY3cvHZSuZlw89QUMAVeC/k0GlO
 aNuYmI542Lv8/jcKChSCqX6ygjwihwhySNxy9rIA7Nds6bu/ajz59p8ujBOFVE02g71zfbJoYuq
 BtmC3hoy+QcBG2+qxJSdhkcWJiVUar8ohpjOPqgI1ahpnnX+c9T6i
X-Received: by 2002:a0c:9792:0:b0:68f:5091:872f with SMTP id
 l18-20020a0c9792000000b0068f5091872fmr6062421qvd.53.1708351498024; 
 Mon, 19 Feb 2024 06:04:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG77FBCOW6rJwLS2eRYF6vSYoQEqYK2ygoOBexAkZx1Yjnv4g43d/5jvjBiRraKU2vQhnbVAg==
X-Received: by 2002:a0c:9792:0:b0:68f:5091:872f with SMTP id
 l18-20020a0c9792000000b0068f5091872fmr6062395qvd.53.1708351497735; 
 Mon, 19 Feb 2024 06:04:57 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 mc7-20020a056214554700b0068caf901c9bsm3260832qvb.17.2024.02.19.06.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 06:04:57 -0800 (PST)
Message-ID: <91aad72f-825f-47c1-a253-cefead336553@redhat.com>
Date: Mon, 19 Feb 2024 15:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tests/qtest: Add ivshmem-flat test
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
 <20240216144456.34992-7-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240216144456.34992-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/02/2024 15.44, Philippe Mathieu-Daudé wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Add qtest for the ivshmem-flat device.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Message-ID: <20231127052024.435743-4-gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/ivshmem-flat-test.c | 320 ++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build         |   2 +
>   2 files changed, 322 insertions(+)
>   create mode 100644 tests/qtest/ivshmem-flat-test.c
> 
> diff --git a/tests/qtest/ivshmem-flat-test.c b/tests/qtest/ivshmem-flat-test.c
> new file mode 100644
> index 0000000000..5489a0d915
> --- /dev/null
> +++ b/tests/qtest/ivshmem-flat-test.c
> @@ -0,0 +1,320 @@
> +/*
> + * Inter-VM Shared Memory Flat Device qtests
> + *
> + * SPDX-FileCopyrightText: 2023 Linaro Ltd.
> + * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "ivshmem-utils.h"
> +
> +#define IVSHMEM_FLAT_MMR_ADDR 0x400FF000
> +#define IVSHMEM_FLAT_SHM_ADDR 0x40100000
> +#define SHM_SIZE 131072 /* 128k */
> +
> +static ServerThread thread;
> +
> +uint32_t *shm_ptr;
> +char *shm_rel_path;
> +char *server_socket_path;
> +
> +static void cleanup(void)
> +{
> +    if (shm_ptr) {
> +        munmap(shm_ptr, SHM_SIZE);
> +        shm_ptr = NULL;
> +    }
> +
> +    if (shm_rel_path) {
> +        shm_unlink(shm_rel_path);
> +        shm_rel_path = NULL;
> +    }
> +
> +    if (server_socket_path) {
> +        unlink(server_socket_path);
> +        server_socket_path = NULL;
> +    }
> +}
> +
> +static void abort_handler(void *data)
> +{
> +    test_ivshmem_server_stop(&thread);
> +    cleanup();
> +}
> +
> +/*
> + * Check if exactly 1 positive pulse (low->high->low) on 'irq' IRQ line happens
> + * in 'timeout' second(s). 'irq' must be intercepted using qtest_irq_intercept_*
> + * before this function can be used on it. It returns 0 when pulse is detected,
> + * otherwise 1.
> + */
> +static int test_ivshmem_flat_irq_positive_pulse(QTestState *qts, int irq,
> +                                                int timeout)
> +{
> +    uint64_t num_raises = 0;
> +    uint64_t num_lows = 0;
> +    uint64_t end_time;
> +
> +    end_time = g_get_monotonic_time() + timeout * G_TIME_SPAN_SECOND;
> +    do {
> +        num_raises = qtest_get_irq_raised_counter(qts, 0);
> +        if (num_raises) {
> +            num_lows = qtest_get_irq_lowered_counter(qts, 0);
> +            /* Check for 1 raise and 1 low IRQ event. */
> +            if (num_raises == num_lows && num_lows == 1) {
> +                return 0;
> +            } else {
> +                g_message("%s: Timeout expired", __func__);
> +                return 1;
> +            }
> +        }
> +        qtest_clock_step(qts, 10000);
> +    } while (g_get_monotonic_time() < end_time);
> +
> +    return 1;
> +}

The timeout stuff looks like it will be quite sensitive to slow CI runners. 
Timeout is set to 2 seconds in most callers - but on very loaded systems, it 
can easily happen that a job gets interrupted for two seconds.

I think you should either increase the 2 seconds to something bigger (maybe 
use a #define for it), or instead of using g_get_monotonic_time(), rather 
loop a certain number of iterations and use a g_sleep(10000) in the loop 
body - that will also relax the host CPU while the test waits for QEMU to 
progress?

> +static inline uint32_t read_reg(QTestState *qts, enum Reg reg)
> +{
> +    uint32_t v;
> +
> +    qtest_memread(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
> +
> +    return v;
> +}
> +
> +static inline void write_reg(QTestState *qts, enum Reg reg, uint32_t v)
> +{
> +    qtest_memwrite(qts, IVSHMEM_FLAT_MMR_ADDR + reg, &v, sizeof(v));
> +}
> +
> +/*
> + * Setup a test VM with ivshmem-flat device attached, IRQ properly set, and
> + * connected to the ivshmem-server.
> + */
> +static QTestState *setup_vm(void)
> +{
> +    QTestState *qts;
> +    const char *cmd_line;
> +
> +    cmd_line = g_strdup_printf("-machine lm3s6965evb "

Could you please add a check, either in meson.build or in main(), to make 
sure that the lm3s6965evb machine is really available when running this 
test? ... it might have been disabled in the build ...

> +                               "-chardev socket,path=%s,id=ivshm "
> +                               "-device ivshmem-flat,chardev=ivshm,"
> +                               "x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',"
> +                               "x-bus-qompath='/sysbus',shmem-size=%d",
> +                               server_socket_path, SHM_SIZE);
> +    qts = qtest_init(cmd_line);
> +
> +    return qts;
> +}

  Thomas



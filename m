Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DEBC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSZJ-0008Hz-NV; Tue, 20 Feb 2024 11:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcSZH-0008He-OY
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:02:03 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rcSZD-0004eo-Mn
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:02:03 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2999329dfe7so2092137a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708444918; x=1709049718; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jl01hblCshM4jrd6Y8lI0n3bYzDGjAPg+QWRlS/Loz8=;
 b=iPWbi7NbsJGEniICObYSqx1edtQAGysk6ocvb+eciKrOLKKCzBb65Gaf5IsGa4Yp+Z
 0+j+z6v3O1ruLBOmNmyNVAE3ifgLex3lBD0bv//i2v9PIigoFieC86t4jeScQs2ssblt
 IIlwqVlKZCV9YfDkcnxeWBwl6IfOV78mWf0ih40KTT6hy81xCfzPBgr1be4Jf5YIZRtH
 rDYfe7Ml6o4QB/r05jOvQ+6rq7vCsvZAq69dCqenw4+T5sr58MxxOReRGoWuRGTPB02Q
 V69rWN52+4eMKZsRsU67feEKphnVDwXTx4FTmJQIicDe79VA89KE1tNYDhSwoBCqmeNx
 AJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708444918; x=1709049718;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jl01hblCshM4jrd6Y8lI0n3bYzDGjAPg+QWRlS/Loz8=;
 b=oojyK5dvPgp5XoD+1UCsZD/Fyc8GndRjx2/7xFdT//brksky1yOMoxwhW1Ool1KYIW
 PcKaiRKvVXqd0D0NbiL0IjkdcJRG0dMy25HNG8WyYU7pLVI6oDJdjaq9Co7zDBqy4Dp4
 YKVnCkgyzJ0MSR74xPfj2DIkYQ+OC2HnCThfDYY9hg+726NzgA0niakNdC9R+tQbk+kh
 0vRAYO4bi0uh8l3occsLscxsUqIDsgpQNV03HVxYvBgdyNNafmhxqMEm7Wyh3tvshdfT
 EwOUX8vSObquFa2W6Xy6hpDZeSXF9Mt97FR16X/3UTHDvyk9YAjzKxbTYV+ZKvXv03K1
 vASg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV94oxbtcUaKLu3KuxKFjvPpY1bOUlNzQeNqsSotTXS3+m4/3xy6Fnin27cdFL+h5CgEM3A3FwJi5MhhabLrrBBfzw7ZlQ=
X-Gm-Message-State: AOJu0Yx8UbwbjRRtOMBifrIAvfQzPzokqBw1NrsHBZHty3WCsSmnUOA6
 hqVib+E8FDgNSynvmsfZmvUHBoopQ4NDsEU0tow0y8nMJQe8MppwOPT+2wgnTqM=
X-Google-Smtp-Source: AGHT+IG4fjhBf2ntC1KxE79na/iOR5xeTmFKN7bIW4oVDm0mb2lwqFi0sFt4HAOgofrwSV0QOWSMgA==
X-Received: by 2002:a17:90a:a78d:b0:299:b92b:d1e8 with SMTP id
 f13-20020a17090aa78d00b00299b92bd1e8mr4102350pjq.7.1708444917929; 
 Tue, 20 Feb 2024 08:01:57 -0800 (PST)
Received: from ?IPv6:2804:7f0:b400:1b59:1a6a:7944:fbd6:3f71?
 ([2804:7f0:b400:1b59:1a6a:7944:fbd6:3f71])
 by smtp.gmail.com with ESMTPSA id
 sx12-20020a17090b2ccc00b0029454cca5c3sm2410138pjb.39.2024.02.20.08.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 08:01:55 -0800 (PST)
Subject: Re: [PATCH v2 6/6] tests/qtest: Add ivshmem-flat test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Kochkov
 <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
 <20240216144456.34992-7-philmd@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <bfe6403a-46a6-dfb9-6486-f3ea005b15cb@linaro.org>
Date: Tue, 20 Feb 2024 13:01:49 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20240216144456.34992-7-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.297,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2/16/24 11:44 AM, Philippe Mathieu-Daudé wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Add qtest for the ivshmem-flat device.

This needs a commit message.

All tests are failing is this commit due to the last
changes. So we need to tweak it (see my comments inline).

Also, I think we need to mark
it pendent upon the new IRQ toggling API (not merged yet), so add a:

Based-on: https://lists.gnu.org/archive/html/qemu-devel/2023-11/msg03176.html

or

Based-on: <20231113230149.321304-1-gustavo.romero@linaro.org>


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
> +
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
> +                               "-chardev socket,path=%s,id=ivshm "
> +                               "-device ivshmem-flat,chardev=ivshm,"
> +                               "x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',"
> +                               "x-bus-qompath='/sysbus',shmem-size=%d",
> +                               server_socket_path, SHM_SIZE);
> +    qts = qtest_init(cmd_line);
> +
> +    return qts;
> +}
> 

Fix this part with:

      cmd_line = g_strdup_printf("-machine lm3s6965evb "
                                 "-chardev socket,path=%s,id=ivshm "
                                 "-device ivshmem-flat,chardev=ivshm,"
-                               "x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',"
-                               "x-bus-qompath='/sysbus',shmem-size=%d",
+                               "x-irq-qompath='/machine/soc/v7m/nvic/unnamed-gpio-in[0]',"
+                               "x-bus-address-iomem=0x400FF000,"
+                               "x-bus-address-shmem=0x40100000,"
+                               "shmem-size=%d",
                                 server_socket_path, SHM_SIZE);
      qts = qtest_init(cmd_line);

The x-bus-address-iomem and x-bus-address-shmem options are necessary
in the current state and if my suggestion for making them non-optional
is taken.


> +static void test_ivshmem_flat_irq(void)
> +{
> +    QTestState *vm_state;
> +    uint16_t own_id;
> +
> +    vm_state = setup_vm();
> +
> +    qtest_irq_intercept_out_named(vm_state,
> +                                  "/machine/peripheral-anon/device[0]",
> +                                  "irq-output");

      qtest_irq_intercept_out_named(vm_state,
                                    "/machine/peripheral-anon/device[0]",
-                                  "irq-output");
+                                  "sysbus-irq");


> +
> +    /* IVPOSTION has the device's own ID distributed by the ivshmem-server. */
> +    own_id = read_reg(vm_state, IVPOSITION);
> +
> +    /* Make device notify itself. */
> +    write_reg(vm_state, DOORBELL, (own_id << 16) | 0 /* vector 0 */);
> +
> +    /*
> +     * Check intercepted device's IRQ output line. Named IRQ line 'irq-output'
> +     * was associated to qtest IRQ 0 and after self notification qtest IRQ 0
> +     * must be toggled by the device. The test fails if no toggling is detected
> +     * in 2 seconds.
> +     */
> +    g_assert(test_ivshmem_flat_irq_positive_pulse(vm_state, 0, 2) == 0);
> +
> +    qtest_quit(vm_state);
> +}
> +
> +static void test_ivshmem_flat_shm_write(void)
> +{
> +    QTestState *vm_state;
> +    int num_elements, i;
> +    uint32_t  *data;
> +
> +    vm_state = setup_vm();
> +
> +    /* Prepare test data with random values. */
> +    data = g_malloc(SHM_SIZE);
> +    num_elements = SHM_SIZE / sizeof(*data);
> +    for (i = 0; i < num_elements; i++) {
> +        data[i] = g_test_rand_int();
> +    }
> +
> +    /*
> +     * Write test data to VM address IVSHMEM_FLAT_SHM_ADDR, where the shared
> +     * memory region is located.
> +     */
> +    qtest_memwrite(vm_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
> +
> +    /*
> +     * Since the shared memory fd is mmapped into this test process VMA at
> +     * shm_ptr, every byte written by the VM in its shared memory region should
> +     * also be available in the test process via shm_ptr. Thus, data in shm_ptr
> +     * is compared back against the original test data.
> +     */
> +    for (i = 0; i < num_elements; i++) {
> +        g_assert_cmpint(shm_ptr[i], ==, data[i]);
> +    }
> +
> +    qtest_quit(vm_state);
> +}
> +
> +static void test_ivshmem_flat_shm_read(void)
> +{
> +    QTestState *vm_state;
> +    int num_elements, i;
> +    uint32_t  *data;
> +    uint32_t v;
> +
> +    vm_state = setup_vm();
> +
> +    /* Prepare test data with random values. */
> +    data = g_malloc(SHM_SIZE);
> +    num_elements = SHM_SIZE / sizeof(*data);
> +    for (i = 0; i < num_elements; i++) {
> +        data[i] = g_test_rand_int();
> +    }
> +
> +    /*
> +     * Copy test data to the shared memory region so it can be read from the VM
> +     * (IVSHMEM_FLAT_SHM_ADDR location).
> +     */
> +    memcpy(shm_ptr, data, SHM_SIZE);
> +
> +    /* Check data */
> +    for (i = 0; i < num_elements; i++) {
> +        qtest_memread(vm_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
> +                      sizeof(v));
> +        g_assert_cmpint(v, ==, data[i]);
> +    }
> +
> +    qtest_quit(vm_state);
> +}
> +
> +static void test_ivshmem_flat_shm_pair(void)
> +{
> +    QTestState *vm0_state, *vm1_state;
> +    uint16_t vm0_peer_id, vm1_peer_id;
> +    int num_elements, i;
> +    uint32_t  *data;
> +    uint32_t v;
> +
> +    vm0_state = setup_vm();
> +    vm1_state = setup_vm();
> +
> +    /* Get peer ID for the VM so it can be used for one notify each other. */
> +    vm0_peer_id = read_reg(vm0_state, IVPOSITION);
> +    vm1_peer_id = read_reg(vm1_state, IVPOSITION);
> +
> +    /* Observe vm1 IRQ output line first. */
> +    qtest_irq_intercept_out_named(vm1_state,
> +                                  "/machine/peripheral-anon/device[0]",
> +                                  "irq-output");

      /* Observe vm1 IRQ output line first. */
      qtest_irq_intercept_out_named(vm1_state,
                                    "/machine/peripheral-anon/device[0]",
-                                  "irq-output");
+                                  "sysbus-irq");


> +
> +    /* Notify (interrupt) VM1 from VM0. */
> +    write_reg(vm0_state, DOORBELL, (vm1_peer_id << 16) | 0 /* vector 0 */);
> +
> +    /* Check if VM1 IRQ output line is toggled after notification from VM0. */
> +    g_assert(test_ivshmem_flat_irq_positive_pulse(vm1_state, 0, 2) == 0);
> +
> +    /* Secondly, observe VM0 IRQ output line first. */
> +    qtest_irq_intercept_out_named(vm0_state,
> +                                  "/machine/peripheral-anon/device[0]",
> +                                  "irq-output");

      /* Secondly, observe VM0 IRQ output line first. */
      qtest_irq_intercept_out_named(vm0_state,
                                    "/machine/peripheral-anon/device[0]",
-                                  "irq-output");
+                                  "sysbus-irq");


> +
> +    /* ... and do the opposite: notify (interrupt) VM0 from VM1. */
> +    write_reg(vm1_state, DOORBELL, (vm0_peer_id << 16) | 0 /* vector 0 */);
> +
> +    /* Check if VM0 IRQ output line is toggled after notification from VM0. */
> +    g_assert(test_ivshmem_flat_irq_positive_pulse(vm0_state, 0, 2) == 0);
> +
> +    /* Prepare test data with random values. */
> +    data = g_malloc(SHM_SIZE);
> +    num_elements = SHM_SIZE / sizeof(*data);
> +    for (i = 0; i < num_elements; i++) {
> +        data[i] = g_test_rand_int();
> +    }
> +
> +    /* Write test data on VM0. */
> +    qtest_memwrite(vm0_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
> +
> +    /* Check test data on VM1. */
> +    for (i = 0; i < num_elements; i++) {
> +        qtest_memread(vm1_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
> +                      sizeof(v));
> +        g_assert_cmpint(v, ==, data[i]);
> +    }
> +
> +    /* Prepare new test data with random values. */
> +    for (i = 0; i < num_elements; i++) {
> +        data[i] = g_test_rand_int();
> +    }
> +
> +    /* Write test data on VM1. */
> +    qtest_memwrite(vm1_state, IVSHMEM_FLAT_SHM_ADDR, data, SHM_SIZE);
> +
> +    /* Check test data on VM0. */
> +    for (i = 0; i < num_elements; i++) {
> +        qtest_memread(vm0_state, IVSHMEM_FLAT_SHM_ADDR + i * sizeof(v), &v,
> +                      sizeof(v));
> +        g_assert_cmpint(v, ==, data[i]);
> +    }
> +
> +    qtest_quit(vm0_state);
> +    qtest_quit(vm1_state);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    int shm_fd, r;
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* If test fails, stop server, cleanup socket and shm files. */
> +    qtest_add_abrt_handler(abort_handler, NULL);
> +
> +    shm_rel_path = mktempshm(SHM_SIZE, &shm_fd);
> +    g_assert(shm_rel_path);
> +
> +    /*
> +     * Map shm to this test's VMA so it's possible to read/write from/to it. For
> +     * VMs with the ivhsmem-flat device attached, this region will also be
> +     * mapped in their own memory layout, at IVSHMEM_FLAT_SHM_ADDR (default).
> +     */
> +    shm_ptr = mmap(0, SHM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
> +    g_assert(shm_ptr != MAP_FAILED);
> +
> +    server_socket_path = mktempsocket();
> +    /* It never fails, so no assert(). */
> +
> +    /*
> +     * Currently, ivshmem-flat device only supports notification via 1 vector,
> +     * i.e. vector 0.
> +     */
> +    test_ivshmem_server_start(&thread, server_socket_path, shm_rel_path, 1);
> +
> +    /* Register tests. */
> +    qtest_add_func("/ivshmem-flat/irq", test_ivshmem_flat_irq);
> +    qtest_add_func("/ivshmem-flat/shm-write", test_ivshmem_flat_shm_write);
> +    qtest_add_func("/ivshmem-flat/shm-read", test_ivshmem_flat_shm_read);
> +    qtest_add_func("/ivshmem-flat/pair", test_ivshmem_flat_shm_pair);
> +
> +    r = g_test_run();
> +
> +    test_ivshmem_server_stop(&thread);
> +    cleanup();
> +
> +    return r;
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index bc6457220c..c0468bc6e0 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -205,6 +205,7 @@ qtests_stm32l4x5 = \
>      'stm32l4x5_syscfg-test']
>   
>   qtests_arm = \
> +  (config_all_devices.has_key('CONFIG_IVSHMEM_FLAT_DEVICE') ? ['ivshmem-flat-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
>     (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
> @@ -320,6 +321,7 @@ qtests = {
>     'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
>     'erst-test': files('erst-test.c'),
>     'ivshmem-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
> +  'ivshmem-flat-test': ['ivshmem-utils.c', '../../contrib/ivshmem-server/ivshmem-server.c'],
>     'migration-test': migration_files,
>     'pxe-test': files('boot-sector.c'),
>     'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
> 


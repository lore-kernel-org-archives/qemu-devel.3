Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D3EE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 18:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbzN-00010a-UV; Tue, 17 Dec 2024 13:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbzM-00010J-32
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:08:08 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbzI-0005jC-0S
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:08:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BDF32110B;
 Tue, 17 Dec 2024 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734458882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MARslWbjifCdOGEjjRk2uGGFESCf9tHmzJA1JTwTIyI=;
 b=YeyUY/BThdgdhoDiXi2LRQthhrLzZ04J8elfhdexOSg2B7HG7xmjKXMLYWutRBwECMlrxS
 1OD3ki2n7zgH9yN2eY0jEZdjuLyqUtgx+ywHnymIM6EsLy/z+P5CVvTDJarTTFOMkknv/c
 Oaz8mW+eKn2iZEY69Z4/4adki3Du4nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734458882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MARslWbjifCdOGEjjRk2uGGFESCf9tHmzJA1JTwTIyI=;
 b=ojUw50R8HQObJfDUrnndMRPQBaGeW3Df3Y4/uPHd4jExwWGIEEf6jzupgYYaTVv3VD/EUf
 sFfZE3sLd4/lu1DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZWdEDCPp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U+ufuTSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734458881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MARslWbjifCdOGEjjRk2uGGFESCf9tHmzJA1JTwTIyI=;
 b=ZWdEDCPpqaNAA9B3UJdTr4gNtQ3KFpoLhIoWZQMYH3NBKrLj6dhFNhm87zZhcLC806Bip/
 xUL7BaujMoXVMPOxwjgt1XaPZO419x7zl2ohoG5LY+AbdnFnkhLXQh7qEV2vu2X0XodXqv
 dRax4t112qsbce2Ad/nQYc1FmnBGffw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734458881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MARslWbjifCdOGEjjRk2uGGFESCf9tHmzJA1JTwTIyI=;
 b=U+ufuTSIuNS7p4kpMXpMtTGnVv+rP66KmE6MSXedGcGg2ztcsRZCIgKF8zbHKRt2Pp2nJ5
 fm/RhOnl60Kdn/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC0C013A3C;
 Tue, 17 Dec 2024 18:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJ0LHAC+YWcmVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 18:08:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yichen Wang <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>, Yichen Wang <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v8 10/12] util/dsa: Add unit test coverage for Intel DSA
 task submission and completion.
In-Reply-To: <20241204021142.24184-11-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
 <20241204021142.24184-11-yichen.wang@bytedance.com>
Date: Tue, 17 Dec 2024 15:07:58 -0300
Message-ID: <87ttb2uqrl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 3BDF32110B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yichen Wang <yichen.wang@bytedance.com> writes:

> From: Hao Xiang <hao.xiang@linux.dev>
>
> * Test DSA start and stop path.
> * Test DSA configure and cleanup path.
> * Test DSA task submission and completion path.
>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  tests/unit/meson.build |   6 +
>  tests/unit/test-dsa.c  | 503 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 509 insertions(+)
>  create mode 100644 tests/unit/test-dsa.c
>
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d5248ae51d..394219e903 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -50,6 +50,12 @@ tests = {
>    'test-fifo': [],
>  }
>  
> +if config_host_data.get('CONFIG_DSA_OPT')
> +  tests += {
> +    'test-dsa': [],
> +  }
> +endif
> +
>  if have_system or have_tools
>    tests += {
>      'test-qmp-event': [testqapi],
> diff --git a/tests/unit/test-dsa.c b/tests/unit/test-dsa.c
> new file mode 100644
> index 0000000000..181a547528
> --- /dev/null
> +++ b/tests/unit/test-dsa.c
> @@ -0,0 +1,503 @@
> +/*
> + * Test DSA functions.
> + *
> + * Copyright (C) Bytedance Ltd.
> + *
> + * Authors:
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +
> +#include "qemu/cutils.h"
> +#include "qemu/memalign.h"
> +#include "qemu/dsa.h"
> +
> +/*
> + * TODO Communicate that DSA must be configured to support this batch size.
> + * TODO Alternatively, poke the DSA device to figure out batch size.
> + */
> +#define batch_size 128
> +#define page_size 4096
> +
> +#define oversized_batch_size (batch_size + 1)
> +#define num_devices 2
> +#define max_buffer_size (64 * 1024)
> +
> +/* TODO Make these not-hardcoded. */
> +static const strList path1[] = {
> +    {.value = (char *)"/dev/dsa/wq4.0", .next = NULL}
> +};
> +static const strList path2[] = {
> +    {.value = (char *)"/dev/dsa/wq4.0", .next = (strList*)&path2[1]},
> +    {.value = (char *)"/dev/dsa/wq4.1", .next = NULL}
> +};
> +
> +static Error **errp;
> +
> +static QemuDsaBatchTask *task;
> +
> +/* A helper for running a single task and checking for correctness. */
> +static void do_single_task(void)
> +{
> +    task = buffer_zero_batch_task_init(batch_size);
> +    char buf[page_size];
> +    char *ptr = buf;
> +
> +    buffer_is_zero_dsa_batch_sync(task,
> +                                  (const void **)&ptr,
> +                                  1,
> +                                  page_size);
> +    g_assert(task->results[0] == buffer_is_zero(buf, page_size));
> +
> +    buffer_zero_batch_task_destroy(task);
> +}
> +
> +static void test_single_zero(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    task = buffer_zero_batch_task_init(batch_size);
> +
> +    char buf[page_size];
> +    char *ptr = buf;
> +
> +    memset(buf, 0x0, page_size);
> +    buffer_is_zero_dsa_batch_sync(task,
> +                                  (const void **)&ptr,
> +                                  1, page_size);
> +    g_assert(task->results[0]);
> +
> +    buffer_zero_batch_task_destroy(task);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_single_zero_async(void)
> +{
> +    test_single_zero();
> +}
> +
> +static void test_single_nonzero(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    task = buffer_zero_batch_task_init(batch_size);
> +
> +    char buf[page_size];
> +    char *ptr = buf;
> +
> +    memset(buf, 0x1, page_size);
> +    buffer_is_zero_dsa_batch_sync(task,
> +                                  (const void **)&ptr,
> +                                  1, page_size);
> +    g_assert(!task->results[0]);
> +
> +    buffer_zero_batch_task_destroy(task);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_single_nonzero_async(void)
> +{
> +    test_single_nonzero();
> +}
> +
> +/* count == 0 should return quickly without calling into DSA. */
> +static void test_zero_count_async(void)
> +{
> +    char buf[page_size];
> +    buffer_is_zero_dsa_batch_sync(task,
> +                                  (const void **)&buf,
> +                                  0,
> +                                  page_size);
> +}
> +
> +static void test_null_task_async(void)
> +{
> +    if (g_test_subprocess()) {
> +        g_assert(!qemu_dsa_init(path1, errp));
> +
> +        char buf[page_size * batch_size];
> +        char *addrs[batch_size];
> +        for (int i = 0; i < batch_size; i++) {
> +            addrs[i] = buf + (page_size * i);
> +        }
> +
> +        buffer_is_zero_dsa_batch_sync(NULL, (const void **)addrs,
> +                                      batch_size,
> +                                      page_size);
> +    } else {
> +        g_test_trap_subprocess(NULL, 0, 0);
> +        g_test_trap_assert_failed();
> +    }
> +}
> +
> +static void test_oversized_batch(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    task = buffer_zero_batch_task_init(batch_size);
> +
> +    char buf[page_size * oversized_batch_size];
> +    char *addrs[batch_size];
> +    for (int i = 0; i < oversized_batch_size; i++) {
> +        addrs[i] = buf + (page_size * i);
> +    }
> +
> +    int ret = buffer_is_zero_dsa_batch_sync(task,
> +                                            (const void **)addrs,
> +                                            oversized_batch_size,
> +                                            page_size);
> +    g_assert(ret != 0);
> +
> +    buffer_zero_batch_task_destroy(task);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_oversized_batch_async(void)
> +{
> +    test_oversized_batch();
> +}
> +
> +static void test_zero_len_async(void)
> +{
> +    if (g_test_subprocess()) {
> +        g_assert(!qemu_dsa_init(path1, errp));
> +
> +        task = buffer_zero_batch_task_init(batch_size);
> +
> +        char buf[page_size];
> +
> +        buffer_is_zero_dsa_batch_sync(task,
> +                                      (const void **)&buf,
> +                                      1,
> +                                      0);
> +
> +        buffer_zero_batch_task_destroy(task);
> +    } else {
> +        g_test_trap_subprocess(NULL, 0, 0);
> +        g_test_trap_assert_failed();
> +    }
> +}
> +
> +static void test_null_buf_async(void)
> +{
> +    if (g_test_subprocess()) {
> +        g_assert(!qemu_dsa_init(path1, errp));
> +
> +        task = buffer_zero_batch_task_init(batch_size);
> +
> +        buffer_is_zero_dsa_batch_sync(task, NULL, 1, page_size);
> +
> +        buffer_zero_batch_task_destroy(task);
> +    } else {
> +        g_test_trap_subprocess(NULL, 0, 0);
> +        g_test_trap_assert_failed();
> +    }
> +}
> +
> +static void test_batch(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    task = buffer_zero_batch_task_init(batch_size);
> +
> +    char buf[page_size * batch_size];
> +    char *addrs[batch_size];
> +    for (int i = 0; i < batch_size; i++) {
> +        addrs[i] = buf + (page_size * i);
> +    }
> +
> +    /*
> +     * Using whatever is on the stack is somewhat random.
> +     * Manually set some pages to zero and some to nonzero.
> +     */
> +    memset(buf + 0, 0, page_size * 10);
> +    memset(buf + (10 * page_size), 0xff, page_size * 10);
> +
> +    buffer_is_zero_dsa_batch_sync(task,
> +                                  (const void **)addrs,
> +                                  batch_size,
> +                                  page_size);
> +
> +    bool is_zero;
> +    for (int i = 0; i < batch_size; i++) {
> +        is_zero = buffer_is_zero((const void *)&buf[page_size * i], page_size);
> +        g_assert(task->results[i] == is_zero);
> +    }
> +
> +    buffer_zero_batch_task_destroy(task);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_batch_async(void)
> +{
> +    test_batch();
> +}
> +
> +static void test_page_fault(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    char *buf[2];
> +    int prot = PROT_READ | PROT_WRITE;
> +    int flags = MAP_SHARED | MAP_ANON;
> +    buf[0] = (char *)mmap(NULL, page_size * batch_size, prot, flags, -1, 0);
> +    assert(buf[0] != MAP_FAILED);
> +    buf[1] = (char *)malloc(page_size * batch_size);
> +    assert(buf[1] != NULL);
> +
> +    for (int j = 0; j < 2; j++) {
> +        task = buffer_zero_batch_task_init(batch_size);
> +
> +        char *addrs[batch_size];
> +        for (int i = 0; i < batch_size; i++) {
> +            addrs[i] = buf[j] + (page_size * i);
> +        }
> +
> +        buffer_is_zero_dsa_batch_sync(task,
> +                                      (const void **)addrs,
> +                                      batch_size,
> +                                      page_size);
> +
> +        bool is_zero;
> +        for (int i = 0; i < batch_size; i++) {
> +            is_zero = buffer_is_zero((const void *)&buf[j][page_size * i],
> +                                      page_size);
> +            g_assert(task->results[i] == is_zero);
> +        }
> +        buffer_zero_batch_task_destroy(task);
> +    }
> +
> +    assert(!munmap(buf[0], page_size * batch_size));
> +    free(buf[1]);
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_various_buffer_sizes(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    char *buf = malloc(max_buffer_size * batch_size);
> +    char *addrs[batch_size];
> +
> +    for (int len = 16; len <= max_buffer_size; len *= 2) {
> +        task = buffer_zero_batch_task_init(batch_size);
> +
> +        for (int i = 0; i < batch_size; i++) {
> +            addrs[i] = buf + (len * i);
> +        }
> +
> +        buffer_is_zero_dsa_batch_sync(task,
> +                                      (const void **)addrs,
> +                                      batch_size,
> +                                      len);
> +
> +        bool is_zero;
> +        for (int j = 0; j < batch_size; j++) {
> +            is_zero = buffer_is_zero((const void *)&buf[len * j], len);
> +            g_assert(task->results[j] == is_zero);
> +        }
> +
> +        buffer_zero_batch_task_destroy(task);
> +    }
> +
> +    free(buf);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_various_buffer_sizes_async(void)
> +{
> +    test_various_buffer_sizes();
> +}
> +
> +static void test_double_start_stop(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    /* Double start */
> +    qemu_dsa_start();
> +    qemu_dsa_start();
> +    g_assert(qemu_dsa_is_running());
> +    do_single_task();
> +
> +    /* Double stop */
> +    qemu_dsa_stop();
> +    g_assert(!qemu_dsa_is_running());
> +    qemu_dsa_stop();
> +    g_assert(!qemu_dsa_is_running());
> +
> +    /* Restart */
> +    qemu_dsa_start();
> +    g_assert(qemu_dsa_is_running());
> +    do_single_task();
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_is_running(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +
> +    g_assert(!qemu_dsa_is_running());
> +    qemu_dsa_start();
> +    g_assert(qemu_dsa_is_running());
> +    qemu_dsa_stop();
> +    g_assert(!qemu_dsa_is_running());
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_multiple_engines(void)
> +{
> +    g_assert(!qemu_dsa_init(path2, errp));
> +    qemu_dsa_start();
> +
> +    QemuDsaBatchTask *tasks[num_devices];
> +    char bufs[num_devices][page_size * batch_size];
> +    char *addrs[num_devices][batch_size];
> +
> +    /*
> +     *  This is a somewhat implementation-specific way
> +     *  of testing that the tasks have unique engines
> +     *  assigned to them.
> +     */
> +    tasks[0] = buffer_zero_batch_task_init(batch_size);
> +    tasks[1] = buffer_zero_batch_task_init(batch_size);
> +    g_assert(tasks[0]->device != tasks[1]->device);
> +
> +    for (int i = 0; i < num_devices; i++) {
> +        for (int j = 0; j < batch_size; j++) {
> +            addrs[i][j] = bufs[i] + (page_size * j);
> +        }
> +
> +        buffer_is_zero_dsa_batch_sync(tasks[i],
> +                                      (const void **)addrs[i],
> +                                      batch_size, page_size);
> +
> +        bool is_zero;
> +        for (int j = 0; j < batch_size; j++) {
> +            is_zero = buffer_is_zero((const void *)&bufs[i][page_size * j],
> +                                     page_size);
> +            g_assert(tasks[i]->results[j] == is_zero);
> +        }
> +    }
> +
> +    buffer_zero_batch_task_destroy(tasks[0]);
> +    buffer_zero_batch_task_destroy(tasks[1]);
> +
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_configure_dsa_twice(void)
> +{
> +    g_assert(!qemu_dsa_init(path2, errp));
> +    g_assert(!qemu_dsa_init(path2, errp));
> +    qemu_dsa_start();
> +    do_single_task();
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_configure_dsa_bad_path(void)
> +{
> +    const strList *bad_path = &(strList) {
> +        .value = (char *)"/not/a/real/path", .next = NULL
> +    };
> +    g_assert(qemu_dsa_init(bad_path, errp));
> +}
> +
> +static void test_cleanup_before_configure(void)
> +{
> +    qemu_dsa_cleanup();
> +    g_assert(!qemu_dsa_init(path2, errp));
> +}
> +
> +static void test_configure_dsa_num_devices(void)
> +{
> +    g_assert(!qemu_dsa_init(path1, errp));
> +    qemu_dsa_start();
> +
> +    do_single_task();
> +    qemu_dsa_stop();
> +    qemu_dsa_cleanup();
> +}
> +
> +static void test_cleanup_twice(void)
> +{
> +    g_assert(!qemu_dsa_init(path2, errp));
> +    qemu_dsa_cleanup();
> +    qemu_dsa_cleanup();
> +
> +    g_assert(!qemu_dsa_init(path2, errp));
> +    qemu_dsa_start();
> +    do_single_task();
> +    qemu_dsa_cleanup();
> +}
> +
> +static int check_test_setup(void)
> +{
> +    const strList *path[2] = {path1, path2};
> +    for (int i = 0; i < sizeof(path) / sizeof(strList *); i++) {
> +        if (qemu_dsa_init(path[i], errp)) {
> +            return -1;
> +        }
> +        qemu_dsa_cleanup();
> +    }
> +    return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (check_test_setup() != 0) {
> +        /*
> +         * This test requires extra setup. The current
> +         * setup is not correct. Just skip this test
> +         * for now.
> +         */
> +        exit(0);

Usually the correct way to skip a test is calling:

  g_test_skip("DSA hardware not properly configured");
  return g_test_run();

Also let me point out that if we need special hardware to run these
tests that kind of defeats the purpose of unit testing. Most parts of
the code should be able to be tested with some mocking. Not asking that
you do this for now, but keep it in mind. We've seen with the
compression code that putting too much behind a CONFIG is prone to being
broken every release.

> +    }
> +
> +    if (num_devices > 1) {
> +        g_test_add_func("/dsa/multiple_engines", test_multiple_engines);
> +    }
> +
> +    g_test_add_func("/dsa/async/batch", test_batch_async);
> +    g_test_add_func("/dsa/async/various_buffer_sizes",
> +                    test_various_buffer_sizes_async);
> +    g_test_add_func("/dsa/async/null_buf", test_null_buf_async);
> +    g_test_add_func("/dsa/async/zero_len", test_zero_len_async);
> +    g_test_add_func("/dsa/async/oversized_batch", test_oversized_batch_async);
> +    g_test_add_func("/dsa/async/zero_count", test_zero_count_async);
> +    g_test_add_func("/dsa/async/single_zero", test_single_zero_async);
> +    g_test_add_func("/dsa/async/single_nonzero", test_single_nonzero_async);
> +    g_test_add_func("/dsa/async/null_task", test_null_task_async);
> +    g_test_add_func("/dsa/async/page_fault", test_page_fault);
> +
> +    g_test_add_func("/dsa/double_start_stop", test_double_start_stop);
> +    g_test_add_func("/dsa/is_running", test_is_running);
> +
> +    g_test_add_func("/dsa/configure_dsa_twice", test_configure_dsa_twice);
> +    g_test_add_func("/dsa/configure_dsa_bad_path", test_configure_dsa_bad_path);
> +    g_test_add_func("/dsa/cleanup_before_configure",
> +                    test_cleanup_before_configure);
> +    g_test_add_func("/dsa/configure_dsa_num_devices",
> +                    test_configure_dsa_num_devices);
> +    g_test_add_func("/dsa/cleanup_twice", test_cleanup_twice);
> +
> +    return g_test_run();
> +}


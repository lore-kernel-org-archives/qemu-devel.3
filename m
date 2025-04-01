Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C350EC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcL9-0008JX-Pp; Tue, 01 Apr 2025 10:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzcL8-0008Gw-Fg
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:11:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tzcL5-0003Dw-Kn
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:11:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D28E0211F3;
 Tue,  1 Apr 2025 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743516697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NPhgVfbtsbJJblVKd5NIqPEp1VIUo0vVyizGrAKs8c=;
 b=HzVhtBeuvbvpgiuyCJglc/xvsqZQSdCiIU1zZFjSs+v91h1J9p6xq6hm4m1fbCtKNfW8wk
 EmFUKl8L31+Twl9FGqOIXr0967uZgRhdjOv/tjMTQZlq0+Gdgd7Uo709E5p2Rh65FnZIrU
 ZhLbwLscGQayXS9cVUrg5EkHLKth7oc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743516697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NPhgVfbtsbJJblVKd5NIqPEp1VIUo0vVyizGrAKs8c=;
 b=kYFardxuwZCwbF3Xii6YGGI2B7Qzp/OKUZcW7vKRlhPGCWGmJuPKQARovma5+Cn++ch/3y
 YSEGRJn2CviuglBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IGPpjqux;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yo7dRewY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743516695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NPhgVfbtsbJJblVKd5NIqPEp1VIUo0vVyizGrAKs8c=;
 b=IGPpjqux81kwIx4NSzZxN8MyyOhMqVO6gDnvqFiWT1LBZpuSvGe71OUYuCrH11iV8BLApV
 DRlvrDLhKAol4NE8sHtr6Co4sGJMFMXnMMmIEcSj8JQXtU8r2SUmdBuHBK99xvVe4FqJMu
 D3ntCgQh1U7pbdXQbk2Fx3trub1nSAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743516695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NPhgVfbtsbJJblVKd5NIqPEp1VIUo0vVyizGrAKs8c=;
 b=yo7dRewY6oP4E2iulawYRJHWAfoG6Iy4LLML9cQxUh/ydHV+5Udz5r5R36EauuzYW6032j
 RyxbS+KXvVAwWnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AF0D138A5;
 Tue,  1 Apr 2025 14:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dq4TAhf062fPXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 01 Apr 2025 14:11:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nikita Shubin <nikita.shubin@maquefel.me>, qemu-devel@nongnu.org
Cc: Nikita Shubin <n.shubin@yadro.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: add qtests for STM32 DMA
In-Reply-To: <20250324100508.2176-4-nikita.shubin@maquefel.me>
References: <20250324100508.2176-1-nikita.shubin@maquefel.me>
 <20250324100508.2176-4-nikita.shubin@maquefel.me>
Date: Tue, 01 Apr 2025 11:11:32 -0300
Message-ID: <87jz84ezu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D28E0211F3
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, yadro.com:email, maquefel.me:email, suse.de:dkim,
 suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Nikita Shubin <nikita.shubin@maquefel.me> writes:

> From: Nikita Shubin <n.shubin@yadro.com>
>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  tests/qtest/meson.build      |   1 +
>  tests/qtest/stm32-dma-test.c | 415 +++++++++++++++++++++++++++++++++++
>  2 files changed, 416 insertions(+)
>  create mode 100644 tests/qtest/stm32-dma-test.c
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 5a8c1f102c..6c45692f9d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -240,6 +240,7 @@ qtests_arm = \
>    (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
>    (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_STM32F100_SOC') ? ['stm32-dma-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
>    (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
> diff --git a/tests/qtest/stm32-dma-test.c b/tests/qtest/stm32-dma-test.c
> new file mode 100644
> index 0000000000..74b81fa434
> --- /dev/null
> +++ b/tests/qtest/stm32-dma-test.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * QTest testcase for STM32 DMA engine.
> + *
> + * This includes STM32F1xxxx, STM32F2xxxx and GD32F30x
> + *
> + * Author: 2025 Nikita Shubin <n.shubin@yadro.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "libqtest-single.h"
> +#include "libqos/libqos.h"
> +
> +/* Offsets in stm32vldiscovery platform: */
> +#define DMA_BASE    0x40020000
> +#define SRAM_BASE   0x20000000
> +
> +/* Global interrupt flag */
> +#define DMA_ISR_GIF   BIT(0)
> +/* Full transfer finish */
> +#define DMA_ISR_TCIF  BIT(1)
> +/* Half transfer finish */
> +#define DMA_ISR_HTIF  BIT(2)
> +/* Transfer error */
> +#define DMA_ISR_TEIF  BIT(3)
> +
> +/* Used register/fields definitions */
> +#define DMA_CCR(idx)     (0x08 + 0x14 * idx)
> +#define DMA_CNDTR(idx)   (0x0C + 0x14 * idx)
> +#define DMA_CPAR(idx)    (0x10 + 0x14 * idx)
> +#define DMA_CMAR(idx)    (0x14 + 0x14 * idx)
> +
> +#define DMA_MAX_CHAN    7
> +
> +/* Register offsets for a dma chan0 within a dma block. */
> +#define DMA_CHAN(_idx, _irq)  \
> +    { \
> +        .ccr = DMA_CCR(_idx), \
> +        .cndrt = DMA_CNDTR(_idx), \
> +        .cpar = DMA_CPAR(_idx), \
> +        .cmar = DMA_CMAR(_idx), \
> +        .irq_line = _irq,\
> +    }
> +
> +typedef struct DMAChan {
> +    uint32_t ccr;
> +    uint32_t cndrt;
> +    uint32_t cpar;
> +    uint32_t cmar;
> +    uint8_t irq_line;
> +} DMAChan;
> +
> +const DMAChan dma_chans[] = {
> +    DMA_CHAN(0, 11),
> +    DMA_CHAN(1, 12),
> +    DMA_CHAN(2, 12),
> +    DMA_CHAN(3, 13),
> +    DMA_CHAN(4, 14),
> +    DMA_CHAN(5, 16),
> +    DMA_CHAN(6, 17),
> +};
> +
> +/* Register offsets for a dma within a dma block. */
> +typedef struct DMA {
> +    uint32_t base_addr;
> +    uint32_t isr;
> +    uint32_t ofcr;
> +} DMA;
> +
> +const DMA dma = {
> +    .base_addr = DMA_BASE,
> +    .isr = 0x00,
> +    .ofcr = 0x04,
> +};
> +
> +typedef struct TestData {
> +    QTestState *qts;
> +    const DMA *dma;
> +    const DMAChan *chans;
> +} TestData;
> +
> +#define NVIC_ISER 0xE000E100
> +#define NVIC_ISPR 0xE000E200
> +#define NVIC_ICPR 0xE000E280
> +
> +static void enable_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ISER, 1 << n);
> +}
> +
> +static void unpend_nvic_irq(unsigned int n)
> +{
> +    writel(NVIC_ICPR, 1 << n);
> +}
> +
> +static bool check_nvic_pending(unsigned int n)
> +{
> +    return readl(NVIC_ISPR) & (1 << n);
> +}
> +
> +static uint32_t dma_read(const TestData *td, uint32_t offset)
> +{
> +    return qtest_readl(td->qts, td->dma->base_addr + offset);
> +}
> +
> +static void dma_write(const TestData *td, uint32_t offset, uint32_t value)
> +{
> +    qtest_writel(td->qts, td->dma->base_addr + offset, value);
> +}
> +
> +static void dma_write_ofcr(const TestData *td, uint32_t value)
> +{
> +    return dma_write(td, td->dma->ofcr, value);
> +}
> +
> +static uint32_t dma_read_isr(const TestData *td)
> +{
> +    return dma_read(td, td->dma->isr);
> +}
> +
> +static void dma_write_ccr(const TestData *td, uint8_t idx, uint32_t value)
> +{
> +    dma_write(td, td->chans[idx].ccr, value);
> +}
> +
> +static uint32_t dma_read_ccr(const TestData *td, uint8_t idx)
> +{
> +    return dma_read(td, td->chans[idx].ccr);
> +}
> +
> +static void dma_write_cndrt(const TestData *td, uint8_t idx, uint32_t value)
> +{
> +    dma_write(td, td->chans[idx].cndrt, value);
> +}
> +
> +static void dma_write_cpar(const TestData *td, uint8_t idx, uint32_t value)
> +{
> +    dma_write(td, td->chans[idx].cpar, value);
> +}
> +
> +static void dma_write_cmar(const TestData *td, uint8_t idx, uint32_t value)
> +{
> +    dma_write(td, td->chans[idx].cmar, value);
> +}
> +
> +static void test_m2m(gconstpointer test_data)
> +{
> +    const TestData *td = test_data;
> +    QTestState *s = td->qts;
> +    const uint32_t patt_len = 0xff;
> +    char *pattern_check = g_malloc(patt_len);
> +    char *pattern = g_malloc(patt_len);

These^ two should be g_autofree.

> +    uint8_t idx = 0;
> +    uint32_t val;
> +
> +    enable_nvic_irq(td->chans[idx].irq_line);
> +    qtest_irq_intercept_in(global_qtest, "/machine/soc/dma[0]");
> +
> +    /* write addr */
> +    dma_write_cpar(td, idx, SRAM_BASE);
> +    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
> +
> +    /* enable increment and M2M */
> +    val = dma_read_ccr(td, idx);
> +    val |= BIT(1); /* TCIE */
> +    val |= BIT(6); /* PINC */
> +    val |= BIT(7); /* MINC */
> +    val |= BIT(14); /* M2M */
> +    dma_write_ccr(td, idx, val);
> +
> +    generate_pattern(pattern, patt_len, patt_len);
> +    qtest_memwrite(s, SRAM_BASE, pattern, patt_len);
> +
> +    dma_write_cndrt(td, idx, patt_len);
> +
> +    val |= BIT(0); /* enable channel */
> +    dma_write_ccr(td, idx, val);
> +
> +    qtest_memread(s, SRAM_BASE + patt_len, pattern_check, patt_len);
> +
> +    g_assert(memcmp(pattern, pattern_check, patt_len) == 0);
> +
> +    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
> +}
> +
> +typedef struct width_pattern {
> +    uint32_t src;
> +    uint8_t swidth;
> +    uint32_t dst;
> +    uint8_t dwidth;
> +} width_pattern;
> +
> +static void test_width(gconstpointer test_data)
> +{
> +    const width_pattern patterns[] = {
> +        { 0xb0,       1, 0xb0,       1 },
> +        { 0xb0,       1, 0x00b0,     2 },
> +        { 0xb0,       1, 0x000000b0, 4 },
> +        { 0xb1b0,     2, 0xb0,       1 },
> +        { 0xb1b0,     2, 0xb1b0,     2 },
> +        { 0xb1b0,     2, 0x0000b1b0, 4 },
> +        { 0xb3b2b1b0, 4, 0xb0,       1 },
> +        { 0xb3b2b1b0, 4, 0xb1b0,     2 },
> +        { 0xb3b2b1b0, 4, 0xb3b2b1b0, 4 },
> +    };
> +
> +    const TestData *td = test_data;
> +    QTestState *s = td->qts;
> +    const uint32_t patt = 0xffffffff;
> +    const uint32_t patt_len = 4;
> +    uint32_t dst;
> +    uint8_t idx = 0;
> +    uint32_t val;
> +
> +    qmp("{'execute':'system_reset' }");

These calls to qmp() all leak the response dict. You need to catch the
return value and unref.

    QDict *response;

    response = qmp("{'execute':'system_reset' }");
    qobject_unref(response);

> +
> +    /* write addr */
> +    dma_write_cpar(td, idx, SRAM_BASE);
> +    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
> +
> +    /* enable increment and M2M */
> +    val = dma_read_ccr(td, idx);
> +    val |= BIT(6); /* PINC */
> +    val |= BIT(7); /* MINC */
> +    val |= BIT(14); /* M2M */
> +    dma_write_ccr(td, idx, val);
> +
> +    for (int i = 0; i < ARRAY_SIZE(patterns); i++) {
> +        /* fill destination and source with pattern */
> +        qtest_memwrite(s, SRAM_BASE, &patt, patt_len);
> +        qtest_memwrite(s, SRAM_BASE + patt_len, &patt, patt_len);
> +
> +        qtest_memwrite(s, SRAM_BASE, &patterns[i].src, patterns[i].swidth);
> +
> +        dma_write_cndrt(td, idx, 1);
> +        val |= BIT(0); /* enable channel */
> +        val = deposit32(val, 8, 2, patterns[i].swidth >> 1);
> +        val = deposit32(val, 10, 2, patterns[i].dwidth >> 1);
> +        dma_write_ccr(td, idx, val);
> +
> +        qtest_memread(s, SRAM_BASE + patt_len, &dst, patterns[i].dwidth);
> +
> +        g_assert(memcmp(&dst, &patterns[i].dst, patterns[i].dwidth) == 0);
> +
> +        /* disable chan */
> +        val &= ~BIT(0);
> +        dma_write_ccr(td, idx, val);
> +    }
> +}
> +
> +static void dma_set_irq(unsigned int idx, int num, int level)
> +{
> +    g_autofree char *name = g_strdup_printf("/machine/soc/dma[%u]",
> +                                            idx);
> +    qtest_set_irq_in(global_qtest, name, NULL, num, level);
> +}
> +
> +static void test_triggers(gconstpointer test_data)
> +{
> +    const TestData *td = test_data;
> +    QTestState *s = td->qts;
> +    const uint32_t patt = 0xffffffff;
> +    const uint32_t patt_len = 4;
> +    uint32_t dst;
> +    uint32_t val;
> +
> +    qmp("{'execute':'system_reset' }");
> +
> +    for (int i = 0; i < ARRAY_SIZE(dma_chans); i++) {
> +        qtest_memset(s, SRAM_BASE, 0, patt_len * 2);
> +        qtest_memwrite(s, SRAM_BASE, &patt, patt_len);
> +
> +        /* write addr */
> +        dma_write_cpar(td, i, SRAM_BASE);
> +        dma_write_cmar(td, i, SRAM_BASE + patt_len);
> +
> +        val = dma_read_ccr(td, i);
> +
> +        dma_write_cndrt(td, i, 1);
> +        val |= BIT(0); /* enable channel */
> +        val = deposit32(val, 8, 2, patt_len >> 1);
> +        val = deposit32(val, 10, 2, patt_len >> 1);
> +        dma_write_ccr(td, i, val);
> +
> +        dma_set_irq(0, i, 1);
> +
> +        qtest_memread(s, SRAM_BASE + patt_len, &dst, patt_len);
> +
> +        g_assert(memcmp(&dst, &patt, patt_len) == 0);
> +
> +        /* disable chan */
> +        val &= ~BIT(0);
> +        dma_write_ccr(td, i, val);
> +    }
> +}
> +
> +static void test_interrupts(gconstpointer test_data)
> +{
> +    const TestData *td = test_data;
> +    const uint32_t patt_len = 1024;
> +    uint8_t idx = 0;
> +    uint32_t val;
> +
> +    qmp("{'execute':'system_reset' }");
> +
> +    enable_nvic_irq(td->chans[idx].irq_line);
> +
> +    /* write addr */
> +    dma_write_cpar(td, idx, SRAM_BASE);
> +    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
> +
> +    /* write counter */
> +    dma_write_cndrt(td, idx, 2);
> +
> +    /* enable increment and M2M */
> +    val = dma_read_ccr(td, idx);
> +    val |= BIT(0); /* EN */
> +    val |= BIT(1); /* TCIE */
> +    val |= BIT(2); /* HTIE */
> +    val |= BIT(3); /* TEIE */
> +    val |= BIT(6); /* PINC */
> +    val |= BIT(7); /* MINC */
> +    dma_write_ccr(td, idx, val);
> +
> +    /* Half-transfer */
> +    dma_set_irq(0, idx, 1);
> +    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
> +    val = dma_read_isr(td);
> +
> +    g_assert_true(val & DMA_ISR_GIF);
> +    g_assert_true(val & DMA_ISR_HTIF);
> +    unpend_nvic_irq(td->chans[idx].irq_line);
> +
> +    dma_write_ofcr(td, 0xffffffff);
> +    val = dma_read_isr(td);
> +    g_assert_false(val & DMA_ISR_GIF);
> +    g_assert_false(val & DMA_ISR_HTIF);
> +
> +    /* Full-transfer */
> +    dma_set_irq(0, idx, 1);
> +    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
> +    val = dma_read_isr(td);
> +
> +    g_assert_true(val & DMA_ISR_GIF);
> +    g_assert_true(val & DMA_ISR_HTIF);
> +    g_assert_true(val & DMA_ISR_TCIF);
> +    unpend_nvic_irq(td->chans[idx].irq_line);
> +
> +    dma_write_ofcr(td, 0xffffffff);
> +    val = dma_read_isr(td);
> +    g_assert_false(val & DMA_ISR_GIF);
> +    g_assert_false(val & DMA_ISR_HTIF);
> +    g_assert_false(val & DMA_ISR_TCIF);
> +
> +    /* Error-on-transfer */
> +    val = dma_read_ccr(td, idx);
> +    val &= ~BIT(0);
> +    dma_write_ccr(td, idx, val);
> +
> +    dma_write_cndrt(td, idx, 1);
> +    dma_write_cpar(td, idx, 0xffffffff);
> +
> +    val |= BIT(0);
> +    dma_write_ccr(td, idx, val);
> +
> +    dma_set_irq(0, idx, 1);
> +    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
> +    val = dma_read_isr(td);
> +
> +    g_assert_true(val & DMA_ISR_GIF);
> +    g_assert_true(val & DMA_ISR_TEIF);
> +    unpend_nvic_irq(td->chans[idx].irq_line);
> +
> +    dma_write_ofcr(td, 0xffffffff);
> +    val = dma_read_isr(td);
> +    g_assert_false(val & DMA_ISR_GIF);
> +    g_assert_false(val & DMA_ISR_TEIF);
> +}
> +
> +static void stm32_add_test(const char *name, const TestData *td,
> +                           GTestDataFunc fn)
> +{
> +    g_autofree char *full_name = g_strdup_printf(
> +        "stm32_dma/%s", name);
> +    qtest_add_data_func(full_name, td, fn);
> +}
> +
> +/* Convenience macro for adding a test with a predictable function name. */
> +#define add_test(name, td) stm32_add_test(#name, td, test_##name)
> +
> +int main(int argc, char **argv)
> +{
> +    TestData testdata;
> +    QTestState *s;
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    s = qtest_start("-machine stm32vldiscovery");
> +    g_test_set_nonfatal_assertions();
> +
> +    TestData *td = &testdata;
> +    td->qts = s;
> +    td->dma = &dma;
> +    td->chans = dma_chans;
> +    add_test(m2m, td);
> +    add_test(width, td);
> +    add_test(triggers, td);
> +    add_test(interrupts, td);
> +
> +    ret = g_test_run();
> +    qtest_end();
> +
> +    return ret;
> +}


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A9606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMrAhLXu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNyPQ-00052L-MB; Mon, 02 Nov 2026 15:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xNyP4-0004yN-MX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:13:15 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xNyOz-0006I2-S1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 15:13:14 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-845f3fa7f38so1493253a34.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 12:13:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793650387; cv=none;
 d=google.com; s=arc-20260327;
 b=nFHqKHHDwLOO393yVhsbTXtiVzY/AMgzLCeeyjiJ/mOewC7iV3LvplOy2KAGHa1NFv
 TeXHsF+gSPOG4AT18qjU6B5EkQBFO3jvdYhPXIxD1BM42Fj59uyerQ58jDeBLrHfhACl
 vTVVcOGiPX2r6K6Rq7Cgp+Sf2+wCQfTFYkv8+lwLGCaWwueN+fXzE0T6OjYQVJJhY1kO
 m5T8FbEinaTLpg/kJDkM9P60Q/K8lmSD4J/5bvPiknYk60o3VHja+w0lky+7Lbz9oG5F
 EHtjkJz5zaJfVmn3RehX76IeihdB3tMJURBRpylYM7P8fbSexV3CVcvAxeWThxqfEfX4
 TMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=QHPUi7u2lynLaHItuOv1boD9Pepmtw5JqY5HVTGfCoo=;
 fh=++tcxxblF3bcWDYSSk4d65KFQlgCUUSinRYT3x9Kb/k=;
 b=q3V+Lt64LmEfsm82/wwzMNEuDCAaRJhuR633vponu7IznJOFojCzYcuTeWlKd44htr
 ruZmVfw5F8rJDaAIurVdruG25an0c+I9RCUGPTUUtp37S/OReiTXE2wMMyGXQSizC7T2
 h3KX/kBeFyCuQ0q4/wjG2f0dL59GBwBzx7mKWCLnOGXuTXuHyQFTP4OpBXt6YKnRkZYR
 gsOHusZIsEdJCFauZfnLTJa7sEXFYQLl3hXcYAm/88tBI/o374eF6Qzf4HGrhT15QJYk
 NGRiHN7v1MVRYVOXE/uIiLTXEI0U6Uc/7rLP89VnuiLsTRF1qIDEcGgpiv2IJb4wnxyy
 K0CA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793650387; x=1794255187; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QHPUi7u2lynLaHItuOv1boD9Pepmtw5JqY5HVTGfCoo=;
 b=XMrAhLXuLpms1gcwGZVpwTwJdgf1XzpIb0xqpgVXcBq8Zt+x2yBP2zz751ZabODPJK
 QJU/cB9sX6j+49gzWDQDpjBfUIqRhsXoRz1fE2a0uvqThQAY3IiAugNmh0EY808NvX5S
 MjZrg7sAQxlh/Jatpgge589zPnDwmIg5yyNwbOq4vpFymRibhc3GYWVspt59K+Ah/lQy
 +0zW4UzGGg87CK24co2yHg0nab+9yJxKbQs8VB0BB+E8nCeXu6BVXZI409kydvaZqaio
 C1B5j/EIo5h13RECb9/59EePfHMASIMfNG68kd9uswUZ/sUX8n6bOYgq0OmrJCUCe/Ln
 b2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793650387; x=1794255187;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHPUi7u2lynLaHItuOv1boD9Pepmtw5JqY5HVTGfCoo=;
 b=m6Kzx6U8ZH8TIxqFXtGBZcrN50ii3UGdhhRoGhkTUwXmTPFU183iCaFKaUKQK0I8sg
 Px0gBZ+SGidAok4s6iJCmnB2Q33wAP/8jRumDtoreiiAC2XsACUeh3Lt0l8LircTRd/q
 A8SUpUwmilyUmFLA7nUFMAwx5e56NxnyAU7rjSri25ObWnUGgYhFb5FDlIi0E3Slj9gB
 jdf0oCkXT24lcWFbl8wj8bMH7dT2eu/DuAV6vFte650sQQ4nxT18eJL9U/Zm/GT/YOda
 Am4hT1GWhnfsc5eyyep1FsIO4s/DKu6kSbyhQpvTRywXhU7TnFZRyGucOsbXlKWOkDnp
 XSKg==
X-Gm-Message-State: AFq9FYJ/FsxXByid1Zk9SPFdUNSgBzvmP1E1xJEsSSxIc/Ci9f+luJs1
 fliMNt8LRKtcanK1DkGBNWk/uprKvvnvf+iUTyE04aJQ41V4zq/Yczgwndm3HmmHpf3jwpeGrQI
 geCF4r9tyu6zWIeHRXn4QNCG+Cr76FiY=
X-Gm-Gg: AYBFou1g3EvEtO+yMkckwA+KOxnGI+gLjUmXu/ErvzNfrY/fV5gd7OItcG0eSBWtVta
 tMkBTuigUGBCv3zLjgz6Xy588TFLrshO/nm8fCwp6Ps1/LgALjMriNoH+O7xKJ3KVKz7+6qoyBy
 yYvg/EbZFO99F24e3hfxThQp/cWafnr6cnxhcfsW5fnAT8DSFCzqPy8DOs7fuhJ7BiU56jBXBES
 PSYwxi8ZEkh/Qgf4MUpicSs88ZkcmiwczMV6gosIqv0IuJNmIFAAj2hfKfWH+/nxKQ4WJlpi06I
 QlZaBQvdCvulzNem5OwtNUlOsfgYKCxAMtAOuPFbxwGPs0bJuCXk8ZnWx5T2Karc0prP/68NxY9
 NFX/3vNFuE1Zr0t8Sg5xfVPeQ0F/YkZgNWlLm8ORr45HxB7En3xM1c+fEKb9ljSsv/ZWMNNJs21
 A0WzG8TXFTz63hm5VwWyIi4A==
X-Received: by 2002:a05:6808:1b2a:b0:4f4:3088:e536 with SMTP id
 5614622812f47-5640dc29217mr6696366b6e.16.1793650387121; Mon, 02 Nov 2026
 12:13:07 -0800 (PST)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Nov 2026 15:13:04 -0500
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Nov 2026 15:13:04 -0500
From: Marcelo Manzo <marcelomanzo@gmail.com>
In-Reply-To: <0bd9bd85fd70c12f7e9ad77ad92a0ac1a778a29e.1793613972.git.lorandmarton.dev@gmail.com>
References: <0bd9bd85fd70c12f7e9ad77ad92a0ac1a778a29e.1793613972.git.lorandmarton.dev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Nov 2026 15:13:04 -0500
X-Gm-Features: AclHuK9CQK3dQOlkd3iU8FR5B-3YfdfIP8iYoIORfSehVgHpEIVhm-gDFEZuWi4
Message-ID: <CAGaQodLmJ7RTUOrA=VV32t10k36z0mmxeeGCqA4m6T6xF6-wYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/bcm2838_genet: wrap the TX consumer index at
 16 bits
To: lorandmarton.dev@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com, 
 qemu-arm@nongnu.org, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jasowangio@gmail.com, serg.oker@gmail.com
Content-Type: multipart/alternative; boundary="0000000000002cfc01065f50c695"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=marcelomanzo@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002cfc01065f50c695
Content-Type: text/plain; charset="UTF-8"

Hi Lorand,

Thanks for the fix. I reproduced the hang on our v6 series: with a stock
Raspberry Pi OS Trixie guest, a 400 MB upload through GENET dies after
roughly 47 MB (about 65k TX descriptors), and the guest stops responding.
With this patch applied, the same 400 MB upload completes in about 13
seconds, and the guest stays healthy afterwards. The loop was inherited
from the original code and our earlier, lighter transfer tests never
reached the 16-bit wrap, so thank you for catching it.

The change itself looks correct to me: masking the consumer index with
R_GENET_DMA_CONS_INDEX_INDEX_MASK keeps it consistent with the 16-bit
producer index.

Reviewed-by: Marcelo Manzo <marcelomanzo@gmail.com>
Tested-by: Marcelo Manzo <marcelomanzo@gmail.com>

Marcelo

On Mon, Nov 02, 2026 05:47 AM, Lorand Marton <lorandmarton.dev@gmail.com>
wrote:

> The producer and consumer indexes of a GENET DMA ring are 16-bit
> counters (Linux bcmgenet masks them with DMA_P_INDEX_MASK and
> DMA_C_INDEX_MASK). bcm2838_genet_tx() counted the consumer index up in
> a uint32_t and compared it with the 16-bit producer index, so the first
> transmit that crossed the wrap (consumer 0xfffe, producer 0x0001) never
> ended the loop: the device sent the ring's descriptors forever with the
> BQL held, and the guest and the monitor hung. A guest sending a
> sustained stream hung after about 65k descriptors on one ring.
>
> Wrap the index, and test a transmit across the wrap.
>
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---
>  hw/net/bcm2838_genet.c           |   4 +-
>  tests/qtest/bcm2838-genet-test.c | 101 +++++++++++++++++++++++++++++++
>  tests/qtest/meson.build          |   2 +
>  3 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/bcm2838-genet-test.c
>
> diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
> index 53bba99b38..557a8a9636 100644
> --- a/hw/net/bcm2838_genet.c
> +++ b/hw/net/bcm2838_genet.c
> @@ -521,7 +521,9 @@ static uint64_t bcm2838_genet_tx(BCM2838GenetState
> *s, unsigned int ring_index,
>          }
>
>          num_descs++;
> -        cons_index_fld++;
> +        /* The indexes count modulo 2^16 */
> +        cons_index_fld = (cons_index_fld + 1)
> +                         & R_GENET_DMA_CONS_INDEX_INDEX_MASK;
>          s->regs.tdma.descs[desc_index].length_status =
>              FIELD_DP32(s->regs.tdma.descs[desc_index].length_status,
>                         GENET_RDMA_LENGTH_STATUS, OWN, 1);
> diff --git a/tests/qtest/bcm2838-genet-test.c
> b/tests/qtest/bcm2838-genet-test.c
> new file mode 100644
> index 0000000000..393abd7da2
> --- /dev/null
> +++ b/tests/qtest/bcm2838-genet-test.c
> @@ -0,0 +1,101 @@
> +/*
> + * QTest testcase for the BCM2838 GENET DMA rings
> + *
> + * Frames go out over a socket netdev. The producer and consumer indexes
> + * of a ring count modulo 2^16.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/bswap.h"
> +#include "libqtest.h"
> +
> +#define GENET_BASE          0xfd580000
> +
> +#define RING_START_ADDR     0x14
> +#define RING_END_ADDR       0x1c
> +
> +#define TDMA_DESC(i)        (0x4000 + (i) * 12)
> +#define TDMA_RING(r)        (0x4c00 + (r) * 0x40)
> +#define TRING_READ_PTR      0x00
> +#define TRING_CONS_INDEX    0x08
> +#define TRING_PROD_INDEX    0x0c
> +#define TDMA_RING_CFG       0x5040
> +#define TDMA_CTRL           0x5044
> +#define TSB_LEN             64      /* transmit status block */
> +
> +#define DESCS_PER_RING      4
> +#define BUF_SIZE            2048
> +#define BUF_BASE            0x100000
> +#define FRAME_LEN           60
> +
> +static void genet_writel(QTestState *qts, uint32_t off, uint32_t val)
> +{
> +    qtest_writel(qts, GENET_BASE + off, val);
> +}
> +
> +static uint32_t genet_readl(QTestState *qts, uint32_t off)
> +{
> +    return qtest_readl(qts, GENET_BASE + off);
> +}
> +
> +/* Transmit across the wrap of the 16-bit consumer index */
> +static void test_tx_index_wrap(void)
> +{
> +    const unsigned r = 0, n = 3;
> +    const uint16_t first = 0xfffe;
> +    uint8_t frame[FRAME_LEN] = { 0 };
> +    uint8_t pkt[4 + FRAME_LEN];
> +    int sv[2];
> +    QTestState *qts;
> +
> +    g_assert_cmpint(socketpair(PF_UNIX, SOCK_STREAM, 0, sv), ==, 0);
> +    qts = qtest_initf("-M raspi4b -nic socket,fd=%d,model=bcm2838-genet",
> +                      sv[1]);
> +    close(sv[1]);
> +
> +    memset(frame, 0xff, 6);
> +    stw_be_p(frame + 12, 0x88b5);
> +    for (unsigned i = 0; i < n; i++) {
> +        frame[14] = i;
> +        qtest_memset(qts, BUF_BASE + i * BUF_SIZE, 0, TSB_LEN);
> +        qtest_memwrite(qts, BUF_BASE + i * BUF_SIZE + TSB_LEN, frame,
> +                       sizeof(frame));
> +        /* SOP, EOP, buffer length */
> +        genet_writel(qts, TDMA_DESC(i), BIT(13) | BIT(14) |
> +                     (TSB_LEN + FRAME_LEN) << 16);
> +        genet_writel(qts, TDMA_DESC(i) + 4, BUF_BASE + i * BUF_SIZE);
> +        genet_writel(qts, TDMA_DESC(i) + 8, 0);
> +    }
> +    genet_writel(qts, TDMA_RING(r) + RING_START_ADDR, 0);
> +    genet_writel(qts, TDMA_RING(r) + RING_END_ADDR, DESCS_PER_RING * 3 -
> 1);
> +    genet_writel(qts, TDMA_RING(r) + TRING_READ_PTR, 0);
> +    genet_writel(qts, TDMA_RING(r) + TRING_CONS_INDEX, first);
> +    genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX, first);
> +    genet_writel(qts, TDMA_RING_CFG, BIT(r));
> +    genet_writel(qts, TDMA_CTRL, 1 | BIT(1 + r));
> +
> +    genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX,
> +                 (uint16_t)(first + n));
> +    g_assert_cmphex(genet_readl(qts, TDMA_RING(r) + TRING_CONS_INDEX) &
> +                    0xffff, ==, (uint16_t)(first + n));
> +
> +    for (unsigned i = 0; i < n; i++) {
> +        g_assert_cmpint(recv(sv[0], pkt, sizeof(pkt), MSG_WAITALL), ==,
> +                        sizeof(pkt));
> +        g_assert_cmpuint(ldl_be_p(pkt), ==, FRAME_LEN);
> +        g_assert_cmpuint(pkt[4 + 14], ==, i);
> +    }
> +
> +    qtest_quit(qts);
> +    close(sv[0]);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("/bcm2838-genet/tx-index-wrap", test_tx_index_wrap);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 46d4fc1d2b..36af0b267a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -284,6 +284,8 @@ qtests_aarch64 = \
>    (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ?
> ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ?
> ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test',
> 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
> +  (config_all_devices.has_key('CONFIG_RASPI') and host_os != 'windows' ?
> +    ['bcm2838-genet-test'] : []) + \
>    (config_all_accel.has_key('CONFIG_TCG') and
>                 \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ?
> ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 :
> []) + \
> --
> 2.56.0
>
>

--0000000000002cfc01065f50c695
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Lorand,<br><br>Thanks for the fix. I repro=
duced the hang on our v6 series: with a stock Raspberry Pi OS Trixie guest,=
 a 400 MB upload through GENET dies after roughly 47 MB (about 65k TX descr=
iptors), and the guest stops responding. With this patch applied, the same =
400 MB upload completes in about 13 seconds, and the guest stays healthy af=
terwards. The loop was inherited from the original code and our earlier, li=
ghter transfer tests never reached the 16-bit wrap, so thank you for catchi=
ng it.<br><br>The change itself looks correct to me: masking the consumer i=
ndex with R_GENET_DMA_CONS_INDEX_INDEX_MASK keeps it consistent with the 16=
-bit producer index.<br><br>Reviewed-by: Marcelo Manzo &lt;<a href=3D"mailt=
o:marcelomanzo@gmail.com">marcelomanzo@gmail.com</a>&gt;<br>Tested-by: Marc=
elo Manzo &lt;<a href=3D"mailto:marcelomanzo@gmail.com">marcelomanzo@gmail.=
com</a>&gt;<br><br>Marcelo<br></div></body></html><br><div class=3D"gmail_e=
xtra"><div>On Mon, Nov 02, 2026 05:47 AM, Lorand Marton &lt;<a href=3D"mail=
to:lorandmarton.dev@gmail.com">lorandmarton.dev@gmail.com</a>&gt; wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">The producer and consumer indexes of a GENE=
T DMA ring are 16-bit<br>
counters (Linux bcmgenet masks them with DMA_P_INDEX_MASK and<br>
DMA_C_INDEX_MASK). bcm2838_genet_tx() counted the consumer index up in<br>
a uint32_t and compared it with the 16-bit producer index, so the first<br>
transmit that crossed the wrap (consumer 0xfffe, producer 0x0001) never<br>
ended the loop: the device sent the ring&#39;s descriptors forever with the=
<br>
BQL held, and the guest and the monitor hung. A guest sending a<br>
sustained stream hung after about 65k descriptors on one ring.<br>
<br>
Wrap the index, and test a transmit across the wrap.<br>
<br>
Signed-off-by: Lorand Marton &lt;<a href=3D"mailto:lorandmarton.dev@gmail.c=
om" target=3D"_blank">lorandmarton.dev@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/net/bcm2838_genet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A04 +-<br>
=C2=A0tests/qtest/bcm2838-genet-tes<wbr>t.c | 101 +++++++++++++++++++++++++=
+++++<wbr>+<br>
=C2=A0tests/qtest/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A02 +<br>
=C2=A03 files changed, 106 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 tests/qtest/bcm2838-genet-test<wbr>.c<br>
<br>
diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c<br>
index 53bba99b38..557a8a9636 100644<br>
--- a/hw/net/bcm2838_genet.c<br>
+++ b/hw/net/bcm2838_genet.c<br>
@@ -521,7 +521,9 @@ static uint64_t bcm2838_genet_tx(BCM2838GenetS<wbr>tate=
 *s, unsigned int ring_index,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_descs++;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cons_index_fld++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The indexes count modulo 2^16 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cons_index_fld =3D (cons_index_fld + 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp; R_GENET_DMA_CONS_INDEX_INDEX_M<wbr>ASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs.tdma.descs[desc_<wbr>index].le=
ngth_status =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FIELD_DP32(s-&gt;regs.tdma.=
<wbr>descs[desc_index].length_<wbr>status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 GENET_RDMA_LENGTH_STATUS, OWN, 1);<br>
diff --git a/tests/qtest/bcm2838-genet-te<wbr>st.c b/tests/qtest/bcm2838-ge=
net-te<wbr>st.c<br>
new file mode 100644<br>
index 0000000000..393abd7da2<br>
--- /dev/null<br>
+++ b/tests/qtest/bcm2838-genet-te<wbr>st.c<br>
@@ -0,0 +1,101 @@<br>
+/*<br>
+ * QTest testcase for the BCM2838 GENET DMA rings<br>
+ *<br>
+ * Frames go out over a socket netdev. The producer and consumer indexes<b=
r>
+ * of a ring count modulo 2^16.<br>
+ *<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/bitops.h&quot;<br>
+#include &quot;qemu/bswap.h&quot;<br>
+#include &quot;libqtest.h&quot;<br>
+<br>
+#define GENET_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xfd580000<br>
+<br>
+#define RING_START_ADDR=C2=A0 =C2=A0 =C2=A00x14<br>
+#define RING_END_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A00x1c<br>
+<br>
+#define TDMA_DESC(i)=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x4000 + (i) * 12)<br>
+#define TDMA_RING(r)=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x4c00 + (r) * 0x40)<br>
+#define TRING_READ_PTR=C2=A0 =C2=A0 =C2=A0 0x00<br>
+#define TRING_CONS_INDEX=C2=A0 =C2=A0 0x08<br>
+#define TRING_PROD_INDEX=C2=A0 =C2=A0 0x0c<br>
+#define TDMA_RING_CFG=C2=A0 =C2=A0 =C2=A0 =C2=A00x5040<br>
+#define TDMA_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x5044<br>
+#define TSB_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =
=C2=A0 =C2=A0 /* transmit status block */<br>
+<br>
+#define DESCS_PER_RING=C2=A0 =C2=A0 =C2=A0 4<br>
+#define BUF_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2048<br>
+#define BUF_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x100000<br>
+#define FRAME_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060<br>
+<br>
+static void genet_writel(QTestState *qts, uint32_t off, uint32_t val)<br>
+{<br>
+=C2=A0 =C2=A0 qtest_writel(qts, GENET_BASE + off, val);<br>
+}<br>
+<br>
+static uint32_t genet_readl(QTestState *qts, uint32_t off)<br>
+{<br>
+=C2=A0 =C2=A0 return qtest_readl(qts, GENET_BASE + off);<br>
+}<br>
+<br>
+/* Transmit across the wrap of the 16-bit consumer index */<br>
+static void test_tx_index_wrap(void)<br>
+{<br>
+=C2=A0 =C2=A0 const unsigned r =3D 0, n =3D 3;<br>
+=C2=A0 =C2=A0 const uint16_t first =3D 0xfffe;<br>
+=C2=A0 =C2=A0 uint8_t frame[FRAME_LEN] =3D { 0 };<br>
+=C2=A0 =C2=A0 uint8_t pkt[4 + FRAME_LEN];<br>
+=C2=A0 =C2=A0 int sv[2];<br>
+=C2=A0 =C2=A0 QTestState *qts;<br>
+<br>
+=C2=A0 =C2=A0 g_assert_cmpint(socketpair(PF_<wbr>UNIX, SOCK_STREAM, 0, sv)=
, =3D=3D, 0);<br>
+=C2=A0 =C2=A0 qts =3D qtest_initf(&quot;-M raspi4b -nic socket,fd=3D%d,mod=
el=3Dbcm2838-gen<wbr>et&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sv[1]);<br>
+=C2=A0 =C2=A0 close(sv[1]);<br>
+<br>
+=C2=A0 =C2=A0 memset(frame, 0xff, 6);<br>
+=C2=A0 =C2=A0 stw_be_p(frame + 12, 0x88b5);<br>
+=C2=A0 =C2=A0 for (unsigned i =3D 0; i &lt; n; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 frame[14] =3D i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_memset(qts, BUF_BASE + i * BUF_SIZE, 0, =
TSB_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_memwrite(qts, BUF_BASE + i * BUF_SIZE + =
TSB_LEN, frame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sizeof(frame));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* SOP, EOP, buffer length */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 genet_writel(qts, TDMA_DESC(i), BIT(13) | BIT(=
14) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(TSB_LEN + FRAME_LEN) &lt;&lt; 16);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 genet_writel(qts, TDMA_DESC(i) + 4, BUF_BASE +=
 i * BUF_SIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 genet_writel(qts, TDMA_DESC(i) + 8, 0);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + RING_START_ADDR, 0);<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + RING_END_ADDR, DESCS_PER_RI=
NG * 3 - 1);<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + TRING_READ_PTR, 0);<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + TRING_CONS_INDEX, first);<b=
r>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX, first);<b=
r>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING_CFG, BIT(r));<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_CTRL, 1 | BIT(1 + r));<br>
+<br>
+=C2=A0 =C2=A0 genet_writel(qts, TDMA_RING(r) + TRING_PROD_INDEX,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint16_t)(f=
irst + n));<br>
+=C2=A0 =C2=A0 g_assert_cmphex(genet_readl(qt<wbr>s, TDMA_RING(r) + TRING_C=
ONS_INDEX) &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff=
ff, =3D=3D, (uint16_t)(first + n));<br>
+<br>
+=C2=A0 =C2=A0 for (unsigned i =3D 0; i &lt; n; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(recv(sv[0], pkt, sizeof(pkt), =
MSG_WAITALL), =3D=3D,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(pkt));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpuint(ldl_be_p(pkt)<wbr>, =3D=3D, F=
RAME_LEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpuint(pkt[4 + 14], =3D=3D, i);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qtest_quit(qts);<br>
+=C2=A0 =C2=A0 close(sv[0]);<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
+=C2=A0 =C2=A0 qtest_add_func(&quot;/bcm2838-genet<wbr>/tx-index-wrap&quot;=
, test_tx_index_wrap);<br>
+=C2=A0 =C2=A0 return g_test_run();<br>
+}<br>
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build<br>
index 46d4fc1d2b..36af0b267a 100644<br>
--- a/tests/qtest/meson.build<br>
+++ b/tests/qtest/meson.build<br>
@@ -284,6 +284,8 @@ qtests_aarch64 =3D \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;<wbr>CONFIG_XLNX_ZYNQMP_ARM&#=
39;) ? [&#39;xlnx-can-test&#39;, &#39;fuzz-xlnx-dp-test&#39;] : []) + \<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;<wbr>CONFIG_XLNX_VERSAL&#39;)=
 ? [&#39;xlnx-canfd-test&#39;, &#39;xlnx-versal-trng-test&#39;] : []) + \<b=
r>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;<wbr>CONFIG_RASPI&#39;) ? [&#=
39;bcm2835-dma-test&#39;, &#39;bcm2835-i2c-test&#39;, &#39;bcm2835-ic-test&=
#39;] : []) +=C2=A0 \<br>
+=C2=A0 (config_all_devices.has_key(&#39;C<wbr>ONFIG_RASPI&#39;) and host_o=
s !=3D &#39;windows&#39; ?<br>
+=C2=A0 =C2=A0 [&#39;bcm2838-genet-test&#39;] : []) + \<br>
=C2=A0 =C2=A0(config_all_accel.has_key(&#39;CO<wbr>NFIG_TCG&#39;) and=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
=C2=A0 =C2=A0 config_all_devices.has_key(&#39;CO<wbr>NFIG_TPM_TIS_I2C&#39;)=
 ? [&#39;tpm-tis-i2c-test&#39;, &#39;tpm-tis-i2c-swtpm-test&#39;] : []) + \=
<br>
=C2=A0 =C2=A0(config_all_devices.has_key(&#39;<wbr>CONFIG_ASPEED_SOC&#39;) =
? qtests_aspeed64 : []) + \<br>
-- <br>
2.56.0<br>
<br>
</blockquote></div></div>

--0000000000002cfc01065f50c695--


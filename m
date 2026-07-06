Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5149AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnWN-0004yh-Rw; Mon, 06 Jul 2026 13:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wgnWG-0004x7-AQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:12 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wgnWE-0008Aw-6I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:11 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38426d04bb4so55963a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783360448; x=1783965248; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zqhFDsBS6AOnPO2/+DoN040xrp2VfMXYgOopaLg5DIk=;
 b=E20j3UhIyeAghHQcf+wc9vjtyiuqNzqEFXlM2VBcsFCTe6pIOZmVr1MJ0qufcdXNSK
 xzyk554soONFR+nXuXHEmi4wGFzMf7xbQ35Ok8Un42uMWqXtqMyWk9iBxVZkThQ6ghYP
 rfHBrVY723Mdjl9cw2+kjmTkfH9gwHkwOZLzUOMDpi2k4TBrO7KtfVZeFLwoJUP0yYWP
 dGHcRkVFT02WySgDupM/y/ZVR7I8Un2S6t2/wXc/ceZXao9ebL7LZtBeCw6M0LlkAmVR
 Sqedkva1FLfWCrOPEIHR13IViZUpbrUr/uTBrMGXcJZaOB9WvYWPL7G0/BAQW5d7aeRj
 wAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783360448; x=1783965248;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zqhFDsBS6AOnPO2/+DoN040xrp2VfMXYgOopaLg5DIk=;
 b=MIlDiO8N/nQQQYHoOMAQq58Rsv8sb19AP9ucR8k0VWtzdmehxwtOWG8QqtPR8GzPpz
 DKmiqGvfGov8lDsKz1DLuQG0T59mtKGyVb7SYsjWg6XqO6BEtcMy7I7iMa9UuE6Cvvev
 3iI4a2oDcxNhaiYeYg3GO6EWKUozTDf5B3oYjbsZJ4HITsTNaeIb2SezFZMw8S3Ftdzv
 UDR4HsdUVcRnAYRF9ZIH6wui0Cdg00GozJ49q8kcSXl+rGHtwk4IuLvlSDDNhZPw/QK0
 AcbQZGJtvtAmso7COuJb53kEq4cm/C+m8Hx6sXYvYSSg7OAt+2lGlHCY+BUTRWIqWYzi
 8bZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpw4Bb33T1f9Bidd8t+dXqGz1fqOfLSwW2YQXSA8zyyXp1tqil5B3vS3EdEFTILN7w+Wdjg8Ej4Y75H@nongnu.org
X-Gm-Message-State: AOJu0YyEmlyy1upEZsgyii4YCUvWZtjo5joQobWUv9OyLTpCqd5jNrg9
 mVPdYDoirLV5wArrcQFyM/+czBX1Ft/AniTO1+N8joU6Ueejv0jM3ABd
X-Gm-Gg: AfdE7cmOkqxXE8k7qvE1BSHcNLKyjE5mOw8rpOMq6YhEZLP8ny9LX2vasWN2I8kWrTa
 9/fGkj/7TDwYCOJBAwlq6QK8B2HUTTyG1Lqc4WgKX6fbqjMxHevoIndBEmUwTRrBnXm85GZ7qlC
 CHEzoWKQAj7pDzv+c4wKsyCi5c9fSuazAG6On308UwDtWPm7QP0ksa2ao0rmjHh6iz8VFUU4rkl
 1DT/eN0UOY++6dGQmO34ZCE7+iw94VCI22e1NbCMxhnkhjdLJkZn6JxBwPU7gdYZc+U10JMR06g
 4pBtL18AfLuX2mvygGFUcdXqSTFnWdPPbA78JdY6R6WHsMjVcK9oZuwulzg6WYtfabDtj2w13kE
 3yBujUL41bNoAq9Ks8eOUIRdNAOSUMfWd3x9cjmCQaLVmeNOjRDDr5KBucVy/hahnqTiL7I5ziI
 4wTJgbJ4CpdEp4JbU=
X-Received: by 2002:a17:90a:f94b:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-38539ad0054mr3779926a91.17.1783360448311; 
 Mon, 06 Jul 2026 10:54:08 -0700 (PDT)
Received: from google.com ([2402:7500:46a:881a:bfa6:b3b2:ab12:133b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38127ae18f7sm5527157a91.3.2026.07.06.10.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:54:07 -0700 (PDT)
Date: Tue, 7 Jul 2026 01:54:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair23@gmail.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 5/5] tests/qtest: Add qtest for Milk-V Duo board
Message-ID: <akvruoEI-PbAJ9es@google.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
 <20260616190147.1286316-6-visitorckw@gmail.com>
 <CAKmqyKMXyrtFeruxxsy2NNTeCeqQfkM4khYuWN+Qu9Zhb0ebMg@mail.gmail.com>
 <CACPK8Xes3v8zoq4d35vLCHe8hs71nP87nAmkgvyr6WOMj9s4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACPK8Xes3v8zoq4d35vLCHe8hs71nP87nAmkgvyr6WOMj9s4Ew@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

i Joel and Alistair,

On Wed, Jul 01, 2026 at 01:05:55PM +0930, Joel Stanley wrote:
> On Mon, 29 Jun 2026 at 11:21, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2026 at 5:04 AM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > >
> > > Add minimal qtest coverage for the Milk-V Duo machine to validate basic
> > > MMIO mapping and register access.
> > >
> > > Currently tested:
> > > - Verify DW8250 UART component version and type signatures.
> > > - Test read/write access to CV1800B clock bypass register.
> > >
> > > Tested with:
> > > $ meson test -C build -v qemu:qtest-riscv64/milkv-duo-test
> > > [...]
> > > Ok:                 1
> > > Fail:               0
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > >  MAINTAINERS                  |  1 +
> > >  tests/qtest/meson.build      |  3 +-
> > >  tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 73 insertions(+), 1 deletion(-)
> > >  create mode 100644 tests/qtest/milkv-duo-test.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e197dcb5b2..472513537f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1807,6 +1807,7 @@ F: hw/riscv/milkv_duo.c
> > >  F: include/hw/char/dw8250.h
> > >  F: include/hw/misc/cv1800b_clk.h
> > >  F: include/hw/riscv/cv1800b.h
> > > +F: tests/qtest/milkv-duo-test.c
> > >
> > >  RX Machines
> > >  -----------
> > > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > > index 4897325d84..38acbdc0c8 100644
> > > --- a/tests/qtest/meson.build
> > > +++ b/tests/qtest/meson.build
> > > @@ -293,7 +293,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
> > >    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
> > >     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> > >     ['iommu-riscv-test'] : []) + \
> > > -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> > > +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : []) + \
> > > +   ['milkv-duo-test']
> > >
> > >  qos_test_ss = ss.source_set()
> > >  qos_test_ss.add(
> > > diff --git a/tests/qtest/milkv-duo-test.c b/tests/qtest/milkv-duo-test.c
> > > new file mode 100644
> > > index 0000000000..06064b8733
> > > --- /dev/null
> > > +++ b/tests/qtest/milkv-duo-test.c
> > > @@ -0,0 +1,70 @@
> > > +/*
> > > + * QTest for Milk-V Duo Board
> > > + *
> > > + * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "libqtest.h"
> > > +
> > > +#define CV1800B_CLK_BASE            0x03002000
> > > +#define CV1800B_CLK_BYPASS          0x030
> > > +#define CV1800B_CLK_BYPASS_RESET    0xFFFFFFFF
> > > +#define TEST_PATTERN_5A             0x5A5A5A5A
> > > +#define TEST_PATTERN_A5             0xA5A5A5A5
> > > +
> > > +#define CV1800B_UART0_BASE          0x04140000
> > > +#define DW_UART_UCV                 0xF8
> > > +#define DW_UART_CTR                 0xFC
> > > +#define DW_UART_VERSION_3_23A       0x3332332A
> > > +#define DW_UART_TYPE_SIGNATURE      0x44570110
> > > +
> > > +static void test_milkv_duo_uart(void)
> > > +{
> > > +    QTestState *qts;
> > > +    uint32_t component_version;
> > > +    uint32_t component_type;
> > > +
> > > +    qts = qtest_init("-M milkv-duo");
> > > +
> > > +    component_version = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_UCV);
> > > +    g_assert_cmphex(component_version, ==, DW_UART_VERSION_3_23A);
> > > +
> > > +    component_type = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_CTR);
> > > +    g_assert_cmphex(component_type, ==, DW_UART_TYPE_SIGNATURE);
> > > +
> > > +    qtest_quit(qts);
> > > +}
> > > +
> > > +static void test_milkv_duo_clk(void)
> > > +{
> > > +    QTestState *qts;
> > > +    uint32_t clk_bypass_val;
> > > +
> > > +    qts = qtest_init("-M milkv-duo");
> > > +
> > > +    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
> > > +    g_assert_cmphex(clk_bypass_val, ==, CV1800B_CLK_BYPASS_RESET);
> > > +
> > > +    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_5A);
> > > +    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
> > > +    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_5A);
> > > +
> > > +    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_A5);
> > > +    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
> > > +    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_A5);
> > > +
> > > +    qtest_quit(qts);
> > > +}
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +    g_test_init(&argc, &argv, NULL);
> > > +
> > > +    qtest_add_func("/riscv/milkv-duo/uart", test_milkv_duo_uart);
> > > +    qtest_add_func("/riscv/milkv-duo/clk", test_milkv_duo_clk);
> >
> > Thanks for the tests. These are just checking some static values
> > though. Can you also add a boot test?
> 
> +1
> 
>  A functional test that exercises -bios -kernel -dtb, as well as the
> sd device would be great.

I'll try to add the boot test.

I assume this means the test will need a way to fetch the kernel image
and dtb from somewhere. Would it be acceptable to host these files on
my personal github, or is there a more appropriate place I should
upload them to?

Regards,
Kuan-Wei


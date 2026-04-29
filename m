Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5725FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI39s-0004iP-Mb; Wed, 29 Apr 2026 07:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI39j-0004ga-Ok
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI39f-0000jC-RH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777462355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEfpl/T+syi3v38UyNihVZXbXMtDsLRzVNxbEldEB5E=;
 b=GWMK39uc0K+LhEigPTIjN2GxF0CVFOe9y9CyaECrD98HiTJIFp8hzbzJcI9lx9lYE4htF5
 MCl0MPR86uNcZVnOx2dJDzpvXYGfOo+5sh7vY510JhuD+3RCZ4bofBARLXS24Me8QIuVEG
 TUWk5D5SCcnqZUU7nbrD4jeAMC9ruaw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-w0zHImdnPFuWCTSlGlTrOg-1; Wed, 29 Apr 2026 07:32:31 -0400
X-MC-Unique: w0zHImdnPFuWCTSlGlTrOg-1
X-Mimecast-MFC-AGG-ID: w0zHImdnPFuWCTSlGlTrOg_1777462350
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24308165dso178893095ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777462350; x=1778067150; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WEfpl/T+syi3v38UyNihVZXbXMtDsLRzVNxbEldEB5E=;
 b=di0wuQ7JyNVeQoFn8nXJgO8LA+ZyHIWmpz13p7YoJ61BrXUj5QErtEX2DVOvBfp34o
 BBgF5fBQnt9Xq2QoZMXqQUZWZpuxpw3oLkMy2ecVbN9ndUHYQ4Ir3ZoqM0wMvtJs6NBN
 Ojj3QDeUMwXLYZHZ1aHxToqZ/MYJbt09guLbnFNT1r+vDYQUeoRZrjZXOBUosXRlmody
 FeDc2RfRGgR1jOhRIqTpKwwaxh7ajaqy7KYk/KfDjweqheQSWmoqzIqZHzSaYGSS8RIz
 IBUJcCUvDiZHY4zpWnd+pS1mmRII6NEKdshDK4pCFGt3Iq66LySNjVnrBkJ7JBQ8O5NI
 SjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462350; x=1778067150;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEfpl/T+syi3v38UyNihVZXbXMtDsLRzVNxbEldEB5E=;
 b=VZtxPczr/ZlyHgsCWjidhLLRVLXMkgATh/ncSowTXzmQfYqdF+vPO5xq6kMi0a3iyg
 ohc6c1UL8vqe2tiSiR/ZR9NVGxG1he7Y1wXNvhy1CRMnVnKQHMjoa7tqf238FqCZTrCa
 BJXOwh8nNT86Q0F0LtLWBPuqrGr4Hrt3oGnwB236ecD5GJKxBqMNg3Hoj18cZwnF+xC8
 O/mA78N58CXspb69EccOi8RAbpJ+q+cqBBv1ZvhSN9oajuaELoPfkjBMiP/xD52/O9OK
 WAINzE6eNkh0uu2i/TnuoitoLKQ7dtPEL9MRrS5vS6yPAkszru/swC3Ug0p30GKTJtRv
 cWnA==
X-Gm-Message-State: AOJu0YzQTUx8ytBw7NGynR/qSCm1YXHCPgOiCKAcvXMvSipSwTRHov7Y
 VB1jCR9YKKZnDK/a157NwSaZrcYBEvZWUsmHBgHM5t1XB2mFEBGyBunShHdmvVmBK4sXifsLapS
 eK+DIKvHgur29jad5w77DNcNzHduM9jm1BmjwKUaOtJQBkIZ0YyeIaIfJ
X-Gm-Gg: AeBDieuAoEBAQd1RWCNkhohG9E/bLZKj4XKdVeBMocS8XvAAr2Qu/T7rCxLojGAz7pS
 eM69y05ToNR4F71+Z0l8zOj/94H0sHPq4q592VgORy1y6SXs5+bG0ZewdXJD2VWl/Y0zB5jJMSx
 QT4JRCjWIZf/PaAGhjL0DYlLdrnpW3mC8nkLUht6RyqA6C2gNw+o6ZM3fdnhYBxcLaRS2iXrXtm
 nrn90PK0LkiopJuiiGJGZmeha7pqbdHWj9JAW52MGieCJ2r+DuDN3ErurLP4Z4EgqIrKdcFUOuH
 081tyjeDnj/2Vku802MmtfupcUcGE4GC5K+DH+zv3ywqtsV8cOKio5cOWAXtFVwaSIxIjgrE3v9
 nvRV62BNgyl6uVvDOOT6H68g=
X-Received: by 2002:a17:903:2ac5:b0:2b7:abc0:3bd7 with SMTP id
 d9443c01a7336-2b97c3fe759mr72552375ad.9.1777462350383; 
 Wed, 29 Apr 2026 04:32:30 -0700 (PDT)
X-Received: by 2002:a17:903:2ac5:b0:2b7:abc0:3bd7 with SMTP id
 d9443c01a7336-2b97c3fe759mr72551875ad.9.1777462349809; 
 Wed, 29 Apr 2026 04:32:29 -0700 (PDT)
Received: from fedora ([49.36.106.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98893f132sm20046805ad.49.2026.04.29.04.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:32:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:02:24 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 6/6] tests: Add a TPM TIS I2C swtpm test
Message-ID: <afHsSJlhvtjYCJ_e@fedora>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428130718.1325177-7-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 01:07:18PM +0000, Stefan Berger wrote:
> Add a test case testing the TPM TIS over I2C with swtpm.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/meson.build              |  5 +-
>  tests/qtest/tpm-tis-i2c-swtpm-test.c | 86 ++++++++++++++++++++++++++++
>  tests/qtest/tpm-tis-i2c-util.c       | 38 ++++++++++++
>  tests/qtest/tpm-tis-i2c-util.h       |  4 ++
>  4 files changed, 131 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 823be192e7..1a94f20f7f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -241,7 +241,7 @@ qtests_arm = \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>    (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
>    (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
> @@ -260,7 +260,7 @@ qtests_aarch64 = \
>    (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
>    (config_all_accel.has_key('CONFIG_TCG') and                                            \
> -   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
> @@ -398,6 +398,7 @@ qtests = {
>    'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'tpm-tis-i2c-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
> +  'tpm-tis-i2c-swtpm-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
>    'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'virtio-net-failover': test_migration_files,
> diff --git a/tests/qtest/tpm-tis-i2c-swtpm-test.c b/tests/qtest/tpm-tis-i2c-swtpm-test.c
> new file mode 100644
> index 0000000000..54a84251f8
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-i2c-swtpm-test.c
> @@ -0,0 +1,86 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest testcase for TPM TIS over I2C talking to external swtpm
> + *
> + * Copyright (c) 2018, 2026 IBM Corporation
> + *  with parts borrowed from migration-test.c that is:
> + *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.ibm.com>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +#include "qemu/module.h"
> +#include "tpm-tests.h"
> +#include "tpm-tis-i2c-util.h"
> +#include "qtest_aspeed.h"
> +
> +typedef struct TestState {
> +    char *src_tpm_path;
> +    char *dst_tpm_path;
> +    char *uri;
> +    const char *machine_options;
> +    char *ifmodel;
> +} TestState;
> +
> +static void tpm_tis_i2c_swtpm_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    aspeed_i2c_restart();
> +
> +    tpm_test_swtpm_test(ts->src_tpm_path, tpm_tis_i2c_transfer,
> +                        ts->ifmodel, ts->machine_options);
> +}
> +
> +static void tpm_tis_swtpm_migration_test(const void *data)
> +{
> +    const TestState *ts = data;
> +
> +    aspeed_i2c_restart();
> +
> +    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path,
> +                                  ts->uri, tpm_tis_i2c_transfer,
> +                                  ts->ifmodel, ts->machine_options);
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    TestState ts;
> +
> +    ts.src_tpm_path = g_dir_make_tmp("qemu-tpm-tis-i2c-swtpm-test.XXXXXX",
> +                                     NULL);
> +    ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-tis-i2c-swtpm-test.XXXXXX",
> +                                     NULL);
> +    ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
> +    ts.machine_options = "-machine rainier-bmc -accel tcg";
> +    ts.ifmodel = g_strdup_printf(
> +                            "tpm-tis-i2c,bus=aspeed.i2c.bus.%d,address=0x%x",
> +                            I2C_DEV_BUS_NUM, I2C_SLAVE_ADDR);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    aspeed_bus_addr = ast2600_i2c_calc_bus_addr(I2C_DEV_BUS_NUM);
> +
> +    qtest_add_data_func("/tpm/tis-i2c-swtpm/test", &ts, tpm_tis_i2c_swtpm_test);
> +    qtest_add_data_func("/tpm/tis-i2c-swtpm-migration/test", &ts,
> +                        tpm_tis_swtpm_migration_test);
> +    ret = g_test_run();
> +
> +    tpm_util_rmdir(ts.dst_tpm_path);
> +    g_free(ts.dst_tpm_path);
> +    tpm_util_rmdir(ts.src_tpm_path);
> +    g_free(ts.src_tpm_path);
> +    g_free(ts.uri);
> +    g_free(ts.ifmodel);
> +
> +    return ret;
> +}
> diff --git a/tests/qtest/tpm-tis-i2c-util.c b/tests/qtest/tpm-tis-i2c-util.c
> index 6e724a4a47..c73420ec5b 100644
> --- a/tests/qtest/tpm-tis-i2c-util.c
> +++ b/tests/qtest/tpm-tis-i2c-util.c
> @@ -15,6 +15,7 @@
>  #include "libqtest-single.h"
>  #include "qtest_aspeed.h"
>  #include "tpm-tis-i2c-util.h"
> +#include "tpm-emu.h"
>  
>  uint32_t aspeed_bus_addr;
>  
> @@ -62,3 +63,40 @@ void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v)
>      }
>      aspeed_i2c_writel(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
>  }
> +
> +void tpm_tis_i2c_transfer(QTestState *s,
> +                          const unsigned char *req, size_t req_size,
> +                          unsigned char *rsp, size_t rsp_size)
> +{
> +    uint32_t sts;
> +    size_t i;
> +
> +    /* request use of locality 0 */
> +    tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
> +
> +    tpm_tis_i2c_writel(s, 0, TPM_I2C_REG_STS, TPM_TIS_STS_COMMAND_READY);
> +
> +    /* transmit command */
> +    for (i = 0; i < req_size; i++) {
> +        tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_DATA_FIFO, req[i]);
> +    }
> +
> +    /* start processing */
> +    tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_STS, TPM_TIS_STS_TPM_GO);
> +
> +    uint64_t end_time = g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND;
> +    do {
> +        sts = tpm_tis_i2c_readl(s, 0, TPM_I2C_REG_STS);
> +        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) != 0) {
> +            break;
> +        }
> +    } while (g_get_monotonic_time() < end_time);
> +
> +    /* read response */
> +    for (i = 0; i < rsp_size; i++) {
> +        rsp[i] = tpm_tis_i2c_readb(s, 0, TPM_I2C_REG_DATA_FIFO);
> +    }
> +    /* relinquish use of locality 0 */
> +    tpm_tis_i2c_writeb(s, 0,
> +                       TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +}
> diff --git a/tests/qtest/tpm-tis-i2c-util.h b/tests/qtest/tpm-tis-i2c-util.h
> index 3289545f61..499bf4964a 100644
> --- a/tests/qtest/tpm-tis-i2c-util.h
> +++ b/tests/qtest/tpm-tis-i2c-util.h
> @@ -27,4 +27,8 @@ uint32_t tpm_tis_i2c_readl(QTestState *s, uint8_t locty, uint8_t reg);
>  void tpm_tis_i2c_writeb(QTestState *s, uint8_t locty, uint8_t reg, uint8_t v);
>  void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v);
>  
> +void tpm_tis_i2c_transfer(QTestState *s,
> +                          const unsigned char *req, size_t req_size,
> +                          unsigned char *rsp, size_t rsp_size);
> +
>  #endif /* TESTS_TPM_TIS_I2C_UTIL_H */
> -- 
> 2.43.0
> 

Reviewed-by: Arun Menon <armenon@redhat.com>

Regards,
Arun Menon



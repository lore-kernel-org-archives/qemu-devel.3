Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2805FF8877
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI376-0002lI-2d; Wed, 29 Apr 2026 07:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI372-0002ke-Tq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI370-0007vf-3l
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777462189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FoopuS5uqwaLcywvhiReMZkk5JjheqUp793BySGQG5U=;
 b=YPLTkgKq74RrJW/0Exq4H3elCar3kP7UdBOzLC1hC0fONSR13AP55dOqfJlbJpqoDhya//
 rtn1lDBPZinISwuKX+F+W2edC1P4Ij4Tc7YEEmpk+iOzSEfTZnTWs+3CCn13bILB3l4gSM
 4JejAcjwkfAqvPVFrlyUmHyDvRWKC3I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-00BrC_bfNtuq33c_N6A3Vw-1; Wed, 29 Apr 2026 07:29:47 -0400
X-MC-Unique: 00BrC_bfNtuq33c_N6A3Vw-1
X-Mimecast-MFC-AGG-ID: 00BrC_bfNtuq33c_N6A3Vw_1777462187
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35fbaada2f3so22945901a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777462186; x=1778066986; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FoopuS5uqwaLcywvhiReMZkk5JjheqUp793BySGQG5U=;
 b=MkvQDw8pXc6Oqx3HJjM1weG2VJEdQPwOxEy+ju8slqvnssoJWhuVrnNLkxPpeMmBxt
 JS/YfM4105+ouG6KV7P2pOSfreL+ZNypCr42InxtmLAlOnCV3D3ljLufDeFJ/a3L1+Xk
 bbsUw1bOa7KrXGA3Cpfg6c6k8LnfeALV0BiuJzfoeu+3oxCyFg9YK1wP2qeQXLLJgv2D
 HtWnYTl6leYM4PITt8NyKCX4Zyn1iCei/kU+rLw21Dg19Imkhl+KOVu9cz7azXfRQ63V
 OcyWGegJjo/hzQltLoa/+QtMJZAhnNT31ggLPvWsYP2QnYIUZBWOXSHp6G2DFZYMCRSf
 idEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462186; x=1778066986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoopuS5uqwaLcywvhiReMZkk5JjheqUp793BySGQG5U=;
 b=CgjtGN1jMRV+QFt5TyGAAvbjRcLswEesoek1kvHJq88yrqlIPZRMakMCppI6UQ2dGz
 jAX3pSzDLa0uPuWXWwcSAbfep3Qpf++h10lsFRory4v68ewnkq7L1FczkH4CbW5XISk2
 QUsQX65XF0rPWHGKIR3tbH9S8025yF6Y2b3dwXiERDAGo8kcYUHkyN8j/xWIzliMzaUg
 LKL5Q8IT2aageJAncLoYUisJkYXOHqlISPOVbn9HLnY2782btPudHgQyYgl5H2KuLWIG
 mWqQl4fAp9wXgL0E5wp9xQj/eI3z5cXiOt78I9I2qtDEywcany864xzFY6otpjshbHYK
 I8+w==
X-Gm-Message-State: AOJu0Yz8HLD294CrB1MUR41EczH9hzW7FWt7WLUBSXE1KAVqY2VoSCz9
 w2+MnhGCZPAhPhAl72h1qbqCKju5uSZq0Fa7VbwABeqEvifEt9A9yRHDUbLrbvPmV+lUGRcLxPE
 Ow8xJpx9bLWKvG4K18R8FmYxvu5v7C9hoXF7lOM2fOPRjnXZX/UQRtYVo
X-Gm-Gg: AeBDiesWEk3G21PvhCNqocRae8/aTvpSnEbEXwdhwaLpcg+8SVxAm2U4JJOqpQJCi00
 Z38XchVSvcHriWusb+46wdsL4iL6qlt5ZJ7T+Dnzy7W4PMByKyxHps3GHAy/YjH+IasA4sBLsOq
 S0YLmKzOc2Nalw8/44GNqbq35rUS+lc8/FUthHEIg7RbPJ+LoG50q8qyFuuiTf1nhxWOV2N8L/4
 1N+EMVKlkE9mMfqHLar9+NeRZ63zHyCFAS87AalqXJbOS9GQiyEb2b8zM2ac9flEW8Pa96W0nt2
 ayiRe2h0PoiTMsQ1yBaTXaUhWlXelNL/q4eguX0npLFnY2zsAOwcj9n6tuqiAY5nqqeZTTORJSY
 84StbJWtqQ+gD0Ty5hqpFY1c=
X-Received: by 2002:a05:6a20:729b:b0:3a3:327:c5c9 with SMTP id
 adf61e73a8af0-3a39c214542mr8092258637.26.1777462186516; 
 Wed, 29 Apr 2026 04:29:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:729b:b0:3a3:327:c5c9 with SMTP id
 adf61e73a8af0-3a39c214542mr8092214637.26.1777462185941; 
 Wed, 29 Apr 2026 04:29:45 -0700 (PDT)
Received: from fedora ([49.36.106.198]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7fd65065e1sm2137088a12.22.2026.04.29.04.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:29:45 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:59:41 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 1/6] tests: Move TPM I2C bus read/write functions to
 common files
Message-ID: <afHrpQWu6mRkehxh@fedora>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428130718.1325177-2-stefanb@linux.ibm.com>
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

On Tue, Apr 28, 2026 at 01:07:13PM +0000, Stefan Berger wrote:
> Move functions for reading from and writing to the Aspeed I2C device into
> a file so they can be reused by other functions.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/meson.build        |  2 +-
>  tests/qtest/tpm-tis-i2c-test.c | 50 +-------------------------
>  tests/qtest/tpm-tis-i2c-util.c | 64 ++++++++++++++++++++++++++++++++++
>  tests/qtest/tpm-tis-i2c-util.h | 30 ++++++++++++++++
>  4 files changed, 96 insertions(+), 50 deletions(-)
>  create mode 100644 tests/qtest/tpm-tis-i2c-util.c
>  create mode 100644 tests/qtest/tpm-tis-i2c-util.h
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b735f55fc4..823be192e7 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -397,7 +397,7 @@ qtests = {
>    'tpm-crb-test': [io, tpmemu_files],
>    'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
> -  'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
> +  'tpm-tis-i2c-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
>    'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>    'virtio-net-failover': test_migration_files,
> diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
> index 3a1af026f2..02ddf76c2c 100644
> --- a/tests/qtest/tpm-tis-i2c-test.c
> +++ b/tests/qtest/tpm-tis-i2c-test.c
> @@ -20,6 +20,7 @@
>  #include "hw/pci/pci_ids.h"
>  #include "qtest_aspeed.h"
>  #include "tpm-emu.h"
> +#include "tpm-tis-i2c-util.h"
>  
>  #define DEBUG_TIS_TEST 0
>  
> @@ -36,58 +37,9 @@
>  #define DPRINTF_STS \
>      DPRINTF("%s: %d: sts = 0x%08x\n", __func__, __LINE__, sts)
>  
> -#define I2C_SLAVE_ADDR   0x2e
> -#define I2C_DEV_BUS_NUM  10
> -
>  static const uint8_t TPM_CMD[12] =
>      "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
>  
> -static uint32_t aspeed_bus_addr;
> -
> -static uint8_t cur_locty = 0xff;
> -
> -static void tpm_tis_i2c_set_locty(uint8_t locty)
> -{
> -    if (cur_locty != locty) {
> -        cur_locty = locty;
> -        aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR,
> -                          TPM_I2C_REG_LOC_SEL, locty);
> -    }
> -}
> -
> -static uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg)
> -{
> -    tpm_tis_i2c_set_locty(locty);
> -    return aspeed_i2c_readb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> -}
> -
> -static uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg)
> -{
> -    tpm_tis_i2c_set_locty(locty);
> -    return aspeed_i2c_readw(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> -}
> -
> -static uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg)
> -{
> -    tpm_tis_i2c_set_locty(locty);
> -    return aspeed_i2c_readl(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> -}
> -
> -static void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v)
> -{
> -    if (reg != TPM_I2C_REG_LOC_SEL) {
> -        tpm_tis_i2c_set_locty(locty);
> -    }
> -    aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
> -}
> -
> -static void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v)
> -{
> -    if (reg != TPM_I2C_REG_LOC_SEL) {
> -        tpm_tis_i2c_set_locty(locty);
> -    }
> -    aspeed_i2c_writel(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
> -}
>  
>  static void tpm_tis_i2c_test_basic(const void *data)
>  {
> diff --git a/tests/qtest/tpm-tis-i2c-util.c b/tests/qtest/tpm-tis-i2c-util.c
> new file mode 100644
> index 0000000000..07b1eeba69
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-i2c-util.c
> @@ -0,0 +1,64 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest utilities for TPM TIS over I2C
> + *
> + * Copyright (c) 2018, 2026 IBM Corporation
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.ibm.com>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/tpm.h"
> +#include "libqtest-single.h"
> +#include "qtest_aspeed.h"
> +#include "tpm-tis-i2c-util.h"
> +
> +uint32_t aspeed_bus_addr;
> +
> +static uint8_t cur_locty = 0xff;
> +
> +static void tpm_tis_i2c_set_locty(uint8_t locty)
> +{
> +    if (cur_locty != locty) {
> +        cur_locty = locty;
> +        aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR,
> +                          TPM_I2C_REG_LOC_SEL, locty);
> +    }
> +}
> +
> +uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg)
> +{
> +    tpm_tis_i2c_set_locty(locty);
> +    return aspeed_i2c_readb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> +}
> +
> +uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg)
> +{
> +    tpm_tis_i2c_set_locty(locty);
> +    return aspeed_i2c_readw(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> +}
> +
> +uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg)
> +{
> +    tpm_tis_i2c_set_locty(locty);
> +    return aspeed_i2c_readl(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
> +}
> +
> +void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v)
> +{
> +    if (reg != TPM_I2C_REG_LOC_SEL) {
> +        tpm_tis_i2c_set_locty(locty);
> +    }
> +    aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
> +}
> +
> +void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v)
> +{
> +    if (reg != TPM_I2C_REG_LOC_SEL) {
> +        tpm_tis_i2c_set_locty(locty);
> +    }
> +    aspeed_i2c_writel(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
> +}
> diff --git a/tests/qtest/tpm-tis-i2c-util.h b/tests/qtest/tpm-tis-i2c-util.h
> new file mode 100644
> index 0000000000..dfe626b43d
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-i2c-util.h
> @@ -0,0 +1,30 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTest TPM TIS I2C: Common test functions used for TPM I2C on Aspeed bus
> + *
> + * Copyright (c) 2026 IBM Corporation
> + *
> + * Authors:
> + *   Stefan Berger <stefanb@linux.ibm.com>
> + *
> + */
> +
> +#ifndef TESTS_TPM_TIS_I2C_UTIL_H
> +#define TESTS_TPM_TIS_I2C_UTIL_H
> +
> +#include "qemu/osdep.h"
> +
> +extern uint32_t aspeed_bus_addr;
> +
> +#define I2C_SLAVE_ADDR   0x2e
> +#define I2C_DEV_BUS_NUM  10
> +
> +uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg);
> +uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg);
> +uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg);
> +
> +void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v);
> +void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v);
> +
> +#endif /* TESTS_TPM_TIS_I2C_UTIL_H */
> -- 
> 2.43.0
> 
> 
Looks good to me.

Reviewed-by: Arun Menon <armenon@redhat.com>



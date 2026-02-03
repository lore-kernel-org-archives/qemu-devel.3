Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D46CE83045
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6F1-00015P-Nk; Mon, 02 Feb 2026 21:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn6Ez-00014a-UP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:34:09 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vn6Ey-0004JZ-AP
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:34:09 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso2982806b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770086046; x=1770690846; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7ghrV72IxSsToHgClBXYn2yjikiEZmz1MbzwrRPZ+5o=;
 b=fqHgDIjWortfqbtadmq/j2Gx0Vq7yDxjGC+t4YsRQrZ1DAmWCyJxaRqqNPftL7QhlZ
 UrsiZZMFF8P+zIJR0lpS1s/pyAG8B3IZVchO0F5Smys/ywxCiWWQXPZg0ckHGCZsWCc4
 dNcZcOXhR5xQwHT2SxhWbwnWz7PtrAtUhUTVlKhdN1SX4R2Jz6KTvdpHIPKcWB6s3/oK
 14pnUWzlhIFfsnLveA2uGWC+lyrd7L0Z1F526usPUpFbbuCgBS4LhAHFH2w7nEzCakKd
 uEDEjnVJV+N5KijCouzqEcCOar/OUvcIPBdp/sWNugb0D6rmF9l94seZ2zFS1etzZHzD
 Flxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770086046; x=1770690846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ghrV72IxSsToHgClBXYn2yjikiEZmz1MbzwrRPZ+5o=;
 b=HKj3TJ6q1fBi7JB/lZMbKdRcngoUdKXRNwd7Dyh/XRGUEe/1c07u6Uj+6fM6ZgJ8kf
 om12Tq/JAWFIwM4tPrditJvGAT9ZaHzjVuBFrUYsolJ/lBFA+IaPGZ29dmIf0USMc8LD
 Il8DWv9cpOzFVjSYbjjnstChIzs76HW7YjMloOE163qGjQtm8wwdACb2obk5044B7siB
 csOMAmu235iB6IgQFEABC7flqbjT8X1150EMRatgPZqefQAp/WgQyywXcXdl3lSFOJXE
 8boIMbDyN1H087A5UyKmjW0crBR5gqrYxtSZi7yzaYGPQzwE1s54rF7TijLh+rajF48h
 0bAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtSeVNiTFMYXzUCe42Rs49FqSkiW2483Gv2YnUA3kZMFsb2yPQqAPO42piC89FLbo4aYkLgS8whHkm@nongnu.org
X-Gm-Message-State: AOJu0YxWDEQu94IZX8r7ZZjgEidhTmWZhE6Kn+WRXpsa3eUgswgsgcF2
 x47vJBCzcJj7GM4Hh3xs0RqqloZPQpzZ4nRLe3eBT6jsJ8XgMPgGywCA
X-Gm-Gg: AZuq6aI4a/KMkBuEeQ5LxrrrTj3K6pGaU2Xg2eRU8T7em/KkNSEIfp+Lgz5aega+UNv
 JEdH9Sh94f6OjS+C8sAms7/bvsZu+glAQIYR1WSSV0KIM7kKhDXkWVCVI5asI5Sa+l0VPbkWyKW
 VSvcNaAKxX6HeminXMhDeM6wBWmQB67lk3T+Y/CN7m7C0T+AXL5vuQ1IXjCDURtWJLVRKRLArnS
 renfaEg97+7pNRGRWBsXoxsNvdnwXMrMZvmFI2srBtT5E+CIt1EiC+Cu0FuUh/F+PcZtNuAdtnM
 F9ZGwrIimfkHNIZSzHvfzOIU/SkJ5mTbbVojtoXkKBIHwUN6uWwPdrnjKkAjy48uazcKA2LvKu1
 t2A1lmQ3beT4SZEIoUML3m2gst+EVzzosC2+91ds29/C7rDsAeHIn2LZXCVAb+YtT19PpYAlVIC
 zCNBrwiu3F/JvuUtt347Afxq5pEbxKluXBJXnJaQpVDRwuv1KSJlDSiUQHNtDJc5o=
X-Received: by 2002:a05:6a00:3e02:b0:81e:81fb:b391 with SMTP id
 d2e1a72fcca58-823ab72d8c0mr13301912b3a.45.1770086045811; 
 Mon, 02 Feb 2026 18:34:05 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([183.195.22.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfc72asm21920457b3a.42.2026.02.02.18.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 18:34:05 -0800 (PST)
Date: Tue, 3 Feb 2026 10:33:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, hust-os-kernel-patches@googlegroups.com
Subject: Re: [RFC PATCH v2 1/2] tests/qtest/libqos: Add RISC-V IOMMU helper
 library
Message-ID: <aYFehJ5oY0rms_E7@ZEVORN-PC.localdomain>
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <fff44d1db25e4a727c40048357059a58fcc58097.1769678103.git.chao.liu.zevorn@gmail.com>
 <2bb4ad3f-790f-438f-b2b3-60a8c91837e3@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb4ad3f-790f-438f-b2b3-60a8c91837e3@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
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

On Fri, Jan 30, 2026 at 11:46:42AM +0800, Tao Tang wrote:
> Hi Chao,
> 
> On 2026/1/29 17:39, Chao Liu wrote:
> > Introduce a libqos helper module for RISC-V IOMMU testing with
> > iommu-testdev. The helper provides routines to:
> > 
> > - Build device contexts (DC) and 3-level page tables for SV39/SV39x4
> > - Program command queue (CQ), fault queue (FQ), and DDTP registers
> >    following the RISC-V IOMMU specification
> > - Execute DMA translations and verify results
> > 
> > The current implementation supports SV39 for S-stage and SV39x4 for
> > G-stage translation. Support for SV48/SV48x4/SV57/SV57x4 can be added
> > in future patches.
> > 
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > ---
> >   MAINTAINERS                          |   1 +
> >   tests/qtest/libqos/meson.build       |   2 +-
> >   tests/qtest/libqos/qos-riscv-iommu.c | 405 +++++++++++++++++++++++++++
> >   tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
> >   4 files changed, 571 insertions(+), 1 deletion(-)
> >   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
> >   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dccdf47888..830f56376b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3584,6 +3584,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
> >   S: Maintained
> >   F: tests/qtest/libqos/qos-iommu*
> >   F: tests/qtest/libqos/qos-smmuv3*
> > +F: tests/qtest/libqos/qos-riscv-iommu*
> >   Device Fuzzing
> >   M: Alexander Bulekov <alxndr@bu.edu>
> > diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> > index b4daec808f..4a69acad0d 100644
> > --- a/tests/qtest/libqos/meson.build
> > +++ b/tests/qtest/libqos/meson.build
> > @@ -71,7 +71,7 @@ if have_virtfs
> >   endif
> >   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
> > -  libqos_srcs += files('riscv-iommu.c')
> > +  libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
> >   endif
> >   if config_all_devices.has_key('CONFIG_TPCI200')
> >     libqos_srcs += files('tpci200.c')
> > diff --git a/tests/qtest/libqos/qos-riscv-iommu.c b/tests/qtest/libqos/qos-riscv-iommu.c
> > new file mode 100644
> > index 0000000000..6c60889eeb
> > --- /dev/null
> > +++ b/tests/qtest/libqos/qos-riscv-iommu.c
> > @@ -0,0 +1,405 @@
> > +/*
> > + * QOS RISC-V IOMMU Module
> > + *
> > + * This module provides RISC-V IOMMU-specific helper functions for libqos tests,
> > + * encapsulating RISC-V IOMMU setup, and assertions.
> > + *
> > + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/bitops.h"
> 
> 
> This include is unnecessary: hw/misc/iommu-testdev.h (pulled in by
> qos-riscv-iommu.h) already includes hw/pci/pci.h, and hw/pci/pci.h itself
> includes bitops.h.
> 
> > +#include "hw/riscv/riscv-iommu-bits.h"
> > +#include "tests/qtest/libqos/pci.h"
> 
> Same. qos-iommu-testdev.h has included tests/qtest/libqos/pci.h.
> 
Thanks for the review. I'ill fix this in v3.

Thanks,
Chao
> 
> Besides
> 
> Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>
> 
> 
> Thanks,
> 
> Tao
> 
> 
> > +#include "qos-iommu-testdev.h"
> > +#include "qos-riscv-iommu.h"
> > +
> 


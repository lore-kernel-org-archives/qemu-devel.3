Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EBECD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 08:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKXde-0005yN-15; Wed, 06 May 2026 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKXdc-0005xs-4E
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:29:48 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wKXda-0003oJ-FZ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:29:47 -0400
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8acb09ddbf6so106520026d6.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778056185; x=1778660985; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qdZ313T3Rh1tXskVCwJ/wC55JV9WeQ50hhPsV/7A5mA=;
 b=Fsx9i2EdayAQ/KBmzsWpsubmqha1nDhGAbmQfkbc1gHqFblEkk7ZeetaWr6G16SY08
 hypojtvqXs+ub51SjyyimpNALvpyf4aLjpKNLj/eqK7DUJyfHZejXhgIqQGXUxgF+VH/
 gODNGOb19HsLnV/kZCwDFgp/fR3SNdpOe3Vqi4w/eOE35u8C7e+9wO308dwttykyyg4g
 Upq43DzGojo3FR2tko0CtlXe5uf9ZrErit/n/7Ipv4jx6yO2eA++oEW0QAcAhdMDVwuN
 RmP15EV0+h7fiif4cSv4o/G8JAmHzpbHjzqgzUlbaOt6Z7qB2FIfUET1jSaqVZl+YvVh
 0pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778056185; x=1778660985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdZ313T3Rh1tXskVCwJ/wC55JV9WeQ50hhPsV/7A5mA=;
 b=Gk+QXoghyc6IvSRG8uOowd7acvy8DNWqbYI9T/PjCcc3tGzLe2BuB9earrQzmoGkgB
 9ivszcWP45pXLCacSL6TU4d4x1Oa8JTTQuuQE7Jo0uBOlWbPcUwPEaaivD2tKumrbItL
 cuAyY3leAy2++isDvvPSYTVuMe56XNewO7XCUwLhUC2H8WULjI19n9phl+eU6SQHcwQv
 JgTitTsgmSW88+MBBuPynN1Gd3A5F/Bhr7NlGDCmAxkyYG7kekCWSK40DswrUgpJFAMu
 qe+b5EwX+Y4LBkjDSVOYXKXIW19UChsYC9vBRK/LhMe1ZdYXFUxETE2KnMiBnuhcRoYI
 l9bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ru9ZiAWPknm/rEzGvtak8FozfZSiaxj6y2HkpuRXUpdlV0YepZ/HkXkKUqGsZSHjIMDcNhpSFa8Ne@nongnu.org
X-Gm-Message-State: AOJu0YyqxICzzGEZwR4y9uxXaR9Ryvszpf2vXjlww38vJ70pR8wKuSXY
 9a0pQZvrm4oqUkttDKh4p/cgQAQVgMtcPV5Ni2mguEf5u2bCuhbXWxjc
X-Gm-Gg: AeBDiesJCopa8+Ev/fitCcZ2PiSObrVpadd4UTdndMHVsiLaLbN0NSZHYn74Na3vpM+
 qws0mHTEtvPOGlIjyvvysvTNGiyfIiXjOfbXZn5vceSYTRAlFkab1+FrzatwpZubLjSHVDf88DR
 U8FzGWyR+SbK4zrx8UL+i4JPqx/MzLbTGnkaGFNGL2WZImDCCoMImGTLYCJ5znD0T2pbgpSFGI4
 DkOJ6+z6QPy+EC3vXZdP8ToJvo3mrmqHTPULJRBGmTF6XqUhZZoAEkc0ADQX44xWgXPyoTTaSzX
 Q5wUYLLPTuW33zzDNKEbTkF3L2Ee8W45hCMnCOdMzvXT1bzZIWflpIE6/GZoonfOs7TFjZYlQh7
 lDonkG9XqSGd7K1+JCD5as/M9rn+eNahmpA2Ehtq3hFfcHs6jX+dWwxm41U9S1IqAbB+JXjRBgc
 ww6uKgyiRH19xgqtDOApgqXPR66uYtnHKHIHQ7Eqcna9pAtwx1u1n57VU5h6Pa/pxBFZcren/gI
 ovqBbf+9xA=
X-Received: by 2002:ac8:5ac2:0:b0:50d:9aff:8b43 with SMTP id
 d75a77b69052e-51461c1de38mr35584731cf.10.1778056185442; 
 Wed, 06 May 2026 01:29:45 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040b80a4dsm143769341cf.24.2026.05.06.01.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 01:29:44 -0700 (PDT)
Date: Wed, 6 May 2026 16:29:28 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH v6 5/5] docs/system/riscv: add documentation for k230
 machine
Message-ID: <afr6fF_Z-hCij63n@ZEVORN-PC.localdomain>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <3340676ead334e862b9eaf33297c87da158c0437.1776438369.git.chao.liu.zevorn@gmail.com>
 <CAKmqyKOKr02Cq7ko5wHkSuYrn4i=crjnkGEuFJeeWFYtG3X=UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOKr02Cq7ko5wHkSuYrn4i=crjnkGEuFJeeWFYtG3X=UQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf42.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, May 01, 2026 at 02:16:17PM +1000, Alistair Francis wrote:
> On Sat, Apr 18, 2026 at 1:13 AM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > From: Chao Liu <chao.liu@zevorn.cn>
> >
> > Add documentation for k230 virt reference platform.
> >
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> >  MAINTAINERS                  |  1 +
> >  docs/system/riscv/k230.rst   | 48 ++++++++++++++++++++++++++++++++++++
> >  docs/system/target-riscv.rst |  1 +
> >  3 files changed, 50 insertions(+)
> >  create mode 100644 docs/system/riscv/k230.rst
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b5b4acf6bd..d8d68cc123 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1776,6 +1776,7 @@ F: include/hw/riscv/xiangshan_kmh.h
> >  K230 Machines
> >  M: Chao Liu <chao.liu.zevorn@gmail.com>
> >  S: Maintained
> > +F: docs/system/riscv/k230.rst
> >  F: hw/riscv/k230.c
> >  F: hw/watchdog/k230_wdt.c
> >  F: include/hw/riscv/k230.h
> > diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> > new file mode 100644
> > index 0000000000..3e6ca295df
> > --- /dev/null
> > +++ b/docs/system/riscv/k230.rst
> > @@ -0,0 +1,48 @@
> > +Kendryte K230 virt reference platform (``k230``)
> > +==========================================================================
> > +The ``k230`` machine is compatible with with Kendryte K230 SDK.
> > +
> > +The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
> > +Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
> > +structure.
> > +
> > +This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
> > +Process Unit) smart computing unit.
> > +
> > +It has multi-precision AI computing ability, works with many common AI computing
> > +frameworks, and for some typical networks, its usage rate is over 70%. Besides,
> > +the K230 chip supports many peripheral connections and has several special
> > +hardware acceleration units (like 2D and 2.5D accelerators). It can speed up
> > +different tasks (such as image processing, video processing, audio processing
> > +and AI computing). It also has many good features: low delay, high performance,
> > +low power use and fast start-up.
> 
> This seems like a bit too much marketing, let's remove this paragraph.
> 
Okay.

> > +
> > +For more information, see <https://www.kendryte.com/en/proDetail/230>
> > +
> > +Supported devices
> > +-----------------
> > +The ``k230`` machine supports the following devices:
> > +
> > +* 1 c908 cores
> > +* Core Local Interruptor (CLINT)
> > +* Incoming MSI Controller (IMSIC)
> > +* 2 K230 Watchdog Timer
> > +* 4 UART
> > +
> > +Boot options
> > +------------
> > +The ``k230`` machine can start using the standard ``-bios``
> > +functionality for loading the boot image. You need to compile and link
> > +the firmware, kernel, and Device Tree (FDT) into a single binary file with
> > +K230 SDK(k230_canmv_defconfig), such as ``uboot``.
> > +
> > +Running
> > +-------
> > +Below is an example command line for running the ``k230``
> > +machine:
> > +
> > +.. code-block:: bash
> > +
> > +   $ qemu-system-riscv64 -machine k230 \
> > +      -bios k230_sdk/output/k230_canmv_defconfig/little/uboot/u-boot \
> > +      -nographic
> 
> Does -kernel not work?
> 
Thanks for the heads-up. I just tested booting Linux via U-Boot, but
ideally we should also support booting Linux with `-kernel`. I'll add
that in next version.

Thanks,
Chao
> Alistair


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5F4C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4jJk-0000Ic-TA; Tue, 15 Apr 2025 12:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4jJZ-0000H9-Vi
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:39:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4jJU-0008OZ-12
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:39:12 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e6ff035e9aso10697926a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744735145; x=1745339945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8d8YrrFlUlJqcgR/DRRyk7FPdwEAP2C2mIktWa8UaM0=;
 b=SnX+hS6uyZ/FtPHwuJjCmIwincRY4H0YZXkSUvnkiX6NBBI1Jm7wJ7jtMaSNCTnjc3
 tip0R2pdieLszVfPikSAMiPHieQM05lbC9oQdN3h8F8IDCRaY0Iwn5rBPGWIbSrS7ELp
 jeOHj8RT/+Zl0jjpuiFi2pH+NP7nVnUCFPE6fwOacGITuc5FDUrTmAJE9YtOsUHHV5Qt
 KCf5ShTtiky6RUzwNjuEWzhNflee85KoQAo0tNQ9Juqm/pczUBztNFtKvYwURYEMTG0C
 FMPxxOCbiRopxvLX254fA9eITtgeQkMp29NtZs06Nfxos9cTvV13EtS6oYornR3IEKrK
 AP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744735145; x=1745339945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8d8YrrFlUlJqcgR/DRRyk7FPdwEAP2C2mIktWa8UaM0=;
 b=NsKOGo9YBCuT6QtOY1GOL1kKJIJH6peJGVipeFcBiDhG65JDTwc05iSVKezlv1IO6t
 tqDim6y+xzRSxkXbsL23qWC2B7bEyzkl3km34UO+Azur0g2xgXJQl/dAoT4q9VuPzw5t
 WRaIo0G/BurZyy2dIo+frzYukWUMa0fNqMNTHItB5z/H2ByVezyfxb97spdqHypfVt5s
 iaetULALYDinTzL6TcCfK4Mqup5L0Kg9GCGd921UJnQkdBY/M75ulLkJ+goq8hQ03oSn
 c3QB2HWogpz6I6bQXvHs3oev1hLxNWAuaZ4c4UHbDvlzqAnBzslbfqK88lzHbuH1+Mkg
 xfoA==
X-Gm-Message-State: AOJu0YwUYrypyNLaIH6rF0l155now0QjWknnq5EgJXXWEmsvb/z3KyZg
 T3UYEPYtLzhLMvfbB6ugFOiL17edsC2/e5AOR6k6TbjkwumvywRYxWHc1vYEQM4C/0iVux0aJeU
 sGPyVDQzvSFOM/jf/m4z+ZNZGNN2lQOFCGN9qVw==
X-Gm-Gg: ASbGncteui+3c7o3y4rVNMrkOZ3bLIoBTKO6XDPE4S/zYBwtzhOdL/FyYtHmmbgPYZQ
 evJv6rSWUeVh1VZ9nXnB8FHBO/0s+eN8ScxdWKEeAWeFs2FguIwwOAYdYEZ9YJB4wMIGuQXHMJe
 5C5HIjOsUSBrIsUSehVJechqjA
X-Google-Smtp-Source: AGHT+IFRKtGZCjPosM7GBfhklF+gabkiYof1vyPKmOkYlTDWCuNNnHPEFIfgRIW1Y+5htdd0kaEFqkl1d1jy2H2sRGA=
X-Received: by 2002:a05:6402:42c5:b0:5ed:2a1b:fd7d with SMTP id
 4fb4d7f45d1cf-5f36fee6a4amr14305561a12.19.1744735144888; Tue, 15 Apr 2025
 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250415081231.21186-1-jim.shu@sifive.com>
 <20250415081231.21186-2-jim.shu@sifive.com>
 <2dd5952a93aca15bbae4b5624b680637@linux.ibm.com>
In-Reply-To: <2dd5952a93aca15bbae4b5624b680637@linux.ibm.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 16 Apr 2025 00:38:52 +0800
X-Gm-Features: ATxdqUE1bFY0OgeEVfSP6kxoXn-QXO1lP_eY0dZX40YG8IJXUxt68MW8ggAStAA
Message-ID: <CALw707oxFXoZbBW73GKuJVa2SuH0RSiUyz6a2XfPrOWZM5jckQ@mail.gmail.com>
Subject: Re: [PATCH 01/17] accel/tcg: Store section pointer in CPUTLBEntryFull
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Ilya,

My patch removes the use of `iotlb_to_section()`, so the section_index
in the last 12-bit of `xlat_section` is no longer used. (Please
correct me if I'm wrong!)
Based on the comment of `phys_section_add()` and the commit log [1], I
believe we can remove the assertion and support more than 4k sections.

I think my commit should also remove the `iotlb_to_section()` function
and rename `xlat_section` to `xlat`.
I will fix it in the next patch.

[1] https://github.com/qemu/qemu/commit/68f3f65b09a1ce8c82fac17911ffc3bb603=
1ebe4

Jim





On Tue, Apr 15, 2025 at 5:13=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On 2025-04-15 10:12, Jim Shu wrote:
> > 'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
> > find the correct section when CPU access the IO region over the IOTLB
> > (iotlb_to_section()).
> >
> > However, section_index is only unique inside single AddressSpace. If
> > address space translation is over IOMMUMemoryRegion, it could return
> > section from other AddressSpace. 'iotlb_to_section()' API only finds
> > the
> > sections from CPU's AddressSpace so that it couldn't find section in
> > other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
> > wrong section and QEMU will have wrong load/store access.
> >
> > To fix this bug, store complete MemoryRegionSection pointer in
> > CPUTLBEntryFull instead of section_index.
> >
> > This bug occurs only when
> > (1) IOMMUMemoryRegion is in the path of CPU access.
> > (2) IOMMUMemoryRegion returns different target_as and the section is in
> > the IO region.
> >
> > Common IOMMU devices don't have this issue since they are only in the
> > path of DMA access. Currently, the bug only occurs when ARM MPC device
> > (hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
> > handling. Upcoming RISC-V wgChecker device is also affected by this
> > bug.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  accel/tcg/cputlb.c    | 19 +++++++++----------
> >  include/hw/core/cpu.h |  3 +++
> >  2 files changed, 12 insertions(+), 10 deletions(-)
>
> Does this mean that there can be more than 4k sections now and the
> assertion in phys_section_add() can be removed?


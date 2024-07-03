Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14579C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP1Qk-0007Zh-V5; Wed, 03 Jul 2024 10:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sP1Qj-0007Yk-Ng
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:57:57 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sP1Qg-0005Pi-N6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 10:57:57 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d846f43632so1256935b6e.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720018673; x=1720623473; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EBVph4qCfYaMbZP3UoZ2K23x3GSN/F+GNnJRA4L/VXg=;
 b=ORaqsK51H8yKvZoxLJoqovuJcwuSpMmQDVRcszAqOBTICf7g8BG+gUtK5Y7Eyf0Fzr
 cTjQfhee3X8UP+LN4x1JnCXX3yoLzgO1WNLtHgPGXctoRB9myVUeJ32W9OCkTa4lWM2u
 YivleJ6p4hX6PuR330+j4wgtMbcwp+HDFSwnXLehz39WLWudfSrjLn+/Vo02m8UF0NRq
 SkadJsF2lK35UD4pzAV5M0OKeKe2Gc3EBdmIzRWv7YIj8l5+4kznshYEdx62Ksbpxewg
 oYkItMb0am4aIvHAVuM1AtZzSkmQrSaHCMnhkd6hqrv/ZIOo7LiyVU4wnc+2lpsh/ooo
 Ze7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720018673; x=1720623473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBVph4qCfYaMbZP3UoZ2K23x3GSN/F+GNnJRA4L/VXg=;
 b=o8Wms1THUub1bZjyUpF1459uHCeWjCAbq/EX0JhRKSA44aIg/3PhSu5spi2GcE1eRC
 z0bSm/MYNRD1j/02UBJXH+meQWwZFyXbH3faoedGPF5yjPATl40f5YMjg4CR+Jc0ZtlR
 +bjIspJnd42seqNOBXiqjUE1KkaUBL3yzpTsB6Aldr8zLQz+xhDv9zPay9lfLg3ewyFB
 B3ia30tUEW0ETU8e3CBA/jR+P7MBtZez3GZnkq77FYVw0WiRelheLWGsHlj6a3BiDkRL
 YXH+7PnFEy/MfxisA7l2stpAk9YteuixfJrkXF3GyktbJgYpGtbfbv9+sfXuNxM2U9Bo
 DYHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIRvcTlve683KfvPZCwEefX274csdKYLZpkAPE9bs0h9goz6D/YGoVVU1J6spvqewV4okhHkg62ziyEuRqcXrdeU87Cuo=
X-Gm-Message-State: AOJu0YzgThnBkv6DC+f5J+JiXKX6DtTnl67+CRvUUmNZtWCp8WdcjxiL
 /eKKkj9KEtNv1dZrNqu9T0p+mUeW5/0D/Nvc+FGcAQrCXI38Hiet/lGW94rUkqs=
X-Google-Smtp-Source: AGHT+IHVsqxV4XGTIjVffB5AyensBfCTbCkocCPk38uDvTI3iZ65HU0X9prSWdmkaq2+TDJZXBeMAw==
X-Received: by 2002:a05:6808:159b:b0:3d2:1da4:af63 with SMTP id
 5614622812f47-3d6b4de260amr11755066b6e.45.1720018672499; 
 Wed, 03 Jul 2024 07:57:52 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fb3ec4esm2101687b6e.49.2024.07.03.07.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 07:57:36 -0700 (PDT)
Date: Wed, 3 Jul 2024 20:27:04 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 16/16] tests/qtest/bios-tables-test: Add expected ACPI
 data files for RISC-V
Message-ID: <ZoVmwFgIRlziF/v4@sunil-laptop>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-17-sunilvl@ventanamicro.com>
 <20240627141803.42cd46c1@imammedo.users.ipa.redhat.com>
 <20240701170330-mutt-send-email-mst@kernel.org>
 <20240702150236.000042eb@Huawei.com>
 <ZoUmf2zn51RWU0o0@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoUmf2zn51RWU0o0@sunil-laptop>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22b.google.com
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

On Wed, Jul 03, 2024 at 03:53:08PM +0530, Sunil V L wrote:
> On Tue, Jul 02, 2024 at 03:02:36PM +0100, Jonathan Cameron wrote:
> > On Mon, 1 Jul 2024 17:03:43 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Jun 27, 2024 at 02:18:03PM +0200, Igor Mammedov wrote:
> > > > On Tue, 25 Jun 2024 20:38:39 +0530
> > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >   
> > > > > As per the step 5 in the process documented in bios-tables-test.c,
> > > > > generate the expected ACPI AML data files for RISC-V using the
> > > > > rebuild-expected-aml.sh script and update the
> > > > > bios-tables-test-allowed-diff.h.
> > > > > 
> > > > > These are all new files being added for the first time. Hence, iASL diff
> > > > > output is not added.
> > > > > 
> > > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > Acked-by: Igor Mammedov <imammedo@redhat.com>  
> > > > 
> > > > Michael,
> > > > can it go via risc-v tree or
> > > > do you plan to merge it via your tree?  
> > > 
> > > given patch 1 is merged, I took the rest.
> > 
> > Looks like your CI runs are catching this as well but
> > RHCT here is failing.  I rebased the GI/GP set on top of this
> > and ignored that failure by skipping riscv64 tests.
> > 
> > Jonathan
> > 
> Hi Jonathan, Michael,
> 
> Looks like a recent RISC-V PR updated the rva22s64 ISA string affecting
> the RHCT I had in my series. I see that Michael dropped those 3 RISC-V
> patches from the PR. So, let me update the expected RHCT AML file in a
> new series. I will also include Igor's feedback to remove fallback path
> in that series.
> 
Hi Alistair,

This issue is because, below 3 extensions are present in the ISA string
for rva22s64 profile cpu after recent RISC-V PR.

zmmul_zaamo_zalrsc

However, IIUC, they are not mentioned in the RVA22S64 profile spec. Because of
this change, my AML files are having a difference and failing CI. The
question is, is this correct behavior? If so, I can update the AML files
and resubmit the patches. Let me know.

Thanks,
Sunil


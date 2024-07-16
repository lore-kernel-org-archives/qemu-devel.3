Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217AFC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThGH-0005pw-Tr; Tue, 16 Jul 2024 08:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sThGD-0005mT-JB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:26:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sThGB-0007lD-8y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:26:25 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70361745053so2146056a34.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721132781; x=1721737581; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=70On1nl54TUx4JS0/JF64ELZTTFL0csQutk2/9F/nqQ=;
 b=F+8svhvbmzDM/cCCltTLPNqFN89TfGmYImoehZseG+aFELpBt+CMmVKYIUKXs8V4N4
 qDnUFjNSRUqSZRnDql7NKohw+UEsPuqFsNaa0xIcrFjcQv0ETuz1konO3p7GvnDw1l/9
 mltYC4IbQSYCrFBHaF4Uv7/z22S5xzohBBXNvBUcngv+GwI0OLLE08SrpCf+r3/VC66P
 FuKixqQLzXrTmBQ4/Ho/wPocylfgvcclcvt1ubKuedlfqaMV+lD+ChhUcX5FXc3gav0i
 qaB7snB63KyWzH6cTye0k2JVIOVoQj/KfBxE8ZUc5/dBtLQti2Lth7k/yRqhQs2ZAsu/
 liVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721132781; x=1721737581;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=70On1nl54TUx4JS0/JF64ELZTTFL0csQutk2/9F/nqQ=;
 b=SCvWrRyzyqLKQog2ShRfllTGR2WQuqvjVYLPd6Lyj2vqJz2vOIktcc2QTMURyBPoCx
 POsYxL33wHAxr8HWI7bpWOvpAgzKGIme8XumRB90usQ7Nrn/mTBTL4OgIIeRDsEslyBy
 1vtm4tgflrtQcNi1JAdOxfCO6w3KeMzz0oO0nrLA7lgwvHuSf3vwLJ9XnilSwgzMj7d6
 wL3fekDefsROa/SjOF8MbiSE33VeXdsXEC7mqj5IBgL5CbG3EpviBPElaumtq6MVPW7d
 SAdinEo2jmRenAy5eNPYOo6XvZhjli2wBMBYh+sq5gCaqVQwSCddqR4/cWPqpKy/bXk7
 2IXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdzzGYmHUOcj0+uZtgqQmDjV8uGpR2sKUb+iDG7KROPrk7fIkQkiG3mzTRjSNjA3B+MJH/RZVdffdO2Nq8P57a1z5Ck7Q=
X-Gm-Message-State: AOJu0YwjCjSeyMR2QbNsLhPx1jAVJWmZJ4m0Dms7HEtzuHvS0L9d8wZc
 pBFJqWUIg9Owb3I8I9BoChcF67ukwsHjXj0zjINLxEo7zpcfwdKAYCgsvLbyktw=
X-Google-Smtp-Source: AGHT+IEq9EFHQosCXk61rGc638X4mwwlsqU0netSsjr948S4FLnIm6218cdlgomyK9/mGf81/JpHdQ==
X-Received: by 2002:a9d:5606:0:b0:703:63d4:afbf with SMTP id
 46e09a7af769-708db33a4c3mr553178a34.16.1721132780670; 
 Tue, 16 Jul 2024 05:26:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d01667sm1295259a34.63.2024.07.16.05.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 05:26:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 17:56:11 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <ZpZm48s9zt/glU/H@sunil-laptop>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
 <ZpEmuB6xyh2K77Ic@redhat.com>
 <20240712155010.3756bb82@imammedo.users.ipa.redhat.com>
 <20240714034105-mutt-send-email-mst@kernel.org>
 <20240715144352.22d36779@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715144352.22d36779@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x334.google.com
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

On Mon, Jul 15, 2024 at 02:43:52PM +0200, Igor Mammedov wrote:
> On Sun, 14 Jul 2024 03:46:36 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jul 12, 2024 at 03:50:10PM +0200, Igor Mammedov wrote:
> > > On Fri, 12 Jul 2024 13:51:04 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >   
> > > > On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote:  
> > > > > On Mon,  8 Jul 2024 17:17:32 +0530
> > > > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >     
> > > > > > This series adds few updates to RISC-V ACPI namespace for virt platform.
> > > > > > Additionally, it has patches to enable ACPI table testing for RISC-V.
> > > > > > 
> > > > > > 1) PCI Link devices need to be created outside the scope of the PCI root
> > > > > > complex to ensure correct probe ordering by the OS. This matches the
> > > > > > example given in ACPI spec as well.
> > > > > > 
> > > > > > 2) Add PLIC and APLIC as platform devices as well to ensure probing
> > > > > > order as per BRS spec [1] requirement.
> > > > > > 
> > > > > > 3) BRS spec requires RISC-V to use new ACPI ID for the generic UART. So,
> > > > > > update the HID of the UART.
> > > > > > 
> > > > > > 4) Enabled ACPI tables tests for RISC-V which were originally part of
> > > > > > [2] but couldn't get merged due to updates required in the expected AML
> > > > > > files. I think combining those patches with this series makes it easier
> > > > > > to merge since expected AML files are updated.
> > > > > > 
> > > > > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > > > > > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.html    
> > > > > 
> > > > > btw: CI is not happy about series, see:
> > > > >  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> > > > > also 'cross-i686-tci' job routinely timeouts on bios-tables-test
> > > > > but we still keep adding more tests to it.
> > > > > We should either bump timeout to account for slowness or
> > > > > disable bios-tables-test for that job.    
> > > > 
> > > > Asumming the test is functionally correct, and not hanging, then bumping
> > > > the timeout is the right answer. You can do this in the meson.build
> > > > file  
> > > 
> > > I think test is fine, since once in a while it passes (I guess it depends on runner host/load)
> > > 
> > > Overal job timeout is 1h, but that's not what fails.
> > > What I see is, the test aborts after 10min timeout.
> > > it's likely we hit boot_sector_test()/acpi_find_rsdp_address_uefi() timeout.
> > > That's what we should try to bump.
> > > 
> > > PS:
> > > I've just started the job with 5min bump, lets see if it is enough.  
> > 
> > Because we should wait for 5min CPU time, not wall time.
> > Why don't we do that?
> > Something like getrusage should work I think.
> > 
> 
> It turned out to be a meson timeout that's set individually per test file.
> I'll send a patch later on.
> 
Hi Igor,

I am unable to get msys2-64bit test in CI to pass. I tried including
your change in meson as well but no luck. I can't guess how enabling
bios-tables-test for RISC-V is affecting this particular test. Does this
pass for you? 

https://gitlab.com/vlsunil/qemu/-/jobs/7343701148

Thanks!
Sunil


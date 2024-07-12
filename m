Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1264FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGfL-0004du-Ql; Fri, 12 Jul 2024 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sSGfJ-0004XJ-Ug
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sSGfA-0003u0-V9
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720792214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ePkYmH/GJd4VuY3X5+BwKbbiNtXv+geAVMk56SLD1Q=;
 b=VWIXwmScYgK++L/YaW8kgcYQIzBkJTJ0KgBXchdKmsDoht6Sc4R1RY93o/ceup5v29iRY3
 W+hWcphEUOYV+GOstsM5cPX11AJ1P6fWHqEE4gpDUwqg2DgV6eA9sCzZUFaCwlxSRC/nBo
 Xb+PigaQecxwr9/4UmWOUIm7ItzkYXc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-TMAdKX1JNc6SAdvZiSCVKQ-1; Fri, 12 Jul 2024 09:50:13 -0400
X-MC-Unique: TMAdKX1JNc6SAdvZiSCVKQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-426683d9c4bso12320665e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 06:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720792212; x=1721397012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ePkYmH/GJd4VuY3X5+BwKbbiNtXv+geAVMk56SLD1Q=;
 b=fqgJpBEcVOCGeNMTmcR9E/DedMVOp50JRdu9PyiS+P4o8m2lI8gpxIMPqpFmqifCO5
 SiZVg0cD4fuuNL+g2bD948GFtbgdGM5XC/RunwX5mWECgjBhLLa1neXimYIX4vE4vrWG
 3hty2nuVdhfgyeQFZ6PBkTGyv9+V4/LEoahd1y1mxXCR6sdFNJR7BL9FyH6CQ1nICMkX
 ZcCUY1/p68LJvVVaeG7RTScnNYIZZZTrYlw3YR1TRmiaOrPbYKYySdlenj2o+aSqeGA9
 LXrjaP4Z8sHl4QQWaCyQe8sdHetaP/ndMGQyHKF5uoP6mNg/Pjs09zTJnjCmIBCbKqhl
 /Ppw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVPtqWYOpNR232AnOalixqEbeT/qaRneimAF0WqLEgz6QnZOY1YuVYjk3Q+FWGuEyMFDFfoE/Vp/4xvu8wpXHXzJODRPs=
X-Gm-Message-State: AOJu0YxOV7mvoxnqxdpG25aM0NvhiZi5WhI8XiHJlif1jGQ8oPd0iWBx
 pxaPBbJUOWoRcEnrzaLD5EBNS48G28RZ9Plf140fRm8rt3sKSSZ70MFFkAGbyUs2zLut7eh7i8Z
 VCjJqHBy58cfSrEzHt9lWGG4tfYwHIaah59akVqTALnGNck5FjMeX
X-Received: by 2002:a05:600c:428a:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-426707e209emr71747475e9.19.1720792212151; 
 Fri, 12 Jul 2024 06:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1OpAB2y3WZP9iSqV1rj32OZr6AbH2cqLalnj9oWHaSTIBaGJUZtCISUQYJHYVUbpIAt8XQA==
X-Received: by 2002:a05:600c:428a:b0:426:6153:5318 with SMTP id
 5b1f17b1804b1-426707e209emr71747325e9.19.1720792211760; 
 Fri, 12 Jul 2024 06:50:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426725597bdsm83977055e9.0.2024.07.12.06.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 06:50:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 15:50:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 0/9] RISC-V: ACPI: Namespace updates
Message-ID: <20240712155010.3756bb82@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZpEmuB6xyh2K77Ic@redhat.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240712144319.233c19a7@imammedo.users.ipa.redhat.com>
 <ZpEmuB6xyh2K77Ic@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 12 Jul 2024 13:51:04 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jul 12, 2024 at 02:43:19PM +0200, Igor Mammedov wrote:
> > On Mon,  8 Jul 2024 17:17:32 +0530
> > Sunil V L <sunilvl@ventanamicro.com> wrote:
> >  =20
> > > This series adds few updates to RISC-V ACPI namespace for virt platfo=
rm.
> > > Additionally, it has patches to enable ACPI table testing for RISC-V.
> > >=20
> > > 1) PCI Link devices need to be created outside the scope of the PCI r=
oot
> > > complex to ensure correct probe ordering by the OS. This matches the
> > > example given in ACPI spec as well.
> > >=20
> > > 2) Add PLIC and APLIC as platform devices as well to ensure probing
> > > order as per BRS spec [1] requirement.
> > >=20
> > > 3) BRS spec requires RISC-V to use new ACPI ID for the generic UART. =
So,
> > > update the HID of the UART.
> > >=20
> > > 4) Enabled ACPI tables tests for RISC-V which were originally part of
> > > [2] but couldn't get merged due to updates required in the expected A=
ML
> > > files. I think combining those patches with this series makes it easi=
er
> > > to merge since expected AML files are updated.
> > >=20
> > > [1] - https://github.com/riscv-non-isa/riscv-brs
> > > [2] - https://lists.gnu.org/archive/html/qemu-devel/2024-06/msg04734.=
html =20
> >=20
> > btw: CI is not happy about series, see:
> >  https://gitlab.com/imammedo/qemu/-/pipelines/1371119552
> > also 'cross-i686-tci' job routinely timeouts on bios-tables-test
> > but we still keep adding more tests to it.
> > We should either bump timeout to account for slowness or
> > disable bios-tables-test for that job. =20
>=20
> Asumming the test is functionally correct, and not hanging, then bumping
> the timeout is the right answer. You can do this in the meson.build
> file

I think test is fine, since once in a while it passes (I guess it depends o=
n runner host/load)

Overal job timeout is 1h, but that's not what fails.
What I see is, the test aborts after 10min timeout.
it's likely we hit boot_sector_test()/acpi_find_rsdp_address_uefi() timeout.
That's what we should try to bump.

PS:
I've just started the job with 5min bump, lets see if it is enough.

> We should never disable tests only in CI, because non-CI users
> are just as likely to hit timeouts.
>=20
>=20
> With regards,
> Daniel



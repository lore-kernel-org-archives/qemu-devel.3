Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D0EC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 10:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOx8q-0000rA-JL; Wed, 03 Jul 2024 06:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sOx8p-0000qs-DG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:23:11 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sOx8n-0000SP-NA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 06:23:11 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d55db7863bso3382175b6e.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720002188; x=1720606988; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tIav5KZUA6cIne1AwYaEIMMojMvU8ctn52V4PV46rME=;
 b=CtgDrRp434LSap9k7otVWL9X0PApP4H+nUqsMLGqElndnghHGJEUP9lecTSdF7Tala
 ORVI1qgL9N8sM7hJ/oX6h/IrcroUIgV0YW3Zq1VDWjUPA0MfRD7urDNFdqau/ijN30ms
 woxKBOtaFWvsxEsUCRc6Bv4L69bg5GRWC1aG8fc12J9AUNxjuiHEA0z+651Blcec/AIS
 x/UXt4V/iGyIAITEPH7ump9auTwVgAU60kQZHta7BnuKmuqJcLdfJL4t9q9msFuA2GJ4
 RiwqDP/Un7Zt4qZlohH3H6F440panp3xWDZl9YlqmsXPAjXF+GEbWJHUTQ374H3ipl/o
 AhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720002188; x=1720606988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIav5KZUA6cIne1AwYaEIMMojMvU8ctn52V4PV46rME=;
 b=uIkq+jrd1MYeEYPvweHaD8Vp54Qc/w9VGxoOfU252kkMFn1hEUh9U639gOeu4rcuqW
 Mmi24KgL+yFxz2Szj9eRvcYhOHT4zE7Wh9eqW5CCeyPIy1HvtE9bVtGLWI57Pz2bRXmJ
 K5SrSHHJGrpR17OwcgSNfDTQ4b+Qxjx4utf1wCQHL8Y5ICNA8EXpdq4ZvtSSuj+jvA2y
 wMXf1/aD1fRPNjJFz07IFpUdQBOrQ7EIzbfXAjkHeGOtmnEGDpDy0UgIw4BlVuyRjDRn
 xevagav/noboTrB0ZvKjEm3ms5qBOykKT2OrNCyX8PD5n1daS+uZop6U6cVtIAWc9bYM
 nmKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlYIiFouaPKKePhY1fCeSg9vlgLELnW0OmjhtZM1qOh5X7DoAjDOnafWDRwvs9XjoJLIXLwxd+1pHYvV7qYy7OGnW0Cgw=
X-Gm-Message-State: AOJu0Ywr59gAw1J5DIGNcekIgiARvHM1PYEty2kXlj5V7jO6aPDRUc7H
 OWhG52NCWPgO1nvp9EysjOTWg7Ucza0KsKuQKUVnGO9gg8gd5S0I5FmJKJjBKF0=
X-Google-Smtp-Source: AGHT+IFTQ6x6dh+JRMQZByO8hHF3avVlJtysEUJdfD31hCa0q0/aNQIVzAMRSUHVHDr7v8j78GkmzA==
X-Received: by 2002:a05:6808:2f06:b0:3d2:1a92:8f4a with SMTP id
 5614622812f47-3d6b32e4136mr15562308b6e.23.1720002187856; 
 Wed, 03 Jul 2024 03:23:07 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e9b20sm2027270b6e.25.2024.07.03.03.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 03:23:07 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:52:55 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <ZoUmf2zn51RWU0o0@sunil-laptop>
References: <20240625150839.1358279-1-sunilvl@ventanamicro.com>
 <20240625150839.1358279-17-sunilvl@ventanamicro.com>
 <20240627141803.42cd46c1@imammedo.users.ipa.redhat.com>
 <20240701170330-mutt-send-email-mst@kernel.org>
 <20240702150236.000042eb@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702150236.000042eb@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 02, 2024 at 03:02:36PM +0100, Jonathan Cameron wrote:
> On Mon, 1 Jul 2024 17:03:43 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Jun 27, 2024 at 02:18:03PM +0200, Igor Mammedov wrote:
> > > On Tue, 25 Jun 2024 20:38:39 +0530
> > > Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >   
> > > > As per the step 5 in the process documented in bios-tables-test.c,
> > > > generate the expected ACPI AML data files for RISC-V using the
> > > > rebuild-expected-aml.sh script and update the
> > > > bios-tables-test-allowed-diff.h.
> > > > 
> > > > These are all new files being added for the first time. Hence, iASL diff
> > > > output is not added.
> > > > 
> > > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > > > Acked-by: Igor Mammedov <imammedo@redhat.com>  
> > > 
> > > Michael,
> > > can it go via risc-v tree or
> > > do you plan to merge it via your tree?  
> > 
> > given patch 1 is merged, I took the rest.
> 
> Looks like your CI runs are catching this as well but
> RHCT here is failing.  I rebased the GI/GP set on top of this
> and ignored that failure by skipping riscv64 tests.
> 
> Jonathan
> 
Hi Jonathan, Michael,

Looks like a recent RISC-V PR updated the rva22s64 ISA string affecting
the RHCT I had in my series. I see that Michael dropped those 3 RISC-V
patches from the PR. So, let me update the expected RHCT AML file in a
new series. I will also include Igor's feedback to remove fallback path
in that series.

Thanks,
Sunil

Thanks,
Sunil


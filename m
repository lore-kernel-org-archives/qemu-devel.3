Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B7CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCrR-0005b4-G6; Thu, 18 Jun 2026 09:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waCrQ-0005aa-1Q
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waCrO-0008S7-3k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781789564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g7xG8JM8Ar3LWTKrhqIL4fcIiBSyebqoYxlucTcBPE=;
 b=BG30eCn1FWpvlGVqtNFo99CZhEs3S9ZvEkDFExOa1Sf/4SPKDMKHwnP3jnS6sDYT6Q95Bf
 ZkCccl2wJk53YIcZlVDhQP2xl1ygN9AJ5RZ1yDd4iw8cqQlAKwTaGviKm8r7jcBXsVNvd+
 Yvc6IjHy8VA5rqaWYgzwoc7f0ifRKho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-N_lEF5sUM8uq0A3lgvAGFQ-1; Thu, 18 Jun 2026 09:32:42 -0400
X-MC-Unique: N_lEF5sUM8uq0A3lgvAGFQ-1
X-Mimecast-MFC-AGG-ID: N_lEF5sUM8uq0A3lgvAGFQ_1781789561
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490bde3d239so6739685e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781789561; x=1782394361; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6g7xG8JM8Ar3LWTKrhqIL4fcIiBSyebqoYxlucTcBPE=;
 b=llT4Ds0yMCtLPoKLJJZ4woAFFvidakQqDsLjctNx1O8xgYNpfEw1K3GZ/GkUTBAudE
 V80YHhDfYauQVxNvJQQrQbOrW0WzIlLcj/eVonHS8Yc7GuWg16gb6CtSuAloJrOry5kv
 5Ap60olHPEHht6g4bE6ojy3Ai203ajQm6/Bua7Fj8VmsRKrmxRBymlCAXOtPdXJsf3uv
 HXOn2ngny2SqUpwqqYfqnfWEINC8Q/xEcHnZhJUbauPtKW4vgm6CibDU9a3+YzZ86LC7
 dzWeIQ52aH2nZXFMYolZ5donJcgE9PMP2k8b9G+b2Scq7GR0uatGrPgV5dVxrfqB659p
 Ztbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789561; x=1782394361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6g7xG8JM8Ar3LWTKrhqIL4fcIiBSyebqoYxlucTcBPE=;
 b=rgkVTKMGqzoi4VgzkeVcSYvpbDTPGqKltDrSQoNOPOrdedFQVPjZdzno/SxAhc7ugN
 MpkPxO5odu+NxNXOdsMviO82uu/Eompms1kF+Qfzi/2WRtzzUky9p2Gb/MXHCNWSnWrq
 mqTGzaZnuvoW8NuDjyLFEvlKi8ZtockXpa9Jg2FVlv99ioGZasVoX8CgyhZTwYPc5M0e
 Ch4N5WynkdmdK3jbPaVrF9uRldUqF/dQR5/Vkde5SvKnv3ewYLW3wiCVv6cySV17OtJr
 lvkCy4k4bqngpFxki0MuBVcK4pgoNnhcn6W+8IRju1DlXcoPKbVvIjWOxvwNF86ysURd
 sLiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gR8Mwu2+Tjk7fopTRCspSuLXXtzW6U0EPuq/PiRbELpIwJAD00tWH2laikNYzTzY+KL3/9FOZ7C3L@nongnu.org
X-Gm-Message-State: AOJu0YyE7S5KujFp2A428zUOjZnix7pA61ktHWkwMdIXP7qhaJAYyQRE
 SiFGYU9TGANKfPnYb6ZMdv0gEiRtYJBeEw5N70UnDIDVtPd7HtHEO8qkklmesNWcexML+Op4DtO
 g4xYWpesNmwFYKDZMIyCe20JahhbZky9P3W34suwSZHUoAHHfWq4qcoy0
X-Gm-Gg: AfdE7cm3kP3Z2rARQL60ncq62vRsvVhg/05j2axGzX3hdoEW/dSM3ekC07hCuz9dIY4
 CZWjZ827tdvjD74xW97FgeVcjS2Z+KKCQkj+dMLCZMkP9+Yh4LAJEYDzpzdJ7DNoULGFo9ylAaY
 LKNvEl5/krkjD2pwuuF1ETKcxXQPk6yLL6UTqwaPfJXVzFAVmhYLAwFfSZDRhbrdJrylO2kLn1g
 TuxbtENMWH3ywuXertpz7c6tkMX8NJutF92FZBiT3gZR2lLbzSromkjX6DqGsNJfu0kAiMD4l5r
 KSvOF2VF5WSVZlWy06yq+KeBadMPg+gM8DtLw8Mr6eiUdWF9tZeXzZdWxxH+dpeTs1czGYYlHQn
 Vys9w/JsI1ZkVBON36Ms3CQnImV8ci5Yf
X-Received: by 2002:a05:600c:3f07:b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-4923341f614mr138041255e9.18.1781789561178; 
 Thu, 18 Jun 2026 06:32:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3f07:b0:490:bc46:1a58 with SMTP id
 5b1f17b1804b1-4923341f614mr138040635e9.18.1781789560633; 
 Thu, 18 Jun 2026 06:32:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2ce361sm59626505f8f.31.2026.06.18.06.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:32:37 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:32:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] hw/acpi: correct field sequence in SPCR table
Message-ID: <20260618093143-mutt-send-email-mst@kernel.org>
References: <20260618124020.640794-1-heinrich.schuchardt@canonical.com>
 <20260618084645-mutt-send-email-mst@kernel.org>
 <5032057d-278c-4afa-987a-a25335dff50a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5032057d-278c-4afa-987a-a25335dff50a@canonical.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 18, 2026 at 03:26:40PM +0200, Heinrich Schuchardt wrote:
> On 6/18/26 14:48, Michael S. Tsirkin wrote:
> > On Thu, Jun 18, 2026 at 02:40:20PM +0200, Heinrich Schuchardt wrote:
> > > On LoongArch and RISC-V invalid SPCR tables are created:
> > > 
> > > Terminal Type : 00
> > > Language : 03
> > > 
> > > The correct values are:
> > > 
> > > Terminal Type : 03
> > > Language : 00
> > > 
> > > This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> > > SPCR creation to common location") that swapped the fields.
> > > 
> > > See the specification of the table in
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table
> > > 
> > > This page shows version 1.10. But the sequence of the fields was not changed
> > > since version 1.0.
> > > 
> > > Our LoongArch and ARM code uses version 1.07 of the specification.
> > > Our RISC-V code uses version 1.10 of the specification.
> > > 
> > > Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
> > > Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> > > Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > 
> > Thanks for the patch!
> > Yet something to improve:
> > 
> > That's not the way to submit expected table changes -
> > it would prevent backporting and rebasing.
> > 
> > Pls follow instructions in ./tests/qtest/bios-tables-test.c
> > 
> > Thanks!
> 
> I tried it. But it does not work:
> 
> After running all tests successfully with make check the script
> /tests/data/acpi/rebuild-expected-aml.sh
> told me that I should run make check.
> 
> That did not make sense to me.
> 
> I there a specific configuration needed to let make check write what
> rebuild-expected-aml.sh is looking for?
> 
> I was using
> 
>   ./configure --prefix=/usr/local --static
> --target-list="riscv64-linux-user"
> 
> and
> 
>   ./configure --prefix=/usr/local --static
> --target-list="loongarch64-linux-user"
> 
> Best regards
> 
> Heinrich


Because linux-user does not support these tests?
Drop the target list limitation and it will work.

> > 
> > > ---
> > > v3:
> > > 	update test data
> > > v2:
> > > 	Mention the different specification versions used by our code
> > > 	https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinrich.schuchardt@canonical.com/
> > > v1:
> > > 	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
> > > ---
> > >   hw/acpi/aml-build.c                   |   4 ++--
> > >   tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
> > >   tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
> > >   3 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 9b3cdd3781..990abc64cd 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
> > >       build_append_int_noprefix(table_data, f->stop_bits, 1);
> > >       /* Flow Control */
> > >       build_append_int_noprefix(table_data, f->flow_control, 1);
> > > -    /* Language */
> > > -    build_append_int_noprefix(table_data, f->language, 1);
> > >       /* Terminal Type */
> > >       build_append_int_noprefix(table_data, f->terminal_type, 1);
> > > +    /* Language */
> > > +    build_append_int_noprefix(table_data, f->language, 1);
> > >       /* PCI Device ID  */
> > >       build_append_int_noprefix(table_data, f->pci_device_id, 2);
> > >       /* PCI Vendor ID */
> > > diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
> > > index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
> > > GIT binary patch
> > > delta 23
> > > TcmWFtm|!Qw%<vxw7?1z}S|J61
> > > 
> > > delta 23
> > > TcmWFtm|!Qw!2BNw7?1z}S{?;}
> > > 
> > > diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> > > index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
> > > GIT binary patch
> > > delta 10
> > > Rcma!wnqbGo%rMbG3IGpM0&@TW
> > > 
> > > delta 10
> > > Rcma!wnqbGoz&z1G3IGpJ0&@TW
> > > 
> > > -- 
> > > 2.53.0
> > 



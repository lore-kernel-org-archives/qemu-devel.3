Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC7DC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncuq-0005jt-Cp; Thu, 27 Feb 2025 07:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncup-0005eJ-1f
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncum-0005yR-6d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740658973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0drJSCTbWN/ba75bqW+aniDK5NCt33vV1jPzY6YlkA=;
 b=hk++juhsh/jlFscuZb2g7ibx0wuDNw0x8WS39Fi+gXAiASkLgBieuyl0muBKEg5H+NLg5u
 O7Fo0qQHkWaCWEWJ0y63yrqpQjuEVlVNwQWVDF2d5I4iIVyQFqp2FzLxUz8HWJ2honHGFL
 GdspqDNeC5LcuOUPdXTqf71/LLM959Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-5yabGHGkMUWlmqFvYx8_pg-1; Thu, 27 Feb 2025 07:22:52 -0500
X-MC-Unique: 5yabGHGkMUWlmqFvYx8_pg-1
X-Mimecast-MFC-AGG-ID: 5yabGHGkMUWlmqFvYx8_pg_1740658971
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399c32efb4so8506475e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658971; x=1741263771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0drJSCTbWN/ba75bqW+aniDK5NCt33vV1jPzY6YlkA=;
 b=oQIo6ZjC0LdELqGAuemltgGuRysQCwITXWKdSbrLTtJPObuC8N8J08a0zX5P577wHG
 c3Q1SbHz7HyEquOqdW6milKLNUEcsOJxH/Zs9EFNo3x1Cd68KjkmrW40C7vVE5GGRQDh
 eF1mG0+2Wm64FApMeOUFiQq4TCIEdAV5g9fdR7gC7ZjdC9XmZmTCRxZQVjKU6ry16o+x
 9622l2zDpgUhMIYsPHSTpXOKcOLEGA9GRxXN4krnEa0o7Zo145BYbF24EipHG18li5k5
 OhfZ+SmsAZON5g/3OX70kD16gcVD61yqs5LXVd5jc5JcvYrmw6XKQr/z1mEgZ3d044vb
 rGAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWobnTanWGM6zdRvXNTYwZ0Eou5YKobKq6aDA4It7n5986tdeajczOxeqHRJXGmLWBAlkH1q5UOiPLg@nongnu.org
X-Gm-Message-State: AOJu0YwbCdRsAqnMvz0XLIHc3nmvUaD8c4iXJJurjlSyZvogZPQMpgQV
 Tv4SDYrnyb7qbOIkdGoLcynwdMk8OFWpMw2byKQ5qc+f8hovj2hJBRgGLQBUTenyQLQA8gqh3kb
 87FWeL/WgnLNA4AyMKshwsMtpy7cOdTpszIfi7Vm6Bo38L8pTkrlf
X-Gm-Gg: ASbGncuQcj61xJ6BT2DOywYXkYUGCXbYTJsKn8dQ/iqliF85TCESY1wuzXtcwaZ4368
 23oXTYJAhURIGHvMvC7U0sZQxVVLYZAEpTq7OpB2SrbVBOTnga94vPmTMwXgcOqUBBhcgvisz7t
 NSvc8+0LrqDPOoagdjT6RKMZPWBmAm9AIVCjl78+YnuxwLsnZLzhOjqy302X8O020RtuzOw/9kA
 roJNAega4rl1aql4B+hXiKAa/7wcjNFNi6vRMt7iHtlQrnAT5NtSxG4eC9tKrCm97FjKfeCbJsR
 FGIDySpitUI02TYtsojp6l1IdpO3bwZEk4QBBIYXDiw4OG8uS/S9v4ZRviVKfoU=
X-Received: by 2002:a05:600c:1c23:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-43b04dc361amr26051785e9.14.1740658970837; 
 Thu, 27 Feb 2025 04:22:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ83M4/KsXSQHu6pDlNDVcuk6Z5Ml2/r9st1BbY0/wCxIRxtiVX5idFzmIaNDSfkyk0vvAlA==
X-Received: by 2002:a05:600c:1c23:b0:439:892c:dfd0 with SMTP id
 5b1f17b1804b1-43b04dc361amr26051585e9.14.1740658970475; 
 Thu, 27 Feb 2025 04:22:50 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f839asm21290255e9.2.2025.02.27.04.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:22:49 -0800 (PST)
Date: Thu, 27 Feb 2025 13:22:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250227132248.17c6754b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250227124538.7a2191e0@foz.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
 <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
 <20250227124538.7a2191e0@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Feb 2025 12:45:38 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 26 Feb 2025 15:37:14 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 15:35:10 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> 
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 3ac8f8e17861..8ab8d11b6536 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> > >      build_dbg2(tables_blob, tables->linker, vms);
> > >  
> > >      if (vms->ras) {
> > > -        acpi_add_table(table_offsets, tables_blob);
> > > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> > > -                        vms->oem_id, vms->oem_table_id);
> > > +        AcpiGedState *acpi_ged_state;
> > > +        AcpiGhesState *ags;
> > > +
> > > +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,    
> >                             ^^^ will explode if object_resolve_path_type() returns NULL  
> > > +                                                       NULL));    
> > 
> > it's also expensive load-wise.
> > You have access to vms with ged pointer here, use that
> > (search for 'acpi_ged_state = ACPI_GED' example)  
> 
> Ok, but the state binding on ghes were designed to use ACPI_GED. I moved
> the code that it is using ACPI_GED() to the beginning of v5 series,
> just after the HEST table test addition.
> 
> With that, ACPI_GED() is now used only on two places inside ghes:
> 
> - at virt_acpi_build(), during VM initialization;

ACPI_GED() is not expensive, what I'm referring to is
  object_resolve_path_type()

given it's a new code and virt_acpi_build() has direct access
to ged pointer, there is no excuse to use object_resolve_path_type().

all you have to do here is:

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e6328af5d2..040d875d4e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -949,8 +949,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
         AcpiGedState *acpi_ged_state;
         AcpiGhesState *ags;
 
-        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
+        acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
             acpi_add_table(table_offsets, tables_blob);


> - at acpi_ghes_get_state().

this one is different, it doesn't have access to ged so it
has to look up for it.

> 
> If you want to replace it by some other solution, IMO we should do
> it on some separate series, as this is not related to neither error
> injection nor with offset calculation to get read ack address. 
> 
> > > +        if (acpi_ged_state) {    
> > 
> >                 hence, this check is not really needed,
> >                 we have to have GED at this point or abort
> > 
> >                 earlier code that instantiates GED should take care of
> >                 cleanly exiting if it failed to create GED so we would never get
> >                 to missing GED here  
> 
> I dropped this check on v5.
> 
> Thanks,
> Mauro
> 



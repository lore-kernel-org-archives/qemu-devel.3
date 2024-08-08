Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794A5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc41v-0008Qp-QO; Thu, 08 Aug 2024 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sc41t-0008IG-QM
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sc41s-0004ti-0Q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723126931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWiq/R1qfDvotqZucy6GvkqQ+EVl6vxLjsehT82Sjwk=;
 b=V5793x0+Hynpq/EJXiLfpNOn4SfruRdz/EtETVEi4Rvmsrs0TX/orT4vKpbiHm0MrzlgpF
 r8WvnqdjDj+oe4M8XnVE9PHGBn7LcfuUZmFpfC7PBHL9W6MlEtHU5eK+bCvOiItcv6EyO1
 jaFVckq/8CmKN2qblSZ3nSUZgtoZL/Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-3GIGwS-JNIOMV7ArHsCvZw-1; Thu, 08 Aug 2024 10:22:08 -0400
X-MC-Unique: 3GIGwS-JNIOMV7ArHsCvZw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3688010b3bfso761199f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723126928; x=1723731728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eWiq/R1qfDvotqZucy6GvkqQ+EVl6vxLjsehT82Sjwk=;
 b=GSh9oGEMdmqqEaUH7YMfQo/8dtToq2so+0fhpTr29gDBarEXI6oNh2IW7Q2/VQPVYP
 6llcJ4JuMsARG/x/QAeOyfgSi43C+aCIzEMHONHSkK/bER03EyjrNgmTdysOZ3YuPrMi
 P6AMwSNX0a6XfJ3yD0jCRP67AySENDR6VaEQooGjDWI+5SxRygLp9/+iDC7n/KTtMzZY
 ih4/d7ED0ygG6D7k/hjFvVSp8ArARVvc4Gzl4pJ90r+9xvi2iZyhKx78JYTEANadoMYQ
 aE9POvaHcHJ3XN6Jh6qBK8gHitR3JO3nTRaUsORLMut+ALySsjyn3r96c8QmVO9a09/7
 qe9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT5zUtq6E8Lor2CMlYYt32Pw1+8ZXn1oexftQiCLzilxm5WA3zZomXgNkR/cEYVr9e54tGdUGefgbTx0Dyn7gsciQrKp0=
X-Gm-Message-State: AOJu0YwoLj+AESioJ0RnsKUITZB1syAsfG462E5Rn41BmWP1rzzA65fh
 4vjGdlyz7WoV0gp0uZOpflb5RN1SUxWCUWgmY3IqZrd6QS1S9Yv8D/RWniQV/ku57lV3mKX++fQ
 j7CfF4dGr0qPbGqVT/wW0tUK7TpdkQOSKjSsPzXgFZRmeFMeqVJZV
X-Received: by 2002:adf:979e:0:b0:36b:a40c:5c09 with SMTP id
 ffacd0b85a97d-36d27591d39mr1599406f8f.58.1723126927518; 
 Thu, 08 Aug 2024 07:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo0de8q7z1Eh0G8+bm2AJ2Ysdfe9LC2CbGZ+DN71+L8yiJUWpRbi57ySyHOUuoDJl7shFiVg==
X-Received: by 2002:adf:979e:0:b0:36b:a40c:5c09 with SMTP id
 ffacd0b85a97d-36d27591d39mr1599371f8f.58.1723126926960; 
 Thu, 08 Aug 2024 07:22:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d2718bfc4sm2072056f8f.57.2024.08.08.07.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:22:06 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:22:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Markus Armbruster <armbru@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240808162205.3a85efb6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808161141.5ffe730e@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
 <87v80b1jqe.fsf@pond.sub.org> <20240808161141.5ffe730e@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 8 Aug 2024 16:11:41 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 08 Aug 2024 10:50:33 +0200
> Markus Armbruster <armbru@redhat.com> escreveu:
> 
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:  
> 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 98eddf7ae155..655edcb6688c 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> > >  F: include/hw/acpi/ghes.h
> > >  F: docs/specs/acpi_hest_ghes.rst
> > >  
> > > +ACPI/HEST/GHES/ARM processor CPER
> > > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +S: Maintained
> > > +F: hw/arm/ghes_cper.c
> > > +F: hw/acpi/ghes_cper_stub.c
> > > +F: qapi/ghes-cper.json
> > > +    
> > 
> > Here's the reason for creating a new QAPI module instead of adding to
> > existing module acpi.json: different maintainers.
> > 
> > Hypothetical question: if we didn't care for that, would this go into
> > qapi/acpi.json?  
> 
> Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
> to report hardware errors. Such hardware errors are typically handled by 
> the host OS, so quest doesn't need to be aware of that[1].
> 
> So, IMO the best would be to keep APEI/HEST/GHES in a separate file.
> 
> [1] still, I can foresee some scenarios were passing some errors to the
>     guest could make sense.
> 
> > 
> > If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
> > instead?  
> 
> Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
> from my side.

if we going to keep it generic, acpi-hest would do

> 
> >   
> > >  ppc4xx
> > >  L: qemu-ppc@nongnu.org
> > >  S: Orphan    
> > 
> > [...]
> >   
> > > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> > > new file mode 100644
> > > index 000000000000..3cc4f9f2aaa9
> > > --- /dev/null
> > > +++ b/qapi/ghes-cper.json
> > > @@ -0,0 +1,55 @@
> > > +# -*- Mode: Python -*-
> > > +# vim: filetype=python
> > > +
> > > +##
> > > +# = GHESv2 CPER Error Injection
> > > +#
> > > +# These are defined at
> > > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> > > +# (GHESv2 - Type 10)
> > > +##    
> > 
> > Feels a bit terse.  These what?
> > 
> > The reference could be clearer: "defined in the ACPI Specification 6.2,
> > section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
> > be nice, if it's stable.  
> 
> I can add a link, but only newer ACPI versions are hosted in html format
> (e. g. only versions 6.4 and 6.5 are available as html at uefi.org).

some years earlier it could be said 'stable link' about acpi spec hosted
elsewhere. Not the case anymore after umbrella change.

spec name, rev, chapter worked fine for acpi code (it's easy to find wherever spec is hosted).
Probably the same would work for QAPI, I'm not QAPI maintainer though,
so preffered approach here is absolutely up to you.

> 
> Can I place something like:
> 
> 	Defined since ACPI Specification 6.2,
> 	section 18.3.2.8 Generic Hardware Error Source version 2. See:
> 
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10
> 
> e. g. having the link pointing to ACPI 6.4 or 6.5, instead of 6.2?
> 
> >   # @raw-data: payload of the CPER encoded in base64
> > 
> > Have you considered naming this @payload instead?  
> 
> Works for me.
> 
> Thanks,
> Mauro
> 



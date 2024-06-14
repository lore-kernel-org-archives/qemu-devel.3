Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0126AC27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI4ci-0002CO-Oy; Fri, 14 Jun 2024 06:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sI4ch-0002Bj-VP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sI4cf-0006DL-Rr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718362651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fN7WzfpET8/k+tVrmxHvGsh2LVZtfm7YDEkeLlFW7/s=;
 b=QLRmdusnFR3J3P7/fm0vBxhy7j0nVq+g37MfI0QbNvsjPshz9cDqWcPmTHggweINP0tHTl
 4E+OJN43PNnsLTtyQnavIhJwmejDUzt62/001wfMVq9La2PKlYc8sWXNBKIPmPzGak5Qyl
 +Ek9Db2ZVjVbEGS/jaGKTGA6Rp4AfTE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6LF_8vw-NRKSn-XRu67ivA-1; Fri, 14 Jun 2024 06:57:30 -0400
X-MC-Unique: 6LF_8vw-NRKSn-XRu67ivA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4217f941ca8so14046995e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 03:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718362649; x=1718967449;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fN7WzfpET8/k+tVrmxHvGsh2LVZtfm7YDEkeLlFW7/s=;
 b=cWo6VbZwq7jqhyHUR3iyZnjto0tnAnkFu+sKKfrhTZPvv23V9otedqyzjAMCpxQi4y
 8bJHSR/7M/Mo9sCXqH5CAXVSeP/w8cpHQnDYM7RBdgQSgLMJGyGuo7B8xgNgHq8lKi94
 E3nY1GazF1dK011NIpjOcKQVly57lHTqjr0bTDGGfvzu4sT/eZevYSDlFbxjm1eEUZtd
 3npax4ipH3uHpRYjjnDBxL0MV7BKuSwfypy6xXMIO1OBVxE0BUbhPllH1bp4v7Edd49L
 vRR1yk+JKoxerWVYnZYeVrLzk+n02dIiRiW998gHcBU7KSECCRw/N3Cn61TZDS/n5poa
 2njA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWErIi7z2MDbwufkoqaZDLm9u6bKTyqrOvGF9lKzqILvlymiKdN/IBq6qcd10IVKjy/T5ErRtX0n2Jfso9DeXAEL60kQzY=
X-Gm-Message-State: AOJu0Yy9d18wr4F9CFRzW0mzQK6rHa4ZqRT+mxFRZDpdibLP1T0vwKxD
 TbeDiKxKy5qMZ5HTJKICvscCajLXc51GQtIl2mt+6n/P7WHrynYwxl6Clv5yVFMicWumJBtVzRy
 qReOM/VWxBXct/foRTihF/oTALjr4IRWXXXXPYcFuMY8+Kg3q+IPF
X-Received: by 2002:a05:600c:4206:b0:422:123f:4b15 with SMTP id
 5b1f17b1804b1-42304859ac3mr18967625e9.37.1718362649232; 
 Fri, 14 Jun 2024 03:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh2zbOD2OPNaUR8T5QPRlt0WZVOKSQ2zPkrdXRzfccin7dF1Bb80XKafBtiXS+LPnfFW+CtQ==
X-Received: by 2002:a05:600c:4206:b0:422:123f:4b15 with SMTP id
 5b1f17b1804b1-42304859ac3mr18967445e9.37.1718362648774; 
 Fri, 14 Jun 2024 03:57:28 -0700 (PDT)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286eefa07sm94554795e9.8.2024.06.14.03.57.28
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 14 Jun 2024 03:57:28 -0700 (PDT)
Date: Fri, 14 Jun 2024 12:57:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240614125725.730f8914@imammedo-mac>
In-Reply-To: <20240606184716.00000708@Huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
 <20240606160653.27226def@imammedo.users.ipa.redhat.com>
 <20240606184716.00000708@Huawei.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 6 Jun 2024 18:47:16 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 6 Jun 2024 16:06:53 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 5 Jun 2024 19:04:55 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > Treating the HID as an integer caused it to get bit reversed
> > > on big endian hosts running little endian guests.  Treat it
> > > as a character array instead.
> > > 
> > > Fixes hw/acpi: Generic Port Affinity Structure Support
> > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > Richard ran the version posted in the thread on an s390 instance.
> > > Thanks for the help!
> > > 
> > > Difference from version in thread:
> > > - Instantiate i in the for loop.
> > > 
> > > Sending out now so Michael can decide whether to fold this in, or
> > > drop the GP series for now from his pull request (in which case
> > > I'll do an updated version with this and Markus' docs feedback
> > > folded in.)
> > > 
> > > ---
> > >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> > >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > > index 1a899af30f..5baefda33a 100644
> > > --- a/include/hw/acpi/acpi_generic_initiator.h
> > > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> > >              uint16_t bdf;
> > >          };
> > >          struct {
> > > -            uint64_t hid;
> > > +            char hid[8];
> > >              uint32_t uid;
> > >          };
> > >      };  
> > 
> > not sure on top of what this patch applies but I have some generic comments wrt it
> 
> https://lore.kernel.org/qemu-devel/20240524100507.32106-1-Jonathan.Cameron@huawei.com/
> 
> Comments are all on elements of the existing upstream code, but I'm touching it
> anyway so will look at making the improvements you suggest as new precursors
> to v3 given we are going around again anyway.
> 
> > 
> > why PCIDeviceHandle is in header file? is there plan for it
> > being used outside of acpi_generic_initiator.c?
> 
> I'll add a precursor patch to my series that moves
> it and anything else that should be more local.  May well move
> to being local in aml_build.c given your later comments with the
> various fields passed in as parameters.
> 
> > 
> > 
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 78b80dcf08..f064753b67 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > >          build_append_int_noprefix(table_data, 0, 12);
> > >      } else {
> > >          /* Device Handle - ACPI */
> > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > +        }
> > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > >          build_append_int_noprefix(table_data, 0, 4);  
> > 
> > instead of open codding structure
> > 
> > it might be better to introduce helper in aml_build.c
> > something like 
> >   /* proper reference to spec as we do for other ACPI primitives */
> >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> >       assert(strlen(hid) ...
> >       for() {
> >             build_append_byte()
> >       }          
> >       ...
> > 
> > the same applies to "Device Handle - PCI" structure
> 
> I'll look at moving that stuff and the affinity structure creation
> code themselves in there. I think they ended up in this file because
> of the other infrastructure needed to create these nodes and it
> will have felt natural to keep this together.
> 
> Putting it in aml_build.c will put it with similar code though
> which makes sense to me.

the point of moving handle packing to aml-build.c,
is to isolate primitives that likely could be reused later on elsewhere
and hide little endiannes from API user.
So shuch errors as you are fixing wouldn't be easy to introduce
(as long as API does it right)


Also this API probably should take not packed BDF, i.e. something like this:
    build_append_srat_pci_device_handle(GArray *table_data, bus, dev, func)

Or a packed BDF as you suggest in the later email, but then API function wold have
to 'decode' that before putting numbers into table, which complicates things
and likely would pull in PCI deps to unpack BDF, which I'd rather avoid in
generic aml-build.c

> 
> > 
> > Also get rid of PCI deps in acpi_generic_initiator.c 
> > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > hw/acpi/pci.c
> 
> Today it's used only for PCI devices, but that's partly an artifact
> of how we get to the root complex via the bus below it.
> 
> Spec wise, it's just as applicable to platform devices etc, but maybe
> we can move it to pci.c for now and move it out again if it gains other
> users. Or leave it in acpi_generic_initiator.c but have all the aml
> stuff in aml_build.c as you suggest. 
> 
> > file if it has to access PCI code/structures directly
> > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)
> 
> Maybe. I'll see what I can come up with.  This feels involved
> however so I'm more doubtful about this as a precursor.
> 
> > 
> > btw:
> > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > it composes only one initiator entry.
> 
> I'll look at tidying up all the relevant naming.
> 
> Jonathan
> 
> > 
> > >      }  
> > 
> > 
> 



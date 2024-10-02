Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D93CF6D38
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw1Yn-0005sK-7J; Wed, 02 Oct 2024 11:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw1Yl-0005s2-CF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw1Yj-0008F2-Ny
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727883996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vP9GlQIfYORSZI5Is17sfvk9DUDB6lv1VsEsk5XjhH4=;
 b=P8bC1HNz6CfYs0VEnjDIH9S2napRg9N5Q/nJGqN51ixQREVL+L9wWiLpkHC3CqcYXZSOlQ
 NP9krqeksXmSQfiETCrOk3eslRaXVF4tOjbavbTeDNdtGxCrWOgApcGmL07WCXgGPVR8v7
 hnnNRXqzfqcmcl0lSoMXhPsSpPc68l0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-nZoBz7QFM7Kpu9TB2MX_SQ-1; Wed, 02 Oct 2024 11:46:35 -0400
X-MC-Unique: nZoBz7QFM7Kpu9TB2MX_SQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-458432fe9baso86454171cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727883995; x=1728488795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vP9GlQIfYORSZI5Is17sfvk9DUDB6lv1VsEsk5XjhH4=;
 b=CmTnvajB/OUDSTbrt+TnAtVI6hdOlpMoSSfIaboIQOaPrIBQQLPPxn1iHW8vT4Bid8
 kTFKgYXTMnIA3o5te2jzEy8ilsDpM23VWUO8YCjOIqkKN6dnp6Sn7NK1jzcFyYx0QKfM
 V9/YsBZA0KHooEmMW3B1ybcX5kfTZIKPVRJ/Cw8c17F9j7G/6qpfX8CvUMkfPW6uMWw0
 LX553iQhM9UydcBK1B/2Rol7bSS6mY/CoZCEnasJm649FxVDss/qNNgWiZ82QOZqE+l6
 pESEQ9zul1LrcP9T2pBV7r4rGLFHAzBBrLDXS9ZGGacjmhSvQaE1E2SALx8GiMnvtxbT
 6Z2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaKzZem5E7l3BPBuEF9+k7Pzd6rVl8pBlreVYlWA6jKjMEJyo9olgNHx//HefY0+OzRA2yKrdLObV9@nongnu.org
X-Gm-Message-State: AOJu0Yy3HbhMDy8wPFPFnbfU0wDwXMmFp7n5ghSRjCEi4rQARb+BIkkp
 1cN7Dpc4iMI8ZrPpr4SVEEKpHJC4yrJjk2mow85utrdwvISpwlREJmosbXZbqPaMB2x3fGjOsOC
 N8iNn3hFcEtWMUO6cKFkowfVV9Oq6jX50ffg/779rw3fKKAWjJlsM
X-Received: by 2002:a05:622a:5c7:b0:45d:797b:b780 with SMTP id
 d75a77b69052e-45d80492e13mr44140861cf.11.1727883994779; 
 Wed, 02 Oct 2024 08:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdgiO0qZWdEv0SRcqJWln00zHqXFqFkLhb/OqdhhQaGuGxpQZhZaPZDw7D+1YP6n9KNRiDEw==
X-Received: by 2002:a05:622a:5c7:b0:45d:797b:b780 with SMTP id
 d75a77b69052e-45d80492e13mr44140591cf.11.1727883994377; 
 Wed, 02 Oct 2024 08:46:34 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f3394aasm57106251cf.64.2024.10.02.08.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:46:33 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:46:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 3/5] acpi/generic_event_device: Update GHES migration
 to cover hest addr
Message-ID: <Zv1q141LZt59SDSM@x1n>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <d29cdf2bbb67c660142841c2d854db280c18e5e0.1727782588.git.mchehab+huawei@kernel.org>
 <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002171543.703ab6e1@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 02, 2024 at 05:15:43PM +0200, Igor Mammedov wrote:
> On Tue,  1 Oct 2024 13:42:48 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The GHES migration logic at GED should now support HEST table
> > location too.
> > 
> > Increase migration version and change needed to check for both
> > ghes_addr_le and hest_addr_le.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> other than minor issues below, lgtm
> 
> > ---
> >  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index d4dbfb45e181..49ca1fb8e84a 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -369,6 +369,34 @@ static const VMStateDescription vmstate_ghes_state = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_hest = {
> > +    .name = "acpi-ghes",
> duplicate name for section, we use that already for hw_error address
> I don't know ramification of (CCIng Peter)

Currently the existing vmstate_ghes is embeded inside vmstate_ghes_state,
so maybe.. it's ok, as I remember QEMU only registers top level vmsds (via
vmstate_register_with_alias_id()).

We do have a sanity check in savevm_state_handler_insert() making sure no
duplicated entry will co-exist since commit caa91b3c44cd.

> 
> Perhaps
> s/ghes/hest/

Said that, perhaps it'll still be nice to try avoiding same names indeed if
possible, at least it could make debugging / reading easier sometimes.

> 
> 
> 
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static bool hest_needed(void *opaque)
> > +{
> > +    AcpiGedState *s = opaque;
> > +    return s->ghes_state.hest_addr_le;
> > +}
> > +
> > +static const VMStateDescription vmstate_hest_state = {
> > +    .name = "acpi-ged/ghes",
> 
> ditto
> 
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = hest_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> > +                       vmstate_hest, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_acpi_ged = {
> >      .name = "acpi-ged",
> >      .version_id = 1,
> > @@ -380,6 +408,7 @@ static const VMStateDescription vmstate_acpi_ged = {
> >      .subsections = (const VMStateDescription * const []) {
> >          &vmstate_memhp_state,
> >          &vmstate_ghes_state,
> > +        &vmstate_hest_state,
> >          NULL
> >      }
> >  };
> 

-- 
Peter Xu



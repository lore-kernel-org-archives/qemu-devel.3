Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E41CC28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 04:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tykfb-0001wj-Pe; Sun, 30 Mar 2025 00:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tykfZ-0001wP-T1
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 00:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tykfW-0003bt-C0
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 00:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743310388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpnGP6fvvX8yKLgmSlci0dF4doCtza7Dil0BLo0FvHk=;
 b=a0FXQMZ1pOHBMeWYlWHDnkQb99s13LVL+XKQKTqcGBFw+wXm4ufTAjusc7DJOabSci/j2S
 q9hjSiYP91ThEFrzCTjXZvjrbBDwFrMqCs3LVy+Uj0huIRfAww3kx4vfX/YGzWC7cIo7Bt
 o5QiqOwsEapAXeghSNJ4qmW6dBXaKso=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-f5c9dpHuMtW-HaIlilSlPA-1; Sun, 30 Mar 2025 00:53:05 -0400
X-MC-Unique: f5c9dpHuMtW-HaIlilSlPA-1
X-Mimecast-MFC-AGG-ID: f5c9dpHuMtW-HaIlilSlPA_1743310384
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac3d175fe71so222158066b.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 21:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743310384; x=1743915184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XpnGP6fvvX8yKLgmSlci0dF4doCtza7Dil0BLo0FvHk=;
 b=A3ZhY/rmHwddEgWeirTQvQWHYCdT+JGNi4Run4uKGknFSGDQ3a/wep1shmg+ACp08v
 GHrSHUfq3uUMeFdUF3LB6g9u5BxeW7QprgApW9p36YnoxBu7DeljATNKnZ7hwnafjjIA
 oSpSuiwu0KmUy+PQpIhqjdn+4DoiDsvmEW8RO2c4mKNLxYa1sCt6wUJVYIVxenEOhdnq
 XxvECANHCP4rg1O/9FfGGE+GokgIdXeKsND5cjMrEXakMwVou2p/SVTsBCxxckRQ1KAG
 70TdXPMFk3use2v5u+/YwrXd4CB82bhdTig0JhUksgf2TkOnFke8zDkyZmgsG4ElL/Er
 nLrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCIzt+g5sWg7lhSxTp/e0lV+m7Qw3BAjEzsXsWs9/p94bU39hSuYXuxOGCt5hyfOyKyqSGGAiXnmei@nongnu.org
X-Gm-Message-State: AOJu0YwI44EKor8W9XnLorM+KWTVLXygNZTKvU1aoKdWXtI3aDBrhxId
 4aXpLIWDYrALToqzGyP70uryWkWpbzh9yOtFXx9LbKxj0n9XYOa3Ck3xIdGd2Kxh3FNSd9sTiVf
 LhQ8Yt/sqSrdgJLah/XC/ZO42Tf1JwiwRYPZssLRKGaMm6vDioenLTjso1sZx/fE/8jaxcwhDS6
 gtEzFB0x8jewtNQIWbl4hxNd1i+9I=
X-Gm-Gg: ASbGncteV5IJ0jPTqY7uST3TiwhbWWET+qWj6vdm47woRp4Te7lsrbwlZH2VWtWy+dG
 A2HnikP4x1fr1NSJpEc0x+WmvZ5NrMF3rgUMadnBATJ/l+oufdMPJmt8XFU6xI47+KveO6KWl9g
 ==
X-Received: by 2002:a17:907:6092:b0:abf:6cc9:7ef5 with SMTP id
 a640c23a62f3a-ac738bff3a6mr412465566b.47.1743310384206; 
 Sat, 29 Mar 2025 21:53:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMVR0vMCDrelOd2P6ADuB4DvJNv4TjeKeOLuHITeDKynfxZtoVLVax4Why7HV/s9ijdYFB+q4/cFCHBgx4R2Q=
X-Received: by 2002:a17:907:6092:b0:abf:6cc9:7ef5 with SMTP id
 a640c23a62f3a-ac738bff3a6mr412463466b.47.1743310383836; Sat, 29 Mar 2025
 21:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250116140315.2455143-1-dwmw2@infradead.org>
 <20250116140315.2455143-4-dwmw2@infradead.org>
 <CAFEAcA9CKgumt-6V_EjCipm1DYdYw5GETNoSbUKeRsGEVhNv_Q@mail.gmail.com>
 <2498d8fa34f6503879f99f671b58055bb6a63fdc.camel@infradead.org>
 <CAFEAcA9=Z11c3LkSqsODQ40EutN0KSvywxFAciFfj=OpvytuHw@mail.gmail.com>
 <9097119d6e4c6a1f0a9c8fd3516b02008a1d8ffd.camel@infradead.org>
 <3d1b617f001b4ee989101748d120992c81a63a63.camel@infradead.org>
 <87d71fa37d3dbf0a4f03f1c29a56d9d6726f98df.camel@infradead.org>
In-Reply-To: <87d71fa37d3dbf0a4f03f1c29a56d9d6726f98df.camel@infradead.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 30 Mar 2025 10:22:52 +0530
X-Gm-Features: AQ5f1JorJNZQbqYX_i6Meb0GtHT_x99zfEbInQvCUCU-tzHrQwRvowwzTeBSHLE
Message-ID: <CAK3XEhPvS7dfHcnjEF-UhfB7L82saF9ax5rsrCzLkqXZm7Szmw@mail.gmail.com>
Subject: Re: [PATCH] hw/acpi: Remove legacy reset handling from vmclock
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cornelia Huck <cohuck@redhat.com>, Peter Hilber <quic_philber@quicinc.com>, 
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, paul <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Mar 29, 2025 at 1:43=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2025-02-07 at 14:34 +0000, David Woodhouse wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > The vmclock device only has a reset method in order to plug its memory
> > region into the system memory. It was originally done this way in order
> > to defer the memory_region_add_subregion_overlap() from vmclock_realize=
(),
> > but that doesn't seem to be necessary (any longer?).
> >
> > Still, allowing the platform code to do this is cleaner because it lets
> > the address be specified by the platform, easing the port to Arm and
> > other platforms in future. And the platform has to be involved anyway
> > because of the need to include the device in the ACPI tables (or DT).
> >
> > So drop the reset method and provide a vmclock_mmio_map() function
> > instead, called from pc_machine_done().
> >
> > Shift the ACPI table build into #ifdef CONFIG_ACPI_VMCLOCK too while
> > we're at it, since it looks like that wouldn't have built when vmclock
> > wasn't enabled.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Found this lurking in my working tree when I came to do something else.
> Was it OK?

I have tagged this for review next in my review queue.

>



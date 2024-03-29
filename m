Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80191C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9jK-0000vA-Rq; Fri, 29 Mar 2024 06:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rq9jI-0000uI-R5
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rq9jH-0000sU-5B
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711709097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+QonRjId6HaDu0WZf2b2eQJeKZ6u+4nYkIOvf5CgEc=;
 b=dKoME7MXzTRS/37GvY+AKCpw3d/EZP1KZE7VqtytGrOMSDOI1aWybn5TwsUtSQMauSgM9V
 3nByLAvygasJHo+9MU0OCsFJsQSTGAdlD5wSjDeTwR9h3+O3G8NAmiIObBVID8mGcjYx9F
 GESXQTN8edaCOJ0zhSmD8oXjA6eO/a4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-xjXOWwpPNMWMQDA4cl-p8w-1; Fri, 29 Mar 2024 06:44:56 -0400
X-MC-Unique: xjXOWwpPNMWMQDA4cl-p8w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56c53b37630so576085a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711709094; x=1712313894;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+QonRjId6HaDu0WZf2b2eQJeKZ6u+4nYkIOvf5CgEc=;
 b=h5b6A7KUPab3iJBZ5NGuvfGhsChmxf8rMV4t3L9UBCfyuFUg2AXMs+JxnPHyIMeUYV
 4KbNNjV7VIVmDZiSWbyo5K/5IhNbMWhiop7bEEGG1IvjG/4b5cjCTT3vlBu29gLe+FA+
 lOL2eYzE9w2Y09YvQfSkOe91GUVgmiBi8twdzOS0ApqBMIghvOYbngawDbnlJF/I3fPs
 PNixG41eswsNSFq+Q3/VWvdYKLZXbmgr6s4okpQDqAdy9UQHuqR6xJEslzr5lBNfX+Np
 8B1UpBn0M4X1tp4JHNC2hmmLvzD/cxsvYk5UJKgGQ6iXNw1d+I67SXQkepqZYdFCr8na
 9Rnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWepcffakH+yQvdfClh4jl/93bjsr7h+Y7ZdjhY3BJ64RRvrt4AKEsysqvwDgr2oW5c/OKIq7WndNss4ogQtxxl/5PajL0=
X-Gm-Message-State: AOJu0YyOXXyJ/8nSsVcQvaPwJyk6LuNjElCm2svClkvDqkPZCG02hPvn
 5/BMdg7EnoYPk0uhB2VW/plD2mJ0nsjJeE/6BTwzvA4W+5LlYszEPzz0jreOAm9SyBOM6mr7mHB
 PFBPZ7drtJEcrfadliQXuB9lCzfOIis06eAgj/5tNNS+kTTAbQfs94rkP/s4q
X-Received: by 2002:a50:d6c5:0:b0:56b:829a:38e3 with SMTP id
 l5-20020a50d6c5000000b0056b829a38e3mr1368204edj.16.1711709094079; 
 Fri, 29 Mar 2024 03:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGoD+Nazb1kqZQktF1VF+3V+NcdFr2Ozr/lu5mo4EjMzFwTgzG2vD8mkjRklyMjal3Vc+MGQ==
X-Received: by 2002:a50:d6c5:0:b0:56b:829a:38e3 with SMTP id
 l5-20020a50d6c5000000b0056b829a38e3mr1368184edj.16.1711709093577; 
 Fri, 29 Mar 2024 03:44:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.36]) by smtp.gmail.com with ESMTPSA id
 g28-20020a056402321c00b0056c1c2b851esm1887056eda.0.2024.03.29.03.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 03:44:53 -0700 (PDT)
Date: Fri, 29 Mar 2024 06:44:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240329064431-mutt-send-email-mst@kernel.org>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 29, 2024 at 03:20:59PM +0800, Jason Wang wrote:
> On Fri, Mar 29, 2024 at 3:07 PM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> >
> > On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> > >>>> +}
> > >>>> +
> > >>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> > >>>>  {
> > >>>>      PCIDevice *dev = PCI_DEVICE(obj);
> > >>>>      DeviceState *qdev = DEVICE(obj);
> > >>>>
> > >>>> +    if (virtio_pci_no_soft_reset(dev)) {
> > >>>> +        return;
> > >>>> +    }
> > >>>> +
> > >>>>      virtio_pci_reset(qdev);
> > >>>>
> > >>>>      if (pci_is_express(dev)) {
> > >>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] = {
> > >>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> > >>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> > >>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> > >>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> > >>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> 
> Why does it come with an x prefix?
> 
> > >>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> > >>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > >>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > >>>
> > >>> I am a bit confused about this part.
> > >>> Do you want to make this software controllable?
> > >> Yes, because even the real hardware, this bit is not always set.
> 
> We are talking about emulated devices here.
> 
> > >
> > > So which virtio devices should and which should not set this bit?
> > This depends on the scenario the virtio-device is used, if we want to trigger an internal soft reset for the virtio-device during S3, this bit shouldn't be set.
> 
> If the device doesn't need reset, why bother the driver for this?
> 
> Btw, no_soft_reset is insufficient for some cases, there's a proposal
> for the virtio-spec. I think we need to wait until it is done.

That seems orthogonal or did I miss something?

> > In my use case on my environment, I don't want to reset virtio-gpu during S3,
> > because once the display resources are destroyed, there are not enough information to re-create them, so this bit should be set.
> > Making this bit software controllable is convenient for users to take their own choices.
> 
> Thanks
> 
> >
> > >
> > >>> Or should this be set to true by default and then
> > >>> changed to false for old machine types?
> > >> How can I do so?
> > >> Do you mean set this to true by default, and if old machine types don't need this bit, they can pass false config to qemu when running qemu?
> > >
> > > No, you would use compat machinery. See how is x-pcie-flr-init handled.
> > >
> > >
> >
> > --
> > Best regards,
> > Jiqian Chen.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C57CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 11:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtR2I-00045O-E8; Sun, 07 Apr 2024 07:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtR2F-00043z-EU
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 07:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtR2A-00017o-UM
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 07:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712490601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG6MBEPPtrDFuBbhLu+9kRKwPNF3qHq/YjKr84HMvcs=;
 b=K4oB7MLg759YxWsBUpaGx04E1Y1L6SWrkwk52fdQedj0WTstUPFRMG0b4qudcsuN8f9D/e
 FfTKGxCG/bnaGce0mX+W9PDolkeKuXnffjfIsGF8ccpwOLEBr6aHVSZ59DCv+C/BFAqCqJ
 23LD8VxrWiueuMKHXbariDZB9frOpSY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-P4bAYWFKMzus_ANhBGEXkA-1; Sun, 07 Apr 2024 07:49:59 -0400
X-MC-Unique: P4bAYWFKMzus_ANhBGEXkA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343d3e1ff1eso1797981f8f.3
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712490598; x=1713095398;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kG6MBEPPtrDFuBbhLu+9kRKwPNF3qHq/YjKr84HMvcs=;
 b=WvlHklFZLP8OZxEi8qoNR8Va0o6ypRVaAvMI7UV3MEOYsyB8JbcnSJB3+E9YcTcGG9
 mcLha7NY5/JPbiv8Fb6pzevT/JJLCuMgjPKFBumtCq84ua1SndX0KIfYwt4lh/SrmhPw
 CHm4/oB4lMqjW7t9hXflYKAeURj9TmkUX+CDprzabcC9tqvpIIG+9oR1WNfpwXVZV+l2
 M4dGZRG9mXjAqIaGvfbyei2PcXbYBFcfZP1eK6KYGx87hhObto4ZUYjStp5ZE6mWRq9j
 GGyCeZ4dklxRhxzPqa2cGy5otbpQseF8Dtm7VQpfwyBrQH1ynbHMSKEa6JvQiHl27+wc
 hkdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHX6pJfaX3sElpaK3BJ/vCMVt2YZDASgUgEisNpvZabbxn4hhUeNLAiGIw8XyTHMpOdB5Q8/dBZ4SB3v60/9kwUcC5xAE=
X-Gm-Message-State: AOJu0YzkcdtwYFmVecfIFY5ufWpYgBwZKhWzdTWqWnGabiYF9HbbQwuC
 7uK7GNaaQ4WTo4gizHOkDYQX51iP6F7TTiYWPvXcqVnxQlF56H8xtB0YLcYTMZoLoibcmCkaxeC
 SpGT383WLtzHyaTkwBNFZOu86+AagwucKvMZTVgOMGicg1tOQlhFd
X-Received: by 2002:adf:e481:0:b0:341:865b:65c9 with SMTP id
 i1-20020adfe481000000b00341865b65c9mr5396612wrm.22.1712490598095; 
 Sun, 07 Apr 2024 04:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2Z650aDdBd/f7Jxn2XIqVfUvMqiyynBxOdR+6oVAynA4ZuIZBbDfKsAKzZjHAWc9jGQdN2g==
X-Received: by 2002:adf:e481:0:b0:341:865b:65c9 with SMTP id
 i1-20020adfe481000000b00341865b65c9mr5396604wrm.22.1712490597574; 
 Sun, 07 Apr 2024 04:49:57 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 n5-20020a5d5985000000b00345a5183f01sm582549wri.108.2024.04.07.04.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Apr 2024 04:49:56 -0700 (PDT)
Date: Sun, 7 Apr 2024 07:49:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240407074848-mutt-send-email-mst@kernel.org>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Apr 07, 2024 at 11:20:57AM +0800, Jason Wang wrote:
> On Tue, Apr 2, 2024 at 11:03 AM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> >
> > On 2024/3/29 18:44, Michael S. Tsirkin wrote:
> > > On Fri, Mar 29, 2024 at 03:20:59PM +0800, Jason Wang wrote:
> > >> On Fri, Mar 29, 2024 at 3:07 PM Chen, Jiqian <Jiqian.Chen@amd.com> wrote:
> > >>>
> > >>> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> > >>>>>>> +}
> > >>>>>>> +
> > >>>>>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> > >>>>>>>  {
> > >>>>>>>      PCIDevice *dev = PCI_DEVICE(obj);
> > >>>>>>>      DeviceState *qdev = DEVICE(obj);
> > >>>>>>>
> > >>>>>>> +    if (virtio_pci_no_soft_reset(dev)) {
> > >>>>>>> +        return;
> > >>>>>>> +    }
> > >>>>>>> +
> > >>>>>>>      virtio_pci_reset(qdev);
> > >>>>>>>
> > >>>>>>>      if (pci_is_express(dev)) {
> > >>>>>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] = {
> > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> > >>>>>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> > >>>>>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> > >>>>>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> > >>
> > >> Why does it come with an x prefix?
> > >>
> > >>>>>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> > >>>>>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> > >>>>>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > >>>>>>
> > >>>>>> I am a bit confused about this part.
> > >>>>>> Do you want to make this software controllable?
> > >>>>> Yes, because even the real hardware, this bit is not always set.
> > >>
> > >> We are talking about emulated devices here.
> > >>
> > >>>>
> > >>>> So which virtio devices should and which should not set this bit?
> > >>> This depends on the scenario the virtio-device is used, if we want to trigger an internal soft reset for the virtio-device during S3, this bit shouldn't be set.
> > >>
> > >> If the device doesn't need reset, why bother the driver for this?
> > >>
> > >> Btw, no_soft_reset is insufficient for some cases, there's a proposal
> > >> for the virtio-spec. I think we need to wait until it is done.
> > >
> > > That seems orthogonal or did I miss something?
> > Yes, I looked the detail of the proposal, I also think they are unrelated.
> 
> The point is the proposal said
> 
> """
> Without a mechanism to
> suspend/resume virtio devices when the driver is suspended/resumed in
> the early phase of suspend/late phase of resume, there is a window where
> interrupts can be lost.
> """
> 
> It looks safe to enable it with the suspend bit. Or if you think it's
> wrong, please comment on the virtio spec patch.
> 
> > I will set the default value of No_Soft_Reset bit to true in next version according to your opinion.
> > About the compatibility of old machine types, which types should I consider? Does the same as x-pcie-pm-init(hw_compat_2_8)?
> > Forgive me for not knowing much about compatibility.
> 
> "x" means no compatibility at all, please drop the "x" prefix. And it
> looks more safe to start as "false" by default.
> 
> Thanks


Not sure I agree. External flags are for when users want to tweak them.
When would users want it to be off?
What is done here is I feel sane, just add machine compat machinery
to change to off for old machine types.


> > >
> > >>> In my use case on my environment, I don't want to reset virtio-gpu during S3,
> > >>> because once the display resources are destroyed, there are not enough information to re-create them, so this bit should be set.
> > >>> Making this bit software controllable is convenient for users to take their own choices.
> > >>
> > >> Thanks
> > >>
> > >>>
> > >>>>
> > >>>>>> Or should this be set to true by default and then
> > >>>>>> changed to false for old machine types?
> > >>>>> How can I do so?
> > >>>>> Do you mean set this to true by default, and if old machine types don't need this bit, they can pass false config to qemu when running qemu?
> > >>>>
> > >>>> No, you would use compat machinery. See how is x-pcie-flr-init handled.
> > >>>>
> > >>>>
> > >>>
> > >>> --
> > >>> Best regards,
> > >>> Jiqian Chen.
> > >
> >
> > --
> > Best regards,
> > Jiqian Chen.



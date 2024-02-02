Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2023C4828D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 00:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVh2G-00017P-IP; Thu, 01 Feb 2024 19:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rVh2F-000177-EN
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rVh2A-0002Ee-0g
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706832232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jj1Yw0oQya+x/p4rzqKIBznCD5WLBmKmx3akYpsffgg=;
 b=CbHC8VJPsz/um18LBHXzYvF0XOjOIJ/aQ5cK8GhTHUiKLxYrs/arWpNaE0RFnQInHZTyQD
 0lsJ1x7RYkcR0rJelSjBrp0N4sCs9HgzhlbYVcL3SdOfx8gusj3NFX05YjHhGp2L5FQF1I
 sqJqSKmexNsCRCcLJ6bdJYm6TGU2USo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-g8LQrYWKPiS1lFC3QY7drA-1; Thu, 01 Feb 2024 19:03:51 -0500
X-MC-Unique: g8LQrYWKPiS1lFC3QY7drA-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7c00a026be0so107454839f.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 16:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706832230; x=1707437030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jj1Yw0oQya+x/p4rzqKIBznCD5WLBmKmx3akYpsffgg=;
 b=jb6W/TOUwHMSC0xtC097J1LabdljIWVTIQDjotCuFXXKLis384Nh/wHN7JUtk4ogRa
 Nq0Z4m2GrzLFyxYTzOf0qGfc5wigZv7vCM60ceoLspahUltj/znlKrKg6YtIN/D0EpQg
 Ea1VFEGDQOFf8QKfuAW2qBzkwbqybBGfhznv05X4OYDF3htFxFssaV0l3QMQnhrKZ7pa
 Q0rRfNq/F9uZd8zXpxSgv4y7cugeoMfbPIkNoh7XwGJz62vIpHGTwPPDx5fZzsnimkez
 RduCJxvgKqGnoVllPevLk71Tq5mw/qnM+ibyxw4KLq36CUSxK2onOkbPXdGePgLiSr8p
 bodg==
X-Gm-Message-State: AOJu0Yxu4yFyn/KRRVoD7/sDFNmH2MxodeT9WPTuOBFb/BGtpRYLovhm
 6LALuDgwjXRgQjm7bewTCZ7Ge1n0kon/4KqZMesTspY7zpWSeE5iu7c3RrDew5uBPvU6YONxgB7
 /3pIuoDIvdKVd+BpW4n7Ids5vmPIT/tMW39A8wvbb+PrE8SP/EXpC
X-Received: by 2002:a05:6602:4283:b0:7c0:1fe2:da9d with SMTP id
 cd3-20020a056602428300b007c01fe2da9dmr4042198iob.19.1706832230315; 
 Thu, 01 Feb 2024 16:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFcUT65sbnBLBdSszoOBFeHTcsClFnTtDTh8yhO9Ozui+Qd4CtuhOppDKgWv/ZnegRshdhBA==
X-Received: by 2002:a05:6602:4283:b0:7c0:1fe2:da9d with SMTP id
 cd3-20020a056602428300b007c01fe2da9dmr4042180iob.19.1706832230012; 
 Thu, 01 Feb 2024 16:03:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWo2d6nJCqjFEhr0J15FETg9J5veg56K1DRkPmw8xJTMem8R3e0583qifY9wpurLlRawWKeDrnhReW40lq2H+8ow25ubNLqj3xu1U8zJk1Po6rUIENmt81Rd3Q3UXt77eUrqPGbGykSuhGGQvuAoWBnr5GalCokLAHE+WIDUcO0u/7+qlZLmIjyyRzmcw5DUqAmY4tTvYlgFcic8LD9Z2I94RvWbocpuwGO8zecMOC0YIJlPU7ZrRVTIvQ3xYrBjlk=
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 l30-20020a02cd9e000000b00470c4e1553esm155190jap.131.2024.02.01.16.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 16:03:49 -0800 (PST)
Date: Thu, 1 Feb 2024 17:03:47 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Vinayak Kale <vkale@nvidia.com>, zhiw@nvidia.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 targupta@nvidia.com, cjia@nvidia.com, acurrid@nvidia.com,
 marcel.apfelbaum@gmail.com, avihaih@nvidia.com
Subject: Re: [PATCH] hw/pci: migration: Skip config space check for vendor
 specific capability during restore/load
Message-ID: <20240201170347.41b8994b.alex.williamson@redhat.com>
In-Reply-To: <20240201130440-mutt-send-email-mst@kernel.org>
References: <20240130095617.31661-1-vkale@nvidia.com>
 <4d6a45ed-ca8d-4e41-b536-c2502ff1ce8b@nvidia.com>
 <20240130115832.462e76b7.alex.williamson@redhat.com>
 <f6586fc8-d64c-4ff0-80ac-1eb18b5f486b@nvidia.com>
 <20240131103817.50389f39.alex.williamson@redhat.com>
 <b83a9452-cbcc-4f4d-b0f7-b4957029e755@nvidia.com>
 <20240201130440-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 13:10:48 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 01, 2024 at 11:08:58PM +0530, Vinayak Kale wrote:
> >=20
> > On 31/01/24 11:08 pm, Alex Williamson wrote: =20
> > >=20
> > > On Wed, 31 Jan 2024 15:22:59 +0530
> > > Vinayak Kale <vkale@nvidia.com> wrote:
> > >  =20
> > > > On 31/01/24 12:28 am, Alex Williamson wrote: =20
> > > > >=20
> > > > > On Tue, 30 Jan 2024 23:32:26 +0530
> > > > > Vinayak Kale <vkale@nvidia.com> wrote:
> > > > >  =20
> > > > > > Missed adding Michael, Marcel, Alex and Avihai earlier, apologi=
es.
> > > > > >=20
> > > > > > Regards,
> > > > > > Vinayak
> > > > > >=20
> > > > > > On 30/01/24 3:26 pm, Vinayak Kale wrote: =20
> > > > > > > In case of migration, during restore operation, qemu checks t=
he config space of the pci device with the config space
> > > > > > > in the migration stream captured during save operation. In ca=
se of config space data mismatch, restore operation is failed.
> > > > > > >=20
> > > > > > > config space check is done in function get_pci_config_device(=
). By default VSC (vendor-specific-capability) in config space is checked.
> > > > > > >=20
> > > > > > > Ideally qemu should not check VSC during restore/load. This p=
atch skips the check by not setting pdev->cmask[] for VSC offsets in pci_ad=
d_capability().
> > > > > > > If cmask[] is not set for an offset, then qemu skips config s=
pace check for that offset.
> > > > > > >=20
> > > > > > > Signed-off-by: Vinayak Kale <vkale@nvidia.com>
> > > > > > > ---
> > > > > > >     hw/pci/pci.c | 7 +++++--
> > > > > > >     1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > > > index 76080af580..32429109df 100644
> > > > > > > --- a/hw/pci/pci.c
> > > > > > > +++ b/hw/pci/pci.c
> > > > > > > @@ -2485,8 +2485,11 @@ int pci_add_capability(PCIDevice *pdev=
, uint8_t cap_id,
> > > > > > >         memset(pdev->used + offset, 0xFF, QEMU_ALIGN_UP(size,=
 4));
> > > > > > >         /* Make capability read-only by default */
> > > > > > >         memset(pdev->wmask + offset, 0, size);
> > > > > > > -    /* Check capability by default */
> > > > > > > -    memset(pdev->cmask + offset, 0xFF, size);
> > > > > > > +
> > > > > > > +    if (cap_id !=3D PCI_CAP_ID_VNDR) {
> > > > > > > +        /* Check non-vendor specific capability by default */
> > > > > > > +        memset(pdev->cmask + offset, 0xFF, size);
> > > > > > > +    }
> > > > > > >         return offset;
> > > > > > >     }
> > > > > > >  =20
> > > > > >  =20
> > > > >=20
> > > > > If there is a possibility that the data within the vendor specifi=
c cap
> > > > > can be consumed by the driver or diagnostic tools, then it's part=
 of
> > > > > the device ABI and should be consistent across migration.  A mism=
atch
> > > > > can certainly cause a migration failure, but why shouldn't it? =20
> > > >=20
> > > > Sure, the device ABI should be consistent across migration. In case=
 of
> > > > VSC, it should represent same format on source and destination. But
> > > > shouldn't VSC content check or its interpretation be left to vendor
> > > > driver instead of qemu? =20
> > >=20
> > > By "vendor driver" here, are you suggesting that QEMU device models (=
ex.
> > > hw/net/{e1000*,igb*,rtl8139*}) should perform that validation?  If so,
> > > where's the patch that introduces any sort of validation hooks for
> > > vendors to provide?  Where is this validation going to happen in the
> > > case of a migratable vfio-pci variant devices?  Nothing about this
> > > patch suggests that it's deferring responsibility to some other code
> > > entity, it only indicates "checking this breaks, let's not do it".
> > >=20
> > > It's possible that the device you care about only reports volatile
> > > diagnostic information through the vendor specific capability, but
> > > another device might use it to report information relative to the
> > > internal hardware configuration.  Without knowing what the vendor
> > > specific capability contains, QEMU needs to take the most conservative
> > > approach by default.  Thanks, =20
> >=20
> > PCI/PCIe spec doesn=E2=80=99t define ABI for VSC/VSEC contents. Any oth=
er code
> > entity except vendor driver should ignore VSC contents. QEMU=E2=80=99s =
expectation
> > of VSC contents to be equal on source and destination seems incorrect g=
iven
> > that QEMU has no control over ABI for VSC contents.
> >  =20
> > >=20
> > > Alex
> > >  =20
>=20
> I don't get why this matters though. This is no different from any other
> device specific register. If a register is visible to guest it generally
> should not change across migration. If you are migrating a VFIO device and
> you are making a vsc visible to guest then your migration routine must
> make sure to migrate the contents of vsc.
>=20
> Maybe there's a good reason to have a register which actually does
> change. Then, please document the actual reason. When you say:
>=20
> 	 Ideally qemu should not check VSC during restore/load.
>=20
> then that is clearly wrong in most cases.

The argument as I understand it is that enforcing that the contents
remain unchanged between source and target is a policy, but QEMU has
no basis to create such a policy because the ABI for this capability is
not defined by the spec.  Furthermore since the ABI of this capability
is only defined by the device, only the driver for the device should
have any interaction with the capability.

There's some merit there, but a potential flaw is that QEMU does in
fact register several vendor specific capabilities for which it does
know the ABI.  See for example:

	vfio_add_vmd_shadow_cap()
	vfio_add_nv_gpudirect_cap()
	pci_bridge_qemu_reserve_cap_init()
	virtio_pci_add_mem_cap()

I think only the vfio VMD one can be claimed not to support migration
since afaik we could add a GPUDirect clique capability to a migratable
vGPU.  So since these are QEMU created capabilities and QEMU does
understand the ABI, what about these specific capabilities would allow
them to change between source and target VMs?

The GPUDirect clique capability describes p2p capabilities between
devices.  That information cannot spontaneously change.

The bridge vendor capability exposes reserved bridge resources, which I
think is consumed by firmware so a change would result in resources
shifting after migration and a guest reboot.  That would be bad.

The virtio vendor capability does a variety of things that I'm sure MST
could explain better than me, but also seems like defined ABI to the VM.

So actually is it the case that the only vendor specific capabilities
exposed to the VM that QEMU doesn't understand are those provided from
a device exposed through vfio-pci?  If that's the case, then QEMU's
default policy to verify that the vendor capability is unchanged seems
to be valid and I'd think the patch instead should be creating
exceptions to that default policy for vfio-pci devices (ie. nothing
says vfio-pci cannot clear cmask bits set by the pci-core).

I think we also see above that there are vendor specific capabilities
that have a scope beyond the guest driver itself, some visible through
userspace tools, some consumed by firmware.  So I still find it
difficult to determine whether any vfio-pci exception should be
unconditional or tied to specific devices.

Also, migration is only supported by vfio-pci variant drivers, so why
is it that the variant driver cannot or should not make the target
capability match the source?  If the contents of the capability
changes, does it need to be exposed at all by the variant driver, or is
the vendor specific capability the only means to expose this
information for the driver?  Thanks,

Alex



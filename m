Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E7CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 05:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwxw6-0004pQ-6Q; Wed, 17 Apr 2024 01:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rwxw4-0004pF-4W
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 01:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rwxvz-0002hd-HI
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 01:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713332053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqP6xChdHT6tWYDrjRvwjoIlN4Hee4rmb4tsJSvD8jI=;
 b=DXSwcxeM3YwEF9a74YH0T/WWIiBCtXxTdxsiIVpPEOLZjoT0tds1aZ2wc17lQRLmqLTTtb
 p50uDA5Y19wvsLhvst2WSYLHhfzjdG8G7P1VnsjG1cZ1d5Iw2S9EdgJ6fXfRvRMIc13Bqf
 QDQpiiDOE4ak14xN43YUGxUyRwO/r3k=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-cL2Tu85jN5CSSClSeMUhTQ-1; Wed, 17 Apr 2024 01:34:10 -0400
X-MC-Unique: cL2Tu85jN5CSSClSeMUhTQ-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4daa6aaff58so2390081e0c.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 22:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713332049; x=1713936849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqP6xChdHT6tWYDrjRvwjoIlN4Hee4rmb4tsJSvD8jI=;
 b=ltoeAfllmP6Y35fqDHT+AnGxizb3R0q33OlnJKoEc+buD6iCB9L1mEDXbkinJ788OI
 X/9qFMgIEcER3m6ofz7s3DoHz/1r50deVzpjVoU2mdyIiyeXUoo4p87p1ATLrQ549bdo
 y/juGNKGc94q/rDdkofSdUuq8xg+307TZEfdZNPgJ+Qw2yeYPseA+q4v0Q5aVktt9GZQ
 WuP5Wc1+xBSk5/rP64qsir+wBKo4EwbJR4GtAf/hivfZZbD4Jeso6EVYsJqbJqcjDRNH
 yHI5nKRvKXICps0uB12VG36CN/CXkZdYQpbQrW7KHZ4Qy8O9mpPCIpitV+ag78rrirJ1
 fD8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSsAME0YZZ1VI0tEU/SBr5nSpPV/ytajkFgQDwVaOxioC5Zw6aW1pvZRfzGOZKSZ5b0FROqMDOn2NAtpsSTlNNXVeiudA=
X-Gm-Message-State: AOJu0Yxb+F3S3yfIgx05u3rIABTbQS9xzzvIXWxJSpcjtV8lXQvZmp4j
 cLsNmeJMUsZjH/hjrvLcxxR79VKcgs3keWldQ4eVGcCYI2+5mC5oGa7u79UgXZsx8ADNN0andED
 5tkiX8SHSbR/+zrWAodKVBB/28LGV6EmUz4qmeS+s9WHJ5t+Q4mw/4nhz/T3zqukxUwHdwes8xz
 5+OAojnZj8D/dNbXnMIAucYgK634c=
X-Received: by 2002:a05:6122:1d93:b0:4d4:5d86:b2d with SMTP id
 gg19-20020a0561221d9300b004d45d860b2dmr12636661vkb.16.1713332048116; 
 Tue, 16 Apr 2024 22:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGEzsremqqO/n0fOXTw4qUiM3aodIPEA0fAgksoUmzzwBuvOv0eGGn+IbwTVl9BfMIQ22g3tIxqUPh2qurak8=
X-Received: by 2002:a05:6122:1d93:b0:4d4:5d86:b2d with SMTP id
 gg19-20020a0561221d9300b004d45d860b2dmr12636610vkb.16.1713332046299; Tue, 16
 Apr 2024 22:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-3-Jiqian.Chen@amd.com>
 <20240416174531.6573af25@imammedo.users.ipa.redhat.com>
 <BL1PR12MB5849B0755AE7DFD07A9B253FE70F2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849B0755AE7DFD07A9B253FE70F2@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 17 Apr 2024 08:33:55 +0300
Message-ID: <CAGoVJZyodBsX-FAxEjAGaXfu4ce8J1Qj4auWt-o9F+oRPVKBXg@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
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

On Wed, Apr 17, 2024 at 6:13=E2=80=AFAM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/4/16 23:45, Igor Mammedov wrote:
> > On Tue, 16 Apr 2024 15:01:27 +0800
> > Jiqian Chen <Jiqian.Chen@amd.com> wrote:
> >
> >> In current code, when guest does S3, virtio-gpu are reset due to the
> >> bit No_Soft_Reset is not set. After resetting, the display resources
> >> of virtio-gpu are destroyed, then the display can't come back and only
> >> show blank after resuming.
> >
> > Just a high level question.
> > Typically when system goes into S3 all devices (modulo RAM) loose conte=
xt
> > (aka powered off), and then it's upto device driver to recover whatever
> > was lost.
> No, what you said is just one situation that when system goes into S3 dev=
ices loose context and fully reinitialized and be D0-uninitialized state.
> The other situation is the context must be maintained so that the devices=
 can quickly be D0-active state after resuming.
> There are some descriptions in PCIe specification in Chapter 5.3.1.4 D3 s=
tate:
> " Functional context is required to be maintained by Functions in the D3H=
ot state if the No_Soft_Reset field in the PMCSR is
> Set. In this case, System Software is not required to re-initialize the F=
unction after a transition from D3Hot to D0 (the
> Function will be in the D0active state). If the No_Soft_Reset bit is Clea=
r, functional context is not required to be
> maintained by the Function in the D3Hot state, however it is not guarante=
ed that functional context will be cleared and
> software must not depend on such behavior. As a result, in this case Syst=
em Software is required to fully re-initialize the
> Function after a transition to D0 as the Function will be in the D0uninit=
ialized state."
>
BTW: according to Windows documentation D3 Hot state implementation is
a must for real HW devices.
https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/device-sl=
eeping-states
"Device power states D1, D2, and D3 are the device low-power states.
Starting with Windows 8, D3 is divided into two substates, D3hot and
D3cold.

D1 and D2 are intermediate low-power states. Many classes of devices
do not define these states. All devices must define D3hot."

Best regards,
Yan.


> What's more, not all virtio devices' context can be recovered by driver a=
fter resuming, like virtio-gpu, we have not enough information to re-create=
 all
> display resources, that is discussed in my previous version email thread.
>
> > So why should we implement hw(qemu) workaround for a driver problem?
> I think this is not a workaround, No_Soft_Reset bit is also described in =
PCIe specification, it can be set or not.
> And we can set this bit for the specific device which we want to maintain=
 context during S3.
>
> >
> >>
> >> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can ch=
eck
> >> this bit, if this bit is set, the devices resetting will not be done, =
and
> >> then the display can work after resuming.
> >>
> >> No_Soft_Reset bit is implemented for all virtio devices, and was teste=
d
> >> only on virtio-gpu device. Set it false by default for safety.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++=
+
> >>  include/hw/virtio/virtio-pci.h |  5 +++++
> >>  2 files changed, 42 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index a1b61308e7a0..82fa4defe5cd 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -2230,6 +2230,11 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev, Error **errp)
> >>              pcie_cap_lnkctl_init(pci_dev);
> >>          }
> >>
> >> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> >> +            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> >> +                         PCI_PM_CTRL_NO_SOFT_RESET);
> >> +        }
> >> +
> >>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> >>              /* Init Power Management Control Register */
> >>              pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> >> @@ -2292,11 +2297,37 @@ static void virtio_pci_reset(DeviceState *qdev=
)
> >>      }
> >>  }
> >>
> >> +static bool virtio_pci_no_soft_reset(PCIDevice *dev)
> >> +{
> >> +    uint16_t pmcsr;
> >> +
> >> +    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
> >> +        return false;
> >> +    }
> >> +
> >> +    pmcsr =3D pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTR=
L);
> >> +
> >> +    /*
> >> +     * When No_Soft_Reset bit is set and the device
> >> +     * is in D3hot state, don't reset device
> >> +     */
> >> +    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> >> +           (pmcsr & PCI_PM_CTRL_STATE_MASK) =3D=3D 3;
> >> +}
> >> +
> >>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>  {
> >>      PCIDevice *dev =3D PCI_DEVICE(obj);
> >>      DeviceState *qdev =3D DEVICE(obj);
> >>
> >> +    /*
> >> +     * Note that: a proposal to add SUSPEND bit is being discussed,
> >> +     * may need to consider the state of SUSPEND bit in future
> >> +     */
> >> +    if (virtio_pci_no_soft_reset(dev)) {
> >> +        return;
> >> +    }
> >> +
> >>      virtio_pci_reset(qdev);
> >>
> >>      if (pci_is_express(dev)) {
> >> @@ -2336,6 +2367,12 @@ static Property virtio_pci_properties[] =3D {
> >>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >> +    /*
> >> +     * for safety, set this false by default, if change it to true,
> >> +     * need to consider compatible for old machine
> >> +     */
> >> +    DEFINE_PROP_BIT("pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> >> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> >>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio=
-pci.h
> >> index 59d88018c16a..9e67ba38c748 100644
> >> --- a/include/hw/virtio/virtio-pci.h
> >> +++ b/include/hw/virtio/virtio-pci.h
> >> @@ -43,6 +43,7 @@ enum {
> >>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> >>      VIRTIO_PCI_FLAG_AER_BIT,
> >>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> >> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
> >>  };
> >>
> >>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> >> @@ -79,6 +80,10 @@ enum {
> >>  /* Init Power Management */
> >>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
> >>
> >> +/* Init The No_Soft_Reset bit of Power Management */
> >> +#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
> >> +  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> >> +
> >>  /* Init Function Level Reset capability */
> >>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
> >>
> >
>
> --
> Best regards,
> Jiqian Chen.



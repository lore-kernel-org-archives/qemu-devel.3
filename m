Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3EACD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 07:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq6YF-0003ht-6c; Fri, 29 Mar 2024 03:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6YA-0003fz-K0
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rq6Y8-0002Si-Im
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 03:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711696875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QB9J8xbbQHTrqr5D4B2K0iqpiL61PDs7BwWglpfUP1s=;
 b=XoLnRgEZHMYbV/RUpi9XcEserZVO+P8th+Oxk1IlSEeSBKSwrBVx+twrtnfYvzOsINla5R
 rWQz4uKChmaN5iur8WONrVrISAYcoShYgjMOlQW3eS39lAwVIoFpNR5sVTBTpl62cXBxEa
 hDjRfgjYxQBZULBuBva4pnbT7BmCmnk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-AYasxoCHOFebRz0YUoEKBQ-1; Fri, 29 Mar 2024 03:21:12 -0400
X-MC-Unique: AYasxoCHOFebRz0YUoEKBQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a0862ca1b3so1498452a91.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 00:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711696871; x=1712301671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QB9J8xbbQHTrqr5D4B2K0iqpiL61PDs7BwWglpfUP1s=;
 b=rT4ZhD22lX8zd9Rn/yNdvFBK+bfNyGqjjPwaIWObhZSxsav73ikgxASuxIBuxyzD5i
 SKEMu0pAKcTQO1YmjQhJbhV5pnmA5eadu9ngxyE+ut+BtkjHAej93gIevKNP0M7/rinb
 1va97sFsIKzN55iYDORKiSdqXXW5texruDigYtHFvyA/7TO3ABTvfKPP00dJpOVBuREA
 cvLndxXzQG00+ClWg6VfMzW7Zb668poVxmdlQOtAwP9GVq/m85vypiy1B+kD4s7t1yWv
 AoVczO4jcNSndjlDKZpq5bqdptgzTSEI2ZjRb5V0F0ITwBJmysq9sBnUrKLMB+tvRcOc
 s78g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu6vLO+jwSCPZtHvm7A21vS1jAZy2M621ksq/5/ZzZRupzY8XmkJKSGc6NAhuBHM+/Uuj86am6jvXncmJjJr6asA6GYCY=
X-Gm-Message-State: AOJu0Yx3tZ/VV3timrG4zw3LDBAHZPKfUO4DuARwGZ1b2Xo9dPiwGD9I
 bSe2G5bv7EX8eWClN/33UVlXVfLuG0Gw7csIEBVlgWcHlALpwY7Mj1If39L8TsotHXWF9bnuD8N
 UXwzKx53sF+En0wBpWPbq7Qmnsl5VJUSrjizGPdjZdOI5wKhcYLymbOhlxm0SaCUqh8uPxP6wCs
 8xqc1uTniRNhogA0upUfQnfuoTrNw=
X-Received: by 2002:a17:90a:2f42:b0:2a2:18fa:38fb with SMTP id
 s60-20020a17090a2f4200b002a218fa38fbmr312620pjd.0.1711696871200; 
 Fri, 29 Mar 2024 00:21:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqQaNEqjEQHwJ3r+MKL04BCPUf+YpQ3mICw06gR+++oIZEMooAOMpB6c0dwGT8vbAqjB3doWCQeNHrr1FcjFQ=
X-Received: by 2002:a17:90a:2f42:b0:2a2:18fa:38fb with SMTP id
 s60-20020a17090a2f4200b002a218fa38fbmr312608pjd.0.1711696870848; Fri, 29 Mar
 2024 00:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 15:20:59 +0800
Message-ID: <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Fri, Mar 29, 2024 at 3:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/3/28 20:36, Michael S. Tsirkin wrote:
> >>>> +}
> >>>> +
> >>>>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>>>  {
> >>>>      PCIDevice *dev =3D PCI_DEVICE(obj);
> >>>>      DeviceState *qdev =3D DEVICE(obj);
> >>>>
> >>>> +    if (virtio_pci_no_soft_reset(dev)) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>>      virtio_pci_reset(qdev);
> >>>>
> >>>>      if (pci_is_express(dev)) {
> >>>> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] =3D {
> >>>>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>>>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>>>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >>>> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flag=
s,
> >>>> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),

Why does it come with an x prefix?

> >>>>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>>>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>>>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >>>
> >>> I am a bit confused about this part.
> >>> Do you want to make this software controllable?
> >> Yes, because even the real hardware, this bit is not always set.

We are talking about emulated devices here.

> >
> > So which virtio devices should and which should not set this bit?
> This depends on the scenario the virtio-device is used, if we want to tri=
gger an internal soft reset for the virtio-device during S3, this bit shoul=
dn't be set.

If the device doesn't need reset, why bother the driver for this?

Btw, no_soft_reset is insufficient for some cases, there's a proposal
for the virtio-spec. I think we need to wait until it is done.

> In my use case on my environment, I don't want to reset virtio-gpu during=
 S3,
> because once the display resources are destroyed, there are not enough in=
formation to re-create them, so this bit should be set.
> Making this bit software controllable is convenient for users to take the=
ir own choices.

Thanks

>
> >
> >>> Or should this be set to true by default and then
> >>> changed to false for old machine types?
> >> How can I do so?
> >> Do you mean set this to true by default, and if old machine types don'=
t need this bit, they can pass false config to qemu when running qemu?
> >
> > No, you would use compat machinery. See how is x-pcie-flr-init handled.
> >
> >
>
> --
> Best regards,
> Jiqian Chen.



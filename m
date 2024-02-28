Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA28CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 19:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfPky-0003fF-Ea; Wed, 28 Feb 2024 14:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rfPkw-0003em-5O
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rfPku-0007pU-Gi
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 14:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709149094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA20CDAKsgM4Tx3YYjgPKLshZVqnm4Ew1QkRNRKLdZo=;
 b=UKGfXarCbhjUiw8A6FNfr9s/+beoA2N4i0ENGV759ABFU4BgXxeXit4ESFhIWdwRszpbSo
 b4rEtyZBJmGILtflQxg75QiKD9yayn8Dy8RMNlUcfOm5ThRco6n3vUi1DPD+FclT0wWH8w
 bPZXbASSFaROdHPTBkSIaM/eK2Ds5KY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-VXsObLH-PmW9uXg6BaZ8KQ-1; Wed, 28 Feb 2024 14:38:12 -0500
X-MC-Unique: VXsObLH-PmW9uXg6BaZ8KQ-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7c7ee7fa1caso5887039f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709149092; x=1709753892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uA20CDAKsgM4Tx3YYjgPKLshZVqnm4Ew1QkRNRKLdZo=;
 b=tp5yj3shsUAMeykdfBIOMom0pCA5vUmwmoc2THYa1FexJZ/vD7+CD8TiOn3+RnA3+h
 JpoMCPOHZmuaqr7LEsj+YXx8EHmq2lc51RfcHjv93sDYeT29hKhHNvZsrHo73PXtK8Wd
 kamiG8E8mxn5aotvWE0qwqjCnhVj30CpBJFoyFCuutRtJA332u6J54rJ1tXU5eQYj4gm
 rsWmMBUsUtL7WneVRgYLQPgHhSrZ3Kc+87lUV0riP/Qq290psGtfinV+UV1L3wE4YJNr
 tIwoiCu0xYSIwB8E8ReXrqKZfdt/4l76HI7S88acX8goERn4cTy9p2NW38I9mvt5yifP
 v0Rg==
X-Gm-Message-State: AOJu0Ywux1TXUBXyr6kaA7rvYDwYy/sv4ad3fhyUCfihVgwsc8oVSsmS
 CvowD3OKtVl9zUX8kfI3xUVz6dU1GGF5NpMi83V+imU4He+IyW9tyuij9lbC0xG9yVPnwFfu6/h
 Yz9ir38SUaLsRjuDr8qDtEysa8huix9PrJmpoBcdKmJ0oR088Nw3c
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id
 g20-20020a056602073400b007c7687e41bamr163493iox.9.1709149092240; 
 Wed, 28 Feb 2024 11:38:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLbkc9moMLuoOGq7o7bm+s7c1gRZdMUmGNufsCw5nAB2hYAZNgiuYz111J6g0/Tgm8/E8rCg==
X-Received: by 2002:a05:6602:734:b0:7c7:687e:41ba with SMTP id
 g20-20020a056602073400b007c7687e41bamr163467iox.9.1709149091853; 
 Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 cl10-20020a0566383d0a00b004741d55e66asm7810jab.84.2024.02.28.11.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 11:38:11 -0800 (PST)
Date: Wed, 28 Feb 2024 12:38:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Delevoryas <peter@pjd.dev>
Cc: qemu-devel <qemu-devel@nongnu.org>, suravee.suthikulpanit@amd.com,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [q&a] Status of IOMMU virtualization for nested virtualization
 (userspace PCI drivers in VMs)
Message-ID: <20240228123810.70663da2.alex.williamson@redhat.com>
In-Reply-To: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
References: <3D96D76D-85D2-47B5-B4C1-D6F95061D7D6@pjd.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 10:29:32 -0800
Peter Delevoryas <peter@pjd.dev> wrote:

> Hey guys,
>=20
> I=E2=80=99m having a little trouble reading between the lines on various
> docs, mailing list threads, KVM presentations, github forks, etc, so
> I figured I=E2=80=99d just ask:
>=20
> What is the status of IOMMU virtualization, like in the case where I
> want a VM guest to have a virtual IOMMU?

It works fine for simply nested assignment scenarios, ie. guest
userspace drivers or nested VMs.
=20
> I found this great presentation from KVM Forum 2021: [1]
>=20
> 1. I=E2=80=99m using -device intel-iommu right now. This has performance
> implications and large DMA transfers hit the vfio_iommu_type1
> dma_entry_limit on the host because of how the mappings are made.

Hugepages for the guest and mappings within the guest should help both
the mapping performance and DMA entry limit.  In general the type1 vfio
IOMMU backend is not optimized for dynamic mapping, so performance-wise
your best bet is still to design the userspace driver for static DMA
buffers.
=20
> 2. -device virtio-iommu is an improvement, but it doesn=E2=80=99t seem
> compatible with -device vfio-pci? I was only able to test this with
> cloud-hypervisor, and it has a better vfio mapping pattern (avoids
> hitting dma_entry_limit).

AFAIK it's just growing pains, it should work but it's working through
bugs.

> 3. -object iommufd [2] I haven=E2=80=99t tried this quite yet, planning t=
o:
> if it=E2=80=99s using iommufd, and I have all the right kernel features in
> the guest and host, I assume it=E2=80=99s implementing the passthrough mo=
de
> that AMD has described in their talk? Because I imagine that would be
> the best solution for me, I=E2=80=99m just having trouble understanding if
> it=E2=80=99s actually related or orthogonal.

For now iommufd provides a similar DMA mapping interface to type1, but
it does remove the DMA entry limit and improves locked page accounting.

To really see a performance improvement relative to dynamic mappings,
you'll need nesting support in the IOMMU, which is under active
development.  From this aspect you will want iommufd since similar
features will not be provided by type1.  Thanks,

Alex



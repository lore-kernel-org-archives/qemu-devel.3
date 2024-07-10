Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A4C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 20:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdX2-0000od-0t; Wed, 10 Jul 2024 16:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sRdWy-0000o3-Oy
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sRdWw-0008B2-IC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720641786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swnvs7DLTNVmFV1wk/zmsG7c1ZYl3ac3sADZ5TJc9Sc=;
 b=UMFIprCpD1FdQRLs5WpP7ARyuM795+qkfYr/Re9EYvFn8WI3CLgGTfNAaHAm+9LIAzZDo+
 7P+MaN/4x2KUmG0tiP6UfCrDoFtSpVHQ/KyQaAe/UxnRjPKJahiPRak1Uw1UB7C5Cv1wXz
 8+AHyI34k2UkzczlIR2NSGweRwo65H4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-JJcBUqhZP5exZ362s-siYg-1; Wed, 10 Jul 2024 16:03:04 -0400
X-MC-Unique: JJcBUqhZP5exZ362s-siYg-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7fdfb3333e5so15195339f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 13:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720641783; x=1721246583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swnvs7DLTNVmFV1wk/zmsG7c1ZYl3ac3sADZ5TJc9Sc=;
 b=E9h4xv2eLwJKQjBJ8J5OC085oS/Wfl+HftKmhzkUwEEyAiSEdLBdwdKoneCi8wEPAM
 PpI79JHhCVKef+YaDgUHW6qeCm7yKsCasQXmZlUWc0QJhEnxYZo2fAxE4MKvO3tqBeuS
 KrIH/wt0Zd4yuMcP0W4Sf1G1ufv+H1MtC6UVkPspXHzkjHFjLvTyt9kn+6bLWtwJW055
 VbbN5akTIQFBGoejRt7a9qtjV46rw4Zr2gz7oXGNAB/EJEEZzFC4I9jtwTW67kLeOt6y
 W6mPqzrAiAocJD3GkaRQ7a0CzNcDg2oGWx2bRHbvXVi1SDzYpr0b4JNpeHcOBfQWaum9
 uYlA==
X-Gm-Message-State: AOJu0YzNax4YdsOu7nMlfpaLSWcH4KXwtWkLjA9TBCHxtZ2ZjrbS0+tG
 01/mm3IzkZwpLAjZst0nafK/9I3ZT5j/YFG3P0CFXFuLVltJ3QCaW4QTl/0PpJ6LKxflq3jcQMh
 csmpQr6lnZfIs5ePVMjuboRlUAbjVNBbgSxL5NXI7NPj8hhH9w2ki/TJtZylA
X-Received: by 2002:a6b:ea1a:0:b0:7f8:c0eb:7adf with SMTP id
 ca18e2360f4ac-7fffa120fffmr707617239f.0.1720641783248; 
 Wed, 10 Jul 2024 13:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTq87kJf8Oh5Jvwn4pWMylhx63AhFO0tdVphsGgc6BcH7n0GccH2x2e+JOsuXws51NntSzyg==
X-Received: by 2002:a6b:ea1a:0:b0:7f8:c0eb:7adf with SMTP id
 ca18e2360f4ac-7fffa120fffmr707615039f.0.1720641782921; 
 Wed, 10 Jul 2024 13:03:02 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7ffed67d79fsm138696239f.45.2024.07.10.13.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 13:03:02 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:03:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Cedric Le Goater <clg@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V1 4/8] vfio-pci: cpr part 1 (fd and dma)
Message-ID: <20240710140301.4491b9b1.alex.williamson@redhat.com>
In-Reply-To: <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
 <1720558737-451106-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue,  9 Jul 2024 13:58:53 -0700
Steve Sistare <steven.sistare@oracle.com> wrote:

> Enable vfio-pci devices to be saved and restored across a cpr-exec of qemu.
> 
> At vfio creation time, save the value of vfio container, group, and device
> descriptors in CPR state.
> 
> In the container pre_save handler, suspend the use of virtual addresses
> in DMA mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest ram will
> be remapped at a different VA after exec.  DMA to already-mapped pages
> continues.  Save the msi message area as part of vfio-pci vmstate, and
> save the interrupt and notifier eventfd's in vmstate.
> 
> On qemu restart, vfio_realize() finds the saved descriptors, uses the
> descriptors, and notes that the device is being reused.  Device and iommu
> state is already configured, so operations in vfio_realize that would
> modify the configuration are skipped for a reused device, including vfio
> ioctl's and writes to PCI configuration space.  Vfio PCI device reset
> is also suppressed. The result is that vfio_realize constructs qemu
> data structures that reflect the current state of the device.  However,
> the reconstruction is not complete until migrate_incoming is called.
> migrate_incoming loads the msi data, the vfio post_load handler finds
> eventfds in CPR state, rebuilds vector data structures, and attaches the
> interrupts to the new KVM instance.  The container post_load handler then
> invokes the main vfio listener callback, which walks the flattened ranges
> of the vfio address space and calls VFIO_DMA_MAP_FLAG_VADDR to inform the
> kernel of the new VA's.  Lastly, migration resumes the VM.


Hi Steve,

What's the iommufd plan for cpr?  Thanks,

Alex



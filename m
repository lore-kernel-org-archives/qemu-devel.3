Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E085FC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 18:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUrJV-0003nN-Ip; Thu, 26 Jun 2025 14:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uUrJU-0003nF-Eh
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1uUrJS-0000vT-5k
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 14:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750962423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4clI53HhHp7nAuGK6FEGiuar6XY3fN+YHyCHBP1DVhw=;
 b=YQAf8Wl5eX5xTc/H8/DBkOLCYQHFkowQWuNqFSsM8dPmGY/lFxrZD5q86BklNPXsjnzymN
 Z5F+NFNFj8SRsXjfTI7pXzMlNF85fAanFHOlDB7DiHj03Bit8ebZiW1FCjx14wWjI/pGDp
 ydOAotbyWH1iC392oKdvRO9ZxDzEgKA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-QqBIOLxUOf6xJ6T02X8sxw-1; Thu, 26 Jun 2025 14:27:01 -0400
X-MC-Unique: QqBIOLxUOf6xJ6T02X8sxw-1
X-Mimecast-MFC-AGG-ID: QqBIOLxUOf6xJ6T02X8sxw_1750962421
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2e9b1c38495so166906fac.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 11:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750962421; x=1751567221;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4clI53HhHp7nAuGK6FEGiuar6XY3fN+YHyCHBP1DVhw=;
 b=tGrR3zqyvwua7zqEERWb225FsRoQvJf9nznEhsXSLb2KKwYmD2VWYMM4yCb/2IdgPq
 LiNdpi4bldXfJaAA2zoanlyQk7yCwFSI6Vdle1gQ0uZvWDU/c5ZznoCUGxyQ2BVf8eo6
 TQsKb1hYofQfl8Qs8osswiYWI6tHTuqwV4a3zM5+DqwdJ6HsC9jSgWLVqND5C3vHAJxK
 wp3R6wzkrvXejsWSdGye6hRo0WVzSHp5s4hlyQkd1E6fYRAofwJrDP5OG6vdDnnw2leM
 Nz31N/4UdIW3frhvC285wUkb4923n9aELQ10Ms6ND9Euehd1xKx7eEijjRB9Bfh5Zxsk
 6+cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Sy7yE2x2QMemRIGrJwxkgjmfzUW9kyocZAFuVcNaWKxqc7kuMa6LJFiD2h4iseuc3o/PFscW/676@nongnu.org
X-Gm-Message-State: AOJu0YxaiWAgHvvEKhaQ07TlbT8tcpHigl3p5NBTSp3ITFFWBllXAZ+3
 dPTx7sgjrhCejMplaWAp16SCjy5DLKm8qLbFg6x7Usua5ihCSJdWqBhXz9JhwUiuQ/y4BLI5+/y
 CUOzrH+cbV/USPFxsLrkYTYbamSPx7lWyT5F0TpVTbKl4/f3Yzy0ufhpM
X-Gm-Gg: ASbGncsw2YjWf3bR6tES+BeLa9ZJD8Kzz3mwAX6vSKhltmqf2KF26kFc5YWo8/X/dz8
 pgV45rJAtPrTSi8cQVy4CO2kSlfaeYKWKV9NM/j7lm/d3n2j5TKNqClrisgGMlMTA5Co+yoqw/p
 2EBeZsbMmPIJi9HaaDl7Rhfbz2fdRZzfKxu+nJzZt06qUP+YnXBtKDRqz3XOT54cKwfPZOhILNO
 ByugXnVO6gaO+IXATc9nsi1OdGEJPI3oT+Qf0+jj73001zoG3nroOZIV/H05GTbWvlchQbQDpT0
 WaPrEhaIbaQC06Kd+h67FY2Gkg==
X-Received: by 2002:a05:6820:a107:b0:611:a243:3889 with SMTP id
 006d021491bc7-611b901c613mr65442eaf.1.1750962420902; 
 Thu, 26 Jun 2025 11:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaOL67kMe0avYg3OC5VLJKmII9cZ0nHo/2R3x7WCHmVNwqiaVtvfdZ8mhULgQyQztJwiN7kw==
X-Received: by 2002:a05:6820:a107:b0:611:a243:3889 with SMTP id
 006d021491bc7-611b901c613mr65435eaf.1.1750962420476; 
 Thu, 26 Jun 2025 11:27:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b8474865sm46437eaf.1.2025.06.26.11.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 11:26:58 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:26:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] vfio/pci: Introduce x-pci-class-code option
Message-ID: <20250626122654.1d62f8c8.alex.williamson@redhat.com>
In-Reply-To: <92845463-8315-4ad8-9eab-eb2f4972cbaa@gmail.com>
References: <20250528155548.29344-1-tomitamoeko@gmail.com>
 <20250528123019.5ff938ed.alex.williamson@redhat.com>
 <d6c3adba-40a0-42ce-9578-2e0a4a68fe2b@gmail.com>
 <92845463-8315-4ad8-9eab-eb2f4972cbaa@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 17 Jun 2025 08:56:41 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 2025/5/29 18:41, Tomita Moeko wrote:
> > On 2025/5/29 2:30, Alex Williamson wrote:  
> >> On Wed, 28 May 2025 23:55:48 +0800
> >> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> >>  
> >>> Introduce x-pci-class-code option to allow users to override PCI class
> >>> code of a device, similar to the existing x-pci-vendor-id option. Only
> >>> the lower 24 bits of this option are used, though a uint32 is used here
> >>> for determining whether the value is valid and set by user.
> >>>
> >>> Additionally, to prevent exposing VGA ranges on non-VGA devices, the
> >>> x-vga=on option requires x-pci-class-code is either unset or set to
> >>> VGA controller class.
> >>>
> >>> This is mainly intended for IGD devices that expose themselves either
> >>> as VGA controller (primary display) or Display controller (non-primary
> >>> display). The UEFI GOP driver depends on the device reporting a VGA
> >>> controller class code (0x030000).
> >>>
> >>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> >>> ---
> >>> v2:
> >>> * Add vdev class code check in vfio_populate_vga().
> >>> * Fix type in trace-events.
> >>> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
> >>>
> >>>  hw/vfio/pci.c        | 25 +++++++++++++++++++++++++
> >>>  hw/vfio/pci.h        |  1 +
> >>>  hw/vfio/trace-events |  1 +
> >>>  3 files changed, 27 insertions(+)
> >>>
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>> index b1250d85bf..d57cb7356e 100644
> >>> --- a/hw/vfio/pci.c
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -2726,6 +2726,14 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> >>>          return false;
> >>>      }
> >>>  
> >>> +    /* vdev class should be either unmodified (PCI_ANY_ID), or VGA controller */
> >>> +    if ((vdev->class_code != PCI_ANY_ID) &&
> >>> +        (vdev->class_code != (PCI_CLASS_DISPLAY_VGA << 8)) &&
> >>> +        (vdev->class_code != (PCI_CLASS_NOT_DEFINED_VGA << 8))) {
> >>> +        error_setg(errp, "vdev is not a VGA device");
> >>> +        return false;
> >>> +    }  
> >>
> >> I think we should follow the scheme used for vendor_id and device_id to
> >> populate the struct field when not specified.  That let's us use it
> >> more easily and consistently for things like this.  
> > 
> > Hi, Alex
> > 
> > The class code override takes place in vfio_pci_config_setup(), where
> > is after vfio_populate_vga() is called in vfio_populate_device(). So
> > I have to check if it equals to default or VGA class code here, and
> > not initializing the sturct field with device value. If we decide to
> > initialize it for other purpose, I personally think we should also
> > save the subvendor/subdevice value as well.  
> 
> It have been several weeks, wondering if there is further comments.

Hi Moeko,

Thank you for your patience.  I'm still a little confused how this
works.  AIUI you have an GPU reported as a display controller, but you
want to change the class code to VGA, despite there being no VGA region
provided by vfio, right?  So the GOP driver only depends on the legacy
VGA class code and not the VGA regions.

vfio_populate_vga() initializes the vfio VGA region and calls
pci_register_vga().  Therefore with the ability to modify the class
code we only want to register the device as VGA if the class code is
unmodified, where the VGA vfio regions will only exist if the device is
VGA, or if the class override is VGA, where the VGA vfio regions again
only exist if the device is actually VGA and therefore the override is
a no-op.  But we only get to vfio_populate_vga() if the user specifies
x-vga=on.  So I think we're really just trying to prevent a physical VGA
device overridden as a non-VGA class code, but still specified with
x-vga=on, from calling pci_register_vga(), right?

What if we just separate pci_register_vga() out of vfio_populate_vga()?
Then we can continue the semantics of making class_code valid
regardless of whether it's been specified and around the point where we
call vfio_bars_register() we can also call pci_register_vga() if and
only if the class code is VGA and vdev->vga is configured.  Does that
make sense?  Thanks,

Alex



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB5ECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 21:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwSde-0007OV-5n; Wed, 10 Sep 2025 17:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwSdb-0007O0-Jk
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwSdX-0005Cu-SJ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 17:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757540754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j+0kWRPwugwD0NMlvh3M1zlJfsDP9U1sSAyC00kwvio=;
 b=R/ZQRvuAcxGb/54NWGrxqViwjPqbr0vAK3OqvVnNiCf71UkV8HHByjXATBbnWegum5DYL1
 /lv0d0mVZ32MdPMUOHWvvTkfWrzOimmnoykTEnZIcYiCdWL3YQmTBcn4EAgaCAuKf4o95P
 5QGfuHfdsgxHzs6ZNXGFAaIhpBQOzyU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-EKvACFArMgam9VzYMBt5ww-1; Wed, 10 Sep 2025 17:45:53 -0400
X-MC-Unique: EKvACFArMgam9VzYMBt5ww-1
X-Mimecast-MFC-AGG-ID: EKvACFArMgam9VzYMBt5ww_1757540752
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-819781ca2d4so3542385a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 14:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757540752; x=1758145552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+0kWRPwugwD0NMlvh3M1zlJfsDP9U1sSAyC00kwvio=;
 b=KQU9ZK0arl4UxQGjHSzm5wsJqYGsvsR6x9lDvx+EQh6BrRcY0MLYzVy+H1uOrgMN8t
 N31W3r1roc5iObvJ6JLLflWtMsWcBTROkDcBVKc00GkvzaYTt/Un3ECnKCBOkKuVflsS
 s21xybIKuF3wrYi+XKwOgfL/ShqLgDKBUsHLoOtnz2qdJZbKm8RvGm5prgARXqGAIA1c
 saLmq5vGEWqrVLQtQo+bgkbgFmMjbHDtnE408B0ogjMdZ+FBjiViAyJ12LGcGeZrxTOr
 wiKdkRjtQzZsIAVR2fXR+JToMb93kd60s5lZUiupO6TT5WISYy+IfKgVWmPukf1BGDvl
 EtxA==
X-Gm-Message-State: AOJu0Yw/WAooUxAUuopvMFq6h9/gq26nzk3CPllZw0dBEvzWluBqCZS3
 CNRVpbWXNgs+pIm4GlYVXEMnz6fgMZgaMMqjBeg5KQge56aWChBHAJxnt/6Mk0IsrKQ8d9WirsF
 S2XLgAYw97CuVpXsvv9Xii6p26v0QStA5x+HniI3CLtK+WPkfWmgHHV0b
X-Gm-Gg: ASbGncvvK8mRAkJfzda4AZOvIDhw4QFBziRDo0K9BOy64vJDg45+tAVVoPtxbfk8B/i
 fVNLa9rPOS8lPjvB/ed+xckoFeNNJwjRHGSASk4Qw1vrHMycOh5NhbAzfcTB/WG1oU+JFMIfBVV
 2DG/LIyDzrNdfneB6YTk208kz1q2YGVO3v9p7Hm95CTa4Qrh3U1YS3ZulhdJBmNGCySUU9HSafS
 aS2fmlOdN+lmaL+UwwP/Yb4vNZIzKyc0nZVgdDi8KLjMM413e3PgOZTiW5nlOtLaa+wXsQxe8y1
 GlHRdg0lN1NoS7RpWsuL7areP+WI+TBETEYNcArIPaQMJPxi0qMXZybH97E7G+vyBMT2MWsCdDa
 M/vVRKad3Zl2xj7/TZwtjCg==
X-Received: by 2002:a05:620a:4592:b0:805:aad7:f511 with SMTP id
 af79cd13be357-813be440657mr1748624085a.3.1757540751929; 
 Wed, 10 Sep 2025 14:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOFS+L++PosfPrkX7o7dRybTtrTJ+aIRGE5Wk/BC8OEYujGFYJCQaVv6nbosIGedB81z3quQ==
X-Received: by 2002:a05:620a:4592:b0:805:aad7:f511 with SMTP id
 af79cd13be357-813be440657mr1748618685a.3.1757540751195; 
 Wed, 10 Sep 2025 14:45:51 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b598ce968sm361138585a.22.2025.09.10.14.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 14:45:50 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:45:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
Message-ID: <aMHxhTIw2EGRyD4-@x1.local>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Sep 06, 2025 at 04:39:06AM +0200, Akihiko Odaki wrote:
> MemoryRegions used to "piggyback" on their owners instead of using their
> own reference counters due to the circular dependencies between
> them, which caused new circular references. Stop piggybacking, showing
> that the circular dependencies are actually broken at the finalization
> time.
> 
> Circular references caused by piggybacking
> ==========================================
> 
> Piggybacking created another circular reference when an owner referred
> to its MemoryRegion via memory_region_ref(). This could happen in three
> scenarios:
> 
> - A subregion and its container had the same owner. In this case, the
>   container would use memory_region_ref() to take a reference to the
>   subregion.
> 
> - An AddressSpace and its root MemoryRegion had the same owner. The
>   situation is similar to the subregion/container scenario.
> 
> - An owner called address_space_map() with a guest-controlled address
>   that points back to its MemoryRegion. This scenario is similar to what
>   MemReentrancyGuard handles.
> 
> Avoiding such a circular reference required checking if the referrer is
> the owner at many places where memory_region_ref() is called,
> complicating the code further.

I understand (1).  Why (2)/(3) are causes of circular references?

> 
> Insight
> =======
> 
> This change challenges the underlying assumption that circular
> dependencies exist and can be tolerated at the finalization time. The
> deletable MemoryRegions are of hotpluggable devices and
> virtio-gpu-virgl's hostmem. A device and its MemoryRegion have the
> following dependencies:
> 
> QOM tree -> Device
> Container -> MemoryRegion
> Device <-> MemoryRegion

Yes, they need to "reference" each other.  That's also why IMHO the current
qemu mr refcounting design is still practical, in that it keeps the
reference graph to be acyclic, which is much simpler to understand.

> 
> Techniques like piggybacking or a hypothetical garbage collector can
> finalize the device and the MemoryRegion once the QOM tree and container
> lose their dependencies. However, these methods are fundamentally
> insufficient because the MemoryRegion and the device have finalizers,
> and they do not respect the dependencies these objects may have during
> finalization.
> 
> As long as the object model based on the device and the MemoryRegion is
> correct, one of them should lose its dependency on the first,
> establishing a valid finalization order. Understanding this allows using
> standard reference counting, which is immune to the problems of
> piggybacking.
> 
> Analysis reveals that the device no longer depends on the MemoryRegion
> after being unparented. The device needs the MemoryRegion for the
> following two purposes:
> - To add the MemoryRegion to a container and expose it to an
>   AddressSpace.
> - To expose it via the QOM tree.
> 
> Once unparented, the device is hidden from the AddresSpaces and the
> QOM tree so it no longer needs the MemoryRegion and the circular
> dependencies are broken. We only need to ensure that the device is
> finalized after the MemoryRegion then.
> 
> It should also be noted that the reference from the MemoryRegion to the
> device needs to be tracked only after the device is unparented because
> the device will not be finalized as long as it is in the QOM tree.
> This fact can be exploited to avoid having a circular reference between
> the device and the MemoryRegion before the device gets unparented.
> 
> Solution
> ========
> 
> When devices get unparented, they also unparent their memory regions.
> The unparented memory regions will then retain their references to the
> devices. This ensures that:
> 
> 1. the references from the devices to their memory regions are counted
>    until the devices get unparented
> 2. the references from their memory regions to the devices afterwards,
>    which in turn ensures that devices are finalized after their
>    MemoryRegions.
> 
> When virtio-gpu's hostmems get unparented, they also unparent their
> memory regions in the same manner.
> 
> This enforces a valid finalization order, allows MemoryRegions to rely
> on standard reference counting, and eliminates the entire class of
> memory leaks caused by piggybacking.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  docs/devel/memory.rst         | 41 +++++++++++++++++-----------------
>  include/system/memory.h       | 51 +++++++++++++++++++++----------------------
>  hw/core/qdev.c                | 16 ++++++++++++++
>  hw/display/virtio-gpu-virgl.c |  1 +
>  system/memory.c               | 33 ++++++++++++++++++++--------
>  5 files changed, 86 insertions(+), 56 deletions(-)
> 
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 749f11d8a4dd..9634d8805740 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -143,11 +143,7 @@ Region lifecycle
>  ----------------
>  
>  A region is created by one of the memory_region_init*() functions and
> -attached to an object, which acts as its owner or parent.  QEMU ensures
> -that the owner object remains alive as long as the region is visible to
> -the guest, or as long as the region is in use by a virtual CPU or another
> -device.  For example, the owner object will not die between an
> -address_space_map operation and the corresponding address_space_unmap.
> +attached to an object, which acts as its owner or parent.
>  
>  After creation, a region can be added to an address space or a
>  container with memory_region_add_subregion(), and removed using
> @@ -158,30 +154,34 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
>  as soon as the region is made visible.  This can be immediately, later,
>  or never.
>  
> -Destruction of a memory region happens automatically when the owner
> -object dies.
> +A region will retain references to its owner object when it is
> +unparented. This ensures that the owner object remains alive as long as
> +the region is in use by a virtual CPU or another device.  For example,
> +the owner object will not die between an address_space_map operation and
> +the corresponding address_space_unmap. Devices automatically unparent
> +their memory regions when they are unparented.
>  
> -You must not destroy a memory region as long as it may be in use by a
> -device or CPU.  In order to do this, as a general rule do not create or
> -destroy memory regions dynamically during a device's lifetime.
> +You must not free a memory region as long as it may be in use by a
> +device or CPU.  In order to do this, as a general rule do not allocate
> +or free memory regions dynamically during a device's lifetime.
>  The dynamically allocated data structure that contains the
>  memory region should be freed in the instance_finalize callback.
>  
>  If you break this rule, the following situation can happen:
>  
> -- the memory region's owner had a reference taken via memory_region_ref
> +- the memory region had a reference taken via memory_region_ref
>    (for example by address_space_map)
>  
> -- the region is unparented, and has no owner anymore
> +- the region is freed
>  
> -- when address_space_unmap is called, the reference to the memory region's
> -  owner is leaked.
> +- when the mapped memory is used, the use of the memory region
> +  results in use-after-free.
>  
>  
> -There is an exception to the above rule: it is okay to call
> -object_unparent at any time for an alias or a container region.  It is
> -therefore also okay to create or destroy alias and container regions
> -dynamically during a device's lifetime.
> +There is an exception to the above rule: it is okay to free an alias or
> +a container region at any time.  It is therefore also okay to allocate
> +or free alias and container regions dynamically during a device's
> +lifetime.
>  
>  This exceptional usage is valid because aliases and containers only help
>  QEMU building the guest's memory map; they are never accessed directly.
> @@ -191,9 +191,8 @@ this exception is rarely necessary, and therefore it is discouraged,
>  but nevertheless it is used in a few places.
>  
>  For regions that "have no owner" (NULL is passed at creation time), the
> -machine object is actually used as the owner.  You must never call
> -object_unparent on regions that have no owner, unless they are aliases
> -or containers.
> +machine object is actually used as the owner.  You must never free
> +regions that have no owner, unless they are aliases or containers.
>  
>  
>  Overlapping regions and priority
> diff --git a/include/system/memory.h b/include/system/memory.h
> index e2cd6ed12614..1fc773ca49e2 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1307,7 +1307,7 @@ static inline bool memory_region_section_intersect_range(MemoryRegionSection *s,
>   * memory_region_add_subregion() to add subregions.
>   *
>   * @mr: the #MemoryRegion to be initialized
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: used for debugging; not visible to the user or ABI
>   * @size: size of the region; any subregions beyond this size will be clipped
>   */
> @@ -1320,14 +1320,14 @@ void memory_region_init(MemoryRegion *mr,
>   * memory_region_ref: Add 1 to a memory region's reference count
>   *
>   * Whenever memory regions are accessed outside the BQL, they need to be
> - * preserved against hot-unplug.  MemoryRegions actually do not have their
> - * own reference count; they piggyback on a QOM object, their "owner".
> - * This function adds a reference to the owner.
> + * preserved against hot-unplug. This function adds a reference to the
> + * memory region.
>   *
> - * All MemoryRegions must have an owner if they can disappear, even if the
> - * device they belong to operates exclusively under the BQL.  This is because
> - * the region could be returned at any time by memory_region_find, and this
> - * is usually under guest control.
> + * We do not ref/unref memory regions without an owner because it slows
> + * down DMA sensibly. All MemoryRegions must have an owner if they can
> + * disappear, even if the device they belong to operates exclusively
> + * under the BQL.  This is because the region could be returned at any
> + * time by memory_region_find, and this is usually under guest control.
>   *
>   * @mr: the #MemoryRegion
>   */
> @@ -1337,9 +1337,8 @@ void memory_region_ref(MemoryRegion *mr);
>   * memory_region_unref: Remove 1 to a memory region's reference count
>   *
>   * Whenever memory regions are accessed outside the BQL, they need to be
> - * preserved against hot-unplug.  MemoryRegions actually do not have their
> - * own reference count; they piggyback on a QOM object, their "owner".
> - * This function removes a reference to the owner and possibly destroys it.
> + * preserved against hot-unplug. This function removes a reference to
> + * the memory and possibly destroys it.
>   *
>   * @mr: the #MemoryRegion
>   */
> @@ -1352,7 +1351,7 @@ void memory_region_unref(MemoryRegion *mr);
>   * if @size is nonzero, subregions will be clipped to @size.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @ops: a structure containing read and write callbacks to be used when
>   *       I/O is performed on the region.
>   * @opaque: passed to the read and write callbacks of the @ops structure.
> @@ -1372,7 +1371,7 @@ void memory_region_init_io(MemoryRegion *mr,
>   *                                    directly.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1395,7 +1394,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
>   *                                          modify memory directly.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1425,7 +1424,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>   *                                     canceled.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: used size of the region.
> @@ -1454,7 +1453,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>   *                                    mmap-ed backend.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1487,7 +1486,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
>   *                                  mmap-ed backend.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: the name of the region.
>   * @size: size of the region.
>   * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
> @@ -1518,7 +1517,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
>   *                              region will modify memory directly.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1546,7 +1545,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
>   * skip_dump flag.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: the name of the region.
>   * @size: size of the region.
>   * @ptr: memory to be mapped; must contain at least @size bytes.
> @@ -1566,7 +1565,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
>   *                           part of another memory region.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: used for debugging; not visible to the user or ABI
>   * @orig: the region to be referenced; @mr will be equivalent to
>   *        @orig between @offset and @offset + @size - 1.
> @@ -1592,7 +1591,7 @@ void memory_region_init_alias(MemoryRegion *mr,
>   * of the caller.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1615,7 +1614,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
>   * of the caller.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @ops: callbacks for write access handling (must not be NULL).
>   * @opaque: passed to the read and write callbacks of the @ops structure.
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
> @@ -1651,7 +1650,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>   * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
>   * @instance_size: the IOMMUMemoryRegion subclass instance size
>   * @mrtypename: the type name of the #IOMMUMemoryRegion
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: used for debugging; not visible to the user or ABI
>   * @size: size of the region.
>   */
> @@ -1667,7 +1666,7 @@ void memory_region_init_iommu(void *_iommu_mr,
>   *                          region will modify memory directly.
>   *
>   * @mr: the #MemoryRegion to be initialized
> - * @owner: the object that tracks the region's reference count (must be
> + * @owner: the object that provides the region's storage (must be
>   *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
>   * @name: name of the memory region
>   * @size: size of the region in bytes
> @@ -1713,7 +1712,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
>   * If you pass a non-NULL non-device @owner then we will assert.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
>   *        must be unique within any device
>   * @size: size of the region.
> @@ -1744,7 +1743,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
>   * If you pass a non-NULL non-device @owner then we will assert.
>   *
>   * @mr: the #MemoryRegion to be initialized.
> - * @owner: the object that tracks the region's reference count
> + * @owner: the object that provides the region's storage
>   * @ops: callbacks for write access handling (must not be NULL).
>   * @opaque: passed to the read and write callbacks of the @ops structure.
>   * @name: Region name, becomes part of RAMBlock name used in migration stream
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 8fdf6774f87e..b83c46615fba 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -718,8 +718,18 @@ static void device_class_base_init(ObjectClass *class, const void *data)
>      klass->props_count_ = 0;
>  }
>  
> +static int collect_memory_region(Object *child, void *opaque)
> +{
> +    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
> +        g_array_append_val(opaque, child);
> +    }
> +
> +    return 0;
> +}
> +
>  static void device_unparent(Object *obj)
>  {
> +    g_autoptr(GArray) array = g_array_new(FALSE, FALSE, sizeof(Object *));
>      DeviceState *dev = DEVICE(obj);
>      BusState *bus;
>  
> @@ -735,6 +745,12 @@ static void device_unparent(Object *obj)
>          object_unref(OBJECT(dev->parent_bus));
>          dev->parent_bus = NULL;
>      }
> +
> +    object_child_foreach(OBJECT(dev), collect_memory_region, array);
> +
> +    for (gsize i = 0; i < array->len; i++) {
> +        object_unparent(g_array_index(array, Object *, i));
> +    }

What if the owner is not a device?

If we have a more self contained solution [1], which do not care about the
type of the owner object, why bother?

What is the benefit of your proposal here, comparing to [1]?

>  }
>  
>  static char *
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index f5cba8a7fa66..7afcaa4bfe2e 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -203,6 +203,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>          /* memory region owns self res->mr object and frees it by itself */
>          memory_region_set_enabled(mr, false);
>          memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));

It's definitely not obvious why a memory core change will involve a GPU
change too.

>          object_unparent(OBJECT(vmr));
>      }
>  
> diff --git a/system/memory.c b/system/memory.c
> index 56465479406f..edaf039b0647 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1212,11 +1212,19 @@ static char *memory_region_escape_name(const char *name)
>      return escaped;
>  }
>  
> +static void memory_region_free(void *obj)
> +{
> +    MemoryRegion *mr = obj;
> +
> +    object_unref(mr->owner);
> +}
> +
>  static void memory_region_do_init(MemoryRegion *mr,
>                                    Object *owner,
>                                    const char *name,
>                                    uint64_t size)
>  {
> +    OBJECT(mr)->free = memory_region_free;

I think this is wrong.  This should break object_new(TYPE_MEMORY_REGION)
users.

>      mr->size = int128_make64(size);
>      if (size == UINT64_MAX) {
>          mr->size = int128_2_64();
> @@ -1293,6 +1301,18 @@ static void memory_region_get_size(Object *obj, Visitor *v, const char *name,
>      visit_type_uint64(v, name, &value, errp);
>  }
>  
> +static void memory_region_unparent(Object *obj)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +
> +    object_ref(mr->owner);
> +}
> +
> +static void memory_region_class_init(ObjectClass *klass, const void *data)
> +{
> +    klass->unparent = memory_region_unparent;
> +}
> +
>  static void memory_region_initfn(Object *obj)
>  {
>      MemoryRegion *mr = MEMORY_REGION(obj);
> @@ -1826,25 +1846,19 @@ Object *memory_region_owner(MemoryRegion *mr)
>  
>  void memory_region_ref(MemoryRegion *mr)
>  {
> -    /* MMIO callbacks most likely will access data that belongs
> -     * to the owner, hence the need to ref/unref the owner whenever
> -     * the memory region is in use.
> -     *
> -     * The memory region is a child of its owner.  As long as the
> -     * owner doesn't call unparent itself on the memory region,
> -     * ref-ing the owner will also keep the memory region alive.
> +    /*
>       * Memory regions without an owner are supposed to never go away;
>       * we do not ref/unref them because it slows down DMA sensibly.
>       */
>      if (mr && mr->owner) {
> -        object_ref(mr->owner);
> +        object_ref(mr);
>      }
>  }
>  
>  void memory_region_unref(MemoryRegion *mr)
>  {
>      if (mr && mr->owner) {
> -        object_unref(mr->owner);
> +        object_unref(mr);
>      }
>  }
>  
> @@ -3777,6 +3791,7 @@ static const TypeInfo memory_region_info = {
>      .parent             = TYPE_OBJECT,
>      .name               = TYPE_MEMORY_REGION,
>      .class_size         = sizeof(MemoryRegionClass),
> +    .class_init         = memory_region_class_init,
>      .instance_size      = sizeof(MemoryRegion),
>      .instance_init      = memory_region_initfn,
>      .instance_finalize  = memory_region_finalize,
> 
> -- 
> 2.51.0
> 

[1] https://lore.kernel.org/all/20250826221750.285242-1-peterx@redhat.com/

-- 
Peter Xu



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E6CF07BD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 07:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1synwy-0005YJ-77; Thu, 10 Oct 2024 03:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1synww-0005Xy-SW
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1synwr-00025X-T5
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728546660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=io/9fnYFU0APX5VBYnxws13b+otrDN/cLaWAo0YUeUE=;
 b=ZsguuP8/8CdxHgAJoT87FGz1D/gzRCzUVNJXE2tMc7LH773B9DRpF+7RWSXrD7/JlhzGZt
 3uBZze+W4FACpSq5ZwVL3oMYyqLXbuIz9ZfomaWxr1NQVtpQTwKzqb1WhDTtAm7ag8UN3h
 d9ailAqW11OEXNvypawwDUMrUojIMxk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-I471GCg1PoyrkwaSlbVCOQ-1; Thu, 10 Oct 2024 03:49:17 -0400
X-MC-Unique: I471GCg1PoyrkwaSlbVCOQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2fac931e7c6so4403601fa.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 00:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728546556; x=1729151356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=io/9fnYFU0APX5VBYnxws13b+otrDN/cLaWAo0YUeUE=;
 b=vOqjP/e8Cd1hSg4qdQUDXXShDYShahkW/ZR6mUhjhht747rH8wWLEYFuzk7Yz/gEG4
 i80BuEbsV1t9gfZTt6mmoCG6VXRrnNkVzkB5QKis8e4xqCRYcTV7VMwvTsZsqM+gAiFK
 PyxEmh69yameKFCJnLm7Mtw7go/xTfTtp5evjcKJyjIHQy5NaFmAa3wJVTNIGRArWQC0
 roZTJjKkkSkqiw6d6OQXGstfT1vTIuqPmeBhCsNgWUkMjKU4cYTbCV7ZRSqJRMj7VGRZ
 F6QxwJOX58uUYDBh6uiw/MCAfHsVpkwD6HMIDtwOsAZgL5chs6XvCbRp2OlLQSFFv+Q0
 9ZEA==
X-Gm-Message-State: AOJu0Ywcui471y7M/FLodXc47WIK0I7rz30V5tbn4LvhyrhLlqqOHi9n
 QHrfQeq5HqZ7h27edfggb8+2N10HTyVTIzb6Rfvv4+YqmnwlMMOxCfzqbiMQHiXfynR6cDGrkK8
 DnwFjWX0foq8ESlz10zo/FV8YQY9bSeN93gPiqVqcHoEy1eIfkQPWFwZImnET/Q3OTctLvuMX4q
 Eyc9kTivmbh9i2fVAIic0kw2/zfMU=
X-Received: by 2002:a2e:4611:0:b0:2f7:51c2:fb08 with SMTP id
 38308e7fff4ca-2fb1872a68bmr27349771fa.12.1728546555875; 
 Thu, 10 Oct 2024 00:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWNVn5HQOOuWF+cOZogCVW0VvQ4rZ1NMtEEx36vRxk5QE1zvmHh/52jb4/MPbs3VuGJ5SNHGG35jkDFsZW9yI=
X-Received: by 2002:a2e:4611:0:b0:2f7:51c2:fb08 with SMTP id
 38308e7fff4ca-2fb1872a68bmr27349571fa.12.1728546555386; Thu, 10 Oct 2024
 00:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241008105455.2302628-1-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 10 Oct 2024 09:49:04 +0200
Message-ID: <CAMXpfWtgbHfGPJFZcP+Vb0FMgrnpc8pFQ8xHBRP-3vUbfTbmNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series has been successfully tested in s390x. Booted up a VM including=
:

/home/qemu/build/qemu-system-s390x \
...
-m 4G,maxmem=3D20G \
-object memory-backend-ram,id=3Dmem0,size=3D16G,reserve=3Doff \
-device virtio-mem-ccw,id=3Dvmem0,memdev=3Dmem0,dynamic-memslots=3Don \
...

Check the memory devices
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
memaddr: 0x100000000
node: 0
requested-size: 0
size: 0
max-size: 17179869184
block-size: 1048576
memdev: /objects/mem0

Hotplug memory to the maximum
(qemu) qom-set vmem0 requested-size 16G
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
  memaddr: 0x100000000
  node: 0
  requested-size: 17179869184
  size: 17179869184
  max-size: 17179869184
  block-size: 1048576
  memdev: /objects/mem0

Try to unplug the device, check the error message is correct
(qemu) device_del vmem0
Error: virtio-mem device cannot get unplugged while some of its memory
is still plugged

Reduce the memory till 0 and device is successfully unplugged
(qemu) qom-set vmem0 requested-size 0
(qemu) device_del vmem0
(qemu) object_del mem0

Hotplug again the device
(qemu) object_add memory-backend-ram,id=3Dmem0,size=3D8G,reserve=3Doff
(qemu) device_add
virtio-mem-ccw,id=3Dvmem0,memdev=3Dmem0,dynamic-memslots=3Don,requested-siz=
e=3D1G
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
memaddr: 0x100000000
node: 0
requested-size: 1073741824
size: 1073741824
max-size: 8589934592
block-size: 1048576
memdev: /objects/mem0

Finally, add some extra memory and check the memslots
(qemu) qom-set vmem0 requested-size 4G
(qemu) info mtree
...
    0000000100000000-00000002ffffffff (prio 0, i/o): virtio-mem
      0000000100000000-000000013fffffff (prio 0, ram): alias memslot-0
@mem0 0000000000000000-000000003fffffff
      0000000140000000-000000017fffffff (prio 0, ram): alias memslot-1
@mem0 0000000040000000-000000007fffffff
      0000000180000000-00000001bfffffff (prio 0, ram): alias memslot-2
@mem0 0000000080000000-00000000bfffffff
      00000001c0000000-00000001ffffffff (prio 0, ram): alias memslot-3
@mem0 00000000c0000000-00000000ffffffff

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Based on current master.
>
> There is really not much left to do on s390x, because virtio-mem already
> implements most things we need today (e.g., early-migration,
> unplugged-inaccessible). The biggest part of this series is just doing wh=
at
> we do with virtio-pci, wiring it up in the machine hotplug handler and ..=
.
> well, messing with the physical memory layout where we can now exceed
> initial RAM size and have sparsity (memory holes).
>
> I tested a lot of things, including:
>  * Memory hotplug/unplug
>  * Device hotplug/unplug
>  * System resets / reboots
>  * Migrate to/from file (including storage attributes under KVM)
>  * Basic live migration
>  * Basic postcopy live migration
>
> More details on how to use it on s390x -- which is pretty much how
> we use it on other architectures, except
> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>
> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
> be documented in the kernel and at [2] once this+kernel part go upstream.
>
> There are not many s390x-specific virtio-mem future work items, except:
> * Storage attribute migration might be improved
> * We might want to reset storage attributes of unplugged memory
>   (might or might not be required for upcoming page table reclaim in
>    Linux; TBD)
>
> The Linux driver is available at [3].
>
> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com
>
> v1 -> v2:
> * "s390x/s390-virtio-hcall: prepare for more diag500 hypercalls"
>  - Turn handle_diag_500() into a void function
>  - Inject PGM_SPECIFICATION from handle_diag_500() directly
> * "s390x/s390-virtio-ccw: move setting the maximum guest size from sclp t=
o
>    machine code"
>  - Move code to a new function to make further changes easier
>  - Adjust s390_pv_vm_try_disable_async() to stay in sync with the
>    maxram->ram change
> * "s390x: introduce s390_get_memory_limit()"
>  - Store limit in machine
>  - Move s390_set_memory_limit() from target code into machine code
> * "s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT"
>  - Move handling into a separate function now that we lookup the machine
> * "s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
>    layouts"
>  - Adjust to s390_get_memory_limit() changes
> * "s390x/s390-skeys: prepare for memory devices"
>  - Adjust to s390_get_memory_limit() changes
> * "s390x/pv: prepare for memory devices"
>  - Use s390_get_memory_limit()
> * "s390x: remember the maximum page size"
>  - Store it in the machine
>  - Move s390_set_max_pagesize() from target code into machine code
>  - No need for s390_get_max_pagesize()
> * "s390x/virtio-ccw: add support for virtio based memory devices"
>  - Move machine wire-up code from virtio-mem patch into this patch
>  - Add stubs to make compilation without virtio-mem work
> * "s390x: virtio-mem support"
>  - Move machine write-up code to previous patch
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
>
> David Hildenbrand (14):
>   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
>   s390x/s390-virtio-hcall: remove hypercall registration mechanism
>   s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
>   s390x: rename s390-virtio-hcall* to s390-hypercall*
>   s390x/s390-virtio-ccw: move setting the maximum guest size from sclp
>     to machine code
>   s390x: introduce s390_get_memory_limit()
>   s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
>   s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
>     layouts
>   s390x/s390-skeys: prepare for memory devices
>   s390x/s390-virtio-ccw: prepare for memory devices
>   s390x/pv: prepare for memory devices
>   s390x: remember the maximum page size
>   s390x/virtio-ccw: add support for virtio based memory devices
>   s390x: virtio-mem support
>
>  MAINTAINERS                        |   5 +
>  hw/s390x/Kconfig                   |   1 +
>  hw/s390x/meson.build               |   6 +-
>  hw/s390x/s390-hypercall.c          |  85 +++++++++++
>  hw/s390x/s390-hypercall.h          |  25 ++++
>  hw/s390x/s390-skeys.c              |   6 +-
>  hw/s390x/s390-stattrib-kvm.c       |  67 ++++++---
>  hw/s390x/s390-virtio-ccw.c         | 165 ++++++++++++++-------
>  hw/s390x/s390-virtio-hcall.c       |  41 ------
>  hw/s390x/s390-virtio-hcall.h       |  25 ----
>  hw/s390x/sclp.c                    |  17 +--
>  hw/s390x/virtio-ccw-md-stubs.c     |  24 +++
>  hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++
>  hw/s390x/virtio-ccw-md.h           |  44 ++++++
>  hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++
>  hw/s390x/virtio-ccw-mem.h          |  34 +++++
>  hw/virtio/Kconfig                  |   1 +
>  hw/virtio/virtio-mem.c             |   4 +-
>  include/hw/s390x/s390-virtio-ccw.h |   4 +
>  target/s390x/cpu-sysemu.c          |  15 --
>  target/s390x/cpu.h                 |   2 -
>  target/s390x/kvm/kvm.c             |  18 +--
>  target/s390x/kvm/pv.c              |   2 +-
>  target/s390x/tcg/misc_helper.c     |   7 +-
>  24 files changed, 782 insertions(+), 195 deletions(-)
>  create mode 100644 hw/s390x/s390-hypercall.c
>  create mode 100644 hw/s390x/s390-hypercall.h
>  delete mode 100644 hw/s390x/s390-virtio-hcall.c
>  delete mode 100644 hw/s390x/s390-virtio-hcall.h
>  create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
>  create mode 100644 hw/s390x/virtio-ccw-md.c
>  create mode 100644 hw/s390x/virtio-ccw-md.h
>  create mode 100644 hw/s390x/virtio-ccw-mem.c
>  create mode 100644 hw/s390x/virtio-ccw-mem.h
>
> --
> 2.46.1
>
>



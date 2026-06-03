Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B599CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUrFY-0004m1-Bx; Wed, 03 Jun 2026 15:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrFU-0004lG-9r
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUrFP-0000vc-Dv
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 15:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780514844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ON6QjNp6kxkutNYQIzCn+4gK3lyHCxWvpATs/J2ApdU=;
 b=CDxKAl1Crdrvo0R3e5k7aa67GqiigWwnAfIy2hBiALLbs77vaFu2q+Ayrj1u7sWeB8ctSP
 V30aucGV5dsVUsXpVrMdCtfs0BwWdT2ZI6vQjpxu+uKMslEmTaOOFOFJKZmmrh+auKXhG2
 S7pw83cIqcBY5hPSfdzC/+IDt4JcPFk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-NYRr919IOgu7HGDHUKyVKA-1; Wed, 03 Jun 2026 15:27:23 -0400
X-MC-Unique: NYRr919IOgu7HGDHUKyVKA-1
X-Mimecast-MFC-AGG-ID: NYRr919IOgu7HGDHUKyVKA_1780514843
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5177f07ea82so23486181cf.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780514843; x=1781119643; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ON6QjNp6kxkutNYQIzCn+4gK3lyHCxWvpATs/J2ApdU=;
 b=VCTo3iHZMGdCsAepG61YAhOUt7SvTYWRSUPtyIK3WJXNnQ4vsCGif/99yRJWD6zyD6
 tFeJVbbqeWAjEAUspjXOlkmJskDxyqMQIxjzLXgw7sXSNeLiBTlKyT9HFt/ooGAFYuae
 f6RIjNn6tuGYcsajfJHLLiV/sM7Gjx53pUdOjda/EFBwgvuXzDQMKQ9CwCVNg49jHTtO
 P/d3AQuz39FstPRh8CXE2SwV6oyDMjcFwK4kVxRHa6G+gKCZnlOtRcTfFFWqMr2oFxdP
 6rntqFQ5Xz0M0egWHakcCdJY563RZ+TwQWAjqGekrzPaWPtuP6cF3KvatOba0E1yB3ga
 WEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780514843; x=1781119643;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ON6QjNp6kxkutNYQIzCn+4gK3lyHCxWvpATs/J2ApdU=;
 b=PbKkrOY4rc4s59Alig2WEcLejFjIBwNawvoESMZ0rJ8ZbxdvcS4G8k3LwjLdhRS19L
 5tLi+MfV5OHK0IFE3i2OChen5OScUddbof/IoTvty6ZlKHcf7O3l/LV6xkRsbxwSlR9l
 xPC9P+Ldfsja3A0Fi9zhlO2xHTO92wLMPGP4lrISrCeu4a3wpHuDnVuGBkUqIhSUpPNR
 LSRn2ALpctE7N44Zx/2inBukn69kbAWJYlvajj2prOmRviKSVMjk5eMX+QWKFrsDbrJt
 D2myShjFPdj4L5RQmhbQVhQYidiup9FZs3kA+FhvEYXAzK87GrQMtIvTEGzzPtB8y8IR
 M4kQ==
X-Gm-Message-State: AOJu0Yyrsa1ZbZrHiHeMJssAOaOqMQfG8e8+lduZZ7QM2F0eAeeLQ6Pr
 +RISEJ6oUeaen0ayoDpdMg1EuMtqvBDfqQTJOtFLqHZaceAujkanbZLh2rFT2tTUQdHjCK0Ej4H
 P2JQh3IQTzU/mEsSxcBguGdj6pIRjPSiDAZI4Zz3oBiuGgpQlWMXlL6Y2
X-Gm-Gg: Acq92OF+bVKwDN4738RdPq/B2uNWj50o9732UNo/Sc5LxPpuKPqR37y9ldGeqyIacII
 YYsYlZD51V9TcXShbNtNDUaJciQ21EfTlu3UOHQLT2ehJSl/IlL+sLRXgFRGswodsnIXgi93+ws
 nwhKBsIeV8VBUGQDXxfbm/FTT5nw20XsxgnRTTLhoyvaLZeqFesUJtdAR8txedL5PU1FFLrV8Pe
 dnjUbplnvYsMMN03MyFp2opV7eMQCZ4ttV4RwuPICztlIhSzFzJ4576lXDsRDfnVW/O/jkU24IU
 D2HcjLaPJ2GQ3umi/tAUUSSnPvR/QRHAA06WphB6bjy7jT7Nqjyld7gb5ZBEw5n/lQb/9XgPcCe
 SnQ4rwCh18G/+yBhFkxtbU8B6bg==
X-Received: by 2002:a05:622a:1814:b0:509:2858:3c63 with SMTP id
 d75a77b69052e-51778635f4bmr68684671cf.23.1780514842485; 
 Wed, 03 Jun 2026 12:27:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1814:b0:509:2858:3c63 with SMTP id
 d75a77b69052e-51778635f4bmr68684041cf.23.1780514841737; 
 Wed, 03 Jun 2026 12:27:21 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c54177sm34941001cf.12.2026.06.03.12.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 12:27:18 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:27:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <aiCAFWKEAHkPLCO5@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 02, 2026 at 05:02:29PM -0500, Michael Roth wrote:
> On Mon, Dec 15, 2025 at 03:51:51PM -0500, Peter Xu wrote:
> > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > 
> > v3:
> > - Collect R-bs from Xiaoyao
> > - Rebased to 10.2-rc3; no dependency needed now, as those got merged
> > - Reorder patches, touch up commit messages or comments on in-place misuse
> > - Added patch "kvm: Provide explicit error for kvm_create_guest_memfd()" [Xiaoyao]
> > - Added one patch for renaming machine_require_guest_memfd() [Xiaoyao]
> > - Added one patch for renaming memory_region_init_ram_guest_memfd() [Xiaoyao]
> > 
> > =========8<===========
> > 
> > This series allows QEMU to consume init-shared guest-memfd to be a common
> > memory backend. Before this series, guest-memfd was only used in CoCo and
> > the fds will be created implicitly whenever CoCo environment is detected.
> > When used in init-shared mode, the guest-memfd will be specified in the
> > command lines directly just like other types of memory backends.
> > 
> > In the current patchset, I reused the memory-backend-memfd object, rather
> > than creating a new type of object.  After all, guest-memfd (at least from
> > userspace POV) works similarly like a memfd, except that it was tailored
> > for VM's use case.
> > 
> > This approach so far also does not involve gmem bindings to KVM instances,
> > hence it is not prone to issues when the same chunk of RAM will be attached
> > to more than one KVM memslots.
> > 
> > Now, instead of using a normal memfd backend using:
> > 
> >   -object memory-backend-memfd,id=ID,size=SIZE,share=on
> > 
> > One can also boot a VM with guest-memfd:
> > 
> >   -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
> 
> Hi Peter,

Hi, Michael,

> 
> I'm working on enabling support for this, as well as enabling in-place
> conversion support for confidential VMs[1]. In my series I added a
> dedicated memory-backend-guest-memfd to handle using mmapable
> guest_memfd to back normal VMs (and confidential VMs with in-place
> conversion enabled on top). Xiaoyao mentioned we had some overlap and
> potential inter-dependencies between our series so I took some notes
> on the differences which I've included at the bottom of this email...

To Xiaoyao: thanks for linking these works, and also thanks for answering
other question I raised in the separate thread.

> 
> But at a high-level I think this series is further along in implementing
> guest_memfd for normal VMs, and I would plan to just mostly rebase my
> in-place conversion patches on top of your series. However I think it
> would be a good idea to go with a dedicated memory-backend-guest-memfd
> for reasons I outlined in my notes, so maybe this needs to be discussed
> more.

To me, it was just natural when working on that to reuse memfd backend,
because conceptually they're really the same: I guess guest-memfd is named
as guest-memfd (not guest-special-fd etc.) also because of that.

I don't have a strong feeling here, hostmem-memfd.c is tiny so duplicating
isn't a major concern even if so.  It's just that I don't yet see when gmem
will become special.

Say, all of the features that memfd provides can easily be applied to
guest-memfd either now or at some point later:

  - hugetlb/hugetlbsize being one of them already, I believe we almost know
    1G will happen to gmem soon
  - seal: I don't see why we can't seal a gmemfd too.. maybe it'll come, in
    general the whole seal concept can apply to gmem too.
  - cpr support on memfd (or anything about live update in the future to
    happen on gmem): I believe gmem also want it..

IIUC it's a matter of if we expect future property of guest-memfd that will
stop applying to memfd anymore?

> 
> I also saw you were open to having someone pick up these patches if you
> don't think you'll have a chance to get to them near-term, so I'd be
> happy to pick them up if that's preferable.

Sure!  Indeed I don't have bandwidth to keep working on this one in the
near future. Please feel free to pick whatever needed into your series.

Thanks,

> 
> Thanks!
> 
> -Mike
> 
> [1] https://lore.kernel.org/qemu-devel/20260528000416.8161-1-michael.roth@amd.com/
> 
> Comparisons to the above patchset:
> 
>   [PATCH v3 01/12] kvm: Decouple memory attribute check from kvm_guest_memfd_supported 
>     - similar to:
>         [PATCH 01/12] accel/kvm: Decouple guest_memfd checks from memory attribute checks
>     - to allow mmap case, both defer error handling to ram_block_add() + RAM_GUEST_MEMFD path
>     - pros: adds nice kvm_private_memory_attribute_supported() helper
>     - cons: my patch checks/prints error via kvm_create_guest_memfd(), which
>       makes it a more re-usable error since ram_block_add() isn't the only
>       caller.
>     - IMO, I think we should merge the pros of your patch into my similar patch
>       and add your Co-developed-by, but also fine to keep yours as-is and deal
>       with anything else needed as a follow-up patch
>   [PATCH v3 02/12] kvm: Detect guest-memfd flags supported
>     - similar to the kvm_supported_guest_memfd_flags / kvm_create_guest_memfd_shared()
>       additions that are part of:
>         [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
>     - This patch could be treated as a common dependency of the above and I can
>       drop the corresponding changes from my patch
>   [PATCH v3 03/12] kvm: Provide explicit error for kvm_create_guest_memfd()
>     - Keep as-is
>   [PATCH v3 04/12] ramblock: Rename guest_memfd to guest_memfd_private
>     - Keep as-is
>   [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
>     - Keep as-is
>   [PATCH v3 06/12] memory: Rename memory_region_has_guest_memfd() to *_private()
>     - Keep as-is
>   [PATCH v3 07/12] hostmem: Rename guest_memfd to guest_memfd_private
>     - Keep as-is
>   [PATCH v3 08/12] hostmem: Support fully shared guest memfd to back a VM
>     - alternative to:
>         [02/12] hostmem: Introduce dedicated memory backend for guest_memfd
>     - pros: re-uses infrastructure from hostmem-memfd
>     - pros: less command-line changes vs. dedicated hostmem-guest-memfd (less libvirt changes?)
>     - cons: less flexibility vs. a dedicated backend
>     - cons: more risk of memfd vs guest_memfd behavior/options diverging over
>             time and having less commonality (e.g. if hugetlb has special options
>             we wouldn't need to muddy the existing documentation for normal
>             memfds or introduce alternative options alongside)
>     - IMO, a clean state patch only requires ~90 lines of potentially-duplicate
>       code, and that's offset to some degree by needing less special-casing
>       throughout hostmem-memfd.c (e.g. this patchset adds 55 lines on top), and
>       it seems worthwhile given some of the advanced use-cases planned around
>       guest_memfd (hugetlb, DAX-like functionality, and persisting userspace
>       across kexec) that might require special handling/options for very
>       different use-cases than normal memfds.
>   [PATCH v3 09/12] machine: Rename machine_require_guest_memfd() to *_private()
>     - Keep as-is
>     - (all these renames are a nice cleanup/prep and will help a lot with making
>       in-place conversion handling more readable)
>   [PATCH v3 10/12] memory: Rename memory_region_init_ram_guest_memfd() to *_private()
>     - Keep as-is
>     - (all these renames are a nice cleanup/prep and will help a lot with making
>       in-place conversion handling more readable)
>   [PATCH v3 11/12] tests/migration-test: Support guest-memfd init shared mem type
>     - Keep as-is
>   [PATCH v3 12/12] tests/migration-test: Add a precopy test for guest-memfd
>     - Keep as-is
> 
> > 
> > The init-shared guest-memfd relies on almost the latest linux, as the
> > mmap() support just landed v6.18-rc2.  When run it on an older qemu, we'll
> > see errors like:
> > 
> >   qemu-system-x86_64: KVM does not support guest_memfd
> > 
> > One thing to mention is live migration is by default supported, however
> > postcopy is still currently not supported.  The postcopy support will have
> > some kernel dependency work to be merged in Linux first.
> > 
> > Thanks,
> > 
> > Peter Xu (11):
> >   kvm: Detect guest-memfd flags supported
> >   kvm: Provide explicit error for kvm_create_guest_memfd()
> >   ramblock: Rename guest_memfd to guest_memfd_private
> >   memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
> >   memory: Rename memory_region_has_guest_memfd() to *_private()
> >   hostmem: Rename guest_memfd to guest_memfd_private
> >   hostmem: Support fully shared guest memfd to back a VM
> >   machine: Rename machine_require_guest_memfd() to *_private()
> >   memory: Rename memory_region_init_ram_guest_memfd() to *_private()
> >   tests/migration-test: Support guest-memfd init shared mem type
> >   tests/migration-test: Add a precopy test for guest-memfd
> > 
> > Xiaoyao Li (1):
> >   kvm: Decouple memory attribute check from kvm_guest_memfd_supported
> > 
> >  qapi/qom.json                         |  6 ++-
> >  include/hw/boards.h                   |  2 +-
> >  include/system/hostmem.h              |  2 +-
> >  include/system/kvm.h                  |  1 +
> >  include/system/memory.h               | 27 ++++++------
> >  include/system/ram_addr.h             |  2 +-
> >  include/system/ramblock.h             |  7 +++-
> >  tests/qtest/migration/framework.h     |  4 ++
> >  accel/kvm/kvm-all.c                   | 33 ++++++++++++---
> >  accel/stubs/kvm-stub.c                |  6 +++
> >  backends/hostmem-file.c               |  2 +-
> >  backends/hostmem-memfd.c              | 55 +++++++++++++++++++++---
> >  backends/hostmem-ram.c                |  2 +-
> >  backends/hostmem-shm.c                |  2 +-
> >  backends/hostmem.c                    |  2 +-
> >  backends/igvm.c                       |  4 +-
> >  hw/core/machine.c                     |  2 +-
> >  hw/i386/pc.c                          |  6 +--
> >  hw/i386/pc_sysfw.c                    |  8 ++--
> >  hw/i386/x86-common.c                  |  8 ++--
> >  system/memory.c                       | 17 ++++----
> >  system/physmem.c                      | 37 ++++++++++-------
> >  target/i386/kvm/kvm.c                 |  3 +-
> >  tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++
> >  tests/qtest/migration/precopy-tests.c | 12 ++++++
> >  25 files changed, 239 insertions(+), 71 deletions(-)
> > 
> > -- 
> > 2.50.1
> > 
> > 
> 

-- 
Peter Xu



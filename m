Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B01CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0X0-0006Vb-FZ; Thu, 23 Oct 2025 14:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0Wz-0006V4-22
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vC0Ww-0003Cm-AG
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761245959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3RhjhKUwucPWSz6t7LDgdbVxnx7hnOXeNX/ldy7dCag=;
 b=KqBERfEE0Zt8gWeaIJoZaJauIqOGKK+521fJO61TTepki3nVHFHM5ZKGws4gboBhXpymm/
 8rBdKZ4Wsl3VyeowchDQrkpf6K/g5Qvb230bnjBfQuEOeU/sblZVyT/RjHKsRd9nXUaowV
 hpPxE/IgVrKN/ZBZmq6mBgJfFbnQzjw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-4BNruxlQM52UCpLUUA5sKA-1; Thu, 23 Oct 2025 14:59:18 -0400
X-MC-Unique: 4BNruxlQM52UCpLUUA5sKA-1
X-Mimecast-MFC-AGG-ID: 4BNruxlQM52UCpLUUA5sKA_1761245957
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-891215d399dso256531185a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761245957; x=1761850757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RhjhKUwucPWSz6t7LDgdbVxnx7hnOXeNX/ldy7dCag=;
 b=TRS+MwLiktcJr+4c7b+LmEaplTFhwMUAXEgLx5p6GkRF77+jFodE2L7M0dfugcJVx3
 9Ps1P7YdpTdKY2zXOPYF3zWVOUgEqZgvd7Yp9JQ6psU/u5h06lCt7C42VpGE+gdOX7yY
 6D02bibamzbXakRh9wns1ylH+nl3Gq/ZasbL09Up6uoJ6ud7K5islkQz35OtMhKRFCrM
 YPzylByqG6NSehR26aQR6oCUCL7g1biDbrWT7OOI/1aOnsO3gyW242x0oQ0QnQCQbYGS
 SWhd6fF6xEJxmR4TBuEewnUMZ/ZfS2tK3N8oOCcj/D65Pm0bbm2Zj4S2rcIB9Ctau5ob
 EPyw==
X-Gm-Message-State: AOJu0YzOgbB3X8SbXBO5Vjckv6dkBeKkx/HIei9wCGX29Ws0LpCb3n5F
 V0IwdKpYGhjMB8pM9xwx24MbW8r2nc1XSI8AOTK5JAKFJuohiDRWRqWF4x7PCJAuvknzgAT9KaD
 QiraeIFJ/0CgkGx/4+CfgqkeDvJvapIUiRx7JSQC4da22odpPzmGRa7wDHO7bG0J6H9FVm75SC1
 GeN3b/wSGHrS9w+0izTEfhyDurNhFcyE7LfLV3Yg==
X-Gm-Gg: ASbGncsQcbGh31cXUfJF1OmDYtm9KK8sgUCHFRvyikmYi8GrBgKQxQ2xFYtEwRHce27
 gK4ubrawZE1rf+ogIKiACfALTOW5NUSlR43bpcW51cOBQPsfCBgXSxKn7t0LgX2cw4l3qHe8zFg
 xQAz+nqgvpoEfoQRzz8VQvV0sP6rQcP7O4+2MdNrqj3MmyQn1rXeQ+9/CGQxDOh0gKSN2s0x7YD
 1neogRMJnfoSF6kRZDh6oMupaspR1xIp10rKje6+UhdRotmeL7nv1kndHa4m94P1c59D+7G0UFD
 5Qqab1vEb7+99vF3bkU1H288N95XW5OEkIHDrPGXNdELRV0h6AjjHLfIrEqFDgyU
X-Received: by 2002:a05:620a:1a0e:b0:891:d073:907c with SMTP id
 af79cd13be357-891d073913dmr2759144185a.79.1761245956990; 
 Thu, 23 Oct 2025 11:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvxDEXgl5n0kyCUAof/0mmWo/XoMT96WDll3kn1aGAGEmnLZIwn4QviDReeoSF94/1C9qZhw==
X-Received: by 2002:a05:620a:1a0e:b0:891:d073:907c with SMTP id
 af79cd13be357-891d073913dmr2759139785a.79.1761245956420; 
 Thu, 23 Oct 2025 11:59:16 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c0ec61770sm213940585a.26.2025.10.23.11.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 11:59:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/8] KVM/hostmem: Support in-place guest-memfd as VM backends
Date: Thu, 23 Oct 2025 14:59:05 -0400
Message-ID: <20251023185913.2923322-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series allows QEMU to consume guest-memfd in-place, to be a common
memory backend. Before this series, guest-memfd was only used in CoCo and
the fds will be created implicitly whenever CoCo environment is detected.

In the current patchset, I reused the memory-backend-memfd object, rather
than creating a new type of object.  After all, guest-memfd (at least from
userspace POV) really works very similarly like a memfd, except that it was
tailored for VM's use case.

So instead of using a normal memfd backend using:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on

One can also boot a VM with guest-memfd:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on

The in-place guest-memfd here relies on almost the latest linux, as the
mmap() support just landed v6.18-rc2.  When run it on an older qemu, we'll
see errors like:

  qemu-system-x86_64: KVM does not support guest_memfd

One thing to mention is live migration is by default supported, however
postcopy is still currently not supported.  The postcopy support will have
some kernel dependency work that was still being reviewed on mm list, so it
will be a separate work TBD.

Thanks,

Peter Xu (8):
  linux-headers: Update to v6.18-rc2
  kvm: Allow kvm_guest_memfd_supported for non-private use case
  kvm: Detect guest-memfd flags supported
  memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
  memory: Rename memory_region_has_guest_memfd() to *_private()
  ramblock: Rename guest_memfd to guest_memfd_private
  hostmem: Rename guest_memfd to guest_memfd_private
  hostmem: Support in-place guest memfd to back a VM

 qapi/qom.json                                 |  6 +-
 include/standard-headers/linux/ethtool.h      |  1 +
 include/standard-headers/linux/fuse.h         | 22 +++++-
 .../linux/input-event-codes.h                 |  1 +
 include/standard-headers/linux/input.h        | 22 +++++-
 include/standard-headers/linux/pci_regs.h     | 10 +++
 include/standard-headers/linux/virtio_ids.h   |  1 +
 include/system/hostmem.h                      |  2 +-
 include/system/memory.h                       | 16 ++---
 include/system/ram_addr.h                     |  2 +-
 include/system/ramblock.h                     |  7 +-
 linux-headers/asm-loongarch/kvm.h             |  1 +
 linux-headers/asm-riscv/kvm.h                 | 23 ++++++-
 linux-headers/asm-riscv/ptrace.h              |  4 +-
 linux-headers/asm-x86/kvm.h                   | 34 ++++++++++
 linux-headers/asm-x86/unistd_64.h             |  1 +
 linux-headers/asm-x86/unistd_x32.h            |  1 +
 linux-headers/linux/kvm.h                     |  3 +
 linux-headers/linux/psp-sev.h                 | 10 ++-
 linux-headers/linux/stddef.h                  |  1 -
 linux-headers/linux/vduse.h                   |  2 +-
 linux-headers/linux/vhost.h                   |  4 +-
 accel/kvm/kvm-all.c                           | 26 ++++---
 backends/hostmem-file.c                       |  2 +-
 backends/hostmem-memfd.c                      | 68 +++++++++++++++++--
 backends/hostmem-ram.c                        |  2 +-
 backends/hostmem.c                            |  2 +-
 system/memory.c                               |  6 +-
 system/physmem.c                              | 29 ++++----
 29 files changed, 253 insertions(+), 56 deletions(-)

-- 
2.50.1



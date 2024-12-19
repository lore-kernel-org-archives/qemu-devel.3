Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F95E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGt-0004JG-Gx; Thu, 19 Dec 2024 11:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiP-00038c-5i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tOHiN-0002LM-7u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 09:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734619281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=76jSE4Bt6ErxlHP8hWQFcVkQDv1Z2knZrsKerVGsv5M=;
 b=Boe28twKIXWZl6wQlEvgaW7C8bJw9NSTxC+BzmE4Rgd18qE+j/ZiURaNIKHqARle3pc+GI
 gNHycaLfFrmJF+lZ/ioP8vkFbvth3onmkA6mtI896ASEn5FP0U1RmjXKHrywqdYojqL6Ei
 11uOd+arg5IGmI2S7RpL7vCsreIns4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-d06MBCg0MoytmS_JmX5LKw-1; Thu, 19 Dec 2024 09:41:20 -0500
X-MC-Unique: d06MBCg0MoytmS_JmX5LKw-1
X-Mimecast-MFC-AGG-ID: d06MBCg0MoytmS_JmX5LKw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so5411155e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 06:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734619279; x=1735224079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76jSE4Bt6ErxlHP8hWQFcVkQDv1Z2knZrsKerVGsv5M=;
 b=eIi3p03TId9oTwJszVbi0sQnObVU6VzHsH2851EOdtcNHVMX7zw95FFbz5MA5XvdCv
 6CuoMbq0K+ZyRzFAOliOlhPh7tPLdU1JjBO53VOKt2xjOaQBJ8Qgq4oYuIrnJNnuhi0R
 pYpgBfz+Yv1JZOdglsdnl/URBb2h1uAqaWlU9CcObzTBCs+M1ci/rmDFBnQyGjrrDIkp
 0fuCN6qwasQN9xssnUuvWajDxp5H7H9i/GFvVPsHs5C2hHFo6VJwOC4tvrgcI6Fgf7os
 sHughJ9+n1ayS1ndSIAy4XAAAfNrDK62nMMdQ4I7s1ydqx0dHVDiWqEGnTeN5/8TM/ti
 AHaw==
X-Gm-Message-State: AOJu0YyZ2v7K+D5tUpmIGMEe7/+9ZGs6MojnyBnqoEtlI78E4iw5dqM6
 4pMDz6OdAAnNF0SeZlxA/3uYqcrFXqyHDBTThq7bUY6F27eZPMxYvxhpOoqd9rb6yX0itFuup+k
 JJR8znj3fCxut8u7m4D+tLbr/te3HN2XWylC9aT+wN/mjz5wk1xonQZH2el45DQc9fNEjpK7fV0
 e2Je5UGrGGBZaxJ3uw4Hu+5rdoKgZrvt0qJhQ=
X-Gm-Gg: ASbGnctC+o7L43iFuvfjYhTNx4q+RgdQjmsl9+Ju98Vj00vgxOfDcEAxfRUQH5pELES
 b384mthE7dj95HV+HZ8cnLoh1kOQ6mYybQ5p0peRVwYVWA1Myv/oV/IPhzSur7FXTcDmT/eOKaw
 iZaePdfLPD7HvutzYdNAtA9Q5kfMJrCCH04u9rvfz7sdNB0UbNDDt4954jBWs9bhGUa4qsugQjs
 brKP9g/I5Kt5aJ563SacqCAEzif1TSTSZ8RR8r7wI+fYkXd7wQ31qH2Ornq+E+rcLnKT21MVIWv
 KI9sbnG8AJHdVdolitu4+i661bw7qEZA5uILZnbV
X-Received: by 2002:a7b:cde1:0:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-4365c7c9713mr26042265e9.26.1734619279292; 
 Thu, 19 Dec 2024 06:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXT8RyUcO8QSl9OvKQDVO5nyz9LKZerDZif2ke4kT8zU00teSon3++Ze8gcqOY1FzAuvDxAA==
X-Received: by 2002:a7b:cde1:0:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-4365c7c9713mr26041875e9.26.1734619278723; 
 Thu, 19 Dec 2024 06:41:18 -0800 (PST)
Received: from localhost
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b119ccsm53830355e9.24.2024.12.19.06.41.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 06:41:17 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/14] s390x: virtio-mem support
Date: Thu, 19 Dec 2024 15:41:01 +0100
Message-ID: <20241219144115.2820241-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Resending it with minor make-weird-things-compile fixes. Will queue this
shortly again + resend the PULL request if there are no comments. Based on
current master.

There is really not much left to do on s390x, because virtio-mem already
implements most things we need today (e.g., early-migration,
unplugged-inaccessible). The biggest part of this series is just doing what
we do with virtio-pci, wiring it up in the machine hotplug handler and ...
well, messing with the physical memory layout where we can now exceed
initial RAM size and have sparsity (memory holes).

I tested a lot of things, including:
 * Memory hotplug/unplug
 * Device hotplug/unplug
 * System resets / reboots
 * Migrate to/from file (including storage attributes under KVM)
 * Basic live migration
 * Basic postcopy live migration

More details on how to use it on s390x -- which is pretty much how
we use it on other architectures, except
s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.

This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
be documented in the kernel and at [2] once this+kernel part go upstream.

There are not many s390x-specific virtio-mem future work items, except:
* Storage attribute migration might be improved
* We might want to reset storage attributes of unplugged memory
  (might or might not be required for upcoming page table reclaim in
   Linux; TBD)

The Linux driver has been merged into 6.13-rc1.

[1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
[2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec

v2 -> v3:
- "s390x/s390-virtio-hcall: remove hypercall registration mechanism"
 -> Move s390-virtio-hcall.c under CONFIG_S390_CCW_VIRTIO and use
    ugly-but-necessary CONFIG_S390_CCW_VIRTIO in target/ code to
    make it compile with weird configs without CONFIG_S390_CCW_VIRTIO.
    (I don't think we want to use stubs, most of that code does not make
     sense to compile without CONFIG_S390_CCW_VIRTIO; but that will have to
     be a separate cleanup)
- "s390x: introduce s390_get_memory_limit()"
 -> Inline s390_get_memory_limit() for the same reason
 -> Initialize hw_limit to 0 to make some compilers happy
- Adjust other patches to these changes

v1 -> v2:
* "s390x/s390-virtio-hcall: prepare for more diag500 hypercalls"
 - Turn handle_diag_500() into a void function
 - Inject PGM_SPECIFICATION from handle_diag_500() directly
* "s390x/s390-virtio-ccw: move setting the maximum guest size from sclp to
   machine code"
 - Move code to a new function to make further changes easier
 - Adjust s390_pv_vm_try_disable_async() to stay in sync with the
   maxram->ram change
* "s390x: introduce s390_get_memory_limit()"
 - Store limit in machine
 - Move s390_set_memory_limit() from target code into machine code
* "s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT"
 - Move handling into a separate function now that we lookup the machine
* "s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
   layouts"
 - Adjust to s390_get_memory_limit() changes
* "s390x/s390-skeys: prepare for memory devices"
 - Adjust to s390_get_memory_limit() changes
* "s390x/pv: prepare for memory devices"
 - Use s390_get_memory_limit()
* "s390x: remember the maximum page size"
 - Store it in the machine
 - Move s390_set_max_pagesize() from target code into machine code
 - No need for s390_get_max_pagesize()
* "s390x/virtio-ccw: add support for virtio based memory devices"
 - Move machine wire-up code from virtio-mem patch into this patch
 - Add stubs to make compilation without virtio-mem work
* "s390x: virtio-mem support"
 - Move machine write-up code to previous patch

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>

David Hildenbrand (14):
  s390x/s390-virtio-ccw: don't crash on weird RAM sizes
  s390x/s390-virtio-hcall: remove hypercall registration mechanism
  s390x/s390-virtio-hcall: prepare for more diag500 hypercalls
  s390x: rename s390-virtio-hcall* to s390-hypercall*
  s390x/s390-virtio-ccw: move setting the maximum guest size from sclp
    to machine code
  s390x: introduce s390_get_memory_limit()
  s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
  s390x/s390-stattrib-kvm: prepare for memory devices and sparse memory
    layouts
  s390x/s390-skeys: prepare for memory devices
  s390x/s390-virtio-ccw: prepare for memory devices
  s390x/pv: prepare for memory devices
  s390x: remember the maximum page size
  s390x/virtio-ccw: add support for virtio based memory devices
  s390x: virtio-mem support

 MAINTAINERS                        |   5 +
 hw/s390x/Kconfig                   |   1 +
 hw/s390x/meson.build               |  10 +-
 hw/s390x/s390-hypercall.c          |  85 +++++++++++
 hw/s390x/s390-hypercall.h          |  25 ++++
 hw/s390x/s390-skeys.c              |   6 +-
 hw/s390x/s390-stattrib-kvm.c       |  67 ++++++---
 hw/s390x/s390-virtio-ccw.c         | 160 +++++++++++++-------
 hw/s390x/s390-virtio-hcall.c       |  41 ------
 hw/s390x/s390-virtio-hcall.h       |  25 ----
 hw/s390x/sclp.c                    |  17 +--
 hw/s390x/virtio-ccw-md-stubs.c     |  24 +++
 hw/s390x/virtio-ccw-md.c           | 153 +++++++++++++++++++
 hw/s390x/virtio-ccw-md.h           |  44 ++++++
 hw/s390x/virtio-ccw-mem.c          | 226 +++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw-mem.h          |  34 +++++
 hw/virtio/Kconfig                  |   1 +
 hw/virtio/virtio-mem.c             |   4 +-
 include/hw/s390x/s390-virtio-ccw.h |   9 ++
 target/s390x/cpu-sysemu.c          |  15 --
 target/s390x/cpu.h                 |   2 -
 target/s390x/kvm/kvm.c             |  21 +--
 target/s390x/kvm/pv.c              |   2 +-
 target/s390x/tcg/misc_helper.c     |  10 +-
 24 files changed, 790 insertions(+), 197 deletions(-)
 create mode 100644 hw/s390x/s390-hypercall.c
 create mode 100644 hw/s390x/s390-hypercall.h
 delete mode 100644 hw/s390x/s390-virtio-hcall.c
 delete mode 100644 hw/s390x/s390-virtio-hcall.h
 create mode 100644 hw/s390x/virtio-ccw-md-stubs.c
 create mode 100644 hw/s390x/virtio-ccw-md.c
 create mode 100644 hw/s390x/virtio-ccw-md.h
 create mode 100644 hw/s390x/virtio-ccw-mem.c
 create mode 100644 hw/s390x/virtio-ccw-mem.h

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A2C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzCj-00032A-97; Tue, 25 Aug 2026 18:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCf-0002ld-O9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:10 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCd-00015z-61
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:09 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so526084a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695265; x=1788300065; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QiElhV40kLZgn2p0ydPjTL1vJDUlrNWu2jfkcIQqWeo=;
 b=miLndCZuRukfYf9CZFxdl/clBNt+J25Aii1OKhrCZ0RM52lrkg5fA1E8t7XIZf7LHW
 fFFlQYnjckjJIP8BDvR4KXJ26sHOTJR1RN2cf/B/zSwG5KRBLxCs+X83G9iHXXW92OzG
 L/goTX3VTTY+SipHAzq04fVTc4Z6Y/ADQNb+TaOM7XAODiA9XRGHDFLF2Iimy2Dn9eFd
 JBRysgmDO51MpHhNiubVszXPXEKGwjL1Tax1GWFYtNcFX7KUtM5YwWaNnSADyWIziotn
 +EPg8lLmQZl8W8xV/k09FQtXfzUyb2MUa435DoF/zoGkvaTN9Cy2jrj+Io/ZFpP8fTc2
 +b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695265; x=1788300065;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QiElhV40kLZgn2p0ydPjTL1vJDUlrNWu2jfkcIQqWeo=;
 b=BKy/ZnEFaGZehx3Y9eICAjqZzsK7KDyErmqy8mEhM2sB09LpERrMZmX/+FdjhuyDLr
 Q4wp30ryoJKyvJW2rSIcyKPwYL5+YeFIuE0p2Fdp6kUERhxfDJNZXWoIXINw7TD/XpNf
 yQlW2Q12vf7xw/FPjLFelL7wuceWpb3h7QvdXmTsQBJg5YXg51weQPxu/Xq33sUCXOUQ
 wP3aKmve/09aNGy7WCuTw5YJOGIwsX6MGbvy/XdTxqbRmIt7dm+rmCDW2ggYQX+yBAfm
 5/nA3D1gp0tx3X3oVJBrNnNweWNsvxnmlVaMDUMZddOVAHliV6KdzbGNA/g/2bV4btVu
 vnlQ==
X-Gm-Message-State: AFuF++lP+sct8dXrNlz1lr/NiwLFjc0tshHkV/UEAM3CZcQju2ufqQjH
 ZNqPyX1U/DXA8TYUR/FCBL1FRBEGHATEw6xKCMjxcN4Knd+VVh/aOU/eahaDDLAYxBg=
X-Gm-Gg: AR+sD10ZPaEZW2ViHb1waITfwxcB0bXGtuxNE7Vyg49Di2pVtXFQEsMa1znbiVyKOY7
 ovYz0NQl8mhAS3mHAxsY0C7x8Piw2Ze3BBjti4B8f23uuBEII7+iCMAjCIxGvh9Dq6ql358eLhp
 LQ3swXJ5/uieQLWs1vJNwp7beCGql/EERzSP5O2Ri2w+kHuiQsMljUP6Uw+ZonhF41EkaYnwQE6
 soAdNxOro/5dESy2zLE6RdPSfAJPwmODZY5Xm4AWP735Ayh4wdEvhFwjLwmUS+bT0oTdkzXWRst
 73bMTYCsLeEoIoB/yHha+HKmagMmlbHSEKpj1OQeEcPBkv4D7q7tkWu/61m8tHegLWCqlE0E+kS
 4Y7Lmt0NBRxwt3I7YncT5DNXko2a07sn14Jk9pi3Bm0UYuTy5LrD/aKYLkgD9YcU6gPUKxRJH8r
 0yqyZ9O3MCK7cBXP6m/mQvnFo5hkhUeOSFZgAAC9gLn9myOx/WvlyLIiSFn8zYoPCYdFI/8ly46
 nCM6PijvlLhzHQ=
X-Received: by 2002:a17:90b:2885:b0:380:71eb:4014 with SMTP id
 98e67ed59e1d1-3966d5c1a78mr4454909a91.15.1787695264783; 
 Tue, 25 Aug 2026 15:01:04 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:03 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 00/24] Add Realm support to QEMU-VMM
Date: Tue, 25 Aug 2026 16:00:37 -0600
Message-ID: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset provides minimal functionality to start a Realm VM
from an Arm RME capable host using the following command line:

qemu-system-aarch64 \
 -M confidential-guest-support=rme0,memory-backend=ram0 \
 -object rme-guest,id=rme0,convert-in-place=on \
 -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
 -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..

It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
back.  It is compatible with Steven Price's v16 revision [1] of his work adding
CCA support to KVM.

This revision is based on Michael Roth's work on guest memfd in-place memory
conversion [2] and as such, the QEMU baseline is different from 'master'.  Other
than modifications to use in-place memory conversion from Lorenzo Pieralisi that
were integrated to patches 04, 08-11, it is identical to V2.   

It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
here [3], along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
with Steven's v16 patchset).  The Repository for the kernel [6] is available
from Arm.

Instructions to compile and run the entire stack can be found here [7].

Device Assignment is not included.

Thanks,
Mathieu

[1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
[2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
[3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3?ref_type=heads
[4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
[5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
[6]. https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16?ref_type=heads
[7]. https://gitlab.com/Linaro/cca-public/build-instructions

RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

Jean-Philippe Brucker (23):
  linux-headers: Add RME related definitions
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm: Add confidential guest support
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch Realm VM when requested
  target/arm/kvm: Use kvm_vm_check_extension() where necessary
  hw/core/loader: Add a ROM loader notifier
  target/arm/kvm-rme: Keep track of images loaded in Realm memory
  target/arm/kvm-rme: Populate Realm with runtime images
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/cpu: Don't read Realm registers
  hw/arm/virt: Set proper conduit method for Realms
  hw/arm/virt: Embed Realm VM type with IPA address space
  hw/arm/virt: Reserve one bit of guest physical address for RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware
  target/arm/kvm-rme: Add DMA remapping for the shared memory region
  docs/interop/firmware.json: Add arm-rme firmware feature
  hw/arm/boot: Load DTB as is for confidential VMs
  hw/arm/boot: Skip bootloader for confidential guests

Mathieu Poirier (1):
  target/arm/kvm-rme: Add mechanic to initialize realms

 docs/interop/firmware.json                 |   5 +-
 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 hw/arm/boot.c                              |  70 ++++-
 hw/arm/virt.c                              | 142 +++++++--
 hw/core/loader.c                           |  15 +
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/core/loader.h                   |  17 ++
 linux-headers/asm-arm64/kvm.h              |   9 +
 linux-headers/linux/kvm.h                  |  12 +-
 qapi/qom.json                              |  13 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu.h                           |  10 +
 target/arm/cpu64.c                         | 122 ++++++++
 target/arm/kvm-rme.c                       | 336 +++++++++++++++++++++
 target/arm/kvm-stub.c                      |   9 +
 target/arm/kvm.c                           | 202 ++++++++++++-
 target/arm/kvm_arm.h                       |  20 ++
 target/arm/meson.build                     |   5 +-
 21 files changed, 963 insertions(+), 51 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.43.0



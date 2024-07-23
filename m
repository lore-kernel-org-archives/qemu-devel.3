Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F5C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGIo-0003R8-Sy; Tue, 23 Jul 2024 10:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIm-0003GQ-0y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGIj-00075w-Gm
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a4SLVcHD1ny7i1Gh9+ZamR66knHG3W4qX8EoC4WInqc=;
 b=Iajl2SE51biE7iJM9y4hY42kYVMectBMJLYj+ZHetVELn7IsplwpNVP/dt6M3pxq+fJ+Xs
 AN+5FJOWQqsB1rXx39DxnOKVCoLoYRp5V7pFZ3i6pOCNfXv77gIzQe+xLUjx440YBpolxW
 2bWGVAlAUxh4gC3sebYLqg+7b3nAdts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-5Vh3wNgXPISnYXPuT-bETg-1; Tue, 23 Jul 2024 10:15:33 -0400
X-MC-Unique: 5Vh3wNgXPISnYXPuT-bETg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3688010b3bfso3905435f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744132; x=1722348932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4SLVcHD1ny7i1Gh9+ZamR66knHG3W4qX8EoC4WInqc=;
 b=Zgf8BoxsYipIVU2LuTAIbCMdnAsM7tNbCVhm/ChzD24ptmupjl/vpmpybQC7Sf59Ig
 VMPNg3RRV8Mo/XjfOvmGKCMMdqtMr+21dQqenIKbu6kEv7JNwSbnLVkO+ZiDsv8kIt4c
 3HLyonN7m1PU0xDiUXygH5eSWjY7VAqYMb2H8LZIoKqm9eq6Gyd35tySxY62KBi3dJFz
 0ohi8IP7a+LNtUWM7VuDEiDTn7VeSErIrleoAlTXQ78cdRBe5sq5sNTU/4nTcl7wz/No
 Kuwd2FK9kzWPxuecNLQdzqVNUGrtGsVrEPcyYxZYLYIawvLpDEvjZ+L+a8bIkMbEsz8x
 rXAw==
X-Gm-Message-State: AOJu0YzEAqNgdd+fUUPJK42gLI1AmwTOpdZhB2G+vLRYk99zx1nM9mJk
 fYRGw8KGchFlsxZemQdU7vmZCuciZ5g6QPF35BkxV8tFVxx3lCsMK6rryLNkRWKhYe1EudLz9ox
 O3onP4kVagrtFuV0qJ/i2xtOu1FIfw6Y5Zt2oo7RxLbsu/ydTNjGuahM8bnUwSo1Ra9Yblo9YYp
 SsZbkaFEoHobfMtAmFMyRdRKs9uM4+NO/z+AOI
X-Received: by 2002:adf:e68a:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-369bae3a608mr7599529f8f.3.1721744132321; 
 Tue, 23 Jul 2024 07:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfIPHTWS4OYy6Tgx08IXGBSWJrRvG90UIv0lIbWUz07Zyysa/D034WVb7rlKAQX6h2qItLhg==
X-Received: by 2002:adf:e68a:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-369bae3a608mr7599500f8f.3.1721744131792; 
 Tue, 23 Jul 2024 07:15:31 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878695b35sm11640184f8f.65.2024.07.23.07.15.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target/i386, HPET changes for QEMU 9.1 soft freeze
Date: Tue, 23 Jul 2024 16:15:18 +0200
Message-ID: <20240723141529.551737-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7c912ffb59e8137091894d767433e65c3df8b0bf:

  hpet: avoid timer storms on periodic timers (2024-07-22 19:19:44 +0200)

----------------------------------------------------------------
* target/i386/kvm: support for reading RAPL MSRs using a helper program
* hpet: emulation improvements

----------------------------------------------------------------
Anthony Harivel (3):
      qio: add support for SO_PEERCRED for socket channel
      tools: build qemu-vmsr-helper
      Add support for RAPL MSRs in KVM/Qemu

Paolo Bonzini (8):
      target/i386: do not crash if microvm guest uses SGX CPUID leaves
      hpet: fix and cleanup persistence of interrupt status
      hpet: ignore high bits of comparator in 32-bit mode
      hpet: remove unnecessary variable "index"
      hpet: place read-only bits directly in "new_val"
      hpet: accept 64-bit reads and writes
      hpet: store full 64-bit target value of the counter
      hpet: avoid timer storms on periodic timers

 MAINTAINERS                              |   1 +
 docs/specs/index.rst                     |   1 +
 docs/specs/rapl-msr.rst                  | 155 +++++++++
 docs/tools/index.rst                     |   1 +
 docs/tools/qemu-vmsr-helper.rst          |  89 ++++++
 meson.build                              |   7 +
 include/io/channel.h                     |  21 ++
 include/sysemu/kvm_int.h                 |  32 ++
 target/i386/cpu.h                        |   8 +
 target/i386/kvm/vmsr_energy.h            |  99 ++++++
 tools/i386/rapl-msr-index.h              |  28 ++
 accel/kvm/kvm-all.c                      |  27 ++
 hw/i386/sgx.c                            |   6 +-
 hw/timer/hpet.c                          | 329 +++++++++----------
 io/channel-socket.c                      |  28 ++
 io/channel.c                             |  13 +
 target/i386/kvm/kvm.c                    | 431 ++++++++++++++++++++++++-
 target/i386/kvm/vmsr_energy.c            | 345 ++++++++++++++++++++
 tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++++++++++
 contrib/systemd/qemu-vmsr-helper.service |  15 +
 contrib/systemd/qemu-vmsr-helper.socket  |   9 +
 hw/timer/trace-events                    |   4 +-
 target/i386/kvm/meson.build              |   1 +
 23 files changed, 1995 insertions(+), 185 deletions(-)
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 docs/tools/qemu-vmsr-helper.rst
 create mode 100644 target/i386/kvm/vmsr_energy.h
 create mode 100644 tools/i386/rapl-msr-index.h
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 tools/i386/qemu-vmsr-helper.c
 create mode 100644 contrib/systemd/qemu-vmsr-helper.service
 create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
-- 
2.45.2



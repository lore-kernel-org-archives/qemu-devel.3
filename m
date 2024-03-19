Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC744C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma0z-0005Ya-N7; Tue, 19 Mar 2024 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0g-0005Wz-Ia
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0e-00072j-SH
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0hwkQPmRbUVgGdEZ7kTUHbl5qvn1KLyjDLH9eX7JDOM=;
 b=WBn4L/wmyKqPWC4o/cXdoECxJNZcHjgy0/ZdF3x3qYgntVRNgfPMy2RZwTJs4veVoaIMvD
 itEdtm6xn02iWRfnDwVP9sdMsjHnSew4XvmXRWKoNqkOtv93aYHaplRzKtzUS5t6MbvdM1
 YehKVf+foAb1sUsnVItYZVFGtMVZCE8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-sqAQQlhIPcqw6lSAM_oZwA-1; Tue, 19 Mar 2024 10:00:05 -0400
X-MC-Unique: sqAQQlhIPcqw6lSAM_oZwA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a468654002fso253689866b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856803; x=1711461603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hwkQPmRbUVgGdEZ7kTUHbl5qvn1KLyjDLH9eX7JDOM=;
 b=u0FZ3TrX7gTCUUg3zbaKu6xZ41jK3M5FvIzriU8+LaCFUBFbywW7yZkGlomGDTVJ7j
 xfWohlktN+iSHP9aQbyHP4g81aC2Cc5QgV9slZCUpUXWZ7NNDNKF3E++vhd1IyXl5XH3
 qAEYueaS4mLn+0DdCtorZAtVkWD6PSxxYbtQ7XUq5EzhPWaaaUYwjXXeOd6iLE1K6elU
 nlk6goltU/2yXp+xJIswjUqkC48f3cmZjmnEWwpwyLmy2pk3/jpaqUIEo5sKvr+SRD6o
 wzXlIRFZ91CMzKcmiPaVHzXraOquA+CqGjzsfTzd87ZSeaPJZbw5B5q38//Ci9tKaHBk
 +lnA==
X-Gm-Message-State: AOJu0Yz+no4uvstJv9kQRTh1579OzYfVgEadP6oDA8dxfknL5qHxTQg5
 PSmhJf4UuwkXhuKOWzs/TYo/S5FLAaOcHfM63/68n2seQl4pBY/v3bfIfHGBgXhozQiOYuI7RDJ
 dD66SoH3doCUcONUg76korSdOY3WOYREnRn5o8YDkTo8P1tjQaNkzSA72P8DBYKZbuQQp96SeS5
 LDIEaph+dgrAG6s0MerBLq7t9yw/eEfDLOSZEB
X-Received: by 2002:a17:906:2a10:b0:a46:a662:e543 with SMTP id
 j16-20020a1709062a1000b00a46a662e543mr5607948eje.48.1710856803300; 
 Tue, 19 Mar 2024 07:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUUWwQijPZN/OHZZqn5xJzTqLl0A8vxd2o111stlcty/EHuC8kPQy8l07ey7me8VsLqKUmLg==
X-Received: by 2002:a17:906:2a10:b0:a46:a662:e543 with SMTP id
 j16-20020a1709062a1000b00a46a662e543mr5607930eje.48.1710856802781; 
 Tue, 19 Mar 2024 07:00:02 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 lb9-20020a170906adc900b00a46b87c32besm2846265ejb.39.2024.03.19.07.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 0/7] target/i386: VM type infrastructure and KVM_SEV_INIT2
 support
Date: Tue, 19 Mar 2024 14:59:53 +0100
Message-ID: <20240319140000.1014247-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds another vendor-neutral part of the SEV-SNP/TDX support
patches, namely support for KVM_CAP_VM_TYPES.  In Linux 6.10 this will
also be available for SEV and SEV-ES, so introduce it now already.

Also, Linux 6.10 will _not_ allow KVM_GET/SET_* ioctls for VMs with
encrypted state and a VM type other than KVM_X86_DEFAULT_VM, so prepare
for that.

The patches are not yet available in kvm.git, hence the hackish
linux-headers update in patch 1.  Apart from that, however, the API
should be final.

Tested by booting a SEV-ES guest.

Paolo

Based-on: <20240229060038.606591-1-xiaoyao.li@intel.com>

Paolo Bonzini (6):
  linux-headers hack
  runstate: skip initial CPU reset if reset is not actually possible
  KVM: track whether guest state is encrypted
  KVM: remove kvm_arch_cpu_check_are_resettable
  target/i386: introduce x86-confidential-guest
  target/i386: SEV: use KVM_SEV_INIT2 if possible

Xiaoyao Li (1):
  target/i386: Implement mc->kvm_type() to get VM type

 include/sysemu/kvm.h             | 12 ++-----
 include/sysemu/kvm_int.h         |  1 +
 linux-headers/asm-x86/kvm.h      |  8 +++++
 linux-headers/linux/kvm.h        |  2 ++
 target/i386/confidential-guest.h | 59 ++++++++++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h       |  2 ++
 accel/kvm/kvm-accel-ops.c        |  2 +-
 accel/kvm/kvm-all.c              | 19 ++++++----
 hw/i386/x86.c                    |  6 ++++
 system/runstate.c                | 15 +++++++-
 target/arm/kvm.c                 |  5 ---
 target/i386/confidential-guest.c | 33 ++++++++++++++++++
 target/i386/kvm/kvm.c            | 49 +++++++++++++++++++++++---
 target/i386/sev.c                | 48 ++++++++++++++++++++++----
 target/loongarch/kvm/kvm.c       |  5 ---
 target/mips/kvm.c                |  5 ---
 target/ppc/kvm.c                 |  5 ---
 target/riscv/kvm/kvm-cpu.c       |  5 ---
 target/s390x/kvm/kvm.c           |  5 ---
 target/i386/meson.build          |  2 +-
 20 files changed, 226 insertions(+), 62 deletions(-)
 create mode 100644 target/i386/confidential-guest.h
 create mode 100644 target/i386/confidential-guest.c

-- 
2.44.0



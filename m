Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15ACC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL8o-0002en-53; Tue, 20 Feb 2024 03:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL8m-0002d9-03
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL8j-0000Mb-1n
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v3pJu2vTudPnKcG+w3eV2U8dIOCns2Bhsw8Qrv9GaA0=;
 b=R2n8e6+GJsypMEynAfHe7NTEL8+FnOIVTZZIerpo/rdLwk1Nqy96Hdl8k+X3GzlZWVqTwF
 UhMTgSDtQ4o/bCuHX93YQL8wRYZeflw3xWHxsC8Ns1B1A9LWPRyDDCYUAVgq1O4K5CJ2LX
 Rwk9G6V4kl4Fr/rVL0SToI5Pjg9oIpc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-T9XA_tCrN8O6f8gw1IMsYQ-1; Tue, 20 Feb 2024 03:06:05 -0500
X-MC-Unique: T9XA_tCrN8O6f8gw1IMsYQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3ec1d8b1e2so85962766b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416363; x=1709021163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v3pJu2vTudPnKcG+w3eV2U8dIOCns2Bhsw8Qrv9GaA0=;
 b=fMAIgiC4WtvN4BHpfzwF07OxadYwlNuw83a0tiqSDso7huDQxsZWttUAUlz+xOdxyD
 1TscxmyPqwj9DATYvK7ItdRD6scKG012vQdjhd4Qq/8CaUvOskMiSrMN6M4O/mBXPLlZ
 6RG3RF+uHRS/HG/Ol1GkxW13B41Mg8UBLHlbKDrrYBGKcOGo9rqnepG3CIOr0/1DVcvT
 xstAncsu0N0pnTgnYi+1koztjdAfe6KlSolvZiSemZuGC8gIIYcmiQs8FNHncMjO27kA
 LuloJvRxbHNztqKLs/NuI5YrjjkFozNUPSBou2MKWL1syT9YPIswi62BfX/D0JPDoOtk
 J15w==
X-Gm-Message-State: AOJu0Yz3GmTdpz9tG3JIyGr+hS5sLaACuJnR2DZ43XFaglq2AAGfxNyi
 mTVt23sMgiD6OwItx+CTrPdCa62PVL32SegNWWE3rwqBfjq4FVe3+5EORqp/HwzzBJZwBQcgMUl
 LDLI/UknLKaxf0aUPDKMRkmUNsf5OnBvxAhOqa5Gq8ms1oAHmp5tukYrNh8BtIp3lUgsuKDBDsO
 alv1BYG1OnGpwi38rgRU+207VyTANGg7dEItSY
X-Received: by 2002:a17:906:b0d9:b0:a38:63d4:2273 with SMTP id
 bk25-20020a170906b0d900b00a3863d42273mr10200833ejb.35.1708416363473; 
 Tue, 20 Feb 2024 00:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6NkT51WHUu5Fh9vKRsDqacWPxr5FSJQjS8yPCh9X190t2gJbdmyNFxPcLvh5rG6e/SyHEkQ==
X-Received: by 2002:a17:906:b0d9:b0:a38:63d4:2273 with SMTP id
 bk25-20020a170906b0d900b00a3863d42273mr10200813ejb.35.1708416363034; 
 Tue, 20 Feb 2024 00:06:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 jj12-20020a170907984c00b00a3e64bcd2c1sm2463283ejc.142.2024.02.20.00.05.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Build, x86 patches for 2024-02-16
Date: Tue, 20 Feb 2024 09:05:41 +0100
Message-ID: <20240220080558.365903-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 3ff11e4dcabe2b5b4c26e49d741018ec326f127f:

  Merge tag 'pull-target-arm-20240215' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-15 17:36:30 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5f9beb5001738d9d32bb8a617ed0528d99d7f09a:

  ci: Fix again build-previous-qemu (2024-02-16 13:56:09 +0100)

----------------------------------------------------------------
* Some hw/isa cleanups
* Fixes for x86 CPUID
* Cleanups for configure, hw/isa and x86

----------------------------------------------------------------
Paolo Bonzini (8):
      mips: remove unnecessary "select PTIMER"
      isa-superio: validate floppy.count value
      smc37c669: remove useless is_enabled functions
      configure: do not create legacy symlinks
      configure: put all symlink creation together
      i386: xen: fix compilation --without-default-devices
      usb: inline device creation functions
      ci: Fix again build-previous-qemu

Xiaoyao Li (8):
      i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when CPUID_EXT_XSAVE is not available
      i386/cpu: Mask with XCR0/XSS mask for FEAT_XSAVE_XCR0_HI and FEAT_XSAVE_XSS_HI leafs
      target/i386: Add support of KVM_FEATURE_ASYNC_PF_VMEXIT for guest
      i386/pc: Drop pc_machine_kvm_type()
      physmem: replace function name with __func__ in ram_block_discard_range()
      i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
      i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
      i386/cpuid: Move leaf 7 to correct group

Ziqiao Kong (1):
      target/i386: Generate an illegal opcode exception on cmp instructions with lock prefix

 configure                   | 20 +++++---------------
 include/hw/i386/pc.h        |  3 ---
 include/hw/usb.h            | 27 ++++++++++++++++++++++++---
 hw/i386/pc.c                |  5 -----
 hw/isa/isa-superio.c        |  4 +++-
 hw/isa/smc37c669-superio.c  | 18 ------------------
 hw/usb/bus.c                | 23 -----------------------
 system/physmem.c            | 38 +++++++++++++++++---------------------
 target/i386/cpu.c           |  8 +++++---
 target/i386/kvm/kvm.c       |  7 ++-----
 target/i386/tcg/translate.c | 11 ++++++-----
 .gitlab-ci.d/buildtest.yml  |  2 +-
 accel/Kconfig               |  1 +
 hw/mips/Kconfig             |  1 -
 14 files changed, 64 insertions(+), 104 deletions(-)
-- 
2.43.0



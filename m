Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9w0-0004sJ-7H; Thu, 23 May 2024 11:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vx-0004iJ-JD
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9vv-0004me-Ng
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+cz7/A2Vd7WnBcData+m1wJymCreFQbA7KiqEEru/k8=;
 b=hZtOARx/91xuFcNmGnNr3JYS7ZSaewLwtobl2BSxBD2NUna4MQWowQF0hzD9KdPEBmupuD
 AS5wK04TMeOZbE2xzfNPBR6SV50JbfJhrEBL6xjv0VLwy+o3/lm3vUiUmN7NvUxHWUggPv
 jXBTpHarEH6rS0e1BFV5D1Sa7lyyq/E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-AJN56AajOtWgsKTs7Ft6fQ-1; Thu, 23 May 2024 11:00:40 -0400
X-MC-Unique: AJN56AajOtWgsKTs7Ft6fQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso147553166b.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476438; x=1717081238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+cz7/A2Vd7WnBcData+m1wJymCreFQbA7KiqEEru/k8=;
 b=VsHNxuggvlRrFsydiMu+i7guZqHO1RgtkUnJMPd8HlWTWaV8ZcCt8BdXOm0lUdnAHf
 Oc7e+CDVOc666bE+CDdYU/05t6jAQcnFz6ew8EDsZ88AP2GWnyMrUoctSrwWyXGt+XS3
 lpYK8f1L0vzYO4RZn2EomjqsaQM2/Gvn5UGpAMRvT/SL24rUjpfyHeFFY3+AkQYqzIqs
 yye3rnvqVIRrrN2kX9Stn2IUUMo03c0btySMTQD7qJf8H3Rpw2Hn0FSsVqMk/asgfiOR
 U/2vbf1lSWttVOMyEYJYBoFvKHymDM4j0nb2pT1ecaq/UqJv/MvEuSrhJwRDx5SZsegr
 qP+A==
X-Gm-Message-State: AOJu0YypboClEcFr+ra1L6S8JrFXViupYeMMfauAYYxPGBUVCZfe4h7A
 7ROdnMEEogDJgWZQCtTPkFHTbh/4u1xqffmjJCTihmHPtoShEe5ujDK2iypVAxUGn0ecA2PT9ML
 u3YuyW5TkGlyl1ZO2V9WVpS3ZV7R8TncQo9lPw0g8U0tBPn9HrnPZ9I3blyC9hXb7rHnPRT9cxe
 KNwGECXpQS4JY//WPDphhT4sJQ43n4EKcToa5G
X-Received: by 2002:a17:906:b887:b0:a5a:1a:b0e6 with SMTP id
 a640c23a62f3a-a62280b2e16mr478656366b.9.1716476438633; 
 Thu, 23 May 2024 08:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWVLHd61+4NF3uxgdUWkhnHgiVbR2XGKGNk1v2h6XY72LHzeKOHAH3QvHx9SN17DU88AIC8Q==
X-Received: by 2002:a17:906:b887:b0:a5a:1a:b0e6 with SMTP id
 a640c23a62f3a-a62280b2e16mr478653766b.9.1716476437959; 
 Thu, 23 May 2024 08:00:37 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c6b1sm1951952666b.57.2024.05.23.08.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:00:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] i386 changes for 2024-05-23
Date: Thu, 23 May 2024 17:00:13 +0200
Message-ID: <20240523150036.1050011-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 01782d6b294f95bcde334386f0aaac593cd28c0d:

  Merge tag 'hw-misc-20240517' of https://github.com/philmd/qemu into staging (2024-05-18 11:49:01 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 84d4b72854869821eb89813c195927fdd3078c12:

  target-i386: hyper-v: Correct kvm_hv_handle_exit return value (2024-05-22 19:56:28 +0200)

----------------------------------------------------------------
* hw/i386/pc_sysfw: Alias rather than copy isa-bios region
* target/i386: add control bits support for LAM
* target/i386: tweaks to new translator
* target/i386: add support for LAM in CPUID enumeration
* hw/i386/pc: Support smp.modules for x86 PC machine
* target-i386: hyper-v: Correct kvm_hv_handle_exit return value

----------------------------------------------------------------
Bernhard Beschow (1):
      hw/i386/pc_sysfw: Alias rather than copy isa-bios region

Binbin Wu (1):
      target/i386: add control bits support for LAM

Paolo Bonzini (2):
      target/i386: generate simpler code for ROL/ROR with immediate count
      target/i386: clean up AAM/AAD

Robert Hoo (1):
      target/i386: add support for LAM in CPUID enumeration

Zhao Liu (16):
      i386/cpu: Fix i/d-cache topology to core level for Intel CPU
      i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]
      i386/cpu: Use APIC ID info get NumSharingCache for CPUID[0x8000001D].EAX[bits 25:14]
      i386/cpu: Consolidate the use of topo_info in cpu_x86_cpuid()
      i386/cpu: Introduce bitmap to cache available CPU topology levels
      i386: Split topology types of CPUID[0x1F] from the definitions of CPUID[0xB]
      i386/cpu: Decouple CPUID[0x1F] subleaf with specific topology level
      i386: Introduce module level cpu topology to CPUX86State
      i386: Support modules_per_die in X86CPUTopoInfo
      i386: Expose module level in CPUID[0x1F]
      i386: Support module_id in X86CPUTopoIDs
      i386/cpu: Introduce module-id to X86CPU
      hw/i386/pc: Support smp.modules for x86 PC machine
      i386: Add cache topology info in CPUCacheInfo
      i386/cpu: Use CPUCacheInfo.share_level to encode CPUID[4]
      i386/cpu: Use CPUCacheInfo.share_level to encode CPUID[0x8000001D].EAX[bits 25:14]

Zhuocheng Ding (1):
      tests: Add test case of APIC ID for module level parsing

donsheng (1):
      target-i386: hyper-v: Correct kvm_hv_handle_exit return value

 include/hw/i386/pc.h             |   1 +
 include/hw/i386/topology.h       |  60 +++++++-
 target/i386/cpu.h                |  43 +++++-
 target/i386/helper.h             |   4 +-
 hw/i386/pc.c                     |   3 +
 hw/i386/pc_piix.c                |   3 +
 hw/i386/pc_q35.c                 |   2 +
 hw/i386/pc_sysfw.c               |   8 +-
 hw/i386/x86-common.c             |  54 +++++--
 hw/i386/x86.c                    |  13 +-
 target/i386/cpu.c                | 310 +++++++++++++++++++++++++++++++--------
 target/i386/helper.c             |   4 +
 target/i386/kvm/hyperv.c         |   2 +-
 target/i386/kvm/kvm.c            |   3 +-
 target/i386/tcg/int_helper.c     |  19 +--
 tests/unit/test-x86-topo.c       |  56 ++++---
 target/i386/tcg/decode-new.c.inc |   4 +-
 target/i386/tcg/emit.c.inc       |  34 +++--
 qemu-options.hx                  |  18 ++-
 19 files changed, 491 insertions(+), 150 deletions(-)
-- 
2.45.1



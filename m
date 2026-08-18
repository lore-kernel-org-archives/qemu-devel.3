Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B1C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwZFh-0001TC-B8; Wed, 19 Aug 2026 01:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3OsSEagcKCjEWNPXlYVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jackyli.bounces.google.com>)
 id 1wwQfw-0005z8-3f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:48 -0400
Received: from mail-pg1-x545.google.com ([2607:f8b0:4864:20::545])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3OsSEagcKCjEWNPXlYVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jackyli.bounces.google.com>)
 id 1wwQft-0007Ke-JT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:44:47 -0400
Received: by mail-pg1-x545.google.com with SMTP id
 41be03b00d2f7-cb835525b10so227611a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787085882; x=1787690682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zgsgqcz30KQGgMzP9vxq2oYMMooKqJ9S2gmDtPTjvA8=;
 b=l2aJjN8LYuD51dxTnAoD4PsZn1uiKdze2lURozpuw72QzAC99tJhe13Hu0SMSpIx6n
 poM1dYJbrEcI3DvwN+oSEQWTKrLfZt4wbyZ3pLvxqcVgzQbOrUkKBGq2UZLeppqE463N
 qMLb81cfHNS6VM0cKDBS3hnjv2o/8Rkh1IQv91+rEakqqOarjXRgXjQWWFAF23311dae
 aeGh4shRVbn01ZG6gFBxMe1TSlOGw0OZne8blb7hRBtAfoGC8WxXeImdapSDAfBHIbkW
 O5+Gw5rOBP5haN7sjCARISCxhbVE5ayVv85VFZkvARSLlr8gDtZ5203DE3z1N2h5hGwj
 6j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085882; x=1787690682;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zgsgqcz30KQGgMzP9vxq2oYMMooKqJ9S2gmDtPTjvA8=;
 b=OKSmxKDGUyItbDPy6Qrcex8LQQT75+8hAtQlrmWbASc3Qd0QOitxKfP+2qEdk5t5Qb
 NClq6+2b0DSY9gwNc+OwBxvT7vIolLc1J393XT0ZFjDtsTrLk/vkfYsjl2dsXEK999C8
 NgJtPlWQbh6q0cBzbVd8XyP18BQz0y0mUp41jI5bSb4Vhzsyz9/+ZCYD/fYTRwXE64t7
 wSOTe9yaeux2NYsKcjB/ItryBPQZWjVL8jotgfJOvxhazrmZkCVvbgRsNkCmPPyDHyt3
 qEW0HIx+NR/xXWSHCQvYrwudHkoZ18J99onVeD/CiXJ16nzKrtk6wUuNPsw3xdvBntuG
 SBPA==
X-Gm-Message-State: AOJu0Yzt1yw7WuNz4Z88fJsStk0a2UBq9f4sLNK/2AbjOHSNm81FWVp1
 wIcloX0AdL+1dFPI8xTwwP0wp4IKbRZBp14vSYG7VhKCv7Na1iNIzdnmITLxfK+jwt4zmWd8Kcs
 XDYDey4TGUIRtRjfZrwMwSXyBCzW0GYyMsjfaADNJJF/UaK2ZOHciSHAHNlM6Vn3xU41dsf3QAs
 nhz2HG5ULBtAvm8wn7QTgsb85MBceXNK+9WW3JsK8=
X-Received: from pgbg13.prod.google.com ([2002:a63:520d:0:b0:cbe:9dc7:9efa])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:94c8:b0:3c4:1c9f:d81
 with SMTP id adf61e73a8af0-3ccff3c3fd3mr751374637.7.1787085882100; Tue, 18
 Aug 2026 13:44:42 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:14 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB7EhGoC/32Nyw6CMBBFf4V07Zg+eBRX/odhUdoBGpWSFhsJ4
 d8trNzo8tzJObOSgN5iIJdsJR6jDdaNCdgpI3pQY49gTWLCKS9pxWvoUM0vjzDdcQGDEbRU6WZ
 aWbQ5SdrksbPvI3lrEg82zM4vx4fI9vVPLDKgoIURvFBtVdd47Z3rH3jW7rnHD1My9sOUpkKZF
 yXjVHybzbZtHzLFcVnrAAAA
X-Change-Id: 20260729-feature-pkey-dev-c8a026db85b4
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 0/6] Protect VMM from speculative attacks using x86 PKRU
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, 
 Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::545;
 envelope-from=3OsSEagcKCjEWNPXlYVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--jackyli.bounces.google.com;
 helo=mail-pg1-x545.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 01:54:07 -0400
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

Hi,

This RFC patch series introduces a hardware-assisted memory protection
mechanism in QEMU using x86 Protection Keys for Userspace (PKRU / MPK)
to complete the Address Space Isolation ecosystem by protecting the VMM
from guest-to-host speculative execution attacks.

In a guest-to-host speculative side-channel attack against QEMU, a
malicious guest mistrains the VMM branch predictor to execute a
speculative gadget in host mode. This gadget speculatively reads a
host secret and uses that secret as an index to touch guest RAMBlocks,
leaving an observable microarchitectural footprint in the CPU cache.
Existing mitigations like issuing IBPB on every VM-exit incur high
overhead, while guest_memfd cannot protect memory that must stay mapped.

To break this covert channel, we protect guest RAMBlocks using a
dedicated pkey (pkey_mprotect).

- During normal QEMU host userspace execution (I/O handling, timers,
  event loops), we lock this pkey by setting PKEY_DISABLE_ACCESS in
  the PKRU register via WRPKRU. Because CPU pipelines natively enforce
  PKRU restrictions during out-of-order execution, any speculative
  gadget in host mode attempting to touch guest RAMBlocks is blocked by
  the MMU at the hardware level, leaving zero footprint in the cache.

- Before entering KVM (KVM_RUN), we temporarily unlock the pkey, and
  immediately re-lock it upon returning to QEMU userspace.

- To gracefully handle legitimate host accesses to guest RAMBlocks
  when locked, a SEGV_PKUERR signal handler unlocks the pkey in the
  interrupted thread's xstate and issues an IBPB (PR_SPEC_INDIRECT_BRANCH)
  to prevent speculative leakage before resuming execution.

Comments and feedback on this approach are very welcome!

To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org
Cc: James Houghton <jthoughton@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Reiji Watanabe <reijiw@google.com>
Cc: Jacky Li <jackyli@google.com>

Signed-off-by: Jacky Li <jackyli@google.com>
---
Jacky Li (6):
      [RFC PATCH 1/6] x86: Introduce basic PKRU hardware wrappers
      [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
      [RFC PATCH 3/6] physmem: Tag guest RAMBlocks with Protection Key
      [RFC PATCH 4/6] kvm: Lock guest RAMBlocks via PKRU during host usersp=
ace execution
      [RFC PATCH 5/6] x86: Add xstate parsing and PKRU offset detection
      [RFC PATCH 6/6] kvm: Implement SIGSEGV sentinel for Pkey recovery

 MAINTAINERS               |   1 +
 accel/kvm/kvm-all.c       |   7 +-
 include/exec/cpu-common.h |   4 +
 include/qemu/mmap-alloc.h |   5 +
 system/physmem.c          |  22 ++-
 system/vl.c               |   1 +
 util/meson.build          |   2 +-
 util/mmap-alloc.c         |   3 +-
 util/pkey.c               | 386 ++++++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 424 insertions(+), 7 deletions(-)
---
base-commit: fa19879df1658f96ac07365fca8835b7decd6995
change-id: 20260729-feature-pkey-dev-c8a026db85b4

Best regards,
--=20
Jacky Li <jackyli@google.com>



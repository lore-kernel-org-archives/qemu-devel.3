Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227CBE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9RV-0008RG-FQ; Fri, 13 Dec 2024 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3X25cZwgKCu4mXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com>)
 id 1tM9RO-0008P9-FB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:02 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3X25cZwgKCu4mXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com>)
 id 1tM9RL-0007mz-U1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:01 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so11231435e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110815; x=1734715615; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/sTeh+XDP5RbmC2/hDbbrxjKw0q/LBowSVvqQJbgKb8=;
 b=0NGn/9aFnoN94yrL4S6nL5wJS91HCueAYV73wZv6uc58khx+qpmtbX8he550hDdPT8
 gcCqhUiyIoiiWxTYXIQ9HlBCslDbrHSgEvp4fDqrmbQjwP70Tb+Cgnjiyxhk/8ehbSFn
 rOZwpSafdZOx1Nxhana9J6SnZr5Ues3/IRD9jyOd3xi1V89MQZZjkMuAfVULmWwH6FS8
 ybYoDkvAxFJaPGjJVpDMJCoPFPAXFcZxsy4wvyfXU6YJ272Muv/zh8A6H60l1zIkQhlo
 Hmhl3oz5qbeJPmLX9hTrvDFV8Jc2VIUTq2Rz993GFTVBhi88fxV89TS8ccLIVmuRGui1
 IvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110815; x=1734715615;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sTeh+XDP5RbmC2/hDbbrxjKw0q/LBowSVvqQJbgKb8=;
 b=uOP99SsU65RDh+5liogArwvc4wruEe2Le2CQn7PueOhhzEKJxyWv+/dMOAHutrRkFG
 yrL5P3jaQ1haPkEtFDNQS87kcbD3flZJHghmUF7kXfBlKQibYuatc/Nvq6VDi+nfgCtb
 cnEpyV+k0UWuukB68oVt1d5aviL7NMN2tAFbJYqTB1DoWvUnZ3x5QS3yCH0ziAiZIgyN
 ps8xtEeNg09iGy8KnV0S0YEE5rYxO+gInRITCOWLqrnOpjl2IiQJf40SshMa5aQmQ1RW
 d6i0y7hgvG3yz2HKuaKk38Qmu+l6RCcdKpnBbsIptyl2Z1mMC921QYBLq5AGXgUlkjld
 DtMA==
X-Gm-Message-State: AOJu0Ywc4rwSzOq4BW654y4xw6CT5xnEbmnccMhgOrbxV12k/yxB4ugX
 StvxudZSpH//giaruKwXtQbMDj6EPBXKdBT8njgwAqq989BgNxpWjeFx0T/p7x+PoTTQNPECPA4
 axYVTQaDzV2U462pl6wn4xY80qHHKfdKqudtizzZ2KnPAPYHYCPWq7ZCl8LHODH+odUiEXZVOV8
 Bv2V914uYFfeG9wIokL4JfAHHW9MrAdl0lpxRied2qdA==
X-Google-Smtp-Source: AGHT+IEnft7Z0hx7shf9zOAJ5l7kBj1sZIoWpDLeTXMdjhGcI5xKKTYnudq9QS7Bzfa2UJXu4dDDxxag3YULnw==
X-Received: from wmpw19.prod.google.com ([2002:a05:600c:993:b0:434:f7e5:bd2f])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c07:b0:434:a350:207c with SMTP id
 5b1f17b1804b1-4362aaa9f99mr31120425e9.23.1734110815182; 
 Fri, 13 Dec 2024 09:26:55 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-1-whendrik@google.com>
Subject: [PATCH v5 0/8] mulate Intel RDT features needed to mount ResCtrl in
 Linux
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?Hendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3X25cZwgKCu4mXUdThYaWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Hendrik W=C3=BCthrich <whendrik@google.com>

The aim of this patch series is to emulate Intel RDT features in order
to make testing of the linux Resctrl subsystem possible with Qemu.

A branch with the patches applied can be found at:
https://github.com/Gray-Colors/Intel_RDT_patches_applied/tree/rdt_v5

The changes made introduce the following features:

* Feature enumeration for Intel RDT allocation.
* Feature enumeration for Intel RDT monitoring.
* Intel RDT monitoring system interface.
* Intel RDT allocation system interface.

By adding these features, a barebones implementation most of the RDT
state and MSRs is introduced, which can be enabled through qemu
command line flags.
The features missing for a faithful recreation of RDT are CDP and
non-linear MBA throttle, as well as the possibility to configure
various values through the command line, as some properties can be
different across different machines. For increased ease of use, the
correct features should be automatically enabled on machines that
support RDT functionality.
The missing features mentioned above will be implemented in the
following order:

* Expand feature set for RDT allocation to include CDP and non-linear
 MBA throttle
* Allow for command line configuration of some values, such as the L3
 CBM length
* Automatically enable RDT on machines that officially support it.

Will NOT be implemented
* Tests to simulate interaction with the host by the guest

Command line examples assuming entire patch series is applied (This
requires a kernel with Resctrl enabled):

To emulate Intel RDT features:

Currently, it is necessary to force the RDT options on in qemu, as it is
not automatically enabled for any machines. An example would be the
following:
-cpu Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba,+l3-cat,+l2-cat
and
-device rdt

Just enabling RDT in qemu won't really help, though. The following
option allows resctrl in the kernel:
- Kernel options: rdt=3Dmbmlocal,mbmtotal,cmt,mba,l2cat,l3cat

To use Resctrl in the Qemu, please refer to:
https://docs.kernel.org/arch/x86/resctrl.html

V4 -> V5
- rebase
- fix feature bit names to all be in hex

=E2=80=AAHendrik W=C3=BCthrich (8):
  i386: Add Intel RDT device and State to config.
  i386: Add init and realize functionality for RDT device.
  i386: Add RDT functionality
  i386: Add RDT device interface through MSRs
  i386: Add CPUID enumeration for RDT
  i386: Add RDT feature flags.
  i386/cpu: Adjust CPUID level for RDT features
  i386/cpu: Adjust level for RDT on full_cpuid_auto_level

 hw/i386/Kconfig                      |   4 +
 hw/i386/meson.build                  |   1 +
 hw/i386/rdt.c                        | 286 +++++++++++++++++++++++++++
 include/hw/i386/rdt.h                |  76 +++++++
 target/i386/cpu.c                    | 114 ++++++++++-
 target/i386/cpu.h                    |  24 +++
 target/i386/tcg/sysemu/misc_helper.c |  81 ++++++++
 7 files changed, 584 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

--=20
2.47.1.613.gc27f4b7a9f-goog



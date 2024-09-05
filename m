Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E12CD5BA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZh-0008Fn-QK; Thu, 05 Sep 2024 07:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gpTZZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com>)
 id 1smAZc-0008ER-NK
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:22:49 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gpTZZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com>)
 id 1smAZa-0002wY-Jg
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:22:48 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-42c82d3c7e5so6037195e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535363; x=1726140163; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sKFE8Wxe/nHkbS2H3kw+ayEZP6CFdxNOYqChPs75ySA=;
 b=mbzf/FVWRHFpvk3hGOyWTNbZyLHHMpC5Co5E7Pe9kcYmaTr9KNrBp01suQElgE8ZOz
 yxp2MdgQ/IG7NmqbJshpzsEUkkydRtm3La6H30fEMqJJCB0+SM67rCZ7L21hxYbIPvDT
 82wctgQoXT1amZl5dJDj0+jLM4AXx7xk4c01EgSUVrnPf9Txxb7qEr71Rmb5jw0TseG1
 DF0sBJBBbiTczk60YuiIyWf/xK4lE8xCc+CI8XRQEwLVDQ1GdbYnEdSP9GSw1YMLgLSO
 vF0T5fBfaVpLMq4Esygw9wNkTjtb0vvtdSkh3fRjboR+szkOwjdWxy9D8dNv3QEXBlA7
 sjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535363; x=1726140163;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKFE8Wxe/nHkbS2H3kw+ayEZP6CFdxNOYqChPs75ySA=;
 b=mG/XciLJXcz5ThAR58FOejlEGSmOXFomXaHvpTj5d9gYyoOCji80mTv2BExlvOeNad
 G6HbIC62HigMFWxwzzhnEaFqqkFukjRimHw87Fj8WDX5/iMHQDX9yhRR3gjhB5mO1x8o
 R8acQ8FN0lrqnNOY67D5yCIlYr6sRW7gc//hf7KqAn1bs1c2eX/NcSheaGS5BfpyIxim
 spGJYUeLbL3lHtaL5EIX3hpBlX82KhnCNI3ct/pdt9fLZ1YS3fRIqRjzvDDhzzzq8r+y
 Gju+DUQh72dPeqf923azXu9qZjIftqA/6gsM930zTRYeakpk13JCj3RWdi7hQ6enlbwz
 RCig==
X-Gm-Message-State: AOJu0YzSqF6/AptdMskTo9AeNvCGZQVGHavGww+C/cifyi25tQPsfBCs
 6p8Wmdsz7ctTdAcM4CHbjCHHTsja/ZB4tpo7swlecUriG71htEocmtJxCzPmBa0BMNuCdpBK4z5
 Ydhc0jBpbnJ2JbdfUe/gmJ02QRhQ1lNwewzknJprVRGW5gne919h9gv+uwu4d6eAXJdMwkjj0Bc
 cVeRteOBqPLqTlaBPQiDnGZ+F+FHrClT7qCbZ5MsQBPw==
X-Google-Smtp-Source: AGHT+IGZhsjET/Ofg78FMhHBfKJ1yaajhTPM0vG5TVLL6tXIO47OmUwi1a6Okz/1x6rSvFjAxJmuud7L5UqYVQ==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a05:600c:5590:b0:42b:a7d8:4b69 with SMTP id
 5b1f17b1804b1-42bbb43643emr830995e9.6.1725535362530; 
 Thu, 05 Sep 2024 04:22:42 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-1-whendrik@google.com>
Subject: [PATCH v2 0/8] target:386/ Emulate Intel RDT features needed to mount
 ResCtrl in Linux
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?Hendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3gpTZZggKCk8Dyv4u8z1x55x2v.t537v3B-uvCv2454x4B.58x@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
https://github.com/Gray-Colors/Intel_RDT_patches_applied

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
- Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba,+l3-cat,+l2-cat

Just enabling RDT in qemu won't really help, though. The following
option allows resctrl in the kernel:
- Kernel options: rdt=3Dmbmlocal,mbmtotal,cmt,mba,l2cat,l3cat

To use Resctrl in the Qemu, please refer to:
https://docs.kernel.org/arch/x86/resctrl.html

V1 -> V2:
- Merge the first commits 1 and 2 from V1 (add RDT device, add RDT
  state)
- Fix endif in rdt.h (was not at end of file in some commits)
- Apply recommended cosmetic changes
- Add license to new files (rdt.c, rdt.h)
- Don't add lines until they are actually needed
- Change g_arrays holding RDT state to be pointers, as they never change
  size
- Add "i386:" to each commit message, since other patches seemed to do
  the same
- Fix typo in patch 3 (previously 4) title (add RDT functionality)

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
 hw/i386/rdt.c                        | 281 +++++++++++++++++++++++++++
 include/hw/i386/rdt.h                |  76 ++++++++
 target/i386/cpu.c                    | 106 +++++++++-
 target/i386/cpu.h                    |  24 +++
 target/i386/tcg/sysemu/misc_helper.c |  84 ++++++++
 7 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

--=20
2.46.0.469.g59c65b2a67-goog



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291B6C3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVO-0003zT-5g; Fri, 19 Jul 2024 13:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bpSaZggKCj0vgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1sUqUH-0002Hn-1X
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:41 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bpSaZggKCj0vgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com>)
 id 1sUqUE-000477-Ig
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:40 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6688b5b40faso48852437b3.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406575; x=1722011375; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EaJqw2mJRSkYe7MyJyOAWeV6rAh6lGabGEXsQDwDp2E=;
 b=r+RqHDYMU/ZxW+pnQvV06ShPHQLvdMqbCBDy04eDHetGTPIonlfiSH3shbNR9aIOdp
 9T4HmWhGBqDqxddr/cFADOij50fJcpvEEgz8qQ6EFs4sPG6IU0t3SsNoeNgFSHIuiphX
 ErgNN8pOtfreQFoZWrpBa3ApTKVKxPl5AkN3LUPnHzkEshPgqG+rQJZknXmCbo2cVfis
 mpBb5i01hkxviugBgy2zBhMKafoZ9XeZg2KaMjyxD+YcN0D1SbMfAjXXynv2soHVRg0a
 nL6LWldpZK8ovEKIqLyjL9bEK3yaYbQ7/Cg/0KxpCVLMcTDLTnBRhrKY4HxFaHpI+cqU
 NFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406575; x=1722011375;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaJqw2mJRSkYe7MyJyOAWeV6rAh6lGabGEXsQDwDp2E=;
 b=SsB25rnU9fVQjxm8sNfC/N+NB2+EOZI42hYyeKEEZuuX8xoEnIzGhGREKTujLRHAyu
 dWKnJ10esZ2caRRgs3X2aiR/Pfmh7MhF9+tfyHnhF9rP0YjNVHpiLahAstxeY/iH/4En
 bYXLFrm8azq7iTCIkG0tn3vOK9DjRhsWwyJbIbMrywnw6oSh9N6hgdIWc4Vc4St+PElI
 2EqV67Sf2S1P1qMRP+z6tA2+UEbta6V2UEm8jFcblTTmuDLKGfEzXA9DPhh2gWRw0EAn
 jARR4zxbPHyKV0LY4p9THKtIVpaOXhygLD4ke7A5uh+ACf/hFd0xWHcOv7EhdgdX+6/B
 tEDA==
X-Gm-Message-State: AOJu0YwJBJCWVXpAUbOzPVz9guSDRuMkVDSkupihgaNzVz3vWgHORO2y
 jQsa8CwbjnjGDgK+9kuIHH53srgOhti48GLIGQXXGwdetMghHryqSrvqee6Eq0EBH7QnU4wkkUX
 5LLON7uDyvbMF0el+4616NcrqFfjdmZSwCp0Kgr2E8K73B+ZCYm1jHdIAoPgGTC7gZOOQv+xXDf
 Rf8AC2g/m7Hq/UCtlYqRpLTrVI+xhKcOaDce0/TCSeKA==
X-Google-Smtp-Source: AGHT+IEExF9VHEpqkn+TXNjRAu8yv4NeugenWosKZDwMXaCa9Hhf+Jv8wg+Ww4ydxzb15VDBHCUs/cskYGuFyA==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:6902:1003:b0:e03:a22c:df5 with SMTP id
 3f1490d57ef6-e087042cc79mr864276.7.1721406574746; 
 Fri, 19 Jul 2024 09:29:34 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-1-whendrik@google.com>
Subject: [PATCH v1 0/9] target:386/ Emulate Intel RDT features needed to mount
 ResCtrl in Linux
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?Hendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3bpSaZggKCj0vgdmcqhjfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--whendrik.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:47 -0400
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

=E2=80=AAHendrik W=C3=BCthrich (9):
  Add Intel RDT device to config.
  Add state for RDT device.
  Add init and realize funciontality for RDT device.
  Add RDT functionality
  Add RDT device interface through MSRs
  Add CPUID enumeration for RDT
  Add RDT feature flags.
  Adjust CPUID level for RDT features
  Adjust level for RDT on full_cpuid_auto_level

 hw/i386/Kconfig                      |   4 +
 hw/i386/meson.build                  |   1 +
 hw/i386/rdt.c                        | 271 +++++++++++++++++++++++++++
 include/hw/i386/rdt.h                |  60 ++++++
 target/i386/cpu.c                    | 134 ++++++++++++-
 target/i386/cpu.h                    |  26 +++
 target/i386/tcg/sysemu/misc_helper.c |  80 ++++++++
 7 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

--=20
2.45.2.1089.g2a221341d9-goog



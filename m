Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78355E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI1y-0002uq-Ll; Thu, 05 Dec 2024 15:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XAZSZwgKCvEpaXgWkbdZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--whendrik.bounces.google.com>)
 id 1tJI1i-0002rG-UQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:42 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XAZSZwgKCvEpaXgWkbdZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--whendrik.bounces.google.com>)
 id 1tJI1d-0001cz-KV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:41 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434941aa9c2so8131595e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428828; x=1734033628; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Fnzl56Dz76c5TijDmIAM8taLTc8mOPooB2iRDgFXio=;
 b=puElV82qSyGSJixxuxNVFMToQ58FuKUt1gY3qTQrXnyOf5uqJ/kZ3Qc6BruX+aCz6K
 BI/RmjuF3kWEYCMqkeLKZ5WBYO9GH2eUMX6udNiX/7Ew3I+bSr8hBu6+uqpsJCV8jevK
 zB7Mc94+NvjZ5ZSbxO5rKJIjeZXWl7olcMLH+PtxmCeteiAglcTGzdEWZ5nRuEjFj317
 dPbb46wGRzhE/pKTpOtdH8eCwsiWHwbAgsFS82ua7D3wI+bzNoHUHeOr6h2ALVsadf4I
 co6elOjlVeBVufnBGUO4WXKDXTI5NHJhGtdILXY3x5uuSk7Utx/tP+Q/ntZ7ANvA25W4
 Pjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428828; x=1734033628;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Fnzl56Dz76c5TijDmIAM8taLTc8mOPooB2iRDgFXio=;
 b=G/F0IOhEN1uKfo5qjtGIMJ9VL2aLslwHnmKJayE25KfqqDsIJd744VM/IXQVpzsExg
 IQ3mKWg1Ov1t+RXeFn+MUKwwQQXr6pF9EJ14sPWnYL0lB/RitLMnySPPfl51PvztQXae
 8pl4Zo0+UJsCQKjxPGplrc9fjffTIJNexxXJ995LIfLwGp+KgJ7CGKwGwoPthUta0aw5
 1b1X2vJ2BUi+UduK0NsHmrgD8rMtFuW7XHhEkd50u+XR7tmov4WoDm9AtNWByWSbH4lZ
 TUXNllDn6c++NGVv6vPQKI/H9dkxkgEBDbRZZ0KYs9oA4gN5IrnBshR8eB50w5EnBro/
 3X4Q==
X-Gm-Message-State: AOJu0YxSjTjkzrjLOieAtxGKfG2SETAYbuSbJ59cpOY4iYOZHhKx+ObN
 KRhIhOocRG5sslXF9C6cnPuq7GUtg89bNwbH8At2Ynp7idaweErNgdeejtyV3u2mYK/LTmlLSdB
 R3ZMWQ5dQOy0CxqoxiFXCJbNm31xzdIGRfc8rAQ00fvos2LvzPieBjZavkJAXiEP4bHzQuBIqDk
 qkV3hhQAngunaQck9eVjPGQNT/K88jHMLxGLNnh6EZMg==
X-Google-Smtp-Source: AGHT+IHAdzdfDaKQP/DKWNOJ9KJLkgypbp3XIzN4Zk3OOM0zkRZMsMKaq8jnZVtyMJu7aNQUphbrswtlzyxhFA==
X-Received: from wmjs19.prod.google.com ([2002:a7b:c393:0:b0:434:a10e:91b5])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca3:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-434ddeb6731mr5157515e9.14.1733428828587; 
 Thu, 05 Dec 2024 12:00:28 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:17 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-1-whendrik@google.com>
Subject: [PATCH v4 0/8] Emulate Intel RDT features needed to mount ResCtrl in
 Linux
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?Hendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3XAZSZwgKCvEpaXgWkbdZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
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
https://github.com/Gray-Colors/Intel_RDT_patches_applied/tree/rdt_v4

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

V3 -> V4
- rebase
- general fixes

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
2.47.0.338.g60cca15819-goog



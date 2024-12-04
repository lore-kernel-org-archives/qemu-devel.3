Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB267E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl3w-0008Vc-PP; Wed, 04 Dec 2024 03:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ahdQZwgKChsN85E4I9B7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--whendrik.bounces.google.com>)
 id 1tIl3u-0008Ud-Vl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:47 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ahdQZwgKChsN85E4I9B7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--whendrik.bounces.google.com>)
 id 1tIl3t-00010H-11
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:46 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-434a29a93cdso48742975e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302122; x=1733906922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uF1ofiR2T41ZDyU6Ck5ygK7yUALbkRrX0Bh/AS/hgrY=;
 b=vZw/ivkOz+YYEWQ7/2n0uC7eK72qzJcWzKcAJIuwo6lMxqDSf9hGHgGiLXr5qD4SiX
 S1a6CEgFkH4adA2hgJALsm79A6fNCa5p7mzuQYHFgHqmZ3fGXL6FwwEvjdsydjoc6+EO
 LA58PsQsWU5UFm5qLzbhngIb6P78e7eMg7wkOvL7LQh2OqiL+h7hpR0iy/dw3+JGTY6K
 avAdJ6DnzvLkqLmFDbT56oY3CoIrvIhoUitLm9uvPv5PfAiOlHgKcheYw9Vbmt6I2tMT
 wP2auY/amka8oKuNVoziR1TAXzSSjmAAsFwNu6Y9+ctx3P6IokLCzGJe4As5cUyEjigM
 g1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302122; x=1733906922;
 h=content-transfer-encoding:cc:to:from:subject:message-id
 :mime-version:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF1ofiR2T41ZDyU6Ck5ygK7yUALbkRrX0Bh/AS/hgrY=;
 b=VKZWg5cPfoiDOJJ/8/aS5EVfFLR4D2cvRsfxEnvwdCioiv5INQRtZMhDo2E+AF0s+0
 sUUURIIVhBXtyOiLS7kDT1C5JuI1FmWCGM+ub8zP4imGZoPzT4EIBmMXUXslT5MVxFZU
 jOTfOjcOZCOHpLC5QTce/ZU4ojwRGfb0Aq+GeGVfvpxQw7r7XZKVUbZI/H7UV3aRiAr5
 B91ab55fZzyfpBzI8Cqm4lm6ecq2AxhvZacxp4rLMCUyouuoLki4EM1wTgNuKJHLBP1m
 NsbH/Z2DoOy0F34NO5WPEpER0qC5DGLf/wamblHTcrO2Grciiiz3lPB6QEjnthd+E2vj
 LC3A==
X-Gm-Message-State: AOJu0YwvA3t6Qz3iZfBNg421eFiCMlM9tjSB7DSrvgeQyfRyTfAjZvlI
 bp/7rfz2f35DMTWz4fM6TUVH+dYYPSwvf9RXmlJULKqN3zl4OUje8l4SjlZKHE/kc7LAqodKvbN
 8OE3LnEDoJ/BEPeYx18/bGnNhByiFA0OTKTDKMHDsNxvlfXICISmQOvQCMQPBYgRpX8/TTPymZn
 TumgpQtcniEd/SewPLiSTtH9Nn6DZxuTlTPbtPbAAheA==
X-Google-Smtp-Source: AGHT+IFX8cyc2sQMteQAItVyFkJJJWvB189hQOF2suLqSNmjh+sE44KE1C+YgpBGaO4tS8QbNqCWZL1bM0rA3Q==
X-Received: from wmbjw17.prod.google.com
 ([2002:a05:600c:5751:b0:434:a9bd:e68c])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4745:b0:434:a5b3:8fee with SMTP id
 5b1f17b1804b1-434d0a07c49mr42090405e9.26.1733302122456; 
 Wed, 04 Dec 2024 00:48:42 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-1-whendrik@google.com>
Subject: [PATCH v3 0/8] The aim of this patch series is to emulate Intel RDT
 features in order to make testing of the linux Resctrl subsystem possible
 with Qemu.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?Hendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3ahdQZwgKChsN85E4I9B7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
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
-cpu Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba,+l3-cat,+l2-cat
and
-device rdt

Just enabling RDT in qemu won't really help, though. The following
option allows resctrl in the kernel:
- Kernel options: rdt=3Dmbmlocal,mbmtotal,cmt,mba,l2cat,l3cat

To use Resctrl in the Qemu, please refer to:
https://docs.kernel.org/arch/x86/resctrl.html

V2 -> V3
- Fix up command line examples in cover letter
- Fix CBM sizes which were wrong before
- Warn instead of crash when -device rdt is not set, while RDT options
  are forced on.

=E2=80=AAHendrik W=C3=BCthrich (8):
  i386: Add Intel RDT device and State to config.
  i386: Add init and realize funciontality for RDT device.
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
 target/i386/cpu.c                    | 112 ++++++++++-
 target/i386/cpu.h                    |  24 +++
 target/i386/tcg/sysemu/misc_helper.c |  84 ++++++++
 7 files changed, 580 insertions(+), 2 deletions(-)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

--=20
2.47.0.338.g60cca15819-goog



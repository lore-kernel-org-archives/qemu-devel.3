Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2DEFEDA19
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2aJb-0007PB-TC; Tue, 17 Mar 2026 15:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJW-0007Na-BQ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:50 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2aJT-0006vm-6E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:42:48 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35b90d6fe14so2079065a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773776565; x=1774381365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aOsoy0tJVFky9i9apne3w638753OOZ3M0acDHtHWolU=;
 b=Da3JIw/hOrnt+eW1QJt4s9KjZ0ESqAyxOOcrBB6aJ5JkbPJdBz+OMk3GEiNXxVZI2A
 pSXgVaOqXEmXc7Kf28yeN0IKXUdr3ZDv5R00XygjL5AH+WMNSKgvLsDz2FRGFuML8jzk
 sv4TDog7BgJFtXK/cnlOnHbG+Wy94wHfHIqMicyv8HIlr3MCrOvwEUtD4xDyvjyPaCSF
 IoMuDoZTJvCO1k4os97BuhJX70HH2/dExjkBjUJ83sUQZ57N1JBgzqYU6U2BSoq0iVOw
 Dh3nQmLBSTJ89r5ZnGai6603/Dwx72qXGxNoU+cqgPCJatzHod0IFLKtGI2hLDooTUrT
 1KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773776565; x=1774381365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOsoy0tJVFky9i9apne3w638753OOZ3M0acDHtHWolU=;
 b=QqmZUIdGFhk64rx6GeW58W2qCXadjOpjDgSQS2yCI0xYf352l5MYYIOmxcx8Oh6o03
 663RSw/jl1HFgy/umh19lHI5axr7gK45PqhyxrKD0iz0lR//hbIYwyOfq9aVgW6DRoU9
 60kAmN+fWM8ViHBnV+PdavZNWXTjJq1poPjdhXwd/jRjnEwE8Q/4Klg1BSQT62h+PVrn
 pAkrEV60+Pf3VR+AX63M6WOiF1Lkw+iFDHf/VqX/xpMXx8o08l14nTEjrJF38KVwqX1V
 YQS34qSKD/LEOXNjsNm1NkyWOBnbeDhvslExYw65gUSHesmOdLZfvkLXmm52hlcpkDxL
 t+5A==
X-Gm-Message-State: AOJu0YxLXz+K6VnHJ0oZ0VCQeQQq5KVIaA4V/0TO8Jc3IYrMdzyiEZ19
 WxxRz1Kec9OuYQf5Hhec25E6zMz1GdiaJRM5fD3faOPvUmbUjiiyQGZ3smfmJ5j3TeXwFp53cbm
 LoHJUmUU=
X-Gm-Gg: ATEYQzxewmqchpKBCNb/i+mGtTAQEVlnwAzI4Fwr/LlNhKDHu+yIWnIF4tVHYB5pOGV
 FmGohjviayI1BChpQWE4NFh59ZGxxjzBSpQWckUV0WJV0NCjgKQnWrhLqOR7mmOQUqlsk0tylhz
 vHdjpolNfdoT+U2xf8asiAcsB7Abirg8s1TXeeiKRUkp4NthsQ9bkz8f1N/x3h/eIB18J8/vVcV
 nLLvVRc6E5a1iDQ7vXXSP7cJUHJuGyDb0cGmkMBGy+3CcMkvGMY7yT46WK6SXTeEtD6nmSOCO5w
 d94XwgmApHvDYR9LPALQmLi9n24+T6w1Mh0MxfEymBY3szfpnOQFpuaiw8HdNGx1R/suySDMJcd
 jxJKRaw2iioHRM0Vz9x0+aWCeUplpc3P1Gq3p7NhE2igludbJ6S+6Zu8JyPzHeUNhhX1fabMJuP
 e/1sgX3qHb6+t+f8AprmxMAU3ti566ss7cRzCOgH3mr/6hPJvJFCeBhVHUF45bvPyjIf5/Dq1Kg
 tRO
X-Received: by 2002:a17:90b:2d8e:b0:35b:a656:a61a with SMTP id
 98e67ed59e1d1-35bb9f3eeccmr581307a91.25.1773776565358; 
 Tue, 17 Mar 2026 12:42:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bba5b8606sm239907a91.14.2026.03.17.12.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:42:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
Subject: [PATCH v4 0/8] hw/vfio: single-binary
Date: Tue, 17 Mar 2026 12:42:33 -0700
Message-ID: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This series makes changes to hw/vfio to compile files only once.
Changes are pretty straightforward and are mostly extraction of kvm/other config
specific functions to proper files.
This is the last hw/* subsystem that needs to be changed for single-binary.

v4
--

- rewrite commit description for "hw/vfio: eradicate CONFIG_IOMMU from sources"

v2 (sent as v3)
---------------

- use global stub_ss (fix some missing dependencies in this case)
- move kvm_enabled() guard check on function calls
- s/Vfio spapr kvm/VFIO sPAPR KVM/

Pierrick Bouvier (8):
  hw/vfio/listener.c: remove CONFIG_KVM
  hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
  hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
  hw/vfio: eradicate CONFIG_IOMMU from sources
  hw/vfio/pci.c: eradicate CONFIG_KVM
  hw/vfio/ap.c: use full path for target specific header
  hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
    hw/vfio/kvm-spapr.c
  hw/vfio: all vfio files can now be common files

 meson.build                  |   2 +-
 hw/vfio/kvm-spapr.h          |  12 +++
 hw/vfio/pci.h                |   2 +
 target/s390x/kvm/kvm_s390x.h |   2 +-
 hw/vfio/ap.c                 |  11 +-
 hw/vfio/ccw.c                |   9 --
 hw/vfio/helpers.c            | 172 -------------------------------
 hw/vfio/igd-stubs.c          |  20 ++++
 hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-spapr.c          |  47 +++++++++
 hw/vfio/kvm-stubs.c          |  34 +++++++
 hw/vfio/listener.c           |   4 -
 hw/vfio/pci-quirks.c         |   5 -
 hw/vfio/pci.c                |  39 ++-----
 hw/vfio/spapr.c              |  30 +-----
 hw/vfio/meson.build          |   6 +-
 16 files changed, 329 insertions(+), 258 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/igd-stubs.c
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-spapr.c
 create mode 100644 hw/vfio/kvm-stubs.c

-- 
2.47.3



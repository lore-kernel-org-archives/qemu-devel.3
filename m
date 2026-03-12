Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C6F106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 22:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0omA-0006zN-2t; Thu, 12 Mar 2026 18:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om8-0006yu-L6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0om7-00030L-2J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 18:45:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aae146b604so10675765ad.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773355501; x=1773960301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yXqO/Kn7C+46BkYp7T9YboQwLGMeOmJcv6Exfo1t6AQ=;
 b=DKgsytKL/cI8AeWvhyAvf88L5iYgYAaZyb9XT7S4qKoaaJ3CN03yDxw689YuDYfRtd
 XDUFvqspXoM9z0nbHxtxWw3pqh8ChWwvUdQznGf1H5L3QjWbHOoWPOeG19EcKaCKT0EO
 vtuP/Kkwm9HI4tse40S5aQeu13FFJr6C2++8gbigqN7CdXheQPEBEg0s1tIvqUagfZ7A
 qnLZULY4U7QgxguLT24nPGkH8I7Gh7O51mPDkgxTwc33gtwsDj9twYFKmWs2YWuQrojM
 9RobvDeCcYrCFUwR1zGx+XNuEF3fJC/m+qaVRENfqfOGmho8HX/JwQsf7nM1OegEjy4b
 j8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355501; x=1773960301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXqO/Kn7C+46BkYp7T9YboQwLGMeOmJcv6Exfo1t6AQ=;
 b=gurdwbERzvCmENfQzOo6vp230VAZiMCGd3a8l6UP1HAOGT9tbyAZ0g33rhoBL5UX53
 SWlTpYJ2xD7O4h3KYZVOthXs3Ajr2BEl7kNYM40cY0wkPGPBswfyzEAMEBdPaycBY8Uh
 pd5Oy8lnakCXPWDbICavHck7L3c1Elu9DRFeIRNBI/pddUUB4pN33jsRPQMxSxLqyItJ
 AbgHxyY6sCycDduguAQ1ig4ER1d+LYoncYTfLEcZjl0PAWdYy2mhB6BKNX/U8gKKM/jW
 g+7Rz1rGIyEKIZEwzqZsVXUwEaaekDtj89DA3zpRYm4aFEbTV2yWXawHEneVEQUFC41S
 qpDQ==
X-Gm-Message-State: AOJu0YxWXsBeSOm740MuYjQMa1B9KGO03HqHSYCLCpfSNDj57/jLiqmu
 yOTC3lSCTPghPLLzgsAS91SW9h6jfWZ99KGjckSq+3XMhRizfJsrbF0uZ/DUoJpGctRgYu7xBO2
 aNQXE64s=
X-Gm-Gg: ATEYQzxBwFDYdlwF1WNSolxQISCethyBmsOvdN6ugYST07kO4mStLOnrXgxpInNozsc
 0sz7N1bU0Dj3se5YMuvKf/QJABsLNUwvry050yThsCruW1VjojvnXv97NXIB4IDvTlMxrxRXdXh
 mbMoNwdfj0/v1d0jRCIyqphMYNpdP8YWPIll49ay9rRsyQvbK3QIX/32O1wJshY9dHeql37Su1I
 Ug3e/9ydqZmBDn2XPCjsAe2TrbV8ylbrZi5vbWWNejbqMBjwFTHX7IzJ4TDC7JW81ZyfFlyTZ1e
 cme4OUvDybvsjhCurS4Q5FC2RQiwhMcf/dQWayA5SPr07++H21CjdkDSoJbvq98DUPkqajbbu4S
 5Rz8LsXXgdLEtVz2465p2cy2DuHDwmIBQ1gnRSlBqgf6b84kkOrl0tEWMnY3A6UStOw1W0n6EVx
 +a7yvJ92z6mCYVCDsrAWfaIjyVVxNVxhSKPZjMN8FN70vtbdHBCFzMCE/WPG1zMCb/7zj5uQRg/
 Ps1
X-Received: by 2002:a17:902:d4cb:b0:2ae:87de:443b with SMTP id
 d9443c01a7336-2aeca999769mr10295785ad.16.1773355501172; 
 Thu, 12 Mar 2026 15:45:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ed9cdsm128215ad.60.2026.03.12.15.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:45:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/8] hw/vfio: single-binary
Date: Thu, 12 Mar 2026 15:44:41 -0700
Message-ID: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

 hw/vfio/kvm-spapr.h          |  12 +++
 target/s390x/kvm/kvm_s390x.h |   2 +-
 hw/vfio/ap.c                 |  11 +-
 hw/vfio/ccw.c                |   9 --
 hw/vfio/helpers.c            | 172 -------------------------------
 hw/vfio/igd-stubs.c          |  20 ++++
 hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
 hw/vfio/kvm-spapr.c          |  47 +++++++++
 hw/vfio/kvm-stubs.c          |  35 +++++++
 hw/vfio/listener.c           |   4 -
 hw/vfio/pci-quirks.c         |   5 -
 hw/vfio/pci.c                |  37 +++----
 hw/vfio/spapr.c              |  30 +-----
 hw/vfio/meson.build          |   8 +-
 14 files changed, 331 insertions(+), 253 deletions(-)
 create mode 100644 hw/vfio/kvm-spapr.h
 create mode 100644 hw/vfio/igd-stubs.c
 create mode 100644 hw/vfio/kvm-helpers.c
 create mode 100644 hw/vfio/kvm-spapr.c
 create mode 100644 hw/vfio/kvm-stubs.c

-- 
2.47.3



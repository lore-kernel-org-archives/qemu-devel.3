Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFE10F996C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqQ-0003on-6F; Wed, 08 Apr 2026 14:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXqM-0003Pr-Gj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAERz-0005Tx-Ij
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso39642235e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599149; x=1776203949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoKaBti8hgHSAupQ577cwRGACYeQxonS3gqu7n3qfUM=;
 b=zDUs1UQvFkbX7V9ZTgxwfqGBJecJuRVrgO+4cWt/oHSbTO/Hh4Yn5EGob8aYO82th0
 9TSFZ5j0IN7DhuN2/riEfEhiRbEF/DFVBaR489Q1K15d3eUOFQ7x6eeOAxfyIHNAUWXu
 Fz6g0/8OH/4BamHJQItwjzM0ww/+cMZpf952SiNTFEb3DN5EfGvCv89PwDMNdFanisvS
 UBwEZP4QRRZBAZ2NIgaKJpiUH+2yP63i+L/uf9NdVAFrlb+REJAE1fLH6dw6G5M9FDUD
 6qu5CH3qDs7erTlflnN10BE9+USiQtpqjJbsLww1y3O2cIKmUjC3OT7zl1Ql9gFKrm19
 iAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599149; x=1776203949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OoKaBti8hgHSAupQ577cwRGACYeQxonS3gqu7n3qfUM=;
 b=P72yYIgMFvcytfSYD/CTJtmT74bXSDq1uFUEHyp+GTS0Yi0Wo0k4Kg+5PVNqe2hSxv
 DRYxA2QnbwGgosOhSuFWYtj0Nc5VpQjLibnfjJ1Kad/pNgcOlP8RSVud63lhEUI7ZpCi
 h6uJjOydAaXRysRdF6s1ibSfygAiy5fQnSiw8k7LwoWK6tQWAF0OUwmF949ASkzJFKoG
 1YyMzCiOx6OpUIk/2nmGi4xfeXFC9MZp09H4zoLn+X+OAQ5b8DmGH1Tem5AvkgegZ31x
 jR/q3XfWZYzEaMgdIPDHbRqzF6RXr6M9jtRb4nGjQQir7s0Xg5WLZOfMm2aAvwFvyIcP
 ci7w==
X-Gm-Message-State: AOJu0Yy5L5mRo5krSA4rA7ZfUsOvP/peUnVws1YNzGhWN8pGfAsjvQoe
 8HL+wjHIrqAHNG5bZ+EsS7Hv5rEuZSbLV2CgFGJxPs1YtALC+qX6cUuxNmzkCFh9nT6wEBrCzcY
 z2j04CdA=
X-Gm-Gg: AeBDiev7goc8n5APoT/oJOw6irSREFodYinJRzigQ3ta7UO0iRy32htibXzI5LUDRVd
 a/24TkRHoQXL/+S8P/uOwFIcPSrGivUb7sWvUETwCGZ5sJE1pqf6J3rv4LMZVzQmWaBLrApNvmG
 vB/ecpcnNe+7z7ReO6H+HCU8padPmX4cdoFhWMTTk95wPayLEuoKgFhk8ftSFsO7evVtsgOerbu
 Fb7fsL1pfQz1rwjUaY53nQqgTDozKym/afDFXguy27DLlqRwBkHznpMlLz+o8hXTNJ5+ubvtKdv
 pi+beK4b6lJlLoN981yKPOhWt/ymIqAu4XnVjhS48GfQx3UbeR+H3rmXhXmowUATS8kpUunZShk
 TgqNx45/seEfyvBYVRKo69K9jRluvmB4k3buKOAFY/c2eJdCXPVV70kUB163HfTGB6gD1ZtfSeN
 tZxPeqHyA1Q0GGYQ8UR0Yu4mEF/fEn/fKZE3MtyGDEf0b1r7MTkoaywps27qruZHAiHIOCKHHq0
 AZOJV0MtR4=
X-Received: by 2002:a05:600c:3b18:b0:488:90ac:8f71 with SMTP id
 5b1f17b1804b1-488997152camr246008255e9.5.1775599149200; 
 Tue, 07 Apr 2026 14:59:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4889cb46adcsm353450785e9.4.2026.04.07.14.59.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 1/6] docs/about/removed-features: Replace 'since' ->
 'removed in'
Date: Tue,  7 Apr 2026 23:58:55 +0200
Message-ID: <20260407215900.63390-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

We use "deprecated since ..." and "removed in ...".
Replace "since" by "removed in" for removed features.

Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument @detach")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260323151934.92880-1-philmd@linaro.org>
---
 docs/about/removed-features.rst | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 557a24679a1..e75db084108 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -782,8 +782,8 @@ without reporting any destination threads, or non-multifd source
 threads).  For debugging purpose, please use ``-name
 $VM,debug-threads=on`` instead.
 
-``migrate`` argument ``detach`` (since 11.0)
-''''''''''''''''''''''''''''''''''''''''''''
+``migrate`` argument ``detach`` (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
 
 This argument has always been ignored.
 
@@ -932,14 +932,14 @@ work around the atomicity issues in system mode by running all vCPUs
 in a single thread context; in user mode atomicity was simply broken.
 From 10.0, QEMU has disabled configuration of 64-bit guests on 32-bit hosts.
 
-32-bit MIPS (since 10.2)
-''''''''''''''''''''''''
+32-bit MIPS (removed in 10.2)
+'''''''''''''''''''''''''''''
 
 Debian 12 "Bookworm" removed support for 32-bit MIPS, making it hard to
 maintain our cross-compilation CI tests of the architecture.
 
-32-bit PPC (since 10.2)
-'''''''''''''''''''''''
+32-bit PPC (removed in 10.2)
+''''''''''''''''''''''''''''
 
 The QEMU project no longer supports 32-bit host builds.
 
@@ -1172,8 +1172,8 @@ Mips ``mipssim`` machine (removed in 10.2)
 Linux dropped support for this virtual machine type in kernel v3.7, and
 there was also no binary available online to use with that board.
 
-Arm ``ast2700a0-evb`` machine (since 11.0)
-''''''''''''''''''''''''''''''''''''''''''
+Arm ``ast2700a0-evb`` machine (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
 
 The ``ast2700a0-evb`` machine represents the first revision of the AST2700
 and serves as the initial engineering sample rather than a production version.
@@ -1290,8 +1290,8 @@ by using ``-machine graphics=off``.
 
 The 'pvrdma' device and the whole RDMA subsystem have been removed.
 
-``-device sd-card,spec_version=1`` (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''''''
+``-device sd-card,spec_version=1`` (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 SD physical layer specification v2.00 supersedes the v1.10 one.
 
@@ -1396,21 +1396,21 @@ device driver such as RBD.
 VFIO devices
 ------------
 
-``-device vfio-calxeda-xgmac`` (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''
+``-device vfio-calxeda-xgmac`` (removed in 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''
 The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
 10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
 string) to a guest. Calxeda HW has been ewasted now and there is no point
 keeping that device.
 
-``-device vfio-amd-xgbe`` (since 10.2)
-''''''''''''''''''''''''''''''''''''''
+``-device vfio-amd-xgbe`` (removed in 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
 The vfio-amd-xgbe device allows to assign a host AMD 10GbE controller
 to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
 is not supported anymore and there is no point keeping that device.
 
-``-device vfio-platform`` (since 10.2)
-''''''''''''''''''''''''''''''''''''''
+``-device vfio-platform`` (removed in 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
 The vfio-platform device allows to assign a host platform device
 to a guest in a generic manner. Integrating a new device into
 the vfio-platform infrastructure requires some adaptation at
-- 
2.53.0



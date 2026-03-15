Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFCFD58B13
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1fag-0001gS-S0; Sun, 15 Mar 2026 03:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1faf-0001fa-5G
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:45 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fad-0000bS-GO
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso2126432a91.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558522; x=1774163322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHsQx5x1i32qhAN1gWugxMcojWZeVm1RagkCSpjZNqY=;
 b=rF7AeUwSBJCbsVrEq3Kf/TXs/YPqfKrJGJdgsD+pzyrHgI7+78c3nGpyEA/gxhcx5z
 JKlTb5HJYp+reUo4T6ZlT4RgPS7tZyBNaOsRbM4JLRTqpomx8yGoYh7D+xPleJevjWbF
 vAFe3bd1IFOiT3dYySSZOFxvmjTmFwy835z/3rkyVdwe2ATKh/quFvOPFMgNQlzNzlwa
 sxxYinDXubZd3KRE7jsMjc4GX2DLunNRbZAz/GGkQJal8pcpp5jyE1wBULk29cYQGw3n
 PKcGI0+eMv7X0JWxgwN+qtKKxdFxmXdYvQVaIyl1s/UhYSUt/SkdJpELO0bAulvVzCxe
 zOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558522; x=1774163322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHsQx5x1i32qhAN1gWugxMcojWZeVm1RagkCSpjZNqY=;
 b=peN4y5n+SsZ/3kumIPwIBkS3m9VAM48CDNu5JH1qDFpjwYwhhK2D8W3XxV1J+eLNEJ
 S7Ki5HWYHpqQhA35ygNUxrmyRpWgaYEY2VeO8R+JDt3H0UHED481Ivde0JDq9PGZYyUE
 TFoOCxGil9FDt8rKMIMtAm+JynHvgxxD8TRLfiW7EX1osh4RAeU7ftv0zm44akaxdCn6
 HoZ4wuagDrfJVdtb94wL1QJhK8tWqXkbeHUQQihrLqOcui5JMG+P4DKwtwQHl+N1W2k9
 9JAiXsWudHm4FuuhbRsGfCIxqDIVLt81CiSXUPYJMdFbiT+fk2oB0Nafsjq/YNxXXK6E
 yERQ==
X-Gm-Message-State: AOJu0YxeBWNMrGvaTe0TyIJRMWC5kAnsbpRt3Prm5ETA+5gSqPmcis5C
 NjbEvE9h0tE7pC2fab1knXuh2Uzk7CZsfFN6zkPxcrHFoXCNI8iJz0s+Mvzkfd/7DLn9XW7lTHb
 uIftJ0uM=
X-Gm-Gg: ATEYQzy+BpzdoBhCF//iDiBs7/J/sOQOgUpMEl5ecbwhUKGomWIVVNOtYSDKTCcqQVA
 m28oaj1ymHvERAtg7whOfBBKM/HVT311NGLvSTf5SlH2mtOS/rcOFThTfeMRJjiH6IYy8gkyPBp
 d0q8MEziM42suEZsirxIJJvJQ8fnaBWn+AUi6T+vMWicZrrZvMZD/kdyrkHvTBKEVI7UfzFEvPd
 rLwrzcuWMYQn1G0KFUfnQDjm211mP1a9SSNZlhvz3SUlxy9GVfP+Fz6c7Wq3uYzJj043kFswZlJ
 /hTWYoF4DgGDdW0QpSxvVAvzvygBdjaWfsRDA1tP/F4DXBvBwm+ieyUwb4gSgd8p99xAbYbL1tA
 6IxnY7Rk1kz7Wi9WfVCs00qPl6nAD1F8DYTrJL+ehQ3u6hD6G99SyLASUgEaYKxoHb94BWdVJoa
 saYpWRF1em70gDZk4DrDw6nlXE/EjpWhvTlGUOWFUU5UQISbfOwwVmcFvTZDAga7vnOZ7wNDQ77
 jY=
X-Received: by 2002:a17:90b:2f85:b0:35b:94db:fd97 with SMTP id
 98e67ed59e1d1-35b94dc0487mr1553405a91.21.1773558521756; 
 Sun, 15 Mar 2026 00:08:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 0/8] hw/vfio: single-binary
Date: Sun, 15 Mar 2026 00:08:26 -0700
Message-ID: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
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

v2
--

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



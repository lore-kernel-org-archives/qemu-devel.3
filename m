Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A85CA0FF7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0hm-0000br-Dg; Tue, 26 Aug 2025 16:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Rx-uaAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1ur0hl-0000bd-IX
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:45 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Rx-uaAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com>)
 id 1ur0hg-0001pH-G3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 16:55:44 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-32515e8e4cbso9233176a91.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756241735; x=1756846535; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nbmcAIAZ6/DPPcrsP4qNVWLydqfMFaRTzpSq/MghovY=;
 b=hHEPZQGohpHuLLEfVflBCXGh81OZSqJu2sbGYYXBmow9n+UUWYxiqgZCL1qg4m4Gq/
 MDZydsEx7FuanNyPOkSnXMXwX3djSnw+hyaWM8Yj4NsQB4ATBMGSGL4jsrYwXgY8yPRJ
 Fk+CF+BpLXbAU10sWYOfAT9HIZ1IfB8kDwgB1I9vPO/Xx3X5gG7EOlji0fEnsU0nighS
 9EmHY1ct7JR+YwV5LoXHPJYGEIFKNhy8Ya9kShq6xsdsveYjVqrieAnh+MxmU4SbhRmG
 dIF4kmUjkyXEBKZwAcufnXvtQJGMhEIXEHgk47r9C5p9CkOn2CDNb4jLJTuc0ctEjXme
 djYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756241735; x=1756846535;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbmcAIAZ6/DPPcrsP4qNVWLydqfMFaRTzpSq/MghovY=;
 b=vABa2Kf1+cDIrnP4C3fd9ukDAeIJJkvZKnP7i16MSLU7sQvk1OsIryknOO476SFj4g
 PPl4XGrs8QCCrp/AMlKlD+7g6F5AybIb8990zB9NKikIEI+r36Zdy4H2Y9bE+ZDSpJgq
 uc74d2ectCaPx3/B6HsAcJygaG2qexrYTJt0A1X7oiWjrspwuYOsK4e1WHu85cbC09vE
 G3kK1d6Lg4OjhqOKdYUP2o+G7H4wzaREx0GCasMaBlLMs6XNZH2AeCBjbC7OVtDQl5tr
 yw7IiPj28TnMXsarSHieIZQbLynoNKYpF+7/rkgjpRFosme9x6Q6rXcjU6SA0A27CZN5
 E5rw==
X-Gm-Message-State: AOJu0YyAGjsEPkAgmANbgAIIR+NH6YhaotNbJGYe0Xb7y6xZvvLVT/Mx
 fbL7RzRlRb2sxbuYzQMNdJJJ4ldknCBpsNJrXgbgjOPda8UMo43YWb2dGiVuK32SI++WU4n3znB
 ER6C33ceVzOxZRJzmzo4RT8C/gUB3RL9U2VhAMmkq9XGXIOzsArJk7l/UhmRelK5qj94CownTNO
 nJlXTOAl/6lnXGVg8Qi4Dfpwbjso0S1USZuV1RhTjp+AZNwZFnfvxYA7n8Cl4enYwVtL0=
X-Google-Smtp-Source: AGHT+IECga+8es0M0mPKi9XpgQMy+4foPnxBPtkzA+lhpJ7UkSkUeEG5QYNHL6tcbpn9hnP8xB77vUDsegfIwIzjQ9M=
X-Received: from pji14.prod.google.com ([2002:a17:90b:3fce:b0:327:6474:a285])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8a:b0:31f:6f8c:6c92 with SMTP id
 98e67ed59e1d1-32515e412b2mr18741507a91.11.1756241735260; 
 Tue, 26 Aug 2025 13:55:35 -0700 (PDT)
Date: Tue, 26 Aug 2025 20:55:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250826205532.1500639-1-nabihestefan@google.com>
Subject: [PATCH 0/2] hw/pci-bridge: Create PLX Virtual Switch Device
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 venture@google.com, nabihestefan@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3Rx-uaAwKCoo1opwvs67sto1u22uzs.q204s08-rs9sz121u18.25u@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

Create a PLX PEX PCIe Virtual Switch implementation that can be used
for modeling trays. This is a generalized version of the xio3130 switch where
we can set the PCI information on creation, allowing us to model different
trays without creating specific devices for all of them. It is used the same
way the xio3130 switch is used + the PCI Signature information.

The idea is to minimize the difficulty of creating different trays whose
only difference is recognition by some daemon through PCI signatures.
Instead of having to create 8 different versions of xio3130 that have
the same functionality but different PCI Signatures, we create one
general version where you can declare the PCI Signature information,
while keeping the same base functionality. This is not meant to fully
replace xio3130 since that is easier to use without knowledge of the PCI
Signature, this is meant to decrease the difficulty of creating switch
trays that require certain PCI information for recognition without any
significant change from a normal PLX Virtual Switch functionality.

Changes from v1&2: Updating different formatting and API changes that
ocurred QEMU-wide since these patches were first staged in 8.1.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Patrick Venture <venture@google.com>

Nabih Estefan (2):
  hw/pci-bridge: Create Initial revision for PLX Virtual Switch
  MAINTAINERS: Add entry for PLX VSwitches

 MAINTAINERS                            |   6 +
 hw/pci-bridge/Kconfig                  |   5 +
 hw/pci-bridge/meson.build              |   1 +
 hw/pci-bridge/plx_vswitch_downstream.c | 188 +++++++++++++++++++++++++
 hw/pci-bridge/plx_vswitch_upstream.c   | 178 +++++++++++++++++++++++
 include/hw/pci-bridge/plx_vswitch.h    |  43 ++++++
 6 files changed, 421 insertions(+)
 create mode 100644 hw/pci-bridge/plx_vswitch_downstream.c
 create mode 100644 hw/pci-bridge/plx_vswitch_upstream.c
 create mode 100644 include/hw/pci-bridge/plx_vswitch.h

-- 
2.51.0.318.gd7df087d1a-goog



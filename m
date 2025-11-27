Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20DED116E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 00:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOPdF-0002pb-8Q; Wed, 26 Nov 2025 19:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3j5cnaQcKCqwZMhUPQYSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--navidem.bounces.google.com>)
 id 1vOPdD-0002p7-K9
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:07 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3j5cnaQcKCqwZMhUPQYSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--navidem.bounces.google.com>)
 id 1vOPdC-000603-5j
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 19:13:07 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-295952a4dd6so15220695ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1764202384; x=1764807184; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LnAzc27LiQK6IQy24x9xB/i64MPHYZS7/qEEHPh3edU=;
 b=L/zProrqlU19m4I8RnkBhqPEPHHRg37iI/A+Wz9BDv9NyqouvGG0lbAj0lN9Y7GhEd
 UurWry5PENrrqrzu5xOf2T11zoncMo2DVhjVJiCSIZnhWamA09NJRQEQdWoCsoNefJ5r
 46eYKEmiddrhvYkNbL5Mgh+TDqnL37+1NCVr0LosxgFk3b7cMnVy4vYCrz9nWoQ9yk3F
 Y+H6jCKfMLVCBw69C31S7EfP6WPb46hjTJPGScWKu0WRziigqtwEuwf+j+V80CT4BvSh
 uzrIJDvLQuoKDDWFrB45cHOoptcACyJvxZe3KB+25vNLGTqo3FMduljhzSXCRw/t6A01
 uHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764202384; x=1764807184;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnAzc27LiQK6IQy24x9xB/i64MPHYZS7/qEEHPh3edU=;
 b=wiS57moinfG0EGBzA/DiNlBNi/eMcT0YKZH5NXFcAPXGFVMSYvfuyw7KxB1EWuTOBj
 /h1yIT65q+wNQQtxxbrAcDQwSo7iqhjB/LXLPSAFDaDmr93QWRU7atB5Ew1EgeWMS0Ua
 MOzOqbelIDFZX9CeFPYocaPrs5BMDE/YKDZbkoRWqS2eOXbvg66saI2mcRpLbGdswnmf
 86GD90w0rMnSRajH+O4YgL0B0hct1GG/WM+IFvKe2Jw/hS9Sp0PJK/QZ7cswCoJPJ9R9
 RSpcTqxvmnPx1QJMtbbN6M9sFKuMmJA4JQ4rnxKOh6L2WJwqG1HGqa90gmr16diBpxZP
 BCXw==
X-Gm-Message-State: AOJu0YwJZfhS7FzuBDHAM4rSG9gsjSTiKoJ/YsQSkttMkkvAkOJwTOZW
 ZR9J0ZPkQopSTsMROidfFUUJ8PUP15bezkBUTcECHHjHT9z4Rb5jvHpOoeZkMTp9SbI2MFjQtCe
 8KwsHlTAGTtGNuk4HN1Ka1N35EX/+CNVCdKQwLXoAXjNlmadUdXlgNsdDgj6Br1jr0AuGo7ftbv
 CgTSvJed7JgGJJOr0sza6JHZf8SoB810/XhCo+tl47
X-Google-Smtp-Source: AGHT+IFm+oWf3dffHZsfWphXzUQs2N2I4E5TDGLT2J5JnQVFZuawANcaOzo3brKAWVtpTTEceEwW2+bCMhGY
X-Received: from pjnm17.prod.google.com ([2002:a17:90a:8591:b0:340:a5c6:acc3])
 (user=navidem job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc48:b0:297:e897:6f6d
 with SMTP id d9443c01a7336-29b5e2f794amr274934625ad.9.1764202383896; Wed, 26
 Nov 2025 16:13:03 -0800 (PST)
Date: Thu, 27 Nov 2025 00:12:47 +0000
In-Reply-To: <20251127001247.1672873-1-navidem@google.com>
Mime-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127001247.1672873-6-navidem@google.com>
Subject: [PATCH v2 5/5] tests/qtest/fuzz: Add generic fuzzer for
 pcie-pci-bridge
From: Navid Emamdoost <navidem@google.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, zsm@google.com, 
 alxndr@bu.edu, Navid Emamdoost <navidem@google.com>,
 Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3j5cnaQcKCqwZMhUPQYSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--navidem.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Add a new generic fuzz target for the 'pcie-pci-bridge' device. This
target uses a Q35 machine with a multi-level PCI hierarchy to exercise
the bridge's functionality.
This is made possible by the preceding change to handle unimplemented
BARs during fuzzing.

---

This new target significantly improves code coverage for the pcie-pci-bridge
implementation. The baseline coverage shown below was generated by
running all existing fuzz targets with the oss-fuzz corpus.

=== Component: hw/pci  ===
-------------------------------------------------------------------------------
File                           New Target           Baseline             Change
-------------------------------------------------------------------------------
shpc.c                         359/511 (70.3%)      0/511 (0.0%)         +359
pci_bridge.c                   255/304 (83.9%)      12/304 (3.9%)        +243
pcie.c                         390/774 (50.4%)      160/774 (20.7%)      +230
pcie_aer.c                     119/524 (22.7%)      38/524 (7.3%)        +81
pci.c                          1154/2069 (55.8%)    1084/2069 (52.4%)    +70
pcie_port.c                    58/119 (48.7%)       17/119 (14.3%)       +41
pci.h                          86/132 (65.2%)       81/132 (61.4%)       +5

=== Component: hw/pci-bridge  ===
-------------------------------------------------------------------------------
File                           New Target           Baseline             Change
-------------------------------------------------------------------------------
pcie_root_port.c               86/127 (67.7%)       13/127 (10.2%)       +73
pcie_pci_bridge.c              62/94 (66.0%)        20/94 (21.3%)        +42
gen_pcie_root_port.c           45/66 (68.2%)        19/66 (28.8%)        +26

Signed-off-by: Navid Emamdoost <navidem@google.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index ef0ad95712..e025f57a3e 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -247,6 +247,14 @@ const generic_fuzz_config predefined_configs[] = {
         .args = "-machine q35 -nodefaults "
         "-parallel file:/dev/null",
         .objects = "parallel*",
+    },{
+        .name = "pcie-pci-bridge",
+        .args = "-machine q35 -nodefaults "
+        "-device pcie-root-port,port=0x10,chassis=1,id=pci.1,bus=pcie.0,multifunction=true,addr=0x2 "
+        "-device pcie-pci-bridge,id=pci.2,bus=pci.1,addr=0x0 "
+        "-netdev user,id=net0 "
+        "-device e1000,netdev=net0,id=nic0,bus=pci.2,addr=0x3",
+        .objects = "pci* shpc*"
     }
 };
 
-- 
2.52.0.158.g65b55ccf14-goog



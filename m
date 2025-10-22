Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9FCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZPf-0007Ql-U0; Wed, 22 Oct 2025 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPe-0007Oy-LE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:02:02 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBZPb-0001fg-FN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:02:02 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711810948aso48991945e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761141717; x=1761746517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaZKulvsvyPazuPCESEO+VqOsAtzjlNqcxauSGwGk78=;
 b=j0gMyBK9xpqrBn6Y+BiW4PpuLWB0zwQuMqw0vjJV9aWmY70gH7u8gvry7lP6Azaub7
 5AgCacYd32DcXggTtwFLnVsPMHaIbZDmHlhhx26hL58G7aiqSSkopqjzDLcs+EANsb28
 YvbbggcFbCTzmKvmu4EEvllcNiwF8zDZFJW7uwtMjlNQRGgYGY9feMfKYtioarN5BTTX
 Z3tlwvbRHoOJaQQw1CfTLbePtHFcgHG8UAEvLIGz9eC4Wmqi4jUVJZLjeWzu8Rphjk2A
 ljO8ZgryGUIwcTDUz04RaVQ2lqrIfKvs+3khvXhCqrs8287sLxAatyw0IoW6qqSXYxn/
 A0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141717; x=1761746517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaZKulvsvyPazuPCESEO+VqOsAtzjlNqcxauSGwGk78=;
 b=et3mPE5l9T9pk4r8SVFe7rbG/G4QqAdrL7Sx/BveGGY3QxoURYKpT7x8MBHbgTkUid
 +x7Vtk9ei07QJlPMwdHZ0GtqsETU4AuIFmdHtBpl86NCT1zvglQi33V5EJBQmvsbco0c
 8yXoRqH3ATG897ZDHiPn9UCEzFw6p/aiBXeDVL7MC2TjW2lWhe+VYTp53B/bQ7DVQIcp
 8RdrOGD1c/ugZkEfDz9yAEvdKKYVJ/MsoyF9tjpxmkYB8IHXbjYqYa2qPk84pmzHUahd
 iwQCSLxGig8hz9uNB++rWwa2lqq3kBF65mBTf9TmApUyI3MNG1d5d/wJ3exTZxoeT6OP
 vvgg==
X-Gm-Message-State: AOJu0Yw8CHdxzAq1GJuXh0mfaGusLfiYCyRCnvmTewjI8JtG6iWf5BhB
 Wx6hp1jxVMfR8QzaUWomZOxGoY03zZiJlANOrbSoD+mCUWQR4C5JlwqN/N02T4cu/x7YCf8/zLG
 e/+wFinE=
X-Gm-Gg: ASbGncuQIfQK4Da+duweuJJeH302AyKaTa4AH53IkUMTOmFd5zpoik5s0ML+v3Wuv51
 kqjqravznv29ulGfqwsnEaIcXfLnZ/RM9bX5hrutLXQn5KKkUkWG2lHdXrasznhF0UNGQvieK3/
 9MbubJQbu4aOJLulqkkrShW3FPPuJqpWyuTxGFlr8p5ho7lwbvS0SObfFORMyDKuOcxC5cxjUFa
 z2d2Sh1GLKd3d1f1OxIM0l9nD/BXSobYlJPCYfZzuJtFoir2uxZizejmzup0zeQ7SJ5SwgtYjMe
 4C9hvMAerlYXbIoCRC/T1xwQhPB0CbP2Nr/zaDKMAquryfl5xiv4c4oKB7cZoW+HtXbSvw8Yb2v
 FaG2ZtiPKrjhSuAsWVOVv67eNABMT0Te7JpyBAN3Prr0guYV0cqx2y+JSyADQztxUi/Bpi26gRq
 e5KHD7XImb0ebZw5FC2Ug+d+lw6NLuvUJ2SO1D6NSoDke3sEOcj8ArXaLLwks/
X-Google-Smtp-Source: AGHT+IFjoAyFjm2+kFm7KY2q3aB2HGmRZNUqm25Wo0zJ7cEcAB/9ey5BsxA253c/AteFX/omR4r+QQ==
X-Received: by 2002:a05:600d:630a:b0:471:1b25:fa00 with SMTP id
 5b1f17b1804b1-4711b25fd7cmr99064095e9.36.1761141717052; 
 Wed, 22 Oct 2025 07:01:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce586sm25929940f8f.49.2025.10.22.07.01.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 07:01:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/xen: Build only once
Date: Wed, 22 Oct 2025 16:01:13 +0200
Message-ID: <20251022140114.72372-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022140114.72372-1-philmd@linaro.org>
References: <20251022140114.72372-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Now than hw/xen/ files don't use any target-specific code,
we can build all file units once, removing the need for the
xen_specific_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xen/meson.build | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index a1850e76988..dcd2b7e1df3 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -7,21 +7,16 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
   'xen_pvdev.c',
 ))
 
-system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
-  'xen-operations.c',
-),
-if_false: files(
-  'xen_stubs.c',
-))
-
-xen_specific_ss = ss.source_set()
-xen_specific_ss.add(files(
-  'xen-mapcache.c',
+xen_common_ss = ss.source_set()
+xen_common_ss.add(files(
   'xen-hvm-common.c',
+  'xen-mapcache.c',
+  'xen-operations.c',
   'xen-pvh-common.c',
 ))
+
 if have_xen_pci_passthrough
-  xen_specific_ss.add(files(
+  xen_common_ss.add(files(
     'xen-host-pci-device.c',
     'xen_pt.c',
     'xen_pt_config_init.c',
@@ -30,7 +25,8 @@ if have_xen_pci_passthrough
     'xen_pt_msi.c',
   ))
 else
-  xen_specific_ss.add(files('xen_pt_stub.c'))
+  xen_common_ss.add(files('xen_pt_stub.c'))
 endif
 
-specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
+system_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_common_ss)
+system_ss.add(when: ['CONFIG_XEN', xen], if_false: files('xen_stubs.c'))
-- 
2.51.0



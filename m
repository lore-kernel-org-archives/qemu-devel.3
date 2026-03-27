Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A410F284B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AKJ-0007Oq-V9; Fri, 27 Mar 2026 12:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ0-0006eF-Jk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:09 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIu-000380-V3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aecefc7503so16578895ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629895; x=1775234695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DG2yGadve0dkKwtQBuKRWr51A2rW+FntUi1/70Kxt5s=;
 b=gPOV7L50ZjCTeC6P1o8OEFjB1pViUYAFsG82LvdilCc8nwTZawbY5u5NzTbG4UreBe
 lmUQWC2aMUv03GiRWzI6GO8WamzskTo0YxhxxgNh1a+wUBlyb1SBxgSkU1ZLDmZL8Osa
 xhowMwP+J+FWzAsbj4lsqOnPXwwRbqiCy2o4HIvI/j/XApbAabeRxRfn6Zl4fUBtRUlI
 geytq3D7XD2y9Xht7WvObf7+cWoM0L42eqKbvLv/fv7YHguO7DlVx3LYlZbuqeICSQlG
 xfd+ek1WrXl0PHq2U3bZHNZZgTNG64EFHzP6P50vaucYOcnNA+Ka+l0UezFhJ1J8/Yjl
 MF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629895; x=1775234695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DG2yGadve0dkKwtQBuKRWr51A2rW+FntUi1/70Kxt5s=;
 b=qeQxck0CNvMSP0jOOuxezlcPtVwFeM/GhH5xZ4U+Yv9C9fj+ozjYJi/TGCWf0YPRYB
 9U1nmtq+E0lF6bggp+8SoW6+AAMToJaoLKY0xjfmY321qpc4Y4sdaIhaWt1TlEy3zyur
 kv5zC4CncmvduIhM1+DjCWBrnp6naPl96/f1ePorSuzhB3s1mnqbTKBc4bjWqxq42Z2u
 nNuLIxh/OZYOmb+1EIET2Ewl1b8Qq8YonVHZmMfvOtf9JrniDedAeX8yH+Ohm7IVNKwG
 xe34qMECNW4UoxL6CuIFasDxaS0vbB79/dAYmagU5RlfasVJ5euAT37V0chnRj5T285e
 jmFQ==
X-Gm-Message-State: AOJu0YxC3gJo7j/ypM1CgDGfb2scrMQRdW17gSEMDGrxBJYKO5b6nnHZ
 B9eTy0hE4k09kZ1lPHUEieQEx/3stB3x0RIasM739Kqq4dpL7GYbyv/mJzwXpSjomMYSA69AFW2
 Ln9J/aP0=
X-Gm-Gg: ATEYQzxUs9D5mZH5/9wMnIHvBw1Dp6CYtj26FpxjCzcbadi5qVO4fiji/nY4W+C0zWX
 GlbYqaAEAsQfcgCgJIbLixEg9n9K6I+muoBa8lstWwplsss0Np3XtPH9uzLIAYZREeKHH0nAjtl
 VjX4hASIJ1aMxuo+W6hBOK4sKD/OUJe96/8L/Cf33BzXaXstYVqPf2JSzlRf2+x3Zp0MQeHFOS7
 vglmFRDbpHYLTM+pCrzb2JjPeeUJA325AV1i/Xydc2NdM48P+lJ4JAO8WFZtoDK+7/PMOeiRDX1
 +tLNL1QDdphBuW2ewvlcBPBCXHjU1uBTQwF/K/3k2Pe0m9yFKTsD8lJfWHau+BmvYPFcrAbrCxZ
 hcu2GXyoV7vs45xWzuwWjh5mUriVcB5nZV3tfAuPP5K7jk5J+gAtpWhb65G+30XkU3Y+4rMKqlC
 lWhZCyCPFd4puL//RMmAv/cGh6558d+xbNu2PD7oBZOHo2aUpkHrPdCGudouB6te7j8MrpsEUl5
 bDf
X-Received: by 2002:a17:902:d2ca:b0:2b0:5968:a6d5 with SMTP id
 d9443c01a7336-2b0cdc2165fmr33961495ad.18.1774629895059; 
 Fri, 27 Mar 2026 09:44:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:44:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/12] This series tackles (most of) the rest of target/arm,
 especially tcg folder.
Date: Fri, 27 Mar 2026 09:44:37 -0700
Message-ID: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

We extract tcg memory operation in a new header, with a new type representing
virtual addresses.

Initially, I went down the way to have a dynamic definition of TCGv, which
required much more boilerplate and runtime checks. After discussing with
Richard, I realized it was not needed, and that could simply split 32 and 64 bit
properly in different files instead. This approach will not work with other
architectures, requiring something else, but it's enough for target/arm.

Files left are:
- target/arm/tcg/mve_helper.c
- target/arm/tcg/m_helper.c
- target/arm/tcg/cpu32.c

v5
--

- reimplemented what v0 did with new approach defining new tcg-op-mem header
- reapply all straightforward patches from v0
- only translate.c is left, but first want to validate that changes here are ok
  for maintainers before doing more.

v0
--

See original thread:
https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t

Note about v1 -> v4
-------------------

- After v0 which was trying to do too many changes, v1 to v4 focused on smaller
  things, and all patches have been merged already.
  https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/

Pierrick Bouvier (12):
  include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
  target/arm/translate.h: remove tcg-op.h include
  target/arm/tcg/translate.h: remove tcg-op-gvec.h include
  target/arm/tcg/translate.h: remove TARGET_AARCH64
  target/arm/tcg/translate-vfp.c: make compilation unit common
  target/arm/tcg/translate-neon.c: make compilation unit common
  target/arm/tcg/translate-mve.c: make compilation unit common
  target/arm/tcg/translate-m-nocp.c: make compilation unit common
  target/arm/tcg/op_helper.c: make compilation unit common
  target/arm/tcg/gengvec.c: make compilation unit common
  target/arm/tcg/translate.c: remove MO_TE usage
  target/arm/tcg/translate.c: replace target_ulong with uint32_t

 include/tcg/tcg-op-mem.h       | 126 +++++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h           | 100 +-------------------------
 target/arm/tcg/translate.h     |  14 +---
 target/arm/tcg/op_helper.c     |   1 -
 target/arm/tcg/stubs32.c       |  17 +++++
 target/arm/tcg/translate-a64.c |   1 +
 target/arm/tcg/translate-sme.c |   1 +
 target/arm/tcg/translate-sve.c |   1 +
 target/arm/tcg/translate.c     |   6 +-
 target/arm/tcg/meson.build     |  29 ++++++--
 10 files changed, 176 insertions(+), 120 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3



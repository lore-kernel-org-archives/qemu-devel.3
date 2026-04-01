Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985110FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w817t-0006Tz-Ln; Wed, 01 Apr 2026 15:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817l-0006Sc-8C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817j-0002yR-0V
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:08 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso30861a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071265; x=1775676065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wlUtd9hzFjQDa1dMzUiMwhYcP87M56Q72IRWWsTFSIs=;
 b=qrSqosmf7An6VtjPRf/cstXDaBYw52OytweW32fXu24YQ8V65NB75FLBX4cMDgvy2T
 NF+YdcLb/Y4ZrHnY/yGDw2Hyi5D/XNdzSkK8JvVXs1wTW7BqIK2kngntHTb1q8f9DDZ1
 oDK3HvHvi/xWp0C5RijhPoNFL/aNiVzdvgP86942XP2EFtflT5t2m+Oib4LbGyQElGoJ
 taXSNvEpTo/4WkRpI/tlSf4Lfv3m6p7HX2DvcLuGtggVY7Q3oIq064FOx1OI4l8+WxVv
 LG1VnhG3B1w1G5HfQoXNNA4AB5uxfcKbRCnPj3Hh4PDQvWHxeOuYQmSnybnbQcIOuoqx
 AEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071265; x=1775676065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlUtd9hzFjQDa1dMzUiMwhYcP87M56Q72IRWWsTFSIs=;
 b=Y7FSGVdpxMEo9oPk8jD4ELkOKfX6GmgUzy+MsLRRjI0zn0L4fnMmBtTaVhgRY6hGuj
 TJ2FCEX5Aibyr1SfCpJhGHT1rBVvv/Mm0UvltNHWc6YU+OTDeoKGN1ejQ4c03GfTwg/+
 wRgyvrJL8S9JnD5X/fZiQ6DC3sOSFBL7ZQetXAC33TqNztZc+TY/4ACzWSyIps4AW5cc
 3s+Xp0bhajkmXJpWbVcIwOw3vR2DtgcTyjdkOiu/u7QLt3SAOiGbKkAWIcZPY0q+ph8G
 pZ1rYLcvftgdI7KXKniCfrn+kiSDfMpEqJll3iILSLcqVboVbcJv5qgjTjVpiLNeMDyP
 7hmg==
X-Gm-Message-State: AOJu0YwmFpd7L5djbvU9Gc/sj01IBTLWdTJeDXbnZPmpb9Sxb5mLpwnZ
 8K5IY4VVR7qNj7WsgJYJIFAi5AFe9xx8OMDTmDIRSTYtS96IaHs5LS3w7guImO4WOkevW+jI3pR
 8DcYLYSS2Ww==
X-Gm-Gg: ATEYQzys5No8BdwzbD2riiycUEJYcQf++gYKf/pH0c+zgCj75wmGKyiRrEvKlFQV+N0
 YOGQkAYxMhhyv2/av/Q/UnVUKgQseosihXmdIYjWC0pMvtkyK9U699FN3JtNIp4e472/hV2emtP
 V0Rj5U0BRyRE9ufCsRFxvCQlRm6PI98AfvXl9wnyexKMmaiDsRzwo0q+vXV6G4Czk3YdY5gxE/X
 xhXE+lanPJqLj6SHUCORHzu9sJtxNJF9D4UxwuDIwKjij2XE3tzbSn+UlRSY9xiwNtD+63Z+1c2
 4DutAya+lDOahVzbGFRitgo5O8gwvyeRKqwxV5nY7HEo3FZWTAxAxHoMcmqlndXuku19Pws6vyS
 Qbw4YJ9Yh3iAaI8+Pm05mRrQ631t4edYJPUhJrxmvowjsCglrUxAmy2fi6j2yEGJxzCO6yqAAzF
 1nS/8uqanWRjISKbERp7pg4LmzDcSpWpHj4QBxFUE+z399+GCfG9RStAGqIHJgJX0jUUaUOVKoU
 n3n
X-Received: by 2002:a17:90b:2783:b0:35c:cba:344f with SMTP id
 98e67ed59e1d1-35dc6e7a282mr4846063a91.13.1775071264606; 
 Wed, 01 Apr 2026 12:21:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 00/12] target/arm: single-binary
Date: Wed,  1 Apr 2026 12:20:45 -0700
Message-ID: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

This series tackles (most of) the rest of target/arm, especially tcg folder.

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

v6
--

- meson.build: extract decode files in separate variables and explicitly include
  them in user and system code. The duplication is now minimized: one instance
  for all system binaries, and one per user binary.

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
 target/arm/tcg/meson.build     |  51 +++++++++----
 10 files changed, 192 insertions(+), 126 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h
 create mode 100644 target/arm/tcg/stubs32.c

-- 
2.47.3



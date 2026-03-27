Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F1310F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bsm-0001ge-TR; Fri, 27 Mar 2026 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BsV-0001fy-5h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:25:53 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BsS-00068H-Th
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:25:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35c0e7b751aso2328039a91.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774635946; x=1775240746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cBpDbKYSz2C0mrlpdfzSY0eQaq3o+Kst68x4XcP9kl0=;
 b=SyDhhBx8ekFpgvQXTyLqnYmDGUy5ZIbiR47BzsqgxorZdrBK5V5GXwe2Ys1opYeWqJ
 mSaBZXT6mVDPGob2Et/PuB5S9k5qMYo78tuQ/JDzxza90Y9kaZwx0pHwguVZdkXdWVr5
 B4EY6SU5uGmq6j+u6XPrkSwvxTVBi1aHj60gK6bX2cNDHXJ5W3/2wr4f+GkE7/D6MvQP
 MQ/j4U4M7w9SUbKXi2wTMepepvqwf9cRwvppV3dm/AYUEsHBQxtFZmey4/Zur3Qp+0/4
 m33hCZsN+EEk0JtoqhivQ5l2PTDnDd3RCyoXEkttRgielw09fYyFwIic+7ERouHC3L/W
 7Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774635946; x=1775240746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBpDbKYSz2C0mrlpdfzSY0eQaq3o+Kst68x4XcP9kl0=;
 b=qyAmVD/Ksk46DWBr1wgOAI1ttKIfDbBAGVcvOIwe2vgMBYHKRCzZXCBedxwL2om7r2
 fLMubx5mXsnyo8YkQ5S4eArs3C77T4KLod2UC0rxqohSWg+czblTfCNAbZUYRvy7naUv
 1i7w27lfW+77gx5hmPgFjGSXAvDLufj1JkGxQtHpgCrzXC8ShSGYaEoT2/58YFDK+GmX
 kdoUsLowtPOcNdLLmywDEZ0ZSvY40lDnptR2r53q1hbccPjCk56GmgFweYtHK26OhYYZ
 +ochGYDWJGakpThgrbQsD/ZmzCaq6XGGgySAb++fqPQaO8p8l92MK1NemzmQNDE4JQIM
 TXMg==
X-Gm-Message-State: AOJu0YyYresTKQKHfjjuezgnobWJMn44xIBF7g1n++CuSsSF9+FwBkNO
 o69SEG8VVqMIIos6HfMubQhIXZf6V8Q0EQ7F7n9JJlXpJgGB6JFYGhElNgUSL9YY/6YSVdzFVtf
 dho1oXBg=
X-Gm-Gg: ATEYQzx03QCqgRqbxF1+CCHtfvxkt9mFvenzuTnUy0UeOHfGO5pXJUvnehBizk9Cwyy
 NiO8cl9Aw6Cpu09L+9xKuSyhvcO1xoY3TOgEPfelSowSycDy5r7W+s4HdLjV0+20HR53DQ/IC6R
 kN3SZrABymBRMa6sWGAnwYCNCkKw37rMMWi9S1iOFHf/RM1X53eAmlhKK95hSDc93dYfPpO/PjB
 +EwTrBsaIvfLgpjFAOBB+9igTBW5SzCuj8pxKw7OP0hAbUenwW900a3cvr+F7DdoOgeE0Dg44I2
 q7O1LbGhfIL8yTv44sIGEgUzdq60DgqPviZ/fn6/ElxeXu0jnqPZhQPi0FPCZbOKXBecF2RQCc3
 tx2326PTSmLRwq9WIu5bY2N/YyoOoHJllYI2SCBvSrcZ/eDVI57qx2VKRrN++stZL/cyFhVhCLm
 2Qa0OQ/vbhb3g14TXTKvafQXD11MwPrPaPYciRbKy/N/CmS39lgijaMHJ+l/j/SF4IqYJaPUmkk
 7AMM6jI6NcO/Bg=
X-Received: by 2002:a17:903:19ee:b0:2b0:6e60:9586 with SMTP id
 d9443c01a7336-2b0cdc2badbmr38666615ad.17.1774635945836; 
 Fri, 27 Mar 2026 11:25:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7a9deesm64463315ad.28.2026.03.27.11.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 11:25:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] docs and tests: assets moved after GitHub account renaming
Date: Fri, 27 Mar 2026 11:25:40 -0700
Message-ID: <20260327182541.691078-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:

  Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-gh_rename-20260327

for you to fetch changes up to d5a678c87c4d70c1b5ec4397f1daea7ff0186dc8:

  docs and tests: assets moved after GitHub account renaming (2026-03-27 11:25:02 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] docs and tests: assets moved after GitHub account renaming (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
  Link: https://lore.kernel.org/qemu-devel/20260326214436.256215-1-pierrick.bouvier@linaro.org

----------------------------------------------------------------
Pierrick Bouvier (1):
      docs and tests: assets moved after GitHub account renaming

 docs/about/emulation.rst                           | 28 +++++++++++-----------
 .../functional/aarch64/test_device_passthrough.py  |  4 ++--
 tests/functional/aarch64/test_rme_sbsaref.py       |  4 ++--
 tests/functional/aarch64/test_rme_virt.py          |  4 ++--
 4 files changed, 20 insertions(+), 20 deletions(-)


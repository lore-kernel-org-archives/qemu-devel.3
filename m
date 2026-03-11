Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9D11125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PHB-0004ZD-JE; Wed, 11 Mar 2026 15:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0PH8-0004YX-TD
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 15:31:23 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0PH6-0007Lz-Ss
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 15:31:22 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8cd80f56b27so18547785a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 12:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773257480; x=1773862280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ei6Ta+OXVkX6YBpfnwjwbldUWIIqASQEuXoZq4gA2vs=;
 b=Dmp/WZkyb93yqSW2pBuGOlu/v8ZdC2whHVK5miWfPsAzCEydb98OeaP/sTUtAN43/i
 Qw8xF8bTs3p2DfqsLnIlvtStvA7Z4VZM1qasnMmW9JcMHycJX5l0A0P45xS++NrpsLt8
 52RXKVG68hfS9FL2vy3AzUWOM6leh0fEEku1+fNy5vDg5LxFX7Pn/Um4YftZj3o568dy
 X0NQ11bqy6VoD2DmDIVcv8P3Hor1FXuFSugUjIEXMETl7zUnnNcGOnAXcBOeOC317MA8
 t4EhwupuTXyRRvSmdxlaIWy3wgcKHS0dOoDcwChszroRbrM2qz07AZnYL5ENSJKJ5zA8
 FBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773257480; x=1773862280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ei6Ta+OXVkX6YBpfnwjwbldUWIIqASQEuXoZq4gA2vs=;
 b=w+WqeaRBWGKKcsKCwcr/qjnRV/HmKk0ia1mHK/YqvBJdJ+XhEGxdDMeVpPkAK1dKbo
 AhASqtqC7d4FIoLpwSjR6AT/hqVsfvJ+9G2oEB/RPcxkJZBD4MRsk/dAoTrOMGosZahZ
 Uh2ER3rwNisH3qqb7vR3bLP6KuQW/nMHwBwVTakBMvIJs+44vpPweW0xS95xrMi9Ks3/
 oEkXUlAsV8vpr2L5l0h5G8zLTKDbrpCC7JAqgflBCoyZOBpfNEDGrQmhDMk4Nkj+pf+s
 KZXjOzOwULRM70m8gaG0Dn6eXiNdSqWT04o7H2fcLbwgnbZTuCGPeURuc1ilQdNZXXIV
 bjew==
X-Gm-Message-State: AOJu0Yww0MSM3nTTjf+QODpdtcvk+jPy66xICt0TRJ3RWYaqGmXggK3A
 i/1vYxnCam0wia3DxWvx2dlNmmmYFDaH/1HDKYWtWa6/rtIrKjoGErq58TMhipfhF0bYXjrQXSV
 PqWbc
X-Gm-Gg: ATEYQzzni9ymywQouzeCOOqD072/ZXRtJINagXPCYpdpqPfftI+73peEIEiNGFHyprE
 xQHA4tp/qXei2rNa5ArHZDHoIkvpIFM/J/voPwzkKtm4A/OhCbKHevpgmrusEzCfOF/goFSGETn
 uxFCKgtcRpwvA+ZqWMP9BqJS7fBH2XuNuHyeSzMyrmfenK16ooGPdcQbzmpDENEzD+czRTkmUMr
 cg5cVXGgu4j32t7e1SwU8vX5o1PIUvgSMA+1TN99QrzZyyuX8a3xmSG4ZIkADTiG5QmqkZL/VZk
 uj7ewTa4/JLBw09gl5bk59tDvRhoLaAW6iMEWDlyhIx2kXJk5lXjxGt9Wsv3/3s12j1KO19pxhG
 RZebB5Fpm29x/7YrmdJGcZBFPd5AIEOdrXAuQ6Dc0ti2qXtGoZs9z7cbPpKqXcJk36CQhl+kdbB
 pNZngwkhKfp5NF3cZ9OSDkt+LqkO5bc9bWlNiRh6xrl7Kb+tbJ4nUuRfywgL6i+Jt+Aoh0xf5Pt
 BbcVA0pIwvtkIo=
X-Received: by 2002:a05:620a:468f:b0:8cd:a071:9aac with SMTP id
 af79cd13be357-8cda19f395cmr489889885a.24.1773257479708; 
 Wed, 11 Mar 2026 12:31:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda214be99sm213168585a.41.2026.03.11.12.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 12:31:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 0/1] Plugins doc update for 2026-03-11
Date: Wed, 11 Mar 2026 12:31:11 -0700
Message-ID: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72d.google.com
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

The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)

are available in the Git repository at:

  https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260311

for you to fetch changes up to 71b424ca7644e2546da3f07fce3c33980d85602e:

  plugins: add missing docstrings to qemu-plugin.h (2026-03-11 12:30:17 -0700)

----------------------------------------------------------------
Changes:
- [PATCH trivial v3] plugins: add missing docstrings to qemu-plugin.h (Florian Hofhammer <florian.hofhammer@epfl.ch>)
  Link: https://lore.kernel.org/qemu-devel/20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch

----------------------------------------------------------------
Florian Hofhammer (1):
      plugins: add missing docstrings to qemu-plugin.h

 include/plugins/qemu-plugin.h | 106 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 12 deletions(-)


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA618E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKtz-0005bZ-KR; Mon, 13 Jan 2025 08:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtV-0005Xm-Qz
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtT-0007eN-4c
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43635796b48so26700595e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776452; x=1737381252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HQO9GVDNQTUiwYqISYlU2glyJAveShyUsrRw4PZ/cEo=;
 b=ihP0b7lEsjxV3tNCHccIMLVLvv+XSXdEFdOb1R8izqHeRlYcTtzJNzHzAQ6SAVawMU
 pWFCf8PsL2nCFwonOOovArpA4px2fCbBDnhPyNFmV6nh0GJ5Hi8+YFCFJ8xN5IJMuqVe
 IqiRJRc6ProPIKpydzEeODeUpTehVMV0mCUqh+VUTPhn4B5E80RE7u3Yhm0iuzS6cMCO
 ylOMeXZYw1fYSHqnFejsmMUvVIC/5Re3va96fD3ZV/yP8zTsLIAjDVMu2q4a0ShrQdZV
 9N8maB/7ToawZQ6GB3gWBQyM/Z/cK2gmF68JChJWW6IWsNr1KbCquQoC2cQudgUUkuIJ
 JD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776452; x=1737381252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQO9GVDNQTUiwYqISYlU2glyJAveShyUsrRw4PZ/cEo=;
 b=BCEszIVWPyhXDkUQFqKb/Um07UvP6/fGed4Zg5Pe1GVpIznbc+Uyd7JNOGPTlq1HZE
 kzQKRSM0Bai+pfAdb6fTgbMSClgqDEp7Y1hn8My0haA2kJwDG/ZSALMRC3+OvYu8Laxq
 CXfGXGyTGE1qDmYYy8PKGQXuqBPXWeVQ5EFQw0DXQigs4taRcnC7DnmS7Jl6jo5IbLrW
 DP3x+Pubf7qDuhbOXnhPDgCu1CPxE3d2LsoaE1tuzZqIshlz4JtGE2z1XJhlKofkodt+
 /Qx9EMtRZZi3dHxTYwOlO2DGgl+UbqZCMNbdlUonn4avf+teDw8qmePVUv2sDiFyzKMr
 nbiw==
X-Gm-Message-State: AOJu0YxssJ/DDJ4tNE3M+n/beF4OpdIXMhc/wDd7tohQlK3FgN32LNfu
 ZVKPmPoaiwwqXGNjD1TYG3fH22OEX/9OVTZYRZ84PccukrOkVa4cMBe/eem6NtVFMQb2kYyJGJ4
 3
X-Gm-Gg: ASbGnctg6eoAmrmiya52IlerAG2RDs2CXXFKjXe3twbj7kjiFN2Vkr5pvWbgSxsyErF
 piXRag9RiciPx+TWMbPg2xAO/egBFjdUZRNQYuMdxFd5HJeS4+BqS0wX8KXfKS0jk/e7aREfaXh
 kyL1i3no1GvNd8fwWwt0iCsHQECAJGjjTO0do1vdCKntSqpGigJGFnNOKbECYAbT27q4a3E/7n6
 +4XVKcE1rleEp11alkI5TAonm156/3ihumpn1kbuGPzl21YRGv3Yz6oB73xUtE=
X-Google-Smtp-Source: AGHT+IFRJqVnJfnowLpAqBtpHa7zSVK4XfddycRvaieWkipon7S7KDNK5JI8xXHexCzUpgVd8lycoA==
X-Received: by 2002:a05:600c:1e1f:b0:436:fdac:26eb with SMTP id
 5b1f17b1804b1-436fdac27d7mr20551835e9.7.1736776452409; 
 Mon, 13 Jan 2025 05:54:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] hw/misc: cast rpm to uint64_t
Date: Mon, 13 Jan 2025 13:53:59 +0000
Message-Id: <20250113135408.3164401-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Tigran Sogomonian <tsogomonian@astralinux.ru>

The value of an arithmetic expression
'rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION' is a subject
to overflow because its operands are not cast to
a larger data type before performing arithmetic. Thus, need
to cast rpm to uint64_t.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
Reviewed-by: Patrick Leis <venture@google.com>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20241226130311.1349-1-tsogomonian@astralinux.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/npcm7xx_mft.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 9fcc69fe5c5..e565cac05d8 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -172,8 +172,9 @@ static NPCM7xxMFTCaptureState npcm7xx_mft_compute_cnt(
          * RPM = revolution/min. The time for one revlution (in ns) is
          * MINUTE_TO_NANOSECOND / RPM.
          */
-        count = clock_ns_to_ticks(clock, (60 * NANOSECONDS_PER_SECOND) /
-            (rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
+        count = clock_ns_to_ticks(clock,
+            (uint64_t)(60 * NANOSECONDS_PER_SECOND) /
+            ((uint64_t)rpm * NPCM7XX_MFT_PULSE_PER_REVOLUTION));
     }
 
     if (count > NPCM7XX_MFT_MAX_CNT) {
-- 
2.34.1



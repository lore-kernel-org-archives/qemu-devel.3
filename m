Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC28FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLTp-00050n-1z; Mon, 27 Apr 2026 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNH-0007kg-J7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNG-0005Nr-2Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso102129575e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294060; x=1777898860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMqIfKVMLj1oTZTKwDNNLVPnYy0OK2XdZ9Xj1/3bKSY=;
 b=n76StaKCZQGT4Fw50HQfha2zTO5e6+NliDICipJzHRxie5tDuXrZOdr2XwRtXrcYbs
 nA0P5wJiu3Y85lqWdVHJZWWg3gTO10k6bLtwQkSBreEFimIS7BmO49GIiTX/IFY5h4Lv
 fveyCkP6nFPkutBQShgiFHK9wD+VHXyLoxTO1UmlunSDWyhcXYV4I1vjqB7aTp0TPUGS
 mEiwFn5I8ArSTWr92Mq30VZAV4gFmEBj1ezT4owibcfO2hPpHeYJ2DhQrVeQLBii2kbU
 Uys/w9Km+hxWenSuYOpoHHHxqzSBAtyulEZQDWm6UBJxkO0I3IJpy9RsqedCIuLzqbM9
 lQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294060; x=1777898860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fMqIfKVMLj1oTZTKwDNNLVPnYy0OK2XdZ9Xj1/3bKSY=;
 b=fIfo1lC8/Z/nyxA9K2KU/oc1LraHhcJFQRadUHpM6nlPXVYp3QBzKE/zrZ4fsk7kzW
 y4cHzzTGYQOT68e4ZycotlwkVV0QuFkI0Lb0APpl8e56fvlP0VggzIMZ2KckyNLJ9KZI
 alMIvxSvePYrrR5vPXJ9OvpKZmHydD+Qp09nYN/Yz49mrBfq0VHan0Z4Uj85/IYQWCg6
 NC/xazTjilZaQcUD2EMLyO7Lu7dlLZbNnPRjWPJrGRAjk5qUW04CfSIU9fcVnsVOYbL4
 RrHuoj8c7TGv+cMiiBPuyFMss+0VdluSZr+uW9fpup7rh7QM7lIWn7ShnCFX2s0pwxKy
 yOAA==
X-Gm-Message-State: AOJu0YwSERFooFPbP3WTuPuq3s86A93qizva6LVQM5KtjX3MrrGo1gcr
 JJMHVxpwIbEtTNqIjWLV9DxSV6NQM2ARxoqQEgb0Ilocy7TG4YXXOLP6K9mP1uZuXLXc2VX9R2b
 WmbJi
X-Gm-Gg: AeBDieuiuCH3bwiNgftpPa90AbdzGi2eZwx9iUu5d9s8E3Ye4jubuvk9vFcZ8WIL1Vc
 k/PVnSbWLN/KURYKP1Rs3mx7VoXMEY55DqcTFynx4fCmJFbnZFncXj56zfTP1K579jaHjfgmQ74
 xZpWmjFFzCF3AD7JfB5+rAp+HLCVZlRFVgBJtMhu9dHLTn8suwYKVjYOHACSa9s12L+aP+r8/4G
 vN8vWWAc+Pz8nqTnmEO3KQZHte2KTsK6Bdgh8DDnvyxSmuryZnE9vSk7J/PuaJ3IYppXogRu2vN
 WNuu7HqpEKR0xo3vPr331kQojgS5UwYHCETBymKIxHHlZeTtf7FbN1j+RXVCL396jSCrcifTFk7
 /T9u3rno6hYLSPiB/XLaGc8sfOXBUTr+pcs8Kd7L4vgSc0YTtVLvaoJFY8ag39VufIk+zKwLmsY
 COVFcgfE2IWuF0R0/Qv+zeiHyvdVXx+VtATAVb2Ort+F4ETSPbPrJBuq/DQUuZOco/MZM/znQhL
 itA4MGJVGxRABez1X86bEil4+hjReJ8G4cf0obYDw==
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488fb77ed1bmr582973345e9.26.1777294060364; 
 Mon, 27 Apr 2026 05:47:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/63] docs/system: add FEAT_AA32 and FEAT_AA64 to emulation
 list
Date: Mon, 27 Apr 2026 13:46:35 +0100
Message-ID: <20260427124738.966578-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is just a documentation tweak as we already support both.
FEAT_AA32 implies FEAT_AA32EL0. FEAT_AA64 implies FEAT_AA64EL[0123].

This is however useful if you are using emulation.rst as a source of
truth of what QEMU emulates and when cross checking with
Features.json from Arm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260421093506.616307-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7787691853..8cd7fe7b00 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -7,6 +7,7 @@ QEMU's TCG emulation includes support for the Armv5, Armv6, Armv7,
 Armv8 and Armv9 versions of the A-profile architecture. It also has support for
 the following architecture extensions:
 
+- FEAT_AA32 (PE Support for AArch32)
 - FEAT_AA32BF16 (AArch32 BFloat16 instructions)
 - FEAT_AA32EL0 (Support for AArch32 at EL0)
 - FEAT_AA32EL1 (Support for AArch32 at EL1)
@@ -14,6 +15,7 @@ the following architecture extensions:
 - FEAT_AA32EL3 (Support for AArch32 at EL3)
 - FEAT_AA32HPD (AArch32 hierarchical permission disables)
 - FEAT_AA32I8MM (AArch32 Int8 matrix multiplication instructions)
+- FEAT_AA64 (PE uses AArch64 after last reboot)
 - FEAT_AA64EL0 (Support for AArch64 at EL0)
 - FEAT_AA64EL1 (Support for AArch64 at EL1)
 - FEAT_AA64EL2 (Support for AArch64 at EL2)
-- 
2.43.0



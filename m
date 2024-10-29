Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7618D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nvW-000675-13; Tue, 29 Oct 2024 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nsB-0000p6-Ps
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns3-0007j7-A6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so56029445e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214658; x=1730819458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pxi72wEBVWIssBlyuwhwklhEOKwU4BGfiI/BxT6XvHQ=;
 b=vYcNeXQ9NyXJ1ZJ4xc26ZUdIsfu1km2C9fYooFvpGgu8kju24KbFht1G7QstOOq8C6
 evFALRLvLiw1CqtFWm6yiXRuoKlN1V0eRZY3e1tR7LJ0LE6ijxAx7g5amiI+GX/ZQ2qS
 +qmr0j14ZVJ/eGYtV0pYK5Gl9XABSk46YNPoZDquCM58AAKXg5fuqtOth9Mo+ZuzI5My
 x7r10jvm+93erlrxRrhC/DaCduWige9wtzj23bGi5hYCbdi0/UKyIDLTuY0NHLj1OHea
 u8TkoXV3SYMS0p/UfKdMMgN5fUhe7WauyVhd2nZ3rRm4K04svabZcK2H7B0DKF3cQzwq
 wsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214658; x=1730819458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pxi72wEBVWIssBlyuwhwklhEOKwU4BGfiI/BxT6XvHQ=;
 b=L7qf6icOOZ8x8G2RC2RsrER5vjCwZhTJVeMVxPSivlEwkzEphL7lHCjsuc+TaegQGE
 npNbeGt2pcGQYkPx02HfZ1vsuugIE8sN2RrrpWnXH0DBHa+eQwv9RQnV2vKNYL980egw
 1dZxwMW+13KKz5gYFM1Opox7w2x0e6BbY+HRgh8VORFOJsbe9PXvvdn4uc9tM7l0oCQU
 gDb/hoEPBzf87Z2XM7pXNVQHnZsQbWAs+9s8cMZIra2s6JLeDadxsLJ9Xj+Clr5ChvRI
 hpoPT5IdBPBFHldF0R8G/1gnJCsBBZxZlkbdrcGqHm1PRdiqMiyENSRG5M0tq5tw++Qz
 4usQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIeKFtA99NiqLxQbkNfp0TWusOZdICKRRqXh7w5+5u78EQkExxUV9UXFTa98xjdXinnkCGAq3O+9jP@nongnu.org
X-Gm-Message-State: AOJu0YxM8VMStZiTmVxiyGBMdIRphnlGv4HhD561XOU1N3zwhk8cyuw4
 sZmQTZsulTywn4fsm+/pz4TA4Vb+4bYSzw2JrGYCTUth5I3HJ3zwYiGlWDpaD44=
X-Google-Smtp-Source: AGHT+IGurcefVrmrukjbRawbZ4xMJgNOT5IZOgiC43vWNuEifnSFIB6bVdsjzSmeEGo25/zBELFVFw==
X-Received: by 2002:a05:600c:5253:b0:431:46fe:4cc1 with SMTP id
 5b1f17b1804b1-4319aca42bemr111677735e9.10.1730214657629; 
 Tue, 29 Oct 2024 08:10:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/18] docs/system/target-arm.rst: Remove "many boards are
 undocumented" note
Date: Tue, 29 Oct 2024 15:10:45 +0000
Message-Id: <20241029151048.1047247-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We now have at least placeholder documentation for every Arm board,
so we can remove the apologetic note that says that there are
undocumented ones which you can only find out about via the
``--machine help`` option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20241018141332.942844-8-peter.maydell@linaro.org
---
 docs/system/target-arm.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1f806cf4a46..9aaa9c414c9 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -63,10 +63,6 @@ large amounts of RAM. It also supports 64-bit CPUs.
 Board-specific documentation
 ============================
 
-Unfortunately many of the Arm boards QEMU supports are currently
-undocumented; you can get a complete list by running
-``qemu-system-aarch64 --machine help``.
-
 ..
    This table of contents should be kept sorted alphabetically
    by the title text of each file, which isn't the same ordering
-- 
2.34.1



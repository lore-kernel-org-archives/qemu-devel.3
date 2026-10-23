Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83EA606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KH/4kaOA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFor-0001fe-9l; Fri, 23 Oct 2026 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFoC-0000uN-59
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:49 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFo8-0004t0-Mp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:47 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-93f2f2edb19so83093785a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792763984; x=1793368784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=KH/4kaOAZB1dSXdoHehavhqxkshPasDt+wkuMXMUhRq6q2Oee/9pCChGvC5Rnv6l/i
 HVUasVMy3rM3XbrwJv65XW0eCvSc9trBua0ujDE3Gg4yVrMYGB/2M7ExLDEaJC7+bXwP
 9zsqo9fVrRVW9qp7M26utB6xj68NtggrnTJhFdYsA9mxs+8SARePquD86UjX3LBA5/n7
 SNXeEA8vp65ALqV+Z/BsDooVo96X3YeJwnHhwmMOuAxhHuxgQZXiNuVcKDg7FmdqLyOQ
 B3cLNenV6n0JE7yIQqrQpzQisD3kNsnlc/Wh6zAglzWjOC8QMShyLChpp+CPfZ8RJKA8
 3ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763984; x=1793368784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x4IaF9z025l/Fpk2IsxGNfdeO5acQjE/iVO9VTHti00=;
 b=a/pzNkFUi0KJb0uPJ9KBR4Yq6h6W4iHhzRlWHlBad0JfHjVEDigP1eqer8RCalCX8v
 XWiqPFgDZkv1lNoWKTsNE1tLUomkFRy1sYZ4gTJ2fm4hLqPlamd4Uug0jCGQ793LKaVY
 KJSkyjDzxwnaP2+WAPMhQ2aoEDkfGdg+MMaJtTc7/+wa5zRlacW/6dacGnQEcFGq9s1L
 ee7IOunSoxNxslndSj8lu/GZPC17YdTZUT1z57kT7SqefmsbcG5tj3JF3Br8tFFY0Z0x
 SMaD/TQRFtdV9awEbkAw1MaDeZ4+Uji83ve2zKJrQ+ZSyIcEUySKOB/DxeCBER+esf0a
 lRPA==
X-Gm-Message-State: AFq9FYLcObiuNpwBWP4MYXMP6I/9It8b9LDcnrdLRtRKkVRGI1+0amE2
 OD0l64H89rMHhcMzNPYqFW7Rq0mtjjyJ79H8vrSIqHkv810Bkx2lB+jOZ3G/S3dV
X-Gm-Gg: AYBFou2JJICQbkKsquhancB79hCDfN+rkS2Ihfi6xnEHwbIPInzjCNzJT8bGCZrnc8B
 9+mRa41yg33OvFz4uEUf+Ap7ZlIZUPLSI2VqNC+4bKdY7d9r1zSIXPEy9rfH9TPk4sleY7dIS7H
 7ska3NoX8pfna8rbsz2h8mhPRUXC2azsXZuhf8fh5xsf/SpdM73sNP3K6j3RpqqI5b7BfHre1jI
 VlDCghLf8AnZGeISy/s0sS9g7I82cK//MPaLUXghuWC9VmnTE92Y1TPdNf+wyIHndkFOhKH1zmU
 o1NlAJm8i0pZjkTux2W01l0buA+yY0IDmuG3dqmOjzGjPhQcPXOL5wYI7oE5ReZT7aO7YkI65Cg
 QZwYNMgUZTAIriuDbL0W+HR+k4FYK3rRLPdhw6nsHeCGWHooUi7FpoVDCSxlzawh2Beg1oRxVGE
 lBh8JAwPj7kdMIGoVcB4RPOGF0w1FSdoEbE6Cl7+DFuGiIbJPAtawCNkDSTv3isjn++yhY1kkLz
 FxEgnyCVsB+6n6wgpYsnrZoug+Q3nTGN/c5cDhCiGYRvfTu8jsW4hNICK95y4hRtXYF8KN/+N6W
 bLl182O5FtzFYDUPl7GKR9aqZUw4x9lwCDG2PQeEI3eM7Iijz4LW
X-Received: by 2002:a05:620a:278c:b0:93b:c537:fdb8 with SMTP id
 af79cd13be357-93f6f58a4a1mr404598085a.6.1792763983688; 
 Fri, 23 Oct 2026 06:59:43 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:450e:e72b:156b:33d1])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94047811552sm23741285a.18.2026.10.23.06.59.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 06:59:42 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 15/16] docs/system/arm/raspi: move PCIe/GENET from missing
 to implemented
Date: Fri, 23 Oct 2026 09:59:23 -0400
Message-ID: <20261023135924.64990-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023135924.64990-1-marcelomanzo@gmail.com>
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c3..a8fc37e920 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.55.0



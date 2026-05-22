Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14BCCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQTgY-0001K1-Ud; Fri, 22 May 2026 13:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wQTgX-0001Jr-Jl
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:29:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wQTgV-00031I-O5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:29:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so10349415e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779470957; x=1780075757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjaYtSgqR7wY7A2y0laIyTjZiB4G1HR2dnJ0XIgGQt4=;
 b=H7E5Hfsyw8BnOWImEC4XtoQJh8l6iKTr02avbEyP/bgC/AaUFugWuQlbem9lSD7wYp
 NToh2H6CNI50oJrr4u5BXzmVMjRIEGsr4pcKCgMMQIMlK30BK7ksMv+B7/fFIZK8pGt/
 x7XOuvVM1zHZfGVaOdegk6yvTVOMZDXiz+AEoA/27Im+5ugVv+jSZMO1F7rnKPnGIceW
 M5H8LXtg5SIxcvaoAnmp4+bDBS9NMO5yuYCgiL8J8xDgnjGx5aoDYXYQsYoNbYpC6r+P
 Un3LWAE6iLB7DkVKb3JZiNClcBC+20Fn54y7VEyL4/mrrq3LSaTTi/Fa1CvKXossuE7E
 nypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779470957; x=1780075757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjaYtSgqR7wY7A2y0laIyTjZiB4G1HR2dnJ0XIgGQt4=;
 b=ku1O/fSXFdfK00yixXd7YVQv6c7rhiEuYa9aKGFGkCqRgNdJhMWtJ6hHZ5X17G5m/7
 5t2Jbv176DFBf1U1oTAIt1KShOAWLzVO+iLK9v0gv3nIx9evFDfKuBfnCKGUCpdi2hbK
 hD13NGGR9FAwCRwFFvpgN/A/SpD3sWwU6R1O4skvSB2pkphdzm8WNc4EjtZ695fEzWR1
 u+fM7z2drkWDq+0YbEOJMaQOBjA3niJK2M25fBDSG3DlHFMitotoSbjGRYwNyqNA2sOL
 9dVTwqsccH7RQ/bwzJFVIDFaE9K0y53LbhIRbx2aqfXOEp6IP0ur4ZMOznejiOJ8pCmQ
 wBbw==
X-Gm-Message-State: AOJu0YwEk/9VQ+FALTDCiWGP0fb2g2S/EFWJoKzLdwrMX1eL/n3qdH+e
 ddAicMrV+hxhhimOm530zdSqvT/JdqrTuSW3snz45wrTbie4tOnwHGCR/Uaib/tOljX8WQ==
X-Gm-Gg: Acq92OF48lXynQD9Ah0G4kgksJx4qPRYypRNss1zqbvDMpU+S7Sj3gNmycwqPKbgbQU
 01JyGIY658KklBYk9JXlx8l9l5K6mYziXw3mHgw8NRDTcyN8uQsY7SQKlK4sCUELBH+lZwTq0dB
 oiyQgq9HqB8Sj81f+exXSRFuwQASylNKPy+/8PogBXHyTylnoNZcv+Hn4UcfQuPU0/FIRAOBXjT
 hRXY61ve56+v4fnXFx9WupFxY5PxrXn/etds2dnMDAEARc0dVqlLUWAYIcOOpKiS37Tqh0gqjTu
 1AQyrXZWxUbj9Nq5N9lZ4dZpvjcdTwO+ELhvB442mPoxOXFiv7ze+vS5G6cMc2KMuXLlVXFjN9R
 +2/vn/BL6Xvi7lG+Idp4S3YN0KUEd+mEE+kFXfVUlxQgeHA/eCq1rb6sg6op/zFx78Er2jf2Z5R
 PSxDfuiu4CFz7u2ZA6nojibTSMWZk=
X-Received: by 2002:a05:600c:1392:b0:490:46bf:17ab with SMTP id
 5b1f17b1804b1-49046ce6026mr49620665e9.29.1779470956763; 
 Fri, 22 May 2026 10:29:16 -0700 (PDT)
Received: from fedora ([197.211.52.69]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm49407775e9.0.2026.05.22.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:29:16 -0700 (PDT)
From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, deller@gmx.de, stefanha@redhat.com,
 Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Subject: [PATCH v2] hw/scsi: add scsi-tape device emulation support for QEMU
Date: Fri, 22 May 2026 18:22:05 +0100
Message-ID: <20260522172205.76871-1-emmanuelugwu121@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513025854.76594-1-emmanuelugwu121@gmail.com>
References: <20260513025854.76594-1-emmanuelugwu121@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add copyright year to header

v2:
 - Add copyright year.
 - Split into 5 patches for easier review.

Signed-off-by: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
---
 hw/scsi/scsi-tape.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-tape.c b/hw/scsi/scsi-tape.c
index 650f75471f..17d9ce4e7b 100644
--- a/hw/scsi/scsi-tape.c
+++ b/hw/scsi/scsi-tape.c
@@ -1,7 +1,7 @@
 /*
  *  SCSI Tape Device Emulation
  *
- *  Copyright (c) Emmanuel Ugwu <emmanuelugwu121@gmail.com>
+ *  Copyright (c) 2026 - Emmanuel Ugwu <emmanuelugwu121@gmail.com>
  *
  *  SPDX-License-Identifier: GPL-2.0-or-later
  */
-- 
2.54.0



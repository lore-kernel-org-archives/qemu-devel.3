Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4DEC48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 21:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX6tF-0001Jm-LL; Mon, 05 Feb 2024 16:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jens.nyberg@gmail.com>)
 id 1rX6tD-0001Je-NB
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 16:52:31 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jens.nyberg@gmail.com>)
 id 1rX6tC-0003ZE-9i
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 16:52:31 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51025cafb51so7352118e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707169943; x=1707774743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FDRyVjqhVF5KwGL5oTOoWOtYgrRSRVlkwpfgpimYC8s=;
 b=KhObKzXzs09zkoNBa1/Sqd3UTqCi6PFLRMcpdgUkFftQrUuCBb/DLo/SFhxIrcs7EP
 BiNcjMyJLWPZ+cxXXfTIysKsgU7t5n27pbjg4amKYPlDKmo4f6+JUxZHsjN8+Bsl5Zby
 ICwwMg+6cjFU8vVp/fIoGwIQ/j+f3l3Jwi5y2mzhK+TTOIX+5gKVw8j6uQk3pVj5/2s3
 R0x7UORyRR8tX+j99MCPBE+TXnwL86q+qtdEC4D9kVPp1HsurVQ0bsVSe1mOxtrmWTY5
 wt6PCEP1f2MWMZu3DxznWdM/E/xqWVCKrf9JmSzd11W9/d9awzLo8dG4m/qRoxXJVVx9
 pjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707169943; x=1707774743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDRyVjqhVF5KwGL5oTOoWOtYgrRSRVlkwpfgpimYC8s=;
 b=Z/l9Jk9fmhcVPpkCooKgiC99SSI6wDlHLQVNxnCDLR5AjKaYjB7MJ+r46EK7XwJGm1
 S6xtVUTM86w/QgrYjPjN2wY+phyGNNoaIR+HNdT0dUcJ4w20bXooReNbkWuUprr4H6VD
 HH/FJBiQd3pCD6VjEFo1wFZIrKIL69bNsr7kYNvyS+GIXUkoOyedlMVE75EY6sZhFKgd
 FlPacv5w9CZhkxOk0DDayDy161XGUeD53HeqOP7rL0Ygkr0GMxVW9DbYjiMyjVGpBJjG
 yxNp1Zf56t7E6C2C9LiPB/c/J9Z/MOkOfgFkBmPd+7o9opGlaOaoknIJxlJPtxSuNo+6
 YItg==
X-Gm-Message-State: AOJu0YwFkyYbJ2MaSqwo55xi2SJk4MXn5V0TvT12CHEMYD/c7VGjbMWB
 x1Ulw4SNS6Bl6giJg7eSVsLwIvCEp2G/asRMnDUp98l3730PTyUmYp00WIsGW+A=
X-Google-Smtp-Source: AGHT+IGclgXRacRvYTQhLL+KNodJZOg16emhmi5D3tFUOMom4muX/8X/mgWSYjcxYDJT7dCt2ZtCuA==
X-Received: by 2002:ac2:43a9:0:b0:511:551a:c34d with SMTP id
 t9-20020ac243a9000000b00511551ac34dmr541413lfl.25.1707169942965; 
 Mon, 05 Feb 2024 13:52:22 -0800 (PST)
Received: from localhost.localdomain
 (c-9684225c.01-1057-7570702.bbcust.telenor.se. [92.34.132.150])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a056512358800b00511495618f9sm60941lfr.304.2024.02.05.13.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 13:52:22 -0800 (PST)
From: Jens Nyberg <jens.nyberg@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jens Nyberg <jens.nyberg@gmail.com>
Subject: [PATCH] hw/i386/multiboot: Make bootloader_name static
Date: Mon,  5 Feb 2024 22:51:48 +0100
Message-ID: <20240205215148.2356410-1-jens.nyberg@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=jens.nyberg@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Global variable is only used in a single file and should therefor be set to
static in order to avoid name collisions.

Signed-off-by: Jens Nyberg <jens.nyberg@gmail.com>
---
 hw/i386/multiboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 3332712ab3..6bf6398d01 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -102,7 +102,7 @@ typedef struct {
     int mb_mods_count;
 } MultibootState;
 
-const char *bootloader_name = "qemu";
+static const char *bootloader_name = "qemu";
 
 static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
 {
-- 
2.43.0



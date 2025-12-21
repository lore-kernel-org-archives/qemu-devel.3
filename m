Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83570E67482
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKgV-0008IM-6z; Sun, 21 Dec 2025 09:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vXH4P-0007Or-OB
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 05:53:49 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vXH4O-0002nC-Ak
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 05:53:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a9567bcd9so2577215e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766314426; x=1766919226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gFNfnwGU97xGHPfd21mpBWZF7bSVs2VdgP/4QhHxwu4=;
 b=ixgnoYfN3pkdkHCqAC14ubVcxAwGAy3vyEPCJok8cxTyhHrMjxOp9/oPPiI07Ztl3c
 CDCaI1jc7crhYQJV89484HEcr0H+mXQ7/f1mMKAoaq+VlPSNxIJyuaWMAhATRfAdQYoO
 vP0tzxfXlve4JY+d4cUAu6ovUuXUSoPtAeA7vm2D9RwDfMIxEANzoDPRAwoWmtVtkwLt
 jklfwxbHmFW9bcijDmSP1g3yPbcDjfCaEv5SJysMEGAs2akRU1BlW+VOnUlGtqpKBLOo
 C6gQQb3vpEQPWe7T8VyLMyykjFr8/H82BVPStopiEwhh8rlCLSdsNy9eaJjvEggscoaO
 bz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766314426; x=1766919226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFNfnwGU97xGHPfd21mpBWZF7bSVs2VdgP/4QhHxwu4=;
 b=Yx2lO/JupZcnyzmGLnKeCDeH/MSP5YJGXuLHZl69fNljFcegl+ttuEd934u1cPYbiD
 YQ6OG7f2o0XHsNVjXEWnittpp2Fopyp5WtOt63p4gah0Eh7ZGm2sw4ZH3oX2dOSgzvlm
 3alHRhtbDO6UO7n6pt1Cl5/rYTv8s+tX8M7g15Q8nIQPPYacvjpHOqjgPxlg3wabFNL0
 qiQqP8NpXOEvVy/vTUr5wUa0lof6S80SY/z5UFMV9uuKaSFmiJA/u8sA5mKEroKy8D4m
 KqOvngsbRiFbHgXC/PCmxiKBT6E4h/joqOs2SW1Ik55sY3Pk82fa9DgzvE7po+qbxi6R
 /+pA==
X-Gm-Message-State: AOJu0YxkXXpb6cOqLUkW7qIcfkDIsFaGffhZRA0qaQqXiOIjZjm//Clw
 MVX3vZZAn16rJWgNFdWuBeZWYfOvQcW5xlrGjsxw1waeevJQRzRWHrxOB3V4+IIc
X-Gm-Gg: AY/fxX5oUSDOUAD5gBCaG16nqP3lG7jsfbX8QDydM1+iFFsC5Jwikc3HBcLXlC1XLFj
 krq0CA6RxT6YmjV4zwOnIU6b7VOVT7iv4PmItBFk2rmdGOeCCc8cHeacPtYbu5+4rXA9PCjtxYH
 9IqM4d/q9oxAraoqaO3LNzLOwR5d7swQ1NW5q5+Kx4K4TzgnJ53QwAsZrNZBfiNRvRqQIVwNXBk
 OURjZLmsEpPmynvk/AF3ZH5YMAa1CMGJYKE0jndwjbraIL63g2BuScuCIjqKFvGFvKmGAG85hwi
 vamtDIjYbCm8r0nNwaKioIw25x1trdHS6tCy8vS4g/csrxETCuSELwrY05CBSjhQuPwpAK/uS8x
 aEDFV8c+YlFoSfmfvwhfJ6vq++C2TG05eVrw/ZKkS2cMwpaIhr4S0r6r5Q5fJxCdOJV/N4JdXJT
 z7257Mi6Plhj8+hRpGrUQWq5k=
X-Google-Smtp-Source: AGHT+IHLz6CeEF07ibBuiRm1GJspg2vB3lxTSSBT8EeQqtmV+P1qLw/31CgS4737ol8YkzVw5q+wlQ==
X-Received: by 2002:a05:6000:1867:b0:42b:55a1:214d with SMTP id
 ffacd0b85a97d-4324e4bf4c4mr5220329f8f.1.1766314425492; 
 Sun, 21 Dec 2025 02:53:45 -0800 (PST)
Received: from LT-1H84393QV6 ([79.117.168.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm15879557f8f.32.2025.12.21.02.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 02:53:45 -0800 (PST)
From: Joel Bueno <buenocalvachejoel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Bueno <buenocalvachejoel@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
Date: Sun, 21 Dec 2025 11:53:39 +0100
Message-ID: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=buenocalvachejoel@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Dec 2025 09:45:02 -0500
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

The Fast Read (0Bh) instruction requires 8 dummy clock cycles
according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
However, the current code adds 8 to needed_bytes, which represents
bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
communication (1 bit per clock edge), this results in 64 dummy
clock cycles instead of 8.

Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
(64 clocks), matching the existing implementation for SST flash and
the datasheet specifications.

Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
---
 hw/block/m25p80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index a5336d92ff..21c2118b33 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_WINBOND:
-        s->needed_bytes += 8;
+        s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
-- 
2.51.0



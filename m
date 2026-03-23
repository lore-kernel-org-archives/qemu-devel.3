Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86B4F483D6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iYx-0000sB-CV; Mon, 23 Mar 2026 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYk-0000ar-E4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iYf-0000vH-4P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:55:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso3265455e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284915; x=1774889715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7h0pnAdsdCjYCynDN/kyff4Hk5hBkXEfGF5OgBL9Hi4=;
 b=MMflvkxNiPi1NaJNG68M3PSiYZthJKxhsKP8xn/DqPEHiQN8gROynsBJ3qqGHz7vwK
 6tD389ofG5x8mmd/XDmmWs9MkrDgEmFnpb5lzw/QgZeeP5j2p3dtPgaBtfS6SG9bA7XH
 K3oJCcFULUHE+cax5L2G7ePy3ZX2XZIRMBgl46vEu37ithWWJ+Q41HyZr8cym9XjGQ6C
 hoZbmpY8GGTCCICRrOPxr64bWVhx3Q6TTarXJ4vX9mS8pKjgjuuBUj5HfDeT8dKYY0gb
 MsmP9mEC/+CRmbl95zA5gKc+K6ABWssnwk9EJ2K1lY+nVdXK1tLQRazfnqL0S1JB+ar0
 JoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284915; x=1774889715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7h0pnAdsdCjYCynDN/kyff4Hk5hBkXEfGF5OgBL9Hi4=;
 b=logoyCjOZtL+Bmhk8DkAZZCAsVUxCUPvOTqCq34SHVMEAIjYG0z/4Q4+umIKzB7Xm9
 nxznSU6anvt15TV0g4UP8+79Ltc5rv1ruWrbR6+ZMzPnqfRKIujVRiHMVLxEJ5WgUcQ0
 8m0MS89p9SrMLVD6eCYNgeyepgESRs5jE0Y/gV9nCoTi4o1x6jTAuKG1wkL+Sk7nKq0U
 RbTacnnOzDwFiJE9PpVjtEvpLSlQ+eN9PSMP8AKI94xcjwRXPeFV9f09nN88BxtRj93i
 NvxCuGYhWhl0BMby8KwwXPCuixfQ/RDwvcxvZjhCfhQttwDLVpO4UW9hOnxcTQlLRZOo
 nONg==
X-Gm-Message-State: AOJu0Yy3kJnOdvd4gYZrBto0OSuZJw+MLMY2f+6ZqCWtCzapGNxR7Sk3
 Np3WjphfTczYDnxkkmFc3S2TxW5jvzssXB8WjWxsrzHgf4tyz+/eg4NhryNxg6oL+8yNuzsywrY
 9MaaGjUg=
X-Gm-Gg: ATEYQzxFu/yBTBPGrPbRxSEEt/l/vwh7PyxYGE/l1KFadVQ/HgZzBokdXAIQ5A4zO2P
 9VxC32qjwBOQc9/2/Ms9/7hR/FL0HauYg83l9QSE7ZQ/KZAXaWMBJj/ylCcJlI27Venp1GP5EZd
 l5FscJjtQGkDINKL6/0fBHedlHtYxS1STrgHhREcl5x+Mc3V8SHvgT9xtO7pAYBry1cqcqKU/IA
 gMZkKZAtQhT70K2ioKOuXIiqVcOVOEYhZxP57bfEUh0LlIodLSJXW3EQkCef2I73NK+HUXcJSfJ
 pNN+GeCv/WkcPyhWsGYUIXKIvz3STswd6q8e/ZYBUBmpxXwqw/LPTPW8O5/Sm3WGCzhhHdVpuAW
 +Xzq/KTEsEbyEhW2NhagHqFs+ZLY9heoZx0Ij0bbcbPn4iYm+tXAfLFW2wxzwQN2GQ6gqXKnlBb
 yr2vF8zuFXzTBNBnhkYXgUtuILv6jbFU//GTHqh+tkHSqW+X8x3G0zmYaz9GYyfQqE/aSX1a7P1
 wJYCxvbcMU=
X-Received: by 2002:a05:600c:a416:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-486ff0303admr158190495e9.24.1774284915096; 
 Mon, 23 Mar 2026 09:55:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe967c64sm287223065e9.2.2026.03.23.09.55.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/27] monitor: Correctly display virtual addresses while
 dumping memory
Date: Mon, 23 Mar 2026 17:52:17 +0100
Message-ID: <20260323165218.96607-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

While reworking the address format width in commit 6ad593a75a8 we
introduce a bug, leading to addresses being displayed with too many
zeroes:

  $ qemu-system-ppc -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  0000000000000000000000000000000000000000000000000000000000000000: 0x00000000
  (qemu) x/x 0xfff00000
  00000000000000000000000000000000000000000000000000000000fff00000: 0x60000000

  $ qemu-system-ppc64 -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000: 0x00000000

Correct the format width to restore the previous behavior:

  $ qemu-system-ppc -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  00000000: 0x00000000

  $ qemu-system-ppc64 -monitor stdio -S
  QEMU 10.2.90 monitor - type 'help' for more information
  (qemu) x/x 0
  0000000000000000: 0x00000000

Fixes: 6ad593a75a8 ("monitor/hmp: Use plain uint64_t @addr argument in memory_dump()")
Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260323095020.66658-1-philmd@linaro.org>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a9..bc26b39d708 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -537,7 +537,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
-    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() / 4);
     const bool big_endian = target_big_endian();
 
     if (!cs && (format == 'i' || !is_physical)) {
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F1CCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCdqw-000452-RE; Fri, 02 Oct 2026 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqq-00043j-0M
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:05 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xCdqo-000853-JT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:03:03 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2df4aa80a73so50587945ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790949781; x=1791554581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V2RZzwl9oCOaU/YCJHZH2VBSRzb3jVPLLWNZRqi7UZ8=;
 b=c7oTeLr/tH7aQJyCpvzVHhcXOldcLr6oiL8QA9R7TwkEgaSTHta8nav+5rdp2Rkof+
 nAtLEhftK6MrsiQL+E73HDvTy8m5mbnBRdOVld26ciS9MmUXERj8NLz6JJIGXzJmwmUb
 YhuP/hE04ky0Yp5MCHIvpDsR5AAZd3U+iMtNmrTs/Kk/qammeZ3DRbIN3NbwiCWw6iEl
 jQsaaeRhbbNCq7d/mjDWzoRXkt7m3KWQx2h95T1ggPL/xU5/BKbcxISDLlEWQbjRPcQX
 tptXlHjtqPSpNU/bqiFtfQm76FJSf+J7LxahzFbttoLGcXqYqkMckkOljGIL73mLfww/
 kpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949781; x=1791554581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V2RZzwl9oCOaU/YCJHZH2VBSRzb3jVPLLWNZRqi7UZ8=;
 b=TSXMbechSHfLuyvD0BY0axkW5C9kyfMZJH/Qs50KYuUUV8RpFIgMRR72ddUpuYmfmM
 qzMAGJpQXKKFz55qW2TVJnObOhBHbtWPRVsuPfcBL8cKUzlBdY+DrSktaoT9GE65yLnb
 rxGocAb1jt5ChZ9KALqLcrooAxaNVnPUGgE4MMpHqWd2n331o/KdaI0LfFJB/iYT9Mqr
 asm4EVABNgdG8oKIj7A4DzaJ8tpiSp7BykgL++T32TgTZyCkRgcX2wVmDkfURXAcsAw6
 1HhXzZgrMG1ogENVAXZHxzGQW9i0tWNnsXqnP4ppGm4jFF8I4ZTtEhu8pul854d9zIvp
 Z68g==
X-Gm-Message-State: AFq9FYKJyoR80VU5qYMKWoiNwDZY2nry8YVvYP2RoOwgHAxMxZDUMbrY
 HOgyGDPeffV+rlxG3NvVfvkKMtU0yY9oRHbX1NTFb44JAT63vgS+CrcVXTSShUgH
X-Gm-Gg: AYBFou1fBXLFAp1QI3f/3vJc1+XBHxBXJxJ0B8HTNGKH4bq5Dm0dLxGYFUvRsWfqDpD
 ijQS8XY4OsVGXrOKlbHMb/ObBIr5bmW4KZRLaiIhTzTnFe6/tBLc/ZJSjgqd13RvJBJ5z/OtBLQ
 uvX9kjtcj1yjAa/00BkVKekRofNotuLiUBMRZF4N+/8jgvKmLJz6c3rRULo1zhDkO/ut8iSGhwC
 Ylas6Gkk5Js5DozUOVoFrG7LFLShjdZgtwTF7ytUUK9kEGnR9isF51ehQIMLbKCJHxnNjbJKK1X
 gEpJsqox1W6fxFGAwSD9ltH7w0SkysNniRFrLRbPFIFwDP1eE8RM2Chi5K1tpJD1Mpq6q9g6xBa
 R0Ahx9o8falVoAkoLxuPmg84TjHMNHKW3rCwrxM2RYvc2xaHIFmCrLhY9ZqJ0r6tXAUExxibaKt
 R7NWjpVmcsnx7t1Qist1r4vsQyF3yDhvVCn+a7k1lxn3tWaKlHhGpTP+AamZvgnYoglyff5tLq9
 FfcH2BFhF/CUmjF
X-Received: by 2002:a17:902:da89:b0:2e1:530b:d890 with SMTP id
 d9443c01a7336-2e499f09e52mr28982965ad.5.1790949780939; 
 Fri, 02 Oct 2026 07:03:00 -0700 (PDT)
Received: from dt-VM.localdomain ([101.207.27.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f723a77sm7996165ad.71.2026.10.02.07.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:03:00 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH v2 1/5] hw/misc: fix calculating output address overflow in
 k230_decomp_gzip
Date: Fri,  2 Oct 2026 22:02:41 +0800
Message-ID: <20261002140245.30214-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002140245.30214-1-dingtao0430@163.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use hwaddr for address calculations to avoid 32-bit overflow.

Resolves: Coverity CID 1685515

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index 0d8a3b2d2e..ac06cc1571 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -53,7 +53,7 @@ static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
 static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 {
     return K230_DECOMP_GZIP_SRAM_OUT_BASE +
-           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           (hwaddr) s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            s->output.current_offset;
 }
 
-- 
2.43.0



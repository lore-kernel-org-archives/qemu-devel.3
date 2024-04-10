Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5788DCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU1v-0005sU-S8; Wed, 10 Apr 2024 05:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1u-0005s3-UB
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU1t-0005aa-6y
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso4716518a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740442; x=1713345242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cl/8eM6HtaFKzS73NnToQu9iXIco13zqVdgURn6Eu4c=;
 b=cFh/Isz4AkfWhxCGMn5IO6e3+UrN7sjAhPuhxidtXfcaqPjM3jJERof/JU6J1Z9Pnt
 Unf7kn83etLRdJl6YKgrhLyTElPBCY1AHDIGWt+K6+5aTGQPLyiLBbe+3O85KTa4XfzQ
 0s+L6VY7MM/0RrRt0rDiKCtcrQcZvfB6Y0YSar3uv82HFJlWF69YcUjbJ1q5mve12rsV
 fYku9r2LfB3i2YgaMhWfEsrPxrDBjo7/BrZvVeK1Fe4NiP3tghYas/ZjPuDP/3UGgI7h
 OU7S4U4NHUw2HfDHDvhLYZAdlIDUTo02OLx+dOV10+BKP99n2f8HKFJFCfmjV6JPiXqh
 6jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740442; x=1713345242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cl/8eM6HtaFKzS73NnToQu9iXIco13zqVdgURn6Eu4c=;
 b=Ib32eWSKtaVPUPWL7t5h2h4lF+sqwhoYRQIQ+kSgLHZMZiBp7R7IJzsgY+5VlaEqic
 ere7Q7eYz+umV9ynyrI53LPP2mk4v5MGHkcrI1AbNMzuIIonISqSmkBSNuf8/VUczo3X
 qRh1yI6oulU66nVU+N5aott2IFMkeQ0AgATj2JqPCT/t1vqXwp+mPO+jmr/KRnSFio86
 Z5htPi+V69EGorxtZ7p2WTOaUJxjgS/98VjUlHiZ6Edu3pv8HxlFUxPu2zOWLRAr3Pp7
 0QrcS+57Tfx8dmsi8wxCBk6HeifUmOYLjc6mPE3Lj65yHrH28ReRy9Uv8GOeD0Mi1bLI
 Nk+g==
X-Gm-Message-State: AOJu0YzTzW2Qnb0Lpoaz3yYGM0cYZj9tb4qB8T+lgaDvWaaxlSjYIimd
 WSJIqvM1FRWqRMv/TPfcl62q0LquJ0LirHnaE2lf4bRjYhD830Xt6fBaOPXkFtryoy4lFdwOZnL
 X
X-Google-Smtp-Source: AGHT+IEKi/itgsqITl6Luze98rbUOYYknW+dW6doyRjc5WQrQuI2cosSQHrS5nx6F4XPhOpxtdYrgQ==
X-Received: by 2002:a17:906:3782:b0:a51:dc1f:a3b1 with SMTP id
 n2-20020a170906378200b00a51dc1fa3b1mr1435230ejc.39.1712740442464; 
 Wed, 10 Apr 2024 02:14:02 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 bp5-20020a17090726c500b00a51db91186fsm3254243ejc.119.2024.04.10.02.14.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 07/16] hw/block/nand: Have blk_load() take unsigned offset and
 return boolean
Date: Wed, 10 Apr 2024 11:13:06 +0200
Message-ID: <20240410091315.57241-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Negative offset is meaningless, use unsigned type.
Return a boolean value indicating success.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240409135944.24997-3-philmd@linaro.org>
---
 hw/block/nand.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index f33eb2d552..5a31d78b6b 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -84,7 +84,11 @@ struct NANDFlashState {
 
     void (*blk_write)(NANDFlashState *s);
     void (*blk_erase)(NANDFlashState *s);
-    void (*blk_load)(NANDFlashState *s, uint64_t addr, int offset);
+    /*
+     * Returns %true when block containing (@addr + @offset) is
+     * successfully loaded, otherwise %false.
+     */
+    bool (*blk_load)(NANDFlashState *s, uint64_t addr, unsigned offset);
 
     uint32_t ioaddr_vmstate;
 };
@@ -772,11 +776,11 @@ static void glue(nand_blk_erase_, NAND_PAGE_SIZE)(NANDFlashState *s)
     }
 }
 
-static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
-                uint64_t addr, int offset)
+static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
+                                                 uint64_t addr, unsigned offset)
 {
     if (PAGE(addr) >= s->pages) {
-        return;
+        return false;
     }
 
     if (s->blk) {
@@ -804,6 +808,8 @@ static void glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
                         offset, NAND_PAGE_SIZE + OOB_SIZE - offset);
         s->ioaddr = s->io;
     }
+
+    return true;
 }
 
 static void glue(nand_init_, NAND_PAGE_SIZE)(NANDFlashState *s)
-- 
2.41.0



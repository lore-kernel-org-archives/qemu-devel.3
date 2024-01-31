Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F5C48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6Ja-0001wE-CB; Wed, 31 Jan 2024 03:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JT-0001uU-S7
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:21 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JR-0007s3-Cr
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40f02b8d176so12884825e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691075; x=1707295875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9v7qgpqTwh9hq22Mg4JAHZdgJYch8tJcJ4v6ze8WCo=;
 b=ZPoXcyEBCvZNSMq/t02gNYWG5Pp0UMPQBa7+e+ae5nUJf5mXtAd4sYJ8ZuMAn86QYr
 GwnkxCQ9leGDL1FWgw+arvKY2CJc1UHF4ReDgjUNc1AXDDi1nJscMqWtz53mMqLBLGpt
 +NxctMHaKML5qep5nRLp8WQmjiodzAn3bDI51qXHwAeSBZ0sSxU7eZV/sug7SArNONVA
 px+aoA8eo2qp4jQP6GqaWeyIS47k6eXcHhZrxV2jFAmZim0OMqtY4BVhTIIYDUF01bQi
 RoCamVZFqvtxkyzvWbkqysf/6lMYXfa9Jcmf1rdx6Rr2DWFH/d7XwjuohUz9ytz23+tB
 hIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691075; x=1707295875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i9v7qgpqTwh9hq22Mg4JAHZdgJYch8tJcJ4v6ze8WCo=;
 b=rk3iIcCnqo0qKAOGVkJTiqABsdJcXVB3i4Cq8KviiOkdHKuJzS6SsCzEQq7AefLoN0
 LlY8XKuIFX2CvNl+1E0I0gxSzjRpPgagKkn6283u1UA1kL4c6N3wD72p9CJGCfUCMyHS
 fU3pBMXJTHlQFw9JTasxKhHzE1Lwxhi4Hfi0EFq1YAtpxk/jthqpQR+nZjgvXKdcmXgS
 K5Qy0dkUgi10KCd+2JaVj1+paecVwEc3FVvl3X/EuOu4wVo94l3jGIB43VD6GI5z9oAS
 9unZLSN5kMoc2Nd1DKjppFq0G7IVoFHWOrZGpOYwfm1vwVujKaSufK0zlRBk9QubHzfz
 817g==
X-Gm-Message-State: AOJu0YztvFVrIT7ioS4eU/o5bcDxQV1cQSuf+rx0Bgp2kDbEgYVd5Pzw
 G3cQ1vtWZVUM/0pEHEQkWhuGzthRaYX70H6tR9r+xHfJ3WZw9T9rO3bPFdavC5eqe8DGPyAVzwc
 =
X-Google-Smtp-Source: AGHT+IEI8i2zxFB9XGjsgrT0ld7AM+ELVoSvx0klCgge3VE4glNDVT/HvHHI78RdkTPg0XwGRzwZBA==
X-Received: by 2002:a05:600c:470f:b0:40e:cdff:8d10 with SMTP id
 v15-20020a05600c470f00b0040ecdff8d10mr708731wmo.6.1706691075522; 
 Wed, 31 Jan 2024 00:51:15 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:15 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 6/9] leon3: remove SP initialization
Date: Wed, 31 Jan 2024 09:50:44 +0100
Message-Id: <20240131085047.18458-7-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

According to the doc (see §4.2.15 in [1]), the reset operation should
not impact %SP.

[1] https://gaisler.com/doc/gr712rc-usermanual.pdf

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/sparc/leon3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 7866f0a049..317eb57336 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -69,7 +69,6 @@
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint32_t  entry;            /* save kernel entry in case of reset */
-    target_ulong sp;            /* initial stack pointer */
 } ResetData;
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
@@ -136,7 +135,6 @@ static void main_cpu_reset(void *opaque)
     cpu->halted = 0;
     env->pc     = s->entry;
     env->npc    = s->entry + 4;
-    env->regbase[6] = s->sp;
 }
 
 static void leon3_cache_control_int(CPUSPARCState *env)
@@ -247,7 +245,6 @@ static void leon3_generic_hw_init(MachineState *machine)
     /* Reset data */
     reset_info        = g_new0(ResetData, 1);
     reset_info->cpu   = cpu;
-    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
-- 
2.25.1



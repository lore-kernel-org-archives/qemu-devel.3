Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0705FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRaz-0005oM-S1; Sun, 18 Oct 2026 10:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRau-0005nX-80
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xIRaq-00050E-Pk
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 10:10:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a06454116eso120174b3a.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792332631; x=1792937431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P6RinCIlj8umNB/ICCbnc+5KtiBXAHX73/C1WUV1Zkg=;
 b=LdoWo1LCMwZoKzLUAV6vEsl2kn+rXq1zjoY0FOI+LyqRswbOQbqlGQmZANW4qE8+lu
 pL6SLGNzN8fvzlUBrgeOeuWjg1YkqyMLHP1GpWACaHDEp2SGVlskrzvLMw89KgeQD+c8
 CwvapPH1C/wmAcFUSJ5HzlmxF0fzHba48jT4HX/4kOmxrlhvEAJAfjuhmQaiCRVcppX4
 UyQH5FYBtjw6VuA7OM4+rR0m90L0XU78/bOkdxh/QDIKSwSgZ6BmiOhE/wQZdK07Ihgn
 3UAzejoBiuU2UkDcPTTpnFNN7kKz/xM/zbxd0f1NyPvkGeYNeDRGXjBWIfY64keX34in
 PaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792332631; x=1792937431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P6RinCIlj8umNB/ICCbnc+5KtiBXAHX73/C1WUV1Zkg=;
 b=um5lICl419dHkk+1SO0fhBZm93KdDGlqu7tyXGruaIZ4bV6hGpIPQIPlaqgwOWbKN1
 zL+Hc5UQhJX8TFIkMLlOPmZD8+dyKR1hv/gVaeM1AtqjSCYv8w1GoxjhvtNVccHNjzAp
 TWHaAhMrZNFoW0pcN16RAumbsf2b3g7gUb1RapBXhmo2cD6TZ5vlD0bZyGfcapju8Jav
 7LsvpubKh99BjOFV/9yye8FjrD+v/saqoUAkbrB/rUTKH5FpxD4k5qUmI3XIBYenC5kC
 7l7PMGLyW7Bj7kUirC8DUsZlZMul3H4VFIh+xgo5/QhJAkc3dW4inoaO0AAZ+a15hlud
 +6Yg==
X-Gm-Message-State: AFq9FYL5JjS88FT9Ai/sebIz4if8uyiz9dxXuFgRjVmHg4WDnkrZ05bw
 IOCqEXiAk37mBvcWskonydrap1YMrq2wK+RtLO7AqQ1GRC39eBPGoVnszbM6o33J
X-Gm-Gg: AYBFou2/woLToKNa5N/stOpmv3NZdhH2fURgV9aXUCycLGdKEXGCRGcXS6dotOTG0XN
 kQWTWHG0imNSA+ptW58b7rlxhm1rXCdLdgA9pPthY+bEFsVL7DgJnAEeBMHW9GvUK3NTGfkkOnM
 Pos5lN8WT1F/fkj65FFNC91kf83ZJb/BoLHdPgonuuA8mrrtWtj8m2Kih5YIdWUfrnvJQja0Nfg
 5Rd9ldjbR5rRT478gTW+VKNPdUMq4rP8aWQoUBrNp3yiQVk3uUdEbqYRjb4jXCyxdMNk0xbop5T
 8qAQCZT7b3Efp0EKeA/t8J6/t/a7GcPKgyy6pFGg2KJIr1swUEbYDmCirzyHpqzxgtB6UoDSsWQ
 wOGPrTweFv0z52ReW31K0jz2ZiwWoJnV9Q9lbIXFmP5Oi8H9NNaba87JFtmdb5IXg8A+rS/TWgj
 sfdSVhC/9bydoX3d3Lda/PluVfRol1dJD4Agl8nUyPUEneOVQbJ/4XAT2c7PJ/qR7VEug4uouEE
 iGn36bXZ33Mrj1r
X-Received: by 2002:a05:6a00:348e:b0:89f:34c3:2031 with SMTP id
 d2e1a72fcca58-8a04cb24760mr3871978b3a.53.1792332631367; 
 Sun, 18 Oct 2026 07:10:31 -0700 (PDT)
Received: from dt-VM.localdomain ([101.204.150.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2949430b3a.32.2026.10.18.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:10:31 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Alistair.Francis@wdc.com,
 Tao Ding <dingtao0430@163.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/5] hw/misc: use hwaddr for the k230_decomp_gzip input
 address
Date: Sun, 18 Oct 2026 22:10:04 +0800
Message-ID: <20261018141006.16398-4-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018141006.16398-1-dingtao0430@163.com>
References: <20261018141006.16398-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pf1-x42d.google.com
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

Use hwaddr for address calculations to avoid 32-bit overflow and
address truncation.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index da4dc6f954..54303c0e7f 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -102,7 +102,7 @@ static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
 }
 
 static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
-                                        uint32_t addr, uint32_t size)
+                                        hwaddr addr, uint32_t size)
 {
     s->input.current_offset = 0;
 
-- 
2.43.0



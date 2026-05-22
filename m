Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C727CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDPT-00041r-CH; Thu, 21 May 2026 20:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO8-0002c6-JO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:18 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDO5-0004Wm-Pz
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2baca4df358so40636665ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408312; x=1780013112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jv05LzEaUCaPr20CESUtrgQ1PrLUWrCj+7ROrvB4U0=;
 b=UwfMsJ3Af6IJ3rSoTjpjq975Jv6UzrtiUhzYYii/9UQeWa4+l34UmPG6Pjy6mM35ek
 geiNIUt8GCl/rAEklD5ARNcnkv8fppKPKLZ8c5+WAWxAorEyiTRGZAW5WfyPFE1ZhlVW
 3xcpHa2ALKGHnGAGbULRXB0GdyU4qT+uq1IfOumsAbLRoMKJb8DnhtM2QIJOjQSWihSW
 WY/ZamHt2Pl8ksMduk5SN59G7veMjKbZG2FgWsnK2d0vER6Z7n8tmMDeWGK7A1nk9c60
 l0aYAOcGZ7FC5cuLYG+qljvK+PSX4OkSbc2mmibckNHGSWyNytd7+M5MAtK9is23mtW+
 b6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408312; x=1780013112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/jv05LzEaUCaPr20CESUtrgQ1PrLUWrCj+7ROrvB4U0=;
 b=hOmdptShA/YzzO58hLMcBuQkmIYqgGC2JoHF01fcfZAqn/QikUfKat/IPGsWFHWVlI
 7fS+UjnUZKHxedJmFnSaoURFnci1B5VB9zEuWoHZ+jWM23gKy9Zwne8dAvEzVqtpMjYu
 eBO5vmNoXzFoufrCYtuWmj+GU7dfnrKc/mwPjzElRrlUu9itBnrqzIeNwgUo0yK6i426
 ramtE7ehIVwZd6PsToL2Gd+0iG3Oe2hb3U7pEoky4au3yYicbqcGp42Xsds0bx/tDLwc
 IE2jN58s+0xr2Qbx0OHwFA4WAl2hsvQGhcJ5tCPFyOXEe0xAlI3Qwd0ea/3YBlSZB0GV
 hNaA==
X-Gm-Message-State: AOJu0YyMoxEsH6qZ2h3Qsa6Yc82qv/TQ2IHDBnGW2+mHnIofml5qC9tg
 ZnV7EL1f0wFvUvXVbgPbCdvyModatmIUF8CEe+asL/aNdVcfjH+KLn0R1q3sQA7v
X-Gm-Gg: Acq92OG3V1JgtAYn5NNVhXHt4+7Q84xnZkB1aLp6ztwHz6YPkQNEBsiGYRvgDwt5QY1
 7WqdU7l4rRDYwGS3iu+T+fmAiteOcJnVNjk/69F8N+c0qDXBONOAgzARl+zXf/VXyV1/Z0J8hKG
 3eIEh+CnAaK6LN/LhwXwCPJIi/k/MM0yL+gQnoWHg2OsdREWEnSiVvQ7cyb6J4ionRAsxThEwwI
 zUowzO6QdcDv+ERM5/QPg9pQ/dj0A7V1dGTPvKpIqsqoP2NuOuJfJzPI2LYSxpEZDaXKJNNxZPX
 tknhRzPKNUB5Fg/ZZNgGMd+s/eFEBiRzHlNk3Xpdz2OdNnf9kny/Kq7rmFuPyOoQVwZAHlmVsAO
 85UvTYHL+yNMQZUyaGBw4xqt4+NORNHpWboFBWJR4FpCQIVHNkGgCKdRBIDtJVAq2Bd2U5aOzfF
 m9Es4Bd+Po1r+TIf+w19C8+O+vk1EYE5p3dCUIJB/ZIbJl4JcMVr4Q59MXGxrWYKQ=
X-Received: by 2002:a17:902:ef10:b0:2b0:5ae9:ee4 with SMTP id
 d9443c01a7336-2beb069c65fmr10828575ad.5.1779408312322; 
 Thu, 21 May 2026 17:05:12 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/48] target/riscv/tcg: use only isa_edata_arr[] in
 cpu_cfg_ext_get_name()
Date: Fri, 22 May 2026 10:03:06 +1000
Message-ID: <20260522000324.23255-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're using both isa_edata_arr[] and riscv_cpu_named_features[] to find
an extension name based on a cfg offset.  This is reminiscent of a past
where isa_edata_arr[] didn't include entries for internal extensions.

At this point we can use just isa_edata_arr[].

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-6-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 92406bf41f..704105d3df 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -311,7 +311,6 @@ static int cpu_cfg_ext_get_min_version(uint32_t ext_offset)
 
 static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
 {
-    const RISCVCPUMultiExtConfig *feat;
     const RISCVIsaExtData *edata;
 
     for (edata = isa_edata_arr; edata->name != NULL; edata++) {
@@ -320,12 +319,6 @@ static const char *cpu_cfg_ext_get_name(uint32_t ext_offset)
         }
     }
 
-    for (feat = riscv_cpu_named_features; feat->name != NULL; feat++) {
-        if (feat->offset == ext_offset) {
-            return feat->name;
-        }
-    }
-
     g_assert_not_reached();
 }
 
-- 
2.53.0



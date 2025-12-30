Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D894EEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxW-00053s-DU; Tue, 30 Dec 2025 16:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxU-000537-Jv
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxT-0002G0-3O
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:48 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so103152855e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128925; x=1767733725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J6K9VfrYM9O58NYLBO+LcXYAGm/XGIvX82MjEg9FdAU=;
 b=uz3CsImxacePYGEQ3lQ+2edmNcwQDxP3cdcpB541ZJ7bM2oYb9l9zdRisR6HOjiTBh
 xVGI9SRHEM+J7NM08GEEWNQBs62phaaidzN/9dP0MMSVVKOBG4qIGcLkPEy8DjfYPm28
 XsvnSnDN2zYQfcyOPXYch3pA6QqwtYSpxrpvMfcKXhZ1mkLQ8LtFOYoMDlsZYoIWrywZ
 mpoqzKWmYd4g9J+vObnr3/JRRThnG4m9v1kL/kBXGWP21zocvehfD4FRmuasNC6RM+nU
 pVF5L7cLAqZk3KK6N5Fdg2MzVBnqlUgXBwscDC+iCXw0ON5PaY1IiviE+qGQjHtmS4Rs
 4Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128925; x=1767733725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J6K9VfrYM9O58NYLBO+LcXYAGm/XGIvX82MjEg9FdAU=;
 b=BZ6bTVlhwqept6y5RRnV8x4AtS9jkrhlh6EpqFG44JzwIdMKH/3b8bFDwb4Ci5MluO
 UURp2yZgz7jLHQwEuSTPHpbyajbxocS2uJoDewMEK4Chw+4mMwuiFWS9znUM1scKsIEb
 Uhw2ifpHPQcIwyv1lNVkgm8XonVJXqdyAy3DFz4jJuReylFM/LcYwyEdeY5bWiTefaqQ
 qjqVzcdp6+Z4TzFB+ZzX6JK1AnPVaicCybLsiuJHFBkdhtVndkAJsgaEjjYe7jGoh5Kn
 oCfmUUp//jQIw7q3KdmGqJEmWv0AMd4RbCCaQ+g016jpE0X1LA+b32FwU8urqnv6XcSN
 CeoQ==
X-Gm-Message-State: AOJu0YyX7GpDHXotIl8ONJLzNTvbSf5QSagZYIkFI1aaKStsMuqBrCT9
 YZyrsrDhGcLfnkZ5P1hXeKhnZ+omJCKpNA2zWIf0tApNRKm2SbkvlDM4KY5uldQR7WKvTUdUhYC
 bbgrnbFo=
X-Gm-Gg: AY/fxX5EJHBNZTUs/bSgYsRKBO4pNX/HuXCMIBuqP1NGlaMkOFWsHDR9MlqVS5MsBGK
 AUeCZh0NApj7aOocRRxaK3jsUf2uMoKk13efQS/zv0sKkN936qTjCFhZYzMRFRQT4A6y+d9VfjU
 OyW2pNZUuOOHuO3MmvNiYS01g/T1ix9UDTN5+2Xj5IUz9nHzCY6+DWrCdtRqahH91VbGQvK3sVj
 DKy84LjU6DXwReBbxEOVuJ4yGxsz50aQamEbd9ML1qGafGkswnPyVO0Dud/E4nX3Csk5QaDcwW6
 tO0pEs3BQ+gODRAD+aMBvDAI7cyvD52PpABm39tUHXXVh14kCc8igMQwrVyNKw132xpEjJkbnpR
 V/GyMMYHYtQMMYiXK7i7nNi4JLRuFoWEo/gOxpjrDIulSIzjayw5EO2Hip3RIVDVqG0q1QbFoaJ
 KMKdbpYQq0BNuSP10sz6h3W+1LTuAj+EIAXC4+E3tlzuto6SFFfkIif8WXfkzK
X-Google-Smtp-Source: AGHT+IHjRJFEPCpmtF1d1fOUz6/NeEeSSDi7ivz4NbqDULRUK52RohkvYyyH+icCxmzz4YWOGdHf1g==
X-Received: by 2002:a05:600c:524f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47d1958b73cmr422165405e9.27.1767128925308; 
 Tue, 30 Dec 2025 13:08:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm609217975e9.7.2025.12.30.13.08.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] monitor/hmp: Use plain uint64_t @addr argument in
 memory_dump()
Date: Tue, 30 Dec 2025 22:07:29 +0100
Message-ID: <20251230210757.13803-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

memory_dump() takes either hwaddr or vaddr type, depending
on the @is_physical argument. Simply use uint64_t type which
is common to both.
Pad address using field width formatting, removing the need
for the target_ulong type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-Id: <20251229231546.50604-4-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 51dcb9e314c..e855c0d8a2c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,12 +122,13 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, bool is_physical)
+                        uint64_t addr, bool is_physical)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -165,11 +166,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 
     while (len > 0) {
-        if (is_physical) {
-            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
-        } else {
-            monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
-        }
+        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
         l = len;
         if (l > line_size)
             l = line_size;
-- 
2.52.0



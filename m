Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B40D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVk-0001F6-Am; Thu, 15 Jan 2026 13:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV9-0000eW-8j
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV6-0005tm-PX
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso7052175e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503319; x=1769108119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+NmbJlgi8h+UOMQxJPifrie0UZoWpa9LUKKFYNienOY=;
 b=RMuCT5jF0oFuwtoYn3oV8FJhm5zxB8jP6JICu8OkfSDyUgBQvISP9phWHpt/9jSrU4
 vq+8AnBciWxQyBf5xuIFxfh+PoECCzUnarufJ/mEtPO1jZlOAtSKlHWsBWnXBixe+GO4
 SZCUg+0IQ+luPSaCOLlCM3TZk1mck3HCYSqlzXOH1944AKTc5ACZcrqN2tr3a69NM8sI
 i6yi4lyN+rtABdJ4a6vecfPbujrjBH2nt5qytm2EpsKlSJl/mcGiPeg+8IRI89uBPWFi
 +hOgicR9tVfBL1lDBX9PfQoz6RWEn9q6MmADcRBInwHIvVfpvbYmkDgyitPfIc5jSasR
 RW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503319; x=1769108119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+NmbJlgi8h+UOMQxJPifrie0UZoWpa9LUKKFYNienOY=;
 b=ery6NIIHtt7RXtA0wBYAji8iXzjMzqhBQ85LfNCeHhr1r6A/FeI9qE+K+H91X9oBI0
 ajYgALj6CNAgCpjlWboGOP+7NYJge6y2kNsncti2/wVRSvRrH8VhbdCGUQ/df8hSFoWo
 lj/WIoZi2VDFkTDOixUM1ZvzzlI3lkWrsE//any1rvnTUJ8BeUH2uJMHiR2UeKXV0kC5
 PGFlXxHccI0gHetXuVO2lgnA5JYYCxWIbDUe6zaotpAMFYPfAYAM7qdBKVpNUBppNqfH
 tnruSq3P38PIz9DM0hrs+FlTVLIDEhxFjcqnmwWBWAC7bervqnT9gzAeVW4CnxwFpTKd
 hVGA==
X-Gm-Message-State: AOJu0Yzn2NaxJE0NUSYAOhH3QbH+9iI+KXbAEWdMNPL9D3F23HtqIJNc
 eqVoNjhhPJYlYHqFf0x2EMB+0AdIQuvIBdO8Yh/VK1NKXZjrFESBkx1WtmNTVxhXXImMkUdIbut
 K0U9j
X-Gm-Gg: AY/fxX4YcXqOQoQiW+j6E/o+544EUGPBTr83jYQUaylDEpn11IuoRWmp69gaudm815U
 CA+zbq0kH5yzjZD6l/mj/svYeMz2RX/4QVFOm9LuehubBARuLA7fYAy43dMoUZPxfOJsO2n2xgS
 GdTPIYB+JguCjMGK1e/kkrvGTc6tiKFavSpVE/FgXv3wI11WCEllnd3CYkVXloc3e7uDp21vDw2
 CKOxZql/AKswV0QhmS1dNgY6tUaDtUBOT2/j6eq0GkjARrCKNxBz0W4pVqNta9Sc6mR5lmU98Z3
 tK3r+x16ohR04N32RJuIjUkLDgtyHlH1GprlJ0TBlP628aC5QEN1MUxWD7ML3OJrmI2wiPT8B++
 4uR3PRZRFKIhY0QIRODyIWRVGYD3yqtNDb07Ot7sASTXPQZnAarV28g4GbWBVwaRvDWvDavW3bX
 zF2Zq2DInBDr6F0rRe45YBsja4TSKoAWDLgukrY+L26bs3n5uWoSi1mZ9JHLeDoeGp94wNH9LaQ
 Ayb4NNvHxC+UeiaAPMmB9a029FbBp/ZWc/u1JXG1C6pNQ==
X-Received: by 2002:a05:600c:1f0d:b0:47e:e970:cf28 with SMTP id
 5b1f17b1804b1-4801eb0e144mr1989965e9.30.1768503318836; 
 Thu, 15 Jan 2026 10:55:18 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/25] hw/sd/omap_mmc: Remove omap_badwidth_* calls
Date: Thu, 15 Jan 2026 18:54:52 +0000
Message-ID: <20260115185508.786428-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of these functions in omap_mmc.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/omap_mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 020429aa4f..d779506131 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -335,7 +335,9 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
     OMAPMMCState *s = opaque;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, offset, size);
+        return 0;
     }
 
     switch (offset) {
@@ -428,7 +430,8 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
     OMAPMMCState *s = opaque;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, offset, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, offset, size);
         return;
     }
 
-- 
2.47.3



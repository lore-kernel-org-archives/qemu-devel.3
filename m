Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3BCD46610
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVg-00019l-WE; Thu, 15 Jan 2026 13:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVE-0000ft-NR
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV8-0005uJ-8I
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:23 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-430f57cd471so755922f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503321; x=1769108121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rzXa0m3nz1cG2gDO1gPqQo6PFYCv0OqwAEN4mWq3o0A=;
 b=vgYk4lTacgAGuyC+YEg5Mij697vbqQ7VQpmktwAxjNm9XhDHz4b+JDq14YDOGn3W0C
 a0/99ealgX6Ayw2OWg/YvjUfp0eJ838Ot4Umxa/9DmdNL4IOWkzrewq5aeZ/oa0bEhri
 R1J196q3a4a230rg3IcDA+S3deA6ZkSgQMiw6Uo739xCj6+Q19OFmUX0g2t2ceSmC3BG
 80vcbtxLy3pebtIorMdznmgxPwUAaUqhiAMNevRnhZMAWxa2TJCRWGe/UiLu2xxWPFFm
 td+bmpYv57wlWTqXffBgigAACEYoMi1pYPLK4FQ3pwzeSuDzL3UmI7TEhhIOQEIQu/aO
 R1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503321; x=1769108121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rzXa0m3nz1cG2gDO1gPqQo6PFYCv0OqwAEN4mWq3o0A=;
 b=gBeINk6NlXUlsQg3plVyuHtHaXZbciHSfkUjBIsd94G6hw1umZvAmAVJqOw3KgFFqs
 UqsiAeWwccpl5tcj2T6LYy2ILo7agRylcmfvRVS+8Ne+5eGLoauTWH1uAKYAAPJtnPPG
 mBzwlVZJCkJjJiAnqIYPNMwaWtR0zUoRIbOgWJqqUYiCpMXgctPwUXlE3JCm9Qj9wkn/
 5xuKGylpmsVwFSnbyz2e9A8Aqnvl++N+gugfkTRrZu6ROqlbMfT+GrVwgnL2IIJTUP2D
 Ta8JZdi3idnNnQYTJX//fXGfH0PY+jzTToJl+8H30GyV0PxBXl28KKoXFtIEtiPA8vOT
 4Sng==
X-Gm-Message-State: AOJu0Yxdfj9F38OhMkfIQZSnSpivAOo+gQl4+L528leQ5AotgQGE8u+g
 60QnkC9W1Ryvcf595O8UzAIRwJoijUP9C27LCuhwzCaTbZLe9nlwuKxr2CZI9xZMiNAbsGBxfia
 r0qMk
X-Gm-Gg: AY/fxX7vfnQlZ+pQZjSj6QuXfzPKfjAVrom0VjP1vzAO8Z/R7Ls5dYwgDLDaJAEQqH9
 vUkxZKwrmr8dTVgL0FgROAtcupuZVpQgnl9ThoMMwpRbm9r9jixpamMT0Fh0I9y0nHstHQtBfJB
 fCIztE37ZKFc3mm6BozkRoovL2y+stga1TjYVIyJypJo0hpnk4COk85Biz/Cgi1AcdRCeGEV8m/
 hvAEDxS2Cj5i2Nd3vPMVL1vsGRQCQgc7OthSb1YY2gsyyhUOc6Q6xFpSiOC/r2bplv5KexjhKlA
 KmK6PgK/2wihSpZcGYIN/QvLMwvXs8ZOO27OifpHdbLg8AXHhM99VqiKmDPMfIvz98LrXyCHtWM
 10uZbEke15bMjh7rMOeiamt6DMDS+uMctdgNMH/yFGSocS2/+W8NCT5+FIpzr3jTEkMLEmGF1L1
 kh4tYZnqicsg4A6lV0wvbkEhNMpyu8VJq62olMgsNnGsFvz26eD7Sxk5qepkwoGhYuOmEYlzEdg
 jGlMsGZwfTitQfIXp7VRNuT0iVEbSwXTXzfcXtlTDUjuw==
X-Received: by 2002:a5d:5886:0:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-4356a05c404mr359020f8f.52.1768503320720; 
 Thu, 15 Jan 2026 10:55:20 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/25] hw/gpio/omap_gpio: Remove omap_badwidth_* calls
Date: Thu, 15 Jan 2026 18:54:54 +0000
Message-ID: <20260115185508.786428-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Replace the uses of these functions in omap_gpio.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/omap_gpio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index f7619260ca..ee3ddb09e3 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -76,7 +76,9 @@ static uint64_t omap_gpio_read(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (offset) {
@@ -116,7 +118,8 @@ static void omap_gpio_write(void *opaque, hwaddr addr,
     int ln;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
-- 
2.47.3



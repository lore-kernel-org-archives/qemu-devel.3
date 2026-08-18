Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C05AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIRx-00049J-Es; Tue, 18 Aug 2026 07:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwIRv-00043N-MK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:57:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwIRt-0005rG-9N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:57:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so41474315e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787054263; x=1787659063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HtFpKUldr5VbLOSZLrmdUubVAcmUBdhzZm38kwp/u44=;
 b=CSOzbxP0DTU7OfMRHFcaSktmkzVnQoXfLDvAbLyW4nRRrzMfQQjZLqvbz4H+FA9tN6
 QbWyFSJ2B0ApG2+LOPqV+wbaecu6d86cGzrjYo4IfpirDSTDffYRBKj6yGHNTzHLceQ5
 CT7BQlTiCSXR9a1TPnlhiUnfn4qCJbhriQKFIxdhCylDPUeUeul+ogDhmm/+mrDvC2ry
 Fgy/p2B4rH9a0OPkHiDw6jLDjrAWfUOQeskKFkPvCnUVmEEYGaRyWocaZtMQPZTrYTto
 sWFOPLuwuu07pVL3geenz5jA4oDa7firZMcTFJnkDbnxSWv74MhYv+4XB2o0hHpB2Y71
 J6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787054263; x=1787659063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtFpKUldr5VbLOSZLrmdUubVAcmUBdhzZm38kwp/u44=;
 b=ROKThgJsx3wUi5V5oFMG9kmtlK9WgwSlg5WM3Qf9P6CrHy9C1ggzKRsQqTYUho9+4z
 vLHWhda039IzxQTVrODr2E7oiGoQnVLppLsaVi/knhs6Qnp9egB6Y91Prn/xhf8OZhkx
 L/SIYmjQAHiGuGd5sLzO5UrW0RngFhB7S0EtD2/Kw/276lBLldDIZLoLSVzVeE98jCZn
 IuRMq3ljF0RQmZEjXKB70vRwtZZCjxcPUf4UOaMZc8f9OCWYLB6dsuufuZIJWD8rBQOk
 qQqEEtfaH/1Jp7b8WDZmwsZdlBfaMtZPRg6dUwSsHxsJ9tlB2jZcYljuF7VflkpsEq4+
 nisQ==
X-Gm-Message-State: AOJu0YxpiEd5LwXoii/qWJFqHq3QuYpBM96Af02h3ZlZlm14gDWNTkPH
 lW3JjTJ8ZTpoupvHznx7Xng+sq49kNgTRE5SZ0e3rVlSNa7w17MOAQdDdWl/HtEJ78P01gynCty
 KuwTg
X-Gm-Gg: AR+sD11ap+3dlaJvDKRbQH17IK9IPYLvKeHBYegq42FQoRN1Mbfarb1WQxQUl2/QSWV
 QmsSRcxLtSPGDzSVSn1i//B4X1SoVA5CDqcjm3sXY1jex2y8JIooluYw/W1HjleN497XKJYaqbz
 o4OWLTM9GzmfpQDyVJg1YXTK5NFOCleijAe8Scl0nz1gWHJajPH7hRUOwrOUCP/IK7xsHJcoATj
 CixApKkaGol/EiPrbQSn4fxomzNc0oza8RxsZF6WGxqGfqpZ5WFSFulrEshQHPUhoKvMgJAoYv9
 FAjUfo/og+8uZE75tA04Sxu2HSt/yR1yXnm56L0ncpFOdeZWXMPv24UV7VuJQO8YCAqPleXHOGn
 WPiJZfpVlqdwSbZf2BoWq6tv6elAPDnA8z4nYduyMlCn3KoyMXRiqCMbFk6ELgl/zIgxFU4iHd2
 FWRNSJjy2W8/vYxvbg8SNj/Vt14Wm878sRO/n+NmJxofdELEHDA3uHmRfZLhbeVYYI+iIXUGoWF
 AjxEl+XZ1xI3nqehvCIyAx56rc7ZdNKfJB9oq+oXVi89sQFWGaxm4cyZZ/MkOK32aA1GIY=
X-Received: by 2002:a05:600c:6b72:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-4998795f96bmr419258005e9.11.1787054263624; 
 Tue, 18 Aug 2026 04:57:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d10be27sm158139925e9.14.2026.08.18.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:57:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH] hw/block/pflash_cfi01: Always set romd mode when clearing
 wcycle and cmd
Date: Tue, 18 Aug 2026 12:57:42 +0100
Message-ID: <20260818115742.2268257-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The pflash_cfi01 code has an invariant that the MemoryRegion is in
ROMD mode if and only if wcycle == 0 && cmd == 0.  We rely on this
for setting ROMD mode on an inbound migration.

There is one corner case where the code clears wcycle and cmd without
also setting ROMD mode on the MR: in the "should never happen" code
path in pflash_read().  As the comment notes, that code really is
unreachable (unless an inbound migration feeds us a bogus pfl->cmd
value), so this isn't a problem in practice.  But it does make the
code a little trickier to analyse.

Pull out a function which does the "clear wcycle and cmd and set mode
to ROMD", and use it in the three places that need to do this.  This
makes it clearer that we are preserving our invariant, and tidies up
the loose end noted in the commit message of 60d010f66f2ad7
("hw/block/pflash_cfi01: Restore ROMD mode after migration").

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index a13b91967e..486fc6350d 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -243,6 +243,18 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl, hwaddr offset)
     return resp;
 }
 
+static void pflash_set_to_read_array_mode(PFlashCFI01 *pfl)
+{
+    /*
+     * Reset the flash device to its "just read the data" mode.
+     * The command 0x00 is not assigned by the CFI open standard,
+     * but QEMU historically uses it for the READ_ARRAY command (0xff).
+     */
+    pfl->wcycle = 0;
+    pfl->cmd = 0x00;
+    memory_region_rom_device_set_romd(&pfl->mem, true);
+}
+
 static uint32_t pflash_data_read(PFlashCFI01 *pfl, hwaddr offset,
                                  int width, int be)
 {
@@ -270,12 +282,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
     default:
         /* This should never happen : reset state & treat it as a read */
         trace_pflash_read_unknown_state(pfl->name, pfl->cmd);
-        pfl->wcycle = 0;
-        /*
-         * The command 0x00 is not assigned by the CFI open standard,
-         * but QEMU historically uses it for the READ_ARRAY command (0xff).
-         */
-        pfl->cmd = 0x00;
+        pflash_set_to_read_array_mode(pfl);
         /* fall through to read code */
     case 0x00: /* This model reset value for READ_ARRAY (not CFI compliant) */
         /* Flash area read */
@@ -652,9 +659,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
 
  mode_read_array:
     trace_pflash_mode_read_array(pfl->name);
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle = 0;
-    pfl->cmd = 0x00; /* This model reset value for READ_ARRAY (not CFI) */
+    pflash_set_to_read_array_mode(pfl);
 }
 
 
@@ -873,13 +878,7 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
     PFlashCFI01 *pfl = PFLASH_CFI01(dev);
 
     trace_pflash_reset(pfl->name);
-    /*
-     * The command 0x00 is not assigned by the CFI open standard,
-     * but QEMU historically uses it for the READ_ARRAY command (0xff).
-     */
-    pfl->cmd = 0x00;
-    pfl->wcycle = 0;
-    memory_region_rom_device_set_romd(&pfl->mem, true);
+    pflash_set_to_read_array_mode(pfl);
     /*
      * The WSM ready timer occurs at most 150ns after system reset.
      * This model deliberately ignores this delay.
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C4DCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUeq-00070Y-JA; Tue, 29 Sep 2026 06:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUep-0006zv-4v
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUem-00089M-Uf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso5412255e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676111; x=1791280911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r9V8//4qhC4ighSdbtWyd4J2CAhgVgHit6AfXHkwuFI=;
 b=EYwDpqGWTeynXl9j3KvyZBFsANyj01a8M0sVFQPS3gllChvOCjUKPCXzCk833m/kCw
 c2F85SXHDfO0HysBEReXdrB3c9kDjO9TkZe6/SMSgEqSsiezj/0Dll2jK649du3Wx+rv
 2wr7b0TurmYOW4giQCfD2AzMVLmhPo9dZBYsdNvuaNKm/sjAr4ZH1RP6y3B20dvCxZMN
 +fBTPj2+2FcBSwTFErt9U3LUcW8VDry/qzkhabJji1eAiAW31gAHlhpmS5x0DJd1Ulx3
 LhJ7Evb+y21v6OvM6zWqa6ha91KYpjRdFDLy5dwROqDo/n5KyyfmVEfqKHWlz6VncXT8
 g/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676111; x=1791280911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r9V8//4qhC4ighSdbtWyd4J2CAhgVgHit6AfXHkwuFI=;
 b=WA+BAhn78lg7Z2lckpia7pcKCzGbR9/a/yAIsPNIhiI5lQwHDYSrkJPTFC7UDGb3U/
 WW3TScmkotzgPs4KK24mTHsx1N0Emw5WbhJgKQGBEbcXfRfxr4tj7w5UVk0g0PwBk9Yy
 AjtjaVjj2G8dp+OeaCyPhlqq7Q8PRV0t0DNhW1OBzcP603irpbbGQtyGdz18LsJ67iqn
 kYRkRHsR0mq4bfS2SBM4fheVHrVg2LHzcxQeU4LKzyOjirU1R6SGEej3XIbYamb5kpp+
 2Y/YECltijws9jpNBxelZ8vj1b6Qc5AgB9gfVxWGlLkZMqwH81enUEpwE0alc1XDXthA
 BhEA==
X-Gm-Message-State: AFuF++lmImTHTkLhlFynen6c8kbmDWigmPg8idEFV64963uborQ9Cyrr
 6LViF3Y5m5qpScaMuaDa/oTdlZ565EZNCBQQxZYsP5U721krtFRGnrkA+N9NRtkx3JH3GABXziR
 h+rh4
X-Gm-Gg: AYBFou0ewMWHqp2Udd8KBQNc1FRWYhpuqFkkx21pagvCCiSir2HF8Xm/H3XPt3VASxV
 XMdRbKpK9p48RLQmp5Ac7PndsIBefTFlX6PHHeIHonvz8aPNOVxNoF0IpgskU33SISGDknuy3K/
 tXODgjJoOuoCT0ixiyI28K3PrOE87ooPpxo4biIHsntleTQaMr4twnc1kiy16IFYiYaNjw4aB/i
 HYO+AED+u1QJZFI73hvLW7MgtTKwy3JPeMyR6QjfoYtZ8aKrqrknhbAcqg8PagFjifo4xytgvX7
 0i6+HrOKsEvs+jpo9Ocf9OyunlqDhHYoo90c2DGifS6HP4U2HXpPBqBRCxUaxrWGx9txlZMYccc
 qotGSGAAJlUwPS16AwEClvoV1L0o6zw9iWGNuwtjOglIgJ7zw/BFJWaO3jWUDT80++vK2t6XUtj
 8S196gNasTf95DMXg3qNy0LwhoY5vkL71Moy9+whQskaJ1+k4I4kyLzv8G9S/XeJ8KqoVKvTHVR
 srhsXF9tFqmBRk/5yhV2VHWRKbXt3c/iq7HWgpsgitfq2EOVcbl5CVJJ4NtKuUujP1R+Wcqjp0S
 4+A=
X-Received: by 2002:a05:600d:864d:10b0:49f:f90e:bf9e with SMTP id
 5b1f17b1804b1-4a00d79a5a5mr25147945e9.9.1790676100076; 
 Tue, 29 Sep 2026 03:01:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/37] hw/char/stm32l4x5_usart.c: Support 16-bit writes
Date: Tue, 29 Sep 2026 11:00:57 +0100
Message-ID: <20260929100133.2598676-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Jacob Whitaker Abrams <jwhitakera@gmail.com>

Official STM32CubeL4 drivers use and require support for 16-bit writes to
UART registers for proper function despite datasheet claims.

As the only 16 bit accesses we need to handle are ones to a
register's base address for registers that have no defined fields in
their top 16 bits, the emulation of 16-bit accesses provided by the
memory system core is good enough, and we can implement this by
updating .valid.min_access_size.

Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
Message-id: 20260926175634.2034094-1-satur9nine@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c          |  7 ++++++-
 tests/qtest/stm32l4x5_usart-test.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 0b02dde1f8c..c4ffc0d6ce5 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -522,7 +522,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        /*
+         * Official STM32CubeL4 drivers use and require support for 16-bit
+         * writes to UART registers for proper function despite datasheet
+         * claims.
+         */
+        .min_access_size = 2,
         .unaligned = false
     },
     .impl = {
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index a72c5a685d1..3c6437e75d4 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -332,6 +332,26 @@ static void test_ack(void)
     qtest_quit(qts);
 }
 
+static void test_16bit_access(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    /* GTPR is declared uint16_t in the official STM driver. */
+    qtest_writew(qts, USART1_BASE_ADDR + A_GTPR, 0xABCD);
+    uint16_t gtpr16 = qtest_readw(qts, USART1_BASE_ADDR + A_GTPR);
+    g_assert_cmpuint(gtpr16, ==, 0xABCD);
+
+    /* TDR is uint16_t and r/w, register is 9-bits */
+    qtest_writew(qts, USART1_BASE_ADDR + A_TDR, 0x01CD);
+    uint16_t tdr16 = qtest_readw(qts, USART1_BASE_ADDR + A_TDR);
+    g_assert_cmpuint(tdr16, ==, 0x01CD);
+
+    /* RDR is uint16_t and read only, register is 9-bits */
+    qtest_writew(qts, USART1_BASE_ADDR + A_RDR, 0x01FA);
+
+    qtest_quit(qts);
+}
+
 static void check_clock(QTestState *qts, const char *path, uint32_t rcc_reg,
                         uint32_t reg_offset)
 {
@@ -370,6 +390,6 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
     qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
+    qtest_add_func("stm32l4x5/usart/16bit_access", test_16bit_access);
     return g_test_run();
 }
-
-- 
2.43.0



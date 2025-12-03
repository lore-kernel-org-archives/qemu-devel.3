Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC03D12694
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjLZ-00028u-9N; Wed, 03 Dec 2025 04:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQjLU-00026w-8k
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:40:24 -0500
Received: from smtp84.cstnet.cn ([159.226.251.84] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQjLQ-0007lQ-BD
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 04:40:24 -0500
Received: from [127.0.0.2] (unknown [114.241.82.59])
 by APP-05 (Coremail) with SMTP id zQCowAAHDW52BTBpsxsSAw--.54292S2;
 Wed, 03 Dec 2025 17:40:07 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 03 Dec 2025 17:38:47 +0800
Subject: [PATCH v2] linux-user: Add missing termios baud rates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-linux-user-higher-baud-rates-v2-1-e45b35224437@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIACYFMGkC/42NQQqDQAxFryJZN6LplNKueo/iYhyjEyhjmahYx
 Ls39QQl8MML/JcNlLOwwr3YIPMiKmMyoFMBIfo0MEpnDFTRpbbAl6R5xdlqGGWItlo/d5j9xIr
 kKPiqbx31ZzDFO3Mv66F/NsZRdBrz5/i21L/rn+KlRhsX3I07clfXPkSD19KHMiRo9n3/AmhLI
 LzKAAAA
X-Change-ID: 20251202-linux-user-higher-baud-rates-242ca0fb42f3
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Luca Bonissi <qemu@bonslack.org>, 
 Andreas Schwab <schwab@linux-m68k.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID: zQCowAAHDW52BTBpsxsSAw--.54292S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJFWxWFWUKF1DCr4xWF43GFg_yoWDCF17pF
 WDJa98Gw4rtFs2yws5tr15Jr17ZF13AF17GrW7ur48X3WYv34rXFyqkrW8t34DXFW8ArWY
 yr1DJ39FkrW7Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
 UU=
X-Originating-IP: [114.241.82.59]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.84;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add several missing baud rates and inputs baud rates in cflag_tbl.

Add these missing definitions in termbits.h:

- TARGET_BOTHER for alpha, hppa, ppc, sh4, sparc
- TARGET_IBSHIFT for hppa, mips, ppc, sh4, sparc
- Missing standard baud rates for hppa

These are required for the glibc test tst-termios-linux.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Changes in v2:
- Use macros to simplify the table
- Also translate CIBAUD flags, fixes remaining glibc tst-termios-linux
  tests (Andreas)
- Link to v1: https://lore.kernel.org/qemu-devel/20251202-linux-user-higher-baud-rates-v1-1-14c49ed2474b@iscas.ac.cn
---

checkpatch.pl complains about tabs, which I have used for consistency
with existing code. I'm not sure how to handle this.

The test tst-termios-linux requires termios2, which is provided by [1].
After that the test failure reported in [2] should be resolved by this
patch.

[1]: https://lore.kernel.org/r/745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org/
[2]: https://lore.kernel.org/r/87cy606842.fsf@igel.home/
---
 linux-user/alpha/termbits.h   |  1 +
 linux-user/generic/termbits.h |  2 +-
 linux-user/hppa/termbits.h    | 16 ++++++++-
 linux-user/mips/termbits.h    |  4 ++-
 linux-user/ppc/termbits.h     |  1 +
 linux-user/sh4/termbits.h     |  5 ++-
 linux-user/sparc/termbits.h   |  5 ++-
 linux-user/syscall.c          | 83 ++++++++++++++++++++++++++++++++-----------
 8 files changed, 92 insertions(+), 25 deletions(-)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index 4a4b1e96f2..ad5362b89e 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -126,6 +126,7 @@ struct target_termios {
 #define TARGET_B3000000  00034
 #define TARGET_B3500000  00035
 #define TARGET_B4000000  00036
+#define TARGET_BOTHER    00037
 
 #define TARGET_CSIZE	00001400
 #define   TARGET_CS5	00000000
diff --git a/linux-user/generic/termbits.h b/linux-user/generic/termbits.h
index 6675e0d1ab..6cc5995981 100644
--- a/linux-user/generic/termbits.h
+++ b/linux-user/generic/termbits.h
@@ -157,7 +157,7 @@ struct target_ktermios {
 #define  TARGET_B3000000  0010015
 #define  TARGET_B3500000  0010016
 #define  TARGET_B4000000  0010017
-#define TARGET_CIBAUD     002003600000  /* input baud rate (not used) */
+#define TARGET_CIBAUD     002003600000  /* input baud rate */
 #define TARGET_CMSPAR     010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS    020000000000  /* flow control */
 
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 11fd4eed62..368da52be9 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -100,14 +100,28 @@ struct target_termios {
 #define TARGET_HUPCL   0002000
 #define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
+#define  TARGET_BOTHER  0010000
 #define  TARGET_B57600  0010001
 #define  TARGET_B115200 0010002
 #define  TARGET_B230400 0010003
 #define  TARGET_B460800 0010004
-#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define  TARGET_B500000 0010005
+#define  TARGET_B576000 0010006
+#define  TARGET_B921600 0010007
+#define  TARGET_B1000000 0010010
+#define  TARGET_B1152000 0010011
+#define  TARGET_B1500000 0010012
+#define  TARGET_B2000000 0010013
+#define  TARGET_B2500000 0010014
+#define  TARGET_B3000000 0010015
+#define  TARGET_B3500000 0010016
+#define  TARGET_B4000000 0010017
+#define TARGET_CIBAUD    002003600000  /* input baud rate */
 #define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000  /* flow control */
 
+#define TARGET_IBSHIFT   16            /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG    0000001
 #define TARGET_ICANON  0000002
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index e8b4b58d87..66d7346f12 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -116,10 +116,12 @@ struct target_termios {
 #define  TARGET_B3000000 0010015
 #define  TARGET_B3500000 0010016
 #define  TARGET_B4000000 0010017
-#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define TARGET_CIBAUD    002003600000  /* input baud rate */
 #define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000  /* flow control */
 
+#define TARGET_IBSHIFT   16            /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG    0000001
 #define TARGET_ICANON  0000002
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index eb226e0999..71b398c83a 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -129,6 +129,7 @@ struct target_termios {
 #define TARGET_B3000000  00034
 #define TARGET_B3500000  00035
 #define TARGET_B4000000  00036
+#define TARGET_BOTHER    00037
 
 #define TARGET_CSIZE	00001400
 #define   TARGET_CS5	00000000
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 28e79f2c9a..0ff1bff2cf 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -120,6 +120,7 @@ struct target_termios {
 #define TARGET_HUPCL   0002000
 #define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
+#define TARGET_BOTHER 0010000
 #define TARGET_B57600 0010001
 #define TARGET_B115200 0010002
 #define TARGET_B230400 0010003
@@ -135,10 +136,12 @@ struct target_termios {
 #define TARGET_B3000000 0010015
 #define TARGET_B3500000 0010016
 #define TARGET_B4000000 0010017
-#define TARGET_CIBAUD    002003600000 /* input baud rate (not used) */
+#define TARGET_CIBAUD    002003600000 /* input baud rate */
 #define TARGET_CMSPAR    010000000000 /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000 /* flow control */
 
+#define TARGET_IBSHIFT   16           /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG     0000001
 #define TARGET_ICANON   0000002
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 704bee1c42..4c4c7d1a09 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -128,6 +128,7 @@ struct target_termios {
 #define TARGET_HUPCL	  0x00000400
 #define TARGET_CLOCAL	  0x00000800
 #define TARGET_CBAUDEX   0x00001000
+#define  TARGET_BOTHER   0x00001000
 /* We'll never see these speeds with the Zilogs, but for completeness... */
 #define  TARGET_B57600   0x00001001
 #define  TARGET_B115200  0x00001002
@@ -154,10 +155,12 @@ struct target_termios {
 #define B3000000  0x00001011
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
-#define TARGET_CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define TARGET_CIBAUD	  0x100f0000  /* input baud rate */
 #define TARGET_CMSPAR	  0x40000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS	  0x80000000  /* flow control */
 
+#define TARGET_IBSHIFT	  16          /* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define TARGET_ISIG	0x00000001
 #define TARGET_ICANON	0x00000002
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..00b668f5b9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5758,27 +5758,70 @@ static const bitmask_transtbl oflag_tbl[] = {
 	{ TARGET_FFDLY, TARGET_FF1, FFDLY, FF1 },
 };
 
+#if defined(TARGET_CIBAUD) && defined(CIBAUD)
+
+# define BAUD_TRANSTBL(baud) \
+    { TARGET_CBAUD, TARGET_##baud, CBAUD, baud }, \
+    { TARGET_CIBAUD, TARGET_##baud << TARGET_IBSHIFT, CIBAUD, baud << IBSHIFT },
+
+#else
+
+/* Alpha in particular does not have CIBAUD/IBSHIFT */
+
+# define BAUD_TRANSTBL(baud) \
+    { TARGET_CBAUD, TARGET_##baud, CBAUD, baud },
+
+#endif
+
 static const bitmask_transtbl cflag_tbl[] = {
-	{ TARGET_CBAUD, TARGET_B0, CBAUD, B0 },
-	{ TARGET_CBAUD, TARGET_B50, CBAUD, B50 },
-	{ TARGET_CBAUD, TARGET_B75, CBAUD, B75 },
-	{ TARGET_CBAUD, TARGET_B110, CBAUD, B110 },
-	{ TARGET_CBAUD, TARGET_B134, CBAUD, B134 },
-	{ TARGET_CBAUD, TARGET_B150, CBAUD, B150 },
-	{ TARGET_CBAUD, TARGET_B200, CBAUD, B200 },
-	{ TARGET_CBAUD, TARGET_B300, CBAUD, B300 },
-	{ TARGET_CBAUD, TARGET_B600, CBAUD, B600 },
-	{ TARGET_CBAUD, TARGET_B1200, CBAUD, B1200 },
-	{ TARGET_CBAUD, TARGET_B1800, CBAUD, B1800 },
-	{ TARGET_CBAUD, TARGET_B2400, CBAUD, B2400 },
-	{ TARGET_CBAUD, TARGET_B4800, CBAUD, B4800 },
-	{ TARGET_CBAUD, TARGET_B9600, CBAUD, B9600 },
-	{ TARGET_CBAUD, TARGET_B19200, CBAUD, B19200 },
-	{ TARGET_CBAUD, TARGET_B38400, CBAUD, B38400 },
-	{ TARGET_CBAUD, TARGET_B57600, CBAUD, B57600 },
-	{ TARGET_CBAUD, TARGET_B115200, CBAUD, B115200 },
-	{ TARGET_CBAUD, TARGET_B230400, CBAUD, B230400 },
-	{ TARGET_CBAUD, TARGET_B460800, CBAUD, B460800 },
+	BAUD_TRANSTBL(B0)
+	BAUD_TRANSTBL(B50)
+	BAUD_TRANSTBL(B75)
+	BAUD_TRANSTBL(B110)
+	BAUD_TRANSTBL(B134)
+	BAUD_TRANSTBL(B150)
+	BAUD_TRANSTBL(B200)
+	BAUD_TRANSTBL(B300)
+	BAUD_TRANSTBL(B600)
+	BAUD_TRANSTBL(B1200)
+	BAUD_TRANSTBL(B1800)
+	BAUD_TRANSTBL(B2400)
+	BAUD_TRANSTBL(B4800)
+	BAUD_TRANSTBL(B9600)
+	BAUD_TRANSTBL(B19200)
+	BAUD_TRANSTBL(B38400)
+	BAUD_TRANSTBL(B57600)
+	BAUD_TRANSTBL(B115200)
+	BAUD_TRANSTBL(B230400)
+	BAUD_TRANSTBL(B460800)
+	BAUD_TRANSTBL(B500000)
+	BAUD_TRANSTBL(B576000)
+	BAUD_TRANSTBL(B921600)
+	BAUD_TRANSTBL(B1000000)
+	BAUD_TRANSTBL(B1152000)
+	BAUD_TRANSTBL(B1500000)
+	BAUD_TRANSTBL(B2000000)
+
+	BAUD_TRANSTBL(BOTHER)
+
+	/* SPARC in particular is missing these higher baud rates */
+
+#if defined(TARGET_B2500000) && defined(B2500000)
+	BAUD_TRANSTBL(B2500000)
+#endif
+
+#if defined(TARGET_B3000000) && defined(B3000000)
+	BAUD_TRANSTBL(B3000000)
+#endif
+
+#if defined(TARGET_B3500000) && defined(B3500000)
+	BAUD_TRANSTBL(B3500000)
+#endif
+
+#if defined(TARGET_B4000000) && defined(B4000000)
+	BAUD_TRANSTBL(B4000000)
+#endif
+
 	{ TARGET_CSIZE, TARGET_CS5, CSIZE, CS5 },
 	{ TARGET_CSIZE, TARGET_CS6, CSIZE, CS6 },
 	{ TARGET_CSIZE, TARGET_CS7, CSIZE, CS7 },

---
base-commit: e5eb98b3cae77ffe7d142229a8225cedd8b78f07
change-id: 20251202-linux-user-higher-baud-rates-242ca0fb42f3

Best regards,
-- 
Vivian "dramforever" Wang



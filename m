Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C98DCFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 05:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQJDG-0007hX-V8; Tue, 02 Dec 2025 00:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQIjS-00086M-MF
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:15:22 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1vQIjP-0006nC-8Q
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 00:15:22 -0500
Received: from [127.0.0.2] (unknown [114.241.82.59])
 by APP-03 (Coremail) with SMTP id rQCowADXKt3YdS5plN7jAg--.33793S2;
 Tue, 02 Dec 2025 13:15:04 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 02 Dec 2025 13:14:36 +0800
Subject: [PATCH] linux-user: Add missing termios baud rates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-linux-user-higher-baud-rates-v1-1-14c49ed2474b@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIALt1LmkC/x2MQQqAMAwEvyI5G9CoF78iHqqmbUCqtFYE6d8NX
 naZw8wLiaNwgrF6IfItSY6g0NYVrN4ExyibMlBDQ6uDu4T8YFYNvTivt5i8YTQXJ6SeVtPYpSf
 bgSbOyFaePz/NpXwqIFpRbgAAAA==
X-Change-ID: 20251202-linux-user-higher-baud-rates-242ca0fb42f3
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Luca Bonissi <qemu@bonslack.org>, 
 Andreas Schwab <schwab@linux-m68k.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-CM-TRANSID: rQCowADXKt3YdS5plN7jAg--.33793S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw4ktFyDAw4kuFWxZrW3Awb_yoW7uF4UpF
 WDJ345Gr4rtr4akan3tr15XF17ZF1fAF1UGrW29r48Xa4Yvw48XFyqkrWjg34DXFW8ArWY
 vrn8Jw429rWUu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
 UU=
X-Originating-IP: [114.241.82.59]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 02 Dec 2025 00:46:08 -0500
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

Add missing definitions for TARGET_BOTHER for alpha, hppa, ppc, sh4,
sparc, and also missing standard baud rates for hppa.

Also add the missing baud rates in cflag_tbl.

In particular, BOTHER is required for the glibc test tst-termios-linux.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
checkpatch.pl complains about tabs in linux-user/syscall.c, which I have
used for consistency with existing code. I'm not sure how to handle
this.

The test tst-termios-linux requires termios2, which is provided by [1].
After that the test failure reported in [2] should be resolved by this
patch.

[1]: https://lore.kernel.org/r/745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org/
[2]: https://lore.kernel.org/r/87cy606842.fsf@igel.home/
---
 linux-user/alpha/termbits.h |  1 +
 linux-user/hppa/termbits.h  | 12 ++++++++++++
 linux-user/ppc/termbits.h   |  1 +
 linux-user/sh4/termbits.h   |  1 +
 linux-user/sparc/termbits.h |  1 +
 linux-user/syscall.c        | 27 +++++++++++++++++++++++++++
 6 files changed, 43 insertions(+)

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
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 11fd4eed62..f55748534f 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -100,10 +100,22 @@ struct target_termios {
 #define TARGET_HUPCL   0002000
 #define TARGET_CLOCAL  0004000
 #define TARGET_CBAUDEX 0010000
+#define  TARGET_BOTHER  0010000
 #define  TARGET_B57600  0010001
 #define  TARGET_B115200 0010002
 #define  TARGET_B230400 0010003
 #define  TARGET_B460800 0010004
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
 #define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
 #define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
 #define TARGET_CRTSCTS   020000000000  /* flow control */
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
index 28e79f2c9a..1f7c76e839 100644
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
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 704bee1c42..c2082ebd27 100644
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..9cceb22348 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5779,6 +5779,33 @@ static const bitmask_transtbl cflag_tbl[] = {
 	{ TARGET_CBAUD, TARGET_B115200, CBAUD, B115200 },
 	{ TARGET_CBAUD, TARGET_B230400, CBAUD, B230400 },
 	{ TARGET_CBAUD, TARGET_B460800, CBAUD, B460800 },
+	{ TARGET_CBAUD, TARGET_B500000, CBAUD, B500000 },
+	{ TARGET_CBAUD, TARGET_B576000, CBAUD, B576000 },
+	{ TARGET_CBAUD, TARGET_B921600, CBAUD, B921600 },
+	{ TARGET_CBAUD, TARGET_B1000000, CBAUD, B1000000 },
+	{ TARGET_CBAUD, TARGET_B1152000, CBAUD, B1152000 },
+	{ TARGET_CBAUD, TARGET_B1500000, CBAUD, B1500000 },
+	{ TARGET_CBAUD, TARGET_B2000000, CBAUD, B2000000 },
+
+	/* SPARC in particular is missing these higher baud rates */
+
+#if defined(TARGET_B2500000) && defined(B2500000)
+	{ TARGET_CBAUD, TARGET_B2500000, CBAUD, B2500000 },
+#endif
+
+#if defined(TARGET_B3000000) && defined(B3000000)
+	{ TARGET_CBAUD, TARGET_B3000000, CBAUD, B3000000 },
+#endif
+
+#if defined(TARGET_B3500000) && defined(B3500000)
+	{ TARGET_CBAUD, TARGET_B3500000, CBAUD, B3500000 },
+#endif
+
+#if defined(TARGET_B4000000) && defined(B4000000)
+	{ TARGET_CBAUD, TARGET_B4000000, CBAUD, B4000000 },
+#endif
+
+	{ TARGET_CBAUD, TARGET_BOTHER, CBAUD, BOTHER },
 	{ TARGET_CSIZE, TARGET_CS5, CSIZE, CS5 },
 	{ TARGET_CSIZE, TARGET_CS6, CSIZE, CS6 },
 	{ TARGET_CSIZE, TARGET_CS7, CSIZE, CS7 },

---
base-commit: e5eb98b3cae77ffe7d142229a8225cedd8b78f07
change-id: 20251202-linux-user-higher-baud-rates-242ca0fb42f3

Best regards,
-- 
Vivian "dramforever" Wang



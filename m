Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB79606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=h3x7H9ul
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKMTx-0001n8-RL; Fri, 23 Oct 2026 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTc-0001kO-4I
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:07:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xKMTZ-0003PX-OP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 17:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kTqtS/TIK+y6s2Vdtyn9TQoxfybJvSsurg97MgHXdIA=; b=h3x7H9ulkgmmC4LFihlqAQ3bn6
 S8EEfqMs0RikNxXsZrEotLCdqRAjSDRnbDW4pL75ppWaTZ5E0iSlMUIN3/F+ZSY6IIqQXmqk8wFee
 jEScGRRwdxeIsMVTVs8JQcjGHlcGXTvjbnXuak2BpWec+iBvAMFq4c7Yjt2emTJ8Y3Xno7/k75TD9
 hl0nZwyK8G7apy3fKnvGxD+8VlRYn+fRVGltM9AlsbETtJ03UbGzf/guLnZAAEZ368fbbd+hPBUQz
 KNVGK3cApM9WyNOAzvXFGPgo5BsvQW99lFcvL2MtZlot6U++oUKtxOwD9EPLCeVxDKXAmv31BgfQQ
 m4Llrq+OuH9ddiw90q2mvlzYj3IKAASPSqo4MyWCP6O9VHRsJK4Ea/mUdUdhKc0fF8bw7bgXhm2lL
 IF91H3Eqa0R5vRYGLT4uVuyNiirDetqd809LzC9rOHfnfGWZ1i+JcgKYZIG9kB8l9dHKXGEEdK/5g
 pfzh7sSC0eWchTgwtzCHqFl0fVpCIC2Xsr2TUyJTJy0uhq6LnTDCb/ahQCTYnrFKlMRwKIRrlxIlL
 pByuqhzz+IJZv6uqvr10g8h2Hge7cylQdFyrrKkJl8vbM8VMzUv4UsJsiQpC2XPHfR9hqHeGQ4Pxg
 9Wy8VFNsEWBE9u1QETqUwnpKLuzO7OKujYu1IeDbk=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xKMSq-003QXg-3n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:06:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Fri, 23 Oct 2026 22:06:32 +0100
Message-ID: <20261023210650.559141-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
References: <20261023210650.559141-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 2/6] target/sparc: Return CFR when crypto feature is enabled
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

ASR 26 returns a Compatibility Feature Register (CFR) when the
crypto feature is on. Without the crypto feature, a read keeps
strand status as before.

Return an empty CFR. Each instruction patch sets its bit.
Guests can read the CFR before using each crypto instruction.

Based on OSA (Oracle SPARC Architecture) 2011:
- 5.5 (Ancillary State Registers), table 5-8
- 5.5.11 Compatibility Feature Register (CFR), table 5-15

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261022070059.3861291-3-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/insns.decode |  5 ++++-
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 242ec420161..55f8528ffe5 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -106,7 +106,10 @@ CALL    01 i:s30
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
     RDSTICK         10 rd:5  101000 11000 0 0000000000000
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
-    RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
+    {
+      RDCFR           10 rd:5  101000 11010 0 0000000000000
+      RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
+    }
   ]
 
   # The v8 manual, section B.30 STBAR instruction, says
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b93feb074b2..a1562f50474 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3022,6 +3022,20 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
 
 TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
 
+/* CFR bits (OSA 2011, 5.5.11) */
+#define CFR_AES         (1 << 0)
+#define CFR_SHA1        (1 << 5)
+#define CFR_SHA256      (1 << 6)
+#define CFR_SHA512      (1 << 7)
+#define CFR_CRC32C      (1 << 11)
+
+static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(0);
+}
+
+TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
+
 static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdpsr(dst, tcg_env);
-- 
2.47.3



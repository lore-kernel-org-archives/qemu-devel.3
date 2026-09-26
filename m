Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F8AC98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xARuB-0000TL-Fg; Sat, 26 Sep 2026 08:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAY-0002e0-B7
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:18 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@alexrp.com>) id 1xARAV-0001Tl-5l
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:06:17 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 47983EC010D;
 Sat, 26 Sep 2026 08:06:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Sat, 26 Sep 2026 08:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alexrp.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790424373;
 x=1790510773; bh=uksdB2cmP9Dr1MLeMyooEA5XUjqlSJdz1cnk5dznnGs=; b=
 riJ0PSGcg1agJW0qus80FF1DQVGCeuoxNlEs0wwV1ihJpjPoOUwSBwlJ9fXIxZWP
 Rew5Jhyl9rwBIVjhUJMjkEvk3ckOiS41Cjcze5Vtbx4nS6dBToePeOzQu7IppL68
 erNJ3NLNtXPnOtVZTnJXBBADJtgocLdqstkfOzem99jn7F4eOJ31Dw3TXZ5hW8nw
 nV2JWVlZ9Y4fqwcW26J6Ff3JsD+ktH6/omQ2Dw26qc7hvZSFB3h/qwi7XS9o1+Dm
 poeCTQ4RUNnhYzOV6YndKmVxmoj6f8SfLlthgfCsA43vD5aPTW3IRw8t1Bh9//z0
 ryoSX3y51k4oLP6K+m4iKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790424373; x=
 1790510773; bh=uksdB2cmP9Dr1MLeMyooEA5XUjqlSJdz1cnk5dznnGs=; b=S
 YRyMSIjvZk3VEE5EKrILXZtseZMmW6rjmP6BZ4cbdRebF6jD3YTIp3aX+EYnwb2N
 2LPjHs+ly8yziruFvkES7HaRD2cEUR97iJbQkhxrOME+MogaSYaDQMQfGICcFm0x
 /rDi/y6MC/3kDATXm6qt31hI0yjVqvV5D1KrNewix551R0cnbQNHkmQgO0EIStMG
 ebN4dRjggRnPAUcP/XGdJrwM8sBe7MxWeXRcekqqGUpGvG+7a8yu49OTjfkD5W9Z
 p14F8pUje5Xz2y7Bs1o8zgGS6aFWEGopdskJn4ei4FnEKr914K2RRSWcJgPNe8Cs
 xhYBKeMzEEiEBhWC1cuMQ==
X-ME-Sender: <xms:NLW3asRcraYJRYrUDAp89lCdjdzPVJDZzk8F53iovNVx1apR-tWDIg>
 <xme:NLW3aivx1DlakBliI62zezhSAf_UHYAgmX2_iPnhqCChr5vweomRMfiCKa3Cd-eT5
 7-8ICXE8HtJXAtdTLr9CKlgRZPyboahRCJSr47Qrq9GrfICWeEn_5s>
X-ME-Received: <xmr:NLW3alaZNOShcgjQ3B9LFM5-m2HoIJvMuH2attVyOO7YcRKovHu9FqHqR7IgGbarbJw>
X-ME-Proxy-Cause: dmFkZTF2ZBu3kHgctuGIag8ru0kgwOvO0wWQrJd8XN8ykdeD5P7X0mI2Y/YfA//KKpasNu
 Mlcc3Ou+d+p7YNGqnMdvQmMg90ieCRbh+9/yX2IEiBARzO/C1xz0ps6XXzpGrObI8ItPo0
 kgRrThuhy+vHUewNZ/xwUiAeXC0T1zai2uNyY1ZwYyR3BGBKzDK6zzPTVfSUz76PJC9rti
 AzAe6lDyoOycg+y3Bh9lfdrshgkf20467bw+YG9HZ62K2B9j3sOOkmQSxdtO12CfzTLu0s
 PS/2UzH3SDwUSih+irnKwJKFdOuUsS0KAVLhekVF0a1lyvC2y8wCMCjoMxk+18gqYW65tt
 HmkktR3FlMSNILvT0Nu933jHeS+NAJ3KJiE6VPWdEBPbqSvCDC6N4Fyd2lneVFunwvTuhS
 FdtPZieUuD7vmACHubjM5MmU6xqARPqeFA/aDbKaX6IcG7E+31DUyg8Hdi95+inFLXAvrK
 KMiYHyjdD/WfDmQ9ZQJ44ifLxZOPBETsjQRV7HwH9PDfE8QPPJBfgNrZ3fu0WExAkCT+cT
 QNTOFVfXsUuiS8N2RN3SsrwdSYIRit8GrqFg2hEmo4LGmysc1IYuwea2fX/KwLeFDYVyLu
 zdWjGYBrBRv5qA3iNMcntiZTuIC0UoJbzP8xaU4Z5u8eXO3fQRDWG492SXxQ
X-ME-Proxy: <xmx:NLW3agHP4VIATq9sHbKD_BUTno5-FNMV7nn9MaXphm0EOoEmFHUE2A>
 <xmx:NLW3ahxkzyWCC1Zh8dQH0B0ZWfo0lT8eWoYJXppz_LCCHIVwcmXSfw>
 <xmx:NLW3aqk3_OJsOKAZ3mT_I9gztIc_janOHPEBcKxLaR0nJPkBBQ4tcw>
 <xmx:NLW3ailYp4N1RdQWGlUKXz67XDhTcxjgGzZM8NTSpV7x6dvv75GJkA>
 <xmx:NbW3agpbZkcgJrRwU2N2SKgHfPwOk6FKQju5ooDtlyQEp5dA0iZxzVVs>
Feedback-ID: i799648cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 08:06:11 -0400 (EDT)
From: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20R=C3=B8nne=20Petersen?= <alex@alexrp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v1 1/2] target/mips: fix Loongson-3A4000 definition to have
 abs2008 and nan2008
Date: Sat, 26 Sep 2026 14:05:33 +0200
Message-ID: <20260926120534.240391-2-alex@alexrp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926120534.240391-1-alex@alexrp.com>
References: <20260926120534.240391-1-alex@alexrp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=alex@alexrp.com;
 helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:53:24 -0400
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

Checked on a Loongson 3B4000; this uarch operates in 2008 mode.

Signed-off-by: Alex Rønne Petersen <alex@alexrp.com>
---
 target/mips/cpu-defs.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index cc1916232f..b2ddfa1e82 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -941,8 +941,8 @@ const mips_def_t mips_defs[] =
                     (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
         .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
                     (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
-                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
-        .CP1_fcr31 = 0,
+                    (0x1 << FCR0_D) | (0x1 << FCR0_S) | (0x1 << FCR0_HAS2008),
+        .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
         .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
         .MSAIR = (0x01 << MSAIR_ProcID) | (0x40 << MSAIR_Rev),
         .lcsr_cpucfg1 = (1 << CPUCFG1_FP) | (2 << CPUCFG1_FPREV) |
-- 
2.53.0



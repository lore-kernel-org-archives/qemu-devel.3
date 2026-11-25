Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B15606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E/cYKnaT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCEr-0002G9-Av; Wed, 25 Nov 2026 07:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <puranikyashaswinsharma@gmail.com>)
 id 1xW4zU-0007tH-90
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:52:20 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <puranikyashaswinsharma@gmail.com>)
 id 1xW4zR-0000u8-QE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:52:19 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-386cf1041cdso720059eec.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795582334; x=1796187134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wBibNuURDZzKnCHhzcHs4gii93tNDIQd+c/psrK1+XM=;
 b=E/cYKnaTearnQ6DVp8gUZaq5i2kd+kOyr2lHONulsqpzT6PFmcoqBFbRGZKxw0kQOl
 u+0Y4Hwh6mMoI6cAidYW1aR+2NBOOVTIJZijdeW2Gyxi1FXwDcjv2skxaN2vW/DKqnVv
 U1wOKBd2A0lg7kA9DYj5Dx3p8vl+L24sPqEL9mbFGgv2wyfnuTZ4EvLjlRudNH+NV7EO
 j/mnKI7kDJJ89JdhW1sf14IVyOcbEi3+PWa0UH2FsIR2yPyOFLWsxrhOttbl02Hsr2vi
 0u6YYVTh3cel13Eie1zXk8Lgzs50RqdosPQdMBxiSYQ74cwL1LesMiUVNIKLvwaDhoVk
 2ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795582334; x=1796187134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wBibNuURDZzKnCHhzcHs4gii93tNDIQd+c/psrK1+XM=;
 b=tEFhTOedrM+DXPkR3v7BTjhosWDITHSusIl2OOXsxcWgTsReizhAQ/DZZkIZgSlxiM
 c94HtH/uCi6EUL5cRC5y+hlQ0ZjIXIJUwzsnE/0DolEpboQ3/9pe25VHhmaxjwFnyOXP
 wdHZL8EeWO4PUcHrPiDkxCZpkzEnEwftcGKP2WxyxAZoA61ENj0k2QhOE2fsMKFpUIC0
 nUVXRTKVJPAYU9klPnvFJ03KjFoyELvhCACFcDR9NSXyUP6lioKbaa/IlhAXEIXkCunJ
 mDM0hEB9Sh7T+mx7o2nlY2OPVn6H7P/xwSfWRIA7VHiNtgG3q/QWkwPEbKFYjnmHyVbP
 1xlw==
X-Gm-Message-State: APuU4Z/0jrdfQRDV2UqrU6xPBQqeE5fOJ//O0J3fTIv13C4EYXIgGMPX
 2dvAArIibJ7fKiOH+FALygxD2J12ZwAjeQQNInBpRwlVnx/Tuelo+wv1vW7nA4fhrnI=
X-Gm-Gg: AZFdTZd4/fkH2Uyetz3W4GGn2nsiHEEQNfWSFqpo5EyWSKo2cZuxm5NGQdbt7Z7o+CI
 dsdeGaBwKqnTDtc+J/nXpfpOOw+UeHd3ledpoj7k5D8ESCnuFELdot8PawtcxADPEHnw9jzar1w
 cMVGVWPB666oRDNEd0fCWpUFpkB1t1kHtUCGztxoMEdoPMbC5NuXWOxm1mKs7NATe2R3wvtGXep
 3oNq0r1O96enIYgDjV7iJTPtfS6L5nSbi/es5h1fZ/BS/A0NqKH22jDZf5qcQMdIlZZw1bE6vKg
 qatt6jCajr2hRJbmg+GTXzLr6bPWruW8/gFYlhakQnTLJZO9LiqOGM5S0cRto3TmImQ0CD8gtxD
 aCQpwLtrtiuyAMNV2mnocaA56kVjWsQGMgF9lsWAZqBSF4FLrf/fSXKrnnjZKlOe/b8V56r1NkY
 fRq2jLWw0iieLB8FaqcWMGWvzh3g+/xsEvDA+FxDETU4WgF6srck74WHhDkb/MrC3l96TPvy+ut
 bsDVvnbGx1l+2mRduLERV17BaZGRBsi+dRCZkcVs8XXoCuIuWCSGC1ype8NTqQwz/6KTgwl38lf
 hTnmUac1vapDqNFJ4dAvOiOVxsioe+bucu8eweRmj0bkiY0CjSO+SVEs9SbcXFV1nvaVYeomO0s
 cPwyVDC8Xwcx5FxSGfamt2fruNnbHPwaua5uyUCHMsUQ/zG0TJ/2R6H63ICJAd3baxJqPqj5hCG
 guYmE3QU1HTmrGB9lQL6sAFg==
X-Received: by 2002:a05:693c:4001:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-38570b34fecmr18417096eec.41.1795582333662; 
 Tue, 24 Nov 2026 20:52:13 -0800 (PST)
Received: from localhost.localdomain
 ([2409:40f0:1008:9b8a:1165:b071:8149:d5ec])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385646633d0sm88023194eec.3.2026.11.24.20.52.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 20:52:13 -0800 (PST)
From: Yashaswin Sharma Puranik <puranikyashaswinsharma@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Jiri Novak <jnovak@fel.cvut.cz>,
 Jan Charvat <jancharvat.charvat@gmail.com>,
 Michal Lenc <michallenc7@gmail.com>, Ondrej Ille <ondrej.ille@gmail.com>
Subject: [PATCH] hw/net/can/ctucan: send a Ready TXT buffer that has priority 0
Date: Wed, 25 Nov 2026 10:22:05 +0530
Message-ID: <20261125045205.37999-1-puranikyashaswinsharma@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=puranikyashaswinsharma@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 07:36:30 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ctucan_send_ready_buffers() starts each round with tx_prio_max = 0 and
takes a Ready buffer only when its priority is higher. A Ready buffer
with priority 0 is never picked. It stays Ready and the frame is never
sent.

The CTU CAN FD datasheet (v2.7.0, section 2.9) has no such rule. The
Ready buffer with the highest priority is sent, and of two buffers with
equal priority the one with the lower index goes first. TX_PRIORITY
resets to 0 for every buffer but the first. Linux does not hit this
with four buffers, because it rotates the priorities 7 down to 4.

Start each round below every valid priority. tx_prio_max becomes an int
that starts at -1. prio becomes an int as well: with a uint32_t prio the
comparison converts -1 to unsigned, the test is never true and no
buffer is sent at any priority.

Fixes: aa406e8b7ecd ("hw/net/can: CTU CAN FD IP open hardware core emulation.")
Suggested-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Yashaswin Sharma Puranik <puranikyashaswinsharma@gmail.com>
---
Tested with the same three lines on v6.2.0, where this function is the
same as on master. Guest: QNX 8.0 on ctucan_pci, connected to a host
vcan. A small program writes the registers directly, with no driver
loaded.

  one buffer Ready, priority 0:    before: stays Ready, no frame
                                   after:  TX OK, frame on the bus
  four buffers Ready, priority 0:  before: none sent
                                   after:  all sent, lowest index first
  one buffer Ready, priority 3:    sent before and after

With only tx_prio_max changed to int and prio left as uint32_t, no
buffer is sent in any of these cases. The test suite of our QNX driver
(43 tests) passes before and after.

The change also builds on master (2bfbe39d0fff). The guest test above
ran on v6.2.0.

 hw/net/can/ctucan_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index f6ff4ad..8c62b3e 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -240,7 +240,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
     qemu_can_frame frame;
     uint8_t *pf;
     int buff2tx_idx;
-    uint32_t tx_prio_max;
+    int tx_prio_max;
 
     if (!s->mode_settings.s.ena) {
         return;
@@ -250,10 +250,10 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
         union ctu_can_fd_int_stat int_stat;
         int i;
         buff2tx_idx = -1;
-        tx_prio_max = 0;
+        tx_prio_max = -1;
 
         for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
-            uint32_t prio;
+            int prio;
 
             if (extract32(s->tx_status.u32, i * 4, 4) != TXT_RDY) {
                 continue;
-- 
2.54.0 (Apple Git-157)



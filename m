Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F2606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztFzdJxt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSnTV-0007fX-4q; Sun, 15 Nov 2026 22:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xSmij-0005S2-L2
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:45:26 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xSmih-0004Xe-R3
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:45:25 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8253bc5a613so2365668a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 18:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794797121; x=1795401921; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jvKAweWSF1WL2MIE6+mbKhodNmuJdfWHL+r3/lgJz4M=;
 b=ztFzdJxtD3VIZhu25ZUEtDrwyMvf5YF6GNw1/vCP2NdI0fuvASJUFn380EiLM3K7OC
 jd6CkoQrXvSslvaoI9d9j1DTVyrcaJ2cJFpw6ZhkQIKomtokztAtatKYMTWPss7uqIvP
 EnS2A2HcxnGp+bkwA01l+kknqv7OVXe5VvZAbgPzdF2COU2NlRO7kuvER2mx7rbaNAua
 V9O4ZGmeJ26FanhYunQPjhFhySAIjy9pWS8Lvqqn4qus72vQlpuC+bEUf2Hyo9BjqHnD
 lG0+ep1Sn+ZgHSj79VQrdVkPe1Lnk1dGkqUeqt5MaPbdHq6QaaZGOZ1ES/pjORJzAkAT
 rwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794797121; x=1795401921;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jvKAweWSF1WL2MIE6+mbKhodNmuJdfWHL+r3/lgJz4M=;
 b=T6goNIzvHD/VX2KyxfNjAratCLGv6OjHEqjSGxYZ3u1yWHoPC984MNbJ4hZ61XmQm3
 ud6oFVdhaTGAB+ZaFBqWEgZFB0POOtaPRrTHU6egTDK6CXdIFR5/V7oQVv3PejK4YHDF
 hEmakVBekScNOl+9nmzBHpIhy4aaYkvB1YfvdbeE4RV279fi91nXzS4Dj/uJFB5kiVEw
 8YWId7hqiJTSVv1/mdo2gr0kExsFKnUG6lkvAMfIQ/31ecsxMH2Emv5Rw/GdvUjjhpTy
 SU6n5zvQII6GcycjA/lSEjedv2IyDEPBRVG1O2U2AmC/ZcOgAAhrLWagM6e+x/9vQ02E
 zdZg==
X-Gm-Message-State: APuU4Z/n//BdLtwuMufPq8Ht2V5e5dh0yau4wOPac1s0bGqZN48XDhYu
 +QRPvLyYeOGNwHN+J3cVXM/S6h+0nddWiG6ul7j5IxNCjzT9xPn+gYyT
X-Gm-Gg: AYBFou0NYiRLP7LqeL7fVGU5tqjBKGwpBqaqspBWbIoRlE2paaaZorDj2xFp634s/WV
 35dflZJfGzqAJGpq9p+27ZOPpU8qH2otHM7vJfZ72vDS667wU0L0C+ihM7UnBvL5C0MTbmu+uFA
 dHPgDFs9Ly2tOjTSPu14pKSgffF7zBJzLd1TSGCXNviEFzKNYi4fmm6S3N5hJf9ilMr+HuxGbeW
 xMZxTvK/tgI9Zv50fVWfjk6Ki3wCCtpXcPze51hpR0wrV+oks7lHFVgfXWa16aU88E3Uts7/zOJ
 5BZvRsPUMbcnud+2prekmgjTQgwOc8tsdOkdFr0TlVi7/UaFVxhlaZFb3jnM2fH42AsnER+uUEa
 vgK7MrYyzjDOi6/7p2CKM9IbIzweaTYLcxN2Buin3ZaUF+kqT5GG3CXRQ8AwHs3tHJdmiEQkIsD
 9PHmwBeXA+JjDFWotXIhqvnkjn4yGnuD+YcPHft7Ifs21+0jblqPTNhFzOLgftvdaDrj21jDAsY
 BDOD5cxztmMUmVlYXPPcrv01FJPgACtm6Kahi0FTj5Zi80q0y/EnuCdIQeIogONpF4HA94dQ4/4
 0NGe8sFXH9UGpg/rVEAxzz5XCA==
X-Received: by 2002:a05:6830:230c:b0:822:a034:551f with SMTP id
 46e09a7af769-86289738d61mr12244345a34.2.1794797121570; 
 Sun, 15 Nov 2026 18:45:21 -0800 (PST)
Received: from [127.0.1.1] ([2605:ad80:33:509c:d439:680c:b591:d1b2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862aa7a3530sm5274688a34.8.2026.11.15.18.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 18:45:19 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Sun, 15 Nov 2026 20:45:10 -0600
Subject: [PATCH] hw/net: always validate the interrupt index of the first
 RX descriptor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-4729-out-of-bounds-rx-interrupt-idx-v1-1-164891765f6c@gmail.com>
X-B4-Tracking: v=1; b=H4sIADVu+moC/x2NQQqDMBAAvyJ77kITrFG/Ujyou9a9JLJJJCD+v
 cHjwDBzQWQVjjA2FyifEiX4CubVwLrP/scoVBns23bGmA+2zg4YcsKw4RKyp4haUHxi1Xykqhd
 0PXXD7KhvHUEtHcqblOfyne77D4XcZHN1AAAA
To: qemu-devel@nongnu.org
Cc: Andrew Nguyen <xmphyr@gmail.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794797118; l=1643;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=NmDf79vE8hv0YfgtmCbuGLoZ1VFY8keRaG09xlPsi1w=;
 b=+zLhpnWqBXVfM1FoWXh+vOrYbW+1PdqdxnwmATum6vdWMIGV61ws83fUlq0THoOEwNM9DTFVj
 WT/Yzs4sP/oD857r8lC7BjQonO2SIifW62J25od5GcOHZb1vbPt0S3U
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=xmphyr@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 15 Nov 2026 22:33:34 -0500
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Made it so that vmxnet3_validate_interrupts will always validate
s->rxq_descr[0].intr_idx.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4729
---
This is a resolution for issue #4729: https://gitlab.com/qemu-project/qemu/-/work_items/4729.
From the report, I got the impression that rxq_descr[0] will always "exist" even if the value
of rxq_num is 0. This is because RXQ_IDX is 0. Therefore, my solution is to always validate
rxq_descr[0].intr_idx.

To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>

Changes:
- vmxnet3.c: changed the RX queue interrupt index validation for loop to a do-while loop
---
 hw/net/vmxnet3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 24c551a054..58bb7fb869 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1367,13 +1367,15 @@ static bool vmxnet3_validate_interrupts(VMXNET3State *s)
         }
     }
 
-    for (i = 0; i < s->rxq_num; i++) {
+    i = 0;
+    do {
         int idx = s->rxq_descr[i].intr_idx;
         VMW_CFPRN("Verifying RX queue %d interrupt index (%d)", i, idx);
         if (!vmxnet3_validate_irq_idx("RX", s->msix_used, idx)) {
             return false;
         }
-    }
+        i++;
+    } while (i < s->rxq_num);
 
     return true;
 }

---
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
change-id: 20261115-4729-out-of-bounds-rx-interrupt-idx-78d69a7d847d

Best regards,
-- 
Andrew Nguyen <xmphyr@gmail.com>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69641C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nJw-0001ls-6P; Tue, 29 Apr 2025 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qPYQaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1u9nJs-0001ld-Us
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:56:29 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qPYQaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com>)
 id 1u9nJr-00035V-5f
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:56:28 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-2265a09dbfcso88985335ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745942184; x=1746546984; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s506FXrMpDQbCusG51FMuCdKecG4AFLHwlQu9/L00dE=;
 b=dtRvGVd+xD8JEZXMPXRkymg7SEWWm07oROktMHebzHJNxSrr3cHi6MD0W7uztRgEHZ
 vm8LdYXsm+faV6a82C/MI/xfx6TzXSZQOy58eyHm7uqTzwjdp0gxQQk28uhgdZ1wLokV
 lH8+dLCrHrxogi9bkpSkxn2IOxUWAfuSXYhpcbqOIo5EDA0AB640ArAzCBBFA6gjVcXO
 Mq757LRDMPxaoSZWhigJW18wcRdqug9rXy1q5QuloJPfWdhbZ0asNjt0t/RAjxkpLlW3
 oT5wfyWlWgjkQ8/vLYzoQNeu+MBnl77w9sVouwyTSVsCY86Vo4q/be2GeMnV86hzvGlU
 Xbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942184; x=1746546984;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s506FXrMpDQbCusG51FMuCdKecG4AFLHwlQu9/L00dE=;
 b=eBdlIloj0p9wEsuzMKlm05HDuqKtVyByBFzl+VMDqDqQ0RRjX37DNxbJsr2FcIHKvI
 E0HY8tAH2o79dTkMevj5FBVGsHgWjt9seHXI5KnK88oTet+p4463zmMvfpS1YjpJGBkW
 uNdLUrJBR1XB1gYRLgBcu9x3CBnyW18oKMdx++2J0kHB0PLgYngvghP5i7uyPuR2Ty2W
 GCOyldCPfw1HPzYrAq/De55zVcofJV2x6EH1LpfEidU3JfKpd36zraWFsfQKomEJg2ig
 XHfntPlv2LpRKcDyC1CJbbEM66Tj0OUXbC9i1HwPCxD4PKJVhQWQfTRcUIQkiUPpYx7R
 3emw==
X-Gm-Message-State: AOJu0YxJEoCo2AkdmKb6uFzfyKlAapp+uE608LOVpE7ss/nhF1On6dVo
 ujmUZKsOKekImcXMVlI/NzBa768zohjwpj6Fk/+iJ+X4km2OCJi7GIVx8DjPct57yePMCR5QQCB
 yaOnRW/pzymNAo+MKqXU7zNGkdlabrjyvVKnKwIDgNcqxhUI7t8iRfv0OEkBtoWvPBF6r40cGnc
 zzB0ZFLVAYDD313NahDLkVaCdyOdvlbE1rjzcq2a7YVkLEzefzyAvRhpBP32R8o2A=
X-Google-Smtp-Source: AGHT+IGw/i3/2cROSAL+4BRk5GjVcmUlvTsHEReqJ0b6j27+5mInCxaVCWStWBs0Dw0VtZIpUvHivnVG6Lfe+fqO+8g=
X-Received: from plgw2.prod.google.com ([2002:a17:902:e882:b0:223:f321:1a96])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b05:b0:225:ac99:ae0f with SMTP id
 d9443c01a7336-22de5ebb199mr63017115ad.1.1745942184143; 
 Tue, 29 Apr 2025 08:56:24 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:56:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429155621.2028198-1-nabihestefan@google.com>
Subject: [PATCH v2] Running with `--enable-ubsan` leads to a qtest failure:
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lvivier@redhat.com, farosas@suse.de, 
 sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3qPYQaAwKCiEK78FEBPQBC7KDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--nabihestefan.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

v2: used ldl_le_p and lduw_l_p instead of memcpy as per upstream
suggestion.

```
../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
```
Instead of straight casting the uint8_t array, we use memcpy to assure
alignment is correct against uint32_t and uint16_t.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 tests/qtest/libqos/igb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd..2e0bb58617 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
     e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RA,
-                        le32_to_cpu(*(uint32_t *)address));
+                        ldl_le_p((uint32_t *)address));
     e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
                         E1000_RAH_AV | E1000_RAH_POOL_1 |
-                        le16_to_cpu(*(uint16_t *)(address + 4)));
+                        lduw_le_p((uint16_t *)(address + 4)));
 
     /* Set supported receive descriptor mode */
     e1000e_macreg_write(&d->e1000e,
-- 
2.49.0.901.g37484f566f-goog



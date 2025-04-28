Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA33C3ABA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9VuY-0003Q1-AS; Mon, 28 Apr 2025 17:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LvEPaAwKCpcE12985JK561E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--nabihestefan.bounces.google.com>)
 id 1u9VuH-0003O3-0A
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:21:01 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LvEPaAwKCpcE12985JK561E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--nabihestefan.bounces.google.com>)
 id 1u9VuC-00026E-Oa
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:20:50 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-225505d1ca5so46897675ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745875246; x=1746480046; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/ikzH7SasR4txyw70n4vtW5X+UiNJXBlyt4kScEBCTM=;
 b=NsOYVUNFnwOFNqZ8221mY/vrakx0de/k2YUkE7E9JLyNuuzgsc/ZxH12x++aESi/rw
 dNtFRYCdaI7uhCPVXPbSjYerkUz0/kkZm+2zLZPfR78gs/iGia4v2qJ3SZb2t6BNP6Me
 yM+13ZO06TKgtIVJT0iUY3ccx0/MjIkBp2EZFEI+w2lv4rJT261J/FFQ2Fgauvq1Eot5
 94vbbqOz3eqMyH4T12CkxkE67JDj7qt6mVO2FGH2VHzGtNxm3ECyWoRObEvFtcId5Wqe
 2nvGZN0fHnaqLnMKbwU+QgBXKiPmQ5gcrctROh1gO1DiqQwXzTPiXe42j/VrPzbUohf2
 6Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745875246; x=1746480046;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ikzH7SasR4txyw70n4vtW5X+UiNJXBlyt4kScEBCTM=;
 b=J7kCiVqShGA2nWr+KFIsC9L24hg8ta+jScffaWPgAbyP2HMrIsqCBn4T2mtnA5AzHE
 NeZiXD4XHlhm7PkHB6DctNPMd6gYJowPL8rR45tNZ9YYBOSobQcTbhTXl3yIe0JO4Mpr
 l+GePy6xV6F8SHOPXJF4C8SnaGJ+kUo4nKZGJFJ2KCHhhwH2ITBZhQT6qAlHPIzkfhd7
 BzW4d4asyR6yir/i3k5NOSWsT/9pXLS3NVS1rG0u3wPU4oz0JztI8o2Hl5hKbL3pSaGR
 NhxUJrX2eSloFLFrEDxRBCb/yMpAdcPQ6GJEcTk331ZzGW2NXbQH316XZQFWzo9SvgCS
 QGqg==
X-Gm-Message-State: AOJu0YxO4mbyBKtHTEHeXQgOBkm+pV5R9Fxy/OIsHuF67w+libg8mGlh
 aCBNppJK2HAXDHXOkRZnVWjldkxH+buzUUfZGOcM9XtBRvf/fRCIC25laubWRR6I4F4qmRpjKlI
 Tzvvl5X/VF8mQ+dYL8vgSaUi5Zn+Bhcfo+L7EklZgunSS4B8XFGT36D0qDS3QAnUJvJcp/bmP7y
 ix4szTmO5AKrMJsM0RfJMoq89vTPD6ne5apcYbPn/LVS7Kpuy9PoPFzV+da5awZr4=
X-Google-Smtp-Source: AGHT+IGWB9QMaqFiy/yZpuFVTZmsu8oviwn+plteSuZs7IjNvGRjCPMo8xszt27OPEfQQhoj8yow/3y+2+ePqKvBgkw=
X-Received: from pgbdm2.prod.google.com ([2002:a05:6a02:d82:b0:b0e:1d1:49c9])
 (user=nabihestefan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d50c:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-22de6ea2e01mr8419715ad.21.1745875246020; 
 Mon, 28 Apr 2025 14:20:46 -0700 (PDT)
Date: Mon, 28 Apr 2025 21:20:41 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428212041.1301050-1-nabihestefan@google.com>
Subject: [PATCH] tests/qtest/libqos: Fix UBSan misalignment finding
From: Nabih Estefan <nabihestefan@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lvivier@redhat.com, farosas@suse.de, 
 sriram.yagnaraman@ericsson.com, akihiko.odaki@daynix.com, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3LvEPaAwKCpcE12985JK561E7FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--nabihestefan.bounces.google.com;
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

Running with `--enable-ubsan` leads to a qtest failure:
```
../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
```
Instead of straight casting the uint8_t array, we use memcpy to assure
alignment is correct against uint32_t and uint16_t.

Change-Id: Ibd2bc3d870ea37bcbaf2e459806a22ae17464049
Google-Bug-Id: 391659542
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
---
 hw/pci/remote_pci.c      | 0
 tests/qtest/libqos/igb.c | 8 ++++++--
 2 files changed, 6 insertions(+), 2 deletions(-)
 create mode 100644 hw/pci/remote_pci.c

diff --git a/hw/pci/remote_pci.c b/hw/pci/remote_pci.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
index f40c4ec4cd..f31b1a7261 100644
--- a/tests/qtest/libqos/igb.c
+++ b/tests/qtest/libqos/igb.c
@@ -103,11 +103,15 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
     e1000e_macreg_write(&d->e1000e, E1000_RDLEN(0), E1000E_RING_LEN);
     e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
     e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
+    uint32_t safe32_address;
+    memcpy(&safe32_address, address, sizeof(uint32_t));
     e1000e_macreg_write(&d->e1000e, E1000_RA,
-                        le32_to_cpu(*(uint32_t *)address));
+                        le32_to_cpu(safe32_address));
+    uint16_t safe16_address;
+    memcpy(&safe16_address, (address + 4), sizeof(uint16_t));
     e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
                         E1000_RAH_AV | E1000_RAH_POOL_1 |
-                        le16_to_cpu(*(uint16_t *)(address + 4)));
+                        le16_to_cpu(safe16_address));
 
     /* Set supported receive descriptor mode */
     e1000e_macreg_write(&d->e1000e,
-- 
2.49.0.901.g37484f566f-goog



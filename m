Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B65EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAp-0001yd-3L; Wed, 04 Feb 2026 14:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAm-0001tr-5B
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAj-00087N-P9
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/mr0SaJ3nQqLbGDXUvO9FoPgG42CFKL4dU21fPLl/U=;
 b=XtoW0cpO9E3n7cXI6M4kGQ5G+/aTNaqzBTT+5XjfV8MDS8EWHbgtiPLpG5o6d27jVtpOgp
 oU9TjxFDEgZEPyzKGR7hwsiGfKwfrBRBJti6fgfr8jbranb2EgukbNiZXiE8GYs0KiUeRU
 uhdhFJKoFcy1ktLFJd8R5t3FwwGpV7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-EQYcBpiVOoewHw8AV721pQ-1; Wed, 04 Feb 2026 14:04:14 -0500
X-MC-Unique: EQYcBpiVOoewHw8AV721pQ-1
X-Mimecast-MFC-AGG-ID: EQYcBpiVOoewHw8AV721pQ_1770231853
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso189229f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231852; x=1770836652; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F/mr0SaJ3nQqLbGDXUvO9FoPgG42CFKL4dU21fPLl/U=;
 b=pt719wkEsOYo0M1F6HvbFNpuHHMHsaYsvW6WNcYdAWf5sfQ46L+eKadhO5gT4mY5zg
 Cb6/YrGCxEjyRH6QCbp9pfGu/OwYavmfYDetS1IgLC4nwwtkXpXIzOGemW5eMK2VMj1s
 CpZfUCBnKHHm815B8Kk3yh2ynT/I0s0fCmfmwh6ysriXSUxBW5bc3AJwxjGmrWud8Z+4
 dzOgoQ5CI053hArj27Y7O8CYF3qyC1udI7Vfy5zAJ1yBubZ4pxJqM2RfzB9UGBCy6Vq0
 g8ml9U0aGrnAxVI+pRJcoqYYzHY0tFyDPNJyPQpz4FN+ValfaEAzAcaQ13NiRa+Z4Zrx
 bFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231852; x=1770836652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/mr0SaJ3nQqLbGDXUvO9FoPgG42CFKL4dU21fPLl/U=;
 b=NI9vHj+0IbUabFkrV3b5ZGag6H/o/y5qwLUTUHufW10P56cStDRQB0BOFh5bNFOYTR
 9y3xe6dIHb78Sez1vpo5aE3nnPrznaDNtq8KYsFzQMzWHHGASuF+Zq1y9FeOp9IWe238
 bA9DdseJo23b19sVrlKO/Zn+awZAdSX90WFhW0IQhposJcpaGYL2A2oOEYO3LZtV+hFO
 L6CsMzYH1DyKVgdbcrM/Q9ei3+rVrFarhXSRdgRcaYHVut5COe1pSJtDZG/axOCVa7qG
 srsufGFsKbigPqCTA5OU73uAL3kDCjHP6DwrL+/o53Ty02grtKQHr3k3qURBIciUOSiF
 YKaw==
X-Gm-Message-State: AOJu0Yw9RW9/leTX65Affc9LTNH2/ohP39c/c/awwPVm0xhsLt122bD4
 G9lyGMDkbM3AsbyhP/P1HmJq44Pw/DMLRqfeMPtSGVphHGcVn1bRsG++GLw4OWfwY7xTApXACQu
 AMKniVcXPHCvlmoQH/AkBXQ7tj9eGs28ZQWbTxe/0YsPaXhamC5ba0KRJ6+HBTsWchJFZXrzULQ
 L/nosyx0TedI6MAfnqeg+y4yiYyvMSzc7DtQ==
X-Gm-Gg: AZuq6aJNcmbdfFo/JbKIjgVY8ucLSqf2aTKDGfJh4nzRUNSTN4FOSYMihBKidTmjtkl
 APdgEboQV2GXZvQjScOK8zC4NlOjV8aNtWOLlC1TWDESWvksHPZl9Y3WjxaLEzf/O4LdtgXT+n7
 4+N1+0u9N423k+bvcIYubPSOibCJNOQj1noJ8jeEoAFhvKnpclLjyHx2LV19xdFY2PtfzX/7/zk
 6qv/ymdzA6otKnlUTiUQWHP03gH7XoCf6vj+yaWDQ1SM0fBUzuRPAqmRSc2VKILKFNgcOVMwd7S
 dt3fZ78mmU9n2mQWQ7AyxMF6VV0w9feu6Dazc9nhm+QfOuTk57q0FI7ah4fW0CV12P7JAPugAuR
 PdaxVECiN4wcK260dL8Qyz1unz2mixjTeEw==
X-Received: by 2002:a05:6000:4211:b0:432:c05b:d8c7 with SMTP id
 ffacd0b85a97d-4361805955amr5630939f8f.49.1770231852390; 
 Wed, 04 Feb 2026 11:04:12 -0800 (PST)
X-Received: by 2002:a05:6000:4211:b0:432:c05b:d8c7 with SMTP id
 ffacd0b85a97d-4361805955amr5630868f8f.49.1770231851781; 
 Wed, 04 Feb 2026 11:04:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4d030sm6269655e9.13.2026.02.04.11.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:11 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrey Ryabinin <arbn@yandex-team.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 35/51] q35: Fix migration of SMRAM state
Message-ID: <373e5dd104520d2a30dc11b10463ec7ded7fdbbd.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

When migrating, dst QEMU by default has SMRAM unlocked,
and since wmask is not migrated, the migrated value of
MCH_HOST_BRIDGE_F_SMBASE in config space fall to prey of

  mch_update_smbase_smram()
    ...
    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
        *reg = 0x00;

and is getting cleared and leads to unlocked smram
on dst even if on source it's been locked.

As Andrey has pointed out [1], we should derive wmask
from config and not other way around.

Drop offending chunk and resync wmask based on MCH_HOST_BRIDGE_F_SMBASE
register value. That would preserve the register during
migration and set smram regions into corresponding state.

What that changes is:
that it would let guest write junk values in register
(with no apparent effect) until it's stumbles upon
reserved 0x1 [|] 0x2 values, at which point it
would be only possible to lock register and trigger
switch to SMRAM blackhole in CPU AS.

While at it, fix up test by removing junk discard before negotiation hunk.

PS2:
Instead of adding a dedicated post_load handler for it,
reuse mch_update->mch_update_smbase_smram call chain
that is called on write/reset/post_load to be consistent
with how we handle mch registers.

PS3:
for prosterity here is erro message Andrey got due to this bug:
    qemu: vfio_container_dma_map(0x..., 0x0, 0xa0000, 0x....) = -22 (Invalid argument)
    qemu: hardware error: vfio: DMA mapping failed, unable to continue

1) https://patchew.org/QEMU/20251203180851.6390-1-arbn@yandex-team.com/

Fixes: f404220e279c ("q35: implement 128K SMRAM at default SMBASE address")
Reported-by: Andrey Ryabinin <arbn@yandex-team.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251211165454.288476-1-imammedo@redhat.com>
---
 hw/pci-host/q35.c      | 27 ++++++++++++---------------
 tests/qtest/q35-test.c |  6 ------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b353d3e1e6..e85e4227b3 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -431,30 +431,27 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
     }
 
     if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
-            MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
         *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
         return;
     }
 
     /*
-     * default/reset state, discard written value
-     * which will disable SMRAM balackhole at SMBASE
+     * reg value can come from register write/reset/migration source,
+     * update wmask to be in sync with it regardless of source
      */
-    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
-        *reg = 0x00;
+    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
+        return;
+    }
+    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
+        /* lock register at 0x2 and disable all writes */
+        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
     }
 
+    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;
     memory_region_transaction_begin();
-    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
-        /* disable all writes */
-        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
-            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
-        lck = true;
-    } else {
-        lck = false;
-    }
     memory_region_set_enabled(&mch->smbase_blackhole, lck);
     memory_region_set_enabled(&mch->smbase_window, lck);
     memory_region_transaction_commit();
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index 62fff49fc8..4e3a4457f6 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -206,12 +206,6 @@ static void test_smram_smbase_lock(void)
     qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
     g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
 
-    /* check that writing junk to 0x9c before before negotiating is ignored */
-    for (i = 0; i < 0xff; i++) {
-        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
-        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
-    }
-
     /* enable SMRAM at SMBASE */
     qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
     g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x01);
-- 
MST



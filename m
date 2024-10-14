Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8414D1813A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 18:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Q8b-00049y-6B; Mon, 14 Oct 2024 14:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wmcNZwYKCgcyvx1lonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--roqueh.bounces.google.com>)
 id 1t0Q8W-00049a-MW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:49:45 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wmcNZwYKCgcyvx1lonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--roqueh.bounces.google.com>)
 id 1t0Q8V-00018u-1R
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 14:49:44 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e3705b2883so25355907b3.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728931779; x=1729536579; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7pv8SMLoX58p+TYu8hQfpm8uqfTPRLQQB77L4yBbjds=;
 b=2AaDhlG2aZ1QQ0H+c5GAvSLby7jCF5z9cOWVWCEBimIeLcnmqXd28QzSRfL+2EIDnY
 c6W2E1qvcdnEAWYR3TEn3HRC9V2rOqFJlUD6t4e719xaFAL6co0DE8dsaiqqBIkDGPlv
 DtsGqNZtureu43XibhKV4oIc7Lyx3817Fa6944u1dsxRqYOa8zoj2U2a1M1mUMJyg38G
 NcI/eJYrvk14Ub+FdygotZqqUEH5ehFeGUVVPNAI49CrZAtzo9zKqh6WfoJwzbIh59S9
 IepSUzAbKGIamp5blG33xF1OFPfRhz7g8ZNedSJJ3vNrQO2DZmZlh7OaWfWSKVTLRwqo
 on5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728931779; x=1729536579;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7pv8SMLoX58p+TYu8hQfpm8uqfTPRLQQB77L4yBbjds=;
 b=koVbbEf52+AlXxf2G2abyV2RT+b6IX/s4ScHCl7fzm3PSwnDA2KRC6fRk2YVf7yFwX
 mfZ6GZhYPuWaJC/1HGdrgrQrH4C5Zflbj+fyISPBOfi2hoX5dQXXADQ037Y8iYO8rZnd
 yFy5k3T07FLG6ICyEWl8LK9rWa7DizsN67V6LgOxQCWv1PDdYO49aHkHG92g1wx95A21
 qF4J1Mcp+lr3IccrUB0IZLN+iFcePSGt7RePOazamlUa0cQAIWjAXQt7wP4Z0kgw08uq
 AJ3bLxmKDVjqSNm9zyYdAKAHV7m9u394lDQ+XHJKiLHpZVFUWwldzCPFr2SLLGwIcbZU
 ee2w==
X-Gm-Message-State: AOJu0YyRNuk8dvpH4XNKYA4HfDcEcC3v/8OSNEeH+ezIf8I0m5cyCM/0
 sW5OqjuoV1aNanOiME2EjFaO3FqZkaT84gx2tL8jmlvTqG0+Nt6K/CuU8B50RUaZ6gYGmJfMdvS
 OrA==
X-Google-Smtp-Source: AGHT+IGPyN/FmByTmA6/vgVvdLhbqQ21fnTd521VFrsxMlEDfSP7Mh/OJycrM1QPaoXZanyghCWeT/uTJkk=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:690c:61c8:b0:6e3:345e:5f89
 with SMTP id
 00721157ae682-6e3471eebbbmr1900857b3.0.1728931778975; Mon, 14 Oct 2024
 11:49:38 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:48:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014184847.1594056-1-roqueh@google.com>
Subject: [PATCH] hw/net: Changing log error to trace message
From: Roque Arcudia Hernandez <roqueh@google.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3wmcNZwYKCgcyvx1lonvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: Nabih Estefan <nabihestefan@google.com>

Converting error to trace message to avoid spamming of message when
there is nothing to transmit.

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 hw/net/npcm_gmac.c  | 5 ++---
 hw/net/trace-events | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 6fa6bece61..685905f9e2 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -546,9 +546,8 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
 
         /* 1 = DMA Owned, 0 = Software Owned */
         if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "TX Descriptor @ 0x%x is owned by software\n",
-                          desc_addr);
+            trace_npcm_gmac_tx_desc_owner(DEVICE(gmac)->canonical_path,
+                                          desc_addr);
             gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TU;
             gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
                 NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 4c6687923e..bb8f59cf23 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -476,6 +476,7 @@ npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finishe
 npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sent!, length: 0x%04" PRIX16
 npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
 npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
+npcm_gmac_tx_desc_owner(const char* name, uint32_t desc_addr) "%s: TX Descriptor @0x%04" PRIX32 " is owned by software"
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.47.0.rc1.288.g06298d1525-goog



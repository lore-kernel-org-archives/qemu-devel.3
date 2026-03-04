Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF36EDEBFD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbPe-00062a-TM; Tue, 03 Mar 2026 20:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPb-00061e-Qc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:31 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPa-0004TY-B7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:31 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-94dd2d71231so1845191241.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772589149; x=1773193949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxu4XRB4FitI2+AcQo8tLZ5+1Awl0R6238sOzIkA3R0=;
 b=B7uPM1ZPeWXqFA/Q4lxo2HCiiF1uTfFQwBgwNzx3INPO34CiCyHebhiSjC9vLxbhlr
 F8H8fYdMquRcjYpmfaz4WgeXxI+D9kIWrC3tGK9K5lEORQkqyBKUuHgCeXnT9K6p75cW
 3XxE3F+fy2xoD/IdYDC9+Rq5KgQh5+Jlq/fk8Bk5Nk1F6sXxz54GEDE/9zh3IYSQnS4i
 IGKJvThUPxQveB1wzDTygAdWj47UBnZi2U8RcdeSbGUEqiKfIiQgNaDBvD8iYsraR6AC
 jiPV5cpRw8NUfkjcfyV2PXnW+FyUojeXqu3pXbXUIoS6Uqu/DKy6HGVUiPgbBgc8xPZF
 WCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589149; x=1773193949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxu4XRB4FitI2+AcQo8tLZ5+1Awl0R6238sOzIkA3R0=;
 b=tdViAwvLsEwqpspRIGsaFxPqAKtikW6TxIAVV4gj/vV2mdvNXgXtUQmNEUonuNRU2O
 tzPnSEO50LHxMFhPb4NRFC4u14qGTGPBXso04AENDJLOU9iqpVbBiNv4SeJyuV437wdp
 PDp6DZT5AVru804vto9TRFuguE6pU1y+fneNp1Sg+mU81CJn7gN+uKrXv+FCI+IEZHpV
 rpk/+dj83bAREEPPUyVIheNdweuqSmzvbODJACIzOx5x3nej1/+oweKLgSnCBrOnYbT8
 qLOYgOe14ySAd+U3hofjJQkaZb6UCQk2agyCm7nN2dAH8Fn6OBU2NFVeRF+dA7Z2/G7C
 +moA==
X-Gm-Message-State: AOJu0Yz0VCCJOKG6mdSvPa6QguuzA4xQqh5v7f3iWWwQeY0PR/Pqszyk
 Z+cvNobsh4cVjFCqRsO9Zs8SNCxFVkkWeBuGAEDVpVnDAGKGZo89R54g7535M337
X-Gm-Gg: ATEYQzyhW3e/siTfOguwOmqjxoMuSahfOJqCGRfNox4Bfzq+GhHIKXDe8Ncj916DkSg
 jlHko4WVawf7AmjnnBKIoB3S9XwNd6HG+AnqRl/Nbp/7++Fu++obt+dyr7rd0ayp3+Q/I2iWyun
 DuPrmyGOOF7aK5fr91T5Zl3rcg89T7Efyu0k7bcg77gh25ROLdi74psciIRqAqpRU5oGwFGRnU7
 dLN0aiV1LHqFZ/NDWsn+g4lA+ylA2b+9dNCm+ljD8pqTuUcEpxwkXhargkKm1yQVVQwF2BIRzLo
 P+4Zoj7UmrZX7aHj4qkCoc8gjlK5o753eJCl1+WddpTPYgWLWiCSkV9uz32x8RID0f1K+r8sij6
 LPCXM72GKToFuYqI2e2Z/eJZZuf3svori/dCnqlFHG0jOYja8cxZG5tmNV/m5yBnoqneUlX/qhC
 91pxgPH8HHGR/TCtZP/hBOoZyz6zOzwTHVL6gg3w5O/RFj3OyE/UgKdJ2XvA==
X-Received: by 2002:a05:6102:c09:b0:5dd:f9c2:551c with SMTP id
 ada2fe7eead31-5ffaaf1bf2fmr242963137.27.1772589148744; 
 Tue, 03 Mar 2026 17:52:28 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ff1ea1596asm18777740137.9.2026.03.03.17.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 17:52:28 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PATCH v1 1/5] xen: mapcache: Assert mapcache existance
Date: Wed,  4 Mar 2026 02:52:17 +0100
Message-ID: <20260304015222.979224-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304015222.979224-1-edgar.iglesias@gmail.com>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Assert that the mapcache was created prior to being used.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-mapcache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 11115f6084..517e5171b7 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -464,6 +464,8 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
     MapCache *mc = mapcache;
     uint8_t *p;
 
+    assert(mapcache);
+
     if (grant) {
         mc = is_write ? mapcache_grants_rw : mapcache_grants_ro;
     }
@@ -530,6 +532,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
 {
     ram_addr_t addr;
 
+    assert(mapcache);
+
     addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
     if (addr == RAM_ADDR_INVALID) {
         addr = xen_ram_addr_from_mapcache_single(mapcache_grants_ro, ptr);
@@ -652,6 +656,8 @@ static void xen_invalidate_map_cache_entry_bh(void *opaque)
 
 void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
 {
+    assert(mapcache);
+
     if (qemu_in_coroutine()) {
         XenMapCacheData data = {
             .co = qemu_coroutine_self(),
@@ -709,6 +715,8 @@ static void xen_invalidate_map_cache_single(MapCache *mc)
 
 void xen_invalidate_map_cache(void)
 {
+    assert(mapcache);
+
     /* Flush pending AIO before destroying the mapcache */
     bdrv_drain_all();
 
@@ -776,6 +784,8 @@ uint8_t *xen_replace_cache_entry(hwaddr old_phys_addr,
 {
     uint8_t *p;
 
+    assert(mapcache);
+
     mapcache_lock(mapcache);
     p = xen_replace_cache_entry_unlocked(mapcache, old_phys_addr,
                                          new_phys_addr, size);
-- 
2.43.0



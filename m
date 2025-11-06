Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD1CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 13:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5vv-0006vp-De; Sun, 09 Nov 2025 08:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vI5v1-0006Ei-TD
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vI5uz-0003GF-SZ
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762696641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4QLZ0wocEbh/vect8t4Ip3APFKkZMxf5onqifsOVDY=;
 b=KQMgVE1dcqZdfqZEoMeTdwhLqjI8k6yfL3yuhtkw6TBKBVvosU+RcVzrNWpOwfPrYJXYlq
 jtEKlb88h/yl++fbggFIzjoN25S/kpva/ofsR/miU8LtLiJ8y4xVI1dsVdlymQb6TRvuey
 Pug2CNoXOZECeqMcytqEN+sP7It2n+A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124--jSaVV_POl-3fua5c4ZrmQ-1; Sun,
 09 Nov 2025 08:57:19 -0500
X-MC-Unique: -jSaVV_POl-3fua5c4ZrmQ-1
X-Mimecast-MFC-AGG-ID: -jSaVV_POl-3fua5c4ZrmQ_1762696638
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64CBD180034A; Sun,  9 Nov 2025 13:57:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71E2B1955BE3; Sun,  9 Nov 2025 13:57:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-rust@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] hpet: remove unused trace events
Date: Thu,  6 Nov 2025 16:56:05 -0500
Message-ID: <20251106215606.36598-2-stefanha@redhat.com>
In-Reply-To: <20251106215606.36598-1-stefanha@redhat.com>
References: <20251106215606.36598-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/timer/trace-events | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 2bb51f95ea..f3fca6fc9b 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -112,7 +112,6 @@ sh_timer_write(uint64_t offset, uint64_t value) "tmu012_write 0x%" PRIx64 " 0x%0
 
 # hpet.c
 hpet_timer_id_out_of_range(uint8_t timer_id) "timer id out of range: 0x%" PRIx8
-hpet_invalid_hpet_cfg(uint8_t reg_off) "invalid HPET_CFG + %u" PRIx8
 hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
 hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "reading counter + %" PRIu8 " = 0x%" PRIx64
 hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
@@ -123,4 +122,3 @@ hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
 hpet_ram_write_counter_write_while_enabled(void) "Writing counter while HPET enabled!"
-hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t counter) "HPET counter + %" PRIu8 "written. crt = 0x%" PRIx64 " -> 0x%" PRIx64
-- 
2.51.1



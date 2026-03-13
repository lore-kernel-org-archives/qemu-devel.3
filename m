Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B650107BCD3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17IL-00008H-ON; Fri, 13 Mar 2026 14:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17HG-0007d4-Lk
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w17HE-0005TK-K1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5EF1F5BFA1;
 Fri, 13 Mar 2026 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=497Hr2PA0ZA5bBeneuBb6p0JaBKn273FnDt2WbD9jdI=;
 b=BgNp5WoPPuaURLil2xQgPD1eRt+oI8/BLbGIxKwBSrc5PKyzSat+PbKeI10q/r+5CYVkdQ
 Q1PrF2Y27hXWYTellObLkUo56Ji0TkBw4MVJ4cHo1aX5jxlyRLcFX/JTAGD7vo5EjQICBr
 LMBhZIYwM46X5CDz7d734yJYQ3ULaT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426611;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=497Hr2PA0ZA5bBeneuBb6p0JaBKn273FnDt2WbD9jdI=;
 b=64JRMCwjM3t+/TD17SMHw0k6Q4QgjAHYTFBCEB+XTinWmNXcmnWPaxrem71eFPt9rLVqzS
 TwJzh+xIsnz7CXCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dr0R93LG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4U34EWTR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773426610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=497Hr2PA0ZA5bBeneuBb6p0JaBKn273FnDt2WbD9jdI=;
 b=Dr0R93LGR/p1doECe0fV9OiicKhVXbBHE7+FGtgNLPPtRpWbQKdH622GFlMm9Lsh6Q3axu
 VTqsNaIMgBF550l6HqN71enoaUNWYDdyUX2aYIzY8BIlRfB7VAbXpoEaNWQnmMpZOI9D3W
 ExJ7hxg5VPqxYG/w58s+7Sb4IxogCaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773426610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=497Hr2PA0ZA5bBeneuBb6p0JaBKn273FnDt2WbD9jdI=;
 b=4U34EWTRUFcuz4iPfsM+XtC/vfNlBboiOCCtuBEtG3RGLCHgTIyO8y64nNGL30KXey1QSz
 dUIPWCUQGXw5dlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9A340678;
 Fri, 13 Mar 2026 18:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFZbBbBXtGn9MwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Mar 2026 18:30:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v1 4/4] hw/riscv: Free resources allocated at
 riscv_iommu_instance_init
Date: Fri, 13 Mar 2026 15:29:56 -0300
Message-ID: <20260313182957.28432-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313182957.28432-1-farosas@suse.de>
References: <20260313182957.28432-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[linaro.org,dabbelt.com,wdc.com,gmail.com,ventanamicro.com,linux.alibaba.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5EF1F5BFA1
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Add a riscv_iommu_instance_finalize() routine and move there the unref
of the iot_cache and ctx_cache hash tables from riscv_iommu_unrealize.

Also start freeing the register state masks, also allocated at the
_init function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 98345b1280..a9cd891039 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2446,6 +2446,18 @@ void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode)
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_IGS, mode);
 }
 
+static void riscv_iommu_instance_finalize(Object *obj)
+{
+    RISCVIOMMUState *s = RISCV_IOMMU(obj);
+
+    g_hash_table_unref(s->iot_cache);
+    g_hash_table_unref(s->ctx_cache);
+
+    g_free(s->regs_rw);
+    g_free(s->regs_ro);
+    g_free(s->regs_wc);
+}
+
 static void riscv_iommu_instance_init(Object *obj)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(obj);
@@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
-    g_hash_table_unref(s->iot_cache);
-    g_hash_table_unref(s->ctx_cache);
-
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
         timer_free(s->hpm_timer);
@@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
     .instance_init = riscv_iommu_instance_init,
+    .instance_finalize = riscv_iommu_instance_finalize,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.51.0



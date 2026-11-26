Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAA606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HUDM7B9s;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EzRlySgE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWii1-0008DO-3R; Thu, 26 Nov 2026 18:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihu-00087Z-0a
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihr-00062c-9q
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5msL5Y3whH1wyPAcimr4/6A5hkAEK5pqKOOOJceBdzM=;
 b=HUDM7B9slrzDC4Fy6fRGdSbksPF9Q7/kuj/gDdMb2zNWBm7XA6hsl/ehmQ8v5JnBJLeBf9
 P+qUg4ofQWEwKLgDh56JXrsuithQrS2LinVL284JHM1jJyp5SLi2iRTBwGvuIkGBkEkUyW
 qkAY+tLdRhzsZ1rJ1NImgCN30A1ATJ8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-nLK-QanwPKeoj5QG92JTAQ-1; Thu, 26 Nov 2026 23:16:43 +0000
X-MC-Unique: nLK-QanwPKeoj5QG92JTAQ-1
X-Mimecast-MFC-AGG-ID: nLK-QanwPKeoj5QG92JTAQ_1795735003
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94960bd17b5so1172210985a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735003; x=1796339803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5msL5Y3whH1wyPAcimr4/6A5hkAEK5pqKOOOJceBdzM=;
 b=EzRlySgEDQ6uewkJBi4Je4wObsHdCoaaeR2zmdspZpfvyf34yts6yleVPuPPHGZlH/
 LkpDkFPlNJw1gXJ13KVuF5mLrH/yRGhKO7TP/UzK2VmyzhtpaFtguNNqZNtwJgxL7kUQ
 JcsSflOVQNfEONdGJ8BsOigdVXHOuA3dcmM1qzciqTSEkxvoPjk52r7feXQ1Tuc1L76Y
 9+CjxOlhB2gdPyok8+OLUbIUvF4Wx4pkoMoEWsfvX1ImuXZSk2bTfX/xKE/+ZIvjWS/Z
 QwmpLQCtoSVCyz0Ej1CCdF82J3LTRjDqjsWMXXQFR7MkyCu8EaMDTnCTPODIQr497Mlw
 s1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735003; x=1796339803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5msL5Y3whH1wyPAcimr4/6A5hkAEK5pqKOOOJceBdzM=;
 b=SzjRO881pWAIU6xgvcYvHG/CDWJMit61maa46IS6xnt98ZbSajpiwbahQ4UDan+8LJ
 kkdw3VBvdn875KXroueuxHxYwanDruN+FTEz7vZreQBNwNAuYL06hHPYDoRZAJgcHg7d
 SwDp+E+bobiWGLZcjNBF0mXSui2aAQ89RPyzQGYyi4I/b40d14P/qOlx+Ux5PVd3fSPP
 Zb+8eKIi760C3AoPd/vENTsBuGXDTxAG+IZj1x247WyfyDrHaP3RIF/a/E/WwTdSAm9a
 fOc56EAl5PPN+SiPjMQ4hOpv5+OMR5Zv8jjuSWeTlMdhS1CAfzf3g79KDzaYkKRFnRJP
 cx6Q==
X-Gm-Message-State: APuU4Z96pQqi9zzbA0UypaXhLs4LIBNo21AEhlcTfwe0hHC3/dDsCvRI
 u9GEsuxkgwqG8XiCnxoV8y+PijRh1nf1TDeBdCvkFAgMpZ61sQ/uyc2kBlAAkLTKvWoSDGJ4Bdj
 ItIxh1fGqTxn3C3/1sSgAs89pqKge3mmmt0v2qYnvqTToDT7HZWJkxZYLPzXkFrPcbuVfM7RmeS
 sK1/Kwet5zkjy0W8dhvUCHUThYTKYH1qzBvoo3Pw==
X-Gm-Gg: AZFdTZcH7KC+sJa3G5NFmNmiF78WguLCmJYE2wPwczIe9qtEqfOZAKFpajF4T2ObSAY
 kh3mOthmvUaYYzTtsDyGZs2TVN6xYmjvWK2ZIrxdq7seDTVWJcnHwXSju44mOPnZKBzRIHjMU2h
 bzgno1/bKPmYKmdASSFMCC6sKv1UIexILPat2ZQfhFqRy4ZON9Qo+eS+Ru/3gDz3b2r+jNu8F5Z
 sagN78iM1lTMa+Nlv9Vj4Sl47OdGJB7Cp1x4zEkj12i+hqkwmM5R7P7yA7Rm5JL9023gNcHsGrP
 +Rk+16xL2vJH+c45vGbN/iQg7St6wswxxma2Skw4fc82L8gBGsEB8wPVRmxkGjPAq0/YnCeUV15
 pzgdbiZ0c2fcYPmgvuufdgd5P2ClDVI2IFbbMegQkJfE2
X-Received: by 2002:a05:620a:1d0b:b0:949:75f1:e5fe with SMTP id
 af79cd13be357-949bab1719cmr3745580385a.73.1795735003157; 
 Thu, 26 Nov 2026 15:16:43 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:949:75f1:e5fe with SMTP id
 af79cd13be357-949bab1719cmr3745575685a.73.1795735002525; 
 Thu, 26 Nov 2026 15:16:42 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3a646fsm1697088985a.22.2026.11.26.15.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:42 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH for-12.0 v2 5/9] hw/gpio/zaurus: Move VMSTATE_VALIDATE() check
 into post_load_errp()
Date: Thu, 26 Nov 2026 18:16:27 -0500
Message-ID: <20261126231631.3392756-6-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To pave way for removing VMSTATE_VALIDATE(), remove the use in this file by
moving it into the post_load_errp().

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/gpio/zaurus.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 3cf626a550..ede28f0929 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -23,6 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 /* SCOOP devices */
 
@@ -188,12 +189,19 @@ static void scoop_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static int scoop_post_load(void *opaque, int version_id)
+static bool scoop_post_load(void *opaque, int version_id, Error **errp)
 {
     ScoopInfo *s = (ScoopInfo *) opaque;
     int i;
     uint32_t level;
 
+    if (s->prev_level & 0xffff0000 ||
+        s->gpio_level & 0xffff0000 ||
+        s->gpio_dir & 0xffff0000) {
+        error_setg(errp, "irq levels are not 16-bits");
+        return false;
+    }
+
     level = s->gpio_level & s->gpio_dir;
 
     for (i = 0; i < 16; i++) {
@@ -202,7 +210,7 @@ static int scoop_post_load(void *opaque, int version_id)
 
     s->prev_level = level;
 
-    return 0;
+    return true;
 }
 
 static bool is_version_0(void *opaque, int version_id)
@@ -210,27 +218,17 @@ static bool is_version_0(void *opaque, int version_id)
     return version_id == 0;
 }
 
-static bool vmstate_scoop_validate(void *opaque, int version_id)
-{
-    ScoopInfo *s = opaque;
-
-    return !(s->prev_level & 0xffff0000) &&
-        !(s->gpio_level & 0xffff0000) &&
-        !(s->gpio_dir & 0xffff0000);
-}
-
 static const VMStateDescription vmstate_scoop_regs = {
     .name = "scoop",
     .version_id = 1,
     .minimum_version_id = 0,
-    .post_load = scoop_post_load,
+    .post_load_errp = scoop_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(status, ScoopInfo),
         VMSTATE_UINT16(power, ScoopInfo),
         VMSTATE_UINT32(gpio_level, ScoopInfo),
         VMSTATE_UINT32(gpio_dir, ScoopInfo),
         VMSTATE_UINT32(prev_level, ScoopInfo),
-        VMSTATE_VALIDATE("irq levels are 16 bit", vmstate_scoop_validate),
         VMSTATE_UINT16(mcr, ScoopInfo),
         VMSTATE_UINT16(cdr, ScoopInfo),
         VMSTATE_UINT16(ccr, ScoopInfo),
-- 
2.56.0



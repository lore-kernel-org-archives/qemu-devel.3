Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF51C561E6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrdZb-0005qb-S7; Wed, 05 Aug 2026 11:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZU-0005nQ-26
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:20 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrdZR-0007dJ-NT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 11:30:18 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4896ae35be9so384412b6e.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785943814; x=1786548614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PoXfMDRAQIj+y4/BPWtH1Tl3SZCP6UaSej1RFcIEr2g=;
 b=POHWM1ewxHIkMhmxdfM22pg2ttz9Ev9AfgMMQUhQIcl7XJMSmMSNM7LJymWjQbCZTX
 o2b1dCWY5JUrPACdC2aLHw8wc7HtkOoenaPKsGkXIMYi9YEg3dBJqb4P+yH7rQc8u7yK
 Lg8C2lEQsJFZatl5INmaKmCPcyQMHe0FpK/TteAVA0dGNJEH7nZwWDWt8NIowAhaMOhM
 1GLeJE9uG6TPTjOsaRkxYE27AQhuY55Nh4g0Eh3N9G7CcDanRUc5U+QgF0Ge+T5zNS65
 IHCk3M5m9kIIgaCMA2PzcfWKnuqGImadSYd7bSWqI0LgRqBmcxW9jWrvgPcRXYQ0LucN
 p8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943814; x=1786548614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PoXfMDRAQIj+y4/BPWtH1Tl3SZCP6UaSej1RFcIEr2g=;
 b=FUgapa/uCiwEbsk5Q8CJIx6uYRoX61aIl1FttZSBUaUsft5GXbnWAYHVqI1Sid9hJZ
 FDxgWYT42DKuymaHLjhT2b2/1VAgpM8l5yPlJBq37ckkfeWzKB7CBcyiu2/si5DgQeZQ
 C5PjOLNo69+5L4i51vXuj6m6jtpOJELuA3ZG0RzqCgodRqW1Wq/RHLK09h8lAS7WUYy0
 zfA7ZzdONTJqsXR9gLHNT/Do4o8ZahfR8e6YOnx2COEMEsEMbrUqqYpjphBOrPVNfyUK
 /us1wwCqfEgA/N/2d4i7cyouFZ1EEC+PYsuB8OtgR2FAnWOzHShTqve8HV/yI0Qh/hsh
 StKA==
X-Gm-Message-State: AOJu0YxKBZlw/SHExQB349xvopxW+zXhcYq8Z76I75KnlKOaYssW4jFH
 DMmjKhANMq5r2lO2yfC+28hEkzf004PVEgF56PvlNzVfzUg9s/SVAid4IJ0ezerQ
X-Gm-Gg: AR+sD13Wtoi8bj63I2gs/BfWPc6NTlxFh9D6I1bYwQ1zoKU4H9X/UbrOLrlQPiTe2gO
 F0JqGZxYmTwP/doFih8DpcYW2OYMLQcobWoGmRBxC2boJ52K7+pIY1BAuQufWPhzOqQELRqeEBo
 1ILxt2iTQ3TevbaUPC+PlTM6yS3nUSeG2AhT1+scN9cAGagMuGUmo7j/2CfVCBgjOz6fz6aoeRT
 ATdFPUceihicJrZkGIGvcauFh/Ho8N/bizTEKTlJjHvuwre6xjmKc7O1evWkmBPyKey6KQA488V
 vtm+QBUqCC4E2LV7NzNhOybk7Z+xYoEjMYtNQAHbEqkPsBvP4BywEb6BtTb8ub9RRf5a2iffHSr
 UJ9IQBCXVMVIP1BXmnSfQTtqcZt4wvJBmECgep8l4R/hQI+jSG9SqbcQnROMQqV/UmMDzy+YPuC
 tF6LlNf6MwN+dFNDE1L/OKZXFxJsiPLaHv7HcjLAe+RjPcMnp7J0Bs+GeGOrHDdW5YT4imhkR4I
 olxC5nfqZC2
X-Received: by 2002:a05:6808:444c:b0:4ab:6662:4e97 with SMTP id
 5614622812f47-4afae1e8f4fmr3995544b6e.16.1785943813687; 
 Wed, 05 Aug 2026 08:30:13 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.99.9])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae75ce1bsm2185614b6e.15.2026.08.05.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:30:12 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Owen Giles <owen.giles@hpe.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Robert Elliott <elliott@hpe.com>, Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH v2 4/9] hw/misc/iotkit-secctl.c: fix AHB secure read
Date: Wed,  5 Aug 2026 10:30:00 -0500
Message-ID: <20260805153005.9989-5-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805153005.9989-1-simonxhy0404@gmail.com>
References: <20260805153005.9989-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Fix AHB secure privilege to read AHB instead of APB.

Fixes: b3717c23e1c0 ("hw/misc/iotkit-secctl: Add handling for PPCs")
Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
v1 -> v2
	Noticed this bug in the secure read function
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 54bfe1ba59..93753c2ced 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -195,7 +195,7 @@ static MemTxResult iotkit_secctl_s_read(void *opaque, hwaddr addr,
     case A_AHBSPPPCEXP1:
     case A_AHBSPPPCEXP2:
     case A_AHBSPPPCEXP3:
-        r = s->apbexp[offset_to_ppc_idx(offset)].sp;
+        r = s->ahbexp[offset_to_ppc_idx(offset)].sp;
         break;
     case A_APBSPPPC0:
     case A_APBSPPPC1:
-- 
2.53.0



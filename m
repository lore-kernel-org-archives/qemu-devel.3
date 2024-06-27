Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873D8C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMshc-0000yM-F3; Thu, 27 Jun 2024 13:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsha-0000o1-QV
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMshY-0002nx-Sh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:14:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4247f36f689so58416715e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719508467; x=1720113267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avuRrMAF6rH/sTJFTAsB7oMGZ0jZuIMfuK+mEn/O+u4=;
 b=plA0Tm00Sj5yPaM0/wcvzBXoFhqjuOK6f/MjBUFMSdZdFrOhMJ3Quy/5QErr9pLLi5
 lpkw38riTZvrqi6rjbpYDzTLNKGZ8K4TrsXuTpP9G0qg3TfPXQ2hzRC0+/489enMY3Bz
 fQ6NXrKNaaq2S5xHqDQE4jCKK+ZdQBkL2G2OWc7LTDhiYcwtVziRurhcaovA9mzLALNh
 MBWUDhT9Ai74Lf5t4pdUZtjAm5vKd0wem/kQdrwbgZ0eUuCMShFMXnXRsVYR8+JRRIR+
 xAe+ZFYfEHK7OVOcILfopCu4HFqt8bTOlQO1L+PpiQAuPES44VnEE1Dczswc1GwB/PAN
 t62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508467; x=1720113267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avuRrMAF6rH/sTJFTAsB7oMGZ0jZuIMfuK+mEn/O+u4=;
 b=fccAoFBtJSeOmRPv4ryIhR2tU+usnXTMrtsnzGDfdW0R706gxE9o3S/LeitrjbBCj4
 wytVRMIJwi+Ry5fkmqMXwPvKEsfVMukVLW3BUGduN1nr26K8plgzPYaGRse6iHEOLdhi
 JhMH/LhsvLnS3N8R5lSILvY+EniLgwVh3kbtn9QgcD5ylpO85XEb+Vig5Js85ScGKW15
 9o79QBSNs2WnlGcHKyq2E7QZc9ASMKrXJlex8d7H8TpM07FinmV9AEuncrWLU3XndC0a
 odcB9Fq2K+aJYbbZSkMuBp8prfSVb+8dRo0ubW1vqjdGFbuYxEHAsnodeu/OLcij/tz3
 67Lg==
X-Gm-Message-State: AOJu0YwFmftX+k0jKiHfR6F8VNkm+/OQRRa1IUzW+9kqFSyquY7AD9pt
 hyks9ZHTQF7Is1MXufAcm1hYHGxGHf9uQgWq5GxVovn7S35dMc4WJo4zT+Ayzm6IYRD7M9x1By2
 za6Y=
X-Google-Smtp-Source: AGHT+IFukD632jAS5C/FWo1BJTpZTyOyS5eDSMoz6WDOmt6b03ZazV4LWYdBdKmB6FrQYfuZ2hkj0g==
X-Received: by 2002:a05:600c:5d5:b0:424:a779:b5bf with SMTP id
 5b1f17b1804b1-424a779b679mr50628845e9.20.1719508467093; 
 Thu, 27 Jun 2024 10:14:27 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b098426sm770925e9.32.2024.06.27.10.14.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 10:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vincent Palatin <vpalatin@chromium.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 18/19] hw/sd/sdcard: Subtract bootarea size from blk
Date: Thu, 27 Jun 2024 19:10:58 +0200
Message-ID: <20240627171059.84349-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627171059.84349-1-philmd@linaro.org>
References: <20240627171059.84349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

The userdata size is derived from the file the user passes on the
command line, but we must take into account the boot areas.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2d49be61f6..bbf054ea1e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -804,6 +804,10 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << HWBLOCK_SHIFT;
 
+    if (sc->bootpart_offset) {
+        size -= sd_boot_capacity_bytes(sd) * 2;
+    }
+
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->state = sd_idle_state;
-- 
2.41.0



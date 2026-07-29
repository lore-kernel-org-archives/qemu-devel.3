Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32B9C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6M1-0004c5-54; Wed, 29 Jul 2026 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Lz-0004bM-Ln
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:37:55 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Ly-0001YI-BW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:37:55 -0400
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso8193035e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339473; x=1785944273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H0i9wFR+0jszuSIzriUDQZoOMEXHplug+y13hr3wwAQ=;
 b=eCmnuE/loQs30Yy5iyz/uCQUUJ/GIun6GVxzyqCSAM7CtRG2FAsQpoXQVjTuBGFsOM
 JI3Z8X3Ld5dG+9YvwTux7/ZzkOUAS+6+efIBa2mrnRnd/vJ0IGaj3aYIOE7cNp/ig69H
 mtuVGCRtiC+Yy1RiFEwpqLJMcl3bFSICMqFhGWOgHg89u0/58k63GhPlU/hyiXfdIJEb
 4Di5nxuKzakoc4ACziJqAmurRAXJjEpjBPq77Xit4sP9JIu0JgwZru9B0gKmbMbWcTzq
 eXB77I1yU95zsT3AdLIbdR0+Elfv7YLnYrKh46XAdaERY+Vi2G+eu/ERfx+WEikoCep8
 R8ew==
X-Gm-Message-State: AOJu0YzGxwZs9BPEUOM8ra0rckCLDCbU4ltQ3lSRwGpLE67JZmWCUgJR
 SCzuVVbrDtXJR0Czpi5+R3o68aKkkBNPs2pA0UuWqmyMnZFjsZXxFe8USSFSfLD0
X-Gm-Gg: AR+sD10ZcNb3ffY/HpLdjAD5bB0G9dEUHlB8D5N3Ccg7eOjylJeLTykyyZlocnIqQ88
 XUSQirwQOgxaftawMVVx3xcU+UUJdbf0/bZmwYcoUmBDN/IuMVSFPzi1B/rRvmc4E94R3VGlIuT
 86PKT/OLVNDXPqx68rSyiSKQUnlQUZpl8lrpNB67kcPmN3Zcz2IncBhOt/cqOjw64OLGy/8g7T1
 HttyPPsO5Yfp50zfW+Ztcy3X6t7REZr94eyL3xKTAwJpeEeE3Koa5ARkAI4Xzl01IASFguCDr6i
 r2Rnf7Jul0CsHCupDzRcKxj6mfWR5sWL9Xe8ZqM/n+tFBIQ6ltFoUSeqFOihaQ8HP0aHEwcDuWe
 iDSy0SUZmGbDBhJXocUgzcw5H45FfW4cBElaKY924eVgavZXMHyNPPS418NExk2yy7rjco58cyv
 18cZeEMmaUOL0Bs0lHobWurHkUJusMzY2PBuAswolHthcpfrzOdT9sEzZs6KAPrCkUuDWn91LXf
 Y0OAq9/3cv8IajujtTY5Z4/W/NZ6rUd6A7zXyLxEVaJMYI=
X-Received: by 2002:a05:600c:350e:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-496c655e6e1mr84036055e9.17.1785339472591; 
 Wed, 29 Jul 2026 08:37:52 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfc2ff2sm335559385e9.4.2026.07.29.08.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:37:52 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:50 +0200
Subject: [PATCH 14/25] hw/arm: catalina: use the real TMP75 model
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-14-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337964; l=948;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=yr6ARhHsRJdWelmON/tAwpVgyc94u96MVCdEOI7hMno=;
 b=6Lig/q7xj+IHJLXLGZFw1HA8W3BPThEM/YZac7dWZPjeFwCwzVHetNboH65BktroYWxO/s3Ev
 aN9SI7Ga8AiBfvW3WxJj86RZhkDw+G8Ek/b+IHgJmD5ZBlXgz4QpyRv
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.48; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f48.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Catalina BMC instantiates several ti,tmp75 temperature sensors. Now
that hw/sensor/tmp105.h provides a proper TMP75 model, drop the local
TYPE_TMP75 alias (and its guard) so the board instantiates the accurate
device rather than a plain TMP105.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 33e75338ef..928e140b21 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -22,12 +22,6 @@
 #define CATALINA_BMC_HW_STRAP2 0x00000800
 #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
-/*
- * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
- * defines.
- */
-#undef TYPE_TMP75
-#define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
 #define TYPE_DS1338 "ds1338"
 

-- 
2.50.1



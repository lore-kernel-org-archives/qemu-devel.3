Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3335AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0l-0005A6-Aa; Tue, 23 Apr 2024 09:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0d-00058X-Vf
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0b-0001ta-Qi
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DIuiCzMSL0+YSjMXWZ5/ZMwYhFwNNGbX4Rtfk9cIAE=;
 b=VhdNCLajRLrzzvwMGObde5wsWrJ08k51ryFq8r+K/+vSoFKFq+q0PoUnkg8iXjgsRImU2c
 P8o1Y8ngKd0HNOVWt6i9sRdry/Q31eEyGsuSXxpLNx50DGOlN9S2OqFfJjBJgjVBrxsaR+
 cdygCdo8CUzvbsActKquDg/B6Bq3GGc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-wkLUZBBnPaOVaoVrCQ2quA-1; Tue, 23 Apr 2024 09:16:27 -0400
X-MC-Unique: wkLUZBBnPaOVaoVrCQ2quA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a46852c2239so384743366b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878186; x=1714482986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DIuiCzMSL0+YSjMXWZ5/ZMwYhFwNNGbX4Rtfk9cIAE=;
 b=vCGf09Duf35SlyPAGnmmwRI6EPFIJzlvey8JYdt7OiMS0xrM80OYfpPbicj+tmhy6w
 fkC4uozavmt7D8XfTuonn813pAp53sqLLU7qv9iJRI1MYCJ62/y/Z4kTaGj5fJz2YgK6
 RNX23xHDFhPeZSrpGl69vmefVIPaYWCDexgUwIMrXQkc3MAnivBGOpM61wvYO/p3W6v4
 72cnqiYg3W2OA4727ljDaTg0SzKXxVCnRpGfUdnV7k1FzXJ8P+Vi4JXssMe6XzZSAZxn
 h/53Gz3b4sfVH+uyfmeV0FRbi6Xq/PTiRHgvtdsSVJcw/+BGX4RrqCQirNCckLpF1Ofb
 pAEg==
X-Gm-Message-State: AOJu0Yytccp3jUV/kYbMo0gA5QMLum3zzcUzYKDLDswHQNn3bfxvacu8
 /P4vU4QD6YikuQmSlXAuKcjVAxVsh9I0wmF1PsSV9XsoSPpWXc49TMydS+LMaVRlskJ3BcF8/np
 a6z8SCbTxCyCD5e1NxFKhOQbx73rDXwda5Qg4S67TgTWaqhphKc+3Cl5jsDfv/dm/NR8M+OLl2y
 KURulwlBLtMUx6RNYCCffF7arQQz7SxRKhGQ6Y
X-Received: by 2002:a17:907:940f:b0:a55:b520:768 with SMTP id
 dk15-20020a170907940f00b00a55b5200768mr5281716ejc.32.1713878185895; 
 Tue, 23 Apr 2024 06:16:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR3YaadCy5TKi4y+AYRxIUXWyVK2mlxEukfKzgvByCOnSWz7PvuE0JWYA9nC7E2vsTclxCyw==
X-Received: by 2002:a17:907:940f:b0:a55:b520:768 with SMTP id
 dk15-20020a170907940f00b00a55b5200768mr5281703ejc.32.1713878185624; 
 Tue, 23 Apr 2024 06:16:25 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a170906841800b00a5568959abdsm7052650ejx.134.2024.04.23.06.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 04/22] avr: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:54 +0200
Message-ID: <20240423131612.28362-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with AVR.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/avr-softmmu/default.mak | 5 ++---
 hw/avr/Kconfig                          | 3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/configs/devices/avr-softmmu/default.mak b/configs/devices/avr-softmmu/default.mak
index 80218add98c..4207e7b3ce2 100644
--- a/configs/devices/avr-softmmu/default.mak
+++ b/configs/devices/avr-softmmu/default.mak
@@ -1,5 +1,4 @@
 # Default configuration for avr-softmmu
 
-# Boards:
-#
-CONFIG_ARDUINO=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_ARDUINO=n
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index d31298c3cce..b29937be414 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -5,5 +5,8 @@ config AVR_ATMEGA_MCU
     select AVR_POWER
 
 config ARDUINO
+    bool
+    default y
+    depends on AVR
     select AVR_ATMEGA_MCU
     select UNIMP
-- 
2.44.0



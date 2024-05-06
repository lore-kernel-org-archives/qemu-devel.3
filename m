Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616D7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t96-0005u1-Rh; Mon, 06 May 2024 03:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8h-0005kb-28
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8f-0001bw-FI
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DIuiCzMSL0+YSjMXWZ5/ZMwYhFwNNGbX4Rtfk9cIAE=;
 b=h7R2SIuIP7KPRD1VQYhBPDVm55ysrBSFvimtD3xS11Vg6DBa3V5WeudPQzERAH7zE0t+lH
 XvAxwOwQ/6xAGrX6gifzmzG+s7j+sstZNv3t4GX55FvjFBpxydpw+QTSXu/N+fGapYqVPT
 eM6dlfoqlatJm2y4PFSvpHkGW7Heg80=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-nhjBiH54NvmhwQK1EQPWgg-1; Mon, 06 May 2024 03:51:53 -0400
X-MC-Unique: nhjBiH54NvmhwQK1EQPWgg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5202218b4d3so1324508e87.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981911; x=1715586711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DIuiCzMSL0+YSjMXWZ5/ZMwYhFwNNGbX4Rtfk9cIAE=;
 b=kXEK23mh5PqeCW2OMTBDn2IcgJ09IySD2TtnXyaHTCZhUc/pL6bwi+le8ZUptXmlSr
 FKkiYAvhWXPxnwXDHy0wxZAzWaffREVkVQfZUl8/cakz6nrlpj5xqplJNJ6ZCpNuAGEr
 8ppJChbrpBgsPDfnoXE//Bm4KSbekwXYAFAWTfYP2D9ChGAwFUN/gu6JaLVM/IZ9lIb7
 6Xgz/chqtr60i83gYMKMiJv+qNHrfiYQBuURPNdj7Bf2+MC4EMyBGHwAVkh/1rI/WcQf
 AmIKjQWW42r3XQ4x+y9E9zmS7ZNKviiBtMj5XG7i6tprLTiOxINyaybTaSqk/u3OziWD
 3/3w==
X-Gm-Message-State: AOJu0Yy5TBU9ej1KmzGfKAzTTqmkEv2MDR3AUXE9h6q/ksJ3IRalQwsX
 rXBtZMdXojLjSRkXh0SnnhWyIhostKka9IneTQKwyMtvZ0RzTKX78IflYKGUrzapZdbOXB+gNqE
 FremP7/OUnr7H0E23jxEatqy/BNOEW/XOACg8vzTkDYK4nGDJV+gH2PFoURuIb/YICDSrYe4P3h
 RC4xr/hRiQINvWCTxvEiGfwfcXLtvgRBX5jmIe
X-Received: by 2002:ac2:43a7:0:b0:51f:488d:274b with SMTP id
 t7-20020ac243a7000000b0051f488d274bmr7380948lfl.9.1714981911087; 
 Mon, 06 May 2024 00:51:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5y4XSOJBGkYbB0DiMot1XTqK1b7oEUD78cvcqzv2a/rQeyWtSA2lt8AkN3DzlmPQE22fcmA==
X-Received: by 2002:ac2:43a7:0:b0:51f:488d:274b with SMTP id
 t7-20020ac243a7000000b0051f488d274bmr7380934lfl.9.1714981910727; 
 Mon, 06 May 2024 00:51:50 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 bk1-20020a170907360100b00a59c841ebb2sm1388352ejc.201.2024.05.06.00.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/46] avr: switch boards to "default y"
Date: Mon,  6 May 2024 09:50:48 +0200
Message-ID: <20240506075125.8238-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01196C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHFT-0000z5-Ks; Mon, 14 Jul 2025 07:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1a-0001yY-2K
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1V-0002Cg-35
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ldzKRjoCTm1wE0lg8oM0P/4wDs9Nar/4X2QOq18lFU=;
 b=LbQH2YB5u/FAUZMTuHCPpOJEpMJ6Xsl2rhqa8c1oW0I+QZLkIRbduq+7WrQa63Rz9P539g
 8XspkFotNci3x9OcWbVtWuQ66ydOLDXKqpFTOtEgZOI4bHkelX0mSsRPxHP/vef1KsIY/P
 7hD8jPk+VFnA4kbluA5mMbucbe8VQ74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-xVwKxM1jNv6cc8OiwEXAlw-1; Mon, 14 Jul 2025 07:07:01 -0400
X-MC-Unique: xVwKxM1jNv6cc8OiwEXAlw-1
X-Mimecast-MFC-AGG-ID: xVwKxM1jNv6cc8OiwEXAlw_1752491220
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4538f375e86so32964175e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491219; x=1753096019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ldzKRjoCTm1wE0lg8oM0P/4wDs9Nar/4X2QOq18lFU=;
 b=gQfDsjwBS96EXeJO/jkrv4HcViS0eOP+7S+/eNDAZE3sgHZAUl08wswEowSAmm/cdD
 lDfDtr+zt38YJYvhm3HhRjfrHyYHayEP2EaSPAy1Y15j1DoNHsYJ7EDNeQ+nbqq/FPTu
 k5bLRzxRsKqg/5UFKQnaA5S23jN7DiwoL8l74t0DiAps1VPQbMruYs78+5gdayntMeRx
 JUp6prU9BHG4r17tJYtKDT7HOTAWokxx20ngGXxWy4XZ6Dnvyl4duCq6tuhXxsQPeaYq
 sXJ8lVT8XOGXIrIKceXvFwAhVyMRfOQd082QHUT5Un8L0FFf0vwp6asi0Mqluc+6ZS1c
 hrqA==
X-Gm-Message-State: AOJu0YyOfGqua54GNiHrohwkaI292Nj3WzIcVEIekPHKMwBKwSb2UmAq
 0NB2mnSWPx5HqzvNwE0O9UnW/UkBVQWVHZcC9Z8VMJxg7Va27EOUghhbj3eDIKyzEbcENvKJRIM
 DpsoJI1um1jHyPBi/rjqXtWJtiqskO1MjKxqriKWSogNs3mgCfdDTGIrLHlu9QqVyIgCK4AdVhJ
 nDi1hme2ZijPNTnci1W1bhKHPGNS4xbiQkSoWIT5gI
X-Gm-Gg: ASbGncsnu8SDUp0xBsGOgwX72wrILvVcOtstGf3Uc7hgWJRNEoNN+PjlPSgbGY28tXb
 hOUauUJRfTI8XvzCFUDeLLh2fEi0EnjafMBUK1hgMB0/4gZ/4FmKCDpQEE8sMuTjwlshOHaAM+F
 YnA4Aihek+QUEk6J0h4if5qo00dUDbx+uvnxVTjFEUX4jTrNti7UNudYwv3KhHPB3GhaRZZh2Gd
 P65+EzRzunUg1QavoQpzsd5nOfWfaiZ+ckolN1+cYl+/8l19v+t0n/t6wdsoJfmbH2YWkJ8oTBn
 WZ7jivn4ZPCGbTqF5kvmok8pGQpWNhmOjcp2DRLBS0o=
X-Received: by 2002:a05:600c:4f4d:b0:456:58e:318e with SMTP id
 5b1f17b1804b1-456058e338amr90480955e9.30.1752491218847; 
 Mon, 14 Jul 2025 04:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/kMQ9cJHtGlnnBQusmdGrUFWNteqrNl4LYe65WSNB0AykJDQ2SdQ2sH6I32ROxrynAPo+0A==
X-Received: by 2002:a05:600c:4f4d:b0:456:58e:318e with SMTP id
 5b1f17b1804b1-456058e338amr90480535e9.30.1752491218376; 
 Mon, 14 Jul 2025 04:06:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45611651008sm50979685e9.9.2025.07.14.04.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: [PULL 66/77] i386/cpu: Enable 0x1f leaf for SapphireRapids by default
Date: Mon, 14 Jul 2025 13:03:55 +0200
Message-ID: <20250714110406.117772-67-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Host SapphireRapids CPU has 0x1f leaf by default, so that enable it for
Guest CPU by default as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a11e9bb1117..216e0232df4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5081,8 +5081,12 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             },
             {
                 .version = 4,
-                .note = "with spr-sp cache model",
+                .note = "with spr-sp cache model and 0x1f leaf",
                 .cache_info = &xeon_spr_cache_info,
+                .props = (PropValue[]) {
+                    { "x-force-cpuid-0x1f", "on" },
+                    { /* end of list */ },
+                }
             },
             { /* end of list */ }
         }
-- 
2.50.0



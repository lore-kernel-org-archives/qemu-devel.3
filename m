Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D213C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2s-00030I-45; Sun, 06 Apr 2025 03:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2c-0002vM-JF
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2a-00021f-4g
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9mUqKNnCCEVE/jfFbaW+D3iZCMM8b9SL9JWkQYfv18=;
 b=Ur4zWccF5FMRIW5tD14C6d2Y4OZSBe488gVC0FL8HH7gK3eOO9Dq07hlikKVdg1O2D+RI1
 JUlN15l0nGMDeORYb+BD8c3sNXGO8pXWq8nW1uPF35rJEF1IiJrsASDfzzPg1dkrdkKh34
 d0ypV9CFjTUObcUCqRr6TagFWTPq3Sc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-bcRBIN7gN3KJcpxLWJXmpQ-1; Sun, 06 Apr 2025 03:03:30 -0400
X-MC-Unique: bcRBIN7gN3KJcpxLWJXmpQ-1
X-Mimecast-MFC-AGG-ID: bcRBIN7gN3KJcpxLWJXmpQ_1743923010
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1268690f8f.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923009; x=1744527809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9mUqKNnCCEVE/jfFbaW+D3iZCMM8b9SL9JWkQYfv18=;
 b=Zqr7NFmrGnWUpYlcsgxkGtVziMu3nnd3xLUQ9Z0JDUjsUJo+qHlVY5uTX391sUHO5g
 CAfRZtXI/FQnCP5sLbViarg9HmVulCNiKr7kpshU0LMmR+wzEIie8pbD9NtBG1aFq6xh
 fu2y6qG6xHItQ3gLz4zeeWZ1DMKTSmtlHW6JjVU2ElgGE500jNgS1do3Lb/fF0U6pANz
 2zbZgiVXnhGNvGM+l/kdriKTVrB7eTkijOE+uhAiJAwflL0I4ggkNBl731i+9IE0DfCb
 dSFUUSHY/HvQeWOL1YaGOQwI9oL5BVPUBtkwAdt8aeTAf8k7vbqXP+8bvTIv7rVeKUCd
 E/tg==
X-Gm-Message-State: AOJu0Yxm16t4w/g+dP6RhW6IZDc4pKnPxTWe9aMVPwLGXMwwv03L4l5i
 ixh889EszaDG3kOomB5+hHPp+Ak2m7gg1fWKG2lZJQxiINtRnqbhpwbaJaL9WgHBD2EUs4ecOGr
 m0xgqPDmmTYzJqA5rCazoXNrmlvFa1YYZxvWkIEwe8dBfuQUv4jscZ81rug53Bu/+rxr7xaL2Ol
 fY+WUNEfCIuqgX6uYC18byW9v5aweihmWXoF3V
X-Gm-Gg: ASbGncvcufOAFwlFmAFHrHElN5xzz2DFlo/JOFCk7EPJnkZnc3gCkC+RfRYNjHzyVkH
 kHSZF02Mqpo+W1DnuaXDTglvD0BLmew/9zutU7TxYWflWouFXW6VeoxQjXtuAqVhQVKbgEnnm1y
 vATG7i+HHF9QFb/f21siRxr+AeYQgIGdPqzAB4eU0hkU/lrR1b7BD/XH1vjjioRegCNo5507V0V
 Ed0aNpiRwfEdRuvUjkoBVQfe9v5HDwlj1IF5/b7RJtha/8Q9+I7/kifDLpCarJb8WKrfnBcmGLr
 GasQEwLn9dgt7COj+g==
X-Received: by 2002:a05:6000:2506:b0:39c:3475:b35a with SMTP id
 ffacd0b85a97d-39cba9326bamr7469609f8f.28.1743923009228; 
 Sun, 06 Apr 2025 00:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2bn465y54hUc5JqMStw3lf+ZDDj6LqDmHh+/lYka84A1BH4fwFuGIbKV2PqOG3ujGTnsMDQ==
X-Received: by 2002:a05:6000:2506:b0:39c:3475:b35a with SMTP id
 ffacd0b85a97d-39cba9326bamr7469582f8f.28.1743923008839; 
 Sun, 06 Apr 2025 00:03:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d036sm91474875e9.26.2025.04.06.00.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 12/27] target/riscv: do not make RISCVCPUConfig fields
 conditional
Date: Sun,  6 Apr 2025 09:02:39 +0200
Message-ID: <20250406070254.274797-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Avoid the need for #ifdefs in CPU declarations, keeping them
simple.  After all class_data used to be specified for all
emulators, not just system ones.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 --
 target/riscv/cpu.c                | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index ef58826b2bc..59f134a4192 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -164,9 +164,7 @@ TYPED_FIELD(uint16_t, cbom_blocksize, 0)
 TYPED_FIELD(uint16_t, cbop_blocksize, 0)
 TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 
-#ifndef CONFIG_USER_ONLY
 TYPED_FIELD(int8_t, max_satp_mode, -1)
-#endif
 
 #undef BOOL_FIELD
 #undef TYPED_FIELD
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 58cc2743a53..2c2a6a4b44a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1486,10 +1486,7 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
-
-#ifndef CONFIG_USER_ONLY
     cpu->cfg.max_satp_mode = -1;
-#endif /* CONFIG_USER_ONLY */
 }
 
 static void riscv_bare_cpu_init(Object *obj)
-- 
2.49.0



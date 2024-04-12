Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDll-0005EN-Dk; Fri, 12 Apr 2024 06:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDld-0005Cd-F3
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDlV-0001ZA-0Q
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r2BbovmUqZ6XBAj8TY6CbhKs/XGlgMyKhhvHB01jC9I=;
 b=Igka8zAgvsD4IqXiMQHbxoyx4MI8qGjW+iPBQW+zaETnQbdhuNtnVWJ4uEV3ryTeRY2Azl
 0/tuxNr1vNfhVt24KwTAfc/WkY567TXl9vZNcMP1f48dF/sMduSxGrhgyylHRD/q8vGo9T
 l9eiypEIHgC1JSEke5kMqQ/x71jQdmY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-G5ZEf8cLN62_geJ80CL2AQ-1; Fri, 12 Apr 2024 06:04:10 -0400
X-MC-Unique: G5ZEf8cLN62_geJ80CL2AQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-517866a127fso767996e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916248; x=1713521048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r2BbovmUqZ6XBAj8TY6CbhKs/XGlgMyKhhvHB01jC9I=;
 b=E1KWYkL3cltmul+hTevTGRa88ho/ewEY4V61v7qBx1l8rJyUokrS6lYHklnzGZHqL7
 Ny18yvdwjtiy2H7mPNxL7RWR9ZG4srbBz3da29IiGN4zrEXUS0WDdVXJm71T2nbZYDno
 CcRmEcHyInXhCiVVz0a3r0awP1M547e6kjkABupw1vi1cOXronV0M4oAEJ7YOAS+bYM8
 CQh5d10s98zOy4QDgVd59LxsDIUPo5ABJBlAW4OWSyQfKVP2aeKlw51DcVa+bZhqDdv9
 GPSbOsqHSJiwZDOKaU2ldVGse7TmzWsxzmg3jxz74KjIgatD6VtSebqJjDdzIpXfkckk
 EB0A==
X-Gm-Message-State: AOJu0YxYPO2o1VYmhnXY1C5r1c9TKCnG/VoGXIBi5VFCOX/GgaD+B0NT
 5OqxjcCbo6NOxp5n9LVrDQBc3CKSX4H821KETx/yoQL6deOx/MvShB3YcancEL+s6iv/EdegF/c
 DXlySId2PKG23yfPdtHCUnfRK09cqGKqcCDnVuHCIzzODuiCfCa2RlfqksRJTNf9+U53hYr68fU
 Epi2nnBwhcJn8NrOlZhuIbq6AQt96x3ASNGnhq
X-Received: by 2002:a05:6512:b94:b0:518:902d:8b98 with SMTP id
 b20-20020a0565120b9400b00518902d8b98mr736109lfv.18.1712916248339; 
 Fri, 12 Apr 2024 03:04:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRU/t4cGza1xPrVQyJrQ62s4awbiG6ha8gvL968scZzu8kkZnJWW4qVpLcdiAfR7TUv9M4Wg==
X-Received: by 2002:a05:6512:b94:b0:518:902d:8b98 with SMTP id
 b20-20020a0565120b9400b00518902d8b98mr736078lfv.18.1712916247845; 
 Fri, 12 Apr 2024 03:04:07 -0700 (PDT)
Received: from avogadro.local ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a1709064a0600b00a5209dc79c1sm1654420eju.146.2024.04.12.03.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:04:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/2] meson.build: Disable -fzero-call-used-regs on OpenBSD
Date: Fri, 12 Apr 2024 12:04:01 +0200
Message-ID: <20240412100401.20047-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412100401.20047-1-pbonzini@redhat.com>
References: <20240412100401.20047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently does not work on OpenBSD since the -fzero-call-used-regs
option that we added to meson.build recently does not work with the
"retguard" extension from OpenBSD's Clang. Thus let's disable the
-fzero-call-used-regs here until there's a better solution available.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2278
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240411120819.56417-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4b..91a0aa64c64 100644
--- a/meson.build
+++ b/meson.build
@@ -562,7 +562,11 @@ hardening_flags = [
 #
 # NB: Clang 17 is broken and SEGVs
 # https://github.com/llvm/llvm-project/issues/75168
-if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
+#
+# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
+# https://gitlab.com/qemu-project/qemu/-/issues/2278
+if host_os != 'openbsd' and \
+   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
                name: '-fzero-call-used-regs=used-gpr',
                args: ['-O2', '-fzero-call-used-regs=used-gpr'])
     hardening_flags += '-fzero-call-used-regs=used-gpr'
-- 
2.44.0



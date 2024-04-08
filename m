Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBC1C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrKN-0001ch-63; Mon, 08 Apr 2024 11:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKK-0001bv-L9
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtrKD-0001rb-P6
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 11:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712591665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeF0i7q0SM9JchJ70Oic3dnROBkXEo3V3rWVabZC2/Q=;
 b=O8bsJqVyzHQhWDB2mSQxWiB/+bCuTGnZeeC04dzvggEiuzCY9tfwG/G/SJgXZ/3sj48PaQ
 QkoT9tI9EP/9DLllz7pW224bif/Ab3Jn63Kp6bObPpc29jvdvGKqwPstBzk7IbLXYkP+E+
 7KMt3yAeXy6a5leiMN9UKM0up+sUP9c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-79GDfeVANC2dvIx1_lPyFg-1; Mon, 08 Apr 2024 11:54:23 -0400
X-MC-Unique: 79GDfeVANC2dvIx1_lPyFg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d8729a1126so22708661fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 08:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712591661; x=1713196461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeF0i7q0SM9JchJ70Oic3dnROBkXEo3V3rWVabZC2/Q=;
 b=wn8giDCEKrK1wfmJOaC4DYZV4OIkM+ZRDVxc0VpNJZqQALzJbaiJBEwpoPlrCe3hI1
 qLLuus27+ip/3SBFl0TM2CYJH6rUbw7v7veios7c6XZQsP6Leb9GJGLGtqlUNiTF/vVN
 69JvlBGnK/a2X7V5LZQNtHLa7s/I9LjpWqJgJomtqedto4z9nTnfY0+5Sx+81wzIy17w
 VPxuCuRFlWVAqW8ETBZHmilnNcezzapeH6cCCGAq6diXIVgkmydTxjMal2LHGUZ/d6TM
 se7rRNvFqQdhqFrJ3Gng451iBEhpVkRo8uoHqONA6PObijnP+zHXBgw7SjM5i2K9xlVi
 l1cA==
X-Gm-Message-State: AOJu0YytflyspZuLOw/4lfXTBhaHO/gU94acqIXTEjk2IHk0WzK3bVx/
 iAUqBSh2BNZ6vhaScaxKdB7xcNB6vvQlshVTEBDcYXG3e0fN+RMVyz8py6acuF24MVKUj6Z+Xog
 MBFMarxi0miwywIrsiWQdwNTE9A4hY1iwyOlVL6wrIsg9Bv4SD7vks787ln5TReVwrPDgThTsE6
 sF74iAy6TmtVFFk08Y3Fsm2Hab3yLvX7zyxeMm
X-Received: by 2002:a2e:7e12:0:b0:2d8:6787:eb45 with SMTP id
 z18-20020a2e7e12000000b002d86787eb45mr5412161ljc.25.1712591661056; 
 Mon, 08 Apr 2024 08:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIo+Y27WDuwjl3tYOc5fyfTjhuuYo0nwCZpQebjSkF13C0J3K2UClBQsL8uHzwiVF2dUWSpw==
X-Received: by 2002:a2e:7e12:0:b0:2d8:6787:eb45 with SMTP id
 z18-20020a2e7e12000000b002d86787eb45mr5412147ljc.25.1712591660688; 
 Mon, 08 Apr 2024 08:54:20 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adfe9c5000000b00344a8f9cf18sm6660956wrn.7.2024.04.08.08.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 08:54:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 16/18] stubs: split record/replay stubs further
Date: Mon,  8 Apr 2024 17:53:28 +0200
Message-ID: <20240408155330.522792-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408155330.522792-1-pbonzini@redhat.com>
References: <20240408155330.522792-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

replay.c symbols are only needed by user mode emulation, with the
exception of replay_mode that is needed by both user mode emulation
(by way of qemu_guest_getrandom) and block layer tools (by way of
util/qemu-timer.c).

Since it is needed by libqemuutil rather than specific files that
are part of the tools and emulators, split the replay_mode stub
into its own file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/replay-mode.c | 4 ++++
 stubs/replay.c      | 2 --
 stubs/meson.build   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 stubs/replay-mode.c

diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
new file mode 100644
index 00000000000..264be9d96c9
--- /dev/null
+++ b/stubs/replay-mode.c
@@ -0,0 +1,4 @@
+#include "qemu/osdep.h"
+#include "sysemu/replay.h"
+
+ReplayMode replay_mode;
diff --git a/stubs/replay.c b/stubs/replay.c
index 42c92e4acb8..b4dd6a566e8 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -1,8 +1,6 @@
 #include "qemu/osdep.h"
 #include "exec/replay-core.h"
 
-ReplayMode replay_mode;
-
 void replay_finish(void)
 {
 }
diff --git a/stubs/meson.build b/stubs/meson.build
index a252bffad00..4a524f5816b 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -36,6 +36,7 @@ stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
 stub_ss.add(files('replay.c'))
+stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('sysbus.c'))
 stub_ss.add(files('target-get-monitor-def.c'))
-- 
2.44.0



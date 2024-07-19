Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100AC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 13:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUnzi-00087c-LP; Fri, 19 Jul 2024 09:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sUnzh-00085w-2i
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sUnzf-0003Yh-6z
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721396993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NzpP5zxi/dF3488FKEyR86bHqqfJr7CcoP3BrHPIZ5Y=;
 b=d025E41uUutIL5v8L9rlw/VysdX0X/UnEbJrTMV/YjVUGd98RYCxekA8bBIy/JFwl5iFGf
 QpZU1SS1lrZjqIkhfprIs7YWW2mopuNWlYdsV6lY6nxbegiE8nFppA3fvTQNPg8f9xG16A
 iUJBvL4vkLSU1rZRixaGa8yUShsT4Pw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-abTDM1-QOR-tsZHBG4iEqg-1; Fri, 19 Jul 2024 09:49:51 -0400
X-MC-Unique: abTDM1-QOR-tsZHBG4iEqg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-72c1d0fafb3so1514252a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 06:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721396990; x=1722001790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzpP5zxi/dF3488FKEyR86bHqqfJr7CcoP3BrHPIZ5Y=;
 b=eLW6cXjoFsdV/tths54aUFKZjAewTmGJxjMuTDkXhRerBZnCDfgFMmzwoMbns/wSi6
 eA1iM5P1X7gfC1mj1Ec1pED3XoYS2DDQyJ+n2reAO6BZFyoVNXNJ1OKRRHqyCw1b1Oye
 s5caqK1qzJPhbWoKYNvutOa9jBtGSowDN+mjF3KxYXNL6BTg+V0jwUmKkhjmCmV8jLgV
 Mpd130T5/HGgpmUTCJGRQKHokd76vz0edZyss8i+bFgeh0dmIaJeOvfMsf7+sG3ixtMf
 rpnobPawGDqOm34191dcI3Qyt6Rs4rJGyEOzfdcRmUqAuFBh+3hBd2uBjrALMGcgLlip
 kRxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVON/OHs/bTUJ1KoRFrfGNJRbsu46eXY6am/Mfweel8giA43/dX6Vdf1330zJgF/sdEsxsw8DkRN59SuXUT4vOb08bYr8Q=
X-Gm-Message-State: AOJu0YwyQ5wm3xDVlhmkXmqVwoHpW5PDrJrLyPo4D6bMA0y5/QESewuc
 TSDASrWXmr8E2X+f2TyLDE2iRU71Z9+ZT/SZRKt4dIP0JlAIvLEd3RBfUx3PC9S2z8fsJeIbMqc
 Hjd5RXvVcax9ZSKERBrOMaGiztKlakKCouV2FpPWR1uY7DfEuRzyK
X-Received: by 2002:a05:6a21:9986:b0:1c3:b2b3:442d with SMTP id
 adf61e73a8af0-1c3fdd3082fmr9450891637.40.1721396990438; 
 Fri, 19 Jul 2024 06:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo7ESVjai3vPwUqiXQxgtlNgRx0TFEoSnrj1a3SD+Rsx0zv4co4zEE+izm551vwVNo7gL7Rw==
X-Received: by 2002:a05:6a21:9986:b0:1c3:b2b3:442d with SMTP id
 adf61e73a8af0-1c3fdd3082fmr9450865637.40.1721396989987; 
 Fri, 19 Jul 2024 06:49:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.152.71])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1fd6f45cfe8sm4737825ad.249.2024.07.19.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 06:49:49 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/x86: add a couple of comments explaining how the kernel
 image is parsed
Date: Fri, 19 Jul 2024 19:19:37 +0530
Message-ID: <20240719134937.3643-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cosmetic: add comments in x86_load_linux() pointing to the kernel documentation
so that users can better understand the code.

CC: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/x86-common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index c0c66a0eb5..992ea1f25e 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -665,8 +665,11 @@ void x86_load_linux(X86MachineState *x86ms,
         exit(1);
     }
 
-    /* kernel protocol version */
-    if (ldl_p(header + 0x202) == 0x53726448) {
+    /*
+     * kernel protocol version.
+     * Please see https://www.kernel.org/doc/Documentation/x86/boot.txt
+     */
+    if (ldl_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
         protocol = lduw_p(header + 0x206);
     } else {
         /*
-- 
2.45.2



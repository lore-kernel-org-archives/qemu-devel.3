Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD23C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKyT-00083Q-EZ; Mon, 18 Mar 2024 17:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyS-000839-Bu
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyP-0008D1-V1
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710799008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNPPEhUqNxc++TdG1DRwfNWJJ5hRnAz956SbDwj5H6w=;
 b=gscntFD+xomgQrPRGbI+7X4qLFkvNh+dNAjJ3Kgwb2KxpI9UYPOGmwOFvHvzjBiHFr9zq2
 HSByQSzUvWO8pdIEnveO1H5SHt8LE/VYFc39EFGk76h2eyc/yL/fjQXqRCXxA8TL+uDm/D
 35BV1V3GCOrmtOzggJR0ouD0y0VsR6o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-pqyYP6A2MuWBiwNHk31ywA-1; Mon, 18 Mar 2024 17:56:47 -0400
X-MC-Unique: pqyYP6A2MuWBiwNHk31ywA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d4af32be9fso12357581fa.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710799004; x=1711403804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNPPEhUqNxc++TdG1DRwfNWJJ5hRnAz956SbDwj5H6w=;
 b=PFMUYakUNzudt8ZO4gQXOhMd84Kdg1nFTfFjKvbEZhetV0cRiNWpWRUoDwXGggXkAJ
 yqyMrrqPDZV0CeSspF/f+z7fVOIJs3D49meV6Jv3MoPfT0hSh1Ek3MvZsxY70Nw2RUrL
 /kFNQCSvo8oUScplKGvBWq41+GkUTbZhjPdo0nzDpGJbpSY40qncSMEXWycWtn8VrCJb
 WlP3wfeEocQDHXkCQ78j2Ea8CPCH8QbyAjFcbybj74NbmdIS0Hiv529rV1+F2zLq/TtD
 cZAIRTXQ2LUVQg+BsvNtkHZUkNZtLnUdA1tl8cH2qcjpsffsCy9qBckvnb/21hf3Eenq
 tDiw==
X-Gm-Message-State: AOJu0YzAtAvsEDErDAHoshoCgf5nXXdetHzw3/QEN2aWy5O0aMN6w0Hg
 GHFTJWxkmOovJCN777uww+ACcJbfjfCcwPh+eN/jc4cUMPhzuJXpLOuu9SrCycv8FMnKo2MH75U
 tj0t8m1o7C47kGNn2guz21Oop4itM0y7+wkdx0Aovlv3K/Mh/9ReyZzFZWt0C/q20eiSZN8kuYP
 fYNZpRN1aMERjimOMbvgRDJjLxdisoJIFwpioK
X-Received: by 2002:a2e:8518:0:b0:2d4:764f:87ea with SMTP id
 j24-20020a2e8518000000b002d4764f87eamr538475lji.34.1710799004087; 
 Mon, 18 Mar 2024 14:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoIAQ+CuS1p8W1inemfwajWwojkk43ajj6PFNvreaEW06qZqhx7MNrAKw1wMYtdrIli4TjjA==
X-Received: by 2002:a2e:8518:0:b0:2d4:764f:87ea with SMTP id
 j24-20020a2e8518000000b002d4764f87eamr538467lji.34.1710799003602; 
 Mon, 18 Mar 2024 14:56:43 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 dn16-20020a05640222f000b005645961ad39sm5080274edb.47.2024.03.18.14.56.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 14:56:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] vl: convert qemu_machine_creation_done() to Error **
Date: Mon, 18 Mar 2024 22:56:40 +0100
Message-ID: <20240318215641.978308-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318215641.978308-1-pbonzini@redhat.com>
References: <20240318215641.978308-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow using Error ** to pass an error string up to qmp_x_exit_preconfig()
and possibly main().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/vl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 70f4cece7f9..0c970cf0203 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2653,7 +2653,7 @@ static void qemu_create_cli_devices(void)
     rom_reset_order_override();
 }
 
-static void qemu_machine_creation_done(void)
+static bool qemu_machine_creation_done(Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
 
@@ -2684,7 +2684,8 @@ static void qemu_machine_creation_done(void)
     }
 
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-        exit(1);
+        error_setg(errp, "could not start gdbserver");
+        return false;
     }
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
@@ -2692,6 +2693,7 @@ static void qemu_machine_creation_done(void)
                     "type does not use that option; "
                     "No VGA device has been created");
     }
+    return true;
 }
 
 void qmp_x_exit_preconfig(Error **errp)
@@ -2703,7 +2705,9 @@ void qmp_x_exit_preconfig(Error **errp)
 
     qemu_init_board();
     qemu_create_cli_devices();
-    qemu_machine_creation_done();
+    if (!qemu_machine_creation_done(errp)) {
+        return;
+    }
 
     if (loadvm) {
         RunState state = autostart ? RUN_STATE_RUNNING : runstate_get();
-- 
2.44.0



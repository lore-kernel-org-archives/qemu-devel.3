Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKyW-00084C-6R; Mon, 18 Mar 2024 17:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyT-00083f-SJ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmKyS-0008D8-FB
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710799010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlEJBT2gp4bGZ2HK1o00F2WSlkkp6bVIhmUBdGTu8YA=;
 b=iEIqCZ0r8EFZ6dMbwc8Lmx9Rm5F538LhaXfNSjaPf4RINNV30j5dxJcgSzSwKCtcIzg016
 6xnRtu8qWHOzbr9K7/HxzJSwl4qWdYWQvegVXfr+E87lQsUYCIzIlbWBQVaFojndyNqgHB
 8xY41yhtIh0tK/dKrCVLYwXIL21WjGU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-1XYr8a9fOKS5x4gP1x9akA-1; Mon, 18 Mar 2024 17:56:49 -0400
X-MC-Unique: 1XYr8a9fOKS5x4gP1x9akA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a35ef7abe08so214556366b.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710799007; x=1711403807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlEJBT2gp4bGZ2HK1o00F2WSlkkp6bVIhmUBdGTu8YA=;
 b=kpXGS7VXiyd9uqJHQI5aSwWazmsyOAUabyK9BN9MxnedQ4prukrotzmB6Z9UwxJOyk
 dU3kpa1X9JKIz7+GHq1/mGeZd4yvtHnJbq5y6dWYKoJNb/azomvgPCEaStQA5PySUvd3
 D+AMP3ewv9b9oP32zSOO2M7pzmRdt/2kMmVcufBimyze1xiPHgqmNZolBoYxps2Flch6
 hB7f+LwC1a1BeJO9wTiDU6H5vvHdaIInVvvVPAKWuKQHTLBlaNR2VU+2w2iRJhAuOGaF
 jiN9FfBDKp3YGHLpi8NMfKlWwe3W404wQcSlFCVivsSOqShQOET4EF9nnx9NarTkJHeM
 ZZ9w==
X-Gm-Message-State: AOJu0YyWgC7nVn3TcExBytJj47sP5uA7Ht3PetRKk8WVG1dHvWwjyn71
 7EbC+f3M2ZQ83Cg1skUjPk5aV+OvsnD68Fan1rRm6eol9IinkdjJK0/miu8MBY2JFadHiOnvNfo
 z52PONlGkOgLS+cvo9JgEqvxvrL1/pRKDFcHna6qVE43Pf+9IRCBwkM0+PyqpB3raHkUrlzZLG+
 B4+q1eq25AT23qGN8+IAMGUeyUUcfIRsuosUn1
X-Received: by 2002:a17:906:6958:b0:a46:7794:2c00 with SMTP id
 c24-20020a170906695800b00a4677942c00mr393799ejs.40.1710799007242; 
 Mon, 18 Mar 2024 14:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIPW4rCF4aPootATgErChZD+CV13lGc12JpTMgNWBnGbpL5q9p4DbwJT3zAdW55GNwA1OZnA==
X-Received: by 2002:a17:906:6958:b0:a46:7794:2c00 with SMTP id
 c24-20020a170906695800b00a4677942c00mr393789ejs.40.1710799006915; 
 Mon, 18 Mar 2024 14:56:46 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a17090728c600b00a465a012cf1sm5344926ejc.18.2024.03.18.14.56.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 14:56:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vl: do not assert if sev-guest is used together with TCG
Date: Mon, 18 Mar 2024 22:56:41 +0100
Message-ID: <20240318215641.978308-3-pbonzini@redhat.com>
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

cgs->ready can be false if the accelerator does not look at
current_machine->cgs altogether.

Assume that the lack of initialization is due to this, and
report a nicer error instead of an assertion failure:

    $ qemu-system-x86_64 -object sev-guest,id=sev0,policy=0x5,id=sev0,cbitpos=51,reduced-phys-bits=1 -M confidential-guest-support=sev0
    qemu-system-x86_64: ../softmmu/vl.c:2619: qemu_machine_creation_done: Assertion `machine->cgs->ready' failed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/vl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0c970cf0203..c6442229824 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2676,11 +2676,10 @@ static bool qemu_machine_creation_done(Error **errp)
 
     qdev_machine_creation_done();
 
-    if (machine->cgs) {
-        /*
-         * Verify that Confidential Guest Support has actually been initialized
-         */
-        assert(machine->cgs->ready);
+    if (machine->cgs && !machine->cgs->ready) {
+        error_setg(errp, "accelerator does not support confidential guest %s",
+                   object_get_typename(OBJECT(machine->cgs)));
+        exit(1);
     }
 
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-- 
2.44.0



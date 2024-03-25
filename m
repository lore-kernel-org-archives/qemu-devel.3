Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9F7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohpL-0004OY-AI; Mon, 25 Mar 2024 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohpJ-0004NH-2D
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rohpH-0000vf-95
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711363508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vu6bu/cBzM5ycpxKU3jkLgHIN63prwcYZdEuvk2zFe0=;
 b=GmcucMr2NO4wPT+ihOunbNrGKkDwzRAsvf7hbD1N3/Li92KbQFp/HRBschd+ux3RuXYodW
 Wg/stVv4fB22laFlntiSHnpEyCTsOH0pDTfh9VbsNAaB6pub5vZTFgaVNc2shN8kYf4WOt
 dm8rnR+Ss0NZlUVhyl7SRIt33ZGTMGU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-YHY64TsvMMa-2soo7qov1Q-1; Mon, 25 Mar 2024 06:45:06 -0400
X-MC-Unique: YHY64TsvMMa-2soo7qov1Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a466d8ad648so263737966b.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711363504; x=1711968304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vu6bu/cBzM5ycpxKU3jkLgHIN63prwcYZdEuvk2zFe0=;
 b=Jsgt7Z5I+Rwg1gvj4ImOclUUzTmKkrM6qHyzKzNe8KjVP3bBWO/20qA3qe5NWv8eic
 KdlwI2ny9MVHUXpeNrd2i2m/hpCtm5wD9HzSNA4FRmCCtMVoyDx0QlxDxgfiC/TOTtQV
 xqL3VmL/QNEEOOzBrF411Nrpt0ZL/DGFAzvDH+TTMYCl1LrVxD0cqPOzc14VFYlYOgD1
 oFlJ6yI626CmlyA8DDfUsOYPI9ahLEbg7SG9mudND0mpTSOiml1hRMTohwzFrHqCjiom
 lg6qoSMsCqOCWeAmTqOzS6zERE1fkBl4Bdls2fqe3UmqS3tN5/EX2bt8HI1mNlp170hF
 qjSg==
X-Gm-Message-State: AOJu0YwXL3dcSBOxWHPk+4LLizHaPr31FWZM3kMpRBn2Xu9yRq4Z3ilA
 UaL5r0aX8w0nKQrCBC6OcTOFS/K6btkXHhAwNrCiWUgoPheQvZtjo9iNj6gSDu+MPRknLqqp2z5
 E/+J3/Etph8u4/YgWjMZraJBvHsZzaQbgQfc3FbPpA7A+kIlAjwvzZ6dy3GH6suQd2IgAAgISt+
 gzUfOupymGFeEzwVe5jhm2HCQdLoUX+4FHFVf6
X-Received: by 2002:a17:906:6958:b0:a46:30f4:6321 with SMTP id
 c24-20020a170906695800b00a4630f46321mr4803373ejs.58.1711363504137; 
 Mon, 25 Mar 2024 03:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlGhyHbrD4DAzmAahzYo9CJvzNhFTBmwRzcr9JMHtcR59t1CEX0IzMiFtjWJ0clb6X3uCR+Q==
X-Received: by 2002:a17:906:6958:b0:a46:30f4:6321 with SMTP id
 c24-20020a170906695800b00a4630f46321mr4803359ejs.58.1711363503702; 
 Mon, 25 Mar 2024 03:45:03 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a1709067c8200b00a4720ce2e75sm2892787ejo.129.2024.03.25.03.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 03:45:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qapi: document leftover members in qapi/run-state.json
Date: Mon, 25 Mar 2024 11:45:02 +0100
Message-ID: <20240325104502.1358693-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/run-state.json | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 789fc34559a..cb4a2b43293 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -377,9 +377,17 @@
 ##
 # @watchdog-set-action:
 #
-# Set watchdog action
+# Set watchdog action.
+#
+# @action: @WatchdogAction action taken when watchdog timer expires.
 #
 # Since: 2.11
+#
+# Example:
+#
+#     -> { "execute": "watchdog-set-action",
+#          "arguments": { "action": "inject-nmi" } }
+#     <- { "return": {} }
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
 
@@ -505,6 +513,22 @@
 #
 # Hyper-V specific guest panic information (HV crash MSRs)
 #
+# @arg1: for Windows, STOP code for the guest crash.  For Linux,
+#        an error code.
+#
+# @arg2: for Windows, first argument of the STOP.  For Linux, the
+#        guest OS id, which has the kernel version in bits 16-47
+#        and 0x8100 in bits 48-63.
+#
+# @arg3: for Windows, second argument of the STOP.  For Linux, the
+#        program counter of the guest.
+#
+# @arg4: for Windows, third argument of the STOP.  For Linux, the
+#        RAX register (x86) or the stack pointer (aarch64) of the guest.
+#
+# @arg5: for Windows, fourth argument of the STOP.  For x86 Linux, the
+#        stack pointer of the guest.
+#
 # Since: 2.9
 ##
 {'struct': 'GuestPanicInformationHyperV',
-- 
2.44.0



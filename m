Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D06FD3747
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 12:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDlq-0006zQ-Jy; Wed, 25 Feb 2026 07:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDlo-0006z1-E2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:36 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dahamilt0@gmail.com>)
 id 1vvDlm-0005VT-Rj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 07:13:35 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-896fcfc591eso62681656d6.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 04:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772021613; x=1772626413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5k80c5uMdmECrg+f/PQP3/IGIvO7OS6HPP5VRWX8j88=;
 b=mDvG3yQ0reKTIQP/GClKswEbOUa+2G8TNOSqldRRPjkiFV1zk/NmpdwtDmFPWe3gzK
 J251w8/k15MBh9flATVfXP+ubmZs01aMU8w9dqUlH9DZLRleZxzBz6QBBSgGm37/2cmU
 WJPBoE1nvgq/iY/GfawxYjfLQIuZ+ZGI/wSMCKPB8T4OlhXPDjIq/MKqqV99gW/StfT2
 X1x4vmGFAImjrzXh8G3OcH4pXhdbGwHnIbO1ImWpqGXNAloz6Ii3VQYc3Nouuh3WhqY8
 gOGKeha1XvMJzCWOLBADQz+ERTMp+516gKlTHtV35zqS10sLXHmLV7jnUtXs46yH9VWs
 7ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021613; x=1772626413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5k80c5uMdmECrg+f/PQP3/IGIvO7OS6HPP5VRWX8j88=;
 b=kMgr+1xdE7f+AKEJ+MybrWw1GgnQGE0Iseimid4UoQuaU2axE0qnk3DZYJx+s+t5Y1
 CjKs4ifhHPNJpI4E48YUIiLy76px3sq2p/FcVtRzlfTdzs39wD9jmLgCE3KKHwceoTGi
 v5iGJJIir8p6S6xGxMbWV0pA/oZ0W1DP8GzXAjY/Kadv5wn83IAMAXblGFWNpmL5Wq9f
 Aycvua5/4xchAFX/3VG6nYpYnbQfKxNjle3kYocvbvFezHkn4HTnGrVRFmLg0JwSISKc
 GclyKkDZjtanNsZjlcgpufkXYUsQNUE6sqGX+J84NRa4JMsM3g8yvydiwmNVjhVit86x
 QJcQ==
X-Gm-Message-State: AOJu0YzUAN4PfT6QW//quuu57veJidCVvpbGuYXb6BcUh5VtUnFC7vtv
 dj4TLm7WGc0ajWsT6YILlKdKSbOladufXUxkYRJu4FimxIgG3a3uorICXxfrlQ==
X-Gm-Gg: ATEYQzyohCzFYaHLlsFS+0OEI56QS49IcHCrwHT+iST0BCYfPLFMyVsfxA8RyHmZYoE
 GTchgFK+u1kkbY4GL/L+eM8lY+ETEr+30zSCmW/1diCGn+43xBsdn20Pcmq1DoFXA7LwWPgM1kR
 d+yxal9tNp26xFhhSRwcsBmJQ9FMGfsFA6bjgSEWGV3dbzr95gkndaBLY+Dd0dKPliz1REP03ya
 5BdQlYpD04rryz4Hs9kgL2TiLoz5JIR8Qgk8cop5KVVBkxUOqFMp3vXQqE8Kr5ga0a2KA4glrEp
 7Omxe/KcTCsbVZ5dkUdSFDDR8nTBUIa4m99m24L9XqN88FWnUHuW5Hxop9Ni/FQHZjyU+Dth+vn
 NsfUTDMu8M4FrnTddlvCMaoPaJFvAeqUc7k6OtNvMboncDVlAxWcpahK1xhVWNA8duphYrbVyhi
 r6BnewXIUErCx20gLHFoUoz6jQS3QduiVm994w9FZ7+2V5QtN+JvS4fwvmTT2wvQ==
X-Received: by 2002:a05:6214:5083:b0:896:fe42:e897 with SMTP id
 6a1803df08f44-89979f75ccdmr218666976d6.67.1772021613413; 
 Wed, 25 Feb 2026 04:13:33 -0800 (PST)
Received: from localhost.localdomain ([207.98.184.46])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e77aedasm115830606d6.53.2026.02.25.04.13.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 04:13:33 -0800 (PST)
From: David Hamilton <dahamilt0@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hamilton <dahamilt0@gmail.com>
Subject: [PATCH v2 2/2] hw/misc/ivshmem-pci: Check error after
 setup_interrupt() in process_msg_connect()
Date: Wed, 25 Feb 2026 07:13:23 -0500
Message-ID: <20260225121323.5395-3-dahamilt0@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225121323.5395-1-dahamilt0@gmail.com>
References: <20260225121323.5395-1-dahamilt0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=dahamilt0@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

setup_interrupt() can fail and report via errp, but
process_msg_connect() was ignoring the error and continuing
to ivshmem_add_eventfd(). Check the bool return to avoid
operating on a vector whose interrupt setup failed.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
---
 hw/misc/ivshmem-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index c987eebb98..f1262fa5f7 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -553,8 +553,9 @@ static void process_msg_connect(IVShmemState *s, uint16_t posn, int fd,
     }
 
     if (posn == s->vm_id) {
-        setup_interrupt(s, vector, errp);
-        /* TODO do we need to handle the error? */
+        if (!setup_interrupt(s, vector, errp)) {
+            return;
+        }
     }
 
     if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD)) {
-- 
2.50.1 (Apple Git-155)



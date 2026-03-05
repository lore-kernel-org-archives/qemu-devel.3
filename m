Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258C7F3D315
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBCY-0002ty-8I; Thu, 05 Mar 2026 11:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sampaQcKCv4vklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com>)
 id 1vyBCV-0002rN-TK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:24 -0500
Received: from mail-yx1-xb14a.google.com ([2607:f8b0:4864:20::b14a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sampaQcKCv4vklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com>)
 id 1vyBCL-0002Zm-KM
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:17 -0500
Received: by mail-yx1-xb14a.google.com with SMTP id
 956f58d0204a3-649f0d26e5eso11042825d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772726706; x=1773331506; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rmz6hcKCoQK2IWrB3YiSRHYszKxMw9qvE6cNbjLHzdA=;
 b=krMUfyHDA/lH7we7lIY7Eg3uzZ3/cG8/tdYRElY0BG6rees+9B/2XRv7IvmRfQaEv8
 13JWKBvnA/t+j1Ptch3G8qEx1NbUC+6hZDJH+0lR4ig03jP7wp5MBF0F7Du4ua4FiIN6
 GnLNdyY7WshhKICLaaYa8Pyfgyocqp28fI4ugI+tECzZpXn0UMCsxxWZ7gEYe7V3JhWs
 dgEMItv9o93q1OCfs/TU6DJ3XqCLdo7xhDZaPYlW0O6ZeezKMapPDzo2p9catROM/U66
 NJXBugk2ZqntGmrDpjr5miNBlmru4Bh5w47cm3ncpepO0II6WZQiBRVlZmjYb+snUbt8
 JV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726706; x=1773331506;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rmz6hcKCoQK2IWrB3YiSRHYszKxMw9qvE6cNbjLHzdA=;
 b=nuHHhyBBiLeNHeDnKmFSHDrbV1cjRPplCIWR0uX4k9/px5VEgPee5gr0oIpFS8BLlf
 LkbsBcRTzmjOyQEF96y9XMkk/gUm7EkntvNGnDff3ikfoSiv++LwO01LIkeQK9O05WeS
 hfgo2myvIRJGBlbq/iPlZU5aztI/CtwyRgmFly30/MSIgV1GqjN7+kyxY01RtYPFc96D
 NsrLzZfieXx7Ajl8+Y8n8LNNh/0/z/V5/+zXAyjlXiDEYi+HMbGNd4UmSXdfhaIUE64K
 FPr+FSNWDYSLm4r8fFwQVcuD+CPy2L+Qmx5mirJG+MW74eKv3fLIHfTXlVvdjYXObXP3
 lVYw==
X-Gm-Message-State: AOJu0YxO22Htg9anTQD1yXl26BEswkARQpK5f/oI+MfLLJI4mf2jZyw/
 jU9RUb31nM1kgk1adRrdsls7svT3LcrhKIvx8KqHndPVcYz3VLJjiD66IiKSu0uU3V7HEN58Iy0
 VT00yj6rYdBqXG/LaFM1yFtUvhyk/+NUEscyi4U47zlbBFVIYjLhfZwCw/FXLBzO4mXm6UHyT8z
 RMoPD/Csl0XiyOnSPB0d56835+I9NTxRgFKBuDxVrm
X-Received: from yxdv8.prod.google.com ([2002:a05:690e:448:b0:64c:9860:71ef])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4086:b0:64c:a7d9:e1dc
 with SMTP id 956f58d0204a3-64cf9b27c92mr4799256d50.4.1772726705239; Thu, 05
 Mar 2026 08:05:05 -0800 (PST)
Date: Thu, 05 Mar 2026 11:04:57 -0500
In-Reply-To: <20260305-passt-v2-0-f0582198afc0@google.com>
Mime-Version: 1.0
References: <20260305-passt-v2-0-f0582198afc0@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-passt-v2-2-f0582198afc0@google.com>
Subject: [PATCH v2 2/2] Don't try to read the pidfile if passt got a signal
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b14a;
 envelope-from=3sampaQcKCv4vklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com;
 helo=mail-yx1-xb14a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

g_subprocess_get_if_exited returns false if passt was killed by a signal, so we fall through to trying to read the pidfile.

Update the error when passt exits to include the exit code.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Peter Foley <pefoley@google.com>
---
 net/passt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index b3d4b71314..4ff94ee509 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -270,8 +270,17 @@ static int net_passt_start_daemon(NetPasstState *s, int sock, Error **errp)
         return -1;
     }
 
-    if (g_subprocess_get_if_exited(daemon) &&
-        g_subprocess_get_exit_status(daemon)) {
+    if (g_subprocess_get_if_exited(daemon)) {
+        gint status = g_subprocess_get_exit_status(daemon);
+        if (status) {
+            error_setg(errp, "Passt exited with code %d", status);
+            return -1;
+        }
+    }
+
+    if (g_subprocess_get_if_signaled(daemon)) {
+        error_setg(errp, "Passt killed with signal %d",
+                   g_subprocess_get_term_sig(daemon));
         return -1;
     }
 

-- 
2.53.0.473.g4a7958ca14-goog



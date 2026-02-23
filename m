Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEB5EEC299
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudr6-0003Hs-Vw; Mon, 23 Feb 2026 16:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JMycaQcKCoMwlmvsl5nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--pefoley.bounces.google.com>)
 id 1vudr6-0003HS-2R
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:40 -0500
Received: from mail-yx1-xb149.google.com ([2607:f8b0:4864:20::b149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JMycaQcKCoMwlmvsl5nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--pefoley.bounces.google.com>)
 id 1vudr4-000138-OO
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:39 -0500
Received: by mail-yx1-xb149.google.com with SMTP id
 956f58d0204a3-64c98481d1eso1178788d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771883557; x=1772488357; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=lgAJpfn5j58COsJrDstrt2K24M7TO3WOwb+h1bXRCsg=;
 b=mmuOLPgC5ekDag6CH3o5myJ/YEWxgJSmEDGdL4g7bU4A6GCfhidUl3lgoeoXtCCCJE
 X+GStEjBCPHYOV9314gxu5iv5ai7KAUahBd+Jvgx5ugVvZNiCZ1f9p86kvxMHYeCLMUj
 laS5XSZjG+L9fXhd00r05yH8zx6dhuoL7rb+L0/YMjwiOWx4X5vwW/5eJGd1SEy0SGaW
 eMKoLkSZRD/QNreUFAKjvTqyOQI59UUK1tyqzKsB/ExFfEkmkGb/chjNLC/NG781reDO
 SFzwBb7BTu4Dwq+W1Q+k7YgS5aTUeGp70jT+HLLpPBbxWIy2ce4EX/87KC0mrmPjbTMD
 tOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771883557; x=1772488357;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgAJpfn5j58COsJrDstrt2K24M7TO3WOwb+h1bXRCsg=;
 b=iOeKSUJ5sWVIzIlAw7MUNf1pbONSMMYahV2PHVXjWQRTKAXygWMd+oLdebb3rbYCZU
 qyr5j9+NqTXM67AMHqfA6qE1heoRY0RMriHoyiBrNugC3fhf9aXDExukmjdxmJZlFq2a
 oCxGL+pmkY/P07jcDsxRfXqis11nkhsWQYe/19jK5+9BnVOUx/ypmCGtHC/ADvWjcT4C
 RNHCCYSgdwWgDQJibs6bEENW7Sds80njWK4bXK1QXmHReswceViA3H8ecBM7c+0E5591
 89UPWQ3UY25xgU7z8LngGmir0sKgRmhdeGI1yaj67alpy5Xs/C4oColDnOTTsyWzrN+n
 go+Q==
X-Gm-Message-State: AOJu0YxT9CiCruavuistFiK9AKf9BpQ8K1xUDdTNP+Y83cqb+Kj/ipOH
 DrpPj2x928+ZBEJTHkieMqOuv262oJt7LkL6PMZ3v0YLZuB1MS5Fs8iEhQilfa+lM9zpflZt+o7
 Kjck3u9dBeoUO1YoRrtq4sC5g2HPm7IZdmEd321m1aVyR54/J+IVnqyGl0YWdMmKjalN+waXfMB
 5Quq0LsWWu+DMVPXlY6xI2UNZai/aUjN08rFTn009n
X-Received: from yxn3.prod.google.com ([2002:a05:690e:83:b0:64a:d018:2e1c])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:d56:b0:64a:f0cd:d41
 with SMTP id 956f58d0204a3-64c7906b06dmr8208121d50.87.1771883556878; Mon, 23
 Feb 2026 13:52:36 -0800 (PST)
Date: Mon, 23 Feb 2026 16:52:25 -0500
In-Reply-To: <20260223-passt-v1-0-101c6ba1c88a@google.com>
Mime-Version: 1.0
References: <20260223-passt-v1-0-101c6ba1c88a@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260223-passt-v1-2-101c6ba1c88a@google.com>
Subject: [PATCH 2/2] Don't try to read the pidfile if passt got a signal
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b149;
 envelope-from=3JMycaQcKCoMwlmvsl5nvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--pefoley.bounces.google.com;
 helo=mail-yx1-xb149.google.com
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

Signed-off-by: Peter Foley <pefoley@google.com>
---
 net/passt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/passt.c b/net/passt.c
index b3d4b71314..053c2f5f57 100644
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
+      }
+    }
+
+    if (g_subprocess_get_if_signaled(daemon)) {
+        error_setg(errp, "Passt killed with signal %d",
+                   g_subprocess_get_term_sig(daemon));
         return -1;
     }
 

-- 
2.53.0.371.g1d285c8824-goog



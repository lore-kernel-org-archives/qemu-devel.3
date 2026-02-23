Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF90EEC296
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudr6-0003HR-2f; Mon, 23 Feb 2026 16:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3I8ycaQcKCoIvklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com>)
 id 1vudr4-0003Gz-W0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:39 -0500
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3I8ycaQcKCoIvklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com>)
 id 1vudr3-00012v-KG
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:38 -0500
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-506b3fb32a1so481533921cf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771883556; x=1772488356; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RVEHEUapI70GpGB38m254iV9KetAM2LV4sSrD3wxneI=;
 b=p2h6pV2TyKpwzOK3AtksxtdOA3ix9BwxDx5OOVbwLia8F8Yeh5XS8/ZrKVAOL6AbXr
 FTPKxCXs4Is5Cw11i1bfBxHbOZ+QKDgyoP98jBKyLNCNUlUp0mA8TQgEpbfR4T/ulYoY
 x54w3+e/VQItam4SdlCiPMvrMCN4Ybiu7lkXm5RVk8L5pqYBxa+NNyaYKnDibWMXJxUg
 VfYN1myAW7WbTGVQrEpSW4IIiUWmvFeQSyuL7ZL3DcK0nzT+6I4WzYMmUPZXu8a+w12z
 7f8VSZThMq3q1JUCHHYMRhC50wzXrlgeufeXUX9Sk0TG5U5VkzSsyM8L+mtSTFL9lt1Z
 2xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771883556; x=1772488356;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVEHEUapI70GpGB38m254iV9KetAM2LV4sSrD3wxneI=;
 b=Cnmm4XvK95gbEQ2Ew8ALvh6CtIn/ZaD1L5zskuKxNDaA9z59IIerpn3DFFVDHzzJFq
 c3wJelj+WDftwZ5piHEKh/0WQgoiPUIC9Et8ncAEMaELY2vgrHYG68bMpkqy15lUfLTM
 o2fc9QC5E4A0eBe99TjpCtJmzfndNjs5YdCYzf6BiNdf7Nb1l2tZTSilaprTHZl3tuYQ
 zkbhqq3aptctiNvIh4Ydi+dDXh0C3lhqkWJcTAtk4g9tQ74Gap+NMVTgh4RoMN2KH4Ma
 MUxn5dx+qWB3PPL+v905rIh7ejDDW4LpQP5iXYwdBHoFt+L5qH9+SyXmimfnTpTmFrxw
 Dhvg==
X-Gm-Message-State: AOJu0YwsD4ybCv1lAt8/q/YRT3psBvHLZbNKUM8ge+JSbgrxwfDQdF9c
 jGaImtwtimCJwU8WX6zSrX89sbNCPPiJv00z8o6oNlUSLSH4EFf7HegSoUlGAEmqO/xBl2OGCa/
 WBbAh2gF5/lh4faE2qgJHeFgEOSwKsZDlUK+xijIOrAo0NVWINHzFVvn/0biAVhzPsAxmp4HhZP
 VfEJIr4ZjdixoehvtvvXcTxdSccIXE0rV4UaiwxteU
X-Received: from qtnz19.prod.google.com ([2002:ac8:4553:0:b0:503:2f52:46c5])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c55:0:b0:502:6312:8d6
 with SMTP id d75a77b69052e-5070bba4c79mr167455861cf.12.1771883555650; Mon, 23
 Feb 2026 13:52:35 -0800 (PST)
Date: Mon, 23 Feb 2026 16:52:24 -0500
In-Reply-To: <20260223-passt-v1-0-101c6ba1c88a@google.com>
Mime-Version: 1.0
References: <20260223-passt-v1-0-101c6ba1c88a@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260223-passt-v1-1-101c6ba1c88a@google.com>
Subject: [PATCH 1/2] Only kill passt if it wrote a pidfile
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3I8ycaQcKCoIvklurk4muumrk.iuswks0-jk1krtutmt0.uxm@flex--pefoley.bounces.google.com;
 helo=mail-qt1-x84a.google.com
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

Avoid killing qemu if passt failed before writing a pidfile.

pid is initialized to 0, so calling pid in this scenario would kill the
entire process group.

Signed-off-by: Peter Foley <pefoley@google.com>
---
 net/passt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/passt.c b/net/passt.c
index 9ed811a514..b3d4b71314 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -102,7 +102,9 @@ static void net_passt_cleanup(NetClientState *nc)
     }
 #endif
 
-    kill(s->pid, SIGTERM);
+    if (s->pid > 0) {
+        kill(s->pid, SIGTERM);
+    }
     if (g_remove(s->pidfile) != 0) {
         warn_report("Failed to remove passt pidfile %s: %s",
                     s->pidfile, strerror(errno));

-- 
2.53.0.371.g1d285c8824-goog



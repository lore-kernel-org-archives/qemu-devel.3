Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294AC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVP8-0004PR-OM; Wed, 22 Jul 2026 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLNE-0000Bd-3G
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:48 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLNC-0002hf-KI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:47 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so190285866b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682225; x=1785287025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ydxv0Q4bD+qLHCya35AjaRVSkKhuKwlB7W4JrVReJxs=;
 b=Vaop/T9a/iMJ2yvWBzxrwFm9+2xbXrHBs4Syw/K85UpIcsVdaOEwr4zACALHa4nCP7
 JUR16Erz62zN5B3anLiLTaKX865DBmyzXpGxMMoEwWgfF2SRLgEqKHw0SrisNbWNJAC6
 o4U/8d1llLAVVUSmwidDv72rTkCIzX0Vr045mpvMx6v25TvGCdV6u+510nITMae063WS
 s2P69Be7QZm/ITNnoky1zfuN6pNGS6FEy40WG8OSxwiRBw6c/JEAkzV2nXiXvt0TdMPO
 bH+cxs5hr+GeOQEDilLJ47mbT1k/jnRbhFyTKZ2GgvhdYBrRFVysYqtSh2++OYpFBVq8
 Wl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682225; x=1785287025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ydxv0Q4bD+qLHCya35AjaRVSkKhuKwlB7W4JrVReJxs=;
 b=MupiJOd7yjgez9ZULz/w2Xn9OOkWlaDEUS95gUvjN1yJC/45IuXFP8leOgYG50Sd/p
 vlYwf8oMXi4mkampz5JcMsLrxByH4nMVvm6bsSe3CQYwxDjstOrL5flL74bXtO1eylcF
 r93zdIvGsIFEJfXgO48FY0JFNI4mGnQRWon/SdjO+4iLBREsHy0DgXpS3aaThh+IpnPH
 h4CqhOh3C1oH15k+1UQVqTSRAMekzrEzy82bVd8nunLk9pSOMFhy8iPef8/bRLJ04REt
 OeQGTya75VvJ1OAk1nKVeTF49OMDDCcqWFFY2c6rwk2VlKOxhFmpVbu4TTwij6R1zwH5
 jCEQ==
X-Gm-Message-State: AOJu0Yz4/ZdRh4JuVhXZz7HYVF8aZl6zYoJcGmWsSZ5mkWYMmvhu/CDG
 LzGnezUAi1JdNzDPC57AuHCCBDSjJ/p0VwfYbP5fAmrl0ct4gVDTplHM5Oop0DNbeQE=
X-Gm-Gg: AR+sD13w9B+9S5xkSmUj6KDZOI+zbA46St0HQ1BqdsbB9mJjCURncoL60QyPPV6fjvb
 bFUBO/1Y1BC/UdbgFzElDITpl53ti4VcmS/z+qWeZnMghkSPjNQv8JPqyM8f1PvVWSvIFFaQYxN
 W3DMFI6lAipNtLuhTiwCea5o5mi+b9NOA8IQNIB2kZHp0G+cUvCv87rnnH5Z19Cjyk8yB3Q5r6+
 JsUht1bMYJBxlF/fgwTVUrbEepV/zcdtDiloDEJUXc02YVqnxI1/elYN26i0yRza5Y5kSXuQah7
 X+9BOCCN8ma4qQbQlqKgkvsaSDZjNWxLIOFMYhpu/DR3KFnxzWSyvPWhppJcV7FGXxo1aJVkx3y
 GWPXOMGGM2T3cI8cXHBb1mzYB5Sw2QLgeNErDelieRWftWMGCKuKEeHgkT+I1FV8rvw==
X-Received: by 2002:a17:907:c70c:b0:c12:67d2:3d6b with SMTP id
 a640c23a62f3a-c16b4572384mr863768366b.11.1784682224602; 
 Tue, 21 Jul 2026 18:03:44 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:43 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 5/5] iscsi: avoid null iSCSI error strings after cancel or
 timeout
Date: Wed, 22 Jul 2026 03:02:54 +0200
Message-ID: <20260722010254.424820-6-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722010254.424820-1-rangolit@gmail.com>
References: <20260722010254.424820-1-rangolit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=rangolit@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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

Cancelled and timed-out tasks often left err_str unset, so logs printed
"(null)" instead of a useful reason.

See: https://gitlab.com/qemu-project/qemu/-/work_items/3067
Signed-off-by: Konstantin Nigmatullin <rangolit@gmail.com>
---
 block/iscsi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index b6207d03e5..0ab12987b8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -290,6 +290,20 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
         iscsilun->nop_failures = 0;
     }
 
+    if (status != SCSI_STATUS_GOOD && !iTask->do_retry && !iTask->err_str) {
+        const char *e = iscsi_get_error(iscsi);
+
+        if (e && e[0]) {
+            iTask->err_str = g_strdup(e);
+        } else if (status == SCSI_STATUS_CANCELLED) {
+            iTask->err_str = g_strdup("task cancelled");
+        } else if (status == SCSI_STATUS_TIMEOUT) {
+            iTask->err_str = g_strdup("command timed out");
+        } else {
+            iTask->err_str = g_strdup("I/O error");
+        }
+    }
+
     /*
      * aio_co_wake() is safe to call: iscsi_service(), which called us, is only
      * run from the event_timer and/or the FD handlers, never from the request
-- 
2.53.0



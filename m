Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C9AEEC28E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudr5-0003HO-Ku; Mon, 23 Feb 2026 16:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IsycaQcKCoEujktqj3lttlqj.htrvjrz-ij0jqstslsz.twl@flex--pefoley.bounces.google.com>)
 id 1vudr4-0003Ga-04
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:38 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IsycaQcKCoEujktqj3lttlqj.htrvjrz-ij0jqstslsz.twl@flex--pefoley.bounces.google.com>)
 id 1vudr2-00012l-JE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:52:37 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-79801ac9355so85717997b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1771883554; x=1772488354; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JKjxyOc9+wLsReitGJcfoh57oopHS5EeiajHsmdnHG8=;
 b=s7V+w+rqBjYa1bOs8P5T6Bv42x8FptpSPczIYd/I6m8PaQ/3Vb5DS548QwDlBTTlfH
 skZUfq0nohyu7+4VERetGQmk9XhfHjYWMFbc9TfZ6BDDlQ5RYFVKTW6sD7lcR9ilbujk
 eMzxhXU+tn2eTABPmdnlLs3LTVL2SgBTz0ObC8uky+RPfXsKQl0xtkKVBnmjxHeZxJ2b
 l1lgvB/j51YsAkhNRvF6/4W5T6MrCdYkdKWC8c80VTd4tI8yMJP3gUpcldDPMurvJ968
 ScyDjcyk9YeJ8WOMmLVGJVIU/vnpaRbwWIeIuzCQ0zqaq8bkjBoaRZ3sS6aKGHeDnNmn
 6T6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771883554; x=1772488354;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JKjxyOc9+wLsReitGJcfoh57oopHS5EeiajHsmdnHG8=;
 b=JZRAw98i2IBefSgEvnEr1M5rl2/FQzYL9aY4spTS/z/uvySI+hvJD3/lCqImzifR3s
 9BUv2LPlQLZIHlvXu7ZNP3vzMsRZq64HnjpMvQfX7lmaEs7Rk77jxV15TyWAoRLfuaGz
 pvZ0QThZP9IXgEW19XdHX/3IXdu/EiDhtVAXq3ubFix/847iJjBG4y9Kw6EI1sskfzlz
 OpchuF4712kjflGfs4NqtBT4uBAIZtnHIgYBj37JnTBCB5rpyvirdlvrMuX4qUrpaKw2
 HeqGHOJtdIZ/ZOfCgxBFUCe7GhBQW4xfD432w0m93mg2pe/C05r3JOYxngP1WRFv4VtM
 SZ5A==
X-Gm-Message-State: AOJu0YweCutmfB5eQNJSoBU28ltF77+GQace1/f1QI/7MaHcBGkTrwN9
 5YgbpRS2wy04InBiT6gxPvYczXA8K0znv1rVj+60Zy5r0jJLlQ7K+Ou9aPqLa7Seq/ss4SEiUO7
 mmU+6Mz4KTJ/XTzyVxrrmq8Kfuv/Wvw4GKOe86a+AJCXgrcCEMIWfadK9DXsjKlNcg0IJLppY56
 ASzrcLMmWYq/C5wOoh3R18XmNvEDwIl4VXGff1u7O1
X-Received: from ywbky11-n2.prod.google.com
 ([2002:a05:690c:530b:20b0:796:3e6f:2024])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:ec5:b0:798:5333:ce0d
 with SMTP id 00721157ae682-7985333d42emr22498037b3.4.1771883554361; Mon, 23
 Feb 2026 13:52:34 -0800 (PST)
Date: Mon, 23 Feb 2026 16:52:23 -0500
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABfMnGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3YLE4uISXQNzAwszA+OUZBNLUyWg2oKi1LTMCrA50bG1tQCwhVR
 eVwAAAA==
X-Change-Id: 20260223-passt-0708603dc495
X-Mailer: b4 0.14.3
Message-ID: <20260223-passt-v1-0-101c6ba1c88a@google.com>
Subject: [PATCH 0/2] Error-handling fixes for passt
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3IsycaQcKCoEujktqj3lttlqj.htrvjrz-ij0jqstslsz.twl@flex--pefoley.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

Some fixes for passt error handling that showed up when
trying to enable support with an internal Google framework.

Signed-off-by: Peter Foley <pefoley@google.com>
---
Peter Foley (2):
      Only kill passt if it wrote a pidfile
      Don't try to read the pidfile if passt got a signal

 net/passt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)
---
base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
change-id: 20260223-passt-0708603dc495

Best regards,
-- 
Peter Foley <pefoley@google.com>



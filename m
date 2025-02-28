Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9AC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 21:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to7ms-0002H4-By; Fri, 28 Feb 2025 16:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qijCZwcKCkk6py452przzrwp.nzx1px5-op6pwyzyry5.z2r@flex--venture.bounces.google.com>)
 id 1to7mp-0002GN-Ed
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:20:47 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qijCZwcKCkk6py452przzrwp.nzx1px5-op6pwyzyry5.z2r@flex--venture.bounces.google.com>)
 id 1to7mn-0000ji-9x
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:20:46 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-220e62c4fc2so50573805ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740777642; x=1741382442; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t5stj2TrAArCn/zoW9Gt0j+4oqt6NDwqwMNrnxh9PtY=;
 b=pYMinmO3VfcxDznFznppcMjDJkA6OQYc3+nLOdkp2V558ZLE8Hd2/akkb+GzlQ06Bc
 t6KlP6mF/hE0x8DjnlL0jHpd+5M28VMCermvEhUC4bzLYEIcpevYD9OWyre1htN5Jxwt
 YiVpJ6QP+n4yEoBFMf/FpZSdr4BVZA98FYpmmJ/HSPopFcVSnXd6UbgF6wrgHE30sSFb
 mQ/JgvUM8b3Jts9NpCxsLZAA3JPM12gMO2uTjsU/qna4TBcVv7abbAFk+uFgWiLyNj8C
 cMU9GtQgz/Y4QO0qQcDV7IHnL/pURRmeGwnHSSzl23ve+R2xkfccamVxnXHa+CUCvXmR
 /c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740777642; x=1741382442;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t5stj2TrAArCn/zoW9Gt0j+4oqt6NDwqwMNrnxh9PtY=;
 b=GxlQ3lnF1duvQF3bZ6W3JXLZGk+ROVx8+irBwXJKUf3RlluO2prwG1lZoRsIr9fKLA
 zYFziRYUuDFcNOka3ja70tUrTNMHNHIFr4KDOn0l8IxOxoFGdPzioyjpvd1fax2FKjrC
 gx4d8sxe8NoY+6GUtu/cM+fz3fUF9Ix2PUXrMjtsQqQJtiBketb7krv3oN8dT2zWgTyO
 0RDaElYx8RtqO5TmlJHRx5qA6tIbFETvOEPl7f7wPaH9Q0ZAwXZqW4chSvlNqXrIQw8g
 h1NTxJZK09v0+DfFOKeBhiql0gFWXpRcuvz5s//w3Xut2rK3oEJPuhRujPg9UBiFeASk
 f9sg==
X-Gm-Message-State: AOJu0Yy3qoDjscnHX4OzuEcD9OujT1McjsVxng8ce1DlUezV+G3tH0u+
 uh//CHQ81Zx00DCE7URDe/dIsfmQQNRp+xtwbKGLos4O3uDPxdseG04zpiQaaBBg+77n62HWUxJ
 2+kQksA==
X-Google-Smtp-Source: AGHT+IFR+k6qN5Up3BQk9qIS4/zqLf6B03EjIBWpsgzDHh+Z2plY+mexMCTv6eoXAnV9Z05rMkQJHncjFNkm
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:2fc:af0c:4be])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e841:b0:215:b75f:a1cb
 with SMTP id d9443c01a7336-22368f6a1cbmr68427115ad.9.1740777642380; Fri, 28
 Feb 2025 13:20:42 -0800 (PST)
Date: Fri, 28 Feb 2025 21:20:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228212039.1768614-1-venture@google.com>
Subject: [PATCH] util/keyval: fix msan findings
From: Patrick Venture <venture@google.com>
To: peter.maydell@linaro.org, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Peter Foley <pefoley@google.com>, 
 Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3qijCZwcKCkk6py452przzrwp.nzx1px5-op6pwyzyry5.z2r@flex--venture.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

From: Peter Foley <pefoley@google.com>

e.g.
qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5

Signed-off-by: Peter Foley <pefoley@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 util/keyval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/keyval.c b/util/keyval.c
index a70629a481..f33c64079d 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
 {
     const char *key, *key_end, *val_end, *s, *end;
     size_t len;
-    char key_in_cur[128];
+    char key_in_cur[128] = {};
     QDict *cur;
     int ret;
     QObject *next;
-- 
2.48.1.711.g2feabab25a-goog



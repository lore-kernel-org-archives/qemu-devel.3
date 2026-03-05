Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE28F3D31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBCW-0002rL-P6; Thu, 05 Mar 2026 11:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3r6mpaQcKCvwtijspi2ksskpi.gsquiqy-hiziprsrkry.svk@flex--pefoley.bounces.google.com>)
 id 1vyBCO-0002qu-7S
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:16 -0500
Received: from mail-yx1-xb149.google.com ([2607:f8b0:4864:20::b149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3r6mpaQcKCvwtijspi2ksskpi.gsquiqy-hiziprsrkry.svk@flex--pefoley.bounces.google.com>)
 id 1vyBCH-0002Zd-Cs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:05:11 -0500
Received: by mail-yx1-xb149.google.com with SMTP id
 956f58d0204a3-64c42aa5d66so14080073d50.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772726704; x=1773331504; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHhsPPDLkdSeU9tjRW5N7Haoe6QZcMPx6LMe84vrOkg=;
 b=u/Jolj5sd6LwD5FVWZl6yC5EAsJak2J+vihOtnAf8SbDX8AZpMELlk9dr8JLCmCs6I
 P/vbRIiXkz6H5OPc8PCe4/bJBU+tGCAM9jxXfKLTfiSNqfZ7HSTGsSciUB3xmnswQLTA
 1ejBq1jqPqXHe0PqNJ6pLJWZEGc6iaVaLmhOIuAH86/vlcldMuB9CUTuqYVETESDw8gZ
 4gVrOSk09cqVdEpdngMlMd1xwL2E3UyN4VPy7uk0JP8Q+eCCSZJSdmY0B5qzkwfnNleL
 YqrR7xJVCzSfK51Te/Gxw/VZ6ZZ6ai/wEVBC1Dndip4I2O0la1wAwKmrgctkKCasPmGg
 tWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726704; x=1773331504;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHhsPPDLkdSeU9tjRW5N7Haoe6QZcMPx6LMe84vrOkg=;
 b=oOVT+jWiAEPoiLiMFX0P+9v0mWusc9zL92lf/+UFt5UHFt9/QF9ufJwts3hx8XjA1v
 /kW2Tp80uBXEeVDUJ462guYPOvUSt7JlZwRIhAdKYMUW+qnXvhfIbuAgdBiK2OTKhS/+
 gz+dtSWgfH3eLLEAYBDan3+lZ5RzvdC46a1p0Go5yaKMUk7kVBPFpSUL7cSVMyZ8QSkj
 2ERtn7G5yLEbJvqqiqAszgi2QFYIur+zKJYcW4Vj18S4Y+mo2H7DYIZ5T/fYJf+iLkiF
 Oz6gNOSRFJBN2zuOvSp+j/CBx4w/Ll/hqjU9vdaZH61OgYRzArqBfABNeEZ4KNFXd3gq
 LWmA==
X-Gm-Message-State: AOJu0Yx8PvZRz18scXO/g3ITYyU3/GN07OCz4kLM9zZmS9zsAEly53nZ
 QXJ/FYaJWqFJ7piT8mKmE5o0mwyAWEyGfDHibIeyJIdY/1W/wBsVdWVIaJ8w52DYgE64a7pK8ig
 4p3uXudCCXOhW0UF8myvDU3cEuJ2awrKBe2qmou9szUUY99tb1EbSbb0VsgelorCZ3Z/D7NcAKh
 tBs4U6bro93Iaq8w/y/3JDa9fB/oHeirvL4hr7Q9az
X-Received: from yxiv7.prod.google.com ([2002:a53:b007:0:b0:64a:ef75:1b5])
 (user=pefoley job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:429b:20b0:644:60d9:8648
 with SMTP id 956f58d0204a3-64d10d275fcmr132512d50.87.1772726703947; Thu, 05
 Mar 2026 08:05:03 -0800 (PST)
Date: Thu, 05 Mar 2026 11:04:56 -0500
In-Reply-To: <20260305-passt-v2-0-f0582198afc0@google.com>
Mime-Version: 1.0
References: <20260305-passt-v2-0-f0582198afc0@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260305-passt-v2-1-f0582198afc0@google.com>
Subject: [PATCH v2 1/2] Only kill passt if it wrote a pidfile
From: Peter Foley <pefoley@google.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b149;
 envelope-from=3r6mpaQcKCvwtijspi2ksskpi.gsquiqy-hiziprsrkry.svk@flex--pefoley.bounces.google.com;
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

Avoid killing qemu if passt failed before writing a pidfile.

pid is initialized to 0, so calling pid in this scenario would kill the
entire process group.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
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
2.53.0.473.g4a7958ca14-goog



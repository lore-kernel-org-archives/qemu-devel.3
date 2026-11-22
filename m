Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB3606A6A9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kGvTEfod
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAlN-0001qR-BK; Sun, 22 Nov 2026 11:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl5-0001my-1O
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001W7-7B
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:42 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b8627e0eb2so3167442a12.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366179; x=1795970979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gAGG2jLXtg3SK4J3exZ4kZ9bZ5LCq3jndok7S741WOs=;
 b=kGvTEfodD63AAFvsIu5sl58JaTFLOI5ph7LnrcT23vmdZ+o3wz/VglgSo/Skf+uUt7
 gNFpr9B56bJX9o/wFP4s7DHSscxVpshqGHCPWk2cdUoE7+hSOe/2DKCc5BqEJhemN5DI
 QKY+oE+PXltqddOjmzrBpLJeQ9U6OL9YomJVjbC5EzY3fPfvmHEHT7rg7L4wpk4xmKGD
 jlxqjrqQx1EeNWZsz6Xg28PFzYjC0mmQXeKxMuTjpj1fgwEq3E2KgPiQkG/l7XI+/6cS
 U8tBfpdGGy9Znn6KojCRR35c4iRv3pHG5QYG6hLWIrmslauHHUPOBVVLTRuaxBcfUBuE
 u1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366179; x=1795970979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gAGG2jLXtg3SK4J3exZ4kZ9bZ5LCq3jndok7S741WOs=;
 b=K+Osb3amldiMcgWVII4PJvDhxivWTZgQN0nkrJwGK3/Zz7PBE3c8A/zz4a0ecouSGb
 2v3Sisl0HwI6G83MqWNxKDr60ZPkvhQ1h6dOx/jHN3kf8tl0rYCinh1ZBIpF0fzTRJ/U
 n1NMBY6oZFpePrTvMexxiIS5KKjnewsvzBDNNLY9Li+jWcPk+1f4TtqjHs2yqm39zz4S
 Gu8yPg+kX8BYTN81UiR21FOlZ5xW2MK7/xU1QJTeFoJcI2aviuA5+TlPaiE4oJtPvLle
 92yN16ss5JjiA0dGxegCaf0xahluKttaCZjKQdTen93+kj2r6IgT29xl8fodQLnH057G
 etww==
X-Gm-Message-State: APuU4Z/gwO1iuRrn/OAzsV+Bc6pdR52neMpQMd+nJHj6QEpkbLujwKxo
 qcL10c+Gp7YCl5xz/e+7pV3O34gjAIn+Sf4oOtUU1vrrRyXUFDu6FutOel5z0M+nxJk=
X-Gm-Gg: AZFdTZeZLo7hEFrX7qsfxfdBWe+LImAv5m8jMk62dpcYAg44TLB9vBhc/AXqxPqmiRO
 1Rl+xIiYSlTHAgfsPCn1C2+c3fkNJHfG/nwwr4Ay6IHjeERgxH/hj/3sMXcD7FXJiiXiyYaWGWy
 jnplhFuJxhNC7W/WX24kv5Fs+WfBJRfiM05oxtdoi6noqDxvZiAAhag2txB3ckCQQlNsEDMfUwM
 cun/LN8MIhlY3WmwOIzVcyi9hy3mYDFI593JWc9MTkqsSNBa0F/VVN3frFZ0NrfBg1jgnB9/GhM
 C3IwCzT9Zj1D1gBFnOIgVVCAdFY0261pOegcphVTjQtnnUtpthHTizofxZ7F/SGla3l3oSQu6vQ
 dDS817R68rrLJ3K7TYuhVTlWOGtoUQoj5MYwhItGqk+GYpYVk5Dl7IV172fyLHVL5thBZJafT5B
 R4+XzCZVueJc/WL/JwzUCVCIiLHHUXoK/XymwbF+R5t7mqS8Kg+c8GvWyr4m8XaND0Ku4q9iWRo
 7LjjfBgOXc2/EwnWUNzZLzK3s7DcvOdU2uh4zL6yi/EORpf2CDxlbi1FcQauxDr/ayWpmtvfreC
 Q8G2F4VXiMXNb6F4DNgQL4+x1A91lpLTDlioX+V9CLWTW86dUbcr1eQ8pzXQdpngcwtihL5iETB
 WighzWbFwMKk6zgUGveLUFvGGI5SUiNxSYqnwIas=
X-Received: by 2002:a05:6402:5686:b0:6b8:823:9b4f with SMTP id
 4fb4d7f45d1cf-6ba37eb1d98mr5076724a12.38.1795366179196; 
 Sun, 22 Nov 2026 08:49:39 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:38 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/10] tests/qtest: unset socket timeout
Date: Sun, 22 Nov 2026 17:48:59 +0100
Message-ID: <20261122164905.59680-5-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The qtest_socket_accept() sets a timeout on a listening
socket. FreeBSD also inherits this timeout for the accepted socket,
which breaks some tests. Explicitly set timeout on the accepted socket
to 0.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qtest/libqtest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3..c3d84f9ca9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -151,6 +151,19 @@ static int qtest_socket_accept(QTestState *s, int sock)
     }
     if (ret == -1) {
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+    } else {
+        /*
+         * Accepted sockets might inherit listener's timeout on
+         * some systems, so set it to 0 explicitly
+         */
+        memset(&timeout, 0, sizeof(timeout));
+        if (setsockopt(ret, SOL_SOCKET, SO_RCVTIMEO,
+                       (void *)&timeout, sizeof(timeout))) {
+            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
+                    __func__, strerror(errno));
+            close(ret);
+            return -1;
+        }
     }
 
     return ret;
-- 
2.56.0



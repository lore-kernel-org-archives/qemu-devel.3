Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=df2RZqnu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejh-0008L6-Vd; Thu, 26 Nov 2026 14:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-00081y-Po
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:54 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej1-0005Cs-UR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:46 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so11434564a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719702; x=1796324502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XzcRwDgDMzutl88PLR4QbPYiMmbVjjYhNIcuolmL//o=;
 b=df2RZqnub/b0aHqTgNuPG8OznciiySz9E9a837oP2X6YNtlCauk/KU/X8yN0QVJTWw
 JsAUgOTE5AJM5kUGvxr1V+ojVHSQRyIPkeR4a0700eu2pTuC/0D4gsdXWXxcBodoQM79
 Q6Yzi1LxNeMqUHw+yf+I5xmsYdE2dUblbs1cxbhVZOVkX2AIZtI0BRBob6I4IMVBXLJM
 Wr4mMXYc6T+CKR1rC59GyjSkjujm/RY+4JUj9bQZNZFrzoZhVlGOkEu3ela/qZmAUAvx
 nwUqh6pav96cZ0DDfLa9xxECQWABnGBf2G7a1gtX60hEPsXGdmo8EH5yDfhrjSE5TFYH
 W7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719702; x=1796324502;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XzcRwDgDMzutl88PLR4QbPYiMmbVjjYhNIcuolmL//o=;
 b=TkoEwErYHwd+91GP/vBeBCxJ+D774g7HdYaNvtrbCboqDunTQeviWHb4y6zPPr6kY6
 zbMl8SLbFkLwIWhYB304xQxl91N5Ud6Cqzxb352IYGk1S5anF5Ejt6yBxSCCWYwbXT30
 +i5QNsZyiRMihDDATnFwuFIGQXKcAI19ElYJDoTPPf+oOQbihT9/0nbve51FckumtZtZ
 hkhXooep1Jdl5w8hnyDn2tEjG+aPMQNy9Vgwk515Z+czi/3PXRqqjSRTQ418AVb5264h
 0+Z4Jlvc3JV/TI+gIeH2ofYUdrPs6+E2NFCkNsx77ls18oHwLBjnd65xtvVL6XE9Ytmj
 mu3Q==
X-Gm-Message-State: APuU4Z+x84tuOq0Mnmu42++fVThITgSgkjPeKWdGxNfmGy9Az5DDKIZs
 3W276GGiSsdSxdPgOaBhlCQuL0mhVUMyiPiSrOL95gsQKC7Zxfxg0/R7RKVzAwJtLwo=
X-Gm-Gg: AZFdTZf/oKQFZY7B6Kz1joWLuoWa15m0NE5fmJywp1UyQKWibK3T2/SJQBD41zRQriZ
 7iRv4wBPBU8X+nC4zDdODMBSLEfcPNM8mQaxV9IAfuNPNJ61RqpQZ2EkFaMjI/FzD0m8GtftOrg
 zBv83XPd9M6nM+YNWFDe59OeQYs4tdXsisrFuXOiJZqnX55zdw/jTmz3GhKic/BQd26kJ5cHXfJ
 D7Ce3wK8mP3/4PPGDBIJ5bddUgG9KJpG7U1Pj/BfjWVbzNnvjOluipFG2SI0me8zv0ZPqvlsXBh
 0Kol4pPOU8kIMmb4w/ZUJwR4Kc2JfqNER/rqZOjEkuyFxNBq7GSElfh3xXEL3FZJvX1sibC3nhd
 j9dYVEiqk6VXCF8IRiMjGGIphXMBCN0YCjOXxqa5RasCK2vqSAM9VwUqKXslIVENVvbiTbu12e8
 2VEDLdAw+9RSJXRDYgfMkqREIoLUQ2zc8PrOQvOS0mzzV/qjExqC2QPiOMlDy6HnZRipTakDPXA
 JYlCD59jr6fXiv7/bg52hVSd0yUsFNjtvKY2ZQd1SjwrnxM/nFJwEjOK5b6rgXOGPmEVlb9Pb0V
 lkqRBG1pVf72H2/LJGeFEGggXqYxJPlNvEjL
X-Received: by 2002:a17:907:a890:b0:c4c:b4fe:ca01 with SMTP id
 a640c23a62f3a-c513aad51b7mr1956376066b.37.1795719702247; 
 Thu, 26 Nov 2026 11:01:42 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/10] tests/qtest: unset socket timeout
Date: Thu, 26 Nov 2026 20:00:47 +0100
Message-ID: <20261126190054.40844-5-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52c.google.com
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
Reviewed-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3..7bab712e62 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -151,6 +151,19 @@ static int qtest_socket_accept(QTestState *s, int sock)
     }
     if (ret == -1) {
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+    } else {
+        /*
+         * Accepted sockets might inherit listener's timeout on
+         * BSD systems, so set it to 0 explicitly
+         */
+        memset(&timeout, 0, sizeof(timeout));
+        if (setsockopt(ret, SOL_SOCKET, SO_RCVTIMEO,
+                       (void *)&timeout, sizeof(timeout)) < 0) {
+            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
+                    __func__, strerror(errno));
+            close(ret);
+            return -1;
+        }
     }
 
     return ret;
-- 
2.56.0



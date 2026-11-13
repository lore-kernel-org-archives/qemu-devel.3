Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A306073203
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+CkzTYN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRv79-00061g-F0; Fri, 13 Nov 2026 12:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xRsw6-000795-Cj
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:11:30 -0500
Received: from mail-pi2-x0a.google.com ([2607:f8b0:4864:3a::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zachwade.k@gmail.com>)
 id 1xRsw4-0000qr-Jy
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 10:11:30 -0500
Received: by mail-pi2-x0a.google.com with SMTP id
 41be03b00d2f7-cd6b195dd0cso243454a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794582687; x=1795187487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qdUPcPP85ZDqaItoUOquHjbNHH/klz4YqTQKBBj6Kgk=;
 b=V+CkzTYNqHzdIhPoq/Efsp2Gqhm9LJsiDhl7s9TyPEWHDYnu3w+rKVk9glLHZ/VC2R
 zCbqZeEGfB37nIb3ykfQLgMn2+sOlpMxihBAG1vaOPyj0krvZ5BWKrTbeeMWsa0MPmli
 nGm1Sjbk61sxwWe22PqorlZuWAKNZE6a4slivC/h+1wInbCSEObD7ASHwGmaUSgSfsR4
 KaE9GqCjBA3F5JPsbA8Yb7G5jDC5Ib0GGjLZSyHtOlsMzJIVR52yT4jO3tiga6Vz+aXk
 /2lGogbiRtDqDmTtP/rzy0oklvF6yvOkoUpuavEDPgnfq7UZQaWMC9HXGVMXI+FIpEWr
 fULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794582687; x=1795187487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qdUPcPP85ZDqaItoUOquHjbNHH/klz4YqTQKBBj6Kgk=;
 b=iPZEfJuBUUre8RIZJdZvQBhicsjBofG8fxwNb1fnPDdRm+NbZk5NOIS1ugeRYGCCGa
 SbxP1W2hFENBIEcqfo11uWue9kOs6HhtwZfPEe9qgYJDBHGd4HNoIbMe/jXB5ikde3iS
 8xbaKu7ZcIe7Y1xPAEScA9KLFk4teljP+VT2uKtZDmdQO6waW9EcQ+u8EzLE+0TelucH
 Yf4MoMQULMOVSFPeeYN27D4fkIS5xZTQouGc89IhomU5gOML0hCXwuwVojFJDe7onsDw
 4Wupn1gJSYxS4HerTTgyxoOGd/8SCR757Es7p2nLzpmXBD7cjmEzIKgbAS7waj+58HM5
 eGCg==
X-Gm-Message-State: APuU4Z8bK4PPjAnoGSE2rC4vmgK1M11h4qO0eUVwtqEj4ipaZfJGPtng
 aIMkUEieB0zOa/PWOqqNA1hf6fqvXuPSgCQD5GlIM7omrSU3uao6l+FLTQRrFuu337LLu7afkhI
 =
X-Gm-Gg: AYBFou3aeHUHBx1VfiHVVEggBUtGOEF9BhyigYCzKTeLhbfOus2JztOrx8Z+7cSe26+
 cFJW9tb1FvH6LCWG71LujggefPcRMykTfUFut9KP1z/YQ1NJLr2Kyovz3q6XKTtsGFhkQ8dlY8s
 RLUF5K/adq7jMQRXLOGn0rXcgM2UXWfCIXHX8Sm4pgag98pDJDDdOOwj72PXvu3nopNAAa/ZeY7
 lK4AGFuACfXLbo5nyUd6XioTJXnJ4vRy0pUxal2qXaVPOPiABKTxZJkD/s6NG13WyTfC/QBLnty
 ZKisTdS3b5SwKYSduVCsFNx9M+oHJZDW7Y5wkB3YuEP9CwZktJEnhyd3ZMyh34mtYnVP/LC/Tz7
 CFG2MkydRO3Z/6YkS7tJc1FeVYoR5fCi1tj6Fw7o2s0BiJfalIHZeQZRXu/MY1mHLTfh0PnU4qH
 So1U8b0f4kA0l1OgZ6fOTYdcM1zThpuz+rAraVD3028eaTVqUu4G3RdDmJuxvvbSlq2PFpJmtcg
 nZ4Alle1gBv2qd3ZCI6UqOenE7whBhIS4cUrSLofcyJOHAMdia5sL3QSDw/fjj2dxCoaU3xMk8b
 RSn4RBmIFzs2TBUykGUHdMR3Yl4ltu/9MguEOVrzaWTCLTAh
X-Received: by 2002:a05:6a20:4309:b0:3eb:4690:1e9f with SMTP id
 adf61e73a8af0-3f7a7aca9cdmr2930627637.33.1794582687045; 
 Fri, 13 Nov 2026 07:11:27 -0800 (PST)
Received: from ubuntu.. ([103.49.135.232]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc1889960sm1476908a12.15.2026.11.13.07.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:11:26 -0800 (PST)
From: Zhu Wei <zachwade.k@gmail.com>
X-Google-Original-From: Zhu Wei <zhuwei@sangfor.com.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, zhuwei <zhuwei@sangfor.com.cn>,
 "zachwade . k" <zachwade.k@gmail.com>
Subject: [PATCH 1/1] migration: free migration blocker error in
 migrate_del_blocker() stub
Date: Fri, 13 Nov 2026 23:11:20 +0800
Message-ID: <20261113151120.1912194-2-zhuwei@sangfor.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113151120.1912194-1-zhuwei@sangfor.com.cn>
References: <20261113151120.1912194-1-zhuwei@sangfor.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::a;
 envelope-from=zachwade.k@gmail.com; helo=mail-pi2-x0a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 12:30:38 -0500
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

From: niming <niming@sangfor.com.cn>

The migrate_del_blocker() implementation in stubs/migr-blocker.c was an
empty no-op, while the real one in migration/migration.c takes ownership
of the Error from the migration blocker, frees it and then clears the
pointer:

    void migrate_del_blocker(Error **reasonp)
    {
        if (*reasonp) {
            ...
            error_free(*reasonp);
            *reasonp = NULL;
        }
    }

Command line tools such as qemu-img link against the stub API. Block
drivers like vmdk allocate a migration blocker Error during open() (see
error_setg() in vmdk_open(), "does not support live migration") and pass
it to migrate_add_blocker_normal(). Because the stub migrate_add_blocker*()
is a no-op it does not take ownership of the Error, so on close the
stub migrate_del_blocker() has to free it itself; leaving the body empty
leaks the error message.

This becomes visible when running under ASan: "qemu-img info foo.vmdk"
leaks the migration-blocker error and hangs / fails to exit when the
image is closed.

Free the Error in the stub migrate_del_blocker() and set the pointer to
NULL to match the semantics of the real implementation. This also covers
every other driver that uses a migration blocker through the stub.

Signed-off-by: niming <niming@sangfor.com.cn>
Signed-off-by: zhuwei <zhuwei@sangfor.com.cn>
---
 stubs/migr-blocker.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index e54c7160d3..575b65f183 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "migration/blocker.h"
+#include "qapi/error.h"
 
 int migrate_add_blocker(Error **reasonp, Error **errp)
 {
@@ -18,4 +19,12 @@ int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
 
 void migrate_del_blocker(Error **reasonp)
 {
+    /*
+     * migrate_add_blocker*() is a no-op here, so nobody owns the Error;
+     * free it to avoid a leak (e.g. "qemu-img info foo.vmdk").
+     */
+    if (reasonp && *reasonp) {
+        error_free(*reasonp);
+        *reasonp = NULL;
+    }
 }
-- 
2.56.0



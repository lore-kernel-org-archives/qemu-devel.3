Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A130606A32A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXVchvCA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVAlJ-0001oy-7r; Sun, 22 Nov 2026 11:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl5-0001mx-0i
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:43 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xVAl3-0001Vx-7K
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:49:42 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so409789166b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366179; x=1795970979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nIY/vsHS+7odb2yrYFaEPMbryHKu4IFMgkkl/WW5wEs=;
 b=CXVchvCAhoX9B+X5jM0GS3kiMEA24ZasBz0OIxtuAZLfKagq1EvVf++SQLbQ2f8yt9
 4367pHaImTyrHVUBuzWmO2p0P1qYRpLlLd83VPeb8wxZi4S2ckZsKaewpTDQKF+XkvBV
 zkEBX7HJr3tB1wXidbMAfqaxVr5wZPbWtgQ5yU/l9pwAGLENAtYM9qRV2Q3hJo0/biPg
 x7e1mnHC6ATeIfH7FAxYkSyapqb++pkOzaiQnmMeQbcYW9pkcLqKeFReIS7BoYeuDoqt
 aQgoThVySiqcTN447In+JzPZ5LY+ZKmV7g4jCqWTJmyL8w5Ml2Bccd/i4NbbcKuODzmK
 4XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366179; x=1795970979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nIY/vsHS+7odb2yrYFaEPMbryHKu4IFMgkkl/WW5wEs=;
 b=F5XQLnT5TFtJyhvbCysAa6wyozmlieGh2uCY/JPF7Q83tbNngN4uCJpUSEhsOp7K5i
 oaTPyoDeCN/XJcnKHF5X+JqgEdK/8EAU/kyC1kPt7lWc5c59m3adFQdh/DRjl0tjhEDI
 h8zcSkLS0Qoufe3UbSvY1FU1iwowHKYJX0r5xS7Fc2TusIOIqr/ny07zr7OnDi/H9xJ3
 fmlsaMmQDvHUwoKOqS66hWsAnJM+tnvp+AzUnAdRp0WgHF+ged1/0x0e7JRtx6l1y3l2
 XuENqzXSYQ8KA4AK+CK2h+erRLj/ghQzTWi0piEqrFmjUvJkoKF7dIBt2GiWldjexJ32
 gtKg==
X-Gm-Message-State: APuU4Z9Dwj2Kp84QIF9pgWAJRSXh08f5aAYZ2tMhQpqlQY7dw6YgYXFB
 oUojfB5gGUD+ySqwEhzkp1ZR6qzz99hqIrFDmQo14S4+e/iPNHMofwIBWFzEslYUv84=
X-Gm-Gg: AZFdTZeVGMs8/ABTytlSKRE5ruBRj/18LeLjIgAGEpmsXeKEQraxSfPVgsiyt5i9eVM
 gOyshXRPuCsEwWzdaIPq7YqYEbk66mZCRHy8izQCb/gGymdwdeEegcdgd6EOsN9PGfhJEJXvJoT
 im4hkxoorP2KadTXhsQxio2hdfIJbVNbW4gdtZ2XsY4zC5Dtxf0XybUQaCp8GDL9seSm0DN6vV/
 LhSzN8FCnFZtO6oKAhUD7bnVZsIiYI4tcl7l/smw1wDingwS8oNlSwLDqTgI3pjOST9GTjriooY
 7NwVJoBZ8KPARR020A6Pbv9/aSzCnnEAIHF3gCyDwp0YfSa2ctKzz9bWtmOk89H92xQgpI4ZPl9
 EO/hPs5V33/WJ6brGzhT0X38D616aTJZYQm79MclWYCGwlLut7RYqyFGFvH8HsC0w3+XJJTyP9g
 eu3FgbgJTFmQZHs+oJzeSV8ZXg7bfcNF5iAQw5tBoDHHRaSZvEFeYH5BjiItVQiD2g2ZP/DUKl1
 jXMSe2SEZwJWnDXCoc/1p09R/5N2bVbAGq6/hirnI+ALR5UtAc41SnsxTK+FwaAjdmU/AoKYAc7
 qLl8Csf83LW2w7fnh53I0Udo6t24KSQgGg/nJ1ksPxvUejeakaAR0P495QnS6MVOYioEX2LwHU1
 fCfQNbdO4woBjY8fBhCUhBGNsD5EgFZuLc3qu938=
X-Received: by 2002:a17:906:7d6:b0:c29:63f2:99bb with SMTP id
 a640c23a62f3a-c513aafb466mr604922366b.47.1795366178591; 
 Sun, 22 Nov 2026 08:49:38 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc2455sm325303166b.57.2026.11.22.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 08:49:38 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 03/10] iotests: fix the dd() wrapper
Date: Sun, 22 Nov 2026 17:48:58 +0100
Message-ID: <20261122164905.59680-4-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122164905.59680-1-bogorodskiy@gmail.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The dd() wrapper already uses status=noxfer on Linux. Use the same
for FreeBSD to fix its consumers.

Add a separate "elif" block rather than extending the already existing
Linux block as dd on FreeBSD does not support --help.
The "status=noxfer" is supported since FreeBSD 9.3 and 10.1, so it's
been long enough to use it without a check.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/common.rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da8..82a6b1b5c4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -64,6 +64,9 @@ dd()
             else
                 command dd $@
             fi
+   elif [ "$HOSTOS" == "FreeBSD" ]
+   then
+        command dd status=noxfer $@
    else
         command dd $@
    fi
-- 
2.56.0



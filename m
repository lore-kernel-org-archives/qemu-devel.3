Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ah3EYDBA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejn-00006I-Er; Thu, 26 Nov 2026 14:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-000820-R0
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:54 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej1-0005CZ-51
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:46 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c40e30c26a4so1518001966b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719702; x=1796324502; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kRmpFWnDdWYCaHUMcaih8suioPghShkTxavFPdaHM0Q=;
 b=ah3EYDBACFP3obWf8LPavDbz+Cf0v5yNtcp3umbuQ9g7LZMQ4+ggozaPRVMKUrbSzJ
 KeBQyQdL0r102MSGBlcdnt75KczykyDey9IUNX9LW5waieUZOcAOg/zmwlk4WX3XYJmy
 AIJwsYSLISu/zp54ksl1MHwH6apMmkgnM+FYA2/zKKzkYtob+RK/aEWGc52g9Ei1r513
 uKg24KKM+trmwAXTnTTjwnZyeVDfDiq6MyM0knMf1Np7ekw+yxmF+7ae22sr0gjvEg2j
 SieZp26vax1tbw0SxPdJMf2QeqEK//5HLdTVkRIGaFQoaam7YwItIczd3w80u8KJxzu2
 NbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719702; x=1796324502;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kRmpFWnDdWYCaHUMcaih8suioPghShkTxavFPdaHM0Q=;
 b=ShOq1CvVypBXePtEgYF6/ZzPodSOzcu6nZes/26RbJTvJxkDarkNYS65uHb4wPmxY4
 439ytvFU2ZP1GYF3sX24cbq/ycARlw1tteCycr3dh8Gfouux5hGKd0Eo5TyooMVermpt
 Ce8BJ9/1l9yLttHVWdTT9iWvDJiF44KqGTD47RSqaJCL8TrAnAu2plcYpuQa7hbsXNGf
 XX7SxS+eDM4jPFGkthkvoWQu1/aWEpbbBRXTBhPf2qcoG1wNZ3dw0mKO3qYRu3JHNkRf
 jf5AOa8JcQyB+woeeS3Mo3taNQbJ7BEsnI/gGH37sZIt0eU77bnW30XgupwvWq4HQoZk
 75sA==
X-Gm-Message-State: APuU4Z++d03N9Aluz7MF1Pvm1yzlKg6/Wn2j3up/hEM7HOshs0Vdplbz
 FqkWvcJ4worGtZoA0A7SUI4o5ieP29TED89Iebr0JmPcQbCFR2EraMAosGcQ6O0TARA=
X-Gm-Gg: AZFdTZfoVVIhBgdA6XBYbZz/VeltK6HXF3iumy4TxKvF8psJX+cL5E4W2lM43xDPDmG
 fEnSBu7hzdkMxdVzahloqmTpckftfKf8VlNvzkkcTY0Shc1kyK0RPtQWu9tD3jvzPUEzI2NiLFc
 nGvy9xlEWfyE0ITZt5DQ7KDyPHARZCTKywNDridwF6UYhr1RGKg1UfaFW7xwLqG45SRXmkWU4VU
 AM7U7/3CdThq0pfdhpqWlKz2/bOvDiB8vT1HqLt6ZlIQhx5XQzeJGT9kO5Pgct53tRF/JO4eCme
 vUKwh1JmjbuyUBZn5myitaOxN792QnlDQzncsj0RM0Fu0MTYZjAfdK/BzQDj4WD288cSkyGqJ3J
 aNXwdSlgOnzjQCMYEEAyxkRnRjDikYgD0+DENyNm5JaWqWOmFA9dFt4gCr5hSKlACChCM9GHhrN
 1BJjkrFJJfOUN3SL8skP/SVC9eoOpWg/Vu3qlL8y8rEfWhmO+6+vXQ9pTn0ZgVdf9PyPryE1J4L
 HvQdxNUp/kmXpQ+Ju6waVFnatfOqYLdBZai97sXwqj1y6G2PDiVpPTmPRQTP6kt+c9wHLbPAcVf
 5DT0ELC9CKl3IMAXYCD67tJ7g9Ass6ipfKst
X-Received: by 2002:a17:906:d1da:b0:c4c:a409:5aa3 with SMTP id
 a640c23a62f3a-c513a88fad1mr1243322566b.17.1795719701463; 
 Thu, 26 Nov 2026 11:01:41 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 03/10] iotests: fix the dd() wrapper
Date: Thu, 26 Nov 2026 20:00:46 +0100
Message-ID: <20261126190054.40844-4-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62e.google.com
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

The dd() wrapper uses status=noxfer on Linux. It's also required on
other systems such as FreeBSD.

Rather than adding OS specific conditions, check whether dd supports
status=noxfer and append it to the command if it does.

Suggested-by: Brad Smith <brad@comstyle.com>
Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/common.rc | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da8..a89aa48fb1 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -52,21 +52,16 @@ if ! command -v gsed >/dev/null 2>&1; then
     fi
 fi
 
+if command dd if=/dev/null of=/dev/null status=noxfer >/dev/null 2>&1
+then
+    DD_NOXFER="status=noxfer"
+else
+    DD_NOXFER=""
+fi
+
 dd()
 {
-   if [ "$HOSTOS" == "Linux" ]
-   then
-        command dd --help | grep noxfer > /dev/null 2>&1
-
-        if [ "$?" -eq 0 ]
-            then
-                command dd status=noxfer $@
-            else
-                command dd $@
-            fi
-   else
-        command dd $@
-   fi
+    command dd $DD_NOXFER "$@"
 }
 
 # poke_file 'test.img' 512 '\xff\xfe'
-- 
2.56.0



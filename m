Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94270606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRtiNvcH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWm-0002gz-IY; Wed, 25 Nov 2026 14:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV8-0001af-4O
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:59 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0002L5-IH
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:53 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c5188e4980fso148268766b.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634265; x=1796239065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=58lcozQBlvFlvhWZsGJ8kScJExcsgoaAtpw1STdA0TE=;
 b=ZRtiNvcHrEzAkxEzze/wGZzsHO3CFQlgGGtT2QVM10e8/y9UsTcIRsN9xE1Juc8xzh
 +SCjdL2TvBC78F360a0iuiUQED1zoNw9mukBy00WOfEDw7iCiPXSsF2kCK0N8G3zD+Tp
 jEaH1ac9r1RAFhlrrr/6dd3+KR4cGMop4i4UugHY3P20aDCJs4ohUYmo3bwlNSIUhLXr
 ac5CbFNz2lNHsP77mduMuH0yF3XHsKZUBQByPMdNlp1vdth7XxKcpKFPJwJ6CrrQQ3dS
 PN8L53dqrJiaf87dcn1trUzPG3fRhxJ/ZjN0zOJ9K6fN3s/r7DOw9uAQIPfteJEmc9ao
 YbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634265; x=1796239065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=58lcozQBlvFlvhWZsGJ8kScJExcsgoaAtpw1STdA0TE=;
 b=o3FLLPSaCmDs64YtFoHqshlzenrPILQc4atzhIu+kljWCdFoJXTqAjwbLy+9E0ek/X
 UR8DeosXIOoNJwA/rZoY1GecH3egIMps3zLwlWFnotBA0gto7snHt5k5M/I+DvXa0TEn
 6n4LLxGbASbxT6YchBmfuo1SpULRq3/jCI6GuWV5nGwYQT3A5gbSS2RM1u95z4SmWcTT
 qV5k/2C0uS4TcBh/7aZcfIbhaaP1U0vtzxcpEQaVlmJ4h3SThLydd+8kWni/GArah7Pg
 zSLKJZQMHkfAdnpcV9FFLyD7Fa4yn/QE3lYFEFhvRgOEbpeHi7mu3in+gXXaTitqV+Es
 EeEA==
X-Gm-Message-State: APuU4Z9PC7R0iR99XX0OI/po/3FFC/s9wNAstK/eHSEyd6779fH3aur2
 lLa2HHhnkkE0m1/VL6yMcZjlzjCMlSKVQpBMHUMHjnt5FOudcU/irtwN5z/5nR4Cz30=
X-Gm-Gg: AZFdTZcmlKao0EtA4d8fkxmjimOjVa2W2rdXlM1GdkEsSjEIrkYfbhHz7ckaPqbI2FL
 HRSlLyT5zFUuVEkpDRiGt++6kOlJADIDlvQVrH3ng8OM+il5TBTLHwyXy74pVCOk2ifsvkqfdDP
 qBSBtq1jMJxOu35MnzlovKmzbe/L0QGnJcC01grFlK+fBE9pY+92fUg6TvRnzPjFwm1AvVSDjfa
 OgY925nnEzd84f3NA6k0O23jRUUcBHdJfMlJmBGxwzjaeME/2kppXc7owAPW3rIqnUiu7FRGBPC
 rNSTdc6NgvWXvQs8nMEKeFpudy9zs+hPzt1KdvtY6X0/fs7YiMY7uDHL2RMRbP4UxXruU9M17X5
 LBWlxzXslPiPaPeytetjjYP/TvU69RO9Dm2HwLsDa0aAXIGyfwODZbQpWs0PTs+i87rqiTu7SrD
 OWuI7KHeNJe4c10hZvb8U7Ijm6Vc4JNmyGhfQz8rzCRWvF4P6pVXOUTXfp5ivJfGW1N0L6pp69m
 AG1FoP+cjQYj7y6JE2qPVsstMUzQ/rBIwQnLGxgw+Stn72ehMapIHkLvt/q5OnlYzk4c3HjtwGS
 3eBaTbEDErw5Iz/2O78Ge6YXtyeUm0jEmNHAyqwcvZ2pl525yeYsuQ3NtAaD/CF9gpSh1LEyXIy
 EOc4FnAICh4grPSbyv985VL4flORVkIGqtgofIOc=
X-Received: by 2002:a17:906:d328:b0:c3f:153a:865f with SMTP id
 a640c23a62f3a-c513ab0350cmr1193475666b.40.1795634265333; 
 Wed, 25 Nov 2026 11:17:45 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:45 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 07/10] iotests: fix test 162
Date: Wed, 25 Nov 2026 20:16:57 +0100
Message-ID: <20261125191701.93931-8-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62f.google.com
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

Test 162 expects Linux error messages. These messages could
be different on other OSes, on FreeBSD for example.
Add a _normalize_errors() helper to normalize these
error messages.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/162 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 4f01611886..73a0c43e2c 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -33,6 +33,12 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+_normalize_errors()
+{
+    sed -e "s/Name does not resolve/Name or service not known/" \
+        -e "s/Can't assign requested address/Connection refused/"
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -45,7 +51,7 @@ echo '=== NBD ==='
 # NBD expects all of its arguments to be strings
 
 # So this should not crash
-$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
+$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}' 2>&1 | _normalize_errors
 
 # And this should not treat @port as if it had not been specified
 # (We need to set up a server here, because the error message for "Connection
@@ -78,10 +84,12 @@ echo '=== SSH ==='
 # expected to be an integer
 
 # So "0" should be converted to an integer here (instead of crashing)
-$QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}'
+$QEMU_IMG info \
+    'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}' 2>&1 | \
+        _normalize_errors
 # The same, basically (all values for --image-opts are seen as strings in qemu)
 $QEMU_IMG info --image-opts \
-    driver=ssh,host=localhost,port=0,path=/foo
+    driver=ssh,host=localhost,port=0,path=/foo 2>&1 | _normalize_errors
 
 # This, however, should fail because of the wrong type
 $QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}'
-- 
2.56.0



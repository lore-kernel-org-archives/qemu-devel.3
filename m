Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC539606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+gW4Lp3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejh-0008Jg-F9; Thu, 26 Nov 2026 14:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-00081w-Px
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:54 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej0-0005CG-FJ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:44 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c50e26763a4so251863066b.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719700; x=1796324500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=31yVhEX4jokYorPxCKoj2vIdTS7vM3ARNGO1RFm+TF4=;
 b=G+gW4Lp3NKcO1gKcP3xzq5FeMGiDyvxuOyPVVVOv/tubPLMf1yMM0nvwcg0p6uvRg4
 c6R9+rnn8+sTb9U27S6a4d/LIk6QNCgooCqzyWK4woKdXuDaJJUdM7HTgOE5r0EGkYUn
 GjBLMu4UFHPDNmHmLe+Lt8n8z3ig4+AV4MZuv9r72LG+KrBJdy8sBC2BODuuv4rYyU1n
 qCVb3sPoGaveAcBm2uw6zwHsm2rCMzkPk00AoQDqUDaqTpZfc4DB+1Va7VJNTuwk2YxF
 sHE2feqSUoxOo6kzgRH4nveZK1oPSOWVwjbmjpErIjmc/5nFOzs6VhK2UAThiMijMqV4
 1hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719700; x=1796324500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=31yVhEX4jokYorPxCKoj2vIdTS7vM3ARNGO1RFm+TF4=;
 b=ZdRwmT4LVHT35E7pIKFu5kA58jPFv/EAfYtVcCbnt9icfWfnTxgXPWPn9s9Xim9fNt
 +xRLFQBwUR+vwtcPw0e1FumaT+qF/y8BJWo8L99QVyyu/BLHgSCR79hUsVxnp2hjhAAA
 wZnAZUj+8XjHc2GMKqxXE4BUNioCfRVVWlHfQfFumUGjSh6KgA3e+HmeJFYXigw2R8v0
 xDc+5kxj30zaD5Bx95+QFum4YQUd34MFs5UCcZb+QuNWipjf91iU7eauNrWhzXn42PTU
 15hWLhM9k+DhJvlgKW6Q+ovHNcQu4H6Z9OUBJMO6/kvud0AkZGAzDwGv2p4MitW8quUy
 fsAA==
X-Gm-Message-State: APuU4Z9/Q1N8f9oLDSkf67/+CneWwwe4r3VdT8/zuj3cSNYUNU/XH9bn
 AgjnaIAk9p/GCrH7agjWfrnhWCQFdJNhdYql64Gqw6jbrNsZGJlUOIaK4yttEcPtIgc=
X-Gm-Gg: AZFdTZf9I9m+3VSkPfabuOoNUpFzjhgGWungq4ynFv2L54e5MUrqp3l+xBqtyty/NgO
 mlN1RtS+nd0nIHecdIa0wLoVTsfJUH5nAyXU0cPXR6qW1G5r4z945hkYZ3mQ+0zEO/wFoYYr56m
 m74qgE7VscaqRZqKsI8PeudUpPkK1dlSnP0r+2oky/lLbNl64x8LBj5CDd/GCgTquIIipHuvr1U
 dnLQk7OBfdjsPuiSotQEY8OGI2XU8nhs7LpwxUB2FNM7rXHIWGU8cvQS57j3XCI6DO1H3DFySuW
 XS6zIVo60IuZrlAZASPnVOjF3doTupOCaTk2rzmXKg4HB36P+JVa1YmP8f/urrAV30lKgIqk6n9
 4Teu1j1BlWhFatkc+uEH5sQepOJX1Ge9BmTaj4PvdxZ21ZnMleiFlDSWgW+DCUwcXtIlUmgQIEF
 VPU01E6se07HaSey/E5EXLQatM0YEaCHgPtu9VX59NAw4XlmAPgcOQRiwKBQtM1tZV3wPLIlv8Q
 pgkrc/k1O7EihqH4lAiLmJNFf03OXL+9gOaQvSLRACkWXw9DbRWrgcLY1ygnVJZ+Dte9KiBYlFm
 KhMr2eLbkgJ6zD9+jRKBrtDMVzcEy7i6OGwe
X-Received: by 2002:a17:906:785:b0:c50:5e10:71b3 with SMTP id
 a640c23a62f3a-c513a999557mr1435778666b.10.1795719700059; 
 Thu, 26 Nov 2026 11:01:40 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:39 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 01/10] iotests: use gsed when necessary
Date: Thu, 26 Nov 2026 20:00:44 +0100
Message-ID: <20261126190054.40844-2-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62c.google.com
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

Some iotests fail on FreeBSD because the tests call sed
directly, and BSD sed is not always compatible with GNU sed.
As common.rc already provides the gsed() wrapper, use it
instead if needed.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/115           | 2 +-
 tests/qemu-iotests/common.filter | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 5c8a12f85a..e3ff91de7a 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -78,7 +78,7 @@ _make_test_img -o "refcount_bits=64,cluster_size=512,preallocation=metadata" 256
 # qemu-img check for that purpose, too.
 
 $QEMU_IMG check "$TEST_IMG" | \
-    sed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
+    gsed -e 's/^.* = \([0-9]\+\.[0-9]\+% allocated\).*\(clusters\)$/\1 \2/' \
         -e '/^Image end offset/d'
 
 # (Note that we cannot use _check_test_img because that function filters out the
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index ce4213cb97..f7211a0a29 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -130,7 +130,7 @@ _filter_actual_image_size()
 # Filename filters for qemu-img create
 _filter_img_create_filenames()
 {
-    sed \
+    gsed \
         -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
@@ -296,7 +296,7 @@ _filter_qemu_img_map()
         data_file_filter=(-e "s#$data_file_pattern#\\1#")
     fi
 
-    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
+    gsed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
         -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
         -e 's/Mapped to *//' \
         "${data_file_filter[@]}" \
@@ -310,7 +310,7 @@ _filter_nbd()
     # receive callbacks sometimes, making them unreliable.
     #
     # Filter out the TCP port number since this changes between runs.
-    sed -e '/nbd\/.*\.c:/d' \
+    gsed -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
         -e 's#localhost:[0-9]*#localhost:PORT#g' \
         -e 's#host=127\.0\.0\.1,port=[0-9]*#host=127.0.0.1,port=PORT#g' \
-- 
2.56.0



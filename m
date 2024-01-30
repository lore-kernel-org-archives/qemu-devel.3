Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F0CC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgql-0002uX-D5; Tue, 30 Jan 2024 00:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqg-0002tq-8d
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:54 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqZ-0001Nh-1G
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:54 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dc608c3718dso2988529276.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593066; x=1707197866;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shO/Z0O568FxrbBMQD3Us+o0eIumB7pwZZUUIjpimB0=;
 b=Rj7vF0E2zXvBVHvhLFBbEo8i4pJp3HVVslvd84WzWCj3esd99v4Y76G8OpGFoSlQH1
 Uy3pwouZZFP0HlN7ZCRjFryhhw9s3xJL9v3DjTnrKPG3ccSqvdI5LbvZS20EMDl7uPsv
 MJkpUWenZ3QWNUuuYY4Gym/EvHhZrrH12n9oSpd3HgiPwad/ODPtaTOu7hzCz5Z/I7C1
 uHBV5VZZDjiPFKDn1ukuZ0nbtGV3OW516boHm8ceu8lBQvD02cKARr7ItCZF2YiPK0wR
 WrY0VhiWuws9oNoGILpz1nxC0jydj4jqaimFfk9YAUmV7TeqkEzWyjBe+ReIYSQR6BLM
 TRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593066; x=1707197866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shO/Z0O568FxrbBMQD3Us+o0eIumB7pwZZUUIjpimB0=;
 b=IRW8Crg4EvOoFeKO7MyyWq99t/EyuImQRgNH+9QfsCdzFn6cXJjftHsStfEA5zY1nm
 sBLajX+YUKgPq5hUJIWn5MSC9dVmbtNloyGwCKAK70DyysJVjYFHJ7Oedom0ZvIMm2iF
 MoP4xM86cItu4sekw5cad9+LpB3U/kNG4jfVWnWFURHTy/+FgPL+iMUbkaAGQjkU1aGC
 NM0SkT7DmdYDWlsRjWNWwULJBcuN3/nXDAS5/wJzhNe30b3Uskf8Q1fvdNhIvRlWbTdt
 eYmpSUXfp4xSG0ssZMAvtm5+YdXxpgLXQGWpq+RnX4nn3dtTK7R00mu954QbDclgOJNP
 865w==
X-Gm-Message-State: AOJu0YzU1FnyMh5NTfUtAGeF29b7j5WhG+gChSD+3OtE4UaTcYPJZ8Kj
 s25TzfAvUFkdeh6dY187m6uq8QH+2X7mrhoZBt8cHir7RzGop/qrZY8KW0bFXQ9CMfZ/+YxgIt/
 H0B4=
X-Google-Smtp-Source: AGHT+IHzHPyU+n+Te9GtlFCtkODPx7Fjq9neQNQSI9Y91jzlXxzjaKDAYxIayDkTypZ2Tp5A2wBz/w==
X-Received: by 2002:a81:e202:0:b0:600:769:179f with SMTP id
 p2-20020a81e202000000b006000769179fmr6338729ywl.17.1706593065168; 
 Mon, 29 Jan 2024 21:37:45 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:44 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 6/7] crypto: Introduce 'detached-header' field in
 QCryptoBlockInfoLUKS
Date: Tue, 30 Jan 2024 13:37:24 +0800
Message-Id: <722845380ae359b452c525eb95103a1723f5a192.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1706586786.git.yong.huang@smartx.com>
References: <cover.1706586786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::b31;
 envelope-from=yong.huang@smartx.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

When querying the LUKS disk with the qemu-img tool or other APIs,
add information about whether the LUKS header is detached.

Additionally, update the test case with the appropriate
modification.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block-luks.c        | 2 ++
 qapi/crypto.json           | 3 +++
 tests/qemu-iotests/210.out | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 8ad7cc44a5..3c168aa86f 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -1260,6 +1260,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
     block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
     block->payload_offset = luks->header.payload_offset_sector *
         block->sector_size;
+    block->detached_header = (block->payload_offset == 0) ? true : false;
 
     return 0;
 
@@ -1884,6 +1885,7 @@ static int qcrypto_block_luks_get_info(QCryptoBlock *block,
     info->u.luks.master_key_iters = luks->header.master_key_iterations;
     info->u.luks.uuid = g_strndup((const char *)luks->header.uuid,
                                   sizeof(luks->header.uuid));
+    info->u.luks.detached_header = block->detached_header;
 
     for (i = 0; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS; i++) {
         slot = g_new0(QCryptoBlockInfoLUKSSlot, 1);
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 62fd145223..f8b00cdc4d 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -314,6 +314,8 @@
 #
 # @hash-alg: the master key hash algorithm
 #
+# @detached-header: whether the LUKS header is detached (Since 9.0)
+#
 # @payload-offset: offset to the payload data in bytes
 #
 # @master-key-iters: number of PBKDF2 iterations for key material
@@ -330,6 +332,7 @@
            'ivgen-alg': 'QCryptoIVGenAlgorithm',
            '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
            'hash-alg': 'QCryptoHashAlgorithm',
+           'detached-header': 'bool',
            'payload-offset': 'int',
            'master-key-iters': 'int',
            'uuid': 'str',
diff --git a/tests/qemu-iotests/210.out b/tests/qemu-iotests/210.out
index 96d9f749dd..94b29b2120 100644
--- a/tests/qemu-iotests/210.out
+++ b/tests/qemu-iotests/210.out
@@ -18,6 +18,7 @@ virtual size: 128 MiB (134217728 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -70,6 +71,7 @@ virtual size: 64 MiB (67108864 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha1
     cipher alg: aes-128
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -125,6 +127,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
@@ -195,6 +198,7 @@ virtual size: 0 B (0 bytes)
 encrypted: yes
 Format specific information:
     ivgen alg: plain64
+    detached header: false
     hash alg: sha256
     cipher alg: aes-256
     uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
-- 
2.31.1



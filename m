Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3378606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A4mICU/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIVF-0001aD-KH; Wed, 25 Nov 2026 14:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV1-0001Xe-RL
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:48 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIUy-0002CB-Hi
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:45 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c4d21051042so136841166b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634262; x=1796239062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=31yVhEX4jokYorPxCKoj2vIdTS7vM3ARNGO1RFm+TF4=;
 b=A4mICU/qzJS+lVmb6g6dm6eYe2UC2gpUHOms67OL9K1mxe+EexzJ/6pcIRbekJFUNg
 cuU2noFCGPS4mYxshr5hXgN2Jk1mFp3BMTxHbx3J3JNZbIx62Y9lNu2b0HdtufW3Q3ZR
 P2u8UcXSq8DvwMSHJPEH5EK4nUnvqvKi+QfJLi+MK9jaLapdZ/ISOv12soEvbFqTk9rr
 t5QeJ1huoPVkPYqbgHLZ0ZbnUornFFtfdX0D1J+Yef6qdocvrcsVQawlQIjg6OAx25RZ
 zMzvzHzjhnaUclJEv0wpk3EYCU8yw5B9mh63uq6gEQ4MXE1inZDUALXvRyFTMlHEj5Al
 xfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634262; x=1796239062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=31yVhEX4jokYorPxCKoj2vIdTS7vM3ARNGO1RFm+TF4=;
 b=Ts/I8cQKzbBPBWvOrfFL1l6aplvzvtxFo72tU+OnRh0pO2HNWxFRXOD87LpLTkRxnq
 cIcENAp4C7nJwwfHpG/8rqz1+GritY+6QJBRpZGsYymO1EXG6DLHo9a0I0Nwa8/eKIEF
 pY7TPSmZbmXphO1L0qWce/CWKrhPsh+twsPCcOUfQv/itcLw5wtT7orZM5WUzC5gDpZ4
 RFnsrV1q13RrEjr3dxVuT8UoXV3Xz+UjfjjuwEdeXxfNpx+OEwEzWn8+hNrZTUDsnMFj
 9oQPOMBI+KwZC8jQnXjuzP0gjyp6Cn6X+pQIzE2bldIaW0wks7CLums7G1kL8qffu3FP
 CNLA==
X-Gm-Message-State: APuU4Z+FndIGD87+Psp2rsIWUoqyLFTKtx6OHzCyB5zup/EA59Fnz2xi
 CXmy2hpkKEtBp6fbMJtDz9M2kjqDBnld71hc09oBbQQVxBzuuBpk6/9LlRcNVphIu2M=
X-Gm-Gg: AZFdTZfYxd7tSDPT6UpNi24E8dAjZDgsR2N5sjoXym9pAwMkKh+9Nb68U340RuLP6fa
 kXbETyxjWisutK8ULwCOLA2Q6nhbXzkW1+z5hRk8LXqeWHunmtwQTuakRJ4LH9msDlste6JDo1Q
 g5FAPp+mf0pb1AAhoo7DIYKBfS2qrjKW+yzruT/xXl+dAqpyBmCyRd7ypQgDEDPpEQUohhD9l/8
 Td9i8i8tDMqnKDSUnO8finLMPHLBAPdExOgpJj0Y0N9RCb08RsBFBVeLQGJWFL6WWLwofYts2rj
 VZA4H0VXr7R2u9whjewDpMfXiNAvCk243NN0IVlgbbwXzsn9PR7n1EZvZDxpuHIleG1e9dfpidM
 LHa4yZc+KvZNoWiZqTLldWJsRNLC+2S1t9OdruGElI7mUNOapFBZXv81S1ogqBv1tub9VrBStXO
 CUO/h9jg5sOARyBvqBPiyuyhUSf3uP0YHUl++fQdLkhaFuERCkwxL6qnn+MiJzwTgvOyk8SKJPS
 E+qBOpnSTVWSN/r3RWem9S94z1uHpt/ZFZt14UfC1dHzvFVUpAK3vF19KAUBLvInIDAYBaEiVld
 gl+WvdgbK3fTh+48UYjypoAAgwX8TA2/Dp9BZqzpi0+HE0ocob1sDpz4kU0KAVpxf3zFQLaKEti
 R/I4LIwSv5n4t38rwIyv5dbPzDj/v5IrvUUghQbQ=
X-Received: by 2002:a17:907:2d13:b0:c50:ca93:19a0 with SMTP id
 a640c23a62f3a-c513aab9bcemr1636547866b.40.1795634261328; 
 Wed, 25 Nov 2026 11:17:41 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:41 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 01/10] iotests: use gsed when necessary
Date: Wed, 25 Nov 2026 20:16:51 +0100
Message-ID: <20261125191701.93931-2-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
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



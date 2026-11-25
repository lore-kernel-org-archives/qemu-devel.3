Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFC606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IeWLcJdi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIWb-0001vR-1T; Wed, 25 Nov 2026 14:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV6-0001aQ-IL
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:54 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWIV3-0002MX-Ds
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:17:52 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c5127c7abd5so965567866b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795634266; x=1796239066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EKrW/KMVZQvUPv/4T0xY9IAUFaScpmhyjRdo5uGln3c=;
 b=IeWLcJdiCG/KMiw/2aT7mti2ZASS/Xti3BVh/b1ghPJOwiPrM+86QxZib9SMOIRWFt
 WN4l9LQ11tB/+vOVC+LndYqo1MZq7Czr/0af+Fq5oUdCnS4ACcQiTsSeFgSOl9/QeYe5
 VAnC/u37ycDGvDM6N+uqacw/QKGIAlXR8d6h2D9PJRLjBhmteDHMde30Xbyp5PruW+FA
 BYJQDRs+tjq4AdgsYp5873LLonnSO0x/i0A0XJxaOJjLuwrJALxF+BRvYzEIML6QIGSH
 E47BU1vitI2qsQ3ys6SyyomHerCh5fHABRu2ByWP+Tv4rdGbJXKVxxx566MccM1dxyPq
 dBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634266; x=1796239066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EKrW/KMVZQvUPv/4T0xY9IAUFaScpmhyjRdo5uGln3c=;
 b=RJ4VaNNa8TWugRsl4c1wR0csFWRDkScukUSS9Wwb8JKFTh5BRHLuyeV2ukID7bUgeX
 6zw8hf7UWfRl8BL3CcRssxCrsCwSqcgckhqneX7qbN2+TXvHoQfOQiImBDz+HB8XAXfw
 B19vkKz6BufFn9RdCvHoMpWG0P7qTj3Pyv6hDJrt9UUvYdFdo2mK3vYr9OeMSG0y1iy0
 RYpLnu2z1n8VVDEWt7DkLB/3SNnUTSytR90hixgSYwx+AMcrfh267JhKBm+xhAiiQjA9
 XgxJcce4kgaWPrth2t5SOEYnxPCFnmECbAR7nHMgihXp0g3BC1B5gZCj0ABiI5DLXx9I
 LnuA==
X-Gm-Message-State: APuU4Z/J4DMBrSFDxPaZw9U56hb88aOm5o3Z0McOSGnGzPcCXReb/Dhp
 jBk10WL5xUrhbqA9rWTJMlk5OF62rkuPOhm24sRLTDZa7F2num8qrnd1R3dgFmdgj4U=
X-Gm-Gg: AZFdTZff+yc4I4cd7N5DeFxOigxSSzy8HXZj4t2QabO7bN7nClGKVpugdHDOaKqY69e
 TVlDC0D7LAdOVf3FJOSsArPMdi0YctuBt6VsMCQaJQ80kNBe1eUtPjzHdO1Zw0B94IbQJmvgKxI
 rqGpICjcMerdWACz/SrCs1VHv7fac/lpGOJy5GkKsoxTf6Ps96AM3w50pzXWyrgC4CpXRwhYzi7
 BJJgHLxH+Tc1N7atD+5eEXdvPD+OHx1ZtFlsnOhCETfWoh7fy/AteqxyWY3fgbluUNk8xal7+E0
 A4LgYV3AkYBLIalYakHm+r3ypDCuQmKmZ0pfshkkAx8rKf4ENBKTHOZEsvuE+IXlDxZEj+iPOUx
 Hf+Hy+wbUg4YeKONDe13+vLWRYaTPlc4NEoxciJnHcLA5P2NwQR5xSGI+w72sBXvPD5e71jSvYt
 uFQCoQbeWDJtaUIssoZMDoYiq+w21qrL3AXji72Cl0oYYIHaEwkg4XRND4N02DcqOrxAPU2EcHo
 1mUXI88Ak2L2sOon8ys9VZzaOpi2EdzMme5SsmGBu2FXF/yBzjUc971JRFpy7uNWmqSfs58t8cp
 RAtF9uA2bCPgs4yuYfcRFn1icwiz6ahNrA66nOnWi6HzqudU98ucw8WSkp7s+00SwuLTZ8VPDHW
 L6uWFuWWzM3WnoSfPtcenufGcvv0HqJQns4WHub+7
X-Received: by 2002:a17:906:b1c8:b0:c31:9a1c:de76 with SMTP id
 a640c23a62f3a-c513a5ebc76mr1134942466b.14.1795634265951; 
 Wed, 25 Nov 2026 11:17:45 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b003eacsm672686266b.81.2026.11.25.11.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:17:45 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 08/10] iotests: fix possible race in 145
Date: Wed, 25 Nov 2026 20:16:58 +0100
Message-ID: <20261125191701.93931-9-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125191701.93931-1-bogorodskiy@gmail.com>
References: <20261125191701.93931-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62d.google.com
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

Test 145 uses "-incoming 'exec:true'" argument for QEMU.
It is possible that it reads the migration input before
processing "quit", so it'll report an error and the test
will fail.

Fix by using a migration socket, similarly to how test 181
already does that.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/145 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index bbc3c34c19..3711250c7d 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -25,8 +25,11 @@ echo "QA output created by $seq"
 
 status=1	# failure is the default!
 
+MIG_SOCKET="${SOCK_DIR}/migrate"
+
 _cleanup()
 {
+	rm -f "${MIG_SOCKET}"
 	_cleanup_test_img
 	true
 }
@@ -56,7 +59,7 @@ else
 fi
 
 echo quit | $QEMU -nographic $SYSEMU_EXTRA_ARGS -drive $SYSEMU_DRIVE_ARG \
-                  -incoming 'exec:true' -snapshot -serial none -monitor stdio \
+                  -incoming "unix:${MIG_SOCKET}" -snapshot -serial none -monitor stdio \
           | _filter_qemu | _filter_hmp
 
 # success, all done
-- 
2.56.0



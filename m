Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D0CD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRFd-00087l-98; Mon, 11 May 2026 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFZ-0007lE-K5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFY-0006zV-1D
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:04:49 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c70ea5e9e9dso1770677a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508286; x=1779113086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=lnFtAMeOgDTH+s6TX1fs8wZfB8Vml9lbnQEPPOJuhiRwMou9+Scu1bVPcJZEQLjCx0
 VL0AcgTqpOjXIafX1cSd4s/+F/DwU3/FX1B/hK5iOVhCuCJbsWVFuDreeWPHVR1imqTz
 02ZLNb9nxfyH6CTIx6spe+R9mIizdaBtwvaLYOWLpUocnxEidAakhl8Pa6htm1zmDOLi
 WBZxDqVW3N14rebFNHHr4qR5fb/BSoYZ+IJG1EV3rUj3sLoreDxkB/2uN9jNp1NfZvt0
 CjxPcHSARdor8ZbGlQTAenqDt4gmyYmGDjg81s3Sb66Q4TgipTg1hyrxVkg7+j4CfEoc
 TViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508286; x=1779113086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=iPiUG+tyTVhNv9OTbwcYiTPeAuAb14n3NDS/8VV3OuuGkVxaDyN9zVQMtUgBCuaJFE
 mSRBntCq1tjM5iW3G2VkIb4OIJCalEq7w5Ch52QrYedh7An3oSSxEMS4xiWYcddFFTlQ
 ZKoV0+eKqB0UWYEWg/5LHYqQqvAt2I/3ys5aKG7WNXsFq96P3sAa0mHzPqG8L1CtA0yj
 nej6Ntl/7mDbCKn1AriU9TFzTB0gI9C5/EYXgINd52DSBPLjHrsHm4gATxsySEBeTa0C
 2uCS28mt1W/CUNZOwLxbEcR1DcBihgbL1lYnAWeXdb/hfhdahFKz+W3edE58FnQqJ6JX
 aKnQ==
X-Gm-Message-State: AOJu0YwDTTAQCZVYdqRaaYOXQujdIkd4Id45R8XefvgVwtl6WkxidwKO
 YZtxKVuMMcowA1H9I/weJP8KyBJOUogq8PFBm1Ne42tSnkiedYFemq1irJBIcW4e3qU=
X-Gm-Gg: Acq92OH05UOOhEHn5SAHx50MVtWxxxU4eKHzZyOKAZnORD3gBdRR2RE8UGBxoUlfCHS
 yGROXvGq5x0YTemEs+7lTwj6H0Pel8cnYZcpMbgtnRfT1cYa4pSKZUrtFnD8D1MyncXJ87GCc2+
 hxReVu/ztCs0gfcjg8jDHd4SJWsyEKsTbPNCzkxa9l9SsxzY/fs1a4coJIDeoJBdeNFi64e61as
 Kqm38hBecbelYg6ZscBtY40zYBiN4M4f2QJZlrYXKrm8NdSQoC44qjB7CcynjkQQ2uxSUz4dc14
 +YInXN9jm9dxugcdbfvjVpRM/8D0ksjdn5oOirPZ/Tg7soOupk63guL9i1Euwad5umQ+TFOl/C2
 2spr8Mvn0VW28RLPT1e/uleljy9qizkJeSJ15Ybc0A6V3HR960z1yy85rKv5pd6ZtYP0Eibzuaz
 qdMbxiBQfqRowgL98UFW/59DxYbVQujhxiSQfRmDh5i7x8uJNbxF35u1N1
X-Received: by 2002:a17:90b:2750:b0:364:a173:2d61 with SMTP id
 98e67ed59e1d1-365abcf240fmr23421312a91.11.1778508285804; 
 Mon, 11 May 2026 07:04:45 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:04:45 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH V7 01/14] qapi/misc: Fix missed query-iothreads items
Date: Mon, 11 May 2026 22:04:03 +0800
Message-ID: <20260511140416.28271-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0



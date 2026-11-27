Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DD606A680
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C0seY+Hk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxBz-0006cc-0E; Fri, 27 Nov 2026 09:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBv-0006Xy-IX
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBt-0002Tq-5p
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so78985005e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790683; x=1796395483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P75DXv3ag68dY9Sm9sUF7z0ZtWxtxdDuGO2evQJXzes=;
 b=C0seY+Hkmo1dSFhTPfZGoUAMTKdRtRThnsvF1wY6jYdDAh4V5rdbZFNyyX0OmIcfJ5
 /cYEv2O0QI+wgNJvS7pvFu5ID9fBegEDZHsMmclPedNNWHBns+4wVsFWkALCVrg+xbme
 4hC5ZW+DsM1/q1HfkuPLYTaL3gUof6KTYmIjxm+Jyt6Oor9T0SJJzGI4Ag9GZS6JrP5Q
 t6/sNTElhlC4PvYlqHYHdI7dBDfACVmXc9lsCS5l/8wDZHy9J51eEIBdrgA6jKQRjN6m
 HaqX6JdGJcWXkQXgL7TtamYtjY2n14jAdyPwENatXVGDxVvOxkREieBsuCxirkaSTWED
 Pdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790683; x=1796395483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P75DXv3ag68dY9Sm9sUF7z0ZtWxtxdDuGO2evQJXzes=;
 b=azyskSCHhmvWxeAxGJ5GHtVJ2VkTe5Tbb+M+Tk8w0+oWHWLgwD8HeMgaYbnwy2Bq7K
 PXWVZFiDC+puePcFod3+l8yxMFsIlZpiPvc0RaLHJRUW6psDaSmE9MLh3IlrUgMYME6J
 Nztsd095zSggghgK6ooGicAWFfq8jyVHRPoPQw9rBDMq4KOVHxMcBVV6izLQSJJPWeIN
 G2L134Omn/WDZcq7OLL2ydvwH56MfBsJ3eMdR1LuM2MsBaC0xSDqULLP9ZBhTZfFGr51
 pRWK2ufFSAXAM3RmJ/qaHU6dViDjTtkHD1oup0XDWWI1f/Fa/pBI+m+q+gSynNioxpoD
 5FGQ==
X-Gm-Message-State: APuU4Z+36mudBukJpn3wF9UsKUwoiq9hPorzzU3UutOgTVG+apo8jNZJ
 k8758aYMIVdxj/Tw8f5n5ZFKkYr/D01y0NfwLYRPZOwwzBoO6MPsPnIfEYyAmUcUi8bezYNY4uE
 JWnpw
X-Gm-Gg: AZFdTZcfgqfkCJ1ZMKOWqx8X7XZqRWF9f+OAhqH5Iw+RIlzVQrpQSccJq+pmOOe3CFz
 yVfKmqEfY041hZKdediu0anS+0FYUMyVheLkBduc68qgQ9CVCPXQ0gyTplXIBHPbh3KGl4THUGs
 4Xj6lfHgrk7hblU0uhYu1P03MBGJPoU4r/10WW2x0ltk6WEWA3k4pAWax5CxvRmcIL5J2YFIrbX
 BjfcmEbH9POgq1NwHea2sN4A2pr7FxL4tKVf06p9vmW1uWqD3U95RUewCgvZjk9HDn8tmwgoUqB
 O7xqixNuI1aIx3uHFeV3UBzRoI5OL/BE1KRLlKx/bhKRh1pa7/gECJ25Berg4pnGPjKy1UdE2Fm
 yxx2Bx8Pdlo/arxV4XjekXxUXDchiIGch6vtmvhoXIgC3d+Uks4CdxzrrIZnvVeGGRr8mRj2j3r
 zWzwFn91vL/ArtyXWITXLe7TU2UvaQ1nQo8wUPtn9CRFf87QytQBbnA34yWLIvGEk4ZbbU5rl7H
 p+VurwO+R+FIdelepLCVA0Hq5GATHwyZ3dE2he/9ygk8G/q+Kdsz6nkBKRATULw28r8aNbrc9fv
 8mrRSzk9iy72m//bECdUbkgtex3pzC5Su9jxOfSNSTqMcTiad5YJpU0t60vxKcWQahEcEkw2XkY
 1xp7WtFqHxMaD9yDnZPS03YZjkj7XX8G9Ng==
X-Received: by 2002:a05:600c:4e8e:b0:4ba:59fa:510e with SMTP id
 5b1f17b1804b1-4bb8893014dmr506669075e9.23.1795790683678; 
 Fri, 27 Nov 2026 06:44:43 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm216862975e9.3.2026.11.27.06.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:44:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH for-11.2 3/3] hw/block/pflash_cfi02: register VM change state
 handler once
Date: Fri, 27 Nov 2026 14:44:39 +0000
Message-ID: <20261127144439.627586-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127144439.627586-1-peter.maydell@linaro.org>
References: <20261127144439.627586-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the pflash_cfi02 post-load function we register a VM change state
handler callback, which is a one-shot (it deletes itself when run).

However, loading twice before the VM resumes means the post_load hook
adds the handler again, overwriting the old pfl->vmstate.  This can
result in a use-after-free on resume because the first-registered
callback does not delete itself (which is permitted) but the
second-registered callback (which is not).

Follow the pattern used by vapic.c and only register the callback
if it has not already been registered.

Cc: qemu-stable@nongnu.org
Fixes: be71ba48d5c632 ("hw/block/pflash_cfi02: Add migration support")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/pflash_cfi02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 8d130e14d1c..28e8c27d72e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -1070,7 +1070,7 @@ static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI02 *pfl = opaque;
 
-    if (!pfl->ro) {
+    if (!pfl->ro && !pfl->vmstate) {
         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb, pfl);
     }
 
-- 
2.43.0



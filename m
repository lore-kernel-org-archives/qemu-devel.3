Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDEA60A380D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PH/uDbvf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDT-0004JX-Vp; Mon, 02 Nov 2026 08:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDN-0003kE-F6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDL-0002MP-MX
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so26730355e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626602; x=1794231402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6ucXLCQAjOKmXIjAASK/Dned4ux8wG1Xo7DbJytXyU=;
 b=PH/uDbvf8byW5JoEzveNRS+jsOsrlUDsu6mhFN6iw1EbrHQYVDDFp7DMcdihrTISF6
 Uk+Y+qsmgHV7ntb6lo39kt04JhUmXS+HKvUNn78zYZe+5iAr/dQO7LrWV5h/mDK0AGRx
 QfMWt2hKY20aq69aIveMKGFVPgK7zYVolIJU/DsbmDC94tqr0hRmBY91RnnPvX1IUJib
 3T4YbOgbpfNu6DazJDJfTO8+IAKKet/bf+fcqJo9RMlv+Hya6vpG6Cn0t/Qbmj/aQIkw
 BLI7kI/w9ZwmG52SlDbPIyXrOfrMfdsGS6IvbfUqj9/EH4A13YxDZ2kTjQvY9wUyLO/o
 Bq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626602; x=1794231402;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n6ucXLCQAjOKmXIjAASK/Dned4ux8wG1Xo7DbJytXyU=;
 b=WlJ4I1GiEwkSAzyPbYWBxh/PSa8lJVHTA/A+0T210Kfm9dgdnNJegKt/imcvjX1/eu
 LuhDF/9ex9nOGWynCqh3t1IqI84bBOumPOABPvj6DuQILLxGEFM3nTEyEBG/bFRfAcAl
 yb8RrDKvdGwBrPYuXGa2eYdNtM2rwAgNyyg9tovctq+1DN4JM2YT0UcBwlQkJE+Wio/C
 Hvnuhih5Nqsbpwptw2PZRtYia4hDAZJRGsZs4Z6u8EEKISima9bUfBKPBpcLFUOv5O3O
 mdEn8spyHxNsV9b6D/RV+qvnNCpBcwr3Y/crfeYNj7nS69juN8bC/NHNsQAj2EaIgbqD
 y+7g==
X-Gm-Message-State: AFq9FYK9aAXiOxlXts3KPSgBRUZNPZCWYRTqgu3NGXil+UXVzOBQ4+cD
 mhCojsuJFGoxX9gQNXWY0o76AIIc5WmCV9Wctx/deit55yngpEfDNlVgYZeICDZ5GmYP/Blh7hU
 9awvUUVg=
X-Gm-Gg: AYBFou0w3SSUPVdN5ZsaDOBFhk1xD5ry9dfQLjE/BdBd0JuNf2zooksRShLiEajAhQ1
 nmgsobCW68koFcU2oIxNBCHRVWyqvLTr7S1Z18RKgoZxW01wgBnkP0v7eYOl9IxmjfKsVy6hnS0
 66Vpys7Hm3zsAvxiDqvR1T5cjcCdjjiPuWGa/TozetnsDvr00eH2oJE8VPYujXCSP/MnyFKtDd1
 ixKxtbdnhkkLdyWNBIWAHM3GyvmN8P+nmk5CLt8ghK2aYn7o4z4+L7W//kwnaN3tEsu8FJfd2Ol
 OsbX2MuET8ctiSYZzIt7AEG7Ggsvw76WHftMtkhdZPwsi/wECINUGHFJV2+5I920jNK9e2jvaRe
 pNRVQXJNSsiaoD08J9zHzFPPDF+Lg+PyQxfSUAN9hmE9ReF7Rf1WCWYkLl2mC04/mr5vwh2GehB
 /kfAR0x2U9JpB0b3AvwkEQDtG17f988btFg8SYrqqYFRI8vjZ79FxL8M5L8PC/Mfe4Spz/5uAcZ
 56VNaboeRkh/jw4yZPIZIZ5pzQFuQXjbEl0szA4h/r8w8n8PpBA7ZUoBMhHWUJcs0AGVEq9gdgo
 SIsJL15DexsYpVmUGgAoIVvdgyznqhXkbK2DLFMK77y1lqCen42+viaSOsHwb9CLJew2o8CIAVQ
 p+DFmTHGU475KGK3Scp8ShihqWYk5t+AT5w==
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4ac181e75b7mr245813245e9.31.1793626602075; 
 Mon, 02 Nov 2026 05:36:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/47] target/arm: fix bcm2835 migration issue
Date: Mon,  2 Nov 2026 13:35:47 +0000
Message-ID: <20261102133547.1375701-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Bennée <alex.bennee@linaro.org>

We don't take care to force re-validation of the config on migration
leading to a crash when the defaults don't match the migration stream.
The other frame-buffers seem to do a similar thing in post-loads to
address this.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4668
Fixes: 5e9c2a8dac19 ("bcm2835_fb: add framebuffer device for Raspberry Pi")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20261030141046.2710206-5-alex.bennee@linaro.org
Message-ID: <20261029161310.2065290-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/bcm2835_fb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index bd58f625fcd..c5731521b57 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -352,10 +352,21 @@ static const MemoryRegionOps bcm2835_fb_ops = {
     .valid.max_access_size = 4,
 };
 
+static int bcm2835_fb_post_load(void *opaque, int version_id)
+{
+    BCM2835FBState *s = opaque;
+
+    bcm2835_fb_validate_config(&s->config);
+    s->invalidate = true;
+    qemu_console_resize(s->con, s->config.xres, s->config.yres);
+    return 0;
+}
+
 static const VMStateDescription vmstate_bcm2835_fb = {
     .name = TYPE_BCM2835_FB,
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = bcm2835_fb_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(lock, BCM2835FBState),
         VMSTATE_BOOL(invalidate, BCM2835FBState),
-- 
2.43.0



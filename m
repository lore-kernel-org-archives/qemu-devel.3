Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xFHVEfbx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnJu-0006Kb-HB; Fri, 30 Oct 2026 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJr-0006Ee-6D
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMnJp-0002EG-Aj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:10:58 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso7707645e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793369456; x=1793974256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WvmJcfzcBZbcUM/VumQm7BRuMbxxTTlsqPpIRvc+9u4=;
 b=xFHVEfbxpnDjdP6Az4J4FgL38niL7U3YRIYgjwup1QZ6WyGkARVGPo6oqgQISvx5KB
 B5N1CUlIQjj1TF9NEosyNFDt4HMp2/NiB5K0qJChh2QAjAhgPS0e4Q3lsepOAJ4fQFhl
 +zata6j7QTZKMWt8yw+JtVYEfTiWhIZp/ZFd6dypYb6pJHn1HaAe0oei1nNHvN5+lKlx
 +KtJ1iDSFrBo/forcUxC9MPJBQacSn9dqzrU5L6yvUNwbo6o5RWx12i33J/Ki/07+TqO
 AKUzZaCYmouDUTb3ccvhIjB106oAwsAnUgILoX7wu0SnQtCfIVXKjGC4lr5XnoVghwTF
 5Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793369456; x=1793974256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WvmJcfzcBZbcUM/VumQm7BRuMbxxTTlsqPpIRvc+9u4=;
 b=otNRvo2E71CMu+z6EmauGZoaVhN0lkGcMa/c9IsOdCSl9MS9bVMlDIWr/e7L7/aPZo
 /yo34apny24lhGdC2hYx2X+BURE2PRNAGbwPpDGoOQwsszJz+uG/hLtrOLu6OnOOdHtj
 Z0ViBAmEUAnfey8JAjvAFA0EPkhXQ3gXL4b69Icaz6NuIm/a2a5WHrukXs769ZtcB3dK
 E+2sxkVaTh2AgvWe+YawLKd6+H0q4ZauaHHXrY6N+/Ac/Okw+uQO0TpmisOlIG1CIOa7
 bBG3JYplzL+e3Keb/kWH/8dfOJOtiE3xjNjOhpYsXzpI6PG/W3CGIEVO3lVh/dU0Vklr
 82tw==
X-Gm-Message-State: AFq9FYKTtpCjwWUykYli+UIn/F9BSsTeDS6cCZJYKmT2Elxw+0ZE/fmh
 mzjzo6/DlbFrptNXkHJEwJXu2V38YA2S+sHK8FxNIxOcO42vz3mG/TRMGVl6SwwZiubPfkJRex2
 NgZaviLY=
X-Gm-Gg: AYBFou3A0wa8kUcm2w0+xwy9dzzmCBFxXtEr8jkPAW5cwXlduTSBZXZ9RCxZ1PHFTXf
 8bEsgGLfaeBNWa92mhupN5yZcIgVVKVriiA9rbzUBhhdRQme9/YsMfCQVef7gVthsntGGypsgVy
 DASQcjrfbk3EVPJKwSwC2l7WJ3eq9LQbPJaI4SaxUPlTZmBqyGqKCWKk9IrS1XF7e9GdBD3XNMW
 r2uHEV3R1xsk4qMU9iYzc4uks2PAxR1jmfGuHDDRoOP2HzcewsgB9xI9D42kKx/sd1QfaWV1HLL
 s6PyQmPVmEA8hn62HIp7q5DAxTH22MFSGniiBPvXbFvsCuw9nYEg5UO0dk6oCPDtUbcoEZ0YvXc
 DD3Ypt/PBDiiS6sGhuKj3GLMXF7opMrcMpsoVJ+KCEnEY3zj6Ket6P/QvPJ/XHKUWsKgxz/SnQ9
 deT8S3yLPJrXs8G7nTQwyUIi80iPx7Y4bC5Sylu4MVKOLBSOgI48SATEIhcS9NKfyoZl2zJQGXI
 InnEztRKAsfg02F5HxzG5/HljARot7v6gkPoPEgiIe5felsJEPu+khS1njkaGRezJlwE4mQ4gaL
 8i1459GNyx52cIJFzcgxMT0bZc2Q
X-Received: by 2002:a05:600d:82ea:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4ac17ff9be8mr58270255e9.21.1793369455744; 
 Fri, 30 Oct 2026 07:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm99393125e9.3.2026.10.30.07.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:10:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E3C35F9D3;
 Fri, 30 Oct 2026 14:10:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] target/arm: fix bcm2835 migration issue
Date: Fri, 30 Oct 2026 14:10:46 +0000
Message-ID: <20261030141046.2710206-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030141046.2710206-1-alex.bennee@linaro.org>
References: <20261030141046.2710206-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We don't take care to force re-validation of the config on migration
leading to a crash when the defaults don't match the migration stream.
The other frame-buffers seem to do a similar thing in post-loads to
address this.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4668
Fixes: 5e9c2a8dac19 ("bcm2835_fb: add framebuffer device for Raspberry Pi")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20261029161310.2065290-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3



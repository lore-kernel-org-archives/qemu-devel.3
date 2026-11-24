Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40194606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ibFg3Kbz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnHE-0001Xc-I6; Tue, 24 Nov 2026 04:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHB-0001V4-Rm
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHA-0007sL-79
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso52081105e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514243; x=1796119043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h6Duc2aqV2WdFs2JfMbHaV2pwf/cwqHCBfZDk1KG93U=;
 b=ibFg3KbzZMTslTogXYuUYAT/bUY2rTohMFPuFIqA/WIHjAOSzebP+qm1yY2EouopiK
 dOFB/tI1G2ivSZgBmpYenh+ejM3ZoCwucPIQ84wCV6cTnP9OLb+WWH/3j3eg07EGupIV
 3ZHgrpuPNPQ8D1linBnMl1Bg0sdoLSab3dhZsN9sPJJbXIkZIB5sj92eH3pNh7iSog/G
 KzOmrLzyFbiaJc0654QtYI1ex0DvJntxTQPdyoigyZpuFSeEXvmlYtSDgr7KM6ry/CPd
 8UmcOfm6puPthk4LBHh0BOa9ScjkdoHIExowbdaDq7DJ9Zpp5nZy6Lq7Pk0UK7ii8+fM
 9fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514243; x=1796119043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h6Duc2aqV2WdFs2JfMbHaV2pwf/cwqHCBfZDk1KG93U=;
 b=t+Fw1qWj22590ibb0pBupaJeebjLi8pJeesK1ZqmFZ2iSqAgrwDN8Erx5svFloM+Ry
 DjZY5W2BPi3THugwNdMFyag7mTNxKvXh48LPwR4SHai+HgD17bpFQHY8YNndVchxUXx2
 2Rw/MtLXzA4jFPnD7XdIPks3S7gL7UczjK5wJGEfy3hybjfCQmVlfj9bDWhKeeOaFltO
 SkurbV2W/RSOWw0El5rTESUzvxLf3tdmkGTzmZPzbPLK4Us+6lZAqmY29DOuATSZjkpX
 2gHKDYQpde4UNR96z2jV3eYL78ZESF0xNvJd8W+gxuCHCVuzxvO4r0FwyXSlnWv4MxG1
 pdnw==
X-Gm-Message-State: APuU4Z/rEVVYHhgnImTOIhXGi+ZJLAWnTDdWX3/NPMOxA2kUoSVIgwWP
 q2UiX8oUcbZIMe1Ts7LrUJ1MXI52WTFrdFGL5iNaqBBRYkxvro3U6FBd/Weaedxop03T9tWGSWt
 tOGqK
X-Gm-Gg: AZFdTZdrY7Na9vYkXJEGsX6Ya+44AwfvtzHutPEauAPXIlAgc4y17kQO9Ljx30q1lrs
 93XXveKmnUJ4adjSi+Xw8GCuRLLVxX07wppsK5rN6s/RYjoeh/d91ztVt9kNqMNWNkKlnAs+S1O
 Wy4lT8nSpZQGOgZCCvii6q3fruTQLkDIHGBpQ3hWEwzdeyrctrUilGYwzFr44yTsB9cxDsareEq
 JOVAosKrSaZ5w4GUEfQE9v9xGYrC1HqdeaunqdCqXO7Jgedrm6+2N5K1nrCc7aAkZl2T/9+aA5L
 X724FLRCA8rpav1u7pkUFUdCEX2V/9ALNHarSXT4SYi6bNOkgIKqNmYayzFwCIAI8HdOk0dUggY
 ka36iwxhmj+IzzfIr73n8K0Enpnws/3Z4duIogiqjHvEp9pQG3gY4nh39ga8bsquYEkVdAfQAWo
 F5ZDN2clV919e+QyolU8ax6QPjhgwswoQ9GWcUc4C0Pj4PLr4QqD0Ma0CIiEywgK492bQ4Q0T3N
 befMxalYDH6oISv8H9UBgJLSnCAZHJiFr/jcFkEw5PzooEAWJEjT8gNPcR6q/Gff/T5FD7i9f74
 SD6/vzws9LwaAjPlYO3OhZtfk39cIWe0VzUS1kP89XslSFiXLIPZ+0kQtHQ1glmYunKXBG5j8Uz
 sB18bcHD0SGXv5+xYvSljMsFMDwgM77O8w+E=
X-Received: by 2002:a05:600c:530e:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4bb887fe8f1mr275213565e9.10.1795514242671; 
 Tue, 24 Nov 2026 01:57:22 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm783591885e9.4.2026.11.24.01.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH for-11.2 2/4] hw/display/vmware_vga: Check for bogus FIFO_STOP
 and FIFO_NEXT values
Date: Tue, 24 Nov 2026 09:57:17 +0000
Message-ID: <20261124095719.4126146-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124095719.4126146-1-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The guest should never program the FIFO head and tail offsets (in the
FIFO_NEXT and FIFO_STOP registers) to something outside the bounds of
the memory area it has defined as for the FIFO via the FIFO_MIN and
FIFO_MAX registers. If it does that, return a zero fifo length as
we do for various other bad values.

Bad values here won't cause any serious problems as we were rejecting
offsets that would cause us to index outside the s->fifo[] array; but
they're better rejected. For safety's sake we add an assertion on
the fifo cursor before we read it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/vmware_vga.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f7289687319..49b8f94b6cc 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -581,8 +581,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
     }
     if (s->fifo_max > SVGA_FIFO_SIZE ||
         s->fifo_min >= SVGA_FIFO_SIZE ||
-        s->fifo_stop >= SVGA_FIFO_SIZE ||
-        s->fifo_next >= SVGA_FIFO_SIZE) {
+        s->fifo_stop < s->fifo_min ||
+        s->fifo_stop >= s->fifo_max ||
+        s->fifo_next < s->fifo_min ||
+        s->fifo_next >= s->fifo_max) {
         return 0;
     }
     if (s->fifo_max < s->fifo_min + 10 * KiB) {
@@ -598,7 +600,10 @@ static inline int vmsvga_fifo_length(struct vmsvga_state_s *s)
 
 static inline uint32_t vmsvga_fifo_read_raw(struct vmsvga_state_s *s)
 {
-    uint32_t cmd = s->fifo[s->fifo_stop >> 2];
+    uint32_t cmd;
+
+    assert((s->fifo_stop >> 2) < SVGA_FIFO_SIZE);
+    cmd = s->fifo[s->fifo_stop >> 2];
 
     s->fifo_stop += 4;
     if (s->fifo_stop >= s->fifo_max) {
-- 
2.43.0



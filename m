Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA0C109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Ywn-0005yH-LO; Tue, 31 Mar 2026 09:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ywl-0005pf-J3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ywj-000492-Sf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:15:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-487012ce896so35233955e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962952; x=1775567752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0hZfLbUOtDPdrcYCCS73D5HPlF10V9o2G7my6Fk8kI4=;
 b=cxPN9ZzjjfZDsDreJLxXUl4kCsd+rUFM1GC12+n5zm06M26Wlx8dUdwwzzQBCRu0nv
 nIkA2uiGoLJkUV8qwu38/qn8W8Q0M7R0C4iI/nk5wJakTHAs4XjiF2+3gJhJWfIPD8yt
 ZO1bTKTbweaI6Sg0b4k/eXscUzI2QLefVYXTyfr+/R63Y2CBgiH/tem189/Knjtxfcs6
 HcA0k199EJMO0ts7QUIcbt5N4OREWDyw18wIJJm1rsgXWhTsYkhvETTiq40P2FcFlB9w
 0sedcvMSrtzCzpgWQpr9I12R1DumbZathWdRKlw8doyXZa/gn08uOLXhvsD4tsfDOkAx
 mZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962952; x=1775567752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0hZfLbUOtDPdrcYCCS73D5HPlF10V9o2G7my6Fk8kI4=;
 b=i9i0c8c13QxI9xJCG/C6kxd3Ls6OlubZmVnLrX5mb9n0VjAWbrrbZJDfiGrcjkPwW8
 Jycam5zjR301J7D8N6+5N8Mz+X7R9CG/53n+jprIbTJMhQR7ZTFTgl9Dd7jaod8BsKOf
 KWjuhFlCl1R+skO+gRrhrPi0nAoYNGRTvyJj7GUvrbcc0KsIaWeBatOUXP4ZMvU3xuTA
 5Im2kAOPeRXWUMZOjL2VDzeEpvG9tvaTPk7IyE/ogetPDciSNGXRevjQzKMjLPu4gmf2
 n8tUz313PWZ1/z+Tgg9lFmvZ9qOmwYxHLOEozoAIc6LnM8tkFh3aLTwZ4VxUgUaVUHNW
 0jLw==
X-Gm-Message-State: AOJu0Yy4A+I5RlTMUb9xntODD60o+J4y07QcKb40o27gnXGJgqG5mM+9
 7NoQt74sgT8ee3xyY6ypSRTuWvsAlRXep/DMa6w90uLvp9Vqjn4KnuqebHy9aWJNcMgli8Eapsc
 tFTGigzM=
X-Gm-Gg: ATEYQzzCc/uKhiMuDd/LRNYTVegW1q9ZJOsVPoq1pPRPHwWGpIhtszLI5IL5FZHKSeA
 Qee70KcGaQt4QGFjq60ziL3xSjXg24Vst/4k93gxsPnHSR6SlinoHCvI0xQB7/c/8VVhmo2QTmc
 jrBJkAwtXUgISAzKiV85FiYFkhVJWZWRWlwjxq79DrhM1n1yoXvlRPdvqTSJu7Gmfz2t93HIncF
 4CaPGrygDgwbJNbL0rU2Xu1Ugs5CtGwCrFg6FmaHc1IILD5RKVu9oeCrGMpzyXWH1WXM+04u11T
 5AXehohOsUJ/JfM9ohF428ESNN9QzqHh4UqPIDKcWXJrdnP3S7w7yrJl3L6I+BvBLYWprrtKFnU
 ZUQRysVA0NNOOy+FstnNIihEnKvQCWLck6yU+EiYf5+2gs3bMbVYFeowkn7nvUPNzsCq7h4PesR
 sC+G9f4PzJYKtzvnHA5CPU/vGMfxGK5u7eqDhAXBw7lKKV1HdgsxJeb/s+2sX4hxw8KOk=
X-Received: by 2002:a05:600c:1393:b0:487:288:1199 with SMTP id
 5b1f17b1804b1-48727ef16c5mr290963745e9.28.1774962951574; 
 Tue, 31 Mar 2026 06:15:51 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887eb5aff3sm47341205e9.15.2026.03.31.06.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:15:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] backends/igvm: switch to PRIx64
Date: Tue, 31 Mar 2026 15:15:06 +0200
Message-ID: <20260331131514.21152-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Luigi Leonardi <leonardi@redhat.com>

Use the PRIx64 format macro instead of %lX for uint64_t values.

This is to improve portability as %lX is not necessarily 64 bit long.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260330-igvm_fixes-v1-1-03587a5a808b@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/igvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3b5edf15213..50f0d6fb9a7 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -187,7 +187,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX due to existing non-RAM region",
+                "at address 0x%" PRIx64 " due to existing non-RAM region",
                 addr);
             return NULL;
         }
@@ -198,7 +198,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX: region size exceeded",
+                "at address 0x%" PRIx64 ": region size exceeded",
                 addr);
             return NULL;
         }
-- 
2.53.0



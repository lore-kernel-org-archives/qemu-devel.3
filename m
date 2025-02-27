Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F88EC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhIX-00078y-1g; Thu, 27 Feb 2025 12:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGV-0005Cd-9t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:43 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGR-0002LS-0G
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a823036so12282775e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740675685; x=1741280485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v8PhnXMjZeodBD0z3UBX0mp4g/I3gCrKUSNVDYtiv1E=;
 b=oD81KmF9HL6Spe13KPVjNgRCcy/WvNPUhBJ/tGNnktaeawEPR6u9LriSpQBJ1OKW7u
 7cRO+phn9Vjtgc2I+olNaIIA7Je+p/lQUunNJDjk7wMRz5DIA3w7ZWdYwfxAFNHoZTM6
 5iuah0vTQdBgKln6bYCiCqjriihkNMCXIwvrl16U+tlYjjojswxUMY/K1CMUA/yQCt3d
 0JiqBIAn7ZJRZNpqx7IPCU+3gVfw56KBKuxJQ+q5wvZbyu907u9AlI+XjJLVFqUi3EJc
 tOjDOdF8eG68qH2IB6/SVTLgX+O+0FRqeQ+H5prSLN24jbSdrN1PDS2JHaHx8NhAMwU+
 0NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675685; x=1741280485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v8PhnXMjZeodBD0z3UBX0mp4g/I3gCrKUSNVDYtiv1E=;
 b=ReQDIYbGllZG457kzY8QVffzHZaiVfYgFHFWwI10Joi9eefVCuLmYcUR3TaxMMOuv1
 6ByiaHXNyN/gYIuoM1x9pUmRBolRtQ4GXC6P+6LC2IREq+Vi3RLv0DZkIkUDv3IePEKV
 Owfmge6wmSpr9PdFUc8XfNIk2Ev87rRQMmE10fzvBRE9fAMABcik8OjbmjLcENYpWNro
 5PxCCpa2DeX4YfSJork4J1ak1DIHgewjoks1e3lD4JsyqWxVLBAmROOk10kqqGx1bbEx
 QTdrQqt8gSwVXruCXdDd8dkcQquMx430JPRHMD68w2EMxTW9oyXsqBqRqDv4Npz3hlJJ
 M43A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kr45v1fk4+m9ynWuEAeFKKLj3LMhLJB2X/OKTAoRjBf4pptJZl4Qra6E1clpcpavUukgJbQGPCCM@nongnu.org
X-Gm-Message-State: AOJu0YxiYzWG4f4qGG86/TAvwpRkKVDUF2XcEY/depfK9VmvRRR4An7A
 he+RuT6910IAL/bgbOujobC8sSZdDKpoThFrNfluOcA85mo8UlLn6nmVqmj46uI9XlGnf6GdYvU
 8
X-Gm-Gg: ASbGnct28KPotDo1gmAEjRjEFIGMrbOIYBLxvjYRMllku3QHQ/UNRDiZbwyZO3ksF2H
 545fuYrT/T1z1fpumW2HncyYTPW8AsDOWZKLHk+VSx1rw/T1Qcz0jBKtgUzyJDpssdhbsO8N9nf
 Ann0k3EiXijssK3UY1iWQHCtSgPe95w1JgUqKwJ4s8Xnh2tP5skWT/tGdRg8lwvlabqzr5OoQHq
 pgxh8UcOfMRn1rOACEL8vkyHQydFGefm6pkF4j+Gx5NVHdAidYKZtXwE16wTzwYojJ5tY+2dG0a
 eQTehqek0KCE2DQ6CCILHw+nTCwbn8N0
X-Google-Smtp-Source: AGHT+IFzqvxICu40nbqlDgxbI1+k8sVn+b0sieqMshYCJ29NVBDbB0Lh43wb/rACWqDzF8CgWfmFIA==
X-Received: by 2002:a05:600c:4687:b0:439:9aca:3285 with SMTP id
 5b1f17b1804b1-439b6ad5cbfmr199130035e9.6.1740675684699; 
 Thu, 27 Feb 2025 09:01:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm62747565e9.39.2025.02.27.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:01:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/arm/omap_sx1.c: Remove ifdeffed out debug printf
Date: Thu, 27 Feb 2025 17:01:16 +0000
Message-ID: <20250227170117.1726895-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227170117.1726895-1-peter.maydell@linaro.org>
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Remove an ifdeffed out debug printf from the static_write() function in
omap_sx1.c. In theory we could turn this into a tracepoint, but for
code this old it doesn't seem worthwhile. We can add tracepoints if
and when we have a reason to debug something.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap_sx1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c6b0bed0796..24b40431832 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -76,10 +76,6 @@ static uint64_t static_read(void *opaque, hwaddr offset,
 static void static_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
-#ifdef SPY
-    printf("%s: value %" PRIx64 " %u bytes written at 0x%x\n",
-                    __func__, value, size, (int)offset);
-#endif
 }
 
 static const MemoryRegionOps static_ops = {
-- 
2.43.0



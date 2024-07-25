Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D584C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8MN-0001XL-U8; Thu, 25 Jul 2024 19:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8MC-00011z-8D; Thu, 25 Jul 2024 19:58:50 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8M9-0001dQ-UL; Thu, 25 Jul 2024 19:58:47 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7a263f6439eso253894a12.3; 
 Thu, 25 Jul 2024 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951923; x=1722556723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFW8mrexW3DWNbaozHBTt6yJbtLNBcqpBAa9gzkDLL4=;
 b=flTSLJD2XvkpNOHATgRVmjRsniFfw+dkHXmucoZJRN8KtI+HbleKS+LJUk4HAwQa4T
 R1dShKhjuSIMb6tiKw9pQ3uYxpbzFz2NuvNxsYbOTRI6ewPGvkVDK3+2qcoo02DpQNIY
 lU8xUYAB8QYGIfy8qvnppkwa3eqbzSM6h6FXXV3IRTcptMEdp1IUzP/JkodnhGNCtann
 6p4QlW+KVBlRPeXxryDDU8VP7NJBFznMUYoX5MEv5K1RoD+iTlajYifDR5D8IT3nQnyv
 lU+E8618JOHIsuVM8HVJI5tVTn81afc4ME83NsF3vreOEjgkFRtw+CZljqyEJOIVXttz
 FD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951923; x=1722556723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFW8mrexW3DWNbaozHBTt6yJbtLNBcqpBAa9gzkDLL4=;
 b=jvFLzxRwak7comM4ZxpkzKY96gTregI7PPA9M4i27NJ0N+1nDd9m89JkkdpHa++/Ll
 RfWtux5grN9RHlAPfuAG3GBv6CYEYFqye0YkNPyzU4XrDYZ6t7uZ0cWZUoSO9W180Yy1
 bxnB0kRgBRkG8j6raHk15ahiDeqHr/CN90TSXg457Eo7O4hl/Z1YtvFyqJFJgWbGKRmG
 BcETumxfPyl9fcc7a2SoWh3mus7tJ1xo7j4LsdkIZ7kk4RSXoV4NnhEDMucdQMjGIYEc
 GKGBxkhtOA9VNSltc0+zS3mlhPLF9kVN3Da3dv0ZJ9wwmyhFL3G8ePeMd6EGY44dzT5d
 9/1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8vuHEiY/eWb03qrfCMUMd9FOeTAqWde6UJGmUMM6sAeYGtmHwERBfRRUzfXw3NkqQw8wFHTTZdNBVbiTpf+DHP5Ix
X-Gm-Message-State: AOJu0YxpsAuz4lS6F/SgOUlpKcPMoa8Vi4fu2aCEzKXrabmwjfangvKY
 T5VtWs6jy30vOAfgLLGAumL6X5I/tBDbjwb0W9dQ+m/F8y3mXntfww402w==
X-Google-Smtp-Source: AGHT+IFOQs5GpS/Thp3N26gKXSzwzht42Jo5vyFFox8hmuUFNdbOi/lr3Gb0bHhVqv7IwnKJR9xb4w==
X-Received: by 2002:a17:90b:390a:b0:2c9:6a38:54e4 with SMTP id
 98e67ed59e1d1-2cf2ebcf4b5mr3609969a91.41.1721951923543; 
 Thu, 25 Jul 2024 16:58:43 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:58:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 73/96] target/ppc/mmu_common.c: Remove unused field from
 mmu_ctx_t
Date: Fri, 26 Jul 2024 09:53:46 +1000
Message-ID: <20240725235410.451624-74-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The eaddr field of mmu_ctx_t is set once but never used so can be
removed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 28adb3ca10..0a07023f48 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -40,7 +40,6 @@
 /* Context used internally during MMU translations */
 typedef struct {
     hwaddr raddr;      /* Real address             */
-    hwaddr eaddr;      /* Effective address        */
     int prot;          /* Protection bits          */
     hwaddr hash[2];    /* Pagetable hash values    */
     target_ulong ptem; /* Virtual segment ID | API */
@@ -348,7 +347,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
 
     /* Perform segment based translation when no BATs matched */
     pr = FIELD_EX64(env->msr, MSR, PR);
-    ctx->eaddr = eaddr;
 
     sr = env->sr[eaddr >> 28];
     ctx->key = (((sr & 0x20000000) && pr) ||
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F9E6748D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKLn-0001In-Nd; Sun, 21 Dec 2025 09:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLV-0001DZ-Uk
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:42 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLU-0001JB-DC
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:41 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso3647736b3a.0
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327019; x=1766931819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDk7QJZD5gFp77T+M8deaWWFziy7QSSXS87FreId1bQ=;
 b=Cvfvxn+u66vdlpBi6nVD7q7/RLt4GJHzr6+R+H0kM/8J7mqNrUN0VwEt05HXZ8OIxD
 xyFjj338eEyZGpT8dNgHr2oycLZKG3T4OsCGhcgYZ7vRpuru3Vc4Lk7+V+3h3ksWq8rt
 l4esM07R3qSZjoq9rc09lPoq/frewsEF0UtYWO6MYMB6Kcl3MOhCl9fxtreqX+dwmomU
 1zc7qFU+81yqwBnQM5qv289Mdyafj2fjBvXHbd4TTy1NDea0OsVG62MEzF1QDFyUudBH
 DU/pzws0z5XysonvKM4OXogg1pCsaPjzCLIoDD6fJfPoyE7U+7nnBcdSjbUVx144NH6F
 IBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327019; x=1766931819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDk7QJZD5gFp77T+M8deaWWFziy7QSSXS87FreId1bQ=;
 b=wfUU9p7N/y5Tv3FpB1zZCuD3CSD1AlwudxNJkwvMHsRM85oJTUCwEd1xsLXuPlR6EC
 b01MMnymmMTcto5UlGZJeaxrz7sZJxnSYxgcah4Xi1LTEpIEWxc2YVWbwMa9uJB4Ik5C
 nTvu6slu+XqvzbwIi1jIEA2+Dwv4aBitcFzrlZztDzFxCWSsmVAyaGxkkzaN+NU9KV/K
 ReXVUpPlvTOOopZQ+jS2MsJWvk0jP39BUN2Dz6R0P+/gX0Uq56ADAlGTn0RKPrlvSiSh
 joJzO/JrETYByyHvWHdXosVdB4XjuqVCPou3PuKPuYJ6mtTtGx1EABoKnUVktDcXDzio
 AwOA==
X-Gm-Message-State: AOJu0YxkB7ejhVA1YCuXyuxzUFrNgsaXQ7wAfzpM3JpIol+eI+fK2D84
 wsS6wR6rosbjgFkfTXmgAsoqctdWfiZActii+AMkVdT8qQF3jvjkNfWA813YSpj8uo8=
X-Gm-Gg: AY/fxX6uwswiLNJpUb0TeFXNgA4zckYFnT0V20zk1k/fdn2C0jMk4ekV46opfd+Ksfi
 4Zf95Wktc4BGolGGZyWur9jmgYrybLVJXwv54qEeMuTtMRRj0OMnRzKz8FYfiKHY8f4fAIvs2ks
 eZzHeX+bzV2CosHjdDBj+QJDLcgW9PB2mKmEO7va3XkdZRZfXzF+bbTFa68fqzctZitqJ/rcqKb
 JExcR6x4oxVPggDK/fcEnKXWxUZMFFF38Ke90pB6b+iEmNPzMtOo79PCJtiLXyRsNU6zuvRW+0f
 llYvCFNSL50s+w6NckVvtVpBFHHJRYhSut9+1DRQ9m8z5Z3Fmj/GOzNqlIANSgC+nvrSShbqdqA
 WQXR/Jp7IpdyTmWD19p1PU5MgimG6FHtKkq8GcA6NZRtIVs+rO+UOq3P3jB3inzH8qCnaxUU4Xc
 /EMb/NRVGYrAOmLq14zic=
X-Google-Smtp-Source: AGHT+IHi37o07xVQdlhwAZ97OE06AN+pUUUbXSjS8/8yQeyvN53L8W7DQ/DLI8mulNfNXvty8kwsPQ==
X-Received: by 2002:a05:6a00:8017:b0:7e8:4471:ae68 with SMTP id
 d2e1a72fcca58-7ff67966c94mr6390727b3a.52.1766327018641; 
 Sun, 21 Dec 2025 06:23:38 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:38 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 05/10] scsi:ncr710: Fix table indirect addressing endianness
Date: Sun, 21 Dec 2025 19:53:12 +0530
Message-ID: <20251221142317.266293-6-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Correct the endianness conversion for table indirect addressing
Now we use be32_to_cpu() instead of cpu_to_le32()

This fix descriptor table parsing when using indirect
addressing modes in SCRIPTS

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index e17d1f3fb8..4b42fab754 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1355,8 +1355,8 @@ again:
             offset = sextract32(addr, 0, 24);
             ncr710_dma_read(s, s->dsa + offset, buf, 8);
             /* byte count is stored in bits 0:23 only */
-            s->dbc = cpu_to_le32(buf[0]) & 0xffffff;
-            addr = cpu_to_le32(buf[1]);
+            s->dbc = be32_to_cpu(buf[0]) & 0xffffff;
+            addr = be32_to_cpu(buf[1]);
         }
         /* Check phase match for block move instructions */
         if ((s->sstat2 & PHASE_MASK) != ((insn >> 24) & 7)) {
-- 
2.49.0



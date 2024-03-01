Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA6BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxl-0004tt-CY; Fri, 01 Mar 2024 18:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxg-0004s2-7V
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxd-0004EA-Mq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso28315965ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334396; x=1709939196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tzO2W+WajMGPZKg0sOd9kLpT7E3B/88XAmc0t2vBAHU=;
 b=P6m8rL7I1LpNvpheAK8Iy1EoejxP3ojjKmen4VLCaz/iARpx7kZrXva2xSf7JgoAhh
 ncNpn8GOZhF2kW4t40moKPGQqZdxAn7Eqmkund5Twu6otaKpNsHrPfHsXhaEcb2yFnRx
 JXOTdahiZCZUZuAB+VwXQD5OYLEwRU/y/yk97DCYu9ZCp6D5DlIiGNC3R0oFmv310gul
 3Lj/is+rruP3zLSh5bRid/nZ2/m3tUo14r89DQRN1J/L52sEUmon54PVYNWq0GWl4oIx
 Nw5h4Q1X5hWBQOZsH/2d6ulT3R846Co3CgiLhL1tu65Bo+imDO9tA9/ivJBkRB2texmy
 0EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334396; x=1709939196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzO2W+WajMGPZKg0sOd9kLpT7E3B/88XAmc0t2vBAHU=;
 b=H5KGra6BxYE02HgPXgMT1Px+VCgy8W2iMtuJfCKSe5ow/kTrymTHuZdZrlf3PgJOz6
 6mGNs4KpgzaWr2mk3vMtAgV3w6sRJHf5d49vdMyMwAq+iQ+usexQmY2VQya1xVzjAJN8
 WRYU8PQc2kbMzUS5b9xh//T2mptg7vQpw6pTy+Z+dWwMxwIpkaOLfN1C2ect6CR2138Q
 wM8M7D89vi+tsvJGAwCWkkdS3qBbsf/XWwcmIic/sZjlM4wy1Bl29murm0l/Q7BGxK38
 l0uV3ZYn/1613IU76FcoimUox5hyzg2LHFsez/3GkdpxkPYrAeJSXSHj7D0ZVuWfLF/i
 8C9g==
X-Gm-Message-State: AOJu0YzdXZKBIQ45NPeltLPgTWw9d1D1y3LLEpZATgb7JWPFVGYCC3Q1
 yJsE9Yvg9W1+F+1syhFACoPAgiTvb40QD+Hf1/jv+eK2PLy6J4bSwDkJwkvooJk8qdhoSYe4sae
 i
X-Google-Smtp-Source: AGHT+IEKQ7GtQqgYj9IFKN2wr3vfklCc9HD/bE968/Nw1lzP6d3oCcoZIa1GdGmtaRkFskfZkoftAg==
X-Received: by 2002:a17:902:82c7:b0:1dc:affb:1f50 with SMTP id
 u7-20020a17090282c700b001dcaffb1f50mr2927967plz.47.1709334396419; 
 Fri, 01 Mar 2024 15:06:36 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/60] linux-user/elfload: Write process memory to core file
 in larger chunks
Date: Fri,  1 Mar 2024 13:05:30 -1000
Message-Id: <20240301230619.661008-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We do not need to copy pages from guest memory before writing
them out.  Because vmas are contiguous in host memory, we can
write them in one go.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b8d07d8054..491e754f72 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4551,32 +4551,13 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     }
 
     /*
-     * Finally we can dump process memory into corefile as well.
+     * Finally write process memory into the corefile as well.
      */
     for (vma = vma_first(&mm); vma != NULL; vma = vma_next(vma)) {
-        abi_ulong addr;
-        abi_ulong end;
+        size_t size = vma_dump_size(vma);
 
-        end = vma->vma_start + vma_dump_size(vma);
-
-        for (addr = vma->vma_start; addr < end;
-             addr += TARGET_PAGE_SIZE) {
-            char page[TARGET_PAGE_SIZE];
-            int error;
-
-            /*
-             *  Read in page from target process memory and
-             *  write it to coredump file.
-             */
-            error = copy_from_user(page, addr, sizeof (page));
-            if (error != 0) {
-                (void) fprintf(stderr, "unable to dump " TARGET_ABI_FMT_lx "\n",
-                               addr);
-                errno = -error;
-                goto out;
-            }
-            if (dump_write(fd, page, TARGET_PAGE_SIZE) < 0)
-                goto out;
+        if (size && dump_write(fd, g2h_untagged(vma->vma_start), size) < 0) {
+            goto out;
         }
     }
     errno = 0;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA4C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvK-0007Zz-AD; Thu, 22 Feb 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvI-0007Xq-KY
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:04 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvG-0002jP-WC
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:04 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so194343a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634641; x=1709239441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=ToZF6eZmeo0VzJRBOSANiVU9rNopyEErWWxC6hpA+ZwsTpzaKEVHPSEpdwzx2ZS6ks
 qEo1SbEgDgpj4W0CSM9V3+WxMGB3q+Yem49PmKnNLU81Z1RAxL31zsSFtzGZUINMbYLS
 JqDQj59zEtWXbnIrEykS8VWziCspwa11vLG87dN5ZH8jI7jV4odlcElx31VmA4TH/Fpj
 dZlFVxwcYd/moaVQWPX3f4+mB3g7FJYUt6iEo2ZteNJsLnDFN4jCrvx/1ScHV2q6xLjY
 o2vglr7jJUqCmLAWJGb/SOK2K82tBhPl3GPCrIwRoQiRoxpUUY+FkYRuDn/L9+HHA0ji
 y7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634641; x=1709239441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZykOOhGWRLaDSZ6ojBtzy1ZtPjktUdeyK8bHHdP5Cx0=;
 b=ea0FfmPtGGKjiOHvv8xhbyPN94kaa/3Nyz+ED9deSQpwGG7fJ4eINw/Miq41hxl7u4
 Btj8GV1z6fC6GVEBEFmSUI2a/6Wc5jyWrvNxU0AmNZw1WQSl03AqH3SyHu67TMhxoGLu
 40l38AO3awEZqiUSNStOqCA+REzfF2f+AQxIHCPX4IQZrxpMTry8E2lzpejj0CcO5694
 NLV1AgS4Lea0z/uVM+bav6E+0IMU7LcdhJcl7Ovq9zD+E41RkpwV+NUog3phssDZ2hxf
 WKqCeLNfm4YEtSnVmNNPenpJaiHVGTNKwYzZFFtOvoHwZ+ADe6f5zKUVmpBsWXewqoWO
 Bicw==
X-Gm-Message-State: AOJu0YyZiARAj4dFrQaIkc3OSERp1IVRhnSVZm3OqMrEBinmpDJ+NRJT
 dXl2qV0uz9ZTesfssrWIQWcq1/T3LOjxaltyrCxOHtMhJiVtXQfl6GDlKaXFXkk4TmDqZJfZt/a
 k
X-Google-Smtp-Source: AGHT+IFnVLLQSzQNJh53u4pqPvXtdjSGv0LEG5cfEwN9Tnmtoo9Mf6CgVpDh9rzgZ1hwXkUOcJIo/Q==
X-Received: by 2002:a17:902:f545:b0:1d9:e1aa:f217 with SMTP id
 h5-20020a170902f54500b001d9e1aaf217mr146740plf.22.1708634641623; 
 Thu, 22 Feb 2024 12:44:01 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 23/39] linux-user: Do early mmap placement only for reserved_va
Date: Thu, 22 Feb 2024 10:43:07 -1000
Message-Id: <20240222204323.268539-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

For reserved_va, place all non-fixed maps then proceed
as for MAP_FIXED.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-21-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index cc983bedbd..1bbfeb25b1 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -540,17 +540,19 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
     host_offset = offset & -host_page_size;
 
     /*
-     * If the user is asking for the kernel to find a location, do that
-     * before we truncate the length for mapping files below.
+     * For reserved_va, we are in full control of the allocation.
+     * Find a suitable hole and convert to MAP_FIXED.
      */
-    if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
+    if (reserved_va && !(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         host_len = len + offset - host_offset;
-        host_len = ROUND_UP(host_len, host_page_size);
-        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
+        start = mmap_find_vma(real_start, host_len,
+                              MAX(host_page_size, TARGET_PAGE_SIZE));
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             return -1;
         }
+        start += offset - host_offset;
+        flags |= MAP_FIXED;
     }
 
     /*
-- 
2.34.1



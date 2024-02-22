Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACCEC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvK-0007Zd-5p; Thu, 22 Feb 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvF-0007R6-Tp
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:02 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvE-0002ik-A4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:01 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e4751b97eeso60704b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634639; x=1709239439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=O4OP+juH4k/OmXO5yZxWjdIeFFQcilPrteiC49Pb2FvpG/Cay7gvm5zP3cfHrVMnnJ
 vDSkdvlNNi9To+FFHERq9yWRQ4g3H4QJICru6JioprVyHFkVnbF6fMBM1Nggjs6C/Zjj
 qD2FDF6JZrO/gNTQDKYBBC89X/5VrE9DB54LuUhhalyeVB1UXTDvVg5GkO18/uDx+ncM
 oZfN3urRb74CyRN0+PJ1KLdGgimkiDhAiN8T7n6Y3aMLXB0oSK7CtZlwIQsoz3Xy/m52
 2BQRBEe4PKxuAPA7REwuKI4W8YHh6xLrTRivqE9Hw2/gSnRei4qp+jcn83oDRXJeEgw+
 n4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634639; x=1709239439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=h9nIT442NE/BFTOpAGhtV2JjHSrAUEhli6k0lfJ8RS5I84YoSuSv+YhliKowfkzXvv
 L7QaYugGJOmacXKLcq0jkwyC/RLGGYraVqGh3uv+46XUzzImoCPwOFlsa2kmC/whGrTa
 JpIa/C3YXlsT4yWBkLEUS+SNNlJ/VflZ0heyzMJzCzNE4+puXRw7k2sTsv2rj9poHk/e
 rtN88yi/9vEDW4NScgfP034lLhEavHkmv7HHo4s/8n9bSYlfh8hjnmh1ITe8OHiSTj/Z
 LLViZKYfyHIF6i92v9XyvwsM936KEVc+/keczUTtnLIJZEl3R0rPErW8WbLn3ObpGTRc
 kNrg==
X-Gm-Message-State: AOJu0YwpchpdSSfZY5tnQWHhD24ijSpZY5L15SrqfaHPYQV1H8PAOTWO
 BznbfnHf6nfUcqIolFYMhr8vxKNgzIRf978QCmuuKHXsqF/G6laOTJBTAlIEJPebnzAZQG8MbPH
 9
X-Google-Smtp-Source: AGHT+IEzgNeSB9iEL73eJ6vutCstagS3fngCXf18kC2Ur9HNZ2WlFC9k2DkXFaWM7wkL/g7XuTHITQ==
X-Received: by 2002:a05:6a20:9d94:b0:1a0:cd54:6d9f with SMTP id
 mu20-20020a056a209d9400b001a0cd546d9fmr4859887pzb.23.1708634638728; 
 Thu, 22 Feb 2024 12:43:58 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 21/39] linux-user: Fix sub-host-page mmap
Date: Thu, 22 Feb 2024 10:43:05 -1000
Message-Id: <20240222204323.268539-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

We cannot skip over the_end1 to the_end, because we fail to
record the validity of the guest page with the interval tree.
Remove "the_end" and rename "the_end1" to "the_end".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-19-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fbaea832c5..48fcdd4a32 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -643,7 +643,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end1;
+                goto the_end;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,7 +690,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end1:
+ the_end:
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
@@ -708,7 +708,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         }
     }
     shm_region_rm_complete(start, last);
- the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
-- 
2.34.1



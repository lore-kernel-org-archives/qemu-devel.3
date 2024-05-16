Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82DEC25B7B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dLF-0007w1-Rj; Thu, 16 May 2024 11:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL8-0007l7-V0
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7dL7-0002uV-J8
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:48:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-420104e5336so34421545e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715874496; x=1716479296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teD8rnn0f6FYCrAuK2rQnLlILPjJ9Dq4/0s1mpzug5c=;
 b=jOhWqoONDsmmeFKPYrYIWPVredBjzE3GXwPan5W5NxywdbRQimk/X4NSY8MBR7MYqN
 Ln0uAOihiQaCqBFyvdBeCwWfWW0s9m+W6jmFEz701LOvRR8X/v4udXMnZXnf7qATul5L
 hcDFibnmhc6VkcFn7z3rfTXt4cgp1vLiLNQ5hbSWEBvR7p4wFF4h+FueMR8BmWaPAtug
 gDr8LOvTMy8VuSRXQ0EuF6HXKrnUrKO6ykNH0mU90lbU+hz3Jvn5hNpu7hzpRNdaOIFe
 W9RhvE6p1d60VqjPEjGj0Sf40Rul++3zRxBnNVKCj9rKTNcMYLVw2tvy3CDRnr5nRMFT
 vfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715874496; x=1716479296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teD8rnn0f6FYCrAuK2rQnLlILPjJ9Dq4/0s1mpzug5c=;
 b=d4L7e5OKiSyjRqbddxK4PnsI45PDcFadBSHZ3Cw7LirhGHb29H9kizFtG+lJzVFp6P
 lsjR5teaNLY09OZVidegDlYNHxTr4CRrPX/x0liB8CBvXwMTwh5527x0RLxFu4Z9yHiw
 fHZcx8l/wZJ9i5tLp6kVUoG91dQUcM2LPsVXWPgYBvi0GFTzznBTFv27L7a9Lqy0CJ/U
 En4hMgmmpxlEZ/cT4fADWPJGKcSXrizCUGjPp7kbjwsbs2Zkkg9Am2z9e70rXbmsuiFN
 cYSOrmYSJMIsj4fG1LuHAHT1BV1ZI18NY0zvvI9iH/bzrX+s5nexmJNtu50VNyqstcPB
 7QKg==
X-Gm-Message-State: AOJu0YzjYK9hToXVZc+zEvNyaFbkxTZ5quBqa9EO0hBAK1un6UFuAxvF
 XFIQlIly9XJ9HO2n2z5SVqKClIv92RPwCS1Ai/OKW3XGUhY/Kq29hfh3IpJ7z18=
X-Google-Smtp-Source: AGHT+IHnY2m1gSOif+roTBqJK4laENH333C+wETM9OTAiDP4pjCTiyhjqNlxDwHwPAW5xLvSHvjXng==
X-Received: by 2002:a05:600c:444e:b0:41b:4caa:554c with SMTP id
 5b1f17b1804b1-41fea930c57mr180374385e9.2.1715874495533; 
 Thu, 16 May 2024 08:48:15 -0700 (PDT)
Received: from gmail.com ([213.0.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42016b88f99sm146829475e9.10.2024.05.16.08.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 08:48:15 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/8] softmmu: xen: Always pass offset + addr to
 xen_map_cache
Date: Thu, 16 May 2024 17:48:00 +0200
Message-Id: <20240516154804.1114245-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32d.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Always pass address with offset to xen_map_cache().
This is in preparation for support for grant mappings.

Since this is within a block that checks for offset == 0,
this has no functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 system/physmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 342b7a8fd4..5e6257ef65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2230,7 +2230,8 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(block->mr, addr, len, lock, lock,
+            return xen_map_cache(block->mr, block->offset + addr,
+                                 len, lock, lock,
                                  is_write);
         }
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C258C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ELK-0007jh-BT; Mon, 20 May 2024 21:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9ELC-0007hM-2H; Mon, 20 May 2024 21:31:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9EL9-0005Jp-LA; Mon, 20 May 2024 21:30:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so91608135ad.2; 
 Mon, 20 May 2024 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716255053; x=1716859853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DM7C9zYU/JYPQc+IpanR0zGx9fNeS+QDv9SFSyE3708=;
 b=k8g/0rQ+f9TAbI60bfRQW8+zIqivev2Dv/LnzVJJNDfYA2IwobbyfVaw7DR0nZenRF
 MVTMVXx9x3SYhpx6wbB6y0kbhmtngeF5lpBteGi8T29vpmidy+NL592xBNOm3YXuH9H+
 lexWkG+zX6YYkYRHH+m1r3MiUF4oYFdUB7hkm1PqKIKuK3caaDswVkTzgEYVR/wl9Ii7
 +QdWpEorGAq4NddNAgsuz9eL0VO0KFhIjUhqZNaoNBtyswutmwdez1VvjSkVtTNtNSYn
 JkYC0GrhvuyN174Q+yWq/m4IRxkwC+A7dyth+1WpaV48ylAf8mcBoUdFTkhnonCjXR04
 GAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716255053; x=1716859853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DM7C9zYU/JYPQc+IpanR0zGx9fNeS+QDv9SFSyE3708=;
 b=nJ6p63aNekbfmK71KjpY69CH+JYSahFuEEpYVe7zjMEAGTlrpZxHd7zbWtOeAKu7R+
 rJU5HjAsbVKj4M5Ryph/XlBXUGnQDBwKfDtJQbAbg3dZ3/zM5ShGaetrZVvpJ2VV+PXg
 J72aXT0NNbvpOJlg9ecT9HJ+3iV5jmQs1EMFaRzdNJ8neycYEbINi83w+CS7FKjW8MdZ
 DNSAb2abMI3y4mTpYCW0WPkGq7SAJwAXc0dh4BfPL/Rf3BpXlY3CqXR5HjJQDylFfQgi
 ebzXVMp+AVzYH0vMvsOo4l/3ou+XIu+BLMU6bPjKA97RoTb22YZpzqQcN+kpYVgIPXPP
 aTAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJbImd13S0A+mBsFWlAfDRV75UmXgP76tqGd9nAYkjh37Rk2cyng1s7QbUT6WnlgWgjQ6E+coy9Ht+OWO6UjAsBi0gEb8=
X-Gm-Message-State: AOJu0YyyrkViJS2SM6YqkbHQKwJC7w+I7lWeAGjz8NmfSnFjEEMMhXBX
 dUlshX6DNe2Flop41bV9EB5+MmZ3AfWjw8w9qKNth+aaSJetukoVyNeqJQ==
X-Google-Smtp-Source: AGHT+IFdqgktDuzumxetQ6n515AaYMkRNijVtks8f5C9Yfhn3THLuqM4j1WUb6waCPz/9ngoCiHrkA==
X-Received: by 2002:a17:90a:ad86:b0:2b6:22bd:f4b2 with SMTP id
 98e67ed59e1d1-2b6cc03f435mr25384106a91.4.1716255053583; 
 Mon, 20 May 2024 18:30:53 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd7f0cd400sm2514953a91.31.2024.05.20.18.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 18:30:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 04/12] target/ppc: BookE DECAR SPR is 32-bit
Date: Tue, 21 May 2024 11:30:20 +1000
Message-ID: <20240521013029.30082-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521013029.30082-1-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

The DECAR SPR is 32-bits width.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ee01415c32..927721d49a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -792,7 +792,7 @@ static void register_BookE_sprs(CPUPPCState *env, uint64_t ivor_mask)
                  0x00000000);
     spr_register(env, SPR_BOOKE_DECAR, "DECAR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, &spr_write_generic,
+                 SPR_NOACCESS, &spr_write_generic32,
                  0x00000000);
     /* SPRGs */
     spr_register(env, SPR_USPRG0, "USPRG0",
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C5BCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95pB-0003rh-WD; Wed, 15 Oct 2025 14:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oh-0003nb-4z
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oa-0006Ev-8d
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e504975dbso42616765e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551287; x=1761156087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9t3e/KyULfBPeswO6U630O9UE06JlPP7NTUsO6O4Tg=;
 b=UTWHUHC0YmTuhlCCFVk07OoKmbXeZ1lFGUJ2DKAfwizGhQtNbMYglmfVRgOqM9oRwz
 FDnw5KVGLVaqw2e9f0M7QtG6yb/ZqMnbCzS3Xxz1S/TlEth88jwi5PlRmHGAe5rDbMhl
 +heKmwjrJesf9P0ZzNAgT22GYV2lzk9G2k9d1Kjx9GIYvNpgpJhTEZiKkgTQTFhQYrvv
 0f4fueX8tcdOxGSzZoiFQVjGdGlOXksROv0NK52ono8F+sosXshckqJzv5P0wkcjSZrN
 7dEbFUcZ0d3sLg0kp6bgKInjJWRUlGg+2tENASj8MPfEjE3TXaiFCoDKTH9dqBSkI7rx
 vybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551287; x=1761156087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9t3e/KyULfBPeswO6U630O9UE06JlPP7NTUsO6O4Tg=;
 b=IW4NinyowgbbO+aFMRHvoGOhLk0gm9o8fQV0WKrjyFTpCh4xRVk/0tbPjpHNhNzFvH
 hOSjNsBFESQXz7PXfzkN0XoYYPhI9cIEYh1Jc3eXcvTSA5bKJYcKQArfauJ7lZWOoXNJ
 x/IRQtEtZ5HUwl4VJOX4MzxibeAX3NZ/uzyMFo1Cmb1oAVPdxDf3Whas7SOZtuG2QCsw
 Pwl+gY36JgVZFgU0OEwWQv8drB9SGUmN5fKdK1+Z7bntK2CBVZ+Cc3QMXfajoHHuysw1
 FD/Pjp0izQV6HflMAMQrn+xqoONOGJJunFqq+f8R/72G+3D0v0askd1JOtXOX2Do8f5X
 yv2g==
X-Gm-Message-State: AOJu0YxBd8JIlOTUlL7uL6KM4pnLBfFhXkPe0cKHfoMHE9wHUR8BcP+e
 sjRYR/lcKCyr3mKVH0jrlzRMLnPTVQNoV7iDM0BmgU/XoRrRz24l0InCbeENZwyw3JXydGYcJMW
 S7lNU46ML6Q==
X-Gm-Gg: ASbGncvdJJyS2axWFbYTEw3YCd0z0vsSv6mkVwQHlCrj7dhu8Dig/eV/NJ+IVzavIph
 dFghDUw6QrCHzkNCo4yFLjvggYGENqtLlTkpc96TJKq6oGwWUkcEyzwanZ7m+Si/beTYZa0IEG8
 CWyQL3KA/OsErLhRBhiGADw3gZf+LMWNUxcijNcCEO4XEvcueSf0tFGwMa/IdWq3R6PCab2cT+K
 ew8YZ5NOOeg7fMXn2N3Ebm8D3pIPKLDjUDlavGP71cpzUZlYSRgQFtNflH3XZxhjUWMOSCBMnJs
 EIqZ5nhiNjahQawryEo1Rv7iyjA2YAHvg0fj3NIqjtHFP1tPE4Hhw5NsH0vWYlZLzoTNt7TR4Ea
 43qyd7CLfmNRGKt4UL1hTRO11xofSO+gbzeBWPy0JqRp03cyFK3tJV6ZjNfnEsayppR7vfJlhrd
 cPweWQryPz/21RATFb0ccNrh7DqB+3cA==
X-Google-Smtp-Source: AGHT+IHhLiNBQRa0K8lVXSig+HVcMpglP2pQxfDEQuaL4j9K0HvVfkVAwKmA9ddvpYkk0TRlXlD1Ig==
X-Received: by 2002:a05:600c:1d11:b0:46e:5aca:3d26 with SMTP id
 5b1f17b1804b1-46fa9aef840mr222269875e9.22.1760551287207; 
 Wed, 15 Oct 2025 11:01:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582b44sm30437490f8f.16.2025.10.15.11.01.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/7] target/microblaze: Remove target_ulong uses in
 get_phys_page_attrs_debug
Date: Wed, 15 Oct 2025 20:01:10 +0200
Message-ID: <20251015180115.97493-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
and return a 'hwaddr' type since commit 00b941e581b ("cpu: Turn
cpu_get_phys_page_debug() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index ef0e2f973fa..cf577a72268 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -274,7 +274,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
                                         MemTxAttrs *attrs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
-    target_ulong vaddr, paddr = 0;
+    vaddr vaddr;
+    hwaddr paddr = 0;
     MicroBlazeMMULookup lu;
     int mmu_idx = cpu_mmu_index(cs, false);
     unsigned int hit;
-- 
2.51.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF8EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Io-0005oc-Tj; Thu, 25 Jul 2024 19:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Im-0005QS-ID; Thu, 25 Jul 2024 19:55:16 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ik-0000oJ-U6; Thu, 25 Jul 2024 19:55:16 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cd5e3c27c5so298130a91.3; 
 Thu, 25 Jul 2024 16:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951713; x=1722556513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ezs3DLKhJi9bi+5dnC/86d/6yo+E8mRm9hv7mGV6t+Q=;
 b=H0Z1byuMmInZ2qJJHpkShLQf0BPX/NlzN3tDV7ulO7f+WBxAxtxTwkbYRWw4qBtqPl
 Yfjj2wBUPjZWzBy6OS/nnaeC1+FpNXnGj3O3NkNndKbXgDxQchRzOEDkvHsE31y93dND
 JbKrKL/6gwbRfVZt3C2ehtHwV2SC7PTb5ZJefKD6nybxJuRq6ECQf7ES+WnXo9otmF7H
 pj1LbDGI5uylycu6q81i7MCQbpIpfK0FJTFKmX2kK96e5f3pGT2Teo13AJfE4Snlgelx
 /ilu8o1vawQ2URi0e7IzVAqfwUybEbZmGqurBLIonszj+KFh1ZNcKH/Rrh+sJYP4s7tA
 B0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951713; x=1722556513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ezs3DLKhJi9bi+5dnC/86d/6yo+E8mRm9hv7mGV6t+Q=;
 b=o3S+zhBGm3ViF42w4D8I4jzZcD6pE4CuW69WKLDVVlJHD+WUXVU1U6qN/dUdY+iJ4a
 MEVab/6R/2UwVEnkqrbqAz9mw5nkmvyTc6g9DjRnIPUGqbKUzvffIUDwNWFYvzbTSuT/
 SvvMj7XBRAxqBuPYoGTG+EQ5hAeF8MfKvCiQha4aByJDt2nsFzaSLDH0/J7JZsa3396q
 pDTn3ejBHCDNSuYtKJHx0j3cR/ubPjqC3xO/N9LRpjmOtqB5ylR2Zi6FHsHr9dQeSwKB
 y5JUq07zSBk67HmWcYdlp/t/cz5ZVQDbdLJVvATqXGnKpwnt8dn8qR9/rL66wfaI4rTd
 nb9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw6e4d8UJGNDy2xUvhVfgHD4ad6f6JSaqk4+TpoERAZY3TNi4D2f6AgL/X5rxM6AQk9ifLlg2Mot5UpRhuT8Tfm5vM
X-Gm-Message-State: AOJu0YySdeF/29wUExdE+ldDow3J+PDIHnAWnShELlLgYMg1PbDNsUZz
 inja+79zX7IhcxG745QpWWb0uEU52wDngmMvDfXHHa8YlnlzsvK8TD+3Cg==
X-Google-Smtp-Source: AGHT+IFgFr6UgA4f4GudC0xexIPyO/QZtruD2SyBwzmWOIOO9s4xAjbEd29ckdq3H7URUfpL0KWdmg==
X-Received: by 2002:a17:90b:806:b0:2c2:dee2:ed41 with SMTP id
 98e67ed59e1d1-2cf2ea14992mr3704307a91.19.1721951712661; 
 Thu, 25 Jul 2024 16:55:12 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 12/96] target/ppc/cpu_init: Synchronize HASHPKEYR with KVM for
 migration
Date: Fri, 26 Jul 2024 09:52:45 +1000
Message-ID: <20240725235410.451624-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

The patch enables HASHPKEYR migration by hooking with the
"KVM one reg" ID KVM_REG_PPC_HASHPKEYR.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d311b190c1..2e652f498e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5877,11 +5877,11 @@ static void register_power10_hash_sprs(CPUPPCState *env)
             SPR_NOACCESS, SPR_NOACCESS,
             &spr_read_generic, &spr_write_generic,
             KVM_REG_PPC_HASHKEYR, hashkeyr_initial_value);
-    spr_register_hv(env, SPR_HASHPKEYR, "HASHPKEYR",
+    spr_register_kvm_hv(env, SPR_HASHPKEYR, "HASHPKEYR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,
             &spr_read_generic, &spr_write_generic,
-            hashpkeyr_initial_value);
+            KVM_REG_PPC_HASHPKEYR, hashpkeyr_initial_value);
 }
 
 static void register_power10_dexcr_sprs(CPUPPCState *env)
-- 
2.45.2



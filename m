Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8D5C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K33-00039r-LM; Sun, 06 Apr 2025 03:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2v-00030x-0o
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2t-00024C-Gv
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XJUJRnrTiscZ1lpipSP6/oXqKd/h2Mos+s1lv9QW+I=;
 b=KJykwMif8bH19S8N9Cf5CXFKTsVPXKo3Yfn9WvW3rfpL3KB5MSfX97Oq9Qy72L340DeqId
 JE7UW8JRk6AgZp7No9tHthAXaWNzP4c2NIskcFow4SojZ7RTNYAs08us/8hbBJPWGYYusm
 QOHqCVrvPVOPw79uhBG6DGgoZLDIhU0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-T-uex68APJKZqTP4_LZzHg-1; Sun, 06 Apr 2025 03:03:52 -0400
X-MC-Unique: T-uex68APJKZqTP4_LZzHg-1
X-Mimecast-MFC-AGG-ID: T-uex68APJKZqTP4_LZzHg_1743923031
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3913aaf1e32so2014720f8f.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923030; x=1744527830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XJUJRnrTiscZ1lpipSP6/oXqKd/h2Mos+s1lv9QW+I=;
 b=DH0Fb/7z3NRtU7ysFKvsemjfoipJPJQ2mYLoOoMSotzO39NmUbSbMQDvzVJcya0rbJ
 tFckM42mTmM+Kx65MNqg8qJ3JXkUj3mIGqD0I7hiMaIPWUH/g8ZywrYhSP/xnIKR3plV
 2RKlE10ATbClA0J7a6G0ip8n3UIC4lN55BtMTMrFrm1RHPTkT6HBP6HHITF4IOgrT4aI
 /mNbceZJMrnj9v/bg3iBY5YWAAXEtMphGztIiSK7R6z6jY6YCQQB+QEIvEMxxXyhHx24
 P7yhVt1iAg4LZrFo1+ldvJeYlUZo/XePDQtk40DUfl8AegXrCk6ggeH2W5ZaSH0Xws0c
 9t1g==
X-Gm-Message-State: AOJu0YwaLzcmA7AWdrnGQlDN6jJXPsxThjl1Pc+waP6zgPE07PtdM1aj
 Bpsdl5E12DEPGy1jahyJmnnnxsyhaVsPSSUbN9Ae0NSj7RYcnC1+RyTbt5BRThUBiB67kwVqvVb
 O5J3RqHSMoe7xDd0C94anuGB0cqDnfY3lKfR7aUrVLtmoOGga3itmDB6N2jcYjq9ObCsjFhqVI/
 CxzT04IaGlLe3hXv0Zt6wCG10mb51B7LOKOCcV
X-Gm-Gg: ASbGncsbwijU8cs/1ZISBTTrhR3n5ss3aOEP/BW3//u+zR3k46K3kWfaj7t+xjK5+n+
 jfFXFIBbXgtYHSk7HJ2ImjIXu2SsUwNJYlau3sH68K7EI1mtAuhU1HLyYDkozzpfRNZjBSttOHm
 qfpIeWDIfW25bqrqgHPi2bl96NSC4RxkHSaW0hmvliDvQ5h3YSiI3Xg79qHAhfXoem4582gvGVS
 howSQUA9V47vTN8cxQYzjL3MJGQ7PoZaWStXmkYcfdUxZK97pe83uKTEzeemR3d8JXTXWJwvaSD
 jmfSHQjXaaeTnZlf7A==
X-Received: by 2002:a5d:6d83:0:b0:39c:30fc:20 with SMTP id
 ffacd0b85a97d-39d0de6793fmr6488111f8f.37.1743923030561; 
 Sun, 06 Apr 2025 00:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Eks65h1Rim4Nkwgg47yh795nTvYouQr8EuJk+GBusnk+bjd/DY8dKjwPvHpntkL9zjzwjg==
X-Received: by 2002:a5d:6d83:0:b0:39c:30fc:20 with SMTP id
 ffacd0b85a97d-39d0de6793fmr6488039f8f.37.1743923029545; 
 Sun, 06 Apr 2025 00:03:49 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364d036sm91480155e9.26.2025.04.06.00.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 21/27] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Sun,  6 Apr 2025 09:02:48 +0200
Message-ID: <20250406070254.274797-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..969a9fe3c80 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -29,7 +29,7 @@
 
 typedef struct {
     int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
+    bool (*insertion_test)(RISCVCPU *cpu);
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.49.0



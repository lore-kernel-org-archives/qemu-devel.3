Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4606BCF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsGW-0005Vw-5l; Wed, 02 Oct 2024 01:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGT-0005VU-54
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGQ-0004pM-84
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so17990895ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848262; x=1728453062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGbvTTMJSfmS2eLzhKOmc7FBrGBYUzIf4fRt7YlJWNY=;
 b=Bllmz6Mu0P1D5xf0xy6XN1NeBQ8NhzgvPfz5nY/npYOQpuwaL0rt8t5MCkGS2gYHLV
 OfemDPWd2IeByeIxn5SH47iUwRj6GmH4O3xc+GPo5LXZSj9NJoQFTGq+RE/TpBmyLQ/Y
 xbKYfNfPaZyk85TSz4qhUPYKx1TDACN31bMOs9aQaWKLNoZK1EzSi+igQayONhkita74
 qzMopvGTLF/4G4BTZEpc8jWSxCsS721LePU/95GhU+jGMDeG4mUNgoNNrBQQwRFSR87a
 c+tyXFylrUjNqR/PgFf1JQRQg4BVqY/6U9mINwa3OZOfImPbtcZF/kC/FF5tHIPjjDdy
 +2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848262; x=1728453062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGbvTTMJSfmS2eLzhKOmc7FBrGBYUzIf4fRt7YlJWNY=;
 b=kxN3WLQjPMM6RRnyTVO//1Aw6QoY0yteYnBwikw76efAMQw1XCnrHh6wMlPkeWJSrf
 w1OrrU8amfLVWp/bU8ISeckOTM5l3goHhl2+y2hqmoXeMqmqpcKq9L9h0MlIqwr+lOxP
 NLDw6vps8aqUemTpypaBZDS38YKxIoNZ2DqscdhvGCmNXdapBDlSDgy4JKEAA+rpav5m
 D7c2j08ykGtPttmaQS9YsmPKZgvZmkEP7pHHtSLPycYm7s0UOQso7XjkS01fzaQhb/rN
 JTiABRso8yP9hIso+oQn8attSekdGfsiUYwPfWvIGVsk4ACN5bmOnXOMH70BRndkcVTT
 WsVA==
X-Gm-Message-State: AOJu0Yyz7beBGGBp1+yYqJ480SRQI/hEnvqQYJ/YkNIMkTKIwN4ySRJr
 8nvd//xlwfAAseavA7x3PFOd7NgVhvZE9C6zreRRljZU8rHOa4NTsr0eAt49
X-Google-Smtp-Source: AGHT+IHYl0U6GIPxAefW5iWfccO+Hic6TL9sJ8XpJwtFhkYalPL3RylYtDq12WxTBLg0s7hYHtWpYw==
X-Received: by 2002:a17:903:234b:b0:20b:4f95:9339 with SMTP id
 d9443c01a7336-20bc5a876ccmr25801315ad.60.1727848262376; 
 Tue, 01 Oct 2024 22:51:02 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 01/35] target/riscv: Add a property to set vl to ceil(AVL/2)
Date: Wed,  2 Oct 2024 15:50:14 +1000
Message-ID: <20241002055048.556083-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Jason Chien <jason.chien@sifive.com>

RVV spec allows implementations to set vl with values within
[ceil(AVL/2),VLMAX] when VLMAX < AVL < 2*VLMAX. This commit adds a
property "rvv_vl_half_avl" to enable setting vl = ceil(AVL/2). This
behavior helps identify compiler issues and bugs.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-ID: <20240722175004.23666-1-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h       | 1 +
 target/riscv/cpu.c           | 1 +
 target/riscv/vector_helper.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 8b272fb826..96fe26d4ea 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -127,6 +127,7 @@ struct RISCVCPUConfig {
     bool ext_smepmp;
     bool rvv_ta_all_1s;
     bool rvv_ma_all_1s;
+    bool rvv_vl_half_avl;
 
     uint32_t mvendorid;
     uint64_t marchid;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4bda754b01..cc5552500a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2661,6 +2661,7 @@ static Property riscv_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("rvv_ta_all_1s", RISCVCPU, cfg.rvv_ta_all_1s, false),
     DEFINE_PROP_BOOL("rvv_ma_all_1s", RISCVCPU, cfg.rvv_ma_all_1s, false),
+    DEFINE_PROP_BOOL("rvv_vl_half_avl", RISCVCPU, cfg.rvv_vl_half_avl, false),
 
     /*
      * write_misa() is marked as experimental for now so mark
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 10a52ceb5b..072bd444b1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -75,6 +75,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
     if (s1 <= vlmax) {
         vl = s1;
+    } else if (s1 < 2 * vlmax && cpu->cfg.rvv_vl_half_avl) {
+        vl = (s1 + 1) >> 1;
     } else {
         vl = vlmax;
     }
-- 
2.46.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB04C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZo-0003Mf-P8; Thu, 23 May 2024 19:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZL-0001dy-GC; Thu, 23 May 2024 19:09:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZI-0005qj-Cj; Thu, 23 May 2024 19:09:55 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so314914b3a.0; 
 Thu, 23 May 2024 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505790; x=1717110590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HIn6EebDMl7L2UyZZ1L1MF0Eu/S2CM8hT7PYe2WBK0=;
 b=kZc37eWBIaqHCWAqi82K5YbalF+sIBlZI2YpCRtveRXjELUklAXWP2JpBTc0X+0R+w
 OV3X+UOasWQRL44X+f1xvKQWQTjHzmaSGFhyjc9pfNSr09jLc4kLJDdN/nCOkbdHWCq+
 qhq8OTGfPN/QySfGgbCYkyEO7SZXbEwwVQujmSgI+s82M8T+Gr+5rbzl4zeH6TLwJnam
 gwBKD99Qmh7uPUJja4aTniqsH83v/ufk17QBIs7GRqrUrAA91S8qXOY3wQcrqXlGZNLw
 AJPIH63oG3zGMqoEldqrMFo83hsp5Nt3P8yOmoAki7EpU1K1MxYxAYPNtkW1n0ggaMb7
 JzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505790; x=1717110590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HIn6EebDMl7L2UyZZ1L1MF0Eu/S2CM8hT7PYe2WBK0=;
 b=nd8CEbIvB8xtOLebu9vNzKE94dj7+fApPXL2J2Vpwc0xZjuHNcZxsFVHJD+EooEPz1
 76CjV8c8E1FaLu7pwkDt9E7BDRw5AEu9gBMSahDlW7muK8KhMm7KwSYtiVYOE05WPVwD
 HioIHLGnJzCfAxsayZrFbiGX23JZrSOawSosDrZe0l1L2qem67F/9hQQQHxzZbDA9pqg
 QjhNIgbq2jXCWhrl+A2AyygRz/ZMa8g7Y3Pu6yUxYAWzF831Pp9nMAjEoMCQSCn1ZGEc
 hnf81NeAfU5UYbDkdAKPl8KrMybRxGFzIsxom2K9iP5OH/dnPPBfUeKHWyRdpTQt7gHq
 oIVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3uZ5prAqXsBap3sJM66HlgkM7MOczqaVt/3isJzZMFDpvFcp4kyGZantNO1D+AQMKf+1Hge12lUTqgoKBbkiFw3iO
X-Gm-Message-State: AOJu0YwylNrxWkV2cfIuBnw/jV1NQQhgZnGde8rKTUiRIghAwaF1n2oI
 /oU4jeq9AjtJXQH86Vd7WxhIq6npCBddwJrvS57gO9WcDDXABweb1340hA==
X-Google-Smtp-Source: AGHT+IH16v6oEV/8o4Y8hKuDJPsHMX4/YBTJFvKwNDu7CuBzg0ffNE+CkYwxEyuihoRA/e6hLJpR4A==
X-Received: by 2002:a05:6a20:9752:b0:1af:9ec6:afbd with SMTP id
 adf61e73a8af0-1b212d5b99amr924080637.11.1716505789621; 
 Thu, 23 May 2024 16:09:49 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 36/72] target/ppc: Implement LDBAR, TTR SPRs
Date: Fri, 24 May 2024 09:07:09 +1000
Message-ID: <20240523230747.45703-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

LDBAR, TTR are a Power-specific SPRs. These simple implementations
are enough for IBM proprietary firmware for now.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 141cbefb4c..823be85d03 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2098,6 +2098,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_DEXCR             (0x33C)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
+#define SPR_LDBAR             (0x352)
 #define SPR_MMCRC             (0x353)
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
@@ -2144,6 +2145,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_440_IVLIM         (0x399)
 #define SPR_TSCR              (0x399)
 #define SPR_750_DMAU          (0x39A)
+#define SPR_POWER_TTR         (0x39A)
 #define SPR_750_DMAL          (0x39B)
 #define SPR_440_RSTCFG        (0x39B)
 #define SPR_BOOKE_DCDBTRL     (0x39C)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 415cc7a4e2..d181adc5f1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5767,6 +5767,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  &spr_access_nop, &spr_write_generic,
                  &spr_access_nop, &spr_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_LDBAR, "LDBAR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_lpar_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_TTR, "TTR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_core_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.43.0



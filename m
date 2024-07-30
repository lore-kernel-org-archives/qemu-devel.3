Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1637DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYj3j-0001G6-JV; Tue, 30 Jul 2024 05:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3h-00018g-TN
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYj3g-0005nY-AH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:22:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so12650615e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331334; x=1722936134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ugc2yLiSsI07WG//ugTlVImvOO+yujn7Q1YmHPiaYeY=;
 b=svE9vyBe4iLfuPzZ3CPXE+TN9XEPe1Pa4WFrbu0faWq9YD120fY/baAVbXZ4/mssYI
 f7jMRXgKz33DhaQ2YFPCL5XqeaY/8l/wTlCFVc1jPjSLbsU4eTqBTwZG3SsmefmYfc5o
 g2n/abH1neRSolNakGn2SYN1f+JG7H8hwzbSWHudoX7009r6cgfni+84rOpNcoabg6MO
 qKR+XqZOty/fNPPdlUPL/vAytzPpW2TDgXstWvTgVyB7RMD2Nzx3zDNKJ/WU2KNgknZv
 Oc6t/EfZVyPDb13G/gyzhyOJ12HFysaldlNSb6+uj0dVQ5i8mOpNiMXkd67pmC0w9lwf
 vsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331334; x=1722936134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ugc2yLiSsI07WG//ugTlVImvOO+yujn7Q1YmHPiaYeY=;
 b=f+8i1vO2sSz+CR+Uokav2ed27mRdFjo9YjBXuL6pn1Q700+DWDJW48PIFoY7ltMNfc
 J8tIDBPzgHzm13Cyf9KjtjZ8pxTcVVIyN1Tc8SaHMTDZ6Q8ig9Wt0Ymy0pILe6S3eTRj
 fHhGAUeluQjDgIX0SFcbzaeaTZzkmXli8NvGaPmNCDMdCLoLLw8q0KuoG3tg9+EXMPSK
 X0Q/4YKveAiVKrb5f6Y/qYUmN2ATGS5ctvgL/57oGdO1R/M/m97fxIkiAzZewUfDNoLi
 BrxvMtagPo7aImjvMJi7sF1aLEImj470j24S+CS05h3SXanh9GZcfuOYMH+aRd0Y5CGE
 Q2tw==
X-Gm-Message-State: AOJu0YxXUHYh6FGkMCsAHbjeD4NDXbzC4Y6eOk2bnX9E1Uxl8ePGqHlG
 Kijd6cZdtHWHn1f/RNYI/qDr9BE8UCalZXMTTYFZG31SApvVnSa76zIbPjcMihra2FOVWqZXXBO
 Yo2A=
X-Google-Smtp-Source: AGHT+IGrxNlg8ZBJVA1vrv42R029iazlceOSbctY1GNsHcX+9VYtmRc2z2zSyU7fzJ/oWi5CIeQ8UA==
X-Received: by 2002:a05:600c:4f8e:b0:426:6e9a:7a1c with SMTP id
 5b1f17b1804b1-42811e12d86mr67992635e9.25.1722331334313; 
 Tue, 30 Jul 2024 02:22:14 -0700 (PDT)
Received: from localhost.localdomain (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42809e4423dsm173477325e9.13.2024.07.30.02.22.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 02:22:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 4/5] hw/sd/sdhci: Trace ADMA descriptors
Date: Tue, 30 Jul 2024 11:21:37 +0200
Message-ID: <20240730092138.32443-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730092138.32443-1-philmd@linaro.org>
References: <20240730092138.32443-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c      | 8 ++++++++
 hw/sd/trace-events | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 8293d83556..66b9364e9e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -693,6 +693,11 @@ typedef struct ADMADescr {
     uint8_t incr;
 } ADMADescr;
 
+static void trace_adma_description(const char *type, const ADMADescr *dscr)
+{
+    trace_sdhci_adma_desc(type, dscr->addr, dscr->length, dscr->attr, dscr->incr);
+}
+
 static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 {
     uint32_t adma1 = 0;
@@ -710,6 +715,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->length = (uint16_t)extract64(adma2, 16, 16);
         dscr->attr = (uint8_t)extract64(adma2, 0, 7);
         dscr->incr = 8;
+        trace_adma_description("ADMA2_32", dscr);
         break;
     case SDHC_CTRL_ADMA1_32:
         dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1),
@@ -723,6 +729,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         } else {
             dscr->length = 4 * KiB;
         }
+        trace_adma_description("ADMA1_32", dscr);
         break;
     case SDHC_CTRL_ADMA2_64:
         dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1,
@@ -735,6 +742,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->addr = le64_to_cpu(dscr->addr);
         dscr->attr &= (uint8_t) ~0xC0;
         dscr->incr = 12;
+        trace_adma_description("ADMA2_64", dscr);
         break;
     }
 }
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 43671dc791..3d3f5c1cb7 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -35,6 +35,7 @@ sdhci_access(const char *access, unsigned int size, uint64_t offset, const char
 sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read from input buffer"
 sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
 sdhci_capareg(const char *desc, uint16_t val) "%s: %u"
+sdhci_adma_desc(const char *type, uint64_t addr, uint16_t length, uint8_t attr, uint8_t incr) "%s addr:0x%08"PRIx64" len:0x%x, attr:0x%x, incr:%u"
 
 # sd.c
 sdcard_normal_command(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t arg, const char *state) "%s %20s/ CMD%02d arg 0x%08x (state %s)"
-- 
2.45.2



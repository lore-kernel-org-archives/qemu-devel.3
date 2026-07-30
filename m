Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1138BC55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtc-00076W-Lh; Thu, 30 Jul 2026 04:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLta-00074s-TC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:38 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-00018B-LO
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:38 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso219008166b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399213; x=1786004013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=agLMlyUmxtwx6g/99v7O2aIN4trfNG9SmIE8yPzBwqA=;
 b=p+dhMsHSP3ibnhb6dzPeMFVBD3RCDETjVV9ej1JYzqBQsJTaxzSTlie/uOjeWiYZzP
 CZnkMWVUtIaCbW5U5rl5lg9ZerRGFFjhy05nFwGl2bldVqt8JAR1D32e7yy2CxZGD0CM
 m9vHLxwV912+2xNk8CS39ytKduNXnWoCIR3GyiCi0OB5ga8M6BWAtA/qzD0ZtDx5WOVe
 IPDaBrw9hwvPzMBh+rNBncbAXs+NrLv+Dzafkpgmj/YMwbkjXAEQdYznwjMxckkL0dXS
 DhYaf8dc+o/WwzDv7YDrL0uyvdN+jni4d4uonOvQVVXsD6wZDb4EVwoUSCx+Slh0Zc/o
 4NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399213; x=1786004013;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=agLMlyUmxtwx6g/99v7O2aIN4trfNG9SmIE8yPzBwqA=;
 b=XHTfZD1HBtRg3yfk8RxUtmi4x+INmZM56g1JfW9gYTBYwaqIW79x3gd0TNxl0pY2xR
 Lm/piKNvkVAyRmBJUe6/9To+6AkB7cO63E3MJRClXbN951+MCjl2gr5NT2nqCXWtJf6U
 CERELrH0WC2otHaUnXf/MvxHV12cQX1DMlp1jtHv3n1HZ3VVmVIfmNyDap0UPQkPmSOB
 PKBIaNqJQUU0vfKeXlAKEB2V8J39ffLMm6xGgxZhbhYhE+grCYC80r2PhR+SCKW6N444
 R9sJyigGy9CAr3FApcH/xUtQxaalqcFVMNTBwOI8pTzCx8H3pPJqIoo7I1pueby/JCW4
 S/RA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrofdl8s72wB+bBA+ER3TGIIP7qxoeC6qBIb7Nsw3TQ0lTarSeYonOua+t0bLr0hrtSL4+0yHHbnpwy@nongnu.org
X-Gm-Message-State: AOJu0YzMLBvTPvfWgswm9oph02YFj4b2muvj4BVTZ3g6zXc50r47vLhW
 v7rnWfYqY+eTI5im53Ywozr7JUCMDHGWChgEcg5yu/7m7poMAueYli998dSR7N0zdQ4=
X-Gm-Gg: AR+sD10vtKRxcTuynoYG8CcIbilOfLx+MfPSuoPGpztERcQq8ecbaPqKlJz9dwOAX6m
 Jky4oNSCBCAAibC0ph/pOrQt5cHldCouyCXkhbzzNYVZMG09lZKbBX85X87KTgsCr1+N6ZPspBw
 Mgqz7GeYhniXxkIOT9tUUzNjjVdCI3nWuWLGbJF2r13jEy2QnW0+UGGGL99QuFk4NSHAp6Oljaj
 mA4XmMUNRn1lx/ceYk5WEtBLJXp0xk/y7Q9bFJOmzpyd7nqURJThg1enmMTvpStUg9BgPuon5C5
 ujhg0+NAE4i85rSvUbRQst7Sa6fNIuJsNiR6C3nv/8Dh1CKi3WF9xL9iAPDrHO8YLSSmz/RVmBw
 FGKo+x7CqLl+1IyWoeB1qaDlw9Iq3q0RKEH+xX8F7zZg87MiUZxE0ojIbdTQwhxWwjC18Fqacmo
 6lyz86/MDUxe2evDCMVqk48EDTSJ5nEbMEZt330M5fYnIFv1qC18G7m0zy8YKq
X-Received: by 2002:a17:906:9fc7:b0:c1b:66a5:e8f0 with SMTP id
 a640c23a62f3a-c1fa56985b8mr89990266b.4.1785399212980; 
 Thu, 30 Jul 2026 01:13:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 5/8] tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
Date: Thu, 30 Jul 2026 10:13:21 +0200
Message-ID: <20260730081325.1816193-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=den@openvz.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ahci_exec() always builds ATAPI commands with a 2048-byte logical
sector size, so it cannot drive a READ CD that returns full 2352-byte
raw sectors. Add an atapi_raw option that sets the READ CD
field-selector to 0xf8 and the command's sector size to 2352 before
the transfer is sized, so the derived block count stays correct while
the buffer and byte counts cover the raw sectors.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/libqos/ahci.c | 5 +++++
 tests/qtest/libqos/ahci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 0621a6c477..e3019a1eca 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -707,6 +707,11 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     if (opts->atapi) {
         uint16_t bcl = opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE;
         cmd = ahci_atapi_command_create(op, bcl, opts->atapi_dma);
+        if (opts->atapi_raw) {
+            /* request full 2352-byte raw sectors; sector_size must match */
+            cmd->atapi_cmd[9] = 0xf8;
+            cmd->sector_size = ATAPI_RAW_SECTOR_SIZE;
+        }
     } else {
         cmd = ahci_command_create(op);
     }
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557..2a48a7523d 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -242,6 +242,7 @@
 
 #define AHCI_SECTOR_SIZE                (512)
 #define ATAPI_SECTOR_SIZE              (2048)
+#define ATAPI_RAW_SECTOR_SIZE          (2352)
 
 #define AHCI_SIGNATURE_CDROM     (0xeb140101)
 #define AHCI_SIGNATURE_DISK      (0x00000101)
@@ -485,6 +486,7 @@ typedef struct AHCIOpts {
     uint64_t buffer;    /* Pointer to source or destination guest buffer */
     bool atapi;         /* ATAPI command? */
     bool atapi_dma;     /* Use DMA for ATAPI? */
+    bool atapi_raw;     /* READ CD returning 2352-byte raw sectors */
     bool error;
     int (*pre_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
     int (*mid_cb)(AHCIQState*, AHCICommand*, const struct AHCIOpts *);
-- 
2.53.0



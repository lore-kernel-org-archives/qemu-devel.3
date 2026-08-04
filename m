Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B39C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVL-00006m-GD; Tue, 04 Aug 2026 13:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIVJ-000051-Aw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIVH-0000ib-Oc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so27619f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862834; x=1786467634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=agLMlyUmxtwx6g/99v7O2aIN4trfNG9SmIE8yPzBwqA=;
 b=PwahHVmGkSIjcWIKyUnEygn8lE0VlB06XDTb3/ZVyig+rKqgD9TiDHU70iJtCAcmlu
 W6a5GNVoRvmWDoZq/EjM4axwzNvlqtBbFOzPBTF2rc5b+bCDAVE/e4zh68qAmBc4EC5U
 ZyvfDG0pEAhYJl1cze7BzauVUfaLEEC2a+Orz28j0x4HBZ19pgeEvW18bN2wGSt9ns4/
 Ef7lMucKyxfqk1yKOx72mdXru8niN7VEBXaUJUkhtWJuyDkytxdp2cApIMdkiwa+/w2a
 4wVkRY9+oRQU9cLKf2eaYhPyXsuVTB70hrUckKXba42CXMC/voBkk147Mi813H3Dbrlr
 BESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862834; x=1786467634;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=agLMlyUmxtwx6g/99v7O2aIN4trfNG9SmIE8yPzBwqA=;
 b=ipA8fgHOHO64P7WOi2uVj1IqIoapVbXcU40ztKfl00/FBtnBU/pCZ+CwUqykxhUA+3
 bn9ew3UUDrJleJiq42PipVZPNHTL1NEgGUWLCFPu0LSIINU1BE4JysCBVmRbbbs/E9wE
 eop3y361BSlwDWsVQhPJVBXVPGnUhjdEEwsMZ06msSIZRhQDJ6KZzCMFtUcMPGy37Aay
 4CKB9xbLfjPOqZxRLU96qyp4JkjcIHBLXAppFiIuthC8l9Fao6Telc1Ue7Knt5k6bXLi
 WFeCYkX7hxN2jl97irqXnMC+FlQzHDKfbgT0tw6SAZ4alfU3H8SUbCX4XcxxiRCkn4Ms
 MVPQ==
X-Gm-Message-State: AOJu0YxpixMsJepmKnriAgdDk8RGDgjD1hevdDA1xlpoQ6/5xSZZNWMm
 8VXNlBZfywNweTvjcjaGbB8LSzn9jW6hCDxsA900O2vKo5FWTn+BARyPv7qVmbtClkXHWUWwwGC
 r4/Ac
X-Gm-Gg: AR+sD11pF44kXFdETA/Hu4KtVdGw2Q0ju/GPWJOEfVjkg0vtO+92VJxpveH6Zg7UfkY
 Q69lrjNCV4IIInVyzAUY6AvRtZiB5sCPO3+sQIx7WUQniRgLQHAgVvtno05dbzu09Nn8GXgo3YM
 CW3375lDgTokVUCcjuSD3qhpj8jF5c2B6kaX0zGPW7kdq9topQIuQqjAtlc/OVlfK5ToOCWbg4j
 eBN4M03OfKNx75sj2/K/1e2e5fZ5vsFmNXNxT0YLRUEks7Pq9u7gGX6eSu/T6Awhrqmq7kHsHyg
 GtK8p07P3M76ohnhqybIOLVusXxGD+9hNfe09qUIIY7ZNaCCQYYqK4XlIBhJukQ+7sJkikDwr4e
 yLIdbg7fosvrNLiguQn1t0twiNK5i0vr6vw9ki0wlWUMG6thUN8E+WsJ7NcnWI5f3sOPKJhbgtc
 ZjCv3RGdI90HiYc6Qv50SOYEOrJhU9oDE=
X-Received: by 2002:a05:6000:3113:b0:47f:80f0:8d33 with SMTP id
 ffacd0b85a97d-47fec6457camr980429f8f.30.1785862824261; 
 Tue, 04 Aug 2026 10:00:24 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 4/7] tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
Date: Tue,  4 Aug 2026 19:00:11 +0200
Message-ID: <20260804170015.3128363-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
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



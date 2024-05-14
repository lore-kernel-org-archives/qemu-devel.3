Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E252C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6kWq-0005PL-ND; Tue, 14 May 2024 01:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kWb-0005LM-Ad; Tue, 14 May 2024 01:16:30 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kWZ-0007Wt-KF; Tue, 14 May 2024 01:16:29 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c99c66a40fso2150290b6e.1; 
 Mon, 13 May 2024 22:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715663785; x=1716268585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ltzk5yO+pOa0XOKhz6pBlpqqF49ySHOXvETGMOP2kRk=;
 b=Zoraf2mw1fsoPNn3PS8WYcmPcJjxJq+xtNoPadXQBK1tP/OUy/tSvYVqFfHbW+CuxR
 oGiCSWwH70wOgKc74Q5efK1YACxXbmMm7rkms5US/T1zB1M42My1qCFcklMBuZQXV2i1
 KsaOaFasA2OSR8FPELiAJDt+KxCP5f3KnrZV4zkiS3nXAjl6AYHxhSlbK68t0kPVS4gO
 8SxZZxer3wMPJjLSnqn+/2P92apBT/fWUbKfhGHu0TYOCmvZAADrD5lHESd4OUxPTqkg
 xmY/huIIQAvukdouuJICsJwxjjHLbNRZJgrnAL1aE6w3A9XLCMsYfdktopQcjM6N7xQe
 eUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715663785; x=1716268585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ltzk5yO+pOa0XOKhz6pBlpqqF49ySHOXvETGMOP2kRk=;
 b=VLgqi/9q6CPNPwf2o3leA3D1x2DgxADbkjrJmY7yetFqRyXFJzvlEqN/GildOC2drz
 i+8v971oZXoLJHFZ0ML90HqB7w/Mfnig5KMejDShK10ZUgaQv2o/CvieZxOmXvrhXsu1
 qpQmM+Y/ncgRODgniiE19dviSU8Dk+GDm/bUO4A3ZF3xBmmQsG/C2MQr2Kdr0AwWlKrz
 00Oths7l4vip6l963c9z2S3xKKHDNHypdTjXguMRItKgPil+JMNd7PTz3uZUUWbXf9tr
 1k70eHuzqq8oVAg7724oJSC1zLGQJ4ReAA2WdSvIJ53yaA0lnxpFUZM//aTaEEV0hMgW
 efXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOnlNupzrR/FvzeQtiXdx2acS2DWDB1jZCHEiwp+/4/9njxQJwd6GUyrCj74ywcKuPm2NRgl254PfSx0yVgL5B3zS4vqs=
X-Gm-Message-State: AOJu0YzdaHj1b+DXIQ9EFtBnbadoudoZuxkFnVVNJKwaZF4UZEyzci+v
 dbhNrf5A5otY0RC/9yVHYa743l4FvCelwbWbOSNozaaZyay2awpM9WC5HqImMtc=
X-Google-Smtp-Source: AGHT+IEa3CMwro9JxS2nAeQKlANHhzFJQW7QSk9jYZp5wfcxyNM5mlvnqtVdMmjVEO22I5gRYCrxCw==
X-Received: by 2002:a05:6808:6291:b0:3c9:5538:8688 with SMTP id
 5614622812f47-3c9970cd312mr10737737b6e.36.1715663784923; 
 Mon, 13 May 2024 22:16:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a9d981sm8455858b3a.94.2024.05.13.22.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 22:16:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, bin.meng@windriver.com, qemu-riscv@nongnu.org,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, palmer@dabbelt.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com,
 eric_devolder@yahoo.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] dias/riscv: Decode all of the pmpcfg and pmpaddr CSRs
Date: Tue, 14 May 2024 15:16:15 +1000
Message-ID: <20240514051615.330979-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22d.google.com
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

Previously we only listed a single pmpcfg CSR and the first 16 pmpaddr
CSRs. This patch fixes this to list all 16 pmpcfg and all 64 pmpaddr
CSRs are part of the dissassembly.

Reported-by: Eric DeVolder <eric_devolder@yahoo.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e236c8b5b7..297cfa2f63 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2190,7 +2190,22 @@ static const char *csr_name(int csrno)
     case 0x0383: return "mibound";
     case 0x0384: return "mdbase";
     case 0x0385: return "mdbound";
-    case 0x03a0: return "pmpcfg3";
+    case 0x03a0: return "pmpcfg0";
+    case 0x03a1: return "pmpcfg1";
+    case 0x03a2: return "pmpcfg2";
+    case 0x03a3: return "pmpcfg3";
+    case 0x03a4: return "pmpcfg4";
+    case 0x03a5: return "pmpcfg5";
+    case 0x03a6: return "pmpcfg6";
+    case 0x03a7: return "pmpcfg7";
+    case 0x03a8: return "pmpcfg8";
+    case 0x03a9: return "pmpcfg9";
+    case 0x03aa: return "pmpcfg10";
+    case 0x03ab: return "pmpcfg11";
+    case 0x03ac: return "pmpcfg12";
+    case 0x03ad: return "pmpcfg13";
+    case 0x03ae: return "pmpcfg14";
+    case 0x03af: return "pmpcfg15";
     case 0x03b0: return "pmpaddr0";
     case 0x03b1: return "pmpaddr1";
     case 0x03b2: return "pmpaddr2";
@@ -2207,6 +2222,54 @@ static const char *csr_name(int csrno)
     case 0x03bd: return "pmpaddr13";
     case 0x03be: return "pmpaddr14";
     case 0x03bf: return "pmpaddr15";
+    case 0x03c0: return "pmpaddr16";
+    case 0x03c1: return "pmpaddr17";
+    case 0x03c2: return "pmpaddr18";
+    case 0x03c3: return "pmpaddr19";
+    case 0x03c4: return "pmpaddr20";
+    case 0x03c5: return "pmpaddr21";
+    case 0x03c6: return "pmpaddr22";
+    case 0x03c7: return "pmpaddr23";
+    case 0x03c8: return "pmpaddr24";
+    case 0x03c9: return "pmpaddr25";
+    case 0x03ca: return "pmpaddr26";
+    case 0x03cb: return "pmpaddr27";
+    case 0x03cc: return "pmpaddr28";
+    case 0x03cd: return "pmpaddr29";
+    case 0x03ce: return "pmpaddr30";
+    case 0x03cf: return "pmpaddr31";
+    case 0x03d0: return "pmpaddr32";
+    case 0x03d1: return "pmpaddr33";
+    case 0x03d2: return "pmpaddr34";
+    case 0x03d3: return "pmpaddr35";
+    case 0x03d4: return "pmpaddr36";
+    case 0x03d5: return "pmpaddr37";
+    case 0x03d6: return "pmpaddr38";
+    case 0x03d7: return "pmpaddr39";
+    case 0x03d8: return "pmpaddr40";
+    case 0x03d9: return "pmpaddr41";
+    case 0x03da: return "pmpaddr42";
+    case 0x03db: return "pmpaddr43";
+    case 0x03dc: return "pmpaddr44";
+    case 0x03dd: return "pmpaddr45";
+    case 0x03de: return "pmpaddr46";
+    case 0x03df: return "pmpaddr47";
+    case 0x03e0: return "pmpaddr48";
+    case 0x03e1: return "pmpaddr49";
+    case 0x03e2: return "pmpaddr50";
+    case 0x03e3: return "pmpaddr51";
+    case 0x03e4: return "pmpaddr52";
+    case 0x03e5: return "pmpaddr53";
+    case 0x03e6: return "pmpaddr54";
+    case 0x03e7: return "pmpaddr55";
+    case 0x03e8: return "pmpaddr56";
+    case 0x03e9: return "pmpaddr57";
+    case 0x03ea: return "pmpaddr58";
+    case 0x03eb: return "pmpaddr59";
+    case 0x03ec: return "pmpaddr60";
+    case 0x03ed: return "pmpaddr61";
+    case 0x03ee: return "pmpaddr62";
+    case 0x03ef: return "pmpaddr63";
     case 0x0780: return "mtohost";
     case 0x0781: return "mfromhost";
     case 0x0782: return "mreset";
-- 
2.45.0



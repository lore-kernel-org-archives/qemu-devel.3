Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE39DC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiLOG-0002nW-TI; Fri, 10 Jul 2026 20:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1wiJe7-0007t4-St
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:24:35 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1wiJe6-0006iQ-CN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:24:35 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-39c8dbf4f38so13733551fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783722272; x=1784327072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a1VcYo6Li8HN5FVWYK0KPdgZk8BbnfCQuFN3FFztCGY=;
 b=BT9xB0UXH09QwLyNyc2IDdEcW6kMG5dHvjv4KoAodW6Xaai/bMi7c4CWxmcpDTVgjb
 kU9ZF40YDrfeHaGsTo9vxWw+4TJ96nJX9ElfvxdojRzLB/c8Qc+3YcsDrCvnUXNyWEha
 xbLF2Z060zoRJ4EXYCp18qoJepVgzaiEH4kS5mcvEqm1t57yX77zttAhjvGEC16r7Re6
 QChZ0KMiPz3uE2ZuCKbdKjKvUYeiff38O51KVQuV63yPPSx0eQukYu91vLgyabe9Q++V
 Tf/p3yGMjfY9eacNZoA3Adkx/Ljhbsb6cI2boCYpNr74pbuNYkvtwgp6xrWfF4WiSlPe
 BQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722272; x=1784327072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1VcYo6Li8HN5FVWYK0KPdgZk8BbnfCQuFN3FFztCGY=;
 b=LoALzCmVtV75wHmpJjcLHIM8YliGriOWwGtRANK28pLNjMLwNkmgNktf8WkwIjs6E6
 6s3rqrZ6kC2aiRkBuR2OgGfEedB+Os10WcfXVqNoOA9Ohx8FLDsskUVbaG/RUvnq3oBL
 z2c9msBknAgA/GgOIjYsWIEG5qCbRYtH8F1RDR6GqITDBnPVUbVcRgXLuur7cE/qX6jM
 TpLg7RhMkQpmAl5Bu8p2SwKvbHKDcCiwFsUJyUMRYNXkmNszpB6GLAZfHJJtKMe4sfX6
 sdeg01LyfxgaauyI4rDPF50sPeH01+T7RRjJutX0EsFI28u4i46lD9WwvxcxF6xbqEkk
 xkVg==
X-Gm-Message-State: AOJu0Yx/pIeMRHT9juQWH6DFl81wUxb0qGFw8XIwv1I9ymKAZUAVjro0
 WgKfOKbV28tHkQMpAhQrMstTwSoJiGo5CgScrTK0ry71NlBwXmFaRHvM35eK/YRUMgsnnw==
X-Gm-Gg: AfdE7cmOL8mLNT87TIr7+tRFlmZ01LbCktXa6WJgf1V2XsVRqdVcoDF8/lRK7eGKy0E
 0LOoBpd4v8mwPWxdnKgXgdqaqfArEB/D81JRyNg9RFGgU4kczCjBya4Q33osZ7ZqDb+trIhXH98
 BM3TQCRJTYFtRAtBfgVDLunG0yw9UbUMcbLj27RtThCXTa41LcMvsW+GVUHp/Z2HNJDqFtQscT+
 jDzn7T9a1NCBrmmI2aXgw/yxFzRfHoJmd4XG7dP2Skl95wUvC5bpCa63Adi4MwDfpMU6G3bxILV
 V1HVBT7RADsuR/ohQGtg0Sl863Gd1JFzgHGuFKAYPMjxvGfbGi5SjllAvdaUa4jNvtTNHA6Fd1G
 gtKoYtDugfQ/gBD33/GekpHE5+6KlLc13OT7eGiGY1b4ReaYF6BceXOORE4cl1gfuMujHTENO9T
 9Oe3y5/0H2MSbwsd2cJK6VExMZbf4ZXQ==
X-Received: by 2002:a2e:a006:0:b0:39c:7d51:70d8 with SMTP id
 38308e7fff4ca-39caa8884camr1025651fa.32.1783722271825; 
 Fri, 10 Jul 2026 15:24:31 -0700 (PDT)
Received: from vmbox.lan (088156177242.warszawa.vectranet.pl. [88.156.177.242])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39ca11ba925sm3282261fa.31.2026.07.10.15.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 15:24:31 -0700 (PDT)
From: Dmitry Pimenov <sun4qemu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Dmitry Pimenov <sun4qemu@gmail.com>
Subject: [PATCH] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
Date: Sat, 11 Jul 2026 00:23:50 +0200
Message-ID: <20260710222350.9185-1-sun4qemu@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=sun4qemu@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:16:19 -0400
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

blk_getlength() returns int64_t, but niagara_init() stored it in an int,
truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
before the CPU ran, ending with:

  qemu-system-sparc64: could not load ram disk

AI-used-for: code (bug fix)
Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
---
 hw/sparc64/niagara.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1211ecb82d..ad5e5945a8 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)
        outside of the partition RAM */
     if (dinfo) {
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
-        int size = blk_getlength(blk);
+        int64_t size = blk_getlength(blk);
         if (size > 0) {
             memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
                                    &error_fatal);
--
2.43.0


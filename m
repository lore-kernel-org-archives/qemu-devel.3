Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CD606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=UuY4iDgZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqKg-0004P9-0O; Tue, 10 Nov 2026 13:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKS-0004L4-6T
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:24 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKJ-0001Bk-Fr
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:17 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-70bf1671c21so1364506eaf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794334330; x=1794939130; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82yY37z4xR89rS78RrvGdWkJgveQfhnXEPscnEIBwQ8=;
 b=UuY4iDgZxagvc0bmpeemqx3hEh5XmHRsaU8GqO9x6gtI29kTpeLo9OCy5cdX63Bapg
 8AuTWpuH/whgaXOjo4FXXDwrufNkPkmuh7QYiMkfp0FxpesdpkM0mrrfdGqhsSVkQ7pC
 FO2C44dsaNE6+p5FsfBOyHb50cF17niPY1cKa/o/kKNFspl0fCqKAQzt/dNWzdjzIsgL
 C1DedUh/idOt03xGG7aHkKQQNBJ/aygZyI90N1vtMntepV1TK+HWufUs5tRCKx2ZgwI3
 pKQEMhD5nuwHM1J1P9uVkuH1j8+4+v0wXSU9ceCefG1MTwzdNI9hSptaBqnBuV9i0O47
 si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334330; x=1794939130;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82yY37z4xR89rS78RrvGdWkJgveQfhnXEPscnEIBwQ8=;
 b=Xp1ZfqvOOUhsqyOYoI1l3C1D+BMGrx1eFFAvokq19p4iXhYe2idj3Qg8eX6p6kbRoP
 uefwbEnNY0iSTueORG2mrotEBc42/qCqpEMfLpZWN6Jx9s3HcuhV20dtvNB8/lWP1ArO
 yiop/Xeky0xEAwdi32Iu3K3UEkRQl7U6erC2x9yk+0hR7GIYJHOjj05azh6+aCt5MAal
 w9LSksAyDiPAnzeLURiXUB+RHm57viRP7UN6BuN1vDmRU4hjVJhMIAPSgCZCVTurw6aF
 qqrEy+pYQoDWyg7I2OzJWAP7moNjdmDLlhzX7MNsu9Egtm7xM8aHlZU6o4EQIW+Ovu2c
 M0kA==
X-Gm-Message-State: APuU4Z+GcjL5mGwWiZiMSFETEv75foekgWxi+Z6ox7JEK0QFVv20bMtn
 x0dElYnqhdE2pFP4aDaD9cTkC8VSq89SKzP/43jb2ATmrccmzAOs+VHDkHX8PhXf+wA=
X-Gm-Gg: AYBFou2bVU1E24VbGqAZfpxAlrA2C6vnE4uDl6kZf6skUj8WrcmiWrDoPkiTAC7Lpnk
 SJlrqMky/akiOzmfu54IEjceKgOPh8pSUsTP3TLhfuKOYtRl/Lh+RnXoKCLOimJlGtiemsptCoq
 HMJVMvayGhzdp2G7JwYY+t1zSszAWt4vZ69dIKeZXT810qfSTILIJogBiJVPrcguLxe7qRG1gjy
 ueoO7ErGSg3/Xcj9H66IMDxsnJ+6T3Vm0gwELIS/r1XdaAIM4/hKxaHKBY245GyocDUKyrFkuBX
 iucpeZmnl1/S83iMDu1K77gpIzsiH0jYRvTvDLEIMGlkceG3sWyPhoB4BD/7TX62ykU7PGUXaIO
 1zWoQKLgR0/rbNrCbD0vis5sRDD5h7ZywF8kDnHXJJNwt/rM1T7lHdPOp570Re21Q8TdB6DsZli
 q3VaeulfVs8H/JcI9XD3pSfmsBk1Vzbr+F5Zj0RzUxnrwApcexVy4Veqob1XOlJXf4GwPDNtdwq
 yAFIXUBfvmNjFEcguRvXhu331wp86l3pFrXq+gTAZrCln+H6Zqd/UIpxI1jHw1LRd5FfY7TJgW0
 JcsOQ0BIJyi9aa/LWFmyHO6d5zRVrnQbxYwKCO2kYZcvjnxLgkInL+lrdYFoa6jT3YhLq+iQ0PW
 daYE=
X-Received: by 2002:a05:6820:c2c7:20b0:713:da3b:8b07 with SMTP id
 006d021491bc7-718a683de44mr1418242eaf.54.1794334330213; 
 Tue, 10 Nov 2026 10:12:10 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718aa034ad2sm2063514eaf.13.2026.11.10.10.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:12:09 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 10 Nov 2026 12:11:49 -0600
Subject: [PATCH 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-m25p80_write_enable_fix-v1-2-3a2abc0072b0@oss.tenstorrent.com>
References: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
In-Reply-To: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NOR flash drivers in EDK2[1] and its forks[2] poll for write enable
(WEL) to be deasserted at the end of a SPI operation to indicate that
the operation has been completed. The m25p80 spec[3] indicates that real
hardware would desassert WEL at the end of page program and erase
operations.

The m25p80 model does not deassert WEL at the end of these operations.
Update the model to do so to match hardware behaviour.

[1] https://github.com/tianocore/edk2/blob/3c890c11dfdb5908dcbc84f977dddc6c6d43789f/MdeModulePkg/Bus/Spi/SpiNorFlashJedecSfdp/SpiNorFlash.c#L987
[2] https://github.com/spacemit-com/edk2-platforms/blob/0b8b7182d8a20a771b97a487d0e6f4ab89fb3492/Silicon/Spacemit/Drivers/Spi/SpiNorFlashDxe/SpiNorFlashDxe.c#L532
[3] https://www.alldatasheet.com/datasheet-pdf/download/22807/STMICROELECTRONICS/M25P80.html

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 hw/block/m25p80.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 545e0b5728..cedfec67a2 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -650,6 +650,8 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
     }
     memset(s->storage + offset, 0xff, len);
     flash_sync_area(s, offset, len);
+
+    s->write_enable = false;
 }
 
 static inline void flash_sync_dirty(Flash *s, int64_t newpage)
@@ -1599,6 +1601,10 @@ static int m25p80_cs(SSIPeripheral *ss, bool select)
         if (s->state == STATE_COLLECTING_VAR_LEN_DATA) {
             complete_collecting_data(s);
         }
+        /* Deassert WEL at the end of a non-AAI page program */
+        if (s->state == STATE_PAGE_PROGRAM && !s->aai_enable) {
+            s->write_enable = false;
+        }
         s->len = 0;
         s->pos = 0;
         s->state = STATE_IDLE;

-- 
2.43.0



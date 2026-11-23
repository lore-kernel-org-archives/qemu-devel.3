Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD577606A6B6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Yh0mz9zV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVvA-0003t7-BS; Mon, 23 Nov 2026 10:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrR-0001Tp-Ha
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:46 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xVVrN-0003dn-Kb
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:21:41 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-675617e81f9so3698298d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795447296; x=1796052096; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zjDSjVSaQv5onZy9G9AdiSofPPT37pH5ZbfoqbnGSeA=;
 b=Yh0mz9zVshrxNnmSTfvp/ANND5sU2bgsACqGyHkzgWo4UuE62eGE1cQ7pjDocP8Atx
 yAdhV6CP9DHmEaCtT/612+tmjwJayYt05tK8K9l3HBeazZr0ACIwtZK8AjmOjF7+VRk5
 rRW4mv0e5jjwKBEPKKZubZ4Kt1w1NRVZ4c26IXSovBL2GzsCXVdCqbZr4bBt+5NsquvQ
 B2QwrZbnLZnH/ri0eI0KguiRi/nhe297Z/XqaenwszTllhn1OvKSeZKtbZojWXLBnbbR
 7oeQxXStduAHFNXU/vlLCnZgLn/mTJZZVHq9u4++BuVvupajG1GOibCth60zph/g4HNz
 d1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795447296; x=1796052096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zjDSjVSaQv5onZy9G9AdiSofPPT37pH5ZbfoqbnGSeA=;
 b=KSLyPdJ7fuYpjFup0qEpWHj0SzRkCTtJQJRUQ0p82vhLa5tzvdeuNUQ+6KfIwKqDJ3
 G/E7clmnJFEa6Melksyeiyzm98RHlobZhzNEvVFG1EbBXDInrfXURqghdVTP1i1LTJXr
 C7tPf5SXpv48AcSrwY1SK3DgLubJsSMmnU9OikdXACZex/M1e6mFkDwFfFtHaxTu7l/8
 uT9lXda1gnK4v/rnRb+TdWcD0HzwnUYZsxuFbdm6TleAQtj9Nt4A08Ajaovtv5hDck/S
 kpN0qRHgQFczJTmTo4HMNU3eGCRR94Sq3JYJpSnGFh8OkuI9p3altN7XT++bPUBu1qHZ
 7fNg==
X-Gm-Message-State: APuU4Z+C4QECwYWxbJzLNN0yAPdKkG/Xw3KuqkUR0XMq9y8zNWKikz29
 8IC6hmykebwPBHa4+suv5niNzSg5O4bvHqcs4osWX0n9nNHYJJzKcA3QBHuLRxtsd/0=
X-Gm-Gg: AZFdTZfPaAiMAp8rhsQxTdX0hVJwDgy8rIXpxdhh/a5yTgP23JNGJh11ybx+9xK7GvG
 6QS/Lvmc/Ovx02i21LRwjss4cQvWMEt66nnwZjqQcqJOSMzo7eb4T1TOzfs0C+t0/eYb5xLoCeX
 kAsQFocsbS6aZ0eX45HI1mmx0cm7ikNXaqxmBJL9xtnrAZRb4d/Y9ds25N5LKnQSqIlKUQyaoxb
 IGSLNq3CVCKRe+lZS8mc+PbkoEmlhpwLbFgzaIIcM6+gCJPFEhuypPsKiCYsXlqaWRtCIBrJVVa
 vitXpMGv+qbabFSjjJ+2+Rj1ShzeUlEXEWyiO8s4ZexMSoguF6c7GO3fEZk/jvDHbBVFIeD36EE
 xOVuueGly4aCEKKl+guE3XrvlrMrx5kB9tNHo4IfzzKNBtJiON8kCzeSaiaY1pQu0KKXy1geCaL
 mP7sDTyRKZFpKqjFmoMnAo+D+hP+wfb9JfNPKF7zBp5lGtsv1FtjjKXU37X/ypP4kZqfzbJl5s7
 CIc6Ktk0IFWa8AQqdhMEIoTZxhcE+gykKRhCjS/qzno5wPTKMtrMOKsPtbiv4CKfYGni7ZcJaBl
 0GnhiqCAxEN+/hPDCoDG3eAXAFkhJMDus0GfmbDpcPE/LFTyX1FPDhPVDHE6KkTFI5/ONkVjIRk
 4ejd75Kfd
X-Received: by 2002:a05:690e:440d:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67df4446b92mr2967874d50.78.1795447296128; 
 Mon, 23 Nov 2026 07:21:36 -0800 (PST)
Received: from [192.168.2.129] ([2600:1700:220:59e0:f880:d5ac:69f1:fb89])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67df3353258sm5747939d50.9.2026.11.23.07.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:21:35 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 23 Nov 2026 09:21:17 -0600
Subject: [PATCH v2 2/2] m25p80: Clear write_enable after page program and
 flash erase operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-m25p80_write_enable_fix-v2-2-0ac94f99e91f@oss.tenstorrent.com>
References: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
In-Reply-To: <20261123-m25p80_write_enable_fix-v2-0-0ac94f99e91f@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-stable@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fixes: 82a2499011a7 ("m25p80: Initial implementation of SPI flash device")
Cc: qemu-stable@nongnu.org
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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



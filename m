Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A866606A32D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xtpwa8Eo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOYyu-0007KT-Uz; Wed, 04 Nov 2026 06:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOYys-0007KB-Sw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:16:38 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conti.manuele@gmail.com>)
 id 1xOYyr-00030Q-FS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:16:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so4937975e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793790995; x=1794395795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S7eDLXQ0og57+xOZX0NmwqU/jjtzubiIQLOAYYMpEx8=;
 b=xtpwa8EoXd3glwE6zVtGWI9DeWrHbvAFl55G+sdcPQPKOmZTDU6Ls8cvvtj37Pdaa+
 UjnJN21redftPTcG7j47j+NN29PQXkvZ/LrsMT6zENDVQ/P2CrCCoOsZBoWLd8zDOG+3
 HNBSKNInx04RVUCQU9Afx02e/BzJyBKxkM3tKecfam/GkPBnMDjKQvfz2BNWgxfHUzz+
 oyczsvV0LzsKRSnr6BV0AT2Limn7GoKrglCy51j0EkOSIRunvmwi5sJB2EFPvGpqB1OJ
 AmBVi3rl+IYWiIQWrwJqmi8+74s2oBMa9Y2m2qdMMVUdU0wufpBh6oLa44g6CbgmXydK
 tFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790995; x=1794395795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S7eDLXQ0og57+xOZX0NmwqU/jjtzubiIQLOAYYMpEx8=;
 b=c2igdYCMc+ySvSClNllYSKIyJ8ogK2EQWCl0/TguXLdd16eMDRCH6TtpUUNjXFBMJi
 gizWgP0gO3WB6J6suHy2RqprtrEh6xn9ztjmSu26pXWX1TkW+JyRo9aPQ08rPzWjHxjV
 40fqxfSJys6jmuoG0LlS9DwnIJQ5TfeclBknsYvRNOOuIEPs3NrFKrxKfoGAW4yswLBm
 hB3lkCR4s/tzKwibFeL/CuwDOoWyK8aYsMESJ7Ekvw9AXORypur+ZXje/rR2aHibzcwG
 nErLGEcD/9rS9rOTe0M9chXmQvct0UsXNGJH8ZZRjOQbrwbvymZu1Wu2vDAE6+tqSNmA
 NoJQ==
X-Gm-Message-State: APuU4Z/1EA1IgqY0o+ODcBsPGOT8ZarLXkKy7O5poZhsoXRMcPZMly8u
 Ep9+3XSECAB/CJjcvOPYoWUtE0qm0JjA54FA6i7RStyp/REDSKMPct3wd0Lvqg==
X-Gm-Gg: AYBFou2siqqsPBvBsuBpfFzr6+6Su+2m5sGgaXHWi8EZLi5xBE7L+4rCrIPRtr9D7w8
 L3/9iEcrsIp0K3kSfn2i0XvI0YmvyHACCdoG8O6je4/nWJc8rEI23OW5kT8TmzjNC/fPsTJ6jZs
 L6p4BH7x/SX4pkYe4MAqjc6fk32JftKovN/ufQ+I8h+/0O/pLsXWBJt3cBDfxDD3NGxwWJcE0ck
 ukjuMa9FqmWUpiOyNlZmT+VBbzcelRZIn45a+ArGqObjcl+o22OQRt/8hVN6b88ofzwLf/McFrc
 ZauEsFT5Aak4tjVx69uiSZJFfgCFxmpQgEIfkCzoK2CeVJ0Tz0wd9MNNxNczUoC1+jythmooEa+
 p2li3YHdTbhDDgYZwfdQ916LOCe2mzgYEaJsBoGmyCVss6B+YSfxGscwXr8jkkrU9WZFq1onMDF
 RIILNKM4OElfJpJ1+VIUb5k3ktu1rnAejtCSPAcFazEmEX6p0uou9Dz9UA+P9Z1FoECtMXlAyBI
 sZ7erEgtBjaqum6oXwunT6ij0bN7ES264klmC+RTAklyaC50sG+NBUy495HAzvKwckAPJnRtSdL
 X24aejylWz0Fy+DlnTlEAoxUSjdC4pTnJNkWxzRJMaWMwi8heik6/lOdMXqkGl54CG0oAHGFn+e
 9WO59QTth2/n8NBGd
X-Received: by 2002:a05:600c:19d3:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4ac1209eafcmr357695365e9.0.1793790995101; 
 Wed, 04 Nov 2026 03:16:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:7d0:d208:aa00:9908:ec2a:cbac:ad71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43a48adb7sm49347175e9.1.2026.11.04.03.16.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 03:16:34 -0800 (PST)
From: Manuele Conti <conti.manuele@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manuele Conti <conti.manuele@gmail.com>
Subject: [PATCH] hw/sd/ssi-sd: Handle immediate write start token after R1
Date: Wed,  4 Nov 2026 12:16:19 +0100
Message-ID: <20261104111619.24479-1-conti.manuele@gmail.com>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=conti.manuele@gmail.com; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a write start token immediately follows the R1 response,
the SPI SD controller may still be in SSI_SD_RESPONSE state
and discard the token.

Recognize single-block and multi-block write start tokens
when the SD card is ready to receive data, allowing the
write operation to proceed without an additional dummy byte.

Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
---
 hw/sd/ssi-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index a3a9f0c7efd..13c87c49cfb 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -185,6 +185,12 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
             s->mode = SSI_SD_CMD;
             return SSI_DUMMY;
         }
+        /* The next byte after R1 may already be the write start token. */
+        if (sdbus_receive_ready(&s->sdbus) &&
+            (val == SSI_TOKEN_SINGLE || val == SSI_TOKEN_MULTI_WRITE)) {
+            s->mode = SSI_SD_DATA_WRITE;
+            return SSI_DUMMY;
+        }
         if (sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read\n");
             s->mode = SSI_SD_DATA_START;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC707CD6E52
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 15:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTiCV-00021D-5L; Sun, 31 May 2026 11:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samyak.bambole07@gmail.com>)
 id 1wThzh-0007sy-Cn
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:22:31 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <samyak.bambole07@gmail.com>)
 id 1wThzf-0001Gm-7b
 for qemu-devel@nongnu.org; Sun, 31 May 2026 11:22:28 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so95411a91.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780240945; x=1780845745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5t15FBFncCfWhIEHbAPJ4/OENNZt8mgYjYpEmZUPm7U=;
 b=NMc8SvBgxw3BBx2dTE2safwyrXLsoyU8NwDv0Ihb/J0McFogiM+h1iTer5xPjT4A7y
 8HWDzKxR2qpNyWL3iYK65aoMqTYnJsXqjVpeaZE2ijfhXAqqHL+eroYi3uR0aXkCz9lN
 Dxyx0PW3/8Oq7AFfRCzp8yp07vLterf4UHGPv6MX2rc1e2XBVwaSL4Lm+hQrAkI3HeZK
 ivX1ZTurR8J4hI/4N7EQ+4SYcjtOQFDeKqYMg/G/LppOL9TP6U5d4auXeJgnT/Ed9NRV
 6Lb1lGDV7Ad8mYcAVE41dHDHdzzamuVIkWA3riUdtJeP2bkEmyAzpuvbNq1C28dRJ8Lj
 Inpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780240945; x=1780845745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t15FBFncCfWhIEHbAPJ4/OENNZt8mgYjYpEmZUPm7U=;
 b=q7YigkDcJEfO/tkV91uFV1687mR6ak0UWm7j7/HSSOB5bs4yPBstT8rqPudirDxgGX
 PDanRXaQ2u8JFnG2LoM/YFIskkIO0cW23FXIfesQ/ECAnfgy1SnlSu2OMcNyy+kZxDxF
 XSgo+2xldgUP5aFDFKM7sfwZPOYK7LkeXrENiZnigsU6ROyNuhI4x5NcZbhSRpWus9oa
 Nz/RJmuurgYMefe63OAn6v/YYxB3oVzySm36TxHZeNBK9ho1l5cCHrxCLJ3sgwb5Y2T2
 iUcLMZaYAq0DQ0mMwG7KrIg452aJxU4ataUWshEU10bXcFlgtcncogXop285gbTCOcl5
 nmLA==
X-Gm-Message-State: AOJu0YzAt0e5ClCkWb3kAhdvNa4cKHSlFRFAXewWvTowjp9Cj/X64L+3
 7usHQfCgmATeR3SbTxfSFxcrzIGs6EK6KYYSwD9kdHBOp0LwAKjVUpUb82D9ng==
X-Gm-Gg: Acq92OFrzmF8G74+BMMMBhFhrw4r+mIt2XU/3kTcxKWVE8mtc35xx1MIJCf17nyYz7y
 aUP9mAezmVjZ1+//sTbNcJduj0kBxB6ES7ZlpX10gHEh7OfkLgyh/o3KgSN8s5D94XAZczvg3VH
 jIa7v/uCpSUyPzPc+mAVfEjBE+hCJ/13XlhsxFI+k4Z0vdNZzx1Po8F82dx09kt0kocAm7I04Fh
 QDE12sCfz0wxLk8DUWvlIbwe50ngAPFG9U8gE2W9T38nCMndYcfQBWxz97qaYswOOq+pm0sJ+4h
 hONmMnwmJwA39Cc2DjN71VlcAv+n64Nl8/iDYPE6ltWXPagp1eWFO3mkU6E9YNiM0KEcLIxiUh9
 7vFFfzAw+9YVulMW/JJqCjDS/Hekh53mZsAWl5cfI1LN85iy3bTs0pVOh31rpzXD3kp4Ow0k5l3
 jWCqCH86tGhX9d9+jS0FXr6/5Hs7OOMm00fmngNN5XWaJ9YJSHCGUMBzXVV706uUsNKHVQwk8=
X-Received: by 2002:a17:90b:562b:b0:36d:8e49:d8 with SMTP id
 98e67ed59e1d1-36d8e49038cmr3985103a91.15.1780240944984; 
 Sun, 31 May 2026 08:22:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:88b1:bfce:96bb:43ff:fec0:e782])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bbd667fa4sm5603408a91.0.2026.05.31.08.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 08:22:24 -0700 (PDT)
From: Samyak <samyak.bambole07@gmail.com>
To: qemu-devel@nongnu.org
Cc: Samyak <samyak.bambole07@gmail.com>
Subject: [PATCH] hw/misc/applesmc: replace DEVICE_NATIVE_ENDIAN with
 DEVICE_LITTLE_ENDIAN
Date: Sun, 31 May 2026 20:52:10 +0530
Message-ID: <20260531152210.264330-1-samyak.bambole07@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=samyak.bambole07@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 May 2026 11:35:40 -0400
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

Use explicit DEVICE_LITTLE_ENDIAN same as other devices in /hw/i386,
since the Apple SMC is x86 only.

This was flagged by scripts/checkpatch.pl
---
 hw/misc/applesmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245..aae7fad3a2 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -278,7 +278,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
 static const MemoryRegionOps applesmc_data_io_ops = {
     .write = applesmc_io_data_write,
     .read = applesmc_io_data_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -288,7 +288,7 @@ static const MemoryRegionOps applesmc_data_io_ops = {
 static const MemoryRegionOps applesmc_cmd_io_ops = {
     .write = applesmc_io_cmd_write,
     .read = applesmc_io_cmd_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -298,7 +298,7 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
 static const MemoryRegionOps applesmc_err_io_ops = {
     .write = applesmc_io_err_write,
     .read = applesmc_io_err_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
-- 
2.54.0



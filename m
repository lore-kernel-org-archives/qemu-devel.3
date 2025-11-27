Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB6BD116E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcv7-0005gh-KX; Thu, 27 Nov 2025 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv6-0005cd-HX
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:28 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv4-0006mM-U7
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:28 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso808398f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253465; x=1764858265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNwzzkqCK4F2FAFtlDSFvQSqXPAaSXIjj5Frdipo5HY=;
 b=fAl4l71QVstQFCFoXFqWuRPuU9aDkydqNYh7E5brKdDHrEp/frGEmTu3+sYOo7JGR6
 rrbEMa0FtUSBYfwbfwN/+4b0yhor5NFUvVArGJGTB9+iOcEi0/kbflX0DbA7HmVDdo8d
 SXJgGfwaQE+EoPmqC1wJpnvx1fBlFibvrx5mjFn4mZgjBpC+KN+ySU85TLPVdIgRjkTq
 zcvnKJaNu8gH21wwJm92BtVaFl98bXv1GtBk4mSTZXYDNzYdc/97ymIEZlGcMRiCadtV
 Hu7warU/ntSSDqxysQ/L09D36uEwn/vij61a+u/FBTnWbWlmHGRnPzJCt5RpD8Cw0DJi
 7H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253465; x=1764858265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SNwzzkqCK4F2FAFtlDSFvQSqXPAaSXIjj5Frdipo5HY=;
 b=IEVCzQLmgJ+W04YalEC71Ry5swLFYXnGkjP2zA3DUVoQsCIaSHLKMItXjGovxV6tXY
 nRZPJZ45/C16Onk6EDbgT5R2BjPfwGuAunDue/anjsn+o2kJBXgDi7opwaBw36uSJHRa
 ovNqzLhYdmAWJHBzsPcs5JEIQaTGHwHxCxNdjnfaoKkXjgCfGUYF6umV3CsHsNrWlT52
 N7kGwlBFzuJRt7TsdBJx8gqZO1ooQAO9FN8P2t7zKo8Vmg1yryNf0L47d2Ke3Dfs8bXv
 bQlo5HErlrn3eTVHFqEY6df/nQoGxI4nb00b+HQGLN8SYM+5X6YXyRPRjF8nfS9jL3fn
 fd3A==
X-Gm-Message-State: AOJu0Ywkl5f1r8GjqbMDT7Z+E6Z8akaW7j7wPgwvF95rCNwuOpdVJxnZ
 rTmb3BO9ayDTvJrU9lk8uERlv7eIoO7nCkZKYTLuFTT7wEuazdM+w1MfxR8uETb60g==
X-Gm-Gg: ASbGncuFTC2MBFd+LnhiQjzY+h0RTN5i2wSIsD4QlXvUevr8FrN02RaKN8HKFWFX3E4
 7CiQ+XnSRXkxpqufo2HVlscdY4WSOznfcmdl/6aIiSCGJTYSwDR7TL0K7EW17+vgx+MphoXXuu5
 ePHAyZaUzuAEWuRNg4LZro2wwODd061kOza//8oAmlxBnnuFvnRkkj3lWKBcBG3PI3Y08qPNSJe
 ekTma7h3Lxlo6l2lCyH6ddfolDxva3X0tCcttwU81Xo+i71iddayhrmAnmCcYKGZRa/zFLiput2
 JEzBMdNOMzzoiVKs67qPij5MOwGMiavStm7m3KmSWvy47/RU4mYMjOErgawgs7AwWJmuVROfzx2
 XNAFVOVzW3iP6Wa5tKpbr5v0TFcNz/+zzt+KTZbMywTUIU/aq+q1xsF0diqdpFMM1vXTWsRKZ3F
 nBb22qEpRqeN9IKImETkT3u1I=
X-Google-Smtp-Source: AGHT+IEyX2PsGwHiWh9YBXWyh9KnS2XChVqDRbjSqIfXQ4KIiOks0HRvnmeCEj9uVMrTuJxIP3mceA==
X-Received: by 2002:a05:6000:18a8:b0:42b:5521:31ad with SMTP id
 ffacd0b85a97d-42cc1d51b1fmr22958771f8f.49.1764253465437; 
 Thu, 27 Nov 2025 06:24:25 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:25 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 2/5] vvfat: move fat_type check prior to size setup
Date: Thu, 27 Nov 2025 15:24:14 +0100
Message-ID: <20251127142417.710094-3-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x434.google.com
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

This allows to handle the default FAT size in a single place and make the
following part taking care only about size parameters. It will be later
moved away in a specific function.

The selection of floppy size was a bit unusual:
 - fat-type undefined: a FAT 12 2880 Kib disk (default)
 - fat-type=16: a FAT 16 2880 Kib disk
 - fat-type=12: a FAT 12 1440 Kib disk

Now, that fat-type undefined means fat-type=12, it's no longer possible
to make that size distinction. Therefore, it's being changed for the
following:
 - fat-type=12: a FAT 12 1440 Kib disk (default)
 - fat-type=16: a FAT 16 2880 Kib dis

This has been choosen for two reasons: keep fat-type=12 the default and
create a more usual size for it: 1440 Kib.

The possibility to create a FAT 12 2880 KiB floppy will be added back
later, through the fs-size parameter.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index dd0b3689c1..baf04e678b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1188,28 +1188,8 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         memcpy(s->volume_label, "QEMU VVFAT", 10);
     }
 
-    if (floppy) {
-        /* 1.44MB or 2.88MB floppy.  2.88MB can be FAT12 (default) or FAT16. */
-        if (!s->fat_type) {
-            s->fat_type = 12;
-            secs = 36;
-            s->sectors_per_cluster = 2;
-        } else {
-            secs = s->fat_type == 12 ? 18 : 36;
-            s->sectors_per_cluster = 1;
-        }
-        cyls = 80;
-        heads = 2;
-    } else {
-        /* 32MB or 504MB disk*/
-        if (!s->fat_type) {
-            s->fat_type = 16;
-        }
-        cyls = s->fat_type == 12 ? 64 : 1024;
-        heads = 16;
-        secs = 63;
-    }
 
+    /* Verify FAT type  */
     switch (s->fat_type) {
     case 32:
         warn_report("FAT32 has not been tested. You are welcome to do so!");
@@ -1217,12 +1197,33 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     case 16:
     case 12:
         break;
+    case 0:
+        /* Set a default type */
+        if (floppy) {
+            s->fat_type = 12;
+        } else {
+            s->fat_type = 16;
+        }
+        break;
     default:
         error_setg(errp, "Valid FAT types are only 12, 16 and 32");
         ret = -EINVAL;
         goto fail;
     }
 
+
+    if (floppy) {
+        /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
+        secs = s->fat_type == 12 ? 18 : 36;
+        cyls = 80;
+        heads = 2;
+    } else {
+        /* 32MB or 504MB disk*/
+        cyls = s->fat_type == 12 ? 64 : 1024;
+        heads = 16;
+        secs = 63;
+    }
+
     /* Reserver space for MBR */
     if (partitioned) {
         s->offset_to_bootsector = 0x3f;
-- 
2.43.0



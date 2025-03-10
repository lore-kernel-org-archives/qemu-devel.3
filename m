Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5CEC282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 00:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trn1V-0001W8-LQ; Mon, 10 Mar 2025 19:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1trn1S-0001RF-VB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 19:59:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vliaskovitis@suse.com>)
 id 1trn1R-0004Av-9c
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 19:59:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso12221865e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741651138; x=1742255938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uFYgY/6DBovATYZvrnN9pCa9OPwBjHt8YhEOdrXntc0=;
 b=PMVugtwZMwep08C7PXRWgfic8cAX+VY4VQhDFpFV32Rt4Y05lfHWslYx4/LgeXPOyB
 iV7U63UMIl3NXOeSIZ+Ly5Umv8kAGG7RzxnzmQ/IVOwMLEampuPRjtskrf+7JvtBocff
 h9BO5WpoAILaTKNcQUx+wooxPzrFQSuLiZFU4ikrSne+ZJY+8WvAPnYMjeUW7/wZt9qd
 MUPa3qdM1t+5kPS81e4v3v4nly6rbvHdv+XkvX0UtyDXyCSdWDNI8RHzkZTQ4rkxDwjd
 Zu6Oa/TsFlEDQUp0EZZ4f0df1Rv8zrKYyqAyxMyC/zK4KZjklR+HomdJS6fs/N27P3bd
 lndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741651138; x=1742255938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFYgY/6DBovATYZvrnN9pCa9OPwBjHt8YhEOdrXntc0=;
 b=k8+i5lskbi8jjeClPxpFLsotdwpxzmdKD4Mm6L+iaaDxg3t4LnlGVJV8htfb5yPTYr
 zIoXFZyxlVdNiDbh7cklcMBbGq2RUxWgq3HouHDt91iOH8Y2jceBQ1FrLJ62753vD/CI
 E6owSV6az6DRZDYCAxSctbLQS9he7GGtWWWedG54jMRjBd5zpJojSvccmxe5eW7jP8It
 t2dQ/c4lLfA9HfqhSWkQ4kG5WcZfFYYp2dC/WVn9DTqOJVepEykUgvk+tFIJ3GDi4CZD
 K87yALTV2QQldoi6XwYggO9obP2ZISZnZj1OozeZsxN1NesFgwWGOq+FFwPVD7m/XMpT
 UcqQ==
X-Gm-Message-State: AOJu0Ywm3MpjBjOUsszBFMh4QxSILZ+FsQvjd9oBDaZzRZECrg/aTJcv
 mpl8u0eczKYK/YCJKQ0d2KNY1+6Up+oIXvpmgW82YV9G05TTmA8Rw9lt7TtPyeL8vEeI7p/+aue
 21BdBNg==
X-Gm-Gg: ASbGnctJOcSNV5/P7dBcQ7Iy3V6tK7kBnfLw0bW+5FqAD195WWHWMFYAyuXCtLrBqaU
 4BknGbjqGKs2/okF+VUw1WYyfaabg56JRvSSnoStKasIvCtWkIEewBSQiJ5hVz0SBxUpjyQeeY+
 DdjmnwaoGxgzs4+IZGAr0Au+/CTMDJuGa10GYJ3yhbRmGMx/CyfpTiWoyhYgD5tCLyknZCOy30X
 p2mnUSFDDK8DUfthFolQk1SrYi4sCgjWC9m2R5FjTiWhdgscTrt6vFhToNt0K6Xa0iqKvG/fL5M
 VvxsbSpvdMeMcuvy2SMso1xkZvV+4h+1hpyCHIiZ2xii+bKcnQmV5BD7IQsoL6wjsWOukZ6yKMP
 IoTjYEeQuCA==
X-Google-Smtp-Source: AGHT+IGgYFAY+qbMFvHDzBtSeArLQmcF/eYMPN0szSGA/Y0tJ+Gg89EZ7R706WDL3wWPLqB/L7bNXw==
X-Received: by 2002:a05:6000:2ce:b0:391:39bd:a361 with SMTP id
 ffacd0b85a97d-39139bda97cmr10550317f8f.18.1741651138429; 
 Mon, 10 Mar 2025 16:58:58 -0700 (PDT)
Received: from localhost (ppp-2-87-115-176.home.otenet.gr. [2.87.115.176])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3912c1030cfsm16710575f8f.90.2025.03.10.16.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 16:58:57 -0700 (PDT)
From: Vasilis Liaskovitis <vliaskovitis@suse.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com,
 Vasilis Liaskovitis <vliaskovitis@suse.com>
Subject: [RFC PATCH] vfio/pci-quirks: Exclude non-ioport BAR from ATI quirk
Date: Tue, 11 Mar 2025 00:58:33 +0100
Message-ID: <20250310235833.41026-1-vliaskovitis@suse.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=vliaskovitis@suse.com; helo=mail-wm1-x341.google.com
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

The ATI BAR4 quirk is targeting an ioport BAR. Older devices may
have a BAR4 which is not an ioport, causing a segfault here. Test
the BAR type to skip these devices.

Similar to
"8f419c5b: vfio/pci-quirks: Exclude non-ioport BAR from NVIDIA quirk"

Untested, as I don't have the card to test.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2856
Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 hw/vfio/pci-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c53591fe2b..15598bbaf4 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -403,7 +403,7 @@ static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     /* This windows doesn't seem to be used except by legacy VGA code */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_ATI, PCI_ANY_ID) ||
-        !vdev->vga || nr != 4) {
+        !vdev->vga || nr != 4 || !vdev->bars[4].ioport) {
         return;
     }
 
-- 
2.46.0



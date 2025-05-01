Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3EDC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb6U-0001Ke-V4; Thu, 01 May 2025 17:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6T-0001KH-Qw
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:57 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb6R-0006am-LP
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:57 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d9189e9a06so5153255ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133554; x=1746738354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1tUkE2fqrTbr3cXQ8k1xcGcvFxNEjegGfUTV61cZkA=;
 b=EbXFJ30A946jsPQLWn2SXFovj1q8wmST0y8Ek3Q7sGPSD43hiO+wAXDb3jajsbpLE7
 Qhzmt7AsDqZaR0y4iK2zHr4PdfaGt2h3Ha7QnA/LLpqCbenXLYqC/9RGR2j7FMWbrnx0
 GjgyjH5uIYXIVSEJUZ2uvdppdCaXnWV55VrFCL1Jm6fcwZYyDfEHwwOCXblG9F4tWGN/
 sjZANgV0tfT4oEKymupqxNGVPSWxe76yYxdqvPZpCok4NfJmYt36slkWe4IfsL0yvcZq
 YeqvsBuiqk+DXVFd4PM2U74vTcqddMWVAqGqg2MKGzERI2jFytJ4ev5uoxOEULuv7a5D
 feJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133554; x=1746738354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1tUkE2fqrTbr3cXQ8k1xcGcvFxNEjegGfUTV61cZkA=;
 b=HVEO4JcwznmkNHp/da5pM5Fl8DnrPAi/BrZK1myyDLVYLsRz6uN76M4TVCQ/gQNOdX
 1adhDkVoYJY49IrlXjGrT6r2F/Yb6aR4+2ZI+GbyS+7e12peJDyNg4xXgfNe/qifS0lf
 JpEmO97KHxlSq67eXHVE1xGDiLQ9oRTbeW9IUh0bHqB5Q8fYGZEfJnysy34bI+XOsfQS
 PJ2X1NsQlUnRQJXWIHq+7J0YsFWlVICm9nxZNaq3sw7y+i9sXL+Qr/8GjZLKRR+2lUaI
 KUIT4lVLWVRGPei3IBA1Ndk14vz0qAYbRfVtZwZ8x+4VLdC7nWlQJOLqGM8KJEh7O+iV
 QONw==
X-Gm-Message-State: AOJu0YxNBF99eBpDmHsQPBf33z8G8dZe+NT462rZstQyLBaROArcjNhA
 807AY6XxV4KIIP20sI+jZxyCLp2gFRtN3v666iePIibaAk4eYb4uqs3cUwQNLPmMA3f8DABJzXm
 u
X-Gm-Gg: ASbGncuaa6cakNFUoYEyoTNHSEbKdVZmSrh3SwojL/N+rHiCdn+1xZi7L1t+4LZXc9J
 sMmZFOPcpruRTqDQHheaOUg8WreRzInQQPrXZT41rVnFfpgH05EH3gwPz9L+7baiiX5Z4VZ3YGD
 nS86abW4X+N10MC9AjShFZOyKqEp9Gh6Z479kOkT5NFle0V+tV28W8kh/rvEqg6kXt6JNcSE7fM
 zxzQTchGad2k1pyWPfhC8PUIYk6/SsS5mJF/hIR1PCHAAOHbe4BPesvW+lWHEDsZOPW/HfdXEJ3
 g+5z6zZRfwyyg6vBYKI+8+ru0qQHqiuRmNkh3H7V+85118fKQkOZd7U1MZCx76nESaMXj0SKXzC
 W8s8JKpvjN2PN3Zc=
X-Google-Smtp-Source: AGHT+IEhN0gfiRGdQtK4gvD1FbBGyd1n3rEGkOmMELlyKFKYHHRG9NX+sRBTEqV5mMGJFOpbGJ+6uA==
X-Received: by 2002:a05:6e02:1a8f:b0:3d8:1ed0:e167 with SMTP id
 e9e14a558f8ab-3d97c239b27mr4578815ab.14.1746133554154; 
 Thu, 01 May 2025 14:05:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975f58be3sm3253625ab.58.2025.05.01.14.05.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 06/18] hw/block/pflash: Remove
 PFlashCFI01::old_multiple_chip_handling field
Date: Thu,  1 May 2025 23:04:44 +0200
Message-ID: <20250501210456.89071-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12d.google.com
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

The PFlashCFI01::old_multiple_chip_handling boolean was only set
in the hw_compat_2_8[] array, via the 'old-multiple-chip-handling=on'
property. We removed all machines using that array, lets remove that
property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/block/pflash_cfi01.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 168101d8dfe..bba099a0c9e 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -84,7 +84,6 @@ struct PFlashCFI01 {
     char *name;
     void *storage;
     VMChangeStateEntry *vmstate;
-    bool old_multiple_chip_handling;
 
     /* block update buffer */
     unsigned char *blk_bytes;
@@ -703,13 +702,8 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 *pfl)
      * in the cfi_table[].
      */
     num_devices = pfl->device_width ? (pfl->bank_width / pfl->device_width) : 1;
-    if (pfl->old_multiple_chip_handling) {
-        blocks_per_device = pfl->nb_blocs / num_devices;
-        sector_len_per_device = pfl->sector_len;
-    } else {
-        blocks_per_device = pfl->nb_blocs;
-        sector_len_per_device = pfl->sector_len / num_devices;
-    }
+    blocks_per_device = pfl->nb_blocs;
+    sector_len_per_device = pfl->sector_len / num_devices;
     device_len = sector_len_per_device * blocks_per_device;
 
     /* Hardcoded CFI table */
@@ -765,7 +759,7 @@ static void pflash_cfi01_fill_cfi_table(PFlashCFI01 *pfl)
         pfl->cfi_table[0x2A] = 0x0B;
     }
     pfl->writeblock_size = 1 << pfl->cfi_table[0x2A];
-    if (!pfl->old_multiple_chip_handling && num_devices > 1) {
+    if (num_devices > 1) {
         pfl->writeblock_size *= num_devices;
     }
 
@@ -930,8 +924,6 @@ static const Property pflash_cfi01_properties[] = {
     DEFINE_PROP_UINT16("id2", PFlashCFI01, ident2, 0),
     DEFINE_PROP_UINT16("id3", PFlashCFI01, ident3, 0),
     DEFINE_PROP_STRING("name", PFlashCFI01, name),
-    DEFINE_PROP_BOOL("old-multiple-chip-handling", PFlashCFI01,
-                     old_multiple_chip_handling, false),
 };
 
 static void pflash_cfi01_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1



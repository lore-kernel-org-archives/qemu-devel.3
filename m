Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8FBCC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGilG-0008BA-Bl; Tue, 13 Oct 2026 16:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGiku-00080C-1o
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:48 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGikr-0003NW-Tc
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 16:05:47 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so408536eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791921944; x=1792526744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jAQKw6BdaosTvJkg4nCxTm2cQbTjw31PxJAtciPfv0=;
 b=X1QptIXnfY0+oPKdnRQH6POjn69jERNt6g1m4Wne/bHouS7ZlBVy+/ZXjdDCcs7mlP
 WLGJz0KfrRPJruzJYsY6JJkhaEJy16WZSOxlkPhH/lkNljY56kcZYMXtVXz2ugVtqSkr
 TRdXjP70HLS9MpUtOYWHZ/WP6tYaLC9/JY2q/7paLDRxrid3Gl6z8yFE02fGKPIWibHr
 aDnONirM4sJ/d+yF62nnXCTCwVzFZuqPj8dH9z5VxiXe8QaPYPeDcakFUZmcjYI3C5yl
 gl4UqBuC5jzGwtnHrhoq5fvyMmIV/uiKMRc5QqB1m8hYsfrMUzpiHr6/92j2iIQ26SkS
 qLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791921944; x=1792526744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1jAQKw6BdaosTvJkg4nCxTm2cQbTjw31PxJAtciPfv0=;
 b=FQ/AmfFy/9/Qhl2Ohxf/tAc3vI4/uwhr6vW2+oAdcthqfSRI5BLxTgPytShRa0+HRC
 yicg5u4kFBAleW5G1OaY2nAKV2krDY89p+Y8ssUHnnDKg9ctPF+Eut2CHnm7ga55U/WS
 s07V97+MdVWylq9++xJhBAgzFr446kcpbiK/VkRe8d57p/2sUffRiuniTJDTO54nr7P7
 yuVre7TKGUdgeIaPEqEdZXx6Yvm5aQ7OrHGn0PM0vMfM1fMbjMSNeMB7vOE2rfhaDI64
 Qxrc8t8BXwHT2n+lyVTQ+o0JfnH9mBpT6CroYTyZLsh0tXdmqCjlUDvLsc50GmgsTc4X
 0zqA==
X-Gm-Message-State: AFq9FYK3xFCjan4VHJyx9I+CZdEO5jOot1OiFEr1widR7DVCOVhljS4A
 mo9Htf1j/8j6Q5vA2ISTWMPooJkVe+qsZS2xebaEpfI01VDpR3yW0ewG8GgqRVrI
X-Gm-Gg: AYBFou33/KHcUrcN9m940u8uaBRswYKTHzoeeTU/uSF+fjnmq2ZvXqJDUjU1ExXia00
 /rujFD3puZiwdwpN/enBgY3gIiFqO8s77CFQX8pGlPwK0ZXZadU6fnB8+sSm9836tac0BlqdzBI
 U+0dSpqxNeFrwVbkGXvEMBR/LmyOJVYbdLGFN1P+zVPKN0SJGtfMXhEaJ+kvAQPfPvOlZgTgr4m
 fDJDALD+5pe5KfmO7+lscr0snywsYWPer+MWWGH/WUsQg9OOwxPPgiPPm9iPVzzyGFCAWVsqL/M
 ON4mBGaxqobJXeV1FGTJudjxng/ZOp/Q1F0ukGs9R0EqXFL3znrAoIk+ci/PbPCvVnDhfemb3+f
 A8dfSde2cm0ok3i9qzqU0QbPXBgaOkD+irBwk5x/kSZPJD7ksM5aGsfmw+IiktPWoYEqecdohet
 3yB63IeTKO/les3mutT9vz4Lo8uCMjm+P7x8C0BL8UnXRhC7C80Zg5KTXiudaFS/l4X13mgXA+u
 JRFelqoHefC9JoQhA==
X-Received: by 2002:a05:7301:70b:b0:356:23dd:3c72 with SMTP id
 5a478bee46e88-35623dd574fmr15264117eec.4.1791921944220; 
 Tue, 13 Oct 2026 13:05:44 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-35b29c2f861sm25568233eec.11.2026.10.13.13.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:05:43 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 3/3] hw/virtio/virtio-mem: Avoid call to target_info() in
 class_init
Date: Wed, 14 Oct 2026 04:05:24 +0800
Message-ID: <20261013200525.1340-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261013200525.1340-1-luoyonggang@gmail.com>
References: <20261013200525.1340-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Done by merge virtio_mem_legacy_guests_properties into virtio_mem_properties.
As we already have vmem->unplugged_inaccessible handle in virtio_mem_device_realize
So we can reject the wrong option in virtio_mem_device_realize, then the call
target_info() in class_init no need anymore.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-mem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9..e528bf2a88b 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -879,7 +879,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
             break;
         }
     } else {
-        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
+                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            return;
+        }
     }
 
     if (vmem->dynamic_memslots &&
@@ -1568,9 +1572,6 @@ static const Property virtio_mem_properties[] = {
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
-};
-
-static const Property virtio_mem_legacy_guests_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
                             unplugged_inaccessible, ON_OFF_AUTO_ON),
 };
@@ -1635,9 +1636,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
-    if (virtio_mem_has_legacy_guests()) {
-        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
-    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.55.0.windows.3



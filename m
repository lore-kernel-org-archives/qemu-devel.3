Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1546ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvNV-0005Eb-6c; Wed, 14 Oct 2026 05:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNL-00056V-Kq
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:20 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNI-0000bz-C4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:18 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso3177775eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970455; x=1792575255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n1Kznjn9gwc9J8CJXnPKY6p2oc96M5De/Smwcsx+f98=;
 b=E/Y48btEzOWxnsumy9XUq/joLWl0arMqLyG1YcRZA8OLIlWchtu6ns4B5Q0PrFcCLM
 CM5eIC8qcZWxyviYH4q3b0l0R9eNQdSBBxJWuEaHBay2F3NQGGPBVMR5OnkEiVQqlmDI
 92jRPT3c5NZss4B1IFPrqSGq40QRD8RxGitGYYOevTCp6ooZ0nKK0d39CHMPxmwu3swn
 dj+piktJXyDTzquFf695PkT2EHkR9c9Cq6VUi1UfLlCMmQnId+4E6IVwMYWv4R+mGPmf
 hNvTDtSr8vN2IuPV/fJZjTfyx40u54OXp/tHsWjGA22OZ0+Mo7y+8QNPxaAS6NmhooIM
 t2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970455; x=1792575255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n1Kznjn9gwc9J8CJXnPKY6p2oc96M5De/Smwcsx+f98=;
 b=JrU9tdFVn4Xz9pxcw0gLObaikmfMLqU8Yqzeo1AB61JsStt1NmYuT+VNHGloETOpYs
 +3EiWVRk1/4Q11lksExANOX6DtmOUy8SVCFB0f0OsKOlL/eIwu9GFUcYHmO5fgp7tCZW
 ZTMMBKacPnHmOj5J2L9Fm6iXiNBJO3m6noJM5mecS/fJ7l11YFBG+rjBEEJpMh91khgk
 GFJrP1ra9VvlvgAXIS7ThrpKloZ/cUJsC3x+yFQLWmaSuaxqNbV12P8d9LMXYAghAtUS
 vqqaMQ5+3oa1W9tFLp9TmmAjWQesv//ATwK3SakpW3VHkSikPn50scglbf7ATGdVnkQU
 cv7Q==
X-Gm-Message-State: AFq9FYIEkqa7+sokTUBx/Ash2x3niKph5zj2GKEtmDLpIibN5Fp3v0w5
 QpFXykSM72l3pMbQrxfVtqz1oHMDv1fUjWHfLfjnVVqA+sIGRzhyVbBkLSYVQgANE/s=
X-Gm-Gg: AYBFou1/DPK7ORCiUBL4ynzKreb6qMEp/KUJFH4APkRWejiJ1b48OE8py5DcEf6WOl3
 5dsfLNetLK9K1XRON1PFqZi77jovtmpT5w1EyGHxnnBCKjGDABQkkx9/88JyDTqi26adjNNvWS7
 vnWJXMX/m0ppzKSnTCW13gfVSPZwPyD3Qxr9sWktpG5EYMvv2qtc5bUwIdKBwrz6Xkn1t1meooo
 /Pi4XT10A4Y+p4STgjoaOldcBajUQpv9xxdMQ9KI708j1XxWxY+vOTncZEKEWTQCHy86dLEu247
 FZfEkShB+wYOOrTMoPHgMf7ibw/hmghrQMhVW4862DuH/LC6l66lGP1el+RV3XJjnO8l/abLKPY
 DR/V0l+mWx1sDjxCRQKd3fJ1eSmfeO0TNSngqgPrD50uXsF7FobsZo8ldaboE6x6DyzvZzgme0t
 SPfMC02Sdy44xmyYbbiKqEMPv9lPalSGhcEl7Hxmjk0CYnsbsofKVmUh7BKBgFycyliLGZfL9Y4
 OoWko7fVCf/+6X6eQ==
X-Received: by 2002:a05:701b:450b:10b0:164:3237:4483 with SMTP id
 a92af1059eb24-16a6384f137mr18786492c88.42.1791970454472; 
 Wed, 14 Oct 2026 02:34:14 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:34:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 13/34] hw/microblaze: defer PetaLogix endianness default until
 init
Date: Wed, 14 Oct 2026 17:31:23 +0800
Message-ID: <20261014093152.834-14-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1334.google.com
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

This is for avoid call target_info() in class_init

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..43140ad7bda 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -83,7 +83,13 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = psms->endianness;
+    EndianMode endianness;
+
+    if (psms->endianness == ENDIAN_MODE_UNSPECIFIED) {
+        psms->endianness = target_big_endian() ? ENDIAN_MODE_BIG :
+                                           ENDIAN_MODE_LITTLE;
+    }
+    endianness = psms->endianness;
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
@@ -178,8 +184,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                           &EndianMode_lookup,
                                           machine_get_endianness,
                                           machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
+    object_property_set_default_str(prop, "unspecified");
     object_class_property_set_description(oc, "endianness",
             "Defines whether the machine runs in big or little endian mode");
 }
-- 
2.55.0.windows.3



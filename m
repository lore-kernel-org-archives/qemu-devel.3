Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E050CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UEg-0008If-HP; Sun, 05 Oct 2025 15:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEc-00085b-D8
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEa-0006UZ-MR
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kypaSeEg6IWRZMT772IZeY7cqyb72xxszsPDOfdio+s=;
 b=Xjr1BmnbufVf0FZDOS14ZOavhloBMQiwvKLe7dNJfZXIAcgEHTR/L2o45F0GYdSZ+D+p/h
 tOvgbAk8psePP2dlZKLcdk5OuTWo3IdEIoDwkbLo9xvyY7CK0mPJcH9YMLE4gGoooXhvwn
 /X5bX0U4xw6zpbkUL80UMXWnvPe+4so=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-HjKD3vp-Mea0lX9SMdtltw-1; Sun, 05 Oct 2025 15:17:17 -0400
X-MC-Unique: HjKD3vp-Mea0lX9SMdtltw-1
X-Mimecast-MFC-AGG-ID: HjKD3vp-Mea0lX9SMdtltw_1759691836
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so2979812f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691836; x=1760296636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kypaSeEg6IWRZMT772IZeY7cqyb72xxszsPDOfdio+s=;
 b=W8zKVtw8szdBSzFMW4+EHy51TlRukkEq7qaeS4roKHmuEBQndjsysoT6GQH4wx7QTX
 9G8Tw1ymJiVDAkik7McgszIXPBwc+8drTjGxWa+lIX2/yYKCq3XQL4evc/EWckLWyV67
 rpK6FAQX4iphgBDFQCYQmw4L3aGIeK6MvVV/10tFf+53xgvvv2G8zsx4rS1j3+NZQSEh
 b64rBeY5lN9aM6dh6wDi6fNeU774grQ7HjRHL/nyNsBz05TA/9ko33rG36T1UsohaGPv
 Rur4KAYfzD0V0j3eI5ZSjX8eu3t0jyOWUVgub+gVPp3EfrG35HTPw2A4na07kkzPYpoa
 JeTw==
X-Gm-Message-State: AOJu0Yyf3An7fBaDo5Kf6xBJ5m4nkZqHl0vsSqQQDdUm/jW+C67wxnMG
 enrt1Ws3/yui9yKVBJi31lpbqmMB5RxAAMeFA2vw7qm+8ZGtkokWgP5F/ld3RLXpazjzbLPQS3J
 jR8U/oJ4Dv+EU9bK/011/NWtY7OmqiQV7pzgst0lRlwr82NqHha3RBvzBMXv2gczkFKfWIRyOVn
 YXL6/ZJ1fnLLR9uAn61lX0C4vTPFhjAsP1CQ==
X-Gm-Gg: ASbGncvsOJIMTZBarn8PgSSLB+ei2upPrAMdgOpWn3pVYB/ERzCZI1czJVPt3xhkD6O
 RxAiqNFIBx8V/+yDi6nEIDIAnWRPE3RiMHAMd/RWmkwPitGiA0UvU0EoPIoQnSvbce6Qds2HWmJ
 FNZCK9oYrpXdCPdJmilhUTi1qLsWA9qZ/TYUDhS8G7gZGrDLlrxpe4j5WFgxQutdzDTbLDSH8H8
 8jlHWcWrNUJi6EHgygPf3auf6ty2z4EWF9m7smj1+UHetreO8UDPB27M1jLBEyrTnHNJT7DLBgm
 /LOYImMqjS/mVjJL+dTgRR78kqIgoFaY6VxARXs=
X-Received: by 2002:a05:6000:3103:b0:401:c55d:2d20 with SMTP id
 ffacd0b85a97d-4255d2d12dfmr8775395f8f.26.1759691835891; 
 Sun, 05 Oct 2025 12:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa92RQmwa2ZNgL6xwPfs9sDM/3ON4IoKpumFUnz1MER50CLKuOv+FYc5D0XIWu3DJKe97WFg==
X-Received: by 2002:a05:6000:3103:b0:401:c55d:2d20 with SMTP id
 ffacd0b85a97d-4255d2d12dfmr8775380f8f.26.1759691835298; 
 Sun, 05 Oct 2025 12:17:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm217431125e9.7.2025.10.05.12.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:14 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 32/75] hw/smbios: allow clearing the VM bit in SMBIOS table 0
Message-ID: <d285591d29e28abe2841ecec9a82f57fc773719f.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

This is useful to be able to freeze a specific version of SeaBIOS to
prevent guest visible changes between BIOS updates. This is currently
not possible since the extension byte 2 provided by SeaBIOS does not
set the VM bit, whereas QEMU sets it unconditionally.

Allowing to clear it also seems useful if we want to hide the fact that
the guest system is running inside a virtual machine.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250724195409.43499-1-d-tatianin@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/firmware/smbios.h |  2 +-
 hw/smbios/smbios.c           | 11 ++++++++++-
 qemu-options.hx              |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..3ea732f4e6 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -22,7 +22,7 @@ extern GArray *usr_blobs_sizes;
 
 typedef struct {
     const char *vendor, *version, *date;
-    bool have_major_minor, uefi;
+    bool have_major_minor, uefi, vm;
     uint8_t major, minor;
 } smbios_type0_t;
 extern smbios_type0_t smbios_type0;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 1ac063cfb4..13e21a9c43 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -179,6 +179,10 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
         .name = "uefi",
         .type = QEMU_OPT_BOOL,
         .help = "uefi support",
+    },{
+        .name = "vm",
+        .type = QEMU_OPT_BOOL,
+        .help = "virtual machine",
     },
     { /* end of list */ }
 };
@@ -574,10 +578,14 @@ static void smbios_build_type_0_table(void)
 
     t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
     t->bios_characteristics_extension_bytes[0] = 0;
-    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
+
+    t->bios_characteristics_extension_bytes[1] = 0x04; /* TCD/SVVP */
     if (smbios_type0.uefi) {
         t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
     }
+    if (smbios_type0.vm) {
+        t->bios_characteristics_extension_bytes[1] |= 0x10; /* |= VM */
+    }
 
     if (smbios_type0.have_major_minor) {
         t->system_bios_major_release = smbios_type0.major;
@@ -1405,6 +1413,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&smbios_type0.version, opts, "version");
             save_opt(&smbios_type0.date, opts, "date");
             smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
+            smbios_type0.vm = qemu_opt_get_bool(opts, "vm", true);
 
             val = qemu_opt_get(opts, "release");
             if (val) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3..3ff10ec09d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2700,7 +2700,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "-smbios file=binary\n"
     "                load SMBIOS entry from binary file\n"
     "-smbios type=0[,vendor=str][,version=str][,date=str][,release=%d.%d]\n"
-    "              [,uefi=on|off]\n"
+    "              [,uefi=on|off][,vm=on|off]\n"
     "                specify SMBIOS type 0 fields\n"
     "-smbios type=1[,manufacturer=str][,product=str][,version=str][,serial=str]\n"
     "              [,uuid=uuid][,sku=str][,family=str]\n"
-- 
MST



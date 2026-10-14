Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFEFCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvWJ-00033T-Eh; Wed, 14 Oct 2026 05:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvWE-00031g-BR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:32 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvWC-0001r4-HK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:30 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-14394530ec6so2728642c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971006; x=1792575806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JHiFu4U4liJmndh7L3NobmTnl8BgwDY4UjBKZJ48w48=;
 b=hSs5pdIzfv4uxMZDPTC7ofbbVuq4NfraaXHdb8q91Z2i4xLs7DBugNZ+F2nTbZWmJE
 PU7vkRB91n5hR6vpak62YlJ+6x99YwR9HKYVtVpabiB4UBCjjp9ghkt6S9pchAaXkpXX
 qrImzcjVpoNg2/ONGFM8aBaMKlsKVBk6lrE2qrIMd7lRiEMRzpaIlQJQWlnyA26N2gal
 NPMaBd2tytmlrA/Cpe2hi30FmVhLTKe+HePR6xTyn57sfthfh5DJb0dfpYDxRFGIVnPV
 4aL7N3d8DZaTQp7A2jubuGt8pUyGg6rTnD23imZWdKS5FmCoRTmFvtSogj+2IjxZzMS3
 VXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971006; x=1792575806;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHiFu4U4liJmndh7L3NobmTnl8BgwDY4UjBKZJ48w48=;
 b=jCl5UtS0xCvJZyTU8v5LuEe0CwTt3FfOnoOzcfx1kWzpfUEOZx9hNac+nO8e/VQaEL
 lZsePxZ3hp9WsMXGvVVwf1NwJ9YrakzLGLzjsw3FkGOvzKGaUXBy7rphZoisvwRq1wkT
 dAL9y/3Ml2bPkkc7HJN3x6BJIvbCsz3Hc6sthXM+EYSyBmN++opBEAzYcWxUHDl+6O8S
 qyM4hwJtm3hRiteuUuL4B50yJrS8A+lm2ikA1Cer//wlyEov2Ab8tvTEYIZ8TdVwDVRv
 6Dxb+Vx0RpYsnPMTuoRlnEpyLU7hLn9D0n69C97axlohD9+pnI3pJsJW64ZO06NrimcU
 yM3w==
X-Gm-Message-State: AFq9FYJo+gldeUIp+hskRDMyhCfVLP3s1vhYwj2gOa0ElYTv/mN/Xn88
 2R7n07iySTHBuAZiOLnD9HYx1bCHKkvMst2zD3vX9luFcV+XwhEMFxsXYuRDvviNvdc=
X-Gm-Gg: AYBFou1hNSx2HnxwDwqrCREG5agXLSADzcUkIvpUor4eayHCTPGhrKpf6943PnF1jMh
 3LLHJ+5vogNBNbXxLLVCiX84ueJRsesG9MusxVmxo1zT1lZSKHfdRABaARSSfOvlr+y75/BX2yf
 rMuhd0Zk/sF90fAJMai2pwQqCXp8tzkOGW6e3H0gxTgp4O0iWbK/AIr6REvDJfePZgEM1QCnJaY
 cOok1OK6iIpzNneHA7WgLZBcmR9gCJmHKPnuk3rDJZcVjk9NXE9oGGZWMCYPAtZ0yGDcWD+DZjp
 Yjjcz3S1pyy0qkmDbHVZxHKYIn89q+2iiVDu23l+aTbvT+rAbHc+WXGqEhm+IWKAh+bhvv0bjPs
 gllsmVs9tlKOqXFNOITkJfLdi2l2hp2cH0F1r8JUz5ToQuaYGv3aMyWELrMbr3xVDVCfDsv+XsT
 vJddUa187gCqlOXPWYTAIYVMfm8OaeLiAiwCHlvsOawdQFgUSmkRE/lD3345OIguOt6vYWyHImY
 YNCK8+Ilx9HPFlFWg==
X-Received: by 2002:a05:701b:231b:b0:165:55e2:2d69 with SMTP id
 a92af1059eb24-16a640fcc35mr22716376c88.46.1791971006099; 
 Wed, 14 Oct 2026 02:43:26 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:43:25 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 21/34] hw/or1k/virt: use unique QOM name
Date: Wed, 14 Oct 2026 17:41:36 +0800
Message-ID: <20261014094224.1976-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("or1k-virt") so OpenRISC
virt no longer collides with other virt-machine types in one process.
Keep the -M / help / migration name as virt via
machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/or1k/virt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index a3ff903839b..ec20045a3d0 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -34,7 +34,9 @@
 #define VIRT_CPUS_MAX 4
 #define VIRT_CLK_MHZ 20000000
 
-#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_VIRT_MACHINE \
+    (target_combined_binary() ? MACHINE_TYPE_NAME("or1k-virt") : \
+                                MACHINE_TYPE_NAME("virt"))
 #define VIRT_MACHINE(obj) \
     OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)
 
@@ -548,22 +550,22 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "or1k virtual machine";
+    machine_class_set_name(mc, "virt");
     mc->init = openrisc_virt_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
 }
 
-static const TypeInfo or1ksim_machine_typeinfo = {
-    .name       = TYPE_VIRT_MACHINE,
-    .parent     = TYPE_MACHINE,
-    .class_init = openrisc_virt_machine_init,
-    .instance_size = sizeof(OR1KVirtState),
-    .is_available = target_or1k,
-};
-
 static void or1ksim_machine_init_register_types(void)
 {
+    const TypeInfo or1ksim_machine_typeinfo = {
+        .name = TYPE_VIRT_MACHINE,
+        .parent = TYPE_MACHINE,
+        .class_init = openrisc_virt_machine_init,
+        .instance_size = sizeof(OR1KVirtState),
+        .is_available = target_or1k,
+    };
     type_register_static(&or1ksim_machine_typeinfo);
 }
 
-- 
2.55.0.windows.3



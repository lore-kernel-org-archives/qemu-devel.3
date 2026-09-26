Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D1C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 08:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xANZz-00085m-1V; Sat, 26 Sep 2026 04:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANZw-000853-Mu
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:16 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xANZt-0006nN-S5
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 04:16:16 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3429bca3880so956999eec.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790410572; x=1791015372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2gVclOB8hui0Zzz9xz3lHkA1krFP7WoPwFwVaOSKavs=;
 b=LR576KRK7Lj/KSvjqObbPr5x5AIkVoFCR3wesNBYR1bg0tnqIrDvhwyY/dSyx11itG
 sjuiq8JcZkooUyk5pxwg7dkx3dorwrr1VlG/3AUixpTEUqj+XjssTBEkiTBWUdXIMc5u
 FxYP1z6xqIqZaIbYEwdN8cQK3BYmHtgJiRFOekQEIEo+lgAlUWfTXYMaWhZKNxTwFEZr
 w4QZDGmAVF1QCKfyucQ/onMMipgUrTvxPXhBg76RKOPcRhGTOTq4XZjJyxiP/rQbvt/g
 5FelccWU4uXbB21MVQsEtM9mu2wZv+mq+YquqIfef1m0hfEX0musXQqQgb8E1zV683/v
 xPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790410572; x=1791015372;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2gVclOB8hui0Zzz9xz3lHkA1krFP7WoPwFwVaOSKavs=;
 b=0fNm5gwY+6GmQvYFd4T8aa9v2znv4lA6lpSBjf+4x7dBpvlDJeulnpRhB5tv8n81j0
 P/ZmDKHFL7kGE8y/+OWW71dQbFlqb6r7FxGsZv5ehj3an4ZBYZnbL1knN+ksZOntTTgy
 eUoBKofpYNDtvyd5zr8gmujjiDOb6IjAP0FkQKvwWfTWj5JcMOHeKqX10qV2gJpmRGch
 NMC+bKyEVRyCndTxyPG76MyMq5VcSQoe/SEONO0r7JDeiFLBCsYf7NomI7r1pXMGmHFA
 +xa+HsCwla2Xd2qrty6CzzbYEcBDmdhPOlZMmFjV4cVcvU6KY00WJwJ7i4wu5+Z5zJ4F
 rrEg==
X-Gm-Message-State: AFuF++kNjVf6ltnAJluPADI6qeFlnkyM83ltTYtVgORaSKqE+pvH6CVK
 cubQj2UJC7icoIVtaPbWgaSGOD7sIXh6Z8hA5FvQgzYxWYmh7g/8EPcxlv0SmvPL
X-Gm-Gg: AYBFou2bHirAhnB5BLzZcQ2DCQwlPoFXkX7mSgLyXZ5ES7PxoieVI5pMo5hoJnV9YZt
 DaQotF/FWno+qjsLjtUFpxMSspdlAkpn0MLx0ZHpXKnjUkFoT5VYtBBhRRa+IUZS06kRhfQTHgI
 X3p8Y3U6t2T3M16mtenBiv2/N9aLFfXbz5TWPBhpnwK0EKO67R7mfhjQvgCwJIWeD/gxTSLIYcf
 gAw93eV4NGMZ4fkFHlVM81KAnxBnlbyUlcrCeTSTbEwAIW1/JywoXvm1JVkKH8QXtrbeySdfdfR
 YKy6Di1SLEhJx5dHoLx8uJv1XtaJ6nq5yd/XY8IfW8LBNvuvsPqtaWqo6nngC5gpr1097Ctf/Wn
 HCX3cmmJi2m7L4npYC+hv04t8ZgUwyC8L+/HPb5ZRT/RQV8bEBxxYy00eWOSjJsYnob5K0/TSxM
 SkOhAH/lN8kLmAO74JZ7EnMiUYzENTrsGgH9zMVwBUuJk+wmdT40E12Y0QJIIwrWfVHe/Un6Zvg
 oWYAmHmNSugCLKojoMGwTt4Pal2/Og=
X-Received: by 2002:a05:7301:4d0b:b0:331:89d6:80e7 with SMTP id
 5a478bee46e88-342703c0860mr2555838eec.13.1790410572385; 
 Sat, 26 Sep 2026 01:16:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34144f4eb9esm11970568eec.19.2026.09.26.01.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 01:16:11 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Laurent Vivier <laurent@vivier.eu>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 02/10] hw/riscv/virt: use unique QOM name
Date: Sat, 26 Sep 2026 16:15:42 +0800
Message-ID: <20260926081551.29-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926081551.29-1-luoyonggang@gmail.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use TYPE_RISCV_VIRT_MACHINE so the RISC-V virt QOM type does not
collide with ARM virt in a combined qemu-system binary. Keep the
-M / help / migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/riscv/virt.c         | 3 ++-
 include/hw/riscv/virt.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..b29182cb39b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1134,6 +1134,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->desc = "RISC-V VirtIO board";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
@@ -1197,7 +1198,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo virt_machine_typeinfo = {
-    .name       = MACHINE_TYPE_NAME("virt"),
+    .name       = TYPE_RISCV_VIRT_MACHINE,
     .parent     = TYPE_MACHINE,
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..969aa5866ee 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -30,7 +30,7 @@
 #define VIRT_SOCKETS_MAX_BITS          2
 #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
 
-#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("riscv-virt")
 typedef struct RISCVVirtState RISCVVirtState;
 DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
                          TYPE_RISCV_VIRT_MACHINE)
-- 
2.52.0.windows.1



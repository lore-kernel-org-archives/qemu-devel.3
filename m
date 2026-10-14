Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CB8CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvNF-0004qG-BT; Wed, 14 Oct 2026 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvNA-0004X6-3E
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:08 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvN8-0000a3-Fw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:07 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-15354aa70e8so1830783c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970445; x=1792575245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKhrMR571H4bPltCPL7J1a17aFUoRYsTRwg05TCF5dk=;
 b=Tfk/UA3lTb87cpAuljc2FH9AGX8TeOAtczAUIbS7fbFeOJc1bCOxzEArWezDbw2FnP
 kXLX1RBT3f9SRZoCd2aRVbAzr+WDoS/+hPxFt5AcldbxmX3jlGwtDoT+ZtNSouDc4BL5
 GndyB7O2xc8iDOHsl1Up5zxC0B1L7ch1q38mpsuTeW8u+Etu4o7oRkosrdtSd4WvMb+1
 DsKLezPS8odn3cl/FzXxIzMLs1Fc2wtz4RO0dZW0iNQSA2oS/qakYjeo7oGCMzBus39l
 te7BzXWuKNTRKCtGJiByRdL5OWMAP/6h2rh9YFyT4H6/1k2WT5fOC+p9TmtJpP5u8vkS
 AiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970445; x=1792575245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NKhrMR571H4bPltCPL7J1a17aFUoRYsTRwg05TCF5dk=;
 b=kr/Zt2lsXPvXD7I0M94yNYxpu+UCaKf/4eee/kqVqg+fkfUQ1+Y5n7lzT0mYs8L1Lv
 arE81GkWq5kA8bpCwlyGQVjWKuuYyWIAl5F1AIbNKoYeWWmaJmQ6S6GWJCfFpcwQVXN9
 +Cb+gjfJMqfLE7J8XNFm9udomdp+qOsUeOjpBJHD9sqC4q8mZbgGZHB9wrvbPuOb+3LS
 v8BzOBstBeirokwdzQkqXBrIBLi24l92gHPoO/OzUtHuPBmSRcpwQKTmjpVAEf61nE/1
 dNExqw5vnVUJSD+fAWMc8/xXi1g+WEeuF4J0gEz4UHFtt6fIabWF4PPRqBFwCuqi2rlJ
 DtGg==
X-Gm-Message-State: AFq9FYLr6T76PccnxfW+Aug8lGV+2PVDonafssJwPXq6es04r9quClEH
 FCAs/7EKtT6Esh7hJSWX0SFvv+Kfmg55M+bHtxqbfwr7C1z3/ik9yMNZAOzsUXDRgS4=
X-Gm-Gg: AYBFou1IyzW2iyltpgmJSwDuEuyfzGgtFk20aYbnZofTGMYVWMLLllc4Y2XAqH/IX41
 fSDeQfACf9llBJWWXGguQv0V0AjZAzL972s0RB26/R5YSDfW5CSAmDg5tA5YusF/OSxgu1cp3HL
 h5961e9LWiAkVZpKRHVASs4tyLhwn2DtHMDzBUyimQNlGHXp1EUR/PmkIZRW+iwjcv4HSMYZzga
 lLGnr7hPVj+TNBNFMi+PSzcQBcbc89MhY91Ny8yzPkMlkv8u7pcFEOq8Yvr5yoPsbgkwauldEma
 RG+ebmhdYNO450qRhue2X+hJBMyCWVpQL0HQMUKuI9HJHXW84cClsr1XHKIDLn9Vc6pa7szxIge
 Px2a0X7vbVlW9AozAunj0eRK03hn15wpDCQYZwUgNcM90tb65QgRT5dUFQY/k7M8fkxJ8bh8a7v
 TzlD8Q+7Nv0baoyp41rpgFVVqPHMYKqPDPn/Nt57WueLcSloVcFC7rcxpAO3eVcc9fA8QlCKdWG
 LZdNT2ridgtyF1xEQ==
X-Received: by 2002:a05:701b:2905:b0:151:5d01:9316 with SMTP id
 a92af1059eb24-16a5ef287b3mr21112689c88.23.1791970445008; 
 Wed, 14 Oct 2026 02:34:05 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:34:04 -0700 (PDT)
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
Subject: [PATCH 12/34] target/arm: defer max-v8 initializer selection until
 CPU creation
Date: Wed, 14 Oct 2026 17:31:22 +0800
Message-ID: <20261014093152.834-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
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

This is for avoid "max-v8" qom name conflict in multi-target qemu

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/tcg/cpu-max-v8.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 65f851f2006..d7323ab431c 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -119,12 +119,21 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
 #endif
 }
 
+static void max_v8_tcg_initfn(Object *obj)
+{
+    if (target_aarch64()) {
+        aarch64_max_v8_tcg_initfn(obj);
+    } else {
+        aarch32_max_v8_tcg_initfn(obj);
+    }
+}
+
 static void cpu_max_v8_register_type(void)
 {
-    static const ARMCPUInfo max_v8[2] = {
-        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
-        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
+    static const ARMCPUInfo max_v8 = {
+        .name = "max-v8",
+        .initfn = max_v8_tcg_initfn,
     };
-    arm_cpu_register(&max_v8[target_aarch64()]);
+    arm_cpu_register(&max_v8);
 }
 type_init(cpu_max_v8_register_type)
-- 
2.55.0.windows.3



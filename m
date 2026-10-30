Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB5606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s8cjdxin
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoM1-0004aC-3h; Fri, 30 Oct 2026 11:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoKz-0004Jt-MW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:15 -0400
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoKw-0008Pi-V6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:13 -0400
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-181516de561so770750c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373368; x=1793978168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etdm1aeawsytO27AD2qjJhqW2J7wH4UjI2RO2JWtCa8=;
 b=s8cjdxinyd7QRoKvA7vJC+7PAQe4KEGVx1Je0jfh6rIA03/cfwmh+VlZ6tk7GcOreD
 A+jjuCehSnCzXTics+wlFT6oCczCtz+iPU9WfXou6YqQPqgZDnFsBbdi7AHKIxEvLO+8
 G88G++j8cGb8nvQS1DoxSYx2KCnF0/boCvQvX4LtDkU8vlXB1Z12bCCIUNBnVsAMCpNN
 Spzxj+JN+saavfkfYOCSn2vh/oTWighgWB/zc64iVHDVZJskUjXqgBezED4mvJhA8CKU
 F8JcxO75yeqx5q2ddbIdqGTs/zrs9LW0u5Dj/Mru2EzcezCoGFdKDbS912MnmtWHKgI6
 N5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373368; x=1793978168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=etdm1aeawsytO27AD2qjJhqW2J7wH4UjI2RO2JWtCa8=;
 b=io3tKTEbDB/3UVNGQ2+xJhEGM2M3Ev4UjzIHAVsE8UErDxMXUYmrDwh2mYR+91FmJO
 Hw0odTjTHBg9zJ7gldRvpwn/P49weSzgRHzwsbGCVkVuY4fU4Np0IPHL7P8q+Tmxbjin
 sPwgHv591n058jUkGsEUb1DGQPDDu8kasXWBVB7eryR6hq0z+KKeIG0ZcCIyLkctFvjY
 vZI/FRC8I6/LPzt8fJ8Iu2SikYJQJsSZm57jwqbTpdUPko/mwAWUiqphPJY9Wm+LFPDz
 bwX59jwnII7mabTssgSfxckiuz/HX7mZkGMOT8MZXj5tf1r+Ib2EDJ35CbdxbKZK3qin
 phpA==
X-Gm-Message-State: AFq9FYLJg7XaNxG9eKVE+mdXCV6b+aakee6YbzY+eBvz1HwAhqWr+JJj
 xZqLegAPmagbEsoLfQ9jNPdzQ+bC30ZdMa11KymtMhbWff9g7EelgD1AxBMk1Pv10g8=
X-Gm-Gg: AYBFou1nb+nc/YZBqR/L4vhdcQS6FkLPTEfs1zwaEQKjsdtHNjFsO30+75FAogV7/o0
 EOrE2F1IyjILG5zlPzlEbspr+FjH4Z35V+KtkyUxEjZBX9ZaX5WOFG2OLtI5fd+ym4zRYR5a2+t
 k9qY+F7NcVcCcoeTFmlO0ceG5sBaPBEn5EooVcfZx+RT/hB0v/LwN9LOMF2b+Ec1cNpLFZMJ3zC
 3RFjYs5XZhWD7NDJ3LezMrRp7VUaGIq9f3/59xiWI3LISAE4/c6vwrlnOCbSSiAqZjWifYgLcQH
 diqCtDvrP56WeaIkCYYhMcZsSRiHeOgZv5ZN4ci4VTis8/dB/WJqzQf4qs8Xxc8H2gq+sAXuaiW
 XX3rZOL7u4uJsGoZTiWMoxohhe08biE+bHHel55Dg08NGW9zaG6NWpIyJF11QZwGtR8QFng3Rg9
 uLur18Y5T8VtAjEJdIB4lq2XYWVmDT8q+83yQ+nNs3bGk+pVPoNMSZhSoTEJs2EXDmtO1fGfhh/
 oJ7aUHaqZcwlHI1tI04lEG1wdW4NRn1i0IFsZ2XgPNlUzsKbdCmpdaG0w1NUs10yOBF0wD1rQsr
 hiP81kFKAnK39XHjeLvclz/XZHChVXWFntooNncVwQyJLotqbfZVTqISj5X2ejoF5lU/NA==
X-Received: by 2002:a05:7022:ea57:b0:190:716:4822 with SMTP id
 a92af1059eb24-1ac599f506cmr3074840c88.8.1793373367717; 
 Fri, 30 Oct 2026 08:16:07 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:16:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, Felipe Balbi <balbi@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH 01/15] hw/alpha: expand DEFINE_MACHINE in dp264.c
Date: Fri, 30 Oct 2026 23:15:22 +0800
Message-ID: <20261030151539.1872-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1235;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1235.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() for the clipper machine to clipper_machine_typeinfo
and clipper_machine_register_types() calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/alpha/dp264.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index f928e0cee82..83e9a0853c1 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -201,8 +201,10 @@ static void clipper_init(MachineState *machine)
     }
 }
 
-static void clipper_machine_init(MachineClass *mc)
+static void clipper_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Alpha DP264/CLIPPER";
     mc->init = clipper_init;
     mc->block_default_type = IF_IDE;
@@ -213,4 +215,16 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_nic = "e1000";
 }
 
-DEFINE_MACHINE("clipper", clipper_machine_init)
+static const TypeInfo clipper_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("clipper"),
+    .parent     = TYPE_MACHINE,
+    .class_init = clipper_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void clipper_machine_register_types(void)
+{
+    type_register_static(&clipper_machine_typeinfo);
+}
+
+type_init(clipper_machine_register_types)
-- 
2.55.0.windows.3



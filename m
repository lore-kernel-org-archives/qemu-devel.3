Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M59x8trc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoNW-00062l-CN; Fri, 30 Oct 2026 11:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMw-0005iB-8Q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:18:16 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMt-0000CH-FU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:18:14 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-18cdcfc05ffso1080359c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373490; x=1793978290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGbrF5LygDW3ceui1OfwylCKsorUyXpzXpw3dzNJEUs=;
 b=M59x8trcVOIrEiYkMCmKvG+aZBLP3dD7nByh0vH+qYxWsGfBYYCALFM+Q9Lp24wG3a
 ZAD+oRzxU7ocOdBszW5NZnPKJh7Ax2au3zXUkNbHWJPmAv5laxAXseNlfBwLtPT+Z+Ce
 CqO5FA7Fw18afEpjnKyz22jFPLxQnr7jtXW7RZQAbu3V2AKW4T6yg6pWZJIkecxaHCgQ
 6MNReWSvJV1AUEA9Gr9+7Hgx/pKFda1753VduU21er4n8ElGdrsB628XzniiX1T5m7O5
 X8OaBrAMMAyOB+skEUJ/eFCUMEQ3FrzE4qbx+29DA1nJ2wLAFzTchw9Dc2bUwM84MgPn
 BJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373490; x=1793978290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sGbrF5LygDW3ceui1OfwylCKsorUyXpzXpw3dzNJEUs=;
 b=GD9mUKHOrUAEg41Cvf4Hvskfq/WHpRCJm0Pq1CltMTFNjbB/qucp4GgNc1n999PIdb
 EDd+r99QG5+NBdKZi5QL83WEKyV5hiuXHiGM0IWPS7qu04P8cUb2eQnVRiRBUn3mIZNq
 YR4qdMsYZmy/UVwPbGkSJvde+ZxcztTY5zwXGARa9tVKIkgUpkJT1KJP72BpSm9TbZub
 /khF15B+6PeIHrDtjUFgdUx/OIeF+ZuAJ1ud0plRprqzHGKiYUB8ca/xz+MOY8kIolAq
 Lby3DSa2pKBwbn+mVrpsxya7EZCDkRuanyvBtHTrl4niG+UhKFDfI/MtRKMUU1D1X3JI
 GTAQ==
X-Gm-Message-State: AFq9FYLzk0ZWrSYeamdqkwjYFy9nKB7ZEr2+aFMrO6g86mWIW9+E2b7o
 zzD2AyPZFXmzbNkr4e3BR9UJpUuzYnl6ev+KID912Wc4GdODNsGcS4OovA3Lt1C2HY0=
X-Gm-Gg: AYBFou07HHzFgBjNSS+deE9tc36aIy93rbFk88TF0tzxPEDiMiNyJualCUra7bAQFeG
 9cUkUjyJKSGt85hfub02kNe5Yvr+w7fztyyCVVC1blRabT57olyedxwrwxQzA/uLZDBCCfLEb93
 dr77oi2PUbzkaEbhiAkTKxNg5aeTmrjN42O/MWeXswYxrYVn7ai+7u45vB5Cl6syT3QGwVL+eIo
 Rijm1xc+cqGZjXWYXV87wmpcqydwei0fbvWNK9USdy4Ebttc5vrcfZ/tvD6slI6QffJcpOosc56
 FeNW7y4gdWxdhEX1gNOsw0V0Q0gTHV4Wa1lhMBy0sKUvM9tKqgAqwmpW/wjJN/XIu65vXD7Ghjl
 9h1xg95A4bNEEBgQzmdmTJ5uXSm3dDhawXRbZOgoAbaujbQtn4lCrUlmJlkcUXkSSt2hTWcg7vJ
 VNyNTlzMMvGBq3/0WUS2JTydiFTaBUtnpViJlsfjVS33SDiA+umJm7OmH4JKlrKrWlueq30bFIl
 UTEJPo6ObzdX70RuofD+HLw4M6w3EM3VvTso4V4gmAZWgSFmjdZ/ZLdSjzUKKHWELDOsOZd40T3
 we05cD3svA6k1fAEOnfFT57HaOnrdmHgEaP2PDzX3pfA1ik7O7ZsV/2q7clHdgTbis7j4w==
X-Received: by 2002:a05:7022:258f:b0:165:dd90:1f54 with SMTP id
 a92af1059eb24-1ac5eea0384mr4400234c88.47.1793373489939; 
 Fri, 30 Oct 2026 08:18:09 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:18:09 -0700 (PDT)
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
Subject: [PATCH 12/15] hw/xenpv: expand DEFINE_MACHINE in xen_machine_pv.c
Date: Fri, 30 Oct 2026 23:15:33 +0800
Message-ID: <20261030151539.1872-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122c.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expand DEFINE_MACHINE() in hw/xenpv/xen_machine_pv.c to
xenpv_machine_typeinfo and xenpv_machine_register_types() calling
type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/xenpv/xen_machine_pv.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index c406821c34c..85ba65a3243 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -61,12 +61,26 @@ static void xen_init_pv(MachineState *machine)
     atexit(xen_config_cleanup);
 }
 
-static void xenpv_machine_init(MachineClass *mc)
+static void xenpv_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Xen Para-virtualized PC";
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+static const TypeInfo xenpv_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("xenpv"),
+    .parent     = TYPE_MACHINE,
+    .class_init = xenpv_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void xenpv_machine_register_types(void)
+{
+    type_register_static(&xenpv_machine_typeinfo);
+}
+
+type_init(xenpv_machine_register_types)
-- 
2.55.0.windows.3



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C47606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvddITIR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoMC-0004kb-97; Fri, 30 Oct 2026 11:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoM1-0004bN-O5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:17 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoM0-0008Vz-4o
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:17:17 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1931ff67a29so121249c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373435; x=1793978235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m864uzH9D1nJnXhJ32zoDB2BUw6AVK2KA1WWNZhkMsE=;
 b=UvddITIRGppPhk9RxFZ1M/UETsEUgmdxoB86M8NSL032pxbc/5q02QcGEcIszdnCuW
 jLeuEJuyX3Vn1kb8Uhz9hCxBwkf82vm1ITfM2bJJerRzgJ4hQaEwjO3/e0KiqP4Tni8P
 DKSc/r+nJITU/Muocw2gKHVf2TfCHOd6at2u8fA3FCaYhjOhHXKmOO09WFwPdne67MUT
 J45s/QiLXWAhcJ/AkYrEio09H+qeieLXNCujtEI1ClWtFIRCuF4Sb37Z9Dbrhaduogpa
 HtDLo+jig+3zMSIiEKENl3zwUpF3Z75VcdZc/7Rd+05u0AjrATODJiVVrgRXs/6LgZoO
 MjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373435; x=1793978235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m864uzH9D1nJnXhJ32zoDB2BUw6AVK2KA1WWNZhkMsE=;
 b=hmRfF8n/4a6Z8Sbke48djBFi7erCdWqR4+fa+5r0ODgpH6/cB6F0tP3YORbf8OX3Bv
 3E7cjJaBbJpu9MlYrEJ6r1DlIUubiKkFylspF3NKtfj099iLONUoBQMqJv6SnaYnWZ5U
 X/w1DEkxExjGYQgMid44BTnLzZiL4oAsLanoWG/EFNdums2Ld6g8hk5IncRbQ6emnHEp
 CWT2OPW+vYffCK566yUoaUdznVT0MytdM6Ft4PrmpapCu2y2bwHTPe8mSmKetc0y6XSV
 u2lBQK9zziqtKB6efAV9XS+DCymwggBcvcwsBSV/iiSE4BBIuBOJ08meSQ92o8+jyNAs
 M9bA==
X-Gm-Message-State: AFq9FYILyI5cwlUvcOReBnrN3NaTB9zv3qjmJSfkGc5sbRXUlPdjsO8J
 PZJNSpod7Niy7yDg51gB5fuY+bqo1TJljVhmxBeFo7QoUq+BcvGh91CjNx/Z8bokx7Q=
X-Gm-Gg: AYBFou1L+hr7T4jmLs4qyXUb06c3NmhI2/pMUaVg95ylqt/oygjoNYD4ar2GrCaNvT5
 EVOlhO1LBi2MIc+qTNfSxUIELxhWsIL0wYG4hS93Wkoyh49ze+IipmVnRJiczPVol4pP3jE9zIe
 Ig/iqV88KNVyQ9GVrSUf53S/27RRhlJgqgx+lqXEni9yDwiZNxc0LNWi5g4j7LXeOiWwOUOPyFP
 1mrPJxfXQeVPRvBr7BV9H0xCk3VrVGMjYRm9NWSwGQvidMU8lDupHzz46D9SZu06iB/f+eKro5M
 HRsKb20grixfl3t7/4No1csgn1v9rfp33SfxDbV5S8Dz6N8k8CSxBDyMTTPPBUVxUm1lbaUsTNe
 9SMCAJIwatfujfnZffHLaP6Lr+qwrLmrOV0Q/tAUnpsre8xPdZnfUtcvCC9amBmxnq1tnv2eykJ
 nbQIkKauIqNWGLCTN5mJUt4SqmFapt252HebiZWZxNzWVk2/vKhPlgB49xKHXcWqHHYWR+pazwT
 sL9rZwNntStXhjNEp8bzNWMV/Rq1PFR7HByU28KYuuYxftCz00WqVQQX9hmtyANPuHJ4uzvuusz
 ERbzBOOZfkGgTj26fKjFw/uxKVOzrPIKfw==
X-Received: by 2002:a05:701b:4512:10b0:181:73fc:e53 with SMTP id
 a92af1059eb24-1ac5b7e21fdmr3546543c88.29.1793373434663; 
 Fri, 30 Oct 2026 08:17:14 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:17:13 -0700 (PDT)
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
Subject: [PATCH 07/15] hw/core/null-machine: expand DEFINE_MACHINE
Date: Fri, 30 Oct 2026 23:15:28 +0800
Message-ID: <20261030151539.1872-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
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

Expand DEFINE_MACHINE() for the none machine to
machine_none_machine_typeinfo and
machine_none_machine_register_types() calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/core/null-machine.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 60254913019..1f35b9169d1 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -42,8 +42,10 @@ static void machine_none_init(MachineState *mch)
     }
 }
 
-static void machine_none_machine_init(MachineClass *mc)
+static void machine_none_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "empty machine";
     mc->init = machine_none_init;
     mc->max_cpus = 1;
@@ -55,4 +57,16 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+static const TypeInfo machine_none_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("none"),
+    .parent     = TYPE_MACHINE,
+    .class_init = machine_none_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void machine_none_machine_register_types(void)
+{
+    type_register_static(&machine_none_machine_typeinfo);
+}
+
+type_init(machine_none_machine_register_types)
-- 
2.55.0.windows.3



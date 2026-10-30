Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAED606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K/a0C0tU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoM6-0004ep-VK; Fri, 30 Oct 2026 11:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLY-0004Pl-OW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:55 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoLU-0008Ss-Nw
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:16:47 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so1420465c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373401; x=1793978201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zA4vatNcIKJhE+Eb39umMv/j/wzlc1JpQpFuLfiMq1c=;
 b=K/a0C0tUUuO6kNQZf4bTC+W1V6fsZtma4zFADfaRDP/o0WNzWpbkhaJqJL1EqkmMSa
 nxqes8o3pJxyj2CRDcfW3yD/T6fJSpAvEap8Sc9qQqnvDsholViI5jXLQ/M7mX3ak2J0
 vqViKaCYSgBrsMBlKN8QyYpUUOxNN8NReVh8avw8W89CeS9/6HdZHUakxXUNMVXd3DWP
 u1MKsW7FUSFO1Trw8ohc1na0+B97NbcWGVPLpeI0z5dP7nTIjmuE4WDDvNa5iV0qxNWq
 mj52WWPs+BrIOgUdYIw6xVHvuQe0Plin/66wXTtSK7jxVcYq3Fbuv+fGLY6I0+EC6AZ5
 t6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373401; x=1793978201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zA4vatNcIKJhE+Eb39umMv/j/wzlc1JpQpFuLfiMq1c=;
 b=CfNzZj/yz81DK03Q7mhaoXJB4CQQkGy9UDERFyfqTAHgsd9DhKZqerCtLA+ZzgXEBh
 dTrLFH7ildr+HQ1bbpA5buKet+Wve9HyH8Y4Iu6I9YHmv1gAkGMbOXbG3eLwnWHFtbC5
 smcgv8M0RfMJDUaLoeCFntwZ8eujZQmLft1CxTBgQICTu+iyxSZbF4otTTSWdgpN4JCo
 wcBYy7I8pIyDhAwJdc6Eqipn/oMGmJpz2noPLFpoR+ZmNzaDtgl0hcJRS485htqyS8lB
 teNTNBup3jDsnbtNnh64jn4kD3yjV6qFt4vDpFXEyWtPm8jmWfEIgYaPYi2q5DiuBE14
 i4ZA==
X-Gm-Message-State: AFq9FYLCyMbLExO8wYbtZegCFce4qkjmrvAyOgG57TQEy6BYOgxJWiFq
 uQCkgGvFMksb0jzry5eu4RzemiOHwdXRC8yHdPKapUcdzVCPeJ0PMKPFz+0KzbN+gzU=
X-Gm-Gg: AYBFou1OO3Y9VSrLpSOTvkejaVDV8N86QybRYZrVVfHua0fMbCw/CUtpJZR25O0+ZC2
 t8bnK5ymRF1bVe0ZouH4PeEw8jJfy6QdrI0MksOlXytX2U6IoP7sZEOXYHCc+t/3eXGG9FJpEBV
 nIio/xA3XVYmR7kVK4VErIpWq1AXHYqLtPxqnNAwAclii1YwYeXWEmLvkk6a5q0IXIzs1ripmST
 D/i8QCs6NqSuLyVEI1A8OtfBAfOWGYMqa5QCb/BmCGlaV7f8wHFqtw7MNAlLaW21TtmA7theGaC
 LFTC3GD1bJygaWC214xlBUGRvyMe1sKX2iPJA5KkSYHWCLCIg+Odw/CgSk7Kn/550b5TkRRAFh2
 YzTpPCZB09DRj9x/BxC4RvFPdRsfWJKfu3UztUPHs5DzVEA0Rq+r+x1z6sy8YA8L4z+CDpNObrY
 Sdb7Y0eh2GrhSb+p42WiiWecc6+saJi5idFPmdSEnNcrKE0FsD92CN7br4ZyLrJ//zsd+UlgfRI
 4mnt2IbeiEaSHNbNCwNy3Vnq8ay6H4uAlCB61jgJMX6FhRpjVf/dtcb3WUnn3wFuCq85ri0Qb7V
 5y9u/UCWnF0OnNzUR+DFLqWYapOeuYdePxvWEo7At5dKpX8O6Tgql9EHbeny8/tcziSobg==
X-Received: by 2002:a05:7022:ea46:10b0:177:9a5b:a89 with SMTP id
 a92af1059eb24-1ac5b5f270emr4076428c88.29.1793373401184; 
 Fri, 30 Oct 2026 08:16:41 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:16:40 -0700 (PDT)
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
Subject: [PATCH 04/15] hw/tricore: expand DEFINE_MACHINE in tricore_testboard.c
Date: Fri, 30 Oct 2026 23:15:25 +0800
Message-ID: <20261030151539.1872-5-luoyonggang@gmail.com>
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

Expand DEFINE_MACHINE() in hw/tricore/tricore_testboard.c to
ttb_machine_typeinfo and ttb_machine_register_types() calling
type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/tricore/tricore_testboard.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index d5d796c8eec..2a25f090520 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -106,11 +106,25 @@ static void tricoreboard_init(MachineState *machine)
     tricore_testboard_init(machine, 0x183);
 }
 
-static void ttb_machine_init(MachineClass *mc)
+static void ttb_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
 }
 
-DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
+static const TypeInfo ttb_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("tricore_testboard"),
+    .parent     = TYPE_MACHINE,
+    .class_init = ttb_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void ttb_machine_register_types(void)
+{
+    type_register_static(&ttb_machine_typeinfo);
+}
+
+type_init(ttb_machine_register_types)
-- 
2.55.0.windows.3



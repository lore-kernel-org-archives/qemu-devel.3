Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0A606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0bgiJd8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoNh-0006Jg-W4; Fri, 30 Oct 2026 11:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMk-0005LX-9K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:18:02 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMoMi-0000A7-DF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:18:01 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-353804b591eso1307170eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793373479; x=1793978279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unXNvMdiHSqKZbW2yjBCaHIctKeqs2ATJiqxjlNdZQs=;
 b=U0bgiJd8ZCnBTvR/aNG+GlfHeCc1BT4W490VlHoaN0QKXfvAleXZrOZIBbwn3zAUeE
 gKYLf3LtCTv4tBeztnUq+G6++VThD/PwY+zx4N+ReH78a3a6WSE3qJISS2zv0YmDY3Ng
 +m+TARHJR942KUHmkpEk1JyaKI47dYv+FPM0JeqcynLoQUkGpwU4KKyNLQhGdBPNhmiA
 CwN34uS6crpBRyLcRqITEyP5RcDrcCyVOOf7upwySE9S4sBENKKmLBTAJKzu9/yW1UnE
 ISULCGrEWIi2e/qvYiVDIC2bQg5YhsZStWkxD49lr3nY/nVh8Z2fiTjJM+cMlsMwZKXp
 DHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373479; x=1793978279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=unXNvMdiHSqKZbW2yjBCaHIctKeqs2ATJiqxjlNdZQs=;
 b=H0kkxvFdogREXhqvo63DrhVpg+U6tTvC62a++E2FLDdHhH9u/32ZE9RNs6O+GrlPnY
 nBzex7lTY7nH+/hwoTZMWosj6NMbDAc2NamDEAJFfAUzwvRxZ4yPo/B1Ck1L3+ltAEfS
 GgL3nSzScG7lbfQdMRIcyfOGK2Q1kqrCxdrGCqy6rxjgBD94gb8oOAhPMLECU225saag
 fwq+UgccGV9wIl8epHuud7kWcNqNOBNZA2aQjcS2s+SfeZ7v9+z6Kv1nsy+uOZx8gOIH
 zt9FLexu9tnrGU4C4/VpVhiRjN7rVgq+1YK6lAZ8QyjHczCtauJnzLGastEVDTpFEUWt
 PaLw==
X-Gm-Message-State: AFq9FYKloFC4T8K84xfFm4iaeugNkfQX9mSi2s4yWgPNSNmVqd12E9wv
 zAxPRenpyw/j6jwi/NxKQB4nxy46gY6a0qfBjhj1ww1XiyIsunRuzHVzTZFUah+2UcY=
X-Gm-Gg: AYBFou118A5tkPE4H7nVAvr0ZSa1GwtdM2ghzYXSSQYFyeoQbenPYt6QmREgskfHyBr
 W5oTKqTCgJ6wUkK8OSuBPphHKIF+ZK3rW0UZA7hrjN6aDRFAOzC0to7L8+V+XcjbyJM8ETHeMlr
 ZbTN70mQBCQHpwiIUc6ZwX/RsM2jWFkJDnMGv3W0Uv8aYOJTNTb5kEpOsGVWnIhl2fnyFktodFK
 uGnAZTE7zi/PXIYnWS9onRuXgWHNxD2d67UN9+BZKnoWrzzS4hZEXGP2n2SmUKMwNnZzfynufGA
 dGSItIrkcrKwRHrmbSMxLuRUcy0IMFsLQv0a+xbT4hd7gwS72H6rACXOCIJKHZt5Q9wgkb+76Wf
 OAMO1Tb3PY3qR1ob/WDPBO7EB0+XV0xU/30fgprWf8+j+slYjgjk4fOGn5l7kQpYWzUcUNN+eQS
 1nTFXxFsw5KJvO6PGIMZJ5YJCtUbJf3L+KLjFLKAbvBcWfEwGp7OccoiA1EvKb2cygemRnxferi
 WnogUai8k6e5QcZyARPhNBKa0Ld4FHXAENhlvpVgzuQcpG1swxH5sSm9DAEYmhuXT3zJEe/pjQf
 uolaau5WpacZMZY8P6G82fTsGmSEP9pp2HKxDDHfD4PZR/XW
X-Received: by 2002:a05:7022:ea8e:b0:1ac:f84d:4036 with SMTP id
 a92af1059eb24-1acf84d43f8mr2092732c88.9.1793373478878; 
 Fri, 30 Oct 2026 08:17:58 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm12770449c88.7.2026.10.30.08.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:17:58 -0700 (PDT)
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
Subject: [PATCH 11/15] hw/sparc: expand DEFINE_MACHINE in leon3.c
Date: Fri, 30 Oct 2026 23:15:32 +0800
Message-ID: <20261030151539.1872-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261030151539.1872-1-luoyonggang@gmail.com>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1332.google.com
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

Expand DEFINE_MACHINE() in hw/sparc/leon3.c to
leon3_generic_machine_typeinfo and leon3_generic_machine_register_types()
calling type_register_static().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/sparc/leon3.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d4a6e917598..ddc25f528ff 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -434,8 +434,10 @@ static void leon3_generic_hw_init(MachineState *machine)
                             LEON3_UART_IRQ, GRLIB_APBIO_AREA);
 }
 
-static void leon3_generic_machine_init(MachineClass *mc)
+static void leon3_generic_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Leon-3 generic";
     mc->init = leon3_generic_hw_init;
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
@@ -443,4 +445,16 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->max_cpus = MAX_CPUS;
 }
 
-DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
+static const TypeInfo leon3_generic_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("leon3_generic"),
+    .parent     = TYPE_MACHINE,
+    .class_init = leon3_generic_machine_class_init,
+    .instance_size = sizeof(MachineState),
+};
+
+static void leon3_generic_machine_register_types(void)
+{
+    type_register_static(&leon3_generic_machine_typeinfo);
+}
+
+type_init(leon3_generic_machine_register_types)
-- 
2.55.0.windows.3



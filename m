Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8357F105A593
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 12:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0eui-0007tr-0E; Thu, 12 Mar 2026 08:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w0eug-0007sL-GU
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:13:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w0eue-0005oI-IC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 08:13:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b94a19fdso939097f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317589; x=1773922389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6kU8tqLS+g9vnZu/V0aQdaCqb3gTp1f8uYD2kdM8FM=;
 b=WuL3AWXcTWmJwfchGFzpljvDl2GlUkFLGtf/M96EAVBAvwMaNRoQCHxp7deDdU+eye
 b9gZTh6THZ8hGfLsW12T6MZw25+ooiIi58sgwxG34c06qjDfxQkG/bzzDUOzh4Xf/yz0
 TgnuBt9ILJMv4zq5Zg/1ubJgegT3iF5+Sz1qKnimYGpRjhBrtBUIyDDervV+3+YV3Nmz
 VRzjhuGI6tXNH5uUgfkPWYhrnTAJ73RuMrHyk0BssEdtfev8FdkZr8V/S+NoHag7xUOK
 xAh+N5rP5NFRuQfJb5/H1wTF1L+SiJNrsD0KfFDpyC2pKPwVl+elv/gmwivInbGxKC3F
 yodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317589; x=1773922389;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6kU8tqLS+g9vnZu/V0aQdaCqb3gTp1f8uYD2kdM8FM=;
 b=Dzx0X6BIsDHouR1lbi9CId0CECED50QKBUkKENERyL5m0rnZi4rs837/cvPfNVuKIJ
 SoDgSJl0MYlb0wUKTtRvJLCTXa1apObd3uO2xWda7rjrt0y1X9Mxx24e5gq3PYqVzfiS
 SFizU1+0y+mgB6G/rjUw7H6wk+nwYF89q3NkxxAMpzHV3rLhyE5jqg8T/x74gxC/cOla
 xLoZ4kpSSM0nceMx1q88Vc7oHv5/Y2Mq4n7BGhqpy2W+Jy6HFTcsG/batf37snNeHGdU
 za/d+N2sJG1MHj7Y42Q1aIffH8RyLa10CbOYFwA4RcBGgw5hVVrpE1VNOauSSN5Lzsl7
 1QqQ==
X-Gm-Message-State: AOJu0YxXisDMcBL599xeC6ar8e2TJWr4yrkg49XfQsaGjTMwjxNrjgFx
 L6rnPNdAsw+m35hRcC0c+7RH+8tPB6zxmU5bP8zM8nVfEt6OjbRljXUXms8kQA==
X-Gm-Gg: ATEYQzz1ZW1hA4dmPutzFHWRQgjw4THJWJEE5v1I1dtUNK/Ntq2UlWS803FtYbJJl3w
 eGbHu7v2glJ2KfCEw+s6dPgx8Zn5fT/2ZG1trT40QGvlcWDdqTv6z3Ex+lBfBPRTbb6Cpj5bMvc
 yenIo6U5SgiTy6VkYUm2uR2O/NSZBzoFdh83p91AxvSOgE9tQjl0lhYG4J+LTTpBc+WhRs6o3Rm
 YlTthfsMSy9kFwy0ZTA3PZAMQGgq9Mxp/tRjlcRU0FJTd02iGPxa5vCBEUOi5tjbS9KiRSSndNv
 afDwdCJthiikCurgR2wsYwWsRf2TlTpruVp86ts5Y8bc77lv1GPuAkHhgHxpwklCkmAkCTc5KuF
 DHEKvp/RYMxplvKhSe095m783eVDsq3byheR+Fxdh4QmPg7rmGQi5HVO5zt1REFEgurA6lb+I2Y
 FgH8SzLoDySBGRJP1FLV1WmTIRNrtRm4JYLxBW06GwUxbs2i0qULnOK1ZOX04G6pFR65CWCmFXL
 Ub6MtO2mVbzx7qhWdztotM=
X-Received: by 2002:a05:6000:4011:b0:439:b374:c6d8 with SMTP id
 ffacd0b85a97d-439f8423d80mr10388313f8f.46.1773317589313; 
 Thu, 12 Mar 2026 05:13:09 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100f009a6c939e7d8fe.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe23afc5sm8728377f8f.39.2026.03.12.05.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 05:13:08 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:13:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/isa/piix=3A_Embed_i8259_ir?=
 =?US-ASCII?Q?q_in_device_state_instead_of_allocating?=
In-Reply-To: <20260309171258.1905205-1-peter.maydell@linaro.org>
References: <20260309171258.1905205-1-peter.maydell@linaro.org>
Message-ID: <203D8A31-6A4A-4DD6-9F3E-8A48E5BA256F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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



Am 9=2E M=C3=A4rz 2026 17:12:58 UTC schrieb Peter Maydell <peter=2Emaydell=
@linaro=2Eorg>:
>The pci_piix_realize() function's use of qemu_allocate_irqs()
>results in a memory leak:
>
>Direct leak of 8 byte(s) in 1 object(s) allocated from:
>    #0 0x61045c7a1a43 in malloc (/home/pm215/qemu/build/san/qemu-system-m=
ips+0x16f8a43) (BuildId: aa43d3865e0f1991b1fc04422b5570fe522b6fa7)
>    #1 0x724cc3095ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2=2E0=2E=
so=2E0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>    #2 0x61045db72134 in qemu_extend_irqs /home/pm215/qemu/build/san/=2E=
=2E/=2E=2E/hw/core/irq=2Ec:77:51
>    #3 0x61045cd7bf49 in pci_piix_realize /home/pm215/qemu/build/san/=2E=
=2E/=2E=2E/hw/isa/piix=2Ec:318:35
>    #4 0x61045cf4533e in pci_qdev_realize /home/pm215/qemu/build/san/=2E=
=2E/=2E=2E/hw/pci/pci=2Ec:2308:9
>    #5 0x61045db6cbca in device_set_realized /home/pm215/qemu/build/san/=
=2E=2E/=2E=2E/hw/core/qdev=2Ec:523:13
>    #6 0x61045db86bd9 in property_set_bool /home/pm215/qemu/build/san/=2E=
=2E/=2E=2E/qom/object=2Ec:2376:5
>    #7 0x61045db81c5e in object_property_set /home/pm215/qemu/build/san/=
=2E=2E/=2E=2E/qom/object=2Ec:1450:5
>    #8 0x61045db8e2fc in object_property_set_qobject /home/pm215/qemu/bui=
ld/san/=2E=2E/=2E=2E/qom/qom-qobject=2Ec:28:10
>    #9 0x61045db8258f in object_property_set_bool /home/pm215/qemu/build/=
san/=2E=2E/=2E=2E/qom/object=2Ec:1520:15
>    #10 0x61045db687aa in qdev_realize_and_unref /home/pm215/qemu/build/s=
an/=2E=2E/=2E=2E/hw/core/qdev=2Ec:283:11
>    #11 0x61045d892e21 in mips_malta_init /home/pm215/qemu/build/san/=2E=
=2E/=2E=2E/hw/mips/malta=2Ec:1239:5
>
>(The i386 PC sets the has-pic property to 'false', so this only
>affects the MIPS Malta board=2E)
>
>Fix this by embedding the i8259 irq in the device state instead of
>allocating it=2E  This is a similar fix to the one we used for vt82c686
>in commit 2225dc562a93dc, except that we use qemu_init_irq_child()
>instead of qemu_init_irq()=2E  The behaviour is identical except that
>the _child() version avoids what would be a leak if we ever
>unrealized the device=2E
>
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>---
>The handling of IRQs in i8259_init() is rather convoluted and forces
>its callers into having an IRQ that just forwards the set operation
>outwards=2E It could in theory be cleaned up, but it's used in too
>many places for that to seem worthwhile just now=2E
>---
> hw/isa/piix=2Ec                 | 11 ++++++-----
> include/hw/southbridge/piix=2Eh |  3 +++
> 2 files changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/hw/isa/piix=2Ec b/hw/isa/piix=2Ec
>index 04b2be2cc3=2E=2E31fa53e6a4 100644
>--- a/hw/isa/piix=2Ec
>+++ b/hw/isa/piix=2Ec
>@@ -315,12 +315,13 @@ static void pci_piix_realize(PCIDevice *dev, const =
char *uhci_type,
>=20
>     /* PIC */
>     if (d->has_pic) {
>-        qemu_irq *i8259_out_irq =3D qemu_allocate_irqs(piix_request_i825=
9_irq, d,
>-                                                     1);
>-        qemu_irq *i8259 =3D i8259_init(isa_bus, *i8259_out_irq);
>-        size_t i;
>+        qemu_irq *i8259;
>=20
>-        for (i =3D 0; i < ISA_NUM_IRQS; i++) {
>+        qemu_init_irq_child(OBJECT(dev), "i8259-irq", &d->i8259_irq,
>+                            piix_request_i8259_irq, d, 0);
>+        i8259 =3D i8259_init(isa_bus, &d->i8259_irq);
>+
>+        for (size_t i =3D 0; i < ISA_NUM_IRQS; i++) {
>             d->isa_irqs_in[i] =3D i8259[i];
>         }
>=20
>diff --git a/include/hw/southbridge/piix=2Eh b/include/hw/southbridge/pii=
x=2Eh
>index 86709ba2e4=2E=2Ea296b1205a 100644
>--- a/include/hw/southbridge/piix=2Eh
>+++ b/include/hw/southbridge/piix=2Eh
>@@ -17,6 +17,7 @@
> #include "hw/ide/pci=2Eh"
> #include "hw/rtc/mc146818rtc=2Eh"
> #include "hw/usb/hcd-uhci=2Eh"
>+#include "hw/core/irq=2Eh"
>=20
> /* PIRQRC[A:D]: PIRQx Route Control Registers */
> #define PIIX_PIRQCA 0x60
>@@ -52,6 +53,8 @@ struct PIIXState {
>     qemu_irq cpu_intr;
>     qemu_irq isa_irqs_in[ISA_NUM_IRQS];
>=20
>+    IRQState i8259_irq;
>+
>     /* This member isn't used=2E Just for save/load compatibility */
>     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


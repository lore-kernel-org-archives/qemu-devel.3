Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKe34-0003wz-Cu; Fri, 21 Jun 2024 09:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe32-0003wX-Mh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:24 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKe31-0003li-0h
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:11:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8384211401CF;
 Fri, 21 Jun 2024 09:11:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 21 Jun 2024 09:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718975482;
 x=1719061882; bh=u2x+0gd8VZY8SvVX8gjS5XDM/JI0G+QdPIvDtjvOjP0=; b=
 U4xgWLtDPU41b3PkC86zFfb6ruiJc4uXX6y1b3HAG3MyOqgqP0GxAPu0d9KpFjd1
 A95wLAlUHg/ZwANj1DqkHKcERUQWwQ8p5vZmRHAO8Q8ZWT25atKGeS2LHGDi4QbY
 7JhzU5crukPCVzyWKgqudiEEYYCloEXSpApqOhmoPXR4q4JhdIXlHPp2k0DGLhHB
 eL8W+rmp4QmaFnUG7KGAdLgzribsOhlhGJ3++XINMcuxrN0YVZGkY/ustjilQRkU
 WuVVYqbrGzAlPi+gEOoRWeuFm/OD6MlcFNGobFla6EmJjHiks+f2SdM5qqYB6ToR
 ZEohxihMo6P6XtkcdwRg6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718975482; x=
 1719061882; bh=u2x+0gd8VZY8SvVX8gjS5XDM/JI0G+QdPIvDtjvOjP0=; b=d
 0bWT+otJ7y/E4mRnz58+Y1jY+pSiyQz2NtCiiHzv9sKfqg6OQzOpt/HhAoj74xoc
 LfdYsIrtM48ex/pAMhcGxzqoyDwdIQn/kfI3x4Hlvow2Cy4Dljh3Q69sbFxKEsf1
 F38SMXPlKXPEOPoW3qbZhmj9Jgw6AzbXrZmi91cgZbxekBRQz7HX1FroAQ/ZumzB
 8qrzM5j8FO65MWLL3OpRPB93iiSPGGOHS3aRMZNp1MpvBvir6tkJR+VXIUDnBm9I
 9jbfeyFn9WV3nrG9Ccs3us+Z8eqJgtk/b7pOn8csEpUwjob/ESdf0tZRvEi8lrdm
 CSa7HJCn7YtEDWQzn5IzQ==
X-ME-Sender: <xms:-nt1Zq-S1SFTYBFelONtGkG3fNZsnjhcWLruOPfULnLNemOofdJ7nA>
 <xme:-nt1ZqvKAo2MYgvO75mQ0cMggIjoe7cey8rrSYwRgbA8VOJGYJ-sYnXp_ROkaGzsp
 x77I84h6toXCOj8QNU>
X-ME-Received: <xmr:-nt1ZgBFSqMwNPZ_j7tbvMMGcIGdvRiDwGvqo2UMNqNUaCyvANXLvAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgiedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepffeiteeufeegtdeuuefgieelffefgfdvffekuedujeevteff
 hedvgfeikeelueegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhotghsrhdrmh
 hrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:-nt1ZifNgCEWMEHsmJFgIcvh1XrlMvq7FbFzQD1jCIZ7qExzQnuttA>
 <xmx:-nt1ZvMnYCoXY4CfBznW1cH8A2YNVSUSTj2aZKKM2fIJxegN9xCuog>
 <xmx:-nt1Zsnwv320LbXQwQ9G1aiZtcJexYAwyD8Y9DnFqy8CO1qF208Cgg>
 <xmx:-nt1Zhut97Z_Xe12qWuUqEqjIURaloYMAULsGPrrs0YP3VK4-Jdoyw>
 <xmx:-nt1Zq1ldnKSt8rPlSYl1ymnJrd_uMHxVEyhXaa3sm0KxaFSy0MCMTlr>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 09:11:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 14:11:13 +0100
Subject: [PATCH v2 1/3] hw/mips/loongson3_virt: Store core_iocsr into
 LoongsonMachineState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240621-loongson3-ipi-follow-v2-1-848eafcbb67e@flygoat.com>
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=JJTq5vovQyir/+eg5RcMhy0QRo8ZD01glX5y5Zk+LsY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTS6p/f3h4NCdWyll4Scts22bdm+lc9i7Dtv7K2Xbr/x
 5bJIuFIRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExkyjaG/7Udn5d2qf1dpZbV
 aWfP9jp9id98IW/dq/MO/Po6wSFzWS/DH844pblHhWRF4yR4VdUfK7pptEWFfeeTlBYKPJky5fR
 URgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Link: https://lore.kernel.org/qemu-devel/972034d6-23b3-415a-b401-b8bc1cc515c9@linaro.org/
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b64..69c1f2275838 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -97,6 +97,7 @@ struct LoongsonMachineState {
     MemoryRegion *pio_alias;
     MemoryRegion *mmio_alias;
     MemoryRegion *ecam_alias;
+    MemoryRegion *core_iocsr[LOONGSON_MAX_VCPUS];
 };
 typedef struct LoongsonMachineState LoongsonMachineState;
 
@@ -493,6 +494,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     ram_addr_t ram_size = machine->ram_size;
+    LoongsonMachineState *s = LOONGSON_MACHINE(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
@@ -586,6 +588,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                      iocsr, 0, UINT32_MAX);
             memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
                                         0, core_iocsr);
+            s->core_iocsr[i] = core_iocsr;
         }
 
         if (node > 0) {

-- 
2.43.0



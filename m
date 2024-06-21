Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E066EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdqz-0000op-Dl; Fri, 21 Jun 2024 08:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqx-0000nz-Qf
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:55 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sKdqv-0000xx-M8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:58:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id BF22F11401C3;
 Fri, 21 Jun 2024 08:58:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 21 Jun 2024 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718974732;
 x=1719061132; bh=Sgm/Wc3/2M61rteByezCX+8/ODyLp+wVv9Wwdmdj8TQ=; b=
 Hd4jZkVuFWxQpYZ9he5ox0C841EJBEpsKxNyu5g+veuZ6Y29ejVbFICoKOEZFNBW
 bvvbfW2UMjEUtekRkay/r648dm3m70nmGyoCMChIJ3l6HyljXhqiLHQDHhwOiP3U
 HVoEkhEB44Fu65eOFHgJjfdQ/xVZQ+Z0uz6bUy5CQitFniq1a9Q288dehtQ2H3Vx
 InllpbfWY+1NI2rGxSkYSZLgCtRnYudgIfjwA9JhyQZp88XQ17V+MtCv5KVckaCG
 ZKPnBl6a8WD3FBB23fnU7J+o4Ier2lxfBw75v1RZxXL8nuizuZzPiPNB9y9st01z
 MsS27WVFy/34Zqjvm4dO1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718974732; x=
 1719061132; bh=Sgm/Wc3/2M61rteByezCX+8/ODyLp+wVv9Wwdmdj8TQ=; b=u
 fgFoCfhz2ntJsUGh2CfltUSjmDZ+Bzypz7uYZZjWrGuc059q0cV1w1AczSmPf0l/
 YdzSJmxUb9BOX7UaCT2/KXZmwtwRWCe4SySaZJ4iFyqqZjPaAo3Ws5eRNnsDR1qx
 TcIZj19O0SYbkLamGQY/wXjjvPp7IWsmLP+95IedpDQo3NNoJLPBFoefFLt6i1rv
 u6Bf8c9dkZVwwgm1MZP0AKUEtj6GplkJEczC9lNSDxNrp7TRcJs7dqenz8RFdHJ5
 L94h3E+M8aNnz6nthmvb9Ul7Mq0RQXXwC7Cv8Ty1/lteVNBt+dWACfgIVvbUMFq+
 rGfarn+IFLDJ2904xeQ3g==
X-ME-Sender: <xms:DHl1ZgKZjUYCtMp5Xwr6-NckqUYUGG4QjqZDJFrIjB2ckf7mw0jG0g>
 <xme:DHl1ZgIOkFOD3zmimQLityLNDGCq_1l3fG0uydm4g3taOC5PJtp0joKGKY-Ta3pIH
 FxxGX0Zb5uWo7dtcP4>
X-ME-Received: <xmr:DHl1ZgsbJJ78rGmtSskaD7Kpd7GJj8046TxJNrTg4itz_9gU1Kgyf1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgedgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepffeiteeufeegtdeuuefgieelffefgfdvffekuedujeevteff
 hedvgfeikeelueegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhotghsrhdrmh
 hrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:DHl1ZtbRsoKTgGO42k6POPZWRCD4QUo4NFiADySCHKdoSmvmrLyDaA>
 <xmx:DHl1ZnZgNZBYQFn12iRPGCjClI4Pm4ufEtTppkPyhSafE449bi8gGA>
 <xmx:DHl1ZpCyEh05zcGetSdE8Y95FmDdPf6VN95d5xAb5lucgpNzgbwRYQ>
 <xmx:DHl1Ztb4wBxgwF0nJV0vYur687AX2sMhqtgnZF23ynaYPbouifHfmA>
 <xmx:DHl1Zix7H_9x05MFEHT32V8uEhWjOyjJvLPgU92-HzFdW6_AfdCn4TTd>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jun 2024 08:58:51 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 21 Jun 2024 13:58:41 +0100
Subject: [PATCH 1/3] hw/mips/loongson3_virt: Store core_iocsr into
 LoongsonMachineState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240621-loongson3-ipi-follow-v1-1-c6e73f2b2844@flygoat.com>
References: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
In-Reply-To: <20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=2CZ+I7xCZ2htt0pOnidS13rmrrRuj6WIRlHoYWJa2QM=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTSSq4ZT96W6nP8fajAeEz/nUtlxiqRDbtOyhpdf9Zcb
 pr9yF25o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbSsoDhf9q1JTESSQ+mKlp7
 rMzzfc57f9f6v44Zcpuny5g88bghY8XIsEBOKqKFZcdlzgV3+zbG7MoV2q4Yr3MjVWr9iy+rX1p
 8ZgMA
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
 hw/mips/loongson3_virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4ad36f0c5b64..528be84bf970 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -97,6 +97,7 @@ struct LoongsonMachineState {
     MemoryRegion *pio_alias;
     MemoryRegion *mmio_alias;
     MemoryRegion *ecam_alias;
+    MemoryRegion *core_iocsr[LOONGSON_MAX_VCPUS];
 };
 typedef struct LoongsonMachineState LoongsonMachineState;
 
@@ -493,6 +494,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
     ram_addr_t ram_size = machine->ram_size;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    LoongsonMachineState *s = LOONGSON_MACHINE(machine);
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     MemoryRegion *bios = g_new(MemoryRegion, 1);
@@ -586,6 +589,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                      iocsr, 0, UINT32_MAX);
             memory_region_add_subregion(&MIPS_CPU(cpu)->env.iocsr.mr,
                                         0, core_iocsr);
+            s->core_iocsr[i] = core_iocsr;
         }
 
         if (node > 0) {

-- 
2.43.0



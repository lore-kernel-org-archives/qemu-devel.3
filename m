Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D49C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEgBX-00038x-El; Tue, 04 Jun 2024 22:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBU-00037l-Kk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:28 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEgBJ-0001go-HS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:15:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id F40221380114;
 Tue,  4 Jun 2024 22:15:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 04 Jun 2024 22:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553714;
 x=1717640114; bh=6zYI5XmAf6RQjBQ6bZ9aMqq7aDxYp0W8beC3GgKBVA4=; b=
 AC/Xpr/wIVUJiFzVb6gK7Gxeag5X1InAma3FtCvQsTKcCCf43BqcT8Qai991Mi6+
 lwBl16f2alW4aT+46s0Po+GtsPnusbDQM+wzcUBwtRzmUtGMrn+jzHAi0ZBPtyLK
 Ds+j01D3GrBQf4K+9wi97a05HLEktbQbwsf0sTPwDFtsMLmVpAPnTUwf5HQRbWqA
 oiMYKSHnVlba2fGADXj6KdFIoX/QQmwRZPrZp6botIb9qXslFP3HCbxiHhnxK23F
 Utn10i4/jzPVstKqYpneW89agtkYSwPaEfncrkvJf+6NIG/TGZrZrMuVhEaIWATI
 5pm2ZyN0KwERqKrHvWcEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553714; x=
 1717640114; bh=6zYI5XmAf6RQjBQ6bZ9aMqq7aDxYp0W8beC3GgKBVA4=; b=G
 II5I5/3KZogb5FbiJA+rIEsUouM0XVmuokQg+jR4xLTw4RUVBOprLOdCYopcwZTl
 iWIfo1R2KwloBiDtD3G/vQpDnUZI6e9o8ZXut+z2FQVddCZPDSDzdPZJ0ZDRffKI
 RQnWqJy2X1eDVWaUBBrJYbDTjoK5Ze2oKymw/OO8ocEdtO2whNxj97CO7R0k7qwR
 BowDqDoFaa6Yfstu3H6q8mzLM8ZmdlWv8jaBqhzCrHKyZp5zU+bguyG4aMK6r9Rj
 k03DOy2W068hbgY8/oj9DFjoccPRCZcuhCU3X5ff3HLVXlqPpgK3KxCO/nmeYf2s
 62gPoKqW6si+7m4ZR8+mg==
X-ME-Sender: <xms:MspfZqV-RQnvZ0VAEP_-Jqxp1ViFkAWTHvGsfBbMy7FvSmFGwUVhdQ>
 <xme:MspfZmlGcYDQ-Die2x2UuLl2388hPHlHgkyRjLa9mUE9xKiciUVpkQhwcmBMflZZC
 ThNUIYsXCyUk70n0W0>
X-ME-Received: <xmr:MspfZuaoqWOH1vweqvtqZl4qoHe8r1jNWFIOpbF0TB1he0iVSvO_A9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:MspfZhX65knxHAEDpGVdgAa06_pfc8Ig-BLeK272ETQxuSpHiNox8w>
 <xmx:MspfZkkdp_k07eSGxvcFohiy5JqQFjUagZh7I9GUb3UIwLHMBn4Oag>
 <xmx:MspfZmeqqT7GIy2fc-mDvFXPU0h_UyzqHhVUnrd3Qy9KLloreELpNg>
 <xmx:MspfZmGp5_iq_wDKSzHOxImT2CTC_JZ5GDHnZF0Kh9YPJjU-abtj1w>
 <xmx:MspfZjtflhZAiq1rzsLYD7y6VKt7h0y9UmFquLySKt0wXvBxmggocQwF>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:15:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:15:05 +0100
Subject: [PATCH v3 4/4] hw/intc/loongson_ipi: Replace ipi_getcpu with
 cpu_by_arch_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=hnXpsnXQTRb+LSXuPnTPlwPEXPAPRspcFsaf0+IprRM=;
 b=kA0DAAoWQ3EMfdd3KcMByyZiAGZfyi6hi+qGIs/HuFEuvyHWfNHdZOKdthVyVmMzDmju0SXy0
 oh1BAAWCgAdFiEEVBAijrCB0aDX4Gr8Q3EMfdd3KcMFAmZfyi4ACgkQQ3EMfdd3KcNGHQD/XzBE
 +wMCySdrtQRzoDSN9gxYiwGG1MFU2VUhiXuQ1PwBAKKJZWyvVSliNAwIkExZJb7nVS/dSOmmYbE
 ZTTusUagO
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongson_ipi.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index c8a25b4eb8e2..b3cda5972793 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -118,39 +118,6 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
     return MEMTX_OK;
 }
 
-static int archid_cmp(const void *a, const void *b)
-{
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
-
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        archid_cmp);
-
-    return found_cpu;
-}
-
-static CPUState *ipi_getcpu(int arch_id)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
-        return CPU(archid->cpu);
-    }
-
-    return NULL;
-}
-
 static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
 {
     uint32_t cpuid;
@@ -158,7 +125,7 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
+    cs = cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -176,7 +143,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
+    cs = cpu_by_arch_id(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
     }
@@ -227,7 +194,7 @@ static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
         cpuid = extract32(val, 16, 10);
         /* IPI status vector */
         vector = extract8(val, 0, 5);
-        cs = ipi_getcpu(cpuid);
+        cs = cpu_by_arch_id(cpuid);
         if (cs == NULL || cs->cpu_index >= ipi->num_cpu) {
             return MEMTX_DECODE_ERROR;
         }

-- 
2.43.0



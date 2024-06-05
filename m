Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D06C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 02:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEg0x-0007Q4-Mh; Tue, 04 Jun 2024 22:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0v-0007PJ-SJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:33 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sEg0u-00077K-AP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 22:04:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id CD27713801A7;
 Tue,  4 Jun 2024 22:04:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 04 Jun 2024 22:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1717553071;
 x=1717639471; bh=8BoOtXANLPjK32koJXSR9lzQa8++o+mvTyKyLfnRK/E=; b=
 Fb5HjbnUsogYLneiXrGfZoMkz64JCOW+WOavN2oLBLDViLRnDDgrG3tNY/2TThZx
 Ek4rBVsWAVFwXlYt5JJylxaiXGu/OpLSoTSmRFuGw7cEPjA5gCabqpQFdtJTHcIp
 8SQ8xU4aOKGK+l4qGpzRr6sg4w6q1M1tpdeqmRytBuWiytZQkWbUtZnLYhNKtc3O
 LT9pw7CY83d1m9QCXTdB0h1yLLr7D8gahTgXfIv+zeQDiIn93bqygwOVfuZguFPR
 i0/oJlcFbhNdmf8TnoONqnfJYL38zFPCCRAZCRlg26uxz/9emv3oKpEFnjTbEJhL
 FM8Z1P7rCQXfCrp6xjGtdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717553071; x=
 1717639471; bh=8BoOtXANLPjK32koJXSR9lzQa8++o+mvTyKyLfnRK/E=; b=o
 psL9Vhm4RCrhvGOhAz6Tcy4lYzrOLevzd4N0u/fN+NAOczYhRKNA6ivGc72dMVdA
 mUOy6xqGaRS34yGYtYbouF0TPqUAp24fu1liZPhjRCJ9HIB/YkclN0lWDK1EFnkf
 D1aIRpqD4NG0S3Kbynd4DyrSbcTH+xesIa982Vg9+oyv/DJfNOGBr8e1oFjA+86p
 bJEWFQKYgajBISyMKrF5Xwv3fAZvxpEhTjU6C9D9r5KoyP7QEZuRRTzL9c6ktJwd
 3d9rFMRlgSkC1TZbq4R9VS+EB0+ZAZ2Mz9a78XhjSK4PIUFovHW+7ke3fKUHrMkA
 Hltkgzg721LCa2vL2e3eQ==
X-ME-Sender: <xms:r8dfZo9Y5x8I6zA1H7QEPejXjQwD5UMAmVbu72oG-q6ul2HMKbjkow>
 <xme:r8dfZgtL21ytY3TFb-hmL5iTTzlIrBkAlNWTgei39C_qgaUw3sw8gkcAlNbk7JK2J
 Tfo8_8qQ4sfUBb4GvU>
X-ME-Received: <xmr:r8dfZuAtTz620DoE75TWZxTWxVMgRHDw54VKpNTtHuR_oHo2D10yDfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgheegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:r8dfZoc0UXodej36BO70RzNmrMORBiC13PbFyfVYYjfh3V24_hGHqg>
 <xmx:r8dfZtNrfMQ3IjpLN7eC74K5F1pC6wBpEVxQZirXlJCUmVbTOIssng>
 <xmx:r8dfZikXRFOVWE2bae5EvoidUFc9aps1j9VEUphI8QM-F9PGDUMfZQ>
 <xmx:r8dfZvtDNvv3ro-x9wEYK2E4nPL_HSyU6bg5-O7wmSQS2B00vzuc7Q>
 <xmx:r8dfZg0vWGPPmazQtWYrnBj5a7BycdDDXnE1AQqbq4zvktwkg7RVDyVZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 22:04:30 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 05 Jun 2024 03:04:27 +0100
Subject: [PATCH v2 4/4] hw/intc/loongson_ipi: Replace ipi_getcpu with
 cpu_by_arch_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-loongson3-ipi-v2-4-da26282e03a5@flygoat.com>
References: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
In-Reply-To: <20240605-loongson3-ipi-v2-0-da26282e03a5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=1GSlxW6vjHxZTKXd3mA/53bv0nOkIChGbCQnRgdgOCg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrT446vebCu16L/huXvBvbm1Szj+2nR4lon2t/VMFVu15
 K/gwfnPOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiYeKMDLvNThacEv+4V/x3
 buGc45dPt+qI3l+xaGFmUGiB/SFx700Mfzhb/Twq2fj/vZTLVn9vEbhTXHvaYyO7Vyw3FGrFPPq
 fsQAA
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

Signed-off-by: jiaxun.yang@flygoat.com <Jiaxun Yang>
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



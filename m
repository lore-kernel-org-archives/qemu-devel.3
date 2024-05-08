Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E979C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0e-0007ub-0V; Wed, 08 May 2024 09:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0W-0007qD-75
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:53 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0U-0006Od-8V
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 95ECF11400A9;
 Wed,  8 May 2024 09:06:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 08 May 2024 09:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715173608;
 x=1715260008; bh=g5AGJQsCRBWM46vr8fanAwmhzs3usL3t2dVss5J1yqQ=; b=
 XDt1HkWKOYo40TcxP3MpY9za1/CtSkmGFDhoCgdGZqlN1d8RP9smgT6/+HBNIt6N
 UdhTNs3Djq4FLwaakQa9UIH2TxIrV0iTCwfvtUPD/1qbcLwpvnH+9xzJ6ja9D43/
 mxxzw7a3WmNP7zuEx2EUqYhKYLBwfViLqFzmvOq36LlE4UeUfHi926VN179J1UuF
 VXHbZ+55mSzJmRcqlGHAQXS36vdE7eomzDU1XuocdnDL2ycaSetX+DsQnawIq0p/
 4IF4Lcfa+wEONtbWceR3SZ1xKOngD8H5B8qYfOWaoPbXutki/2D15OY1PMJswTwX
 jutOtzeQH6kPbJrJz/G8Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715173608; x=
 1715260008; bh=g5AGJQsCRBWM46vr8fanAwmhzs3usL3t2dVss5J1yqQ=; b=X
 UBCXxx1vokAUF0nkwzgnT4TkoIu0MM3mOtqpK1dje46J3IfWoz+x37GR+DOnXo5v
 3dhPNR16FidtRiycZP5XazbCN3dThHeYzZ4w0XXQ0dqjvACSKaIoGbyd4vuwbiQ4
 jPrcFd5DISq73G4Lw3tzqQh83Q2EVFu7ImNHNrl6wr4IECu2XbRYfwJogbk5Izrb
 afdebnDdjOu0ARH276AGxAagquU385Nx+XJGKnLq628NU0cTHRUMQxdkRELqwTjp
 Dbg75ma6Alqz8u9AwGnt+bb56G9hzlG+8Re5b9ZL7iNSUCZ3slv6VQXenytW5SN+
 2Fn39xC1Tp9mUKqvFt/zQ==
X-ME-Sender: <xms:6Hg7ZrEeMHA--Zax6iP-W-d93ZCeSgZ7n_EwflP0k5NgQR6OVBMGSA>
 <xme:6Hg7ZoUzMhG3OgErkLIrL-sjiLozZli_Sx2P7FXEkF5w59XkDeI_4t51jhi6ia4vj
 CBGIqhcBbrXgz6pL38>
X-ME-Received: <xmr:6Hg7ZtLFpTjWwplkZlHEoPu36RfcGc-Wo20wlxstbFdvJH_A6YSaxjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:6Hg7ZpFSy8xb0Flm7uPequhAaew6DN8EhPB9Xs90MWM_FIMI6-d1tw>
 <xmx:6Hg7ZhUysPa06AY7r4uZN4SdB5HQmFw3dZ9jbMGaTikRo4lR13c5cQ>
 <xmx:6Hg7ZkPNRjjBIVzddyIdChkCOc72FJrz3CWSwEQnSRrCIqGS7Y6kXw>
 <xmx:6Hg7Zg0p8VgIX9s8n1t8sdiOwDR2PO-WZoXZv0omA58XTe6F8ofY7g>
 <xmx:6Hg7ZvcOUCdiSdKbAjz815hJM7eN-fESz8P7Nl50IuH78YR0YrSOLEo9>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:47 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 14:06:46 +0100
Subject: [PATCH 1/5] hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3-ipi-v1-1-1a7b67704664@flygoat.com>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yyui5VrB+HEHO5BEGR45OrgLwCnSb++bUDOf4iIbLDU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriudpEac2POuXYN8bdXRLUQpn+5FrM3OVHisY3vP7+
 87h6JyTHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRuP8M/3P+rSmXKWGPTve+
 zBW7RZm38vatjxoOOYwnz2omZU1Zc4Lhr9DCCSzF9/huOXjc2KZYpdmu4lUwY7V1VMC6jtaaRus
 afgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh5-smtp.messagingengine.com
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

Since cpuid will be checked by ipi_getcpu anyway, there is
no point to enforce MAX_CPU here.

This also saved us from including loongarch board header.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/loongarch_ipi.c | 19 ++-----------------
 hw/intc/trace-events    |  2 --
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index a184112b0923..44b3b9c138d6 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/irq.h"
@@ -13,9 +14,8 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "hw/loongarch/virt.h"
 #include "migration/vmstate.h"
-#include "target/loongarch/internals.h"
+#include "target/loongarch/cpu.h"
 #include "trace.h"
 
 static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
@@ -122,11 +122,6 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    if (cpuid >= LOONGARCH_MAX_CPUS) {
-        trace_loongarch_ipi_unsupported_cpuid("IOCSR_MAIL_SEND", cpuid);
-        return MEMTX_DECODE_ERROR;
-    }
-
     cs = ipi_getcpu(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
@@ -146,11 +141,6 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     CPUState *cs;
 
     cpuid = extract32(val, 16, 10);
-    if (cpuid >= LOONGARCH_MAX_CPUS) {
-        trace_loongarch_ipi_unsupported_cpuid("IOCSR_ANY_SEND", cpuid);
-        return MEMTX_DECODE_ERROR;
-    }
-
     cs = ipi_getcpu(cpuid);
     if (cs == NULL) {
         return MEMTX_DECODE_ERROR;
@@ -201,11 +191,6 @@ static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
         break;
     case IOCSR_IPI_SEND:
         cpuid = extract32(val, 16, 10);
-        if (cpuid >= LOONGARCH_MAX_CPUS) {
-            trace_loongarch_ipi_unsupported_cpuid("IOCSR_IPI_SEND", cpuid);
-            return MEMTX_DECODE_ERROR;
-        }
-
         /* IPI status vector */
         vector = extract8(val, 0, 5);
         cs = ipi_getcpu(cpuid);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 47340b5bc138..a979784f9bee 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -294,8 +294,6 @@ sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
 # loongarch_ipi.c
 loongarch_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 loongarch_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
-loongarch_ipi_unsupported_cpuid(const char *s, uint32_t cpuid) "%s unsupported cpuid 0x%" PRIx32
-
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
 loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64

-- 
2.34.1



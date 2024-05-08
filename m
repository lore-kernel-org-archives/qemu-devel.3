Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2997CC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h0j-00082g-Kd; Wed, 08 May 2024 09:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0Z-0007sG-AF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:55 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4h0W-0006PH-Fn
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:06:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id B5F2413803AC;
 Wed,  8 May 2024 09:06:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 08 May 2024 09:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715173611;
 x=1715260011; bh=r3KE5xPe5t7eDRCDbXrDYyqXlCCmkw3qv1ZUOLfcQBU=; b=
 sDEJPgMViRYHRTjgS/23HkelDE6u8P3h9vxMjwW3oi3u/bRsNhY3hERN3/7VDc0y
 4FpGK4WXM4NQ3zJ9mHj2o6Z2xs2wJOibUkY2LoqCE1Z13dKRGVEBrPjniCAFMNQa
 JYBzmTOsm2u4WZfkWLZuO45PHVAjxvtLWjStUJyMsykSmfBCeEWn0GWdev2K3h4I
 brdq3JHNYBlRiV+q1Qdur1StfsCASVjG3NGck9yz1M21ucEJDkmoNXvIq/6jsq7N
 +qHAStkMqNf1vo4KKt0De7xYos8m5ePDZ/gPy3WCuDh1/sfHQbKUEmsa7etiAayU
 5fXhS+KuSfPqk9AmzNJlWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715173611; x=
 1715260011; bh=r3KE5xPe5t7eDRCDbXrDYyqXlCCmkw3qv1ZUOLfcQBU=; b=Y
 g8rc4ert9a+Qt//8T/rru+30p2UZAYFF+eOD+1e68AUU+IAZkILy0ffM4ljHl0DE
 uW2Klskg5N2+Ep/3gOavuF45cpgJCr74x7rCn7/sLc5ZyhXoHnn+UMErI5hSRW3M
 +QzotPvaG8KBQ8ajjIaJGEYtVVl0GA5Q3MiunGy4Tw0LvpPCoAiCdf/lnadrblLg
 r7SKywb6F5uDiyaMk54G3TAgksafHfiNOrn7sDpPzSID0cqX+xk8YZtcco+80gdF
 RJB9DLVzUYL1vsAKiqHV+YRpEpysQ9SetPFCqf4Zh13s9idYq4SzaqhOBFpVfMwU
 tnAcMY6rxZupRgAcJzPoA==
X-ME-Sender: <xms:63g7ZteLJzhVzLOsCc6fQwbVuO3Sx4FOZs71DOpE2heW2ks7CCIGIQ>
 <xme:63g7ZrPQoxTpBIyd3OPeAtY3TfbOG3Wcd8P7Sjwzt0SLq8rJIyC4Kyx5WX3XObA0J
 s68B7ScMBDxbGZU3wU>
X-ME-Received: <xmr:63g7ZmgGpY32t3Am2uICxcWNIcEodRhLmEViVDrmupHQ_dTVmGBjBjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepleeiveejtdffffevheelhfdvjeffheeigeevvdejfeekteff
 teehgedvhedtvdeknecuffhomhgrihhnpehiohgtshhrrdgrshenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:63g7Zm-WyO-dVB-lfQn0nc42lbEXTQqk9oMkCh1esRDt1O24z9CloQ>
 <xmx:63g7ZpuLJ3zSCpeOUWa_dJCxoQZr0eUh6ZOmek_Fh-h_itN0m0hTnQ>
 <xmx:63g7ZlFPDgJ6a3OAREQfxuMxraEy3r74GRG6Za4Vo3NGXlgAmAHjaQ>
 <xmx:63g7ZgMdpIpXzAcquRUqXIW0WtENw17inm3id7n0Uz6h32IHTRkMQQ>
 <xmx:63g7ZnVsfgn4Iq5GeS5JNrYic9ncQOrSZi7k8EmBMbuFfQ9jATocY_qS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:06:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 14:06:48 +0100
Subject: [PATCH 3/5] hw/intc/loongson_ipi: Implement IOCSR address space
 for MIPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
In-Reply-To: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3718;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=PYbuGxcd6pEm0Ln8w/B+W6SOya2Obyp8DMZLrbncebg=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTriuc3mW5npLZ8fLlx5aeErPuaD+r/PLmhz/v+y4egM
 90vnRaUd5SyMIhxMMiKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBE7DgY/jvarr26I9X8Pk+p
 rUjSg0WapdOZ1l2Iezpz+ory+pYjv28wMlz+K710wcpfX+q4tr92TuxhTWZ0TpGNiZwuuv7wuUa
 3ORwA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout1-smtp.messagingengine.com
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

Implement IOCSR address space get functions for MIPS/Loongson CPUs.

For MIPS/Loongson without IOCSR (i.e. Loongson-3A1000), get_cpu_iocsr_as
will return as null, and send_ipi_data will fail with MEMTX_DECODE_ERROR,
which matches expected behavior on hardware.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
I understand that there was a review comment stating that I shouldn't
use TARGET_* macros in device drivers. But I still think this is the
best way to handle architectural difference. There are many TARGET_*
usages in hw/virtio for similiar purpose.
---
 hw/intc/loongson_ipi.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8c888da3b27c..93cc50a37a11 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -15,7 +15,12 @@
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "migration/vmstate.h"
+#ifdef TARGET_LOONGARCH64
 #include "target/loongarch/cpu.h"
+#endif
+#ifdef TARGET_MIPS
+#include "target/mips/cpu.h"
+#endif
 #include "trace.h"
 
 static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
@@ -56,18 +61,35 @@ static MemTxResult loongson_ipi_readl(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
-static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
+static AddressSpace *get_cpu_iocsr_as(CPUState *cpu)
+{
+#ifdef TARGET_LOONGARCH64
+    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
+#endif
+#ifdef TARGET_MIPS
+    if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
+        return &MIPS_CPU(cpu)->env.iocsr.as;
+    }
+#endif
+    return NULL;
+}
+
+static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
                           MemTxAttrs attrs)
 {
     int i, mask = 0, data = 0;
+    AddressSpace *iocsr_as = get_cpu_iocsr_as(cpu);
+
+    if (!iocsr_as) {
+        return MEMTX_DECODE_ERROR;
+    }
 
     /*
      * bit 27-30 is mask for byte writing,
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(env->address_space_iocsr, addr,
-                                 attrs, NULL);
+        data = address_space_ldl(iocsr_as, addr, attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -78,8 +100,9 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(env->address_space_iocsr, addr,
-                      data, attrs, NULL);
+    address_space_stl(iocsr_as, addr, data, attrs, NULL);
+
+    return MEMTX_OK;
 }
 
 static int archid_cmp(const void *a, const void *b)
@@ -130,8 +153,7 @@ static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
     attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
+    return send_ipi_data(cs, val, addr, attrs);
 }
 
 static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
@@ -149,8 +171,7 @@ static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
     /* override requester_id */
     addr = val & 0xffff;
     attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
+    return send_ipi_data(cs, val, addr, attrs);
 }
 
 static MemTxResult loongson_ipi_writel(void *opaque, hwaddr addr, uint64_t val,

-- 
2.34.1



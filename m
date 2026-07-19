Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA94C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBF-0007l6-9Z; Sun, 19 Jul 2026 12:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBB-0007jI-IM
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:49 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBA-0002Pq-3F
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:49 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 03ADE7A0097;
 Sun, 19 Jul 2026 12:15:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 12:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477746; x=
 1784564146; bh=9nuB8094LMtH1LjibVqjG4RDOw0IU7XdwLUG8GMKbdM=; b=Y
 sSSKDhVi/GcVan70fy5gVDC3KT/8yBAyJ0oratY4cMFisycBck0lVmkvB0cKGd4q
 Zfby/KmN54k4AopJSIq2vBwNeQX3+/MYZgIjtYAQvb/jEeFQT1l4tcC+j5tdaNWj
 qcLM6DCPIEy7GW0YkD+BUV/KgZijiMzMg91RjXFwhBPdlYVC5Aa4sqV4+MZzez/o
 2jwhOG2Y8EP/PjhJLLP6mJCwdImWYZm6Z/+0w1Bj1BxT6tVwiFqZ3S8lpj/YBFAN
 M0fVG8mKRXGyWorgcIQWzH8e3VrSagzL1zMbtCFnKNBmwbm2Pgh4fQ4p9YtTI1u/
 Zt6LAiZ4rFWFl/vGUz+Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477746; x=1784564146; bh=9
 nuB8094LMtH1LjibVqjG4RDOw0IU7XdwLUG8GMKbdM=; b=GeasKRLsLQLw9+0IJ
 kex+8PHj5BLMEtGy93leJs60b29mMoeURN3TXnDHl2cMJDA1BGF/b/XEEs0gnbfE
 lOo1bk/9BZJoUIGfmX7ttOqigNg0OsZM5Lp4KdTZ5a3de0zgedwaCJqzsKxkR2et
 fLG78Zigjf5eKbE5UhkyKz6e2w1ICQ66c3kIi7urxPTcdMtOqS4Cc2GZOGZISPfU
 ButfwSPoKQyiWPfX+GKO0Wy+L0+RBeQUgSmN4u1OP1oKlrDo9FIxy1T+26zjy2ZV
 VmfqHIyCLWRdXMamK6clNpNbRevGoBVZiFSON8dwqryLwTE5/VKNURhj17/Ck2lD
 5PfyA==
X-ME-Sender: <xms:MvhcaiRS1RVokJqIuFw36ufapqvmfq61Jzrn_2eRt8d-UlRo4mMbiQ>
 <xme:MvhcavNIopYyf1UxmPbmUXqnwE_nx_bPhxyZ2_HUOAmaXOMKlmv3HIXg6dCm6x3bJ
 hMATiswfMzBTJZsidDE-avrQzYijiSwlsbrbmiGjDXHp7N8UyEvyPz6>
X-ME-Received: <xmr:MvhcatNpJR8HA4vfdrRlJLExm7swRo5-NtknBrSihAy7VqZu2BqZaYqUFpo>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIZM
 Gq3OisFsc6EpCJFDU+EraLOMLnRXOFU+HEDL8dQx11KaZOkwrrHjXF7d3pA9dTCSBF+WAU
 yCu3WILrQ0WvGlqzNZ1k9zOi7oI6RFDCtVs1GMRvslrgm68rkUJS0E4yZiiw2VrrOoX9F3
 t0wJXZsERLjEhFzI0LxVBedeSlSDBPOI5wKfiIdjXNjB8ZHAVL7948xUBH5TUJwXU4ZJj+
 0ZoG/37m8YT0jH0pxJxTWQV5/zKm1kYQKIRSJtm6zTxm82eL0hNe6/t1g+Eai2SquBsN8W
 tRu5+NI1Jyv/v84ns3YSq9zaV0kzEYqJGuYHx62TOCAsJEdFnpeeIaANY+OA
X-ME-Proxy: <xmx:MvhcanskUFGHbmw2Mumiogarl2mfXAoL4etMLdx3Bz5LM1C7Ej5Kkg>
 <xmx:MvhcavWFq1Xiafb9lez0fxI_0xV0q92ju06JX9Ip0fOLmXOF0oQl7g>
 <xmx:Mvhcanuoz5JJhh7gQRi2qmMVZ0_JuY6UFgdGgQET5bd_cDSPb9p4nw>
 <xmx:MvhcajVIAH1w6ZgqtYWrlAQhwXPhzUDydqp7xPtjlhqyAiLQf6zwwg>
 <xmx:MvhcapaSZXn5pZ55x1S6IE4CenvdUgEMLi0QB5CUMxpwuCo43WKrMAqa>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:46 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 03405d9f;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 8/9] ati-vga: CP engine indirect buffer
Date: Sun, 19 Jul 2026 12:15:35 -0400
Message-ID: <20260719161536.774061-9-chad@jablonski.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260719161536.774061-1-chad@jablonski.xyz>
References: <20260719161536.774061-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Xorg acceleration (XAA) makes use of the indirect buffer for 2D
operations. Instead of writing packets directly to the ring buffer, they
are written to indirect buffers and then referenced by a small packet on
the ring.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 22 ++++++++++++++++++++++
 hw/display/ati_int.h  |  2 ++
 hw/display/ati_regs.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d758e652b5..0c550599cc 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -623,6 +623,12 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case CP_RB_WPTR:
         val = s->regs.cp_rb_wptr;
         break;
+    case CP_IB_BASE:
+        val = s->regs.cp_ib_base;
+        break;
+    case CP_IB_BUFSZ:
+        val = s->regs.cp_ib_bufsz;
+        break;
     default:
         break;
     }
@@ -1175,6 +1181,22 @@ void ati_mm_write(void *opaque, hwaddr addr,
         }
         break;
     }
+    case CP_IB_BASE:
+        s->regs.cp_ib_base = data & 0xfffffffc;
+        break;
+    case CP_IB_BUFSZ: {
+        uint32_t bufsz = data & 0x007fffff;
+        uint32_t base = s->regs.cp_ib_base;
+        ATIPktState ib_pkt = {0};
+        uint32_t dwords = 0;
+        s->regs.cp_ib_bufsz = bufsz;
+        while (dwords < bufsz) {
+            uint32_t offs = base + dwords * sizeof(uint32_t);
+            ati_pkt_receive_data(s, &ib_pkt, ati_mc_read(s, offs));
+            dwords += 1;
+        }
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 00fb03c4b4..df08b6ae01 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -129,6 +129,8 @@ typedef struct ATIVGARegs {
     uint32_t cp_rb_cntl;
     uint32_t cp_rb_rptr;
     uint32_t cp_rb_wptr;
+    uint32_t cp_ib_base;
+    uint32_t cp_ib_bufsz;
 } ATIVGARegs;
 
 typedef struct ATIHostDataState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 755b9656b1..e8e1b90374 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -134,7 +134,9 @@
 #define PM4_VC_VLOFF                            0x0730
 #define PM4_VC_VLSIZE                           0x0734
 #define PM4_IW_INDOFF                           0x0738
+#define CP_IB_BASE                              0x0738
 #define PM4_IW_INDSIZE                          0x073c
+#define CP_IB_BUFSZ                             0x073c
 #define PM4_FPU_FPX0                            0x0740
 #define CP_CSQ_CNTL                             0x0740
 #define PM4_FPU_FPY0                            0x0744
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884DEC4451B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlUBF-0007l4-7H; Sun, 19 Jul 2026 12:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUBA-0007j2-OC
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:48 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wlUB9-0002Pf-00
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 12:15:48 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 489177A0098;
 Sun, 19 Jul 2026 12:15:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sun, 19 Jul 2026 12:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784477746; x=
 1784564146; bh=HWb35YkY/8g06RTKPli1Lm3ckz8PxQcr8AtNlo0k3Do=; b=C
 7xVMRkZUcaupDCGciGlT0j+oDOHAOdFlTHwPbaoPTSoZm3n3QmoxOudWvXRnZjVj
 q7oSgjCwgouPMImbivz076D0PAIgw8ju57fmRBqKtq8/eRsKzBIREDEal4h6wHn8
 pBiAsbIXNMWTpTqNthUIlS56G7OtBdT+8VoS0vFbuzTHiYV5GxSttw89MeStFx4x
 dJu6R6E4ayKYkbv2NI2gw/C/Y1HjD9+3E1GWAAR53HN8MAlYcTyXf19iR4qNxPja
 n4aaaorG8K5eMvs+od+pDVhtQwFUpZq2kkvQZKBHF8TjrqgkocTyz+VIicMj62Ey
 4yW4S2XVDUd98R7thxrTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784477746; x=1784564146; bh=H
 Wb35YkY/8g06RTKPli1Lm3ckz8PxQcr8AtNlo0k3Do=; b=gDVzgv+EfVQVSvaJv
 xt4yVWAb6Azxd1HbtBm9hY638AgMGvOsr+pgU+f6yXKSbIEsaU7EvjUJDdzwePpG
 kktypFOlcjoHBHDcRGY2cl+84YTwqFWbadUya+GCkv7LQGriNVoJOaSsSRkqqQB3
 8mfGUDyfIpz4TZwEn+3T8dBD7RqDavXLSNRt1iSE7z/Nt+DqaapTX7ZhRdm97lMX
 lskSTJPDnG5/vPRsgy3iMjlQoRU4SaLGnHr+8T3CN/U5Xux9Y54eSQs+Ez/UTrom
 ZerrHkZCnp88N6GAl3+UwVjTsW5+kM2GEbo6q/vg/tiR/YOEjw9fXYEr5xF17Cij
 5zsdQ==
X-ME-Sender: <xms:Mvhcarz4ERHZnWLjnkonvDO0wBYMJZ348mfjJR-S0mqakBvceMxIdw>
 <xme:MvhcaqvHQXH4DXEo88s0Zk2Gf-tC1HBzct4-zb3e-XGghdyA1fSFT5s55UWnypSCG
 aU50kMGd-xLs4eFhCPHq995am9PWumb5WEZLH_sbLLYiX20zWAneSM>
X-ME-Received: <xmr:Mvhcaiuuh-JM6YqXGv3deZHb_wTOZ_P2iwWB-g7Qe-8UQi4fF_kdFSLeCIM>
X-ME-Proxy-Cause: dmFkZTFX22WwMbS2sW99eCB50G1QKT6MSqCpx6iK5itrq8JxZaP0521f6QSaZn8xZ08MPO
 fOwSNa6WDSeLTJNQVc/fxMSGvDLkf+yg/0G9Q09ZIOYGIXIBd2hVswgLVRGFoWlNQkKsDF
 GdNkKsfijsKMESGF+IJc7XNHY6Tof4qnJ8h5MKF7zpjgYI3Er1oT6Sc3p82wEBVA4tVY6K
 sm0munSEzPQOSr/py3N0SGFxIhaHx4yY0PMKs1GFt63biT3SGPXDCwnyEFOs/p40onWKAs
 7IByVaX4T1Xvhqors54F3a+bmhyr13Lneen+jWeanFhb1s0umv08sceX1eK90gcHhjDIjR
 Nrttgw8Cj9xIOr9Yt6qtxvxfVnCDAuIO9v69KQ2rzmO1ZDHnhdRlmiKiHdmH2kkCFSIz5n
 Gx3Llmx6R1mkmWDRiSoJHT/R4PCiKZHFXhGvxCP0jrW6pE0sTMWwTyDy56FEpjp1grCTps
 1NuZhx5hjfaGzVMAjRE0hzNd4zYCqGQ+6mpsW43zuQI1HVd2bYd095LSNctVIQfFOptjvO
 sGzFp7af7Wlr1dEGaFydbrhcb6QQk/vsPlmbMY5kdVwK31FnzXtjVP30I1qlnBw2Nh8fWd
 0RoHDZH3qC9TYDbdYedtMGzHUXh/NGCKVDLp3g2jN/B7kRw7Bx9Awa+bx5cg
X-ME-Proxy: <xmx:MvhcavNNrhwIq7nwLNKVESfLz9lw0GnzaI-PSooF6erC8aBPuEBXMQ>
 <xmx:Mvhcag3-pNBbjoAw94fRebKMof-aCcCf401eida_-pwmY5g9Bg1d6w>
 <xmx:MvhcarNaDZf93cS_N9Sx4KkXK02JK1YTzh3xHGJdAMahNacPfApkng>
 <xmx:Mvhcag16A5W-0KcktgA_9qkOmyR1MCf0kqFU8E1L45O_BcFaXwi4IA>
 <xmx:Mvhcao63GQqTnZ-QhToj3fmfGt-cFVUkecssDT6E8Osbvp1UPakg3AHf>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 12:15:45 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 0f942022;
 Sun, 19 Jul 2026 16:15:40 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH 7/9] ati-vga: CP engine ring buffer
Date: Sun, 19 Jul 2026 12:15:34 -0400
Message-ID: <20260719161536.774061-8-chad@jablonski.xyz>
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

Drivers for the r100 submit packets using the ring buffer. The real
CP engine operates asynchronously. This is a synchronous implementation
of it. Packet processing is triggered by a write to CP_RB_WPTR and
proceeds until the buffer has been emptied.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 50 +++++++++++++++++++++++++++++++++++++++++++
 hw/display/ati_int.h  |  5 +++++
 hw/display/ati_regs.h |  5 +++++
 3 files changed, 60 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index ad32965866..d758e652b5 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -606,6 +606,23 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case MC_FB_LOCATION:
         val = s->regs.mc_fb_location;
         break;
+    case CP_CSQ_CNTL:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
+            val = s->regs.cp_csq_cntl;
+        }
+        break;
+    case CP_RB_BASE:
+        val = s->regs.cp_rb_base;
+        break;
+    case CP_RB_CNTL:
+        val = s->regs.cp_rb_cntl;
+        break;
+    case CP_RB_RPTR:
+        val = s->regs.cp_rb_rptr;
+        break;
+    case CP_RB_WPTR:
+        val = s->regs.cp_rb_wptr;
+        break;
     default:
         break;
     }
@@ -1129,6 +1146,35 @@ void ati_mm_write(void *opaque, hwaddr addr,
          */
         s->regs.mc_fb_location = (data & 0xffc0ffc0) | 0x003f0000;
         break;
+    case CP_CSQ_CNTL:
+        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_QY) {
+            s->regs.cp_csq_cntl = data & 0xf0000000;
+        }
+        break;
+    case CP_RB_BASE:
+        s->regs.cp_rb_base = data & 0xfffffffc;
+        break;
+    case CP_RB_CNTL:
+        s->regs.cp_rb_cntl = data & 0x880f3f3f;
+        break;
+    case CP_RB_WPTR:
+    {
+        uint32_t size_l2qw = s->regs.cp_rb_cntl & 0x3f;
+        /*
+         * RPTR and WPTR are only 23 bits wide, sizes larger
+         * than this make no sense.
+         */
+        unsigned shift = size_l2qw > 22 ? 23 : size_l2qw + 1;
+        uint32_t size_msk = (1U << shift) - 1;
+        s->regs.cp_rb_wptr = data & size_msk;
+        while (s->regs.cp_rb_rptr != s->regs.cp_rb_wptr) {
+            uint32_t offs = s->regs.cp_rb_base +
+                            s->regs.cp_rb_rptr * sizeof(uint32_t);
+            ati_pkt_receive_data(s, &s->cur_packet, ati_mc_read(s, offs));
+            s->regs.cp_rb_rptr = (s->regs.cp_rb_rptr + 1) & size_msk;
+        }
+        break;
+    }
     default:
         break;
     }
@@ -1251,6 +1297,10 @@ static void ati_vga_reset(DeviceState *dev)
     s->host_data.next = 0;
     s->host_data.row = 0;
     s->host_data.col = 0;
+    s->regs.cp_rb_rptr = 0;
+    s->regs.cp_rb_wptr = 0;
+    s->regs.cp_rb_base = 0;
+    s->regs.cp_rb_cntl = 0;
     memset(&s->cur_packet, 0, sizeof(s->cur_packet));
 }
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index bbc360b636..00fb03c4b4 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -124,6 +124,11 @@ typedef struct ATIVGARegs {
     uint32_t aic_lo_addr;
     uint32_t aic_hi_addr;
     uint32_t mc_fb_location;
+    uint32_t cp_csq_cntl;
+    uint32_t cp_rb_base;
+    uint32_t cp_rb_cntl;
+    uint32_t cp_rb_rptr;
+    uint32_t cp_rb_wptr;
 } ATIVGARegs;
 
 typedef struct ATIHostDataState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 5e9396bd7a..755b9656b1 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -117,11 +117,15 @@
 #define OV0_SCALE_CNTL                          0x0420
 #define SUBPIC_CNTL                             0x0540
 #define PM4_BUFFER_OFFSET                       0x0700
+#define CP_RB_BASE                              0x0700
 #define PM4_BUFFER_CNTL                         0x0704
+#define CP_RB_CNTL                              0x0704
 #define PM4_BUFFER_WM_CNTL                      0x0708
 #define PM4_BUFFER_DL_RPTR_ADDR                 0x070c
 #define PM4_BUFFER_DL_RPTR                      0x0710
+#define CP_RB_RPTR                              0x0710
 #define PM4_BUFFER_DL_WPTR                      0x0714
+#define CP_RB_WPTR                              0x0714
 #define PM4_VC_FPU_SETUP                        0x071c
 #define PM4_FPU_CNTL                            0x0720
 #define PM4_VC_FORMAT                           0x0724
@@ -132,6 +136,7 @@
 #define PM4_IW_INDOFF                           0x0738
 #define PM4_IW_INDSIZE                          0x073c
 #define PM4_FPU_FPX0                            0x0740
+#define CP_CSQ_CNTL                             0x0740
 #define PM4_FPU_FPY0                            0x0744
 #define PM4_FPU_FPX1                            0x0748
 #define PM4_FPU_FPY1                            0x074c
-- 
2.54.0



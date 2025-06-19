Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E0DC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSLxc-0004cT-0h; Thu, 19 Jun 2025 16:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxY-0004bT-Aa
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSLxS-0004Ye-G6
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750365240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0psjyOIJ8t+sVmPA16Jc6dLmv441phUHEvX7zxJTbc=;
 b=ZHEHnD62agNvTG+1aeZ06wWU85akeZAJNqBccsQGlXTzbqRHYZgCV+vpCIAqhNNy57gpaT
 eUNn3UdUBro96cHcqruLrNNGaxFoNTLivTGIk4+4T9ICIdqVPN5y95PB9GqwLvv1KznjsV
 0NPWNXLUZLTnzO08jGW8SBizaLUCCCc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-UX0KPKWgPHWAEmtkbEmSuA-1; Thu, 19 Jun 2025 16:33:59 -0400
X-MC-Unique: UX0KPKWgPHWAEmtkbEmSuA-1
X-Mimecast-MFC-AGG-ID: UX0KPKWgPHWAEmtkbEmSuA_1750365238
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6097b0f5aceso1077629a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365237; x=1750970037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0psjyOIJ8t+sVmPA16Jc6dLmv441phUHEvX7zxJTbc=;
 b=t7mK7nh/vQA2g+unh54gajD6Zsa3tAboPOtuz0gSUHcQwah8YMulXrTaP3Hg41WVDv
 Mx+4VfQ2jECnspgft7yb95JhoPB0kw4yTVTVmyWbbs4/zeayC1E4uH+dT3Zf1aZK0qUh
 FTJNLyNA4HxvFMFiIH4jSl0f3+oQZycTzASYHRmuaRgRO3T1mKwNlhU/ZtDDrcEHOLGS
 iFVeph9nU6tMg27N2M6RTCfC52YO8hRfST8nLKwSMyXWTb997rsqv/rIVFXIPHHWDG4l
 P+n8/PVNwEXTDxv0UY4SJ2k1yXsekhqZQI+NOxeQTFGht1Qg+JVdzWFls12eaxMJJ/MV
 DfZQ==
X-Gm-Message-State: AOJu0Yz1T/DKQOg8UMUA+DU+Crl/ITSbrelqV8vlQFXQm0kjvCvwo9PD
 oZm0KpkmUA2bnABUVsa3VWx2oPNNbqWo403fnqpjtZCfpDaXCMq6zFKBO3+oIxyCJ1OsDIn3Rk4
 aAlNPUHASBBBv9ZCGr6xFgpugydZ04CBSYk3bB5pu937krWVtHY9nUQp6QzPwsfMg8q2RoOppWj
 PX6w+2fvn5rNM5eZdT81/TRRXFMyz9iiuCTHwoCFzE
X-Gm-Gg: ASbGncv27DNrIDzM/XeX7YgoA1C6S1garfW4LY2CzCeCIr7m+g1LmsjqAqhJK6Tt64+
 CcAZNk5I/jyxur+NNpuXn8bZqiLR8c4gm9iuVC7XmDSncsdwS9ivzGFikKMeYivbw+6kl0Pgj3c
 aDTHPen+Whq/y8se3UOniz8LUd8h+5c217FE0+ApJ4k9FIPEanzppoNtBKihbSf34TUJY7rYXYp
 He3zQEsnc9CDEQUA4XeJHKA2enIOUVSeYEsJp31wszQvSb7dtKH4T0wrsI2e2jHpxb13qcKJrl1
 2Jc1sLuzYMJk3bBjTo7Mp844JA==
X-Received: by 2002:a17:907:bd83:b0:ad5:557b:c369 with SMTP id
 a640c23a62f3a-ae057b6e6e3mr26193666b.33.1750365237335; 
 Thu, 19 Jun 2025 13:33:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgT0UpzulbXGh5C4cvwBhNKfG7zAr/qWj+qekC+piIVm74cRY7EUxmnX4DRciV4jypdEcRNw==
X-Received: by 2002:a17:907:bd83:b0:ad5:557b:c369 with SMTP id
 a640c23a62f3a-ae057b6e6e3mr26190966b.33.1750365236738; 
 Thu, 19 Jun 2025 13:33:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7d1e8sm42893566b.5.2025.06.19.13.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 13:33:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/3] update Linux headers to v6.16-rc3
Date: Thu, 19 Jun 2025 22:33:49 +0200
Message-ID: <20250619203351.393786-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619203351.393786-1-pbonzini@redhat.com>
References: <20250619203351.393786-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/standard-headers/asm-x86/setup_data.h |  13 +-
 include/standard-headers/drm/drm_fourcc.h     |  45 +++++++
 include/standard-headers/linux/ethtool.h      | 124 +++++++++---------
 include/standard-headers/linux/fuse.h         |   6 +-
 .../linux/input-event-codes.h                 |   3 +-
 include/standard-headers/linux/pci_regs.h     |  12 +-
 include/standard-headers/linux/virtio_gpu.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/linux/bits.h                    |   4 +-
 linux-headers/linux/kvm.h                     |  25 ++++
 linux-headers/linux/vhost.h                   |   4 +-
 13 files changed, 177 insertions(+), 73 deletions(-)

diff --git a/include/standard-headers/asm-x86/setup_data.h b/include/standard-headers/asm-x86/setup_data.h
index a483d72f428..2e446c1d858 100644
--- a/include/standard-headers/asm-x86/setup_data.h
+++ b/include/standard-headers/asm-x86/setup_data.h
@@ -13,7 +13,8 @@
 #define SETUP_CC_BLOB			7
 #define SETUP_IMA			8
 #define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+#define SETUP_KEXEC_KHO			10
+#define SETUP_ENUM_MAX			SETUP_KEXEC_KHO
 
 #define SETUP_INDIRECT			(1<<31)
 #define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
@@ -78,6 +79,16 @@ struct ima_setup_data {
 	uint64_t size;
 } QEMU_PACKED;
 
+/*
+ * Locations of kexec handover metadata
+ */
+struct kho_data {
+	uint64_t fdt_addr;
+	uint64_t fdt_size;
+	uint64_t scratch_addr;
+	uint64_t scratch_size;
+} QEMU_PACKED;
+
 #endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_DATA_H */
diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index a8b759dcbc8..c8309d378bf 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -421,6 +421,7 @@ extern "C" {
 #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
 #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
 #define DRM_FORMAT_MOD_VENDOR_MTK     0x0b
+#define DRM_FORMAT_MOD_VENDOR_APPLE   0x0c
 
 /* add more to the end as needed */
 
@@ -1493,6 +1494,50 @@ drm_fourcc_canonicalize_nvidia_format_mod(uint64_t modifier)
 /* alias for the most common tiling format */
 #define DRM_FORMAT_MOD_MTK_16L_32S_TILE  DRM_FORMAT_MOD_MTK(MTK_FMT_MOD_TILE_16L32S)
 
+/*
+ * Apple GPU-tiled layouts.
+ *
+ * Apple GPUs support nonlinear tilings with optional lossless compression.
+ *
+ * GPU-tiled images are divided into 16KiB tiles:
+ *
+ *     Bytes per pixel  Tile size
+ *     ---------------  ---------
+ *                   1  128x128
+ *                   2  128x64
+ *                   4  64x64
+ *                   8  64x32
+ *                  16  32x32
+ *
+ * Tiles are raster-order. Pixels within a tile are interleaved (Morton order).
+ *
+ * Compressed images pad the body to 128-bytes and are immediately followed by a
+ * metadata section. The metadata section rounds the image dimensions to
+ * powers-of-two and contains 8 bytes for each 16x16 compression subtile.
+ * Subtiles are interleaved (Morton order).
+ *
+ * All images are 128-byte aligned.
+ *
+ * These layouts fundamentally do not have meaningful strides. No matter how we
+ * specify strides for these layouts, userspace unaware of Apple image layouts
+ * will be unable to use correctly the specified stride for any purpose.
+ * Userspace aware of the image layouts do not use strides. The most "correct"
+ * convention would be setting the image stride to 0. Unfortunately, some
+ * software assumes the stride is at least (width * bytes per pixel). We
+ * therefore require that stride equals (width * bytes per pixel). Since the
+ * stride is arbitrary here, we pick the simplest convention.
+ *
+ * Although containing two sections, compressed image layouts are treated in
+ * software as a single plane. This is modelled after AFBC, a similar
+ * scheme. Attempting to separate the sections to be "explicit" in DRM would
+ * only generate more confusion, as software does not treat the image this way.
+ *
+ * For detailed information on the hardware image layouts, see
+ * https://docs.mesa3d.org/drivers/asahi.html#image-layouts
+ */
+#define DRM_FORMAT_MOD_APPLE_GPU_TILED fourcc_mod_code(APPLE, 1)
+#define DRM_FORMAT_MOD_APPLE_GPU_TILED_COMPRESSED fourcc_mod_code(APPLE, 2)
+
 /*
  * AMD modifiers
  *
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 5d1ad5fdeab..cef0d207a62 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -2295,71 +2295,75 @@ static inline int ethtool_validate_duplex(uint8_t duplex)
 #define	RXH_XFRM_SYM_OR_XOR	(1 << 1)
 #define	RXH_XFRM_NO_CHANGE	0xff
 
-/* L2-L4 network traffic flow types */
-#define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
-#define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
-#define	SCTP_V4_FLOW	0x03	/* hash or spec (sctp_ip4_spec) */
-#define	AH_ESP_V4_FLOW	0x04	/* hash only */
-#define	TCP_V6_FLOW	0x05	/* hash or spec (tcp_ip6_spec; nfc only) */
-#define	UDP_V6_FLOW	0x06	/* hash or spec (udp_ip6_spec; nfc only) */
-#define	SCTP_V6_FLOW	0x07	/* hash or spec (sctp_ip6_spec; nfc only) */
-#define	AH_ESP_V6_FLOW	0x08	/* hash only */
-#define	AH_V4_FLOW	0x09	/* hash or spec (ah_ip4_spec) */
-#define	ESP_V4_FLOW	0x0a	/* hash or spec (esp_ip4_spec) */
-#define	AH_V6_FLOW	0x0b	/* hash or spec (ah_ip6_spec; nfc only) */
-#define	ESP_V6_FLOW	0x0c	/* hash or spec (esp_ip6_spec; nfc only) */
-#define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
-#define	IP_USER_FLOW	IPV4_USER_FLOW
-#define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
-#define	IPV4_FLOW	0x10	/* hash only */
-#define	IPV6_FLOW	0x11	/* hash only */
-#define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
+enum {
+	/* L2-L4 network traffic flow types */
+	TCP_V4_FLOW	= 0x01,	/* hash or spec (tcp_ip4_spec) */
+	UDP_V4_FLOW	= 0x02,	/* hash or spec (udp_ip4_spec) */
+	SCTP_V4_FLOW	= 0x03,	/* hash or spec (sctp_ip4_spec) */
+	AH_ESP_V4_FLOW	= 0x04,	/* hash only */
+	TCP_V6_FLOW	= 0x05,	/* hash or spec (tcp_ip6_spec; nfc only) */
+	UDP_V6_FLOW	= 0x06,	/* hash or spec (udp_ip6_spec; nfc only) */
+	SCTP_V6_FLOW	= 0x07,	/* hash or spec (sctp_ip6_spec; nfc only) */
+	AH_ESP_V6_FLOW	= 0x08,	/* hash only */
+	AH_V4_FLOW	= 0x09,	/* hash or spec (ah_ip4_spec) */
+	ESP_V4_FLOW	= 0x0a,	/* hash or spec (esp_ip4_spec) */
+	AH_V6_FLOW	= 0x0b,	/* hash or spec (ah_ip6_spec; nfc only) */
+	ESP_V6_FLOW	= 0x0c,	/* hash or spec (esp_ip6_spec; nfc only) */
+	IPV4_USER_FLOW	= 0x0d,	/* spec only (usr_ip4_spec) */
+	IP_USER_FLOW	= IPV4_USER_FLOW,
+	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
+	IPV4_FLOW	= 0x10, /* hash only */
+	IPV6_FLOW	= 0x11, /* hash only */
+	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
 
-/* Used for GTP-U IPv4 and IPv6.
- * The format of GTP packets only includes
- * elements such as TEID and GTP version.
- * It is primarily intended for data communication of the UE.
- */
-#define GTPU_V4_FLOW 0x13	/* hash only */
-#define GTPU_V6_FLOW 0x14	/* hash only */
+	/* Used for GTP-U IPv4 and IPv6.
+	 * The format of GTP packets only includes
+	 * elements such as TEID and GTP version.
+	 * It is primarily intended for data communication of the UE.
+	 */
+	GTPU_V4_FLOW	= 0x13,	/* hash only */
+	GTPU_V6_FLOW	= 0x14,	/* hash only */
 
-/* Use for GTP-C IPv4 and v6.
- * The format of these GTP packets does not include TEID.
- * Primarily expected to be used for communication
- * to create sessions for UE data communication,
- * commonly referred to as CSR (Create Session Request).
- */
-#define GTPC_V4_FLOW 0x15	/* hash only */
-#define GTPC_V6_FLOW 0x16	/* hash only */
+	/* Use for GTP-C IPv4 and v6.
+	 * The format of these GTP packets does not include TEID.
+	 * Primarily expected to be used for communication
+	 * to create sessions for UE data communication,
+	 * commonly referred to as CSR (Create Session Request).
+	 */
+	GTPC_V4_FLOW	= 0x15,	/* hash only */
+	GTPC_V6_FLOW	= 0x16,	/* hash only */
 
-/* Use for GTP-C IPv4 and v6.
- * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
- * After session creation, it becomes this packet.
- * This is mainly used for requests to realize UE handover.
- */
-#define GTPC_TEID_V4_FLOW 0x17	/* hash only */
-#define GTPC_TEID_V6_FLOW 0x18	/* hash only */
+	/* Use for GTP-C IPv4 and v6.
+	 * Unlike GTPC_V4_FLOW, the format of these GTP packets includes TEID.
+	 * After session creation, it becomes this packet.
+	 * This is mainly used for requests to realize UE handover.
+	 */
+	GTPC_TEID_V4_FLOW	= 0x17,	/* hash only */
+	GTPC_TEID_V6_FLOW	= 0x18,	/* hash only */
 
-/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
- * The format of these GTP packets includes TEID and QFI.
- * In 5G communication using UPF (User Plane Function),
- * data communication with this extended header is performed.
- */
-#define GTPU_EH_V4_FLOW 0x19	/* hash only */
-#define GTPU_EH_V6_FLOW 0x1a	/* hash only */
+	/* Use for GTP-U and extended headers for the PSC (PDU Session Container).
+	 * The format of these GTP packets includes TEID and QFI.
+	 * In 5G communication using UPF (User Plane Function),
+	 * data communication with this extended header is performed.
+	 */
+	GTPU_EH_V4_FLOW	= 0x19,	/* hash only */
+	GTPU_EH_V6_FLOW	= 0x1a,	/* hash only */
 
-/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
- * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
- * UL/DL included in the PSC.
- * There are differences in the data included based on Downlink/Uplink,
- * and can be used to distinguish packets.
- * The functions described so far are useful when you want to
- * handle communication from the mobile network in UPF, PGW, etc.
- */
-#define GTPU_UL_V4_FLOW 0x1b	/* hash only */
-#define GTPU_UL_V6_FLOW 0x1c	/* hash only */
-#define GTPU_DL_V4_FLOW 0x1d	/* hash only */
-#define GTPU_DL_V6_FLOW 0x1e	/* hash only */
+	/* Use for GTP-U IPv4 and v6 PSC (PDU Session Container) extended headers.
+	 * This differs from GTPU_EH_V(4|6)_FLOW in that it is distinguished by
+	 * UL/DL included in the PSC.
+	 * There are differences in the data included based on Downlink/Uplink,
+	 * and can be used to distinguish packets.
+	 * The functions described so far are useful when you want to
+	 * handle communication from the mobile network in UPF, PGW, etc.
+	 */
+	GTPU_UL_V4_FLOW	= 0x1b,	/* hash only */
+	GTPU_UL_V6_FLOW	= 0x1c,	/* hash only */
+	GTPU_DL_V4_FLOW	= 0x1d,	/* hash only */
+	GTPU_DL_V6_FLOW	= 0x1e,	/* hash only */
+
+	__FLOW_TYPE_COUNT,
+};
 
 /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
 #define	FLOW_EXT	0x80000000
diff --git a/include/standard-headers/linux/fuse.h b/include/standard-headers/linux/fuse.h
index a2b5815d890..d8b2fd67e16 100644
--- a/include/standard-headers/linux/fuse.h
+++ b/include/standard-headers/linux/fuse.h
@@ -232,6 +232,9 @@
  *
  *  7.43
  *  - add FUSE_REQUEST_TIMEOUT
+ *
+ *  7.44
+ *  - add FUSE_NOTIFY_INC_EPOCH
  */
 
 #ifndef _LINUX_FUSE_H
@@ -263,7 +266,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 43
+#define FUSE_KERNEL_MINOR_VERSION 44
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -667,6 +670,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE = 5,
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
+	FUSE_NOTIFY_INC_EPOCH = 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
 
diff --git a/include/standard-headers/linux/input-event-codes.h b/include/standard-headers/linux/input-event-codes.h
index 09ba0ad8783..a82ff795e06 100644
--- a/include/standard-headers/linux/input-event-codes.h
+++ b/include/standard-headers/linux/input-event-codes.h
@@ -925,7 +925,8 @@
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
 #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
 #define SW_MACHINE_COVER	0x10  /* set = cover closed */
-#define SW_MAX_			0x10
+#define SW_USB_INSERT		0x11  /* set = USB audio device connected */
+#define SW_MAX_			0x11
 #define SW_CNT			(SW_MAX_+1)
 
 /*
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index ba326710f9c..a3a3e942ded 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -750,7 +750,8 @@
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
+#define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1144,12 +1145,21 @@
 #define PCI_DLF_CAP		0x04	/* Capabilities Register */
 #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
 
+/* Secondary PCIe Capability 8.0 GT/s */
+#define PCI_SECPCI_LE_CTRL	0x0c /* Lane Equalization Control Register */
+
 /* Physical Layer 16.0 GT/s */
 #define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 #define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Physical Layer 32.0 GT/s */
+#define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
+
+/* Physical Layer 64.0 GT/s */
+#define PCI_PL_64GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
+
 /* Native PCIe Enclosure Management */
 #define PCI_NPEM_CAP     0x04 /* NPEM capability register */
 #define  PCI_NPEM_CAP_CAPABLE     0x00000001 /* NPEM Capable */
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 6459fdb9fb5..00cd3f04af9 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -309,8 +309,9 @@ struct virtio_gpu_cmd_submit {
 
 #define VIRTIO_GPU_CAPSET_VIRGL 1
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
-/* 3 is reserved for gfxstream */
+#define VIRTIO_GPU_CAPSET_GFXSTREAM_VULKAN 3
 #define VIRTIO_GPU_CAPSET_VENUS 4
+#define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
 #define VIRTIO_GPU_CAPSET_DRM 6
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 91fec6f5029..09e964e6eee 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -246,6 +246,7 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_ADMIN_CMD_LIST_USE	0x1
 
 /* Admin command group type. */
+#define VIRTIO_ADMIN_GROUP_TYPE_SELF	0x0
 #define VIRTIO_ADMIN_GROUP_TYPE_SRIOV	0x1
 
 /* Transitional device admin command. */
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 4e6aff08df8..f4d9baafa1c 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -419,10 +419,11 @@ enum {
 
 /* Device Control API on vcpu fd */
 #define KVM_ARM_VCPU_PMU_V3_CTRL	0
-#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
-#define   KVM_ARM_VCPU_PMU_V3_INIT	1
-#define   KVM_ARM_VCPU_PMU_V3_FILTER	2
-#define   KVM_ARM_VCPU_PMU_V3_SET_PMU	3
+#define   KVM_ARM_VCPU_PMU_V3_IRQ		0
+#define   KVM_ARM_VCPU_PMU_V3_INIT		1
+#define   KVM_ARM_VCPU_PMU_V3_FILTER		2
+#define   KVM_ARM_VCPU_PMU_V3_SET_PMU		3
+#define   KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS	4
 #define KVM_ARM_VCPU_TIMER_CTRL		1
 #define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 7fb57ccb2a7..cd275ae76d2 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -843,6 +843,7 @@ struct kvm_sev_snp_launch_start {
 };
 
 /* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_PAGE_TYPE_INVALID		0x0
 #define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
 #define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
 #define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
diff --git a/linux-headers/linux/bits.h b/linux-headers/linux/bits.h
index 58596d18f43..9243f389751 100644
--- a/linux-headers/linux/bits.h
+++ b/linux-headers/linux/bits.h
@@ -4,9 +4,9 @@
 #ifndef _LINUX_BITS_H
 #define _LINUX_BITS_H
 
-#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
 
-#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
 	((_BIT128((h)) << 1) - (_BIT128(l)))
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 99cc82a275c..0690743944b 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_TDX              40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -439,6 +440,27 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_TDX */
+		struct {
+			__u64 flags;
+			__u64 nr;
+			union {
+				struct {
+					__u64 ret;
+					__u64 data[5];
+				} unknown;
+				struct {
+					__u64 ret;
+					__u64 gpa;
+					__u64 size;
+				} get_quote;
+				struct {
+					__u64 ret;
+					__u64 leaf;
+					__u64 r11, r12, r13, r14;
+				} get_tdvmcall_info;
+			};
+		} tdx;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -923,6 +945,9 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
+#define KVM_CAP_ARM_EL2 240
+#define KVM_CAP_ARM_EL2_E2H0 241
+#define KVM_CAP_RISCV_MP_STATE_RESET 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index b95dd84eef2..d4b3e2ae131 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -28,10 +28,10 @@
 
 /* Set current process as the (exclusive) owner of this file descriptor.  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
 
 /* Set up/modify memory layout */
-- 
2.49.0



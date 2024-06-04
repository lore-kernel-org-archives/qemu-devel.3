Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BD4C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENum-00032O-TC; Tue, 04 Jun 2024 02:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENul-00030p-L4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuj-0007Ib-Uv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDyhAP+n0w/5RDBBwdEvijayFSHRRMGqLWqQctd9oMc=;
 b=WTII0MYhZujVTVN5ioWhI55M+yLTXneqtpcs0MRP/YBV97+i9OCZI/0X8YeyXLYg7IqCpU
 3KxFeFayfPFO+z7P+RmurLqvjdPONf59RWZVOnrP9aYcHVI0E1OP3fGzd7A0HtkpfG+fNH
 /XlMaCNsmf1Ld2psIIEcifjS3bLwmNA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-BGbOoF6wPSutT3NGIIL2cA-1; Tue, 04 Jun 2024 02:44:56 -0400
X-MC-Unique: BGbOoF6wPSutT3NGIIL2cA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6861bb1c0bso193836566b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483494; x=1718088294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDyhAP+n0w/5RDBBwdEvijayFSHRRMGqLWqQctd9oMc=;
 b=t/ILoPpgx9K/jyjEJPXEiI0912ymTD+XaNuOpuXOLXVUM9cX6CbqtNR5F1/Nm5qUNC
 i88H1Ax2Pv3qYygznUUEsG3F0O8ca9LABYK3YAGa3pMESc+ZVdz0ch8/7SPjGb3UWO1e
 QIVcpPjDhahO425SS1wZDP3bKKPcB1O6TKK1AsSOkYcgJU3vStHdn0V+2z8mO1WVspA3
 u0+cqN0AC+2NIHgt5fbiYG9DVsxNTysUyXsjONl73QtUb5aKajRENmvpldpnMeH6Ze0M
 GtqIWe1r6lEiFp24U+W/TnyPsv+FXTzo5Z1FsOJtj5sDz48RT0DdIr8m1LcO/YhYc0Yd
 LHSQ==
X-Gm-Message-State: AOJu0YwObO/CD9GO2sPF0EdD2vTUFhga6l+pWh894/vz8A+Fl1Ym2HVP
 bTkn/PScx/YK2ijQ5GP0n1lRxlb8GfwdCoD9W6LiJMpxCEejhzM/vaURu4tTFHkvfXLsOHrtth/
 FzMeCUF8c6Ur74bEAkPpl5qQia0SYc0YVETfd0EzpBV1xlJBieX/mR8bA3CreFsx7ZPKOL0mpoL
 /e9Ovut2XvtFUE/h0fg+n0l6yxgOftH1Xhy1q4
X-Received: by 2002:a17:906:408a:b0:a68:43a6:fbdf with SMTP id
 a640c23a62f3a-a6843a6febfmr619271366b.49.1717483493975; 
 Mon, 03 Jun 2024 23:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwFiU7ge6+oSqyQqtrFCqjNNzq0vu3U4tNqhRRWyXNnN09yLxvqIvNyWQTlmusU803vi6lnQ==
X-Received: by 2002:a17:906:408a:b0:a68:43a6:fbdf with SMTP id
 a640c23a62f3a-a6843a6febfmr619270166b.49.1717483493508; 
 Mon, 03 Jun 2024 23:44:53 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e9eed9b1sm354950666b.131.2024.06.03.23.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PULL 14/45] linux-headers: Update to current kvm/next
Date: Tue,  4 Jun 2024 08:43:38 +0200
Message-ID: <20240604064409.957105-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

This updates kernel headers to commit 6f627b425378 ("KVM: SVM: Add module
parameter to enable SEV-SNP", 2024-05-12).  The SNP host patches will
be included in Linux 6.11, to be released next July.

Also brings in an linux-headers/linux/vhost.h fix from v6.9-rc4.

Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-3-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-loongarch/kvm.h |  4 +++
 linux-headers/asm-riscv/kvm.h     |  1 +
 linux-headers/asm-x86/kvm.h       | 52 ++++++++++++++++++++++++++++++-
 linux-headers/linux/vhost.h       | 15 ++++-----
 4 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index 109785922cf..f9abef38231 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -17,6 +17,8 @@
 #define KVM_COALESCED_MMIO_PAGE_OFFSET	1
 #define KVM_DIRTY_LOG_PAGE_OFFSET	64
 
+#define KVM_GUESTDBG_USE_SW_BP		0x00010000
+
 /*
  * for KVM_GET_REGS and KVM_SET_REGS
  */
@@ -72,6 +74,8 @@ struct kvm_fpu {
 
 #define KVM_REG_LOONGARCH_COUNTER	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 1)
 #define KVM_REG_LOONGARCH_VCPU_RESET	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 2)
+/* Debugging: Special instruction for software breakpoint */
+#define KVM_REG_LOONGARCH_DEBUG_INST	(KVM_REG_LOONGARCH_KVM | KVM_REG_SIZE_U64 | 3)
 
 #define LOONGARCH_REG_SHIFT		3
 #define LOONGARCH_REG_64(TYPE, REG)	(TYPE | KVM_REG_SIZE_U64 | (REG << LOONGARCH_REG_SHIFT))
diff --git a/linux-headers/asm-riscv/kvm.h b/linux-headers/asm-riscv/kvm.h
index b1c503c2959..e878e7cc397 100644
--- a/linux-headers/asm-riscv/kvm.h
+++ b/linux-headers/asm-riscv/kvm.h
@@ -167,6 +167,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZFA,
 	KVM_RISCV_ISA_EXT_ZTSO,
 	KVM_RISCV_ISA_EXT_ZACAS,
+	KVM_RISCV_ISA_EXT_SSCOFPMF,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 31c95c2dfe4..1c8f9182348 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -695,6 +695,11 @@ enum sev_cmd_id {
 	/* Second time is the charm; improved versions of the above ioctls.  */
 	KVM_SEV_INIT2,
 
+	/* SNP-specific commands */
+	KVM_SEV_SNP_LAUNCH_START = 100,
+	KVM_SEV_SNP_LAUNCH_UPDATE,
+	KVM_SEV_SNP_LAUNCH_FINISH,
+
 	KVM_SEV_NR_MAX,
 };
 
@@ -709,7 +714,9 @@ struct kvm_sev_cmd {
 struct kvm_sev_init {
 	__u64 vmsa_features;
 	__u32 flags;
-	__u32 pad[9];
+	__u16 ghcb_version;
+	__u16 pad1;
+	__u32 pad2[8];
 };
 
 struct kvm_sev_launch_start {
@@ -820,6 +827,48 @@ struct kvm_sev_receive_update_data {
 	__u32 pad2;
 };
 
+struct kvm_sev_snp_launch_start {
+	__u64 policy;
+	__u8 gosvw[16];
+	__u16 flags;
+	__u8 pad0[6];
+	__u64 pad1[4];
+};
+
+/* Kept in sync with firmware values for simplicity. */
+#define KVM_SEV_SNP_PAGE_TYPE_NORMAL		0x1
+#define KVM_SEV_SNP_PAGE_TYPE_ZERO		0x3
+#define KVM_SEV_SNP_PAGE_TYPE_UNMEASURED	0x4
+#define KVM_SEV_SNP_PAGE_TYPE_SECRETS		0x5
+#define KVM_SEV_SNP_PAGE_TYPE_CPUID		0x6
+
+struct kvm_sev_snp_launch_update {
+	__u64 gfn_start;
+	__u64 uaddr;
+	__u64 len;
+	__u8 type;
+	__u8 pad0;
+	__u16 flags;
+	__u32 pad1;
+	__u64 pad2[4];
+};
+
+#define KVM_SEV_SNP_ID_BLOCK_SIZE	96
+#define KVM_SEV_SNP_ID_AUTH_SIZE	4096
+#define KVM_SEV_SNP_FINISH_DATA_SIZE	32
+
+struct kvm_sev_snp_launch_finish {
+	__u64 id_block_uaddr;
+	__u64 id_auth_uaddr;
+	__u8 id_block_en;
+	__u8 auth_key_en;
+	__u8 vcek_disabled;
+	__u8 host_data[KVM_SEV_SNP_FINISH_DATA_SIZE];
+	__u8 pad0[3];
+	__u16 flags;
+	__u64 pad1[4];
+};
+
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
@@ -870,5 +919,6 @@ struct kvm_hyperv_eventfd {
 #define KVM_X86_SW_PROTECTED_VM	1
 #define KVM_X86_SEV_VM		2
 #define KVM_X86_SEV_ES_VM	3
+#define KVM_X86_SNP_VM		4
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
index bea69739061..b95dd84eef2 100644
--- a/linux-headers/linux/vhost.h
+++ b/linux-headers/linux/vhost.h
@@ -179,12 +179,6 @@
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
-/* Get the count of all virtqueues */
-#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
-
-/* Get the number of virtqueue groups. */
-#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
-
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 
@@ -228,10 +222,17 @@
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
 
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
 /* Get the queue size of a specific virtqueue.
  * userspace set the vring index in vhost_vring_state.index
  * kernel set the queue size in vhost_vring_state.num
  */
-#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
 #endif
-- 
2.45.1



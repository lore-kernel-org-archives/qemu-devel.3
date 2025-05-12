Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE7CC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTj-0006BL-Mh; Mon, 12 May 2025 15:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTY-0005bj-FM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTW-0007XS-JZ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR7VRKsHk1LFUjL/CPvD6Ba0DjnC+4MB5W2eiGKedTs=;
 b=Mau/saVXmfTIVCSxQL6WMp6mMfXDeeO4zl1I2xz7pTyycybuWI2wDJY40HenB0A4Q9JCh1
 0pFIZThzxc9ryMR/cuSxE+dGarIkPiq8HggYXeMx4E/8JHHx6QIFUswLmnFwxv9exutTfj
 1Fio4I9z3NkedFp4qeaq0130FNUklkE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-jhY53pU9M-C6_M-wa611fQ-1; Mon, 12 May 2025 15:06:04 -0400
X-MC-Unique: jhY53pU9M-C6_M-wa611fQ-1
X-Mimecast-MFC-AGG-ID: jhY53pU9M-C6_M-wa611fQ_1747076763
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso22698085e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076762; x=1747681562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cR7VRKsHk1LFUjL/CPvD6Ba0DjnC+4MB5W2eiGKedTs=;
 b=AAEZTs5UjdTDI6fmmvER6cp5Gfy+2DQaPdeotDF0P1l5Fujq73DMrzpQYm2CUld1LF
 oFgpNmN0AhgnFT7qszNYmu0OiooHxOyWV4AqPELsPVXJKg+DbNVtGK8386wp4K24j7WP
 9sYmtYI/Tg46gTWSCRjTZN44pUuvYrd/Yy9j1sFQuZ4jQJBNggPdQJAtpqWSkzno2Ma2
 9eWoST34QhJZ0StCbgWaFavvUYiew4msNPf5sL7Hu+n79nU9nrc7hdJIaOIyg4DcOCOP
 p5zkXSfRQ/K/K6Wo2MF1Ez5LwVyVnBp5lt5mHOZ0RiG6wRnDH5yLV5IH8kP/+bYC0vcj
 0SIw==
X-Gm-Message-State: AOJu0YzxG3AITm6eohTzOym7Y3XBbaF1OJpJ24VgpgjEUUikl/V/FHPH
 O8C5QzXJEjBlH0XZHAQH+LYRsYiUX9vWOhGGD7zZ/S8pKTcNQ3+Z0sTZ/nFgcxQz58Jz9Z4E3cf
 gCG7Cafg8udUr2d8+5yf0KPvs2OqI0JvZ1bBfA8kAw60aDffRR7WbigO4UWc/IdXw7yFIr+hr+q
 ASKX2853lOCRq6/+e8QFzXfgm22Nm3DIbr6Upe
X-Gm-Gg: ASbGnctAwMC5JcYVBgAbzoTf3VE0tAeWisVwxPa47qxB+PC9o/KKVWR3fB3Qoxw5uaN
 ooPkSzaVIKA89smBzsUBpZfCsEcVkWvn5zSAvsNfZIWENFskW1Kn9S4eOCWFut86nEVyXxYwU5h
 n8PE9hcmU4IikAOPc0z1BU6AGu/hkmC53QxXvwAjJuaZfWYNfAK7gln32SDfyt+vLtN05Ti4BqD
 BnDyvqxgx3zJVQBqBAtViROIRslyY1BilsRQME08krVGfXrmdQE2h7dof+ArAGpYx13aeK6oGYo
 rp9hpmEnZ/bu4zY=
X-Received: by 2002:a05:6000:4205:b0:3a0:8c45:d30e with SMTP id
 ffacd0b85a97d-3a1f6469589mr10456954f8f.35.1747076762332; 
 Mon, 12 May 2025 12:06:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGni/cwRNmpwKHVO8icBuN8dguPNC+hZ0jXxCUvop6UXHbGyM54Kizi0SGYRV/Up1Ejf7vloQ==
X-Received: by 2002:a05:6000:4205:b0:3a0:8c45:d30e with SMTP id
 ffacd0b85a97d-3a1f6469589mr10456945f8f.35.1747076761850; 
 Mon, 12 May 2025 12:06:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2ffsm13566379f8f.66.2025.05.12.12.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:06:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 14/16] linux-headers: update from 6.15 + kvm/next
Date: Mon, 12 May 2025 21:05:22 +0200
Message-ID: <20250512190524.179419-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This brings in the userspace TDX API.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-x86/kvm.h | 71 +++++++++++++++++++++++++++++++++++++
 linux-headers/linux/kvm.h   |  1 +
 2 files changed, 72 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index dc591fb17e5..7fb57ccb2a7 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -439,6 +439,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
+#define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
@@ -928,4 +929,74 @@ struct kvm_hyperv_eventfd {
 #define KVM_X86_SNP_VM		4
 #define KVM_X86_TDX_VM		5
 
+/* Trust Domain eXtension sub-ioctl() commands. */
+enum kvm_tdx_cmd_id {
+	KVM_TDX_CAPABILITIES = 0,
+	KVM_TDX_INIT_VM,
+	KVM_TDX_INIT_VCPU,
+	KVM_TDX_INIT_MEM_REGION,
+	KVM_TDX_FINALIZE_VM,
+	KVM_TDX_GET_CPUID,
+
+	KVM_TDX_CMD_NR_MAX,
+};
+
+struct kvm_tdx_cmd {
+	/* enum kvm_tdx_cmd_id */
+	__u32 id;
+	/* flags for sub-commend. If sub-command doesn't use this, set zero. */
+	__u32 flags;
+	/*
+	 * data for each sub-command. An immediate or a pointer to the actual
+	 * data in process virtual address.  If sub-command doesn't use it,
+	 * set zero.
+	 */
+	__u64 data;
+	/*
+	 * Auxiliary error code.  The sub-command may return TDX SEAMCALL
+	 * status code in addition to -Exxx.
+	 */
+	__u64 hw_error;
+};
+
+struct kvm_tdx_capabilities {
+	__u64 supported_attrs;
+	__u64 supported_xfam;
+	__u64 reserved[254];
+
+	/* Configurable CPUID bits for userspace */
+	struct kvm_cpuid2 cpuid;
+};
+
+struct kvm_tdx_init_vm {
+	__u64 attributes;
+	__u64 xfam;
+	__u64 mrconfigid[6];	/* sha384 digest */
+	__u64 mrowner[6];	/* sha384 digest */
+	__u64 mrownerconfig[6];	/* sha384 digest */
+
+	/* The total space for TD_PARAMS before the CPUIDs is 256 bytes */
+	__u64 reserved[12];
+
+	/*
+	 * Call KVM_TDX_INIT_VM before vcpu creation, thus before
+	 * KVM_SET_CPUID2.
+	 * This configuration supersedes KVM_SET_CPUID2s for VCPUs because the
+	 * TDX module directly virtualizes those CPUIDs without VMM.  The user
+	 * space VMM, e.g. qemu, should make KVM_SET_CPUID2 consistent with
+	 * those values.  If it doesn't, KVM may have wrong idea of vCPUIDs of
+	 * the guest, and KVM may wrongly emulate CPUIDs or MSRs that the TDX
+	 * module doesn't virtualize.
+	 */
+	struct kvm_cpuid2 cpuid;
+};
+
+#define KVM_TDX_MEASURE_MEMORY_REGION   _BITULL(0)
+
+struct kvm_tdx_init_mem_region {
+	__u64 source_addr;
+	__u64 gpa;
+	__u64 nr_pages;
+};
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index e5f3e8b5a02..99cc82a275c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -369,6 +369,7 @@ struct kvm_run {
 #define KVM_SYSTEM_EVENT_WAKEUP         4
 #define KVM_SYSTEM_EVENT_SUSPEND        5
 #define KVM_SYSTEM_EVENT_SEV_TERM       6
+#define KVM_SYSTEM_EVENT_TDX_FATAL      7
 			__u32 type;
 			__u32 ndata;
 			union {
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AC6C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma16-0005bC-N0; Tue, 19 Mar 2024 10:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0k-0005XN-VY
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rma0j-000731-FW
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710856811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNplvHuiyIzsoOjFcx52HHJTNXwI0XlPnRO8RYJif78=;
 b=NlcZ4S1kDTRrT+ftnY6X70An5LLLjhDWlVKj3RAlXZFyfUjRfDfowESrGQv3pm6EigJiPt
 mJs1ADsgljIWKBhJhIPnW/LEqDXHLqKHEQZCqBZM7A3cM53VRoqnJ3ml7Wsu0wmg2is/fY
 KB55Vwd3VcQ+z0CRt6EThPfAate+ZIw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-0WMzk2PxMamJLAyta-Q8sg-1; Tue, 19 Mar 2024 10:00:10 -0400
X-MC-Unique: 0WMzk2PxMamJLAyta-Q8sg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a466c7b0587so411569366b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856806; x=1711461606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pNplvHuiyIzsoOjFcx52HHJTNXwI0XlPnRO8RYJif78=;
 b=MOHGWBzaRToTUnz7atr7fYBEqYxF/JIQ3OlQSTKqOioPWzToYjkqj1yiprolhfUuBm
 W3ebL7MI0b4ZJ+0Fq/h7cH8QTuAwqg+Tm8CdpqmsYEUmJFnk8VnKUwd5PDcoryMvAbMR
 WXFBxj+75OuRCMf5CJgIGd+eqvQwmcER0p/yTBFrEllcX6NRCtOvKUCWbC0qsq28s7os
 UNO6+Ao6PgcTFlZh+KXX/ZQfz3Pjjv6Ylni5/q9L3PE48/NZW9qNeOc6LESMo8ys3yAo
 sW/oqKytAiguJjf5/hP7c2Oui1Nu0x36y22Tm3ncpO4QKRr9xYUXvxmIphcFZl9i1sbi
 nrug==
X-Gm-Message-State: AOJu0YxsTDtCl89hSHY4dZFeKUyqzbSkHmgIs42Q3Ef04C96eYGn5xfw
 O6lbGDb2YYvyN45mtdy6uaVTu7AE97WK4Txy0+x+7s9DVU2nWFEuC88n2gZBq5IRy7NCowUyAtB
 sSRvbAziTccSD4eIMZKSfhOgA+lGSfNs99yCIhgNgeHVXU5KxAdaIBv/vquzSXLrcaVZEs1/zVr
 ddT9d2OCA1dDY0dIHDzhc6mC53Vv04ut+fsLzi
X-Received: by 2002:a17:906:b7cc:b0:a46:ea28:2a4d with SMTP id
 fy12-20020a170906b7cc00b00a46ea282a4dmr382299ejb.27.1710856806183; 
 Tue, 19 Mar 2024 07:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Fpr1EGyljzNaWxZc4ES2iclFXCjqHeGg2DKT4v9qIPcbd1pU1kKnqxw97MhCMsfMrSkzrQ==
X-Received: by 2002:a17:906:b7cc:b0:a46:ea28:2a4d with SMTP id
 fy12-20020a170906b7cc00b00a46ea282a4dmr382282ejb.27.1710856805885; 
 Tue, 19 Mar 2024 07:00:05 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a1709060c0a00b00a44899a44ddsm6216745ejf.11.2024.03.19.07.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:00:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com
Subject: [PATCH 1/7] linux-headers hack
Date: Tue, 19 Mar 2024 14:59:54 +0100
Message-ID: <20240319140000.1014247-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319140000.1014247-1-pbonzini@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

To be replaced by update to kvm/next branch from Linux 6.9, once the
new API is committed.
---
 linux-headers/asm-x86/kvm.h | 8 ++++++++
 linux-headers/linux/kvm.h   | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 003fb745347..8f58c32d37d 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -562,5 +562,13 @@ struct kvm_pmu_event_filter {
 
 #define KVM_X86_DEFAULT_VM	0
 #define KVM_X86_SW_PROTECTED_VM	1
+#define KVM_X86_SEV_VM          2
+#define KVM_X86_SEV_ES_VM       3
+
+struct kvm_sev_init {
+        __u64 vmsa_features;
+        __u32 flags;
+        __u32 pad[9];
+};
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 17839229b2a..5fd84fd7d0c 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1865,6 +1865,8 @@ enum sev_cmd_id {
 	/* Guest Migration Extension */
 	KVM_SEV_SEND_CANCEL,
 
+	KVM_SEV_INIT2,
+
 	KVM_SEV_NR_MAX,
 };
 
-- 
2.44.0



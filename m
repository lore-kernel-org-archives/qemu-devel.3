Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D257C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDZ-0000f2-GQ; Wed, 14 Feb 2024 06:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDU-0000VI-P1
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDQ-0006o9-9Q
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iax4fGkbgDG496GWyJLMKtIlIETz7WAUyf3pMF1uss=;
 b=SoCNhsN0aVoGQ31saM03LTxvc6RpqXRAgaTqX8a4cQL2/ORVSW4vnC939Z6Gyc23Rk2Drd
 DwE3kp51PCWf0uNq2peSp2a3U6h4RLvbTyD8Zx3hiMXL/YTcKD573JMnfj9USUWTmgCecx
 XeHiURYmhWARMTxhFXbhn8M/IJcmASY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-1j-73DFKOMaZKZf_5Dpjfg-1; Wed, 14 Feb 2024 06:14:08 -0500
X-MC-Unique: 1j-73DFKOMaZKZf_5Dpjfg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3d06dd626fso90592966b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909247; x=1708514047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iax4fGkbgDG496GWyJLMKtIlIETz7WAUyf3pMF1uss=;
 b=EbKMWR+WmhPaE+RWDSKcWzRR8wWjDGmaLb4CkgE5ujuX2ZBUeNb49XL/n66aoZQDEv
 M+bmdZ3iUBzaRYC+o9vSFeYL/PSwhW/kvyViFb9a9aV+fyg/OK5e5cMZDNZvdFHdSPaK
 tYras3+FA9QU4g97hD6910vH+AMcU7FbJWbGjzf6iW6icsnHNVDYdsCXIWDsO2Q1H1bB
 5qOep0eGFEZe668Itzox7fiVv+naRPQWezBDTgR9k+1fp3AnBzA5wraadvZuG+AFqZrU
 bnLuuAfZiuBLgj2db8/1PYTzMUcVrKDJNRp/0fMSuaQOlrK3y67wo/JxwYQklealZAsX
 61jg==
X-Gm-Message-State: AOJu0YxgYSk7t6lNocx7Os32/DznBSELHJiKntjQacs/wRdIEu/htL2o
 eSZ+GumzvlNCmh6x/7bHWqbo8WwtjmsZMbs/W6ESX/oEJC5fP2lup8jRDIYiBi4NViKXl4kpoJV
 cDaSXIpKOPHLDWs28C6EuZYxHnFt31fieB8LYuIcSUBUEyYfAc4WzCJec08fSnE5bs+Ig41TwKZ
 fZtYb3aU6k6/KxEtTZgwX8bj+roaIX0A==
X-Received: by 2002:a17:907:170d:b0:a3d:1170:e6e3 with SMTP id
 le13-20020a170907170d00b00a3d1170e6e3mr1527439ejc.14.1707909246801; 
 Wed, 14 Feb 2024 03:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI49NcLQyhOXFsT4Md53NHs0c+SdAhAFi2eKpc8vzrHhHQLFmXDzJAS+L37Rh07ecp476ZiA==
X-Received: by 2002:a17:907:170d:b0:a3d:1170:e6e3 with SMTP id
 le13-20020a170907170d00b00a3d1170e6e3mr1527417ejc.14.1707909246526; 
 Wed, 14 Feb 2024 03:14:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU67ULHZKtEAw62/YAPtzCrjtvIDaXgeWg3SK7op60uqHWpe/E0cY99jjrG6+5gvY72coW60A/pb0Tfc00twzDj3OFLJWarLTA8RBqO3k6hUxgvmC7L2ku3QI4XykXMNbzYn8EWE9PkjN93/0BWJ1kuIbJ3k6XZgvbIW8JxAN6raBkKz7IqnEeFcEwtmDh4nWFcKQdP4CkNtPJyFBL1tGlkx/Qpmbaf2kcD9h7K4QtT1GGkyTXnei3g6VegLDkJpWmyBr8T0OxNaCrcnL9nQcVOpXPC+cNiYT+/MHOpQK+DU+8LSYy429CrWXOmDGuaXg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 i24-20020a170906115800b00a3d303f0981sm767429eja.92.2024.02.14.03.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:05 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bui Quang Minh <minhquangbui99@gmail.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 15/60] intel_iommu: allow Extended Interrupt Mode when using
 userspace APIC
Message-ID: <2cf16205290bdb6d92bade3590adec6e08fd26c9.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

As userspace APIC now supports x2APIC, intel interrupt remapping
hardware can be set to EIM mode when userspace local APIC is used.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-Id: <20240111154404.5333-5-minhquangbui99@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1a07faddb4..cf933189d3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4124,11 +4124,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
                                               ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
     if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
-        if (!kvm_irqchip_is_split()) {
-            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
-            return false;
-        }
-        if (kvm_enabled() && !kvm_enable_x2apic()) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
             error_setg(errp, "eim=on requires support on the KVM side"
                              "(X2APIC_API, first shipped in v4.7)");
             return false;
-- 
MST



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1A0C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL9H-0002jW-3P; Tue, 20 Feb 2024 03:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9F-0002jC-9o
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9D-0000Q4-Tu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yV+/CAeygfSb5g+w1cF0lo6AYhW6ddAlCFrpr+vO+w=;
 b=fk/62gKE0vz8dwGYpzIHbAbZKKAu7zNE1Mr9osuiAC8uzStzmqzId6BfjDs7iit+MA2edE
 5JdWcfhDgU+UXJXJ4JRz0g0BPyss16q+eA10FG04k4YIeaPbQRumT7ED/22wp5qYWJN6nl
 mVGiScXRB56VQ7Cdq7uBv2DnCi5+MaU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-AKC4IgiqOCyrXWKAz6z_kQ-1; Tue, 20 Feb 2024 03:06:36 -0500
X-MC-Unique: AKC4IgiqOCyrXWKAz6z_kQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2f71c83b7eso433086966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416394; x=1709021194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yV+/CAeygfSb5g+w1cF0lo6AYhW6ddAlCFrpr+vO+w=;
 b=mX+m9gEk/bHhcjrnMlt5KYOIqveFXMTFcKeL896OmsCG+lPbU8yLxniD4pE0BdRNEM
 rkopQL6tekIiMwIY5JI9TpKFdhDB8xUIJX3kzs3ivkUcoi7qWNs88R6T4QQDd5UZIexX
 +0f3ejLQ09OWOmNTsrtZtp71gA7TMI9VP7OWnvufprqYEqgJ2/bum8z459DUjtHXYE12
 A1eI3+ZVw1+Nx4Ig7cxhnsD9STLUvnXpRXRP4Ji/zWQ2QTbtxOUiKNLQ4ZW1qctEu0xo
 CnGBqXvw/OhSmqnLfsLbybFF2+NqabNnRoHKSNamf4O7GSwCfwwjP76vtSmcc72xioK+
 heRg==
X-Gm-Message-State: AOJu0YyGHQ53dX/BKbebiP4NCPXzZG8gDgTJqzryJSGNjBuHFUHYT869
 nT6GCIEjr3yyt5V0yrYGQvnfIPqYcUA9v/0NWgx1ZZtmJdWlCD2O0yGkkMYQEVTLh5B7HnxkmNd
 oGZdvnJjTnha2nDOJygk+W6MJwsRCWd5oDWR0Qg5boyLfI6Rh1oJhLpmW85ej0GzDrurFaddSsQ
 dW+XusAkYKqtjP+QkztUCp81YX86tyoQuv8eDl
X-Received: by 2002:a17:906:7d46:b0:a3e:4553:ba31 with SMTP id
 l6-20020a1709067d4600b00a3e4553ba31mr4350025ejp.28.1708416394197; 
 Tue, 20 Feb 2024 00:06:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkMgnCyBHS0Xbsw2Tvrh6l+vKfAu7QvipFOg+yblRkGgMmMg7Rg2O28fsTFxmIcllcXqs7CA==
X-Received: by 2002:a17:906:7d46:b0:a3e:4553:ba31 with SMTP id
 l6-20020a1709067d4600b00a3e4553ba31mr4350010ejp.28.1708416393932; 
 Tue, 20 Feb 2024 00:06:33 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a3f0386dc96sm236383ejc.89.2024.02.20.00.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 David Hildenbrand <david@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 04/17] i386/pc: Drop pc_machine_kvm_type()
Date: Tue, 20 Feb 2024 09:05:45 +0100
Message-ID: <20240220080558.365903-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

pc_machine_kvm_type() was introduced by commit e21be724eaf5 ("i386/xen:
add pc_machine_kvm_type to initialize XEN_EMULATE mode") to do Xen
specific initialization by utilizing kvm_type method.

commit eeedfe6c6316 ("hw/xen: Simplify emulated Xen platform init")
moves the Xen specific initialization to pc_basic_device_init().

There is no need to keep the PC specific kvm_type() implementation
anymore. So we'll fallback to kvm_arch_get_default_type(), which
simply returns 0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231007065819.27498-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ec0e5efcb28..02a0deedd3c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -310,15 +310,12 @@ extern const size_t pc_compat_1_5_len;
 extern GlobalProperty pc_compat_1_4[];
 extern const size_t pc_compat_1_4_len;
 
-int pc_machine_kvm_type(MachineState *machine, const char *vm_type);
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
         optsfn(mc); \
         mc->init = initfn; \
-        mc->kvm_type = pc_machine_kvm_type; \
     } \
     static const TypeInfo pc_machine_type_##suffix = { \
         .name       = namestr TYPE_MACHINE_SUFFIX, \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a5..28194014f82 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1756,11 +1756,6 @@ static void pc_machine_initfn(Object *obj)
     cxl_machine_init(obj, &pcms->cxl_devices_state);
 }
 
-int pc_machine_kvm_type(MachineState *machine, const char *kvm_type)
-{
-    return 0;
-}
-
 static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     CPUState *cs;
-- 
2.43.0



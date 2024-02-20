Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78BCC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLEW-00062g-0S; Tue, 20 Feb 2024 03:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLEU-00062W-1A
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLEH-0001JI-Qf
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMnsr6hcGke44dd+ja2+9AFJ8eqcK1lbFVapTuTjVcM=;
 b=ZoCnQBnpH4agaBWlU2aUQcDztRwTWu/K/xMRcLvf2+peUhc+2FM/H5iBACSE+V9i4Rsrem
 TvbEexldZrnV3qIcnUn93sTBKU2JcfSUlzQdbN7yDBvmKfNYj/+ctK1AyJ5fWWzo83znBj
 fWPhfJYGYLCP57Otwv/wNbPF6w5UCl0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-WYgHcnDqOkuOjzSzG5pNqg-1; Tue, 20 Feb 2024 03:11:51 -0500
X-MC-Unique: WYgHcnDqOkuOjzSzG5pNqg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3e6f366aceso68340366b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416407; x=1709021207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMnsr6hcGke44dd+ja2+9AFJ8eqcK1lbFVapTuTjVcM=;
 b=VVklq42phUY8ePKimh1aBEO9qNagGH/rhxg7on4kf/pB5oCnBz7VvKyRs+DVR6CLzB
 vgqhfWmszZTjUaPeE77MXfzZVRoc//PU/l/ToMMxKU3CflqPv4LyDjMskhGbmvUI5dJ6
 u3Nz+U+VTDq2aHqmlky80AYaYKl1W9GEaBDj6WYk2eKXx7pGcETrT+A0ZVMrynzXcZwr
 7vC8QgFz8AzaO467o0q5aQ4zlCNUua40z3SMHJIaRV8gUZmHSOF6FFTqeJaVydQEP84O
 hZvVmETP+ScrOmOSGK0Fwxba6NNilN1kU6DCW5HDV0aNw13l/OsEiz4S6pqMdMnxq7TF
 x6bg==
X-Gm-Message-State: AOJu0YyzggL0ANsRXjjhOrJa67jJZ6R2qQmfrjP0/XN8TcrmZ9Lhbg20
 rcaIz3vpjl5E2tKvioos4SAGS+9C1BEpGjWKcEYadAzxErs+ElQvi4L0QRvr7dgqT26tAdQ7CYR
 BIVUTJ+q58VC6UySILhkCPPBWoogSAyScgKxarUDTRcjMS+e+HqdFHZU6GzSp5rXc1J9mHwS66F
 8JxCt8YSfSjSDuvYcM3ADkS6kyMwhgb4Uj2pHv
X-Received: by 2002:a17:906:8d5:b0:a3d:993e:ad24 with SMTP id
 o21-20020a17090608d500b00a3d993ead24mr8750576eje.59.1708416407079; 
 Tue, 20 Feb 2024 00:06:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuaeBfODDBMc9YFQ6ztRBfrlFrLuFoHQNPTJLUGIwLRcvEcc0dAwEJLZ1oPOYJpnr8f9xkkQ==
X-Received: by 2002:a17:906:8d5:b0:a3d:993e:ad24 with SMTP id
 o21-20020a17090608d500b00a3d993ead24mr8750563eje.59.1708416406794; 
 Tue, 20 Feb 2024 00:06:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 yj7-20020a170907708700b00a3e881b4b25sm2002779ejb.164.2024.02.20.00.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 07/17] i386/cpuid: Remove subleaf constraint on CPUID leaf 1F
Date: Tue, 20 Feb 2024 09:05:48 +0100
Message-ID: <20240220080558.365903-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

No such constraint that subleaf index needs to be less than 64.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by:Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20240125024016.2521244-3-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dff9dedbd76..9758c83693e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1926,10 +1926,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
                     break;
                 }
 
-                if (i == 0x1f && j == 64) {
-                    break;
-                }
-
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
-- 
2.43.0



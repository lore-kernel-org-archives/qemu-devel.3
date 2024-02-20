Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF461C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL9E-0002iq-El; Tue, 20 Feb 2024 03:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9D-0002iQ-Fw
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL99-0000Pn-Rp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YE/crpx08q0cvPrENC0BpfjOnpLuB9SgYwlLiwfyZzU=;
 b=KuTK1Y6Nq/h4H9nAb5LDteTgqLL1XOEpxBSte88Qr4ATdhjgLSiG4IACGJqmLUTSp+A0lN
 0zyZYUtkxEbm4eIznFp4/BiCervEeLV9I5NawYimTXkgskXMdnrFuZ0PDIj3Jd0qxM9K0B
 ADNy2bHnkd0gz3EQch7MXueUymXQ+JY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-eyLmxuqPOXCulOyJ6jFdXQ-1; Tue, 20 Feb 2024 03:06:33 -0500
X-MC-Unique: eyLmxuqPOXCulOyJ6jFdXQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3ef988b742so19794566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416391; x=1709021191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YE/crpx08q0cvPrENC0BpfjOnpLuB9SgYwlLiwfyZzU=;
 b=bIlNOv2ssg40kEc436FdOvXo9zLcrezP7hEF6jAaoGT9DUmWyII6Z4RWkEoORYfKgT
 EMF62TUN5zkJYWdzOAmLBT5uU23XFC0H5GNgj50fOmh7Q2SMM3k9neg5/ZRx2tup+tK5
 vI3Dzqsgx34oGC7LtcJ1KMLxJUfYAAIX9iEBcGF40ka2BuOXinEvJD8AD5A0xDJZJ7yA
 2SYHlCRGhidgJ5oQUBNn8ta32n7W1jrbQDFx2h9Y/sQzwH6gLx5j3JDNPOQIBcLbGdyk
 QmIky1LFgi2ZNuwc/gbUsX1bns+DozEaFIOW+mcXuh5iIMDYmgOuBH4LnR6uz5zJijbk
 1atA==
X-Gm-Message-State: AOJu0YxW26qKVZ8jG9WqyCYkbbhLJXh5pxm8kvg4W73v6vzw3tCeM+Pb
 b1nsOqE3FF3R6Et5VA1002kTgbJJZONH1UsriMSYJFapo/L2ecmB1nmaNXr/4HUIwIpknY+Ihsv
 HFupjIMxSeXMXPRRiRmG8B9We+Ex+Napt1Wzex8Xb0erE0dx7SKwKXLjIG6VEY7dPF90m1eaaCz
 KLqGxjW2saei/3BUFNNPzCop4TmL7/hdG4LCod
X-Received: by 2002:a17:906:3901:b0:a3f:f73:411f with SMTP id
 f1-20020a170906390100b00a3f0f73411fmr315011eje.45.1708416391709; 
 Tue, 20 Feb 2024 00:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeQtLMa5wLegIZJblxVsKBVCFEvFVNOwpzMow3lxE8tzuLe0cFYZpi98xlhG2awya04XvC+g==
X-Received: by 2002:a17:906:3901:b0:a3f:f73:411f with SMTP id
 f1-20020a170906390100b00a3f0f73411fmr314992eje.45.1708416391408; 
 Tue, 20 Feb 2024 00:06:31 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a170906364800b00a3e4e7ad9dbsm2779284ejb.68.2024.02.20.00.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 03/17] target/i386: Add support of KVM_FEATURE_ASYNC_PF_VMEXIT
 for guest
Date: Tue, 20 Feb 2024 09:05:44 +0100
Message-ID: <20240220080558.365903-4-pbonzini@redhat.com>
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

KVM_FEATURE_ASYNC_PF_VMEXIT has been introduced for years, however QEMU
doesn't support expose it to guest. Add support for it.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20231024083354.1171308-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ce138fecb7..bca776e1fe9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -857,7 +857,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
-            NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
+            NULL, "kvm-pv-tlb-flush", "kvm-asyncpf-vmexit", "kvm-pv-ipi",
             "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.43.0



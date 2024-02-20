Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218A5C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL8u-0002fx-Ue; Tue, 20 Feb 2024 03:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL8t-0002fE-Cz
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL8s-0000OM-2s
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5M6GqtNLOa07YsEMestO7DblPI0uRRCNsI2L3ByJHtg=;
 b=Mr8Fk9313z9FRzUM038NDCgNlSOl3zzYEtnpIwbZFBOJeuC9oTdpGggA7ast+29CRh6kdY
 om7ARKPpDhInqGFZuFsgjsGYof8t0l0+chHcQCTsKLygac+72c6oYtnJt7kBtBmSFo65M8
 QtTdMg9NY3n+QckxupeahY1TaZP5938=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-NgPVnVvPPK22GCD3EAF5fw-1; Tue, 20 Feb 2024 03:06:15 -0500
X-MC-Unique: NgPVnVvPPK22GCD3EAF5fw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5642bbddd01so858926a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416373; x=1709021173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5M6GqtNLOa07YsEMestO7DblPI0uRRCNsI2L3ByJHtg=;
 b=YbVK/3ElkkJWclazpAy2GCQXonirLhR/LCbIDZIhcm2WQsOz34Ss31VYHyHTGYLi60
 +bW+REeGUBH0I6XCrnq4TbyveLbj+9GZ9KzeMIxP6k3jWk8j0u25d/rbjLaLRQBHlqbO
 d47Z7GLUgutgySstXUH4mOq17aaPvGLF4Nuf/Rn4euINkafccnDVqkaMKtQYbKir75MJ
 cjWa6wlFLH7AqQf/dFLvktCfACmzWSSQt9oFjHMBBgFJIGsttQYXhnr68QJW68m0O64G
 ZJ2mpdDzHFW2ShQYJGEPAFr/c59D7obhcIQ7fXpmJAJYkPdNH16adGLz0aMTsCjl2jUl
 ZKMg==
X-Gm-Message-State: AOJu0Yzxt86Wygm+AG97xlrR5s4WlMWTeEp04+gB5gu09liKvYksPeTq
 kdTY+d9SlC0AIFplAZtsTJfuKtujSBnGbFUhXx+VWd1BuxltnEnU1HPHW/a5RPUTMupsbBXxGsb
 rFHxaT+XmP4uMqm3FDRhvQIcvsDEgngnIgvTkGWYGZPnymNocS5tznvUD9FkWZuVwutK1huGrQr
 BmAlV6SsntsyYBC30rmV5FkmnkDiIs1Tm2vWP7
X-Received: by 2002:aa7:d4c7:0:b0:564:7bff:8472 with SMTP id
 t7-20020aa7d4c7000000b005647bff8472mr3222016edr.2.1708416373323; 
 Tue, 20 Feb 2024 00:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFffOAWYSqMCLW8q9joK+KxqMMAKqRTVFKRB3xUieaAK2L47GofLMxDqzftjB9taZqLDewOEw==
X-Received: by 2002:aa7:d4c7:0:b0:564:7bff:8472 with SMTP id
 t7-20020aa7d4c7000000b005647bff8472mr3221991edr.2.1708416372921; 
 Tue, 20 Feb 2024 00:06:12 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 ek23-20020a056402371700b0055edfb81384sm3341873edb.60.2024.02.20.00.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 qemu-stable@nongnu.org
Subject: [PULL 01/17] i386/cpu: Clear FEAT_XSAVE_XSS_LO/HI leafs when
 CPUID_EXT_XSAVE is not available
Date: Tue, 20 Feb 2024 09:05:42 +0100
Message-ID: <20240220080558.365903-2-pbonzini@redhat.com>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Leaf FEAT_XSAVE_XSS_LO and FEAT_XSAVE_XSS_HI also need to be cleared
when CPUID_EXT_XSAVE is not set.

Fixes: 301e90675c3f ("target/i386: Enable support for XSAVES based features")
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20240115091325.1904229-2-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0cd32a6fce3..800caeb593b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6927,6 +6927,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
         env->features[FEAT_XSAVE_XCR0_LO] = 0;
         env->features[FEAT_XSAVE_XCR0_HI] = 0;
+        env->features[FEAT_XSAVE_XSS_LO] = 0;
+        env->features[FEAT_XSAVE_XSS_HI] = 0;
         return;
     }
 
-- 
2.43.0



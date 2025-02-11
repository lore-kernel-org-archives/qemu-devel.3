Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A08C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy7p-0005Y1-8K; Tue, 11 Feb 2025 16:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3S8WrZwYKCsg6so1xqu22uzs.q204s08-rs9sz121u18.25u@flex--seanjc.bounces.google.com>)
 id 1thy5t-0001gm-RD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:47:02 -0500
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3S8WrZwYKCsg6so1xqu22uzs.q204s08-rs9sz121u18.25u@flex--seanjc.bounces.google.com>)
 id 1thy5q-00062t-9P
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:47:00 -0500
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-21f4f0570e2so121905685ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739310411; x=1739915211; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=6mvCPTi078oatgZttY+CUepNgmI0pKTTmm/hDNy/tGc=;
 b=rQpvHFLgEwY5dXjTsD8wLUHZtG0BIRVvCwDe70rDeV5lT2JFhDQ1PStkPPbn0nkzNE
 DOGY5gw+KCrvddJVjHVJZsC8k4dV8QqWivsJoLrSIPQvNsa+w3EAWFvd5qWzHN81YsYB
 NM/CY6lRzjjNOBoy0SAEsTrETXk6uSiQDdf5Ml2ITWquaSB7x2zmC9cyw+YXb3zAckb6
 Y8esr+4b3jTshcwEIctKl1J5hXhqC3GN7cB1gz+7JJaWH7A1TxMuwxiW7KrLGGFiYZWg
 KQElu2yvSDMnf+Vu8J2oj0fI9QJh2NFWHj6VZdw+FhttH2ndXLT48SOxLLkObOVose1D
 h/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739310411; x=1739915211;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mvCPTi078oatgZttY+CUepNgmI0pKTTmm/hDNy/tGc=;
 b=PDJMUFqPEvxVFlWQb4K3tiXfeVCyq8AsK/wWobRyl6S1drAFFM0G2kV4hLebOgOK5t
 jcBc3TReusFjDY3naKSsvii8TPfXZy4cLqFvKRr2+QGfKae9yDwEdrBCSkGV+Ud2ZLWo
 5M1SYXW3jkK1DMAy36bEHnKaZ6F0ehMkPKnLcfFQnQfrAShFvVxRNQn2yedWlmwTu3m9
 fVfN/TY8bTR17I0FanH6Va39Klwp5Dh3FTrsFQVG9kaM0HrIAVXonZsyLQXj/2FFTtUn
 o1xSfYxzSJCCU7+jWuxWi2+fGyaADKkncngW46Zd4I0SjhJzlDjTJWJborLNU92lf/tK
 xbew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRfHffciCxMxX14usjff4IlCehH3FJvgjOCYIatL+tbyO0mnHwf844qpLII5o0FyO9QHhvGRtt9RHE@nongnu.org
X-Gm-Message-State: AOJu0Yxr52qZJNDxNMPQKU6mYlI9ZUrj/V5AaSVzX3u+VQSu1GtNDVKd
 TdRYXIN6CDW1Yr3PukyBxxfrT9dIQUkXoWMTqsX0yztArpWHtFNnzKUlshq5+wleCotkRkE1Tag
 Z2g==
X-Google-Smtp-Source: AGHT+IHqctElHQsje8GD0oIhIva/TYzquQdAPSXcMtbPFuairkitbpoJ8EDI9U/Ym3LShWUab2Umb92QUi8=
X-Received: from pfan21.prod.google.com ([2002:aa7:8a55:0:b0:730:7a22:c567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2450:b0:1e1:bdae:e04d
 with SMTP id adf61e73a8af0-1ee5c85db6bmr1716822637.36.1739310411277; Tue, 11
 Feb 2025 13:46:51 -0800 (PST)
Date: Tue, 11 Feb 2025 13:46:49 -0800
In-Reply-To: <4eb24414-4483-3291-894a-f5a58465a80d@amd.com>
Mime-Version: 1.0
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com>
Message-ID: <Z6vFSTkGkOCy03jN@google.com>
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kim Phillips <kim.phillips@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, 
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 "Nikunj A . Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kishon Vijay Abraham I <kvijayab@amd.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3S8WrZwYKCsg6so1xqu22uzs.q204s08-rs9sz121u18.25u@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Feb 10, 2025, Tom Lendacky wrote:
> On 2/7/25 17:34, Kim Phillips wrote:
> > @@ -289,6 +291,7 @@ static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_
> >  #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
> >  #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
> >  #define SVM_SEV_FEAT_DEBUG_SWAP				BIT(5)
> > +#define SVM_SEV_FEAT_ALLOWED_SEV_FEATURES		BIT_ULL(63)
> 
> Hmmm... I believe it is safe to define this bit value, as the Allowed
> SEV features VMCB field shows bits 61:0 being used for the allowed
> features mask and we know that the SEV_FEATURES field is used in the SEV
> Features MSR left-shifted 2 bits, so we only expect bits 61:0 to be used
> and bits 62 and 63 will always be reserved. But, given that I think we
> need two functions:
> 
> - get_allowed_sev_features()
>   keeping it as you have it below, where it returns the
>   sev->vmsa_features bitmap if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES is set
>   or 0 if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES is not set.
> 
> - get_vmsa_sev_features()
>   which removes the SVM_SEV_FEAT_ALLOWED_SEV_FEATURES bit, since it is
>   not defined in the VMSA SEV_FEATURES definition.

Or just don't add wrappers that do more harm than good?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a9e16792cac0..4d0b5a020b65 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -894,15 +894,6 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
        return 0;
 }
 
-static u64 allowed_sev_features(struct kvm_sev_info *sev)
-{
-       if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
-           (sev->vmsa_features & SVM_SEV_FEAT_ALLOWED_SEV_FEATURES))
-               return sev->vmsa_features;
-
-       return 0;
-}
-
 static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
                                    int *error)
 {
@@ -916,7 +907,8 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
                return -EINVAL;
        }
 
-       svm->vmcb->control.allowed_sev_features = allowed_sev_features(sev);
+       if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES))
+               svm->vmcb->control.allowed_sev_features = sev->vmsa_features;
 
        /* Perform some pre-encryption checks against the VMSA */
        ret = sev_es_sync_vmsa(svm);
@@ -2459,7 +2451,8 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
                struct vcpu_svm *svm = to_svm(vcpu);
                u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
 
-               svm->vmcb->control.allowed_sev_features = allowed_sev_features(sev);
+               if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES))
+                       svm->vmcb->control.allowed_sev_features = sev->vmsa_features;
 
                ret = sev_es_sync_vmsa(svm);
                if (ret)

> >  #define SVM_SEV_FEAT_INT_INJ_MODES		\
> >  	(SVM_SEV_FEAT_RESTRICTED_INJECTION |	\
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index a2a794c32050..a9e16792cac0 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -894,9 +894,19 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
> >  	return 0;
> >  }
> >  
> > +static u64 allowed_sev_features(struct kvm_sev_info *sev)
> > +{
> > +	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
> 
> Not sure if the cpu_feature_enabled() check is necessary, as init should
> have failed if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES wasn't set in
> sev_supported_vmsa_features.

Two things missing from this series:

 1: KVM enforcement.  No way is KVM going to rely on userspace to opt-in to
    preventing the guest from enabling features.

 2: Backwards compatilibity if KVM unconditionally enforces ALLOWED_SEV_FEATURES.
    Although maybe there's nothing to do here?  I vaguely recall all of the gated
    features being unsupported, or something...


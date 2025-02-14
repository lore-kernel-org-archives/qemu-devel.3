Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10112C021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 00:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tijzG-0000qt-4K; Thu, 13 Feb 2025 19:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3c5SuZwYKCpoM84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com>)
 id 1tijzF-0000qj-7R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 19:55:21 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3c5SuZwYKCpoM84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com>)
 id 1tijzC-0005ec-I3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 19:55:20 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso5082217a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 16:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739494515; x=1740099315; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=vGzMcm2EJx62xp3i+ETr3ep/fnfxZsEgR2IjUXZxvfM=;
 b=UD+Snak2/lEi21OkGPBGEct153yXT2dmOwgbLPV8Ru7Kz/JQc1XkVKPQEYLUdIS55Q
 ojzGzNx5yYrRoohP2IkOCSEuoSzJI6C4WtI73lZDCa1yVUz731T0A1p9MGt7mpaJSSck
 ynuovTMaHjar6hUqj0NI2MvdOkGn62dAXywPv5PMYnY2XQ67LYcY/lhHMaS6otc74T+L
 +kqfxJI8VyTwBszn0DZWlI+aG9+y0j49TJ61iZC66kG5VxDhA7i3/jxWTZkptgMUpxRA
 V5Y3ft8b7xOtrg3Vs/OWqhVqdf/6W0z/YaTc2Y2vir7Ykba/TT2+7OBCEpgsSWxjbbzZ
 lvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739494515; x=1740099315;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGzMcm2EJx62xp3i+ETr3ep/fnfxZsEgR2IjUXZxvfM=;
 b=g4XV8z/9BNEMnFh6A/zmiRnkPci9aTptHXOTAUsb4FHNdn3vizIGpPnR16Gl6oG90I
 MolIhgiIRXhcgPV2tN7a8lFtu27w5EBcd6vnNk2vH/qc9pgQRKccqB4ud/XhoZXvIiwA
 1DUk4p7RQPmavlLcuAmsioZPVpyPQ83rnl5yIOGs+XZOhsj53WfjYJo8sapbp3oJ+PN0
 TAzgPeaDQiLoq1xZltorg+Fpuli3mNu4ZgO4nNE8ETQZjjn7dHRImAg+7amAmHtrBlpB
 5/4R3xdyuRsoIAFsGgZtQ/CgxxqvRWyt+2CdrrmWwf8qATtZ4/yHztwM5VIkAZ4B2Y2V
 BIrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlrSxbWtYd5fBj9Y3PfQKZx30X8uob/nOL08SeorGef/2iFlijC1wl39nUAcHwQKIvPKje3XqpbY/Y@nongnu.org
X-Gm-Message-State: AOJu0YwNr6e/zBbQRKfjzQMx0KcX8WPpqTNlD74+MK3pTv38ef+dD6RL
 XHXu4vbNQoFZ6Wh/sKKZFU68/l1iMHLbxO1vZyiAUgsu99/O3/GIrjO0uOD/qnF5WXnmyK/1saI
 17w==
X-Google-Smtp-Source: AGHT+IG5ngeMiNOMVZUFHXMBuyybKCp3WjbtkfdfiVwv29ZoD5+1hFfkQhTBVR4sfR9gbDecEXlqXPEFSd8=
X-Received: from pji8.prod.google.com ([2002:a17:90b:3fc8:b0:2fa:1b0c:4150])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:540c:b0:2f9:c56b:6ec8
 with SMTP id 98e67ed59e1d1-2fbf5be6b9amr15999928a91.10.1739494515423; Thu, 13
 Feb 2025 16:55:15 -0800 (PST)
Date: Thu, 13 Feb 2025 16:55:13 -0800
In-Reply-To: <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com>
Mime-Version: 1.0
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com>
Message-ID: <Z66UcY8otZosvnxY@google.com>
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
From: Sean Christopherson <seanjc@google.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, 
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 "Nikunj A . Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kishon Vijay Abraham I <kvijayab@amd.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3c5SuZwYKCpoM84HD6AIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

On Thu, Feb 13, 2025, Kim Phillips wrote:
> On 2/11/25 3:46 PM, Sean Christopherson wrote:
> > On Mon, Feb 10, 2025, Tom Lendacky wrote:
> > > On 2/7/25 17:34, Kim Phillips wrote:
> > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > index a2a794c32050..a9e16792cac0 100644
> > > > --- a/arch/x86/kvm/svm/sev.c
> > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > @@ -894,9 +894,19 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
> > > >   	return 0;
> > > >   }
> > > > +static u64 allowed_sev_features(struct kvm_sev_info *sev)
> > > > +{
> > > > +	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
> > > 
> > > Not sure if the cpu_feature_enabled() check is necessary, as init should
> > > have failed if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES wasn't set in
> > > sev_supported_vmsa_features.
> > 
> > Two things missing from this series:
> > 
> >   1: KVM enforcement.  No way is KVM going to rely on userspace to opt-in to
> >      preventing the guest from enabling features.
> >   2: Backwards compatilibity if KVM unconditionally enforces ALLOWED_SEV_FEATURES.
> >      Although maybe there's nothing to do here?  I vaguely recall all of the gated
> >      features being unsupported, or something...
> 
> This contradicts your review comment from the previous version of the series [1].

First off, my comment was anything but decisive.  I don't see how anyone can read
this and come away thinking "this is exactly what Sean wants".

  This may need additional uAPI so that userspace can opt-in.  Dunno.  I hope guests
  aren't abusing features, but IIUC, flipping this on has the potential to break
  existing VMs, correct?

Second, there's a clear question there that went unanswered.  Respond to questions
and elaborate as needed until we're all on the same page.  Don't just send patches.

Third, letting userspace opt-in to something doesn't necessarily mean giving
userspace full control.  Which is the entire reason I asked the question about
whether or not this can break userspace.  E.g. we can likely get away with only
making select features opt-in, and enforcing everything else by default.

I don't think RESTRICTED_INJECTION or ALTERNATE_INJECTION can work without KVM
cooperation, so enforcing those shouldn't break anything.

It's still not clear to me that we don't have a bug with DEBUG_SWAP.  AIUI,
DEBUG_SWAP is allowed by default.  I.e. if ALLOWED_FEATURES is unsupported, then
the guest can use DEBUG_SWAP via SVM_VMGEXIT_AP_CREATE without KVM's knowledge.

So _maybe_ we have to let userspace opt-in to enforcing DEBUG_SWAP, but I suspect
we can get away with fully enabling ALLOWED_FEATURES without userspace's blessing.

> If KVM enforces ALLOWED_SEV_FEATURES, it can break existing VMs, thus
> the explicit userspace allowed-sev-features=on opt-in [2].
> 
> Thanks,
> 
> Kim
> 
> [1] https://lore.kernel.org/kvm/ZsfKYHFkWA-Rh23C@google.com/
> [2] https://lore.kernel.org/kvm/20250207233327.130770-1-kim.phillips@amd.com/


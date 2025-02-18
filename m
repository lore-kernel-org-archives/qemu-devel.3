Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0002BC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkR4d-0006JQ-C6; Tue, 18 Feb 2025 12:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Zr60ZwYKCvktfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com>)
 id 1tkR4c-0006JH-MK
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:07:54 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Zr60ZwYKCvktfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com>)
 id 1tkR4a-00062f-Uu
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:07:54 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc1a4c150bso11180292a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739898470; x=1740503270; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=v7G98CO03QnnN9xtWKhsLWFqy1wfvQeBeOeRO1YTnQE=;
 b=b4WPnqT/L8u7aYInskQI33Dw/P97iQllpvaxXHkQCMLeioB9VsvBKDgN7RHyU+268d
 Y+9H7TSinADZNpzp/IsnNvkRJdqnwD1H/4svG0amnJW2y+9/nDUTNWvRmrjoXAxGkx4e
 R6icZbGXtQCUp0Hf8Zwmh26AioBNigbZO4xg+WksZ9s/CEk8kTdH2QjTnJ8sqesVVlva
 g19LFPCwzCm9n43EB1IAC604SUY2WSYsyjxpiFwTdpjVA4wF6DaSXzsgLUiQFtd2mXUU
 UPAFVdQm4M89SR8c5+6w/YKDKoO2QYR5eNOqS8HG2SlOBoKttqq0JUHaMkdi54woVbZ6
 zCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898470; x=1740503270;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7G98CO03QnnN9xtWKhsLWFqy1wfvQeBeOeRO1YTnQE=;
 b=C8SxozDT0NNo9w7Ru9bbi3rMogUDLXBuoy11bNNS4LMrarGaI24eSK6H7hOWKbKKmM
 nNVFfCSorSGCczFBALHkvPp2d0fncUCVSNoMpFJmDJk1Sqhed8zNdhlmffBhM1Ku7Aj4
 AvafMVmjJ0zXBvJB3W0AsQ2fcJwWS7IUsN4S7QqBlZ4FJm9RVbV/DlUQDUz0okm7+O6H
 tlIg2KlxqeoL+wT1omaRyaOrg4/jambBf3BSanTm1zGnnYTMeGdjgR3+srvCQfQOoLqj
 G3mIaZtHMvXomQNOeo62ZnIunXhdzlb75xtfQH4h9pLv0x6RfDUaUkREIMa3BlnSrUvB
 tREQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr6FEDuJHkW96yK7CKxe96ntMA9k4YL6OU318GsE/sxHYb/tnOxgSQz4uJTkt+0Db5s4JabDzYIPdt@nongnu.org
X-Gm-Message-State: AOJu0YzPIiKOMgjCnczCL677gfh4O4KnkqXmpixyrcK9lpyn4CZn5z9g
 LAixIKzQHn+YR+kmBgWhAdxwt0zZZr6gXeop3LgTayssJiW9eGmS3U/Ir/auKv8mwY470nZdgQI
 IHw==
X-Google-Smtp-Source: AGHT+IFFSpaYywVlY9O6AQ/VFTVHYkh6sydzucWQ2EmfRDneUwk2wiuFo7ElcO1xKLr/10aECb1WbymrHWw=
X-Received: from pfbjt23.prod.google.com
 ([2002:a05:6a00:91d7:b0:730:b665:d832])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c5:b0:730:927c:d451
 with SMTP id d2e1a72fcca58-732619150e0mr23520657b3a.20.1739898470209; Tue, 18
 Feb 2025 09:07:50 -0800 (PST)
Date: Tue, 18 Feb 2025 09:07:48 -0800
In-Reply-To: <9066c1cc-57e7-4053-bb33-dc8d64a789ba@amd.com>
Mime-Version: 1.0
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com> <Z66UcY8otZosvnxY@google.com>
 <9066c1cc-57e7-4053-bb33-dc8d64a789ba@amd.com>
Message-ID: <Z7S-ZKuOp6aqcR7l@google.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3Zr60ZwYKCvktfbokdhpphmf.dpnrfnv-efwfmopohov.psh@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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

On Fri, Feb 14, 2025, Kim Phillips wrote:
> On 2/13/25 6:55 PM, Sean Christopherson wrote:
> > On Thu, Feb 13, 2025, Kim Phillips wrote:
> > > > > Not sure if the cpu_feature_enabled() check is necessary, as init should
> > > > > have failed if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES wasn't set in
> > > > > sev_supported_vmsa_features.
> > > > 
> > > > Two things missing from this series:
> > > > 
> > > >    1: KVM enforcement.  No way is KVM going to rely on userspace to opt-in to
> > > >       preventing the guest from enabling features.
> > > >    2: Backwards compatilibity if KVM unconditionally enforces ALLOWED_SEV_FEATURES.
> > > >       Although maybe there's nothing to do here?  I vaguely recall all of the gated
> > > >       features being unsupported, or something...
> > > 
> > > This contradicts your review comment from the previous version of the series [1].
> > 
> > First off, my comment was anything but decisive.  I don't see how anyone can read
> > this and come away thinking "this is exactly what Sean wants".
> > 
> >    This may need additional uAPI so that userspace can opt-in.  Dunno.  I hope guests
> >    aren't abusing features, but IIUC, flipping this on has the potential to break
> >    existing VMs, correct?
> > 
> > Second, there's a clear question there that went unanswered.  Respond to questions
> > and elaborate as needed until we're all on the same page.  Don't just send patches.
> > 
> > Third, letting userspace opt-in to something doesn't necessarily mean giving
> > userspace full control.  Which is the entire reason I asked the question about
> > whether or not this can break userspace.  E.g. we can likely get away with only
> > making select features opt-in, and enforcing everything else by default.
> > 
> > I don't think RESTRICTED_INJECTION or ALTERNATE_INJECTION can work without KVM
> > cooperation, so enforcing those shouldn't break anything.
> > 
> > It's still not clear to me that we don't have a bug with DEBUG_SWAP.  AIUI,
> > DEBUG_SWAP is allowed by default.  I.e. if ALLOWED_FEATURES is unsupported, then
> > the guest can use DEBUG_SWAP via SVM_VMGEXIT_AP_CREATE without KVM's knowledge.
> > 
> > So _maybe_ we have to let userspace opt-in to enforcing DEBUG_SWAP, but I suspect
> > we can get away with fully enabling ALLOWED_FEATURES without userspace's blessing.
> 
> If I hardcode DEBUG_SWAP (bit 5) in the vmsa->sev_features assignment
> in wakeup_cpu_via_vmgexit(), such guest boots successfully with the
> kvm_amd module's debug_swap parameter set.
> 
> The guest *doesn't* boot if I also turn on allowed_sev_features=1 with
> qemu and this patchseries.
> 
> So, the answer is yes, always enforcing ALLOWED_SEV_FEATURES does break
> existing guests, thus the userspace opt-in for it.

That is not an "existing" guest.  That's a deliberately misconfigured guest that
serves as testcase/reproducer.  IIUC, the BSP can't enable DEBUG_SWAP through a
backdoor, so I don't think it's at all sane/reasonable for the guest to expect
that enabling DEBUG_SWAP only on APs will function.  Ah, and KVM will still set
the DR7 intercepts, i.e. the guest can't read/write DR7, so this is definitely a
nonsensical/unsupported configuration.

So unless I've missed something, KVM can unconditionally enforce ALLOWED_SEV_FEATURES.


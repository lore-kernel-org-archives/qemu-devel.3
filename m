Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5921AC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSPZ-00044o-Qj; Tue, 18 Feb 2025 13:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3e9K0ZwYKCjgmYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com>)
 id 1tkSPY-00044c-D6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:33:36 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3e9K0ZwYKCjgmYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com>)
 id 1tkSPW-0000qJ-Fh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:33:36 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc45101191so6058469a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739903611; x=1740508411; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RXlNUKi1nXILcNxScCTGDcCAb7tkH8J9nCCjyi/czMs=;
 b=XtQYh+bs6tjcn7w2jzKmeAPdoQzHuO8lNkX6k1RTgrxvok74ybZghMiNRFtYQ1W2Ui
 6UmHTt4sKd1/rsBlDKmvZPfMygeVFcvqykQfhOoI69geeCx4fKQNL0brn4ELhBqldDBk
 lV7ZqPNyMtzj94KX1ihZGnOnBQc3a8ABQKj12IgwT9S1VEUMYjVBFdMQ55biCi7t5rEa
 CqSvEw/PS0WynCub1TEI9OOcemCLnVK+rP08W0hw3sAy9YwdwYcCiPyHoEHQdWKKnQpN
 ceEJ+SqXmMi/U2MelcKhoZ4fOojvjB4a66ZL1wz88EVup8OUE0MIqLxOqMsvBEi/3V3b
 j/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739903611; x=1740508411;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RXlNUKi1nXILcNxScCTGDcCAb7tkH8J9nCCjyi/czMs=;
 b=UJoQ/gJSBJh9uPifjzBSYQYWKpaPnDXEo0okYPB8sS4fiXp+GFVbWVESddeWmLms5R
 ZtDIpDHz24DAd5X28fYuDlZyWi2JCUKDXjqRgUUrX+4U+Q0GhM0hGh2bqpJBVHP2CTzX
 UcZeBJlcvtbarMx7UmFCgInwdE3GFQa9oo8CCfgdxIxW5UJhNJwrWY/e9ZlR6CT76q+c
 ST0FINU2e6UKlsMLxSUHO8Wqa7alAZzQYbO3XejGEiJULQV58OR5M9pj8BsdZJMp+Kms
 hSWmfnkSQqKA762rKhZCVYlOMOipWHsei0HohI3V7RM6Hnp4QbHoTYnh/e0FOtuuarFC
 yk6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXww6oTkcamekFT/fixQYQ1EPq+4z9ryIOk85xviY6Rbjoa1ex649fqo/DLzht2qWp+Jb/SRhTxtvVL@nongnu.org
X-Gm-Message-State: AOJu0YxXf0ddZJxYb+TuPVhG8W57C3yNlXh3ZIB6QrxWaL9r0QJL6ayJ
 nNe8ysQar1QNns4WgVYadiu3ilE5EziiOG0+pAYlBJikvozTbfe8VrfgVzrtY/jZOelETaA/Ldg
 uLQ==
X-Google-Smtp-Source: AGHT+IEcW7Bb+oVUdOJFQR7wversG/+Mi/U5uft9ooKkzX2p+pew6XYKq/ofkOd7HS18VAqSMoPIlTSlOmw=
X-Received: from pfbfr18.prod.google.com
 ([2002:a05:6a00:8112:b0:730:76c4:7144])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:14c2:b0:730:9659:ff4b
 with SMTP id d2e1a72fcca58-732618e4fccmr18645840b3a.19.1739903611200; Tue, 18
 Feb 2025 10:33:31 -0800 (PST)
Date: Tue, 18 Feb 2025 10:33:29 -0800
In-Reply-To: <gxyvqeslwhw6dirfg7jb7wavotlguctnxf5ystqfcnn5mk74qa@nlqbruetef22>
Mime-Version: 1.0
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com> <Z66UcY8otZosvnxY@google.com>
 <gxyvqeslwhw6dirfg7jb7wavotlguctnxf5ystqfcnn5mk74qa@nlqbruetef22>
Message-ID: <Z7TSef290IQxQhT2@google.com>
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>, 
 Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kishon Vijay Abraham I <kvijayab@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3e9K0ZwYKCjgmYUhdWaiiafY.WigkYgo-XYpYfhihaho.ila@flex--seanjc.bounces.google.com;
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

On Mon, Feb 17, 2025, Naveen N Rao wrote:
> On Thu, Feb 13, 2025 at 04:55:13PM -0800, Sean Christopherson wrote:
> > On Thu, Feb 13, 2025, Kim Phillips wrote:
> > > On 2/11/25 3:46 PM, Sean Christopherson wrote:
> > > > On Mon, Feb 10, 2025, Tom Lendacky wrote:
> > > > > On 2/7/25 17:34, Kim Phillips wrote:
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
> 
> In sev_es_prepare_switch_to_guest(), we save host debug register state 
> (DR0-DR3) only if KVM is aware of DEBUG_SWAP being enabled in the guest 
> (via vmsa_features). So, from what I can tell, it looks like the guest 
> will end up overwriting host state if it enables DEBUG_SWAP without 
> KVM's knowledge?
> 
> Not sure if that's reason enough to enforce ALLOWED_SEV_FEATURES for 
> DEBUG_SWAP :)
> 
> If ALLOWED_SEV_FEATURES is not supported, we may still have to 
> unconditionally save the host DR0-DR3 registers.

Aha!  We do not.  The existing KVM code is actually flawed in the opposite
direction, in that saving host DR0..DR3 during sev_es_prepare_switch_to_guest()
is superfluous.

DR7 is reset on #VMEXIT (swap type "C"), and so KVM only needs to ensure DR0..DR3
are restored before loading DR7 with the host's value.  KVM takes care of that in
common x86 code via hw_breakpoint_restore().

However, there is still a bug, as the AMD-specific *masks* are not restored.  KVM
doesn't support MSR_F16H_DRx_ADDR_MASK emulation or passthrough for normal guests,
so the guest can't set those values either, i.e. will get a #VC.  But the masks
do need to be restored, because the CPU will clobber them with '0' when DebugSwap
is enabled.

And of course the DR0..DR3 loads in sev_es_prepare_switch_to_guest() are a
complete waste of cycles.

*sigh*

Ugh, it gets worse.  The awfulness goes in both direction.  Unless I've misunderstood
how this all works, just because *KVM* enables DebugSwap for the BSP doesn't mean
the guest will enable DebugSwap for APs.  And so KVM _can't_ rely on DebugSwap to
actually swap DR0..DR3, because KVM has no way of knowing whether or not a given
vCPU actually has it enabled.  And that's true even when SEV_ALLOWED_FEATURES
comes along, which means treating DR0..DR3 as swap type B is utterly worthless.

What a mess.  I'll send a small series to try and clean things up.

Also, I told y'all so: https://lore.kernel.org/all/YWnbfCet84Vup6q9@google.com

P.S. Can someone please get the APM updated to actually explain WTF enabling
     Debug Virtualization in SEV_FEATURES does?  The APM does not at all match
     what y'all have told me.  A sane reading of the APM would be that DRs are
     *unconditionally* swap type B when DebugSwap is supported, whereas I've been
     told from the very beginning[*] that treating them as type B requires software
     enabling:

         AMD Milan introduces support for the swapping, as type 'B', of DR[0-3]
         and DR[0-3]_ADDR_MASK registers. It requires that SEV_FEATURES[5] be set
         in the VMSA.

[*] https://lore.kernel.org/all/20221201021948.9259-3-aik@amd.com


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C65C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQch-0006pW-HR; Tue, 18 Feb 2025 11:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3oLe0ZwYKCicVHDQMFJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--seanjc.bounces.google.com>)
 id 1tkQcg-0006p4-CL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:02 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3oLe0ZwYKCicVHDQMFJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--seanjc.bounces.google.com>)
 id 1tkQce-0002KY-NU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:02 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-22103ae73f9so70688405ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739896736; x=1740501536; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=s/2cxuf1JoTO6SVroEVY0mJiDRjaVSu69gtCf8fWHf8=;
 b=sECJi6NU6UGO4IDm4PKBtors8hsuMn57vTzKtK08jNILtZrPjkVl0e/g8bptGs19C1
 TqJ1IF9bDWpn5d3qyX15km2SGxuYoF+s1NLma/JKOppcx+nVvVgxVt2Pylf1aQq00Kgq
 Jwzy2NrYruZoAhK4UH3U1ulRpaEce/c2SaOMigxD3BoQ124PqfNNLAswydsnlx19Y88k
 j2ratVhXzyBpj0lYaM6HP1MaqYBxQp9fYtOAtq77ck8Ll4hDfbcon2SJND3B0gzQwJ1p
 dSUgvxtxU0YUkT2EakkmP7KEFJAH26zHLhujHgGds2GOe46v2ANPd1lw9dPKtCQYblOs
 mj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896736; x=1740501536;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/2cxuf1JoTO6SVroEVY0mJiDRjaVSu69gtCf8fWHf8=;
 b=jdXlsRLcV2Ymuc1OkS0TlScvIMTBhWu0R/Gaw3ZvVksJw4kQ67s//nNmjrJ1+Qlf6/
 GhhPpjPbBuqrFYqo1TVumgZUjqaN18EiJKp1hZkJUt++SWJfBOcq1jLHIsGCPX7Aqv2Y
 K5RKzmnEang+drXur7BCoK1BDz3qJvWJsXhvDzBplxE9yrMt90st9ifOH9hivH3lq01b
 PzXcpg9EDxltOfSTDJP2WdwOuxEbw2lrONu4YaG9VQ8h44l6acC4EYiYGDc812wjsgoy
 gSkJ3bpYoE9AgZv97s/sRAIzYJ1XnDxkr0JvoNNRoyDhLc+qR/KdXwKcEEBiP7ZyMdMu
 ru4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0vDo1mOPx/a6KdhtDlpDq2idLs+3Flt0+coxOoIiwgQboN6atgRHEROVt8LpcsYSiKNbUDkub8GE@nongnu.org
X-Gm-Message-State: AOJu0Yyfr2LQG/i9rGv4bNb/he9xbjipGsN+V0m2fsm5TOJMOEjLBYQA
 KGHdediiscW4E9+vMF8J9nXdneGxokxPkIQ5Vt4yysjzb7p2kgV5Rj11RLc2RVfEXfK0ARGQ/Aq
 ylg==
X-Google-Smtp-Source: AGHT+IGz4N5n0ndesWXzGP2ApD6Q37C+sMsEGHLvD3oikIQsMpSyWe7LRrfHaqSbSDOuxeOF+q2qd4wfsWI=
X-Received: from pgbcq4.prod.google.com ([2002:a05:6a02:4084:b0:ad5:45a5:645a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a43:b0:1ee:c89e:1da9
 with SMTP id adf61e73a8af0-1eec89e1ecdmr4815022637.21.1739896736343; Tue, 18
 Feb 2025 08:38:56 -0800 (PST)
Date: Tue, 18 Feb 2025 08:38:54 -0800
In-Reply-To: <gxyvqeslwhw6dirfg7jb7wavotlguctnxf5ystqfcnn5mk74qa@nlqbruetef22>
Mime-Version: 1.0
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com> <Z66UcY8otZosvnxY@google.com>
 <gxyvqeslwhw6dirfg7jb7wavotlguctnxf5ystqfcnn5mk74qa@nlqbruetef22>
Message-ID: <Z7S3ns32Z04sIG2w@google.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3oLe0ZwYKCicVHDQMFJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

Yes, that's what I'm effectively "asking".

> Not sure if that's reason enough to enforce ALLOWED_SEV_FEATURES for 
> DEBUG_SWAP :)
> 
> If ALLOWED_SEV_FEATURES is not supported, we may still have to 
> unconditionally save the host DR0-DR3 registers.

Yes, that's my understanding of the situation.  If the CPU supports DEBUG_SWAP,
KVM must assume the guest can enable it without KVM's knowledge.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985C8C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 20:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsO6-0006vO-UP; Mon, 07 Jul 2025 16:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3BChsaAYKCk89vr40tx55x2v.t537v3B-uvCv2454x4B.58x@flex--seanjc.bounces.google.com>)
 id 1uYs3c-0003HK-1j
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:03:20 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3BChsaAYKCk89vr40tx55x2v.t537v3B-uvCv2454x4B.58x@flex--seanjc.bounces.google.com>)
 id 1uYs3a-0001m6-Eo
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:03:19 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-3138f5e8ff5so3405716a91.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751918596; x=1752523396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=f9m8kL9zJyr1SiWshCzmMkh3jOhLBWM1enV3zix4EH8=;
 b=oRL7ZvqI7ACdRHRIRr3nyJg1oJP4Yx+s9b1XuoaQ4cystER3Zf7hYe0R+FLDZBXhgz
 /yRA9LWAV8Wg7Lt53KLRzlk0c7ahAcmy6xc2JiKVPK2XLkFAR/W9OIySmAsSgQpYv2wB
 eS0Q76IRhXS7Q1koZ88EKA+FUqThyWrkvZpjlLL4+c2Gfp2hYk70KA8p9hVqC1bAFgxm
 fnTHTeHQ8DPU3a/jaarMx62KkIaOL6wD2x8TId4kQ3gnwg+EnAqlHfw8Sy3uGuyE3AtE
 rZqtSmpQQNn7XlWNrHjqm7JNo9RsQGlzSEAp1yCqRFtBoV/KsZ1KpYHIoqCzCwaUZ85J
 ZqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918596; x=1752523396;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=f9m8kL9zJyr1SiWshCzmMkh3jOhLBWM1enV3zix4EH8=;
 b=VX/ykJKM/zTtRl/S3VQtHHVfGbKxg5FmPSasu+JaULOrMK7WZqcgeczMuk4CTWxUzR
 KeOq+vlx+50SENvLGMD+/GebJbU8JlKuTV/S7PFxgb+GBkQxNp1547ORFWxC4kbU6UbT
 /3rGa0QFgM7NckndU/PQhV/VU8LkAVR6jrlRhn+AVCuXTF+HrthH79Om1Cx+9K120yoV
 jKLcZEBFjIvDV/RmW/5YNU4KCoKqtFIl6zZCC0/KJdN/87mqZ3U/ZTzcug37J9LxbiFF
 VeD+8xgH58SpFl40WBQTTEqvTrAnSqADEdphaHi4mMomCb5cGG3eEUdAuM8L+PNK2wKw
 nEmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxjtH47LYPD5FxGZZ0xfR/JNtS3dwg2c0FODwUafqu1seIG7IBBQ+TGijDP6qh1ZkayOakAahejacr@nongnu.org
X-Gm-Message-State: AOJu0YzKKVT7nSz2EgHbIXarft438fEMk+7y2dE20FNuASlwHmFt0v3W
 rmqLNLSfM/jnVC/RMh1f8PgCfjT1nrSOtfRM27UzJBItqO3/lOjrdNbVNSS980FpZREFOopiply
 wtN+Xqg==
X-Google-Smtp-Source: AGHT+IEOE22l1/AQskq/2IzmrxwVQiz1bT6C2edqUZUbehAs5hUamrBIaw+wv6+t/a48QuFUK94WyklPDEg=
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:313:d95c:49db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d88c:b0:311:c939:c851
 with SMTP id 98e67ed59e1d1-31aac43865fmr20009835a91.4.1751918596108; Mon, 07
 Jul 2025 13:03:16 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:03:14 -0700
In-Reply-To: <aGwgq2cz_xcYCf4o@redhat.com>
Mime-Version: 1.0
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <1ecfac9a-29c0-4612-b4d2-fd6f0e70de9d@oracle.com>
 <e19644ed-3e32-42f7-8d46-70f744ffe33b@intel.com>
 <aGQ-EGmkVkHOZcnn@char.us.oracle.com> <aGwgq2cz_xcYCf4o@redhat.com>
Message-ID: <aGwoAo02SWIBx7QR@google.com>
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
From: Sean Christopherson <seanjc@google.com>
To: "Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, 
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, 
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3BChsaAYKCk89vr40tx55x2v.t537v3B-uvCv2454x4B.58x@flex--seanjc.bounces.google.com;
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

On Mon, Jul 07, 2025, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jul 01, 2025 at 03:59:12PM -0400, Konrad Rzeszutek Wilk wrote:
> > ..snip..
> > > OK, back to the original question "what should the code do?"
> > >=20
> > > My answer is, it can behave with any of below option:
> > >=20
> > > - Be vendor agnostic and stick to x86 architecture. If CPUID enumerat=
es a
> > > feature, then the feature is available architecturally.
> >=20
> > Exactly. That is what we believe Windows does.
> >=20
> >=20
> > By this logic KVM is at fault for exposing this irregardless of the
> > platform (when using -cpu host). And Sean (the KVM maintainer) agrees i=
t is
> > a bug. But he does not want it in the kernel due to guest ABI and hence
> > the ask is to put this in QEMU.
>=20
> If QEMU unconditionally disables this on AMD, and a future AMD CPU
> does implement it, then QEMU is now broken because it won't be fully
> exposing valid features impl by the host CPU and supported by KVM.
>=20
> IOW, if we're going to have QEMU workaround the KVM mistake, then
> the code change needs to be more refined.
>=20
> QEMU needs to first check whether the host CPU implements
> ARCH_CAPABILITIES and conditionally disable it in the guest CPU
> based on that host CPU check. Of course that would re-expose the
> Windows guest bug, but that ceases to be KVM/QEMU's problem at
> that point, as we'd be following a genuine physical CPU impl.

+1

In a perfect world, we'd quirk this in KVM.  But to avoid a potentially bre=
aking
ABI change, KVM's quirky behavior would need to remain the default behavior=
, i.e.
wouldn't actually help because QEMU would still need to be updated to opt o=
ut of
the quirk.

That, and KVM's quirk system is per-VM, whereas KVM_GET_SUPPORTED_CPUID is =
a
/dev/kvm ioctl.


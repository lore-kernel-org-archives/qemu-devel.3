Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964F7D3B9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyJf-0002Sb-PG; Tue, 26 Nov 2024 11:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFyJe-0002S2-4B
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:21:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFyJb-0002ao-GV
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:21:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so25547055e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638085; x=1733242885; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h/Y3dfJHpWGeVDMDu3RlQMaq4H0hBO/Po984mVdCMzk=;
 b=lr5O0MBYfJVIklD3EJreO1OKMwiDPdLTSrF8shj06Yh2HRFToR+MdSCpuWfG7UViya
 AJ5zso79dkD9nf6gBu12IxP+G8UgiqTAcPOM5cUiYvDGmjkNKgepZQya64DatuxM8Iam
 HTBzEExRWq9Umb/v8e11GGtmM8KEC+FGE2gXlsYDuQ48R/hCGLQPS9zzzxcPotV35voz
 /el7nXFiEiX1NtR36Yjr2sCWZxWhlznJp6qksEwNOrLgDKeoYeFuQZg9QIqpo85zs6iv
 fq7wLpc66tkjR01dJ4ugRqOXggnsSKLhDT/c47Tev7TAJazUR0mgQuQadnpW6JhV7wgg
 G6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638085; x=1733242885;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/Y3dfJHpWGeVDMDu3RlQMaq4H0hBO/Po984mVdCMzk=;
 b=NyyFmEKOn2FgssDfeyFqq1bfDlQH4Zre+hVnZPTcueQACFmWjSFaEuTYboV7ZKelXG
 FdaLns0mC0R925DRW+xX19UR2zc8y5TcyGUFpdge5HiHSjDu8Ssyu0UmqwZhuxLd5z2Z
 WZp9MSF3aJGsZh4Vk2UGKjvzMwwWQLh1J0Bf7NIXIPfOdHdBvGQu/4/fYYfSYggGcsS8
 X6IwRE8byQnjw9m76+DB0I5gu2bVwk5PnlqNQv1Il1LhREPtZ3eAh6Ah00phORkscNV+
 x7/9uo+MtsvYoQ6Uujf0k38fopYaysdyb5dizcyJvoCbGWJJVcdwkAT1z8eudnH2Jhwp
 7bHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFGwLi9LiMDvd63y2PI/njfPjx6lZOTPscxOOagxV0ouOE4sOO+GpNCEFgwVNeCmpaf72x+Ds+GHt@nongnu.org
X-Gm-Message-State: AOJu0Yz/+1pAoqlfNWkSsY62vkmvdgvWWPgJ3zcIpUEHKXIVfuhpIFPq
 WnI1BPbm07Ihzod+nAr5B/ON/v/cklSGpVbHMhBpNHmiTLGJt2uggz925fRaA/c=
X-Gm-Gg: ASbGncuIKGp0+z2taupPJgWpOeGyBZ3i0Juz9tvpjWnTqIHJmWy/KPXWLMXzIPTmxR/
 soQVG/aJkmrfngD19Do5NmtOiC3Oyjsc9+eyabJqq4sFBQlmdd7q2l6pI941LncQguDlTbyN+fY
 JQqwEgxlRgzC3CSovwjgIJ+cox2lik0Jgnzi9sTyYIIQ0D0Xd8mcozRnAmHyyNuw7TlGLUEN/cq
 5Pe5nx3u98hnvjPnbKWLPIQYMKrc7pTat/CM/Lg0XbCxI2h
X-Google-Smtp-Source: AGHT+IERC/qysp9e4MP1YayPf4Tiox6DeK1HwZXr50kJG05vy8ZZDrAgDmOEoML+pIX03Snk065zYQ==
X-Received: by 2002:a05:6000:1acd:b0:382:31db:d61 with SMTP id
 ffacd0b85a97d-38260bcb9dbmr16775365f8f.38.1732638085131; 
 Tue, 26 Nov 2024 08:21:25 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm13655099f8f.109.2024.11.26.08.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:21:24 -0800 (PST)
Date: Tue, 26 Nov 2024 16:21:49 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, peter.maydell@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
Message-ID: <20241126162149.GC956991@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
 <Z0XREyMovNyB4s6t@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XREyMovNyB4s6t@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 26, 2024 at 01:45:55PM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 25, 2024 at 05:23:44PM -0500, Stefan Berger wrote:
> > 
> > 
> > On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> > > Create an event log, in the format defined by Trusted Computing Group
> > > for TPM2. It contains information about the VMM, the Realm parameters,
> > > any data loaded into guest memory before boot and the initial vCPU
> > > state.
> > > 
> > > The guest can access this log from RAM and send it to a verifier, to
> > > help the verifier independently compute the Realm Initial Measurement,
> > > and check that the data we load into guest RAM is known-good images.
> > > Without this log, the verifier has to guess where everything is loaded>
> > and in what order.
> > 
> > Typically these logs are backed by extensions of TPM PCRs and when you send
> > a log to a verifier you send a TPM quote along with it for the verifer to
> > replay the log and check the TPM quote. Also, early code in the firmware is
> > typically serving as a root of trust that starts the chain of measurements
> > of code and data, first measuring itself and then other parts of the
> > firmware before it jumps into the other parts. Now here you seem to just
> > have a log and no PCR extensions and therefore no quote over PCRs can be
> > used.

Indeed, in our case it's the trusted hypervisor (RMM) that provides the
equivalent to TPM quote and PCRs. In more details:

1. QEMU loads images into guest RAM by calling KVM, which calls RMM.
2. RMM calculates a hash of the image content, adds it to a rolling hash
   the "Realm Initial Measurement" (RIM), which I believe is equivalent to
   a PCR.
3. During remote attestation, the guest sends evidence containing this RIM
   signed by the root of trust, along with a signed token identifying the
   platform (hardware, firmware, RMM).
4. The verifier checks the signature and the platform token, so it trusts
   the RMM and the RIM.

> > Then what prevents anyone from faking this log and presenting a
> > completely fake log to the verifier?

Absolutely, the verifier does not trust the content of the log, it only
uses the log as helper to try to reconstruct the RIM. For example a log
event says "I loaded image XYZ at address A", then the verifier searches
image XYZ in its database of known-good images, calculates the hash that
would result from loading that image at address A. Any malformed event in
the log causes the hash to diverge from the trusted RIM value, and causes
an attestation error.

> In addition, a measurement log is just one of the interesting features
> that a TPM provides to OS. The other TPM features are still relevant
> and useful to confidential VMs.
> 
> As a high level goal I think we should be aiming to make it possible for
> users to move their existing VM workloads from non-confidentail to
> confidential environments, simply as a choice at deployment time. To make
> this as practical as possible, confidential VMs  need to be aiming to
> match non-confidential VM features where ever it is practical to do so.
> Users & vendors should not need to build & carry around 2 sets of disk
> images - one setup for confidential and one setup for non-confidential.
> Following existing standards will reduce the work both for OS developers,
> app developers and users alike, to adopt the CVM world.
> 
> IOW, this is a long winded way of saying that we should be looking to
> provide a complete *standards compliant*, trusted TPM implementation to
> confidential VMs, not providing a cherry-picked selection of a few
> TPM-like features.
> 
> On the x86 side of things, the route to providing a trusted TPM is via
> SVSM, both for SNP and TDX. Microsoft's recently open sources openhcl
> similarly provides a st
> 
> I don't know so much about RME. Is providing a trusted TPM a job for
> the RMM ?

Not directly, but I've heard of at least two options that are being
actively worked on:
* running payloads like SVSM and openhcl that emulate a TPM. In RMM 1.1
  there is a concept of "planes" that enables this.
* having edk2 in the VM provide a "fTPM".

I'm less familiar with these, but I think both need to connect the virtual
TPM to the root of trust by performing remote attestation via RMM (?). So
the problem of reconstructing a RIM on the verifier side remains, even if
it's not done by the application.

In addition I'm wondering about lighter, container-like workloads, which
will want to boot quickly and run the bare minimum software, and where
edk2 or SVSM seems superfluous. Maybe people will want to tailor those
workloads and avoid the extra layer?

Thanks,
Jean


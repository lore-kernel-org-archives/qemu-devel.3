Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F8FC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfXy-0008Ok-Cn; Mon, 09 Jun 2025 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Sw5HaAYKCswAws51uy66y3w.u648w4C-vwDw3565y5C.69y@flex--seanjc.bounces.google.com>)
 id 1uOfXI-0008Dm-VZ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:39:57 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Sw5HaAYKCswAws51uy66y3w.u648w4C-vwDw3565y5C.69y@flex--seanjc.bounces.google.com>)
 id 1uOfXC-0002n6-Ax
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:39:47 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b2eea1c2e97so3142316a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749487179; x=1750091979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=WMQ8PN6884DW9W1jNjmty1PvTsBAocPOjKWRL+Dgqsk=;
 b=P3Q2PYuPKC8n24K1iwaSrhrd2THhR/Q3WfmwqeBgN4poM7FiOjF1GgWVCgPYtYdmhW
 5t5Pz17/1qcIIXaD22xbHo3mzv13PK9ps2Ta4oBYkZkpFL5G8RkebqQh8J/rcRL7+YJu
 MRULSIGft5FBd5tTtlG7FVLyJASfl7LCFK0AqH1F4O119wYaIuO4NL3hkDPKaHFGZvTe
 iqjKnbaSvCu1u8Nmwtt9PGsFX261rtuO4aKxqT9smbra9FSkDO4arHkJhoEi2Wt+UD3s
 5TQI4k/DIjtry3Zr7WOC36PLEX7wmXbPKtVfWpxkN7+N8TmvAIFJNcDLf5+Minxl7uGr
 r9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487179; x=1750091979;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WMQ8PN6884DW9W1jNjmty1PvTsBAocPOjKWRL+Dgqsk=;
 b=jdtiZ4sKth8Mn/MRO5fYK1F9xTbpuuV88SqbQLzuGdW+wxhexa3onWH2vA+qr7EjEV
 19LcHj2vet5G7U+biZRKoYf+bM6+mb1sagKQh5oJebQVaVXpR32rAC82xiMhjbpmqhvv
 N3FM4XdhIr8LUwvX7REexMExOP8EYwbDRA+fPT8kbcvDO6G8+NaY6kRXtieL36YrH2oM
 hREp6i6qkaCa/rmzPAuQ1eKg7iUa7PtUK7IT7rDyQ6ID84HDvuetHl9w7w2TWhxfFYna
 liX8RD667IlMZ+8OUW6uLJRDNMZkFoLWRPG0H2RJpSGtIVatsKNqkMxYaQ+df5rbcjgC
 enOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNQtptbKLof7g0rVtA2jvptHdGWvAZexnAcCbRWlxPJCROPr1lHeRXPOg0z/VfbWdHE17DY/OC1m0i@nongnu.org
X-Gm-Message-State: AOJu0YxXsyo7BJsVl00aekuzTjKvh2ae+LzEghjZ/unOJoZVZFhMWOy/
 Mx4xcKQc+O83ap0W77qM4GmsBP7pYVs3iKqHLmqIY+gw0O1yh87pqvwMd/hRlqrs0pdKaJAA8Gx
 F+oSCRA==
X-Google-Smtp-Source: AGHT+IHfDLIrS/svY0wyQaqGHXC5W4UuRgfimO7Q5quxSh0AY5WdDRwhCyELO5fMyH4vF7a7e9Oz94gvduI=
X-Received: from pfhx29.prod.google.com ([2002:a05:6a00:189d:b0:746:1857:3be6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:50f:b0:21a:de8e:44b1
 with SMTP id adf61e73a8af0-21ee686203dmr20638459637.34.1749487179116; Mon, 09
 Jun 2025 09:39:39 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:39:37 -0700
In-Reply-To: <4f19c78f-a843-49c9-8d19-f1dc1e2c4468@virtuozzo.com>
Mime-Version: 1.0
References: <20250609132347.3254285-2-andrey.zhadchenko@virtuozzo.com>
 <7ce603ad-33c7-4dcd-9c63-1f724db9978e@redhat.com>
 <4f19c78f-a843-49c9-8d19-f1dc1e2c4468@virtuozzo.com>
Message-ID: <aEcOSd-KBjOW61Rt@google.com>
Subject: Re: [PATCH] target/i386: KVM: add hack for Windows vCPU hotplug with
 SGX
From: Sean Christopherson <seanjc@google.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, zhao1.liu@intel.com,
 mtosatti@redhat.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, andrey.drobyshev@virtuozzo.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3Sw5HaAYKCswAws51uy66y3w.u648w4C-vwDw3565y5C.69y@flex--seanjc.bounces.google.com;
 helo=mail-pg1-x54a.google.com
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

On Mon, Jun 09, 2025, Denis V. Lunev wrote:
> On 6/9/25 18:12, Paolo Bonzini wrote:
> > On 6/9/25 15:23, Andrey Zhadchenko wrote:
> > > When hotplugging vCPUs to the Windows vms, we observed strange instan=
ce
> > > crash on Intel(R) Xeon(R) CPU E3-1230 v6:
> > > panic hyper-v: arg1=3D'0x3e', arg2=3D'0x46d359bbdff',
> > > arg3=3D'0x56d359bbdff', arg4=3D'0x0', arg5=3D'0x0'
> > >=20
> > > Presumably, Windows thinks that hotplugged CPU is not "equivalent
> > > enough"
> > > to the previous ones. The problem lies within msr 3a. During the
> > > startup,
> > > Windows assigns some value to this register. During the hotplug it
> > > expects similar value on the new vCPU in msr 3a. But by default it
> > > is zero.
> >=20
> > If I understand correctly, you checked that it's Windows that writes
> > 0x40005 to the MSR on non-hotplugged CPUs.

...

> > > Bit #18 probably means that Intel SGX is supported, because disabling
> > > it via CPU arguments results is successfull hotplug (and msr value 0x=
5).
> >=20
> > What is the trace like in this case?=C2=A0 Does Windows "accept" 0x0 an=
d
> > write 0x5?
> >=20
> > Does anything in edk2 run during the hotplug process (on real hardware
> > it does, because the whole hotplug is managed via SMM)? If so maybe tha=
t
> > could be a better place to write the value.

Yeah, I would expect firmware to write and lock IA32_FEATURE_CONTROL.

> > So many questions, but I'd really prefer to avoid this hack if the only
> > reason for it is SGX...

Does your setup actually support SGX?  I.e. expose EPC sections to the gues=
t?
If not, can't you simply disable SGX in CPUID?

> Linux by itself handles this well and assigns MSRs properly (we observe
> corresponding set_msr on the hotplugged CPU).

Linux is much more tolerant of oddities, and quite a bit of effort went int=
o
making sure that IA32_FEATURE_CONTROL was initialized if firmware left it u=
nlocked.


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8776EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 05:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPFJ5-0003Mo-NP; Thu, 04 Jul 2024 01:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPFJ2-0003MP-Sd
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPFJ0-0008AQ-OI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 01:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720072012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZYTWzTEddJ57pt9YZks29g81dw6pUMQWtZ5EBpCHNs=;
 b=OTFrlTv/Iu77DOvbwVzs1fAeddMaF/0THJ9z2AeuT293PXxZKS2P7hOH24Ga73//F5A5Hh
 9fj4JtYB96jfy1nKX9ABvKJgoK0oQ+tGZNpYVySMX3n7Gkcf5DN8iAcNRorJFL2PyoTNEG
 kqUmRaBfFgRJY0MwAf5+NMfCrUCLOE4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-3fDLkLAAOkasBSZWFLzJFQ-1; Thu, 04 Jul 2024 01:46:50 -0400
X-MC-Unique: 3fDLkLAAOkasBSZWFLzJFQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678ff75122so245799f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 22:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720072009; x=1720676809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZYTWzTEddJ57pt9YZks29g81dw6pUMQWtZ5EBpCHNs=;
 b=PnFeqZgc/aAjX/iuYB/4ssBhkeR5IXISRQg4KyQWeMGahi5TIpJOuHCHGyfN6+SjFy
 ICs+e2OSkTIzqvGy82cv76VgzZaOqqtKxSc7Wyu+QkMzB6RjYas702SzlGAHqBLgS+Nt
 RL4I7Yi51cJZDuWHyNgkD3esvaY5NB1wPVU9eBGOHvACc5arzD1t/BEDPwgy5cm7PlFH
 bBalxt30KQa+8UBDvDwX+6FRx4iIpMD1VT2s5jCQ23mih62JsNZCfZzV5g+ol+2A60lk
 yns5lEKWtI7chnIGn3q7vG04FadUE/fIc4XGvCw6w/FW8OL3K/5piWCO+wRsfyNa7+Ym
 r6yQ==
X-Gm-Message-State: AOJu0YzFvW5E8aWEy0o6F53eTo73QOdEoyLmX3ht8lgeRfs+UzdsH1U8
 /xoY+rqJUTS22fBsO3mlKPr0gGeLnDO3Ip9FdJgce/ZPGUfk6ciXP0NcNszdcgNyY15og80hY9N
 dYK54AfHq9QrJjgExZovw1VewN/2tmKFlnxWej9nEwHIQ96hZv9Rl8TXU72Jvr+tdPGqU0gc3ki
 YozC1UzpG8l/xNN4aYHzd92QBlQPc=
X-Received: by 2002:adf:e743:0:b0:367:9624:f369 with SMTP id
 ffacd0b85a97d-3679dd2925emr394563f8f.16.1720072009638; 
 Wed, 03 Jul 2024 22:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP+RUjQPIFtlJb/UQ0SenjHkkIRYeUACL5aKXF5atwq0f4ZGBGu3VgjthJzV9qMmZCTFvHAYa0T1t9dw+37B0=
X-Received: by 2002:adf:e743:0:b0:367:9624:f369 with SMTP id
 ffacd0b85a97d-3679dd2925emr394555f8f.16.1720072009234; Wed, 03 Jul 2024
 22:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240703110134.1645979-1-pbonzini@redhat.com>
 <20240704002615.ffmdnewoldrntkia@amd.com>
In-Reply-To: <20240704002615.ffmdnewoldrntkia@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 4 Jul 2024 07:46:37 +0200
Message-ID: <CABgObfYYLQAGCEPoTBFfZdB9ZXkm0pyikmyTxdQ3_YD6Ou9-Gg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] target/i386: SEV: allow running SNP guests with
 "-cpu host"
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, zixchen@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 4, 2024 at 2:26=E2=80=AFAM Michael Roth <michael.roth@amd.com> =
wrote:
> > Michael, any ideas?  Is there a way for the host to retrieve the suppor=
ted
> > CPUID bits for SEV-SNP guests?
>
> If we want to support -cpu host, then I don't really see a way around
> needing to maintain a filter of some sort sanitize what gets passed to
> firmware. Generally, every new CPU model is likely to have some features
> which might be a liability security-wise to allow in SNP guests, so the
> CPUID validation is sort of a whitelist of curated features that make
> sense for guests and can be enabled securely in the context of SNP.
>
> Everything else would need to be filtered out, so we'd need to keep that
> list constantly updated.

It would be per new model and right now there are only a handful of
bits that have to be blocked; so it wouldn't be particularly bad.

> I think that may be possible, but do we have a strong use-case for
> supporting -cpu host in conjunction with SNP guests that this would be
> a worthwhile endeavor?

It's a common way to launch a guest if you're not interested in
migration (which is obviously the case for SNP right now), so it's
more like "why not". :)

> > One possibility is to set up a fake guest---either in QEMU or when KVM
> > starts---to do a LAUNCH_UPDATE for the CPUID page, but even that is not
> > perfect.  For example, I got
>
> Yah, the firmware-provided responses are more of a debug tool and not
> something I think we can rely on to enumerate capabilities.
>
> You could in theory take the ruleset in the PPR (Chapter 2, CPUID Policy
> Enforcement), turn that into something programmatic, and apply that
> against the host's CPUID values, but the policies are a bit more
> specific in some cases, and the PPR is per-CPU-model so both the rules
> and inputs can change from one host to the next.

Yeah, and if you mix that with knowledge of what KVM can/cannot
virtualize that doesn't exist in the processor (which isn't that
much), then you end up with something a lot like patch 2

It would be nice if the policy enforcement were changed to allow the
TSC deadline timer and X2APIC bits (you probably don't want TSC
adjust, that's the right call; and virt SSBD is not accessible because
you use V_SPEC_CTRL instead). But then there would be no way to find
out if the change actually happened.

> So I don't see a great way to leverage that to make things easier here.
> The manually-maintained filter you've proposed here seems more reliable
> to me.

Yep, I think I'll include that patch as the maintainability doesn't seem ba=
d.

Paolo



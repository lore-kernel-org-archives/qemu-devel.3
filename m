Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4254D3398C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QhD-0006Pj-NR; Mon, 28 Oct 2024 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qh5-0006PT-P5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qh0-0003HK-Dy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KryVam8B1QeiyXDX/LEC5cXrGo7Bp2ehnvaqDurb+ic=;
 b=LricEg5nxgjgjHEV9Gq/1gpiLJviAXnTdQBVFOyf+2sJl18G6Ia0zR8v6+Uas88XWxBqcG
 BY4Uxtwp3rmCTbbL5OxwzDOAwDJzky6FDr/PlxQ1JWj0mZHwAf6wYWY8kuQnEffDess9G4
 HCvft5fUb7Ttjq3EQTvogdGeZXWvap0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-M54GI0gyPx-c4SAU2lkjgQ-1; Mon, 28 Oct 2024 10:25:59 -0400
X-MC-Unique: M54GI0gyPx-c4SAU2lkjgQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so31604065e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125557; x=1730730357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KryVam8B1QeiyXDX/LEC5cXrGo7Bp2ehnvaqDurb+ic=;
 b=EE0DmVzk9pPt+SVbWnU2ilp3tsf4zu4bsuoXxwlMmf1FJNle8zUYq2Rv3tcRTcdPky
 1JVTgzR3j5HRO1E/VnjTuf5l5lfZvCQK5xHK6Qme1fNUhD1Es2xZEhYySAESOmjLzB+/
 FcqDEqMN49+6MB+Danhac1NXp82ewTgwMcHq58pgopSaQPsgUKEQSS/Ie9CRy2kiUpLG
 pbcnmOkFaArBgPY/arAlFVQ5d2NSCxMbckfali7AxySZJtAVsYRMq0lARtBjNmAAAq6s
 c6K92HfglEA4UAWaPg/Drf4I+ZQWAa9RD8XzIH3/mSv5ukLbXxplqjHifknlu1F/iFAh
 HaTA==
X-Gm-Message-State: AOJu0YyTNUUXAx4LQQ+SJuoIvfM3joHoRJ9EJiV2WEwPHWALzhLXEgQD
 eMfbrHJWy4CBoRZubh4NrE9y54XK0YV22sXVcRu8VP0e4qVR11FQVhHkorCdjT9OmEGJktkU7zb
 KcavurmN022vpXvc/58HN2QTZ8fnO+NzoReNdqgxT9kdLdrMGw3Zs9hsY5iyemcgQJbnT589HmA
 PHm9T2GCJ0KUbZdW2ktQdQnhyFZRs=
X-Received: by 2002:a05:600c:500a:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-4319acb8ce7mr74501645e9.19.1730125557603; 
 Mon, 28 Oct 2024 07:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFIEWhdP7PMNUIadkfCXOK0l0J4+U99CZs9JgcZC+dmcafgti+xaB2/XQDAvxlMXyox/zSuPc8jMnBF+v7Bxc=
X-Received: by 2002:a05:600c:500a:b0:431:561b:b32a with SMTP id
 5b1f17b1804b1-4319acb8ce7mr74501485e9.19.1730125557274; Mon, 28 Oct 2024
 07:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729807947.git.babu.moger@amd.com>
 <b4b7abae-669a-4a86-81d3-d1f677a82929@redhat.com>
 <24ea79dc-1a15-4e54-a741-e88332476646@amd.com>
In-Reply-To: <24ea79dc-1a15-4e54-a741-e88332476646@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Oct 2024 15:25:44 +0100
Message-ID: <CABgObfZ6hCjs35Z8JDLonsRB=7RAdxhBK5a+pr0qja=6LpEdFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] target/i386: Add support for perfmon-v2, RAS bits
 and EPYC-Turin CPU model
To: babu.moger@amd.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 3:23=E2=80=AFPM Moger, Babu <babu.moger@amd.com> wr=
ote:
>
> Hi Paolo,
>
> On 10/28/24 03:37, Paolo Bonzini wrote:
> > On 10/25/24 00:18, Babu Moger wrote:
> >>
> >> This series adds the support for following features in qemu.
> >> 1. RAS feature bits (SUCCOR, McaOverflowRecov)
> >> 2. perfmon-v2
> >> 3. Update EPYC-Genoa to support perfmon-v2 and RAS bits
> >> 4. Support for bits related to SRSO (sbpb, ibpb-brtype,
> >> srso-user-kernel-no)
> >> 5. Added support for feature bits CPUID_Fn80000021_EAX/CPUID_Fn8000002=
1_EBX
> >>     to address CPUID enforcement requirement in Turin platforms.
> >> 6. Add support for EPYC-Turin.
> >
> > Queued, thanks.  I looked at
>
> Thanks.
>
> > https://gitlab.com/qemu-project/qemu/-/issues/2571 and I think it's cau=
sed
> > by the ignore_msrs=3D1 parameter on the KVM kernel module.
>
> Thanks again.
>
> >
> > However, can you look into adding new CPUID_SVM_* bits?
>
> I normally pickup bits when it is added in kernel/kvm. Are you thinking o=
f
> any specific bits here?

Yes, KVM already supports vGIF, virtual VMLOAD/VMSAVE, virtual TSC
rate MSR, vNMI, virtual LBR, virtual pause filter and virtual pause
filter threshold.

Paolo



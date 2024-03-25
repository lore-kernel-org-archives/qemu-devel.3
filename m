Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE682C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roi1f-0000ft-6c; Mon, 25 Mar 2024 06:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1roi1d-0000fN-CS
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:57:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1roi1Y-0003EE-NF
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711364271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1ZDmNeCMIDm97dXCnPolb+RWLhe+L+ppa2TI1ymYd4=;
 b=euCvBDZ/Xi9xAXYe8QG/sbMDa0VRYtaSx2ezFE6CMElTok0eOwwgg4DPwi3DUo01MzdktY
 iVPoRNI8Upts+0GphrvMJD9joLhGmFrCT6iNnNWipkzufrKhop31jl/62/cPQqSNXerd+q
 agFCZqISuWCK6H60EjKhwWAOdtAFkZ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-TV3cQHxmOF-sGmxgyflBWw-1; Mon, 25 Mar 2024 06:57:50 -0400
X-MC-Unique: TV3cQHxmOF-sGmxgyflBWw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e7ef510aaso2692671f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711364269; x=1711969069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U1ZDmNeCMIDm97dXCnPolb+RWLhe+L+ppa2TI1ymYd4=;
 b=TOqagJOWlU5T1Nz9SwiauoaDFS00srdBW2WnNNPl/RZYS+xoPCN+HaakN2sWjVRbDc
 uUX1Nodh3F1Myr6HyMmsrvYcSnpneTflES/6H97XcqZ3+ONyFSfG7su0bOAtNeLb1qWV
 qoUUo5UkQ22ZFnuZQYsQXj4Nrj/oImoAKGKahiWlUUChAC0rFlR+N3Dj8xLK8sg7eVAW
 AxkDzCw5d1sceZxmU6pfIqvVcUG8yNX/mpRIuTnS1jtb+x2qow6lxXbbZ403BNv6ew1d
 rVfEzt+sheAO+pyC+jdvaG6/FdSB1hwWfz8ZDbD6sxyu4FwerKDE4nI+g34nF0BtnSvp
 CUpQ==
X-Gm-Message-State: AOJu0YzErVJMwmFpQbvSGjr7CYrJLYFFI09RajohsrPrKnsU2N/tL0Xg
 FMm8pisS3ObmgsewHjqCQNJMkd+MneZr02aWvLfnWZtHOM1/PmwnBcw1Qa9ImcqttPzaYa0Uszy
 ZkKZUbJDZvqVrYVKT/sUsWbXafgXicGao/1hnnA9gEjVpsJng747SMrufP76+5HWXjYmgS76cbK
 zdLmagemB4ZR4zHXP8dIjggyIqezg0Tv4MRo4ZQw==
X-Received: by 2002:a05:6000:d0:b0:33d:2180:30e8 with SMTP id
 q16-20020a05600000d000b0033d218030e8mr5673102wrx.25.1711364268834; 
 Mon, 25 Mar 2024 03:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpCH+BHjl/7d2tw8POE4DV1asMFRnZLJVpDh0jsgCzoR2Kyd60s5q7R5qlk33IsJO+kVtUeQnWvuUfwVYk8ss=
X-Received: by 2002:a05:6000:d0:b0:33d:2180:30e8 with SMTP id
 q16-20020a05600000d000b0033d218030e8mr5673087wrx.25.1711364268543; Mon, 25
 Mar 2024 03:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-16-pbonzini@redhat.com>
 <93004298-25d3-485f-9d25-22e9398bbe02@linaro.org>
In-Reply-To: <93004298-25d3-485f-9d25-22e9398bbe02@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Mar 2024 11:57:37 +0100
Message-ID: <CABgObfbZg3QfTZhvFaNFOQSKs_mVTWJxwhwOuMZ7+_aV6c6Lqw@mail.gmail.com>
Subject: Re: [PATCH 15/26] target/i386: Implement mc->kvm_type() to get VM type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com, 
 david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 25, 2024 at 10:29=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 22/3/24 19:11, Paolo Bonzini wrote:
> > KVM is introducing a new API to create confidential guests, which
> > will be used by TDX and SEV-SNP but is also available for SEV and
> > SEV-ES.  The API uses the VM type argument to KVM_CREATE_VM to
> > identify which confidential computing technology to use.
> >
> > Since there are no other expected uses of VM types, delegate
> > mc->kvm_type() for x86 boards to the confidential-guest-support
>
> s/mc/cgs/ here and in subject?

No, this refers to x86_kvm_type(), which is the implementation
mc->kvm_type. As the commit message says, mc->kvm_type() is delegated
to cgs->kvm_type(), via kvm_get_vm_type().

Paolo

> > object pointed to by ms->cgs.
> >
> > For example, if a sev-guest object is specified to confidential-guest-s=
upport,
> > like,
> >
> >    qemu -machine ...,confidential-guest-support=3Dsev0 \
> >         -object sev-guest,id=3Dsev0,...
> >
> > it will check if a VM type KVM_X86_SEV_VM or KVM_X86_SEV_ES_VM
> > is supported, and if so use them together with the KVM_SEV_INIT2
> > function of the KVM_MEMORY_ENCRYPT_OP ioctl. If not, it will fall back =
to
> > KVM_SEV_INIT and KVM_SEV_ES_INIT.
> >
> > This is a preparatory work towards TDX and SEV-SNP support, but it
> > will also enable support for VMSA features such as DebugSwap, which
> > are only available via KVM_SEV_INIT2.
> >
> > Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/confidential-guest.h | 19 ++++++++++++++
> >   target/i386/kvm/kvm_i386.h       |  2 ++
> >   hw/i386/x86.c                    | 11 ++++++++
> >   target/i386/kvm/kvm.c            | 44 +++++++++++++++++++++++++++++++=
+
> >   4 files changed, 76 insertions(+)
>



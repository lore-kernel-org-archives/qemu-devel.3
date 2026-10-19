Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF16606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PuNd5AMM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xItXd-0004J8-8B; Mon, 19 Oct 2026 16:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xItXa-0004Ia-LF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:01:03 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xItXY-0007Li-F6
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:01:02 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so2102664a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792440057; x=1793044857; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m8+Us3U2Pncbjo77qvwp3S+xeyIDBlursH67bOY+7p8=;
 b=PuNd5AMMmRowARLrJu23DTco4L2nhiUH9gtHyyIMBDpEBExAQfqUBWP3OpS6tTLH6K
 P3n6SAPA7KL8+UumEu09RA8GnMUZLILItip034HnDhVnVU8zwrqVSZ0HjDjrgRgye+P1
 JuVgPRNKlG3fLhJQ/se82+yzk5Sr3X9L/HiOFIs006mhSu61DN7d+5jvRfsJrc+i6EEO
 26yZykbHWqTVR8EWSMunOJzyL+gpHcpAT5Z65NA9F0EvU5cx3bzr0wDphgcy+Dn2Mr2D
 rfZw1hgGgtG5G9uAPDlP5P3PPqRUG+Cw77IxllN4sMp8ogOmMol5pAZiBh8PK+pDg9Yc
 /IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792440057; x=1793044857;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m8+Us3U2Pncbjo77qvwp3S+xeyIDBlursH67bOY+7p8=;
 b=DX2L1kyd2jnrg/DQnkjouXbrwPzd/ft0ExwtBiEBWnuTE6NRDD9DErvTQFlmO4+W32
 qRclyaTqYrfrp29v2mVszQvtOr/juUt+Yc5UDdfXjhoB5oODH/rkHk3adNsatt00eyYS
 4a0VFAgLKJ+JPjgLJnBxKJMf3bK4HWDDDYHXPZDuBhzKpBs0fizKEEh2W7d0YBnXMgqc
 LG01CwqrbV6wN07ntr0izNsHGuCLSw79f8kYih3RMY7wDzYd/s2gG8B1zklAM7HYPoer
 m+lD0IzQElH5AVtnjuqO1AXA4XPlesD9TfubQN8TgMSzc3U56PYIUT1Kxf49LYMVyHXw
 Ulog==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9VvG0g1SqyvHeY2cmL1zsXfKFJobbDCUrKyExmHo4/skE53aJhC6opA23baSu0dZsi6BqRLe3GY11@nongnu.org
X-Gm-Message-State: AFq9FYLavNTJYiQ6qMMLUc8ErafksbjkpIj9OuPhwx/PFABMrdtGZhRd
 NAia3PT7tAHMXtmluHSsqrj9blO3tdmod9ygEMC780LXRJXRUAEWc2NJGKOhVLOkXH4=
X-Gm-Gg: AYBFou2sVM5kifsgqWwlm+U3yVwZJvG5a6DAGiW8wBcY/pWcs3RtVnz6uFdVgCRbNGN
 /WaIW3Rj/jNr5HSDoC6eepyacYApwq+AzBwb8U0ZNKIOg3b4W/lir/l6kXFFr/+llaj92lxt22d
 4Bb/9cYmRquLQ49Gs2nlzZ1t9Af08uO/42HSKsKU1abzauOFW+C/pb/Sk5lpAxbCtbsbCwekP/e
 3+/CtRvdRekwgCd90EL8lov9rPXTh1t8Y1joV5MgGHrz3CsH3pR7HJtK6XmPLQaCuZ3hN/C2cAw
 jeqt7XyrS5h41t+UVpJnxvdnQlYIUb94CHDn/6LzLBtDrHHSVLHmo/nnSgWDQbSWoPniLnzt+AL
 D96pZ2BJfmnUWtjeiJHWTUa+khLRyp/aLm7LlYpegC7lQmJJL5cbO31h+C2QtJ/BZZ0d1O2Ms+/
 rb52+AD1IAkvvCxyjIdJ3wCJgCj4u2+k722bGxtsfoqdO4MZh6N/UfJJY6CX1CqtPTedPoCpGVH
 g==
X-Received: by 2002:a17:90a:6082:b0:3ac:ffb8:183b with SMTP id
 98e67ed59e1d1-3acffb826b6mr3745980a91.51.1792440056725; 
 Mon, 19 Oct 2026 13:00:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5410:6440:73bf:119f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f90a6bsm647159a91.13.2026.10.19.13.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:00:55 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:00:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical
 address for RME
Message-ID: <atZ29B8xDwCoH6kF@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-18-mathieu.poirier@linaro.org>
 <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6fdb508-0036-4581-9c91-bbf74de1e0e5@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 02, 2026 at 02:19:11PM +1000, Gavin Shan wrote:
> On 9/4/26 5:36 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When RME is enabled, the upper GPA bit is used to distinguish protected
> > from unprotected addresses. Reserve it when setting up the guest memory
> > map.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/arm/virt.c | 20 +++++++++++++++-----
> >   1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 61751aa31e0d..cf3a9320dc3a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
> >   {
> >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >       int max_vm_pa_size, requested_pa_size;
> > +    int rme_reserve_bit = 0;
> >       bool fixed_ipa;
> >       int vm_type;
> > -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> > -
> >       vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
> > +    if (vm_type) {
> > +        /*
> > +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> > +         * Reserve the upper bit to ensure that highmem devices will fit.
> > +         */
> > +        rme_reserve_bit = 1;
> > +    }
> 
> "if (vm_type)" are mapped to any VM types other than KVM_VM_TYPE_ARM_NORMAL, meaning
> it can be PKVM in theory. So this would be:
> 
>        if (vm_type == KVM_VM_TYPE_ARM_REALM) {
>            ...
>        }

I agree.

> 
> > +
> > +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> > +                     rme_reserve_bit;
> > +
> >       /* we freeze the memory map to compute the highest gpa */
> >       virt_set_memmap(vms, max_vm_pa_size);
> > -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> > +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
> >       /*
> >        * KVM requires the IPA size to be at least 32 bits.
> > @@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
> >           requested_pa_size = 32;
> >       }
> > -    if (requested_pa_size > max_vm_pa_size) {
> > +    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
> >           error_report("-m and ,maxmem option values "
> >                        "require an IPA range (%d bits) larger than "
> >                        "the one supported by the host (%d bits)",
> > -                     requested_pa_size, max_vm_pa_size);
> > +                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
> >           return -1;
> >       }
> >       /*
> 
> Thanks,
> Gavin
> 


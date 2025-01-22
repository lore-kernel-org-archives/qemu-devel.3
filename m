Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9346C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tac9C-0007si-DG; Wed, 22 Jan 2025 09:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tac99-0007sF-SR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:55:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tac96-0007kh-Fp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 09:55:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so51658545e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 06:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737557754; x=1738162554; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=egJj4a82EYatey7PDURldUikhwUZAVn4jZM8rkct+9Y=;
 b=fZr8BmDFp4Nj7WFyTGEZvAJFEpdi4YL2q6INZsikaX7iw5YBLjZrpIQWpfxG1csks2
 2ntYc0IzIDFd7wski0fzQqRxSlkBhCyf1qqqwxY8CcGSIFu3D7AvO1/sFsqrCGFChLRI
 9xwqCdGUxwKMl0Whp0bgV6qeaZb9lJvBwPzOjVgKcP03zcnBDwJWOY7N9aIjnmdHZD1N
 YtxLXAVSdMyjPP71QGNHyyAfSh+MCPGtY16BzuMfW4XJ2V62Ai9Frqf4xXFcqtKEKyIs
 vBfiv/ICioo8T0TKfBl3RAJNfRrNI/xmFf5KF5wmPMdfvMU2S7LoyxWKubAGA5OVC8lb
 y41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737557754; x=1738162554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egJj4a82EYatey7PDURldUikhwUZAVn4jZM8rkct+9Y=;
 b=GvmS3AKE/slyaRbB8Px95lHYqX8V09pgSbelHr9B5fdDDRRPPGjuboPB6bjZlY/d/1
 U9o6Woc8+XfpBA7nnlPEexEKX4bQscywChAt8tvKLmce+mt+q3AC7o9TEQYraltaj2au
 KcHafVQUut6o1ecF/DHD3SIcuuCt/2562gRFC0TFF3gHiEPn5nsIFbfdNEduNtpXQd90
 nMiBnkB5o+MvTvTKidMoYujXZ8b887XQSzqcWBEotslLc5bXcHhBuxhV1cLWXrtEi16M
 qRk6BvK2+eB3/co04TIYcHxJ1AEOCvJ2fuojLoAjwLfjY9u2YtkOAbJHHwKAC45k+zx4
 WuLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa9gqp2HhkKzGfFnVO7E83AJ5RXQI6Z+I8Ue2QH2BC1WUVMHkHhpgDgzjTMBbSG/QhHU6hRnNrM/FH@nongnu.org
X-Gm-Message-State: AOJu0YwNnzfs5BM2nhrKGYp5GocbzQfSo0KC4gLLJUGy04P24x9qweJB
 zXuXY3RWhPfpzuB+zhHnxyMuSqezj6fjTPlvrrad5Qo5pFNPDMf8zIBjAxNzQBs=
X-Gm-Gg: ASbGncvSvwcDK9EWkKkz+/IImnLLT797asNWTBMaY0HwGJbjp9U2rr+JIHL/72kSEbt
 KnFgzL0+GXSlpku3vIknhFX+6y6xO/c41YrEeFwC/qXjxVVPV34G4BedzELpQG5g3J73uRr9UnQ
 u7OAisrPyPeFMn1P8TI0MBOLVWyL0BdHMYs58PlDHNegfb5cr9fzm0f2FJ8aqbsA5numDz3Vyka
 0N61VxtzyrukVr/liUFkS8U0U8XzmOda26vSyV5Z+TRgVeBOkwO09Ug4dYH4FTisA8d9YogoOhK
 230=
X-Google-Smtp-Source: AGHT+IHrtFPSJQYW32HgWP5LXT22fBp6dNWGOwlKmAUk/RjmVooB/TxsHOjkwGdTNu7gnbS5fesuPQ==
X-Received: by 2002:a05:600c:3c94:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-43891439f04mr172758555e9.21.1737557754172; 
 Wed, 22 Jan 2025 06:55:54 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31c7c6asm26795495e9.35.2025.01.22.06.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 06:55:53 -0800 (PST)
Date: Wed, 22 Jan 2025 14:56:18 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v3 17/26] hw/arm/virt: Reserve one bit of guest-physical
 address for RME
Message-ID: <20250122145618.GA873449@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-19-jean-philippe@linaro.org>
 <bed63115-017a-4e80-9581-680fd6f29f4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed63115-017a-4e80-9581-680fd6f29f4c@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi Gavin,

On Fri, Dec 13, 2024 at 10:03:08PM +1000, Gavin Shan wrote:
> Hi Jean,
> 
> On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> > When RME is enabled, the upper GPA bit is used to distinguish protected
> > from unprotected addresses. Reserve it when setting up the guest memory
> > map.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   hw/arm/virt.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 9836dfbdfb..eb94997914 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -3035,14 +3035,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
> >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >       int rme_vm_type = kvm_arm_rme_vm_type(ms);
> >       int max_vm_pa_size, requested_pa_size;
> > +    int rme_reserve_bit = 0;
> >       bool fixed_ipa;
> > -    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
> > +    if (rme_vm_type) {
> > +        /*
> > +         * With RME, the upper GPA bit differentiates Realm from NS memory.
> > +         * Reserve the upper bit to ensure that highmem devices will fit.
> > +         */
> > +        rme_reserve_bit = 1;
> > +    }
> > +
> > +    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
> > +                     rme_reserve_bit;
> 
> For realm, @max_vm_pa_size is decreased by 1 ...
> 
> >       /* we freeze the memory map to compute the highest gpa */
> >       virt_set_memmap(vms, max_vm_pa_size);
> > -    requested_pa_size = 64 - clz64(vms->highest_gpa);
> > +    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
> 
> ... For realm, @requested_pa_size is increased by 1, meaning there are two bits in
> the gap.

I think it's a 1-bit gap: max_vm_pa_size is decreased by 1 for the purpose
of memory map calculation, and here we increase by 1 what comes out of
that calculation, for the KVM IPA size setting

> 
> >       /*
> >        * KVM requires the IPA size to be at least 32 bits.
> 
> One bit instead of two bits seems the correct gap for the followup check?

Yes this check seems wrong for realm, since (requested_pa_size ==
max_vm_pa_size + 1) should be valid in this case. I'll fix this.

Thanks,
Jean


> 
>     if (requested_pa_size > max_vm_pa_size) {
>         error_report("-m and ,maxmem option values "
>                      "require an IPA range (%d bits) larger than "
>                      "the one supported by the host (%d bits)",
>                      requested_pa_size, max_vm_pa_size);
>         return -1;
>     }
> 
> Thanks,
> Gavin
> 


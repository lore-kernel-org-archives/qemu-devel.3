Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26A6CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtTq-0004tE-My; Thu, 23 Oct 2025 07:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBtTk-0004sg-Vc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:27:37 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1vBtTi-0007j6-Pd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:27:36 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3c978f55367so424472fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1761218853; x=1761823653; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sY0R1iCadEwKjmswbPNallgydnb2h51wAU0Tm1ZwDMA=;
 b=CHrO/ct3/QukmZoH9MF24Jzc/eP/AoNO57nRjf0lS848btvrW3t9wlwAv+ZrcJ0dIW
 DePEq+FDKBJEL9Wt0JqdqXTL4dnKq6FTes6n+TCsKfI+ExHgKtUOczHlAoNlkmleZVXc
 JizVfYSutKikOROSnh5/Sj951l37U8Ptm5KHfB30Ayoc1caYOiNFMrtN8DhOm+LAy0sO
 4XB7MvuKejgscOQ4YtWb+ZBik0e9diewbKbK+gGWVZNolTjfICOMjMXlEcDGvWKPHNi3
 v6RZb2tVYAYI1XPKipcGoFNRYPINZQAoEksskxdBEfsrLjJNA93nBb7PfgygoaqWStQr
 JNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761218853; x=1761823653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sY0R1iCadEwKjmswbPNallgydnb2h51wAU0Tm1ZwDMA=;
 b=SEPqjhAYHCSH/Ee806VCNc72nsQ5xOF8XLNsRVw+q5Jb5J4CQLeo79071gmNarhsgr
 x5M63Aw4yTva8g47cYFEijQeoG1FlLht6O6sqhHI8HKQ0ob6WyqdU9g4hxIevn8c3wST
 ObGMUkNLxkJUSO2/F12SMC8N6oahNusuhFNfgek3U28inr79PSGz9BxumeHjWIe2AzCm
 PVRBHdaoU9L8XrE763VG8GbLlDQD42I+sFtJFFDxXYcCux6LFZW99tMWzxjlMOWCqUb8
 jTBnbYLvMXP++HkJmvSVeieYsEc1pFFQCbmkTYZ9cmFQH+z/OWeB0XB/8tZ6BK0z1h4k
 KjUw==
X-Gm-Message-State: AOJu0Yy9WQTNe+e7IM2QYXicqyOTfmvN7ljq+tw1PSb16Z/eugCGQjcf
 CIU4wlxApzRvDVAL9ZkuyYU+6tzXn3aTWHe4uS8Q9h3UIcq1zfnoDXdRiHztKNf8n42t6iquEgG
 9UgfDFpNsjN+AeYIEHi47xw6Ad3HawuU9YHKGvx3BMAAbv7Ad2J90elO8RZ01
X-Gm-Gg: ASbGncsGZlfROpUd7cr3fKADZVoAfwIa+AwyZOzxdkeFffW7mRb9zWb3OWmBIoL70YN
 +q53VF0NmmZSDN6c7BysjhTnxOvU9mF344CAABz72ouIz/NE/FvWMTy0Jwpap9CugEuo4LIfbyD
 gDuWZ0Ir0nV5dlGXgJSO9hTsolxDitpNs7Xoei7jjP2QCSaaysLHZYr7NL77IBfnG6MhwdNJ3XQ
 iBL3z1impa/7zhzZBtE90rvqHrWAHUKIr6wd8bmQPycyTwCCVVC/58jKYa5m6u03ybBZoKWJSzs
 DsOTuhhU/Fo4fD/PstoyHud+fTY5bMkyu4POWTPqM+riNL+D/Kgx
X-Google-Smtp-Source: AGHT+IHYQSsjgzlxQeE5KrjCG5/Mk5Izu1cI3D06NYqUjyUougJrRjYzhox7YfKYRRHA3my3zwVSx72+KHv7exxqtLs=
X-Received: by 2002:a05:6870:6123:b0:35c:3928:478b with SMTP id
 586e51a60fabf-3c98d12ee06mr10855939fac.38.1761218852702; Thu, 23 Oct 2025
 04:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-6-salil.mehta@opnsrc.net>
 <a03ed205-b61a-4bba-9f25-83663b7d8a86@redhat.com>
 <CAJ7pxeYurHLqj8GnLrfznmofMpsaw91GeZ3KMyucL0B_gn9gPg@mail.gmail.com>
 <CAJ7pxeaUfUeXwtTVheCTxej-aCTCx0n8-XyAKaFneVUjcWL_7w@mail.gmail.com>
 <beab3dd4-0c19-441c-a9f5-ecae9e791753@redhat.com>
 <CAJ7pxeYEpJGhtL1-3qFEJYTzL-s19fF-it6p5dkq=fg384wBpg@mail.gmail.com>
 <CAJ7pxeZG1w++2DNVD5L5N3sEPRLYPFSFECLqFgh3BYgKpfJtog@mail.gmail.com>
 <5a13811b-628f-4e47-86b9-fad1ab7df244@redhat.com>
In-Reply-To: <5a13811b-628f-4e47-86b9-fad1ab7df244@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Thu, 23 Oct 2025 11:27:20 +0000
X-Gm-Features: AS18NWCB8gZU37rJ9KuOnLp9Gq_euh4HIBeGVBGoLKK3ahqwn2jWFpxq4tN6xK0
Message-ID: <CAJ7pxebfrSLG66t+7CQEGLL-ia4kqTAHRShxK76GcR0h=Dfk9w@mail.gmail.com>
Subject: Re: [PATCH RFC V6 05/24] arm/virt,kvm: Pre-create KVM vCPUs for
 'disabled' QOM vCPUs at machine init
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, 
 salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, imammedo@redhat.com, armbru@redhat.com, 
 andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org, 
 eric.auger@redhat.com, will@kernel.org, ardb@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, rafael@kernel.org, 
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, gankulkarni@os.amperecomputing.com, 
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com, 
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn, 
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com, 
 Keqian Zhu <zhuqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oa1-x2c.google.com
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

[!] Sending this again, to keep conversation *legally* correct,
as this did not appear in the mailing-list when sent from my
official ID.

Sorry for any inconvenience caused due to this.

On Thu, Oct 23, 2025 at 4:14=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> Hi Salil,
>
> On 10/23/25 11:29 AM, Salil Mehta wrote:
>
> [...]
>
> >>
> >> Ah, I see. I think I understand the issue. It's complaining
> >> about calling the  finalize twice. Is it possible to check as
> >> I do not have a way to test it?
> >>
> >>
> >> int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
> >> {
> >> switch (feature) {
> >> case KVM_ARM_VCPU_SVE:
> >> [...]
> >> if (kvm_arm_vcpu_sve_finalized(vcpu))
> >> return -EPERM;-----> this where it must be popping?
> >> [...]
> >> }
> >
> > I've pushed the fix to avoid calling the finalizing SVE
> > feature (KVM_ARM_VCPU_FINALIZE) twice on the
> > same RFC-V6.2 branch.
> >
> > May I kindly request you to validate the fix again and
> > check SVE works on NVIDIA grace-hopper?
> >
>
> With the latest rfc-v6.2 branch, I don't hit the issue. The vCPU can be h=
ot added
> and removed on grace-hopper host.

Excellent, SVE/SME and other ARM extensions have not been tested earlier.
It would be of immense help if all of these can be validated as I do not ha=
ve
capable hardware to test them.

Many thanks for your proactive efforts in reporting, reviewing the fixes an=
d
validating them as well. I appreciate it!

For anyone who wants to try, fix is here:
 https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v6.2
https://github.com/salil-mehta/qemu/commit/cd58e65a79c224a59407553c1a6288ed=
667b19ed


Many thanks!
Salil.


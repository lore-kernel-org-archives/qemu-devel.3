Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2850EC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhCu-0002zs-O5; Thu, 27 Feb 2025 11:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tnhCs-0002yu-NY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:57:54 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tnhCq-0001Z9-8X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:57:54 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dedae49c63so2023510a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740675470; x=1741280270; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5Cgz+tVOMD5ENHSy6XjdaYNEPAFKL0wzWZl6dcQkrCE=;
 b=ka+Exu2xsGpL1pzwQPJUrX6OTjdOukoeiPIC7aOED19+0f2zjiw+rczXW/Xo9gWO68
 RzQVVor10Wo7DnIiUZBMlkj0+Lnm7rP+SS2YBS2NlSyqSnjEwR+dGoj8x1uOPhLGqETQ
 59TEXEWbPJ7N3JCrOhvynRs9slrgM+KnyvkFCqiHaCLfW8QY9M3jZntY0dP3uG84Y6SY
 RmmkKRLQxiXtAmOfiUUA/2YWYtsjtndvwHvmh2mIgLT6jcTqoSJYbnubOhWe5Rg1m+mL
 Hx7URmoYzq2Ao6iGSs2QBzd+QzdayHCnZu7vI13eMY4EKjPxF408oZetpJRFEgBQ+acF
 qF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675470; x=1741280270;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Cgz+tVOMD5ENHSy6XjdaYNEPAFKL0wzWZl6dcQkrCE=;
 b=nWo/1nYoHpftM4+AK6c0JXvOuNCcdh+ifzOv7nwolBjWiARThzCCTKYXWCuR9p0f3J
 gzsLmtiuAMsr1uPaBYVRlCzVyt0qcjGftewOJ8B1JSuBsHuhQ0xs7sOr9YJcOQ34UYlB
 nLku+m5Kv0+MUK/9SsE0dZiwPE/emhcqTLjSQ4Xf/xvI+xBnvToJ9+miaovCRsium5B2
 Q1H1+UlYaDg931msWxeHn1A1+DAqKvLnIKkX5WV1ldwck42y3fpgH+OKZbleco/uZ1bK
 lLk02vnvi06MtiQZBbebgUccWTAQ+j9Cm7AkJc8ATXOcB3TzNAGETqeais2ehPnnGKvZ
 z8/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr3bO4xoW20UIAsnkH0NPvXl8zNN+0ZQoaeiqmaGt/LeV8sf4piVptOUQK5EBLsqg3z1Li6LwAD23y@nongnu.org
X-Gm-Message-State: AOJu0YxH7dFmxhhN3Gy7oOYQJ3GLLkfonp1rvIaOiRZaFWbLS4gnQZ5C
 U0nAJa2Oix3jcx5Jm9m8JoZkOMOFGInTpEJV6i4g/wWFl9DVpubf
X-Gm-Gg: ASbGncth0bRaCmSsKGMwAHsPS8wBnGu20hRtYGODqUlc8CXUQEKjxLa65qyQCBnYRXP
 uKIwkYLzCEGYvpYALstAfgibzorTWUkQz7cM2huDR584GWYn9y1ifMeBiQAcKzemM2yVQjVsaTJ
 Kfvxhh02fCa0RFH8+lUmrDtmZztvbXZhs1NfoKKIHSOFEY+nrXUfNae1BrS/1JSc5Z0sCp4+O2X
 Ec0WgAUYsedOFswBaH5vtSXf/8J+f97rIsFB2gmc1A7LSxOkEJI5AnOEQbUG5vfW0yYutghgl+p
 fSFHPIRiZj0DoeLpwWUoOW4OiJA0s8jOMk8WbPQQbdrXR5GV3yVPyBQ3aKREQThycM9nLa1f0hP
 Fl70rm7U=
X-Google-Smtp-Source: AGHT+IFoqcFF1a1SnBwVN073YQUKGQCPLBWt6b56ydwnsLYg1jhB/EScnrejzAsoRpPuws6rq3GYDQ==
X-Received: by 2002:a17:907:7212:b0:ab7:e278:2955 with SMTP id
 a640c23a62f3a-abf265c839amr16233666b.38.1740675469853; 
 Thu, 27 Feb 2025 08:57:49 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:d6d5:ac54:57ce:812a?
 ([2001:b07:5d29:f42d:d6d5:ac54:57ce:812a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b99c7sm149940866b.33.2025.02.27.08.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:57:49 -0800 (PST)
Message-ID: <40b8bf9854d4a83b55ae8e83f093462b5852a35f.camel@gmail.com>
Subject: Re: [PATCH v7 38/52] i386/apic: Skip kvm_apic_put() for TDX
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Date: Thu, 27 Feb 2025 17:57:47 +0100
In-Reply-To: <20250124132048.3229049-39-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-39-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
> KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow
> for
> KVM_SET_LAPIC[*].
>=20
> Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the
> path
>=20
> =C2=A0 do_kvm_cpu_synchronize_state()
> =C2=A0 -> kvm_arch_get_registers()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> kvm_get_apic()
>=20
> and it's already disllowed for confidential guest through
> guest_state_protected.
>=20
> [*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/
>=20
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> =C2=A0hw/i386/kvm/apic.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
> index 757510600098..a1850524a67f 100644
> --- a/hw/i386/kvm/apic.c
> +++ b/hw/i386/kvm/apic.c
> @@ -17,6 +17,7 @@
> =C2=A0#include "system/hw_accel.h"
> =C2=A0#include "system/kvm.h"
> =C2=A0#include "kvm/kvm_i386.h"
> +#include "kvm/tdx.h"
> =C2=A0
> =C2=A0static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r=
eg_id, uint32_t val)
> @@ -141,6 +142,10 @@ static void kvm_apic_put(CPUState *cs,
> run_on_cpu_data data)
> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_lapic_state kapic;
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if(is_tdx_vm()) {

Missing space between if and (.
scripts/checkpatch.pl would have caught this.


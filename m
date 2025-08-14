Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F819CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umYDX-0001R4-05; Thu, 14 Aug 2025 09:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umYDV-0001Qw-Cj
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:42:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umYDT-0003hV-1j
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:42:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so494743f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755178919; x=1755783719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd/dAHsFKKllARD+HySmsZSjKbhQHRFypNDcOl/ri9I=;
 b=kxcMqGdnZmuwz63GIzK/7Z+hIPA4LtsOqnLJ8dp0eP7pgJ0rzpv5q8sUa/sI2xCb5h
 3N2jLi/gdDIXEEUdkumddqfCecTYfww/di0l94+hGctiOdBPVB+cyc+HawkV28doWJVG
 fvoBJhJHVLW45qWCRQwBisxZivrshAO7fPbbY7a8SqlYgPFpzVL7RsyRQOp/auuZs3DV
 8Zq1aFxuLn40MWfHjSITYDCQUUFUfGg5R1ffnj7RVctWu8zy4fvEqbdWpf8wXdV6llC3
 DHprMs7uoIly2SWRS+hP5k8+4jBvqpmr2noSP+KCz1Pv+19Qj22DycU1h7GbRnpefbvZ
 PbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755178919; x=1755783719;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hd/dAHsFKKllARD+HySmsZSjKbhQHRFypNDcOl/ri9I=;
 b=C6qpwwrGm6iGqvOsqQ9bfVhk8Qxt5qgNKEFXSSEpeTAlDiNcgdjBLchTwLl11gVUHj
 zYT+9FV1Ztxp+k0Uwnj/Ne8u0muuL7LMGlb2LFNzdZHOAbG1wdnaYNMGVMyIPOPCLboc
 HmAQmwyWPI5LaP4Z0fjorQKhOYVK3ersmhuJTtL7ntg+t9uRs8PwDcHTcDem1MEYan1B
 HBktIq5BvdBzwZMeRN+eLx5sszExGcBEhN4+OKn21xjC8XkUYZ4MDKEyEWxpSUe6rkQT
 CnM0ipa+dQmRFMbzO8suaP4ZmPSMAnBvnM+TJWnbpzN9Twciew6NYiaiV2ongVzzlwn8
 PtaA==
X-Gm-Message-State: AOJu0YxXyx1OkAizLQbc5hBgC02RGiShys1ZJcpUIoZB13AUK7PEM8Hj
 NJqRmMWlkZhRmlguBMkiPPCwMWWh1NBRElbImbB9ikkIspKoP47s9HxhvgmERBmTs4w=
X-Gm-Gg: ASbGnct0ffN9ClVEbUDk6XhvBtpV4x8oGgx7T4Oseu0qT7rDZd9TPw9IyychmyKd8Qt
 mRwcMqudxYwm7y9QgwujuEndymab/Xw/b5jJ7bYTErLe8PWeynXFJZGIvCrKkZQ6V8ytRBCBxq+
 5qGEemcvKicXLNuPG5+KqhCmilQgQf/XvkO6zOlzsGHKKXiw0lpYN/E4vzHSe/4onhr5t9pVHQq
 Hhnn9BL5VLp06TOJ6tA2HoE/VQ3mfvwFSYMqdz+YybqQ/kHMjDr9BJy8KeM5wBklK7MiBwI1EJc
 dzRutpaC8eyLm+D9PcXZtq48DLmClVia5iXy8YY0PuJ5+auoYwihplZCuHzIShA76GdDB8RQFXs
 BZzZ1DXe6wF0xovFX2m+zNO4=
X-Google-Smtp-Source: AGHT+IHIaox0UKCIZtqxNesAbupfvnd5vuoWkmoE4/OYiac2694qe1LaHlVoL06WSJFWouC1r8q8uA==
X-Received: by 2002:a5d:5c84:0:b0:3b9:13d6:cb4a with SMTP id
 ffacd0b85a97d-3b9fc36466bmr2635956f8f.59.1755178919053; 
 Thu, 14 Aug 2025 06:41:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c46ee84sm49611830f8f.57.2025.08.14.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:41:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE4BB5F7F9;
 Thu, 14 Aug 2025 14:41:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: ~myrslint <myrslint@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~myrslint <myrskylintu@proton.me>,  Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH qemu v2 1/1] Default disable ignore guest PAT quirk
 (second revision)
In-Reply-To: <175510851329.15645.802219111760057966-1@git.sr.ht>
 (myrslint@git.sr.ht's message of "Wed, 13 Aug 2025 17:53:59 +0000")
References: <175510851329.15645.802219111760057966-1@git.sr.ht>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 14 Aug 2025 14:41:56 +0100
Message-ID: <87plcy3tqz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

~myrslint <myrslint@git.sr.ht> writes:

> From: myrslint <qemu.haziness801@passinbox.com>
>
> Thanks to Alex Benn=C3=A9e <alex.bennee@linaro.org> for the kind code rev=
iew
> and helpful guidance.

This doesn't belong in the commit message, you can add it bellow the ---
if you want to track the changes while iterating a patch:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#id21

> This is a second attempt at addressing this issue:
> https://gitlab.com/qemu-project/qemu/-/issues/2943

This should be a trailer:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2943

bellow your signed-of-by.

> Most Intel CPUs in current use have self-snoop. The few added lines of
> code also check for availability of the quirk disablement option so if
> some CPU does not have this feature no change of behavior will occur.
>
> Signed-off-by: Myrsky Lintu <qemu.haziness801@passinbox.com>
> ---
> Hopefully, I have improved the patch based on kindly provided code
> review.
>
> The only point of divergence is that per
>
> https://www.kernel.org/doc/html/latest/virt/kvm/api.html
>
> this is a VM capability (section 7), not a VCPU one, so a call is made
> to kvm_vm_enable_cap() rather than kvm_vcpu_enable_cap().
>
>  target/i386/kvm/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8..124818bf94 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -16,6 +16,7 @@
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include <asm-x86/kvm.h>
>  #include <math.h>
>  #include <sys/ioctl.h>
>  #include <sys/utsname.h>
> @@ -3367,6 +3368,24 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          }
>      }
>=20=20
> +/* if kernel version does not have it there is no point compiling this i=
n */
> +#ifdef KVM_X86_QUIRK_IGNORE_GUEST_PAT
> +    /* rationale: most x86 cpus in current use have self-snoop so honori=
ng
> +     * guest pat is preferrable. as well, the bochs video driver bug whi=
ch
> +     * motivated making this a default enabled quirk in kvm was fixed lo=
ng ago
> +     * */
> +    /* check if disabling this quirk is feasible and allowed */
> +    ret =3D kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
> +    if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
> +        ret =3D kvm_vm_enable_cap(s, KVM_CAP_DISABLE_QUIRKS2, 0, \
> +                                KVM_X86_QUIRK_IGNORE_GUEST_PAT);
> +        if (ret < 0) {
> +            error_report("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
> +                         "modifiable but we failed to disable it\n");
> +        }
> +    }
> +#endif

This looks good now, I'll leave it to the x86 maintainers to decide on
the automatic enabling of this feature.

> +
>      return 0;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


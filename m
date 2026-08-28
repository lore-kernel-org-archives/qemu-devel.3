Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61471C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztfM-0000lI-Mc; Fri, 28 Aug 2026 06:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wztfJ-0000kx-Ee
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:18:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wztfH-0002Rm-K1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:18:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso5864535e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787912306; x=1788517106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hK1gCAEqj075H2vT8s7bZJBXYS7QjP3AZi4u9ZclhdM=;
 b=uNV4Zx9Zswx8+SMgEZfbDgnh7VfFb8c340HgqiBme7LjeMZhO+dYrdrWM4Uo9fGhO7
 LnRT6vbJQZ0Fvp+BKmBBIptkvVxZqTUm5LKy+aPSOIRvnpYVMc6mzkm/CAS9fObGUU7m
 +mGzDqsFhCtU5iv6Ze2kGlmkSljUOBrDKrpJIDLxno8muXFULpiHeVN/uacmk3TOIrnR
 GKeABV98Yar7ho7DJs0EpDaGHPdBSQYtHE4fqMfTyJiZhbmyA4LfehSDNCE2+8DhIZSh
 JdBB+12ffIAALYrd06lc+tMFaS8r3Ivchjmknfnse2YFHCVAebTnWDVyUBnqQc60dIP0
 0WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912306; x=1788517106;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hK1gCAEqj075H2vT8s7bZJBXYS7QjP3AZi4u9ZclhdM=;
 b=JuFR9NR3PCeDtpSY/tAynKkKLY/J6x5SUjlCCNj63ptA65ML2Mj+z9uQR8ERQVbt/M
 FRWiOH0Kfb7v9d4UhgfZ+1c9fmHybG8IcfxHutoNjB0rkMk37ntzyLjomsuZVvPMFNNu
 LaOQF28wNpNM1WTWAC7/AapTdPXXks02qO8T1K1XmEwUTKNv7OyYpBqprA9rTS1mh7Sq
 3Y8SX5NrOazKh2/bboXZO7ItZkhcSuuGy7xGQ2+TsJoHcvqCcz2pKIHjva0281T3wkQR
 IJBOJa6V+xIC7eCiUNWLdTuMzgSG3ZSTX1teBtkn66WmPS+zW5QLAUthXWo/NOk5BRIV
 JDVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZgKyWNn769KYAfoQNzq0z5aHny1783/yIc51mZdwreB4q/TJJPCo4EN2t6Ul7rMxBoYW3Vb/T3Xz+@nongnu.org
X-Gm-Message-State: AFuF++lUhjgPyEMupX+u6t9aHggyEoouvAs2eVQ2dOub/BAf26fLd4Yn
 VH2sBAxuCMAo0ulNaOv5xfm2I7WeRse1+w2HfQLr4jg5vDhGceNZtPSQMW72Pi++85A=
X-Gm-Gg: AR+sD11L2i8gEMu4Asz4o4KYdzYYVD2aKULw8LaqGu7XjXlySVt2ceDSJf5m8tjewIW
 DKUvuGLiz3i2E8MU7hRbKIilwQX4eK1/1RLsnY63kHDCbHl9HqNKzOrINF5Q+qDnCA+XCxEdN/G
 0COWP+kV2EWHJ2KTc35hbkX9tgHB31+YRQH9cwiW+61I3vjhnmZc04Rm69IlZgCaqfxI0EUYxCM
 OdhIui5nWVYw8FOKUhTAUY/ZvlLhSLtqklo/0A7YVDGCbHGPQeu9yVVcoUP1HLgWXDx3I8zlc8D
 KTMrm8KL2yi9Ujsy/lDGq53pfEa/DnbEzs0Y7sz0yD6+7QdHNqyEPh01pL4eYTIFFk5ZIxTp07C
 npkLmuc8BE8C/RinkUqivgpW50MShH57bjtJDb6wDD4tN/OZdLWzriI6h4dwmV4h8qweL+EQ5w/
 8QZx+5/JqpK6bHVTzMxQ0uXAIjetP+q+9X4mIodSf2t2WDLkLOceaSrqgORO6X
X-Received: by 2002:a05:600c:4fd2:b0:496:c9cd:e7ab with SMTP id
 5b1f17b1804b1-49b91c22421mr86976965e9.5.1787912305557; 
 Fri, 28 Aug 2026 03:18:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d06sm53879335e9.12.2026.08.28.03.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:18:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A54095F7E6;
 Fri, 28 Aug 2026 11:18:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Andreas Grapentin <gra@linux.ibm.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  eric.auger@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 philmd@linaro.org,  qemu-ppc@nongnu.org,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Steffen Eiden <seiden@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
In-Reply-To: <7ce963fc-cca4-43df-8e03-36fe09dc80f1@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 20 Aug 2026 09:24:05 -0700")
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
 <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <29fca8f4-9730-4090-8c89-813ba5c248fb@oss.qualcomm.com>
 <aoWvPGCSA54hg_Dc@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <7ce963fc-cca4-43df-8e03-36fe09dc80f1@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Fri, 28 Aug 2026 11:18:23 +0100
Message-ID: <871pbi4kgg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 8/19/2026 1:06 PM, Andreas Grapentin wrote:
>> On Aug 18 26, Pierrick Bouvier wrote:
>>> It would be better to keep it as system_ss, since bringing back
>>> specific_ss will break the single-binary compilation.
>>> It should not be needed to rely on target config within the C file
>>> directly. At least, we didn't meet any situation where it was.
>>> That said, there is nothing in CI (yet) that prevent such regression,
>>> but I would appreciate if you could keep it as it is for now.
>>>
>>> If you need to filter a specific function per config
>>> (host/target/whatever), the right way is to isolate this in a new file,
>>> and condition inclusion from build system instead.
>>>
>>> system_ss.add_all(when: 'CONFIG_X', if_true: [newfile.c])
>>> Also, you can add associated stubs for other configs in stub_ss.
>>> stub_ss.add(files('newfile-stubs.c'))
>>>
>>> I don't know the details of the series you sent (and too big for me to
>>> take a look now), but if you have a precise question on a specific
>>> patch, feel free to reach out to me by email.
>>>
>>> Regards,
>>> Pierrick
>>=20
>> Thanks Patrick,
>>=20
>> To give some context, the linked series enables s390 host linux KVM to
>> virtualize guests with different (non-native) guest architectures. So we
>> would need to build (on host architecture s390x):
>>=20
>> a) qemu-system-s390x with vfio using asm-s390/kvm.h, and
>> b) qemu-system-aarch64 with vfio using asm-arm64/kvm.h
>>=20
>> which (based on my current understanding of the code) would make it
>> necessary to build the kvm-helpers in the vfio code twice, once per
>> guest architecture s390x and aarch64.

These are common KVM API headers aren't they? Which bits do you need
apart from the ioctl #defines?

>>
>
> Depending which functions/constants you need from asm-$arch/kvm.h, the
> simpler is probably to expose it in a proper API, and then prefix
> symbols per architecture. Finally, you can have a dispatcher function to
> return the right value:
>
> void kvm_get_X() {
>   if (target_aarch64()) {
>     return kvm_aarch64_get_X();
>   }
>   else if (target_s390x()) {
>     return kvm_s390x_get_X();
>   }
>   g_assert_not_reached().
> }

This is basically KVMCPUOps (like TCGCPUOps) with extra steps. I suggest
that is the way to handle the abstraction of kvm_arch_* functions.

>
> However, it does not scale very well if you need to expose a lot of X.
> You could also generate a struct with all values populated per arch, and
> use that.
>
> What kind of information do you need to extract from this header?
>
>> I understand that this is a problem for the single-binary efforts of
>> qemu, and needs further thought. We are currently trying to come up with
>> an approach that more closely aligns with the single-binary goal, and
>> any advice you could give to that end would be appreciated :)
>>=20
>> Of course this problem extends to all components in qemu that require
>> architecture-specific components of the KVM UAPI.
>>
>
> We didn't really meet any issue so far with this, but maybe it's because
> we didn't yet to mix two different arch supporting kvm. In all cases, we
> take the problems one after another, and we don't anticipate things - it
> proved to an inefficient approach.
>
>> Thanks,
>> Andreas
>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


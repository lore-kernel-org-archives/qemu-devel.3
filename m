Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D2606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J0jwKsUs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMm7s-0002Dt-Pr; Fri, 30 Oct 2026 08:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMm7q-0002Bs-1U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:54:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xMm7o-000315-86
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:54:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so5600325e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 05:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793364865; x=1793969665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HvvNtK7qsTKog+CaLgP1+WE8JKsSiGjYF0P2PbDEf9U=;
 b=J0jwKsUs5UvwJR6RDnhe86fn8xXyg/ejDw29dXg5YJMxIPur33rm73tYWRf8G5ZDw4
 Ov0M50RY6WlbUPBpmS5AXN1ns5plbabc1WvPPr/clGvjWVkrXO5h/8uVv1OD0ZdaPvdG
 7h7/5BI7T39Snx69qBhGFGs10Ni7+Nr+M7CEuuBjskXLFyYFoGjB0HX5NC81roBrzS7/
 +662FOrX2QJqRtRTuzblqQSy6DziKBJ9TU0E5YW6itAcBDz608FPC9S2gnaMpnwn9j8y
 32/34rz+LjcoB4Hp46Ay2EUFVXPsOrKTR8AKxny3AUHrAuAtznijqZI8f6k0via2LEDJ
 RxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364865; x=1793969665;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HvvNtK7qsTKog+CaLgP1+WE8JKsSiGjYF0P2PbDEf9U=;
 b=kwiDgdF6uhg0RFltnh0p9btuUNN6R4Tu1AM1fuobZE1xxwWYtF4DydhiJQUce20555
 uxnnaw7o0ZqdUjQUmk256ZGECakGjcrqKwJ93FnQPQTi+QQrjdkiDtnCUnRBqRiAgOGY
 qrKdoMqc3h7wgvCiBRroJIty/bnB2ArtKa/iYcxaIQIqbRwcNvL7v6/OBZUam23DztKH
 hrpCse9rkI5V0kyDNWEDNpAOvH3IjD+n4nf2XknyM60TN0FDZ9pG238BiZ1F4rgbMoTJ
 B0qeG91wlWUv3DN9Vwjui5aI1JawKV8VkUlGQYnhWjmu4veFFthajRMu+OJfsPJUD7hv
 Ph0Q==
X-Gm-Message-State: AFq9FYJIpKrzTniqbffnm/AZ1Iq1dZ0uF9EWGeYU+TsXUiMkf+tf7fuz
 ksOyGl0WWH4wAMq/iZAEGZia3FZJ+/8f+xctsTTLSc27nbRUHTeTHgWp3waC9MDhMEW2INHblAY
 cEAILDW8=
X-Gm-Gg: AYBFou2YrpaLa9uPaUwtPozgsmr+0b4joTr57R+RjXhia3OemsmG0DErGogUcMXSThN
 Cm1t1UHNMfRoTX2F941uJAsRNTsBo670+E7Jsi5THdPDTP10BLNQq4EYqWew1N54DkLJGD75CKQ
 Pd+dw9unU+wWwssAhmdY66MM9ZmH5X/VqCBjFrdojUrS94rvNeLaeLmnd3CM6QQhkvQqSyfLU1t
 zyQCuu46dgdUodn9gkiESt0+HkutfzNwedRZv1EAvN7IyX9y5n6kfXRms4AWObEHJi2yrJjc7+J
 fxmSIdYloWqQWqqsL7acyWFfPIUSvMa2H2tR71bbaU7oMCkxIrc/6/brSBcD0r6gyLlgt34Dk3u
 Zk8gd6jpF5M4TnfQgJ2cxfHWqyhQtmSrQnlulKvxdQ2GS01EG0DxL83DS2Z5G34LBc7KYxcpF/F
 1fppRGDlq5CBpZjKNm90XWpFw+u5MArHgkjt+Dd3+D34Sslst3pBMsHgHbvjVmrwRruZs72VIOV
 1rTGOU8rc4M98qyzKBKiJ8vxzhNNLmhZfzN/ShpRIxb5UfNIJH6RSXGVUG0LrCdZ781OAH3tP4V
 TBkv7bRdNo59qQKk5EJ5GyTILIOu
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ac1932b43amr48669835e9.31.1793364864964; 
 Fri, 30 Oct 2026 05:54:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1076sm62424045e9.6.2026.10.30.05.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:54:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E30C5F7FD;
 Fri, 30 Oct 2026 12:54:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] target/i386: terminate a tcg block on gen_RDMSR
In-Reply-To: <451d1cfb-a94e-40c1-bb10-a768c5701f9b@linaro.org> (Richard
 Henderson's message of "Fri, 30 Oct 2026 06:37:07 -0500")
References: <20261029171737.2126803-1-alex.bennee@linaro.org>
 <451d1cfb-a94e-40c1-bb10-a768c5701f9b@linaro.org>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Fri, 30 Oct 2026 12:54:22 +0000
Message-ID: <87fqxn8i2p.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/29/26 12:17, Alex Benn=C3=A9e wrote:
>> End the block the same way that gen_WRMSR does so an IO access under
>> icount. While this fixes this particular case I suspect there are more
>> IO like accesses the x86 TCG front-end should take care off.
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4779
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   target/i386/tcg/emit.c.inc | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
>> index ed56edf8a3a..911bce5f539 100644
>> --- a/target/i386/tcg/emit.c.inc
>> +++ b/target/i386/tcg/emit.c.inc
>> @@ -3783,6 +3783,7 @@ static void gen_RDMSR(DisasContext *s, X86DecodedI=
nsn *decode)
>>       gen_update_cc_op(s);
>>       gen_update_eip_cur(s);
>>       gen_helper_rdmsr(tcg_env);
>> +    s->base.is_jmp =3D DISAS_EOB_NEXT;
>>   }
>>   #else
>>   #define gen_RDMSR gen_unreachable
>
> You've done nothing to update state.  I think you want
>
>     translator_io_start(&s->base);
>
> which will go though DISAS_TOO_MANY.

Should WRMSR do the same? If not why is it different?

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


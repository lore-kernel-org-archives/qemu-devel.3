Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1285606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aTJjT2YB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRuEV-00014v-Kl; Fri, 13 Nov 2026 11:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRuEU-00014i-6v
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:34:34 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRuES-0007Yg-HV
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:34:33 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b30ff12f84so8988977b3.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587671; cv=none;
 d=google.com; s=arc-20260327;
 b=YF45POFAXAQQKb6rqhCPr9vwU3e8e1pXp8kPQ0GTgyDwrYdDZP/wSE3Fxt3/kOsbvC
 yI0lP01QJAXH68emIzvxZPqlibnLJ5AmuZGfNVTfSPPKVbyeCCEhCmtq7KQ3cEDIkbuS
 xv5Ig2TR08F3ScSj3IMiJw5iOs4whGKQ1TykDcxJtntkTO+dAa+uihJqtPf7UdRnXeRI
 cigUjd/wWhcnDOE7vWCDK992vIQ/i5c4bgn4B4V08n9HoY6w39+JKQ21Iez02P4mE6/D
 vXTF693lAeKDsHGHYfY1wNqqun/Ar9lp4YwC3nB/9mfZ2Ga5Oz8//ahGQQ6eCU5b49aM
 r7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iR4ruVj3mZwj0vu5l0aQqkmmtyRH7YMiwi+aizYCkAU=;
 fh=hsB5Cjbiv2lE513iZTHeCPbP4VsCh9HQj1vpKez3KkM=;
 b=ERJZGJhhSfiO1rqbkeKsFTBF9pJvWQAlRu1fwMsAfoiTqt/kSgZkXFrYq9SQoak+Br
 k4wFLGfth7IxsZCLrRBP5h1fdfiVhSKlSQXWERyMGC4xvWe2nZvCeT0zoHVXGEy9bk/F
 3r98yZQKppdW/peNZyGaqmJtRMOhrM8fQ6m3zWqJ0midvGQfXIGmADpH60JfZPCj/ZWs
 SdG4eydZGFTO0roySBRt24JPRmpA8JG1sm0Bs49BLzBnTg3KRh54YynqVgKt/iSNw5yh
 SkVqy6YiO235sni68l1RAM7EFQpgTABmlPuJYull+pc5jBPQYSdq3LuIeaCtobVO2jZh
 c9uA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794587671; x=1795192471; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iR4ruVj3mZwj0vu5l0aQqkmmtyRH7YMiwi+aizYCkAU=;
 b=aTJjT2YB5siOJIasvBOLzezbbksNMTvI+mI3LcZctS2Ttk/6QskWNcefBZR8QXFGBW
 MJ1mZG7EeghUJtlQQ/HZAeRAmuwxO843Wv6EIrarBUBSAfsa2ZhKHYlnC9Gi4rOvFMDJ
 TLnq7ud6su2Oj1gX6osNQTk2AAGoHDghuWEepbsUT4MAOG72jEe6pHm7AbgiLBbfzP19
 qyF3PBx315xYJnRIB91brCZWD+NCgB6KfBgIzIPTY/KDLUJLZwD2pgdcLUd8fZHnZwoh
 R3qRvDWc/Ane/DiTgLQZlLs3qhy7lw/z66jdkBZazsQb98RyHj1wSrrVu5mJSA//CpBO
 11pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587671; x=1795192471;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iR4ruVj3mZwj0vu5l0aQqkmmtyRH7YMiwi+aizYCkAU=;
 b=XZMyyYAkInOa+Lgf8d2ufQr2mVRWB4H/7NyqYSTgAnveI1WxrKRzRQuFYtt7RbjcuV
 zv+Yb1Fgb/5VR+01fPHo5/oI+LZtpI/6nS9PzDU3CrRpWDykCptTzzsJqDKQYhrY8ozP
 v/086iBlnChJR+nU/shHtekmuV9o+rSRZnYBWgVOK74dNisam7BECwq1dB0DjLgqTQlZ
 qL988hxjfevdSV/nUqV0KurbUwUr/QsYpmY6vQh2RCSDqJQi8INqj/6Rxh5xd5cUzrHh
 32mhQEz3RD6yqWolef/vi0KfACFYsjtaDI4o4ax/opMIvebjiWrn/IWf2XNhjNHNI3JZ
 FbOA==
X-Gm-Message-State: APuU4Z8WCnuLp/iNPpLDU3Iz5g2c4Ek/uW1SfIfR2CtMM6d0Q8dj3kva
 +Klo0p7+gsGUsRMqWnw5cErjvKOjqNhK2FQmP256NBPjuow9ChcTQB5L3ulgI6JAIOTLbKjd2Ju
 yd4Ht3am6QiFhTnhszBNhFC1luMkg5e6/XCTK1BJsKg==
X-Gm-Gg: AYBFou3cZV8OH/2zZcnIdv5GhwDqmbTjFz2JfuEht6udIDd0fHAQUYNgzRdxnOKA7kV
 6EylCMMPXBeGvyaOhKutfvqW6pQDBtc/LqkW/PEkWwamLCq15+2/Laz+BVU5h3LRmaEbIH3+XDG
 zD8kzOHlpzYQVYLbwBBpN+eL+SxzkCGI+1u7x+qOCpzqJplLZsRK+5cEbMCVGnL9O0aLpgDFF2P
 Go8nr8OIWfY8Mbaf8/LWTclQPA1OYpm7wMFTtR+4e8dMcFHiZrGWyOHxg1OEuuLgktUMMhrETnL
 faqKdmxu9z6EsFwWbMizoZgQMAhDaynqPi4K+AI/EkxGrHNYq3xoV50mNga5nZHCqcfArAWtZiL
 orvhEA74KnImm/C+CQWol96/FlRLsbvzzjl2Xis5Mz0n62zqBxYK4rerc+7pJc7aIA8Ryl1h1Ij
 unxgfCwBx19ldxa0lWWTv/
X-Received: by 2002:a05:690c:8696:10b0:8af:1843:a9e5 with SMTP id
 00721157ae682-8b4aa2c8050mr17847277b3.23.1794587670736; Fri, 13 Nov 2026
 08:34:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 16:34:18 +0000
X-Gm-Features: AclHuK_woSQ0_vKLexry19T1ZR7RObQMnIUqtANSpWjopsNk2N1pYp8nNrcG6iY
Message-ID: <CAFEAcA8G-aoxoeEOy2SyUcYyrfxMazHZvB+hfZZYOrbMcmhxkw@mail.gmail.com>
Subject: Re: [PATCH 00/19] target/mips: Mixed bag of fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>, 
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Milica Lazarevic <Milica.Lazarevic@syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 at 16:13, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Various individual fixes noted while reviewing manuals
> during decodetree conversion, and using a RISU prototype.

If you have a little time for MIPS could I get you to have a look at
Coverity issue 1689817 ? It's not urgent, but Coverity complains about
what it thinks is some dead code in the dextr_s_h helper:

    } else if ((temp127 =3D=3D 1) &&
            (temp[1] < 0xFFFFFFFFFFFFFFFFll
             || temp[0] < 0xFFFFFFFFFFFF1000ll)) {

The compare with temp[1] is very odd here. The constant has the "ll"
suffix indicating that the author thought this would be signed,
but the value is 0xFFFF_FFFF_FFFF_FFFF so it doesn't fit in a
signed 64-bit integer type. So the C spec says it has type
"unsigned long long" (because it's a hex constant). That means
that the comparison is int64_t against uint64_t, which causes
temp[1] to be cast to unsigned and we do an unsigned comparison.

The upshot is that "temp[1] < 0xFFFFFFFFFFFFFFFFll" is a funny way of
writing "temp[1] !=3D -1". So I think Coverity is wrong about there
being dead code, but it's confused because the code is written in a
confusing and possibly wrong way.

The comparison with temp[] is also 0xFFFF_FFFF_FFFF_1000 with the
LL suffix, so it's also not really a signed value or comparison.

I don't know what this instruction is supposed to be doing, but
it would be helpful if somebody who does could have a look and
rewrite the code to either do the right thing if the current
code is wrong, or else to rephrase it so it is clearer about
what it's doing if it's getting the right result in a weird way.

thanks
-- PMM


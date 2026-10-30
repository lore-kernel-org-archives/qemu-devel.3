Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AD606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UNuI+/H7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmcM-0003cS-VW; Fri, 30 Oct 2026 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMmcK-0003bl-UG
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:26:00 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMmcJ-0006hc-Gy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:26:00 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ae8607e8afso5153897b3.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793366758; cv=none;
 d=google.com; s=arc-20260327;
 b=naAiHBjOE2MhQHyh12QbE3GRXfiN1JMzf0wJhPKBPBn+A9oUTi4DIta6A6qVoM2JrU
 8uN/IyRZ1mtwKhVyCAg01O8+8NBDihleemArhLQ/8o2v/tVzHL5J2THJOjU45tnnOxGA
 B0lXYJemKfQleaorm2lntefnxJJGS0cfWYZzWY51k/ruscPVnKYgk8Jw5QaO9jTb5J9x
 Lgz0nHVVnZnACVmtzcDURUJT+URAaccQlZrl45IuX6RjZ7beMszoR94e7tTh8Dln8/T5
 3IS/qymssKbqHuF0sjcsVxnmNTNUKpIZfX2l7zISc2u0CytC0gGsW8KjL5PEQ7xAKLJG
 59hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eDxMGrYndojBgZZTFuQ1dDtBn6PBp8RE1QbmxJJDRCw=;
 fh=MjwBXOYEfL/DgFW1V4NhEgisjaFIu9W1HAL3oNndow4=;
 b=JQJiUJyqzKawyD2SROEzQJrP+LZT029+Fb81dpyhVXAkFgthTYXjg0YpzBe8ZYm7ci
 02mHBYknUyPTRsp+BdPARq9f89z5tVSWGkjXbq6Bb3K5MdF/z+TyYkpYFOh6SFhkR8TY
 hiKtFcwNnO7gM0nrAs18vkJ7k4/RTMAlDflHYLXyxtTg7QJKR/Bf4Pype8eiI0wDyl2z
 7agDq/bQ6iti/vxFXZfHHG8TYM1z1c6LMOwZ08/j3imZav4+L8GfxDuivXN1qcW/1rNE
 CU2oERmd75C5xU2okeNR3GerIHiJ4zuSKs5UYWW+IYqrUKAYOfkVt0glHy3K4cAxwpF5
 pcaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366758; x=1793971558; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eDxMGrYndojBgZZTFuQ1dDtBn6PBp8RE1QbmxJJDRCw=;
 b=UNuI+/H75WkK3V+5JbhmI7v6GPnXwSW7cLDe76mibDnbfIqZoNPNWGR9QTl3VdzMkp
 96cKfh7PzhiHUmt6RXz80LFRmH5K/MPctz9S7gFIWJie6kfzXGQnMCK+7GjQIezt5T8h
 PJezdB2gkMKUMtHmD+5/DNXJcNSU5lkRPmYRpAqtoEw5N7wP9sydvA9zzAIEJ/vUR2kO
 Z4amRJWZAfBQWcDzA7Ul3GQcSuFyCqh5FjpcKU4dLiEbsiOqWP8q0+QD/27vphieygIm
 4CPBjJTHjVLLFY5VE9lUZ8JE56m3WOm2USuM/XSGHdVf90JyRWiYs4iW1+dISOyb73Yq
 HPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366758; x=1793971558;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eDxMGrYndojBgZZTFuQ1dDtBn6PBp8RE1QbmxJJDRCw=;
 b=wAmTcJR7F1XK3aS6EwQqdwk+6P5DuyC5iRTvRAluT76h1gGVylY2RGK0mHlLMt1RvT
 cHtRqtZdQrDf/V707jHHX0JYOeL9JGJMCREANOQUq/Fhwaz/mCEJjzmItutSNQkbORIg
 lf8YtKdrfksceDXrQ9VsWR2ggYn2RHksE57VNQtrKrg1t/uNtxkZCJQfcOTFBtEfURm3
 /Oinw8v0AxLuUZl8OZ1Q2LupNFQhH1cHHz6CotJXYGc+e+3CHJio0vaH7HBIlbYJewNF
 l5hDlvC3ZiHn8mArZO29/DKuphdpLyTkhOJ3SV0Bebe2KXVIJ164mhZIQfkjX9K632Oo
 TOSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7OuRCYOgGoDwB80ZMJDit3AHJMIv81K5lCsZFZDWBHZJQbSG3Sh4ds1jlsryVoo0zjAq0x58fCwYU@nongnu.org
X-Gm-Message-State: AFq9FYK1+yCqDEF++q/iSaSZHfnuYku4+5v4S7hlEZOvCGd84laumaJc
 fMN5zk5eA4h9zvW3PuRXcbcfHU4QLBO8JsQutrDmD955JzJVEug0gVL0qV0K24lK/Ly5nrf8u8I
 7cpM0qqGp82qH2sSNMUUzd630ZXbMC9/zpvdG31eD9g==
X-Gm-Gg: AYBFou1G04lsvJZpx90AlPQGDiiRoAUjuM3R7x5yj0lk77y1MF+WDXJcMOn/FS0fy92
 tkCDPo1Fm2hGUUAmYhmo2dElbog8tUKgd1UmoMf4ZqEcWY7bV/QjontxJV5vmSYLiTZR0z3TTBx
 hjCdM/3FWT4djavzjX3tE/sw/V1ax+14k9+Za3p7548SyuZPo3Rza0kfMyCq6kaGYVnLCiO4ZVz
 9B8EoKSUHBlizntOnNPEQ5yED/1I6iBnOkWQmmSX1oUP0mJhInJEU8Cbcp6L6ghIa324FUlbnjy
 s3dWP5grOB2Lux8+Cb5rkEQlm6qr4IGX6AnjSr/Kmi9By1e6ksnDrFU3XUL1/I0KY+aN/ge265G
 4q2kcAmFIBxHjJY1CWFZ2/gGOyf6QVnfyvPIWvvDKLc6u4IkhficBHnKsziNxWHEozp/1yQB4bh
 pivbBX3nqGWwOxvQ9ZVIfN
X-Received: by 2002:a05:690c:dd4:b0:8b0:a352:f979 with SMTP id
 00721157ae682-8b2b672ce98mr12479167b3.29.1793366757554; Fri, 30 Oct 2026
 06:25:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030131406.461599-1-eric.auger@redhat.com>
 <20261030131406.461599-11-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-11-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 13:25:46 +0000
X-Gm-Features: AclHuK-jdzEfOQiCDg1duKYGH31bmbdjvged0btjCWkDLRbmId0M_BvVFFcxyEI
Message-ID: <CAFEAcA9koKTMaxgAhv6qnwRr2RBdtkoJSX5dOZaiq4r0K-ueUw@mail.gmail.com>
Subject: Re: [PATCH v4 for-11.2 10/10] target/arm/kvm: Improve error handling
 on scratch vcpu probe
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com, 
 mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 13:15, Eric Auger <eric.auger@redhat.com> wrote:
>
> Pass an error handle to both kvm_arm_create_scratch_host_vcpu()
> and kvm_arm_get_host_cpu_features(). This allows to improve the
> error reporting on kvm_arm_set_cpu_features_from_host().
>
> If any, the error is stored in the new cpu->host_cpu_probe_err
> field and further propagated on realize().
>
> In arm_gic_cap_kvm_probe() call path we just pass a NULL error handle
> to kvm_arm_create_scratch_host_vcpu because we don't care about the
> failure nature and just want to revert to emulated versions if it
> fails.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


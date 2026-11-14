Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417E606A32E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V/akzFSv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSBKs-0007Ry-RF; Sat, 14 Nov 2026 05:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBKh-0007Li-Tg
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:50:08 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSBKf-0001aU-HO
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 05:50:07 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6767d92cde6so1928929d50.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 02:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794653404; cv=none;
 d=google.com; s=arc-20260327;
 b=YeMztZ2rOzt5qHT/aRjcXM+InzNMP1YnrsmfhH2paVi/eeMbwTFE+qDRbXVX7sOeED
 m292EC5j3V+Esnyht/GDw03NlAY+vF3+YnrN/n8dc5utzlBjGCTf97zLx43B1fTYQb2Z
 XtW6/yes8KmuvqqDp6E5hqhkQWVG5C9nlJkZ72KpK/a6t8N2DsCsQweA9B/4iv5AVB1G
 ffA5e9zaOzqr1Ast+PtI8AuHvrkiVzf5PZOrPsYzlbhLpRiKLDm766hgGruNxvsA2jJ3
 MIFpLp9AyO2upDTdyNuHNFVa/GD4OiVJKY6rRiIpKFAKGsR+sZXA/HtYZTquMK4aTOlK
 UqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cGDymkR3cFc6weptlKP3igi3nbWKhlIh2JKy12OlpYU=;
 fh=zpSGNBbzuVFTWtBcA2i02nfyrEEp3yZwqkcQLyLxHck=;
 b=A9SjCxrelqPJt5YucUvVYOp4LbcV38xAKgaDSZF5xkomwSdfZFBHtR3rWaVhmN2zno
 9tsENxLb9A68JGItRucSThIfX0e3/g3RCPCq0nJadgUYPwbrOyzf5gjWxfvXVhGxq9Yl
 J1r3h8/byJUnP0DzjD37q5UMUW/xADGXF0E5A2J+q8PAZjjBQKA2ZpCCaH+a324edVR8
 IbZ4KGn9So44k+gvSrNM40hcgqAWZKWQclwm9i0yEL0GJ+c6o75mOeqOZWvw2TWClbRo
 JszoaWkY7yL0Eb9FircxK39ZVs0WoSS1WLc2XcA5r4KppLI2MhKn07jiWTqmRnCHHqMM
 NBLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794653404; x=1795258204; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cGDymkR3cFc6weptlKP3igi3nbWKhlIh2JKy12OlpYU=;
 b=V/akzFSvZr+dtNjjxSmQP1PfeNL/kuctkM4umtas8lsonJvrRe/b2SsvbEh27feHYj
 6T1OzSkTvrwBnNBubiEYPJvCmjyiYvO3+JeXeBv8DfyMBjxv3KG9K/LfrBm0TnzpKv2q
 g9llbE9tPXxhgLjPDSNG4u+ki927IWYMLC0i7fmCWUj2J/jKUCIVLLpW1/v/tLFhQN68
 D0dGSJxrRhrQRRJrx4saxvh7FqJ/PAo0ZE5o4K2I8fZSdPA14dVKPY8mCTJW+PvatO9X
 kAgAn97ZNevI6RqkcWjTVaRRvem0sRUIjgdzPSn1nzNfADZjALUaMVL5K1dKo2GYgIul
 XmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794653404; x=1795258204;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cGDymkR3cFc6weptlKP3igi3nbWKhlIh2JKy12OlpYU=;
 b=IGO3Ue2Uw6UxN8fxiYkldYtvckaE7eeUPKTBgPABmllb2IhAOpFN4ucOB0EOduCreQ
 84PUFZ3qfjXvblduv8O5YYYMzOmOlsMhlQ+VSOXIr+sErZ7bM7trJEv5TUJDwQ3TqNRl
 YnOzuRZ2DO5kuZqSm9DRtO1FJcjJBTIT06TgZ+Cgz7XRiJHLICGhJWW2Wdm5XVvEk0ii
 6TBMsM1H6OFVeeyn4rwyiT/GDJd6EZuxW/aL2AcblAy6ldatSvUH9+Voek7e5DCDV+7Q
 BIVvDClIL+ld4EyN43lSRlaSK/iQnU5yAjHcKtPv97wDVYPU2JJPaa2zQSe+vgAG5Tsk
 EVgA==
X-Gm-Message-State: APuU4Z8q5smT/5/Z025U/PxcQzxZYIMvhR0/ZqPNmoU3PWDuEAHotKzS
 8ToNBkQwiF3nhgv7XaGzqCOkZoEhL0TCcB2cGwgQkNs5fP7S2z4pjMj4DDS9pTc83sH9ZK0YiYi
 MqfGFpdbISOIdc08v78cAiD7OcdHT6W4z5QwWQ3/JfQ==
X-Gm-Gg: AYBFou3qZ2kOvrVIXNJPvaHzcY8hiiVTXnJ2qDvX80mTsjKNOiiaqVQ4lFFhXQsRGMy
 /sh6akLNQmsbsmsAQLki9Zr1+Tzy6oVHryuH/et0Qi6+9K+FLyETbrRgiE8FGwBGBwHtnO9/OmH
 O+6dtRhJMyJKrEKEh1S0dwMDBgykp6ret0gGe2oBib6zIX+1zDeSKlRNuV8humlpSi1c0njwdKM
 dgq+Wqy1oc7WuWbGrluvhYGAKBPj0By2kd0GSZVeGcgZV6RRSE/Eu8VmzO+Gr8maHbXR32UrIDe
 EplXFo8yeg+WHB+or91DdNLdBLtg5H9e0U7keIYtFQxUtZa9hBNi50/oqcIDvFKXKHAr0XxRtVU
 J5HjYh38Ud+B6z96IwNDiOiHTWFmpMRyjdVWYtzrPnO6O6x/nb2jOg1knqIe8AlBLifUGbqdAyp
 ifnihWRDegox7iIDEyLUhd
X-Received: by 2002:a05:690e:1389:b0:67d:9a5e:8ec0 with SMTP id
 956f58d0204a3-67d9a5e967cmr1509895d50.48.1794653404111; Sat, 14 Nov 2026
 02:50:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <179449578952.8382.2790865629085512841-0@git.sr.ht>
 <179449578952.8382.2790865629085512841-3@git.sr.ht>
In-Reply-To: <179449578952.8382.2790865629085512841-3@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 14 Nov 2026 10:49:52 +0000
X-Gm-Features: AclHuK9ckxnBfEDfo_LyX-IbblHtB2BETK2N6sP8mZgn1-igdfXYK3CsS6VZnP0
Message-ID: <CAFEAcA-jgooO51Lo7Mne+vOmf22nnFX+vASRdKfNFyUbPpMarw@mail.gmail.com>
Subject: Re: [PATCH qemu 3/3] hw/arm: Add STM32L496G-DISCO machine
To: "~mohammadodeh" <Mohammad.Odeh@exalt.ps>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 15:03, ~mohammadodeh <mohammadodeh@git.sr.ht> wrote:
>
> From: Mohammad Odeh <mohammad.odeh@exalt.ps>
>
> Add a machine model for the STM32L496G-DISCO Discovery kit.
>
> Introduce the STM32L496xG SoC variant with its flash and SRAM sizes.
> Attach the on-board MX25R6435F flash to the QuadSPI controller and add
> qtests for identification, SFDP access, and data transfer.
>
> Signed-off-by: Mohammad Odeh <zephyr@exalt.ps>
> ---
>  MAINTAINERS                          |   8 +
>  docs/system/arm/stm32.rst            |   1 +
>  docs/system/arm/stm32l496g-disco.rst |  43 ++
>  docs/system/target-arm.rst           |   1 +
>  hw/arm/Kconfig                       |   7 +
>  hw/arm/meson.build                   |   1 +
>  hw/arm/stm32l496g-disco.c            |  95 ++++
>  hw/arm/stm32l4x5_soc.c               |  25 +-
>  include/hw/arm/stm32l4x5_soc.h       |   3 +
>  tests/qtest/meson.build              |   1 +
>  tests/qtest/stm32l496g-disco-test.c  | 693 +++++++++++++++++++++++++++
>  11 files changed, 874 insertions(+), 4 deletions(-)
>  create mode 100644 docs/system/arm/stm32l496g-disco.rst
>  create mode 100644 hw/arm/stm32l496g-disco.c
>  create mode 100644 tests/qtest/stm32l496g-disco-test.c

Put tests in a separate patch from the actual implementation, please.


-- PMM


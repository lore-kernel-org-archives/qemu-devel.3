Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A6C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXs8-00040R-Gn; Tue, 01 Jul 2025 06:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXrq-0003jq-LB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:05:36 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXrn-0000EQ-KM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 06:05:34 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e818a572828so3658947276.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751364330; x=1751969130; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kfjRtLV5ssMj94wMWxrtiAx9c7qnsX2Z+NOkWxYACI=;
 b=MfF/3Wj+CqOd7lur4z6B0iTxWo+5vjGz4oc6MiOg9lkSsRQE68YtpcbmVnYK2hIuNG
 avFc2zLcKutnmRAz1tkAsbbAJURo6o8x4hYX00Jo2f9ahAIy4sLKjmGCmxNntukzuNPo
 nO2FDVKyWf9rZi0PAlV1LcSF8ZjXKVCDqRuURZdRjjtl0S66EAcAQzDgYvWUwsdkeA60
 twexwabhCkzy/vLLRiFMVBQjZzZ9eyvNKjSijV89P2mSfh7fFA+9CzcXWDLhoFGc+/TU
 igO0xSGQ/+FY9TuElVt3ObGey/bGTXNGOpUJ4aeiZg9rFfIsIjuq1xiuvjbU7Iwn6ph1
 WKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751364330; x=1751969130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kfjRtLV5ssMj94wMWxrtiAx9c7qnsX2Z+NOkWxYACI=;
 b=xAtglbHYXFij+WmyIxwMeLFe/f5l13rnW2YjBLZb7OxyPEMuusGUSEH1eRYf5CMdtq
 VNzyip7U20PCOk0+qookz3ds0SHaudUmvl0mIm1tNSYvqnWVnYiDUYJPQk7SEfhX04YV
 uLwMdCjKUO1hOFzNiaNJFhqLJFtnN6Lv0I5jyxBnqAHZqn1C4QICM4tV7aWkRJFvPpUk
 C9CPTuoZfIvxOQK3ioOXSZCcMaI+oBRr4zpYBeP7L4bpwFKDCgUGpypzxRzpk3NfBRpN
 442hqfdMSGvJpxyZwxiiXe5IkPcrA0ciEnDh/5MR7HHSxR/RvInWoHO13lk3Oia+QIwM
 /ZUQ==
X-Gm-Message-State: AOJu0YwSqZCtA2WOfdyAq7Vg6NsUw7vHUqAhxq4Mqxfbuh45sKJs0G09
 A3JeNZhuwa1GO4ha1ou0asS9JSx1zuFg9ajC28Ax+BSUMDpMWYM1Q6FHTTWfnxEURILsimofAfi
 oArWifxRLz2MU48Wru85z7HhNh6e80DtVav33q+NVjA==
X-Gm-Gg: ASbGnctksCpKVrp+Mubd7qa86z1mER19Lma/hMn8V3ilNkesexVLPramKGLLEaDUq9i
 KN1TrO1R4d9LYVoKsfcUJe+3GNe4jTyN54pw+74EN3TRifHF7WhqKnJ2w55KhaKs/p/tsvrMEHh
 9/Fs8UhGD9MiKaxmGQVnewEwp0WC30bukydTaPdxmLVH0L
X-Google-Smtp-Source: AGHT+IGOpIzUKfVZ51suWX9MeleA4XpykzcLNH+i6xXehvun3Xncgjy5GjPloXM/LCbq34wBW2AkLyClhKEvOdHIBxM=
X-Received: by 2002:a05:690c:6109:b0:711:9770:161f with SMTP id
 00721157ae682-7151715b6f0mr247333597b3.2.1751364329873; Tue, 01 Jul 2025
 03:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-19-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-19-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 11:05:18 +0100
X-Gm-Features: Ac12FXwOiStkTc29Xq_uInkklsV0tTSFUxB5oz_6xMzY-cgZwTpqcNIDDEe6VkY
Message-ID: <CAFEAcA_M+nXYL5HaN7QUUwWywJw8VaxU3T54YCMQsVd42PQ+PA@mail.gmail.com>
Subject: Re: [PATCH v3 18/26] hw/arm/virt: Only require TCG || QTest to use
 TrustZone
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We only need TCG (or QTest) to use TrustZone, whether
> KVM or HVF are used is not relevant.
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/arm/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 99fde5836c9..b49d8579161 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2203,7 +2203,7 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>
> -    if (vms->secure && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
>          error_report("mach-virt: %s does not support providing "
>                       "Security extensions (TrustZone) to the guest CPU",
>                       current_accel_name());

The change is fine, but the commit message is odd. You
only get to pick one accelerator. The reason for preferring
"fail unless accelerator A or B" over "fail if accelerator
C or D" is that if/when we add a new accelerator type E
we want the default to be "fail". Then the person implementing
the new accelerator can add E to the accept-list if they
implement support for an EL3 guest.

For the not-yet-implemented case of a hybrid hvf+TCG
accelerator, it's not clear what to do: in some cases
where we check the accelerator type you'll want it to
act like TCG, and sometimes like hvf.

I'll take these patches, with an updated commit message.

-- PMM


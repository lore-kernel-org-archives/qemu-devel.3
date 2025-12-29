Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5957D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAwX-0002cE-24; Mon, 29 Dec 2025 05:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAvy-0002Uj-Mv
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:57:11 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAvu-0002Hb-Q3
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:57:05 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso1353778966b.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005820; x=1767610620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrZGb6dWHCmT1ssrjOwvpDQ9Hw9Fe4nOcn9X7qrdwOQ=;
 b=u6LSksZWXxiuV4ChmsZsdnKBp6iscX6PREQlYFOopBi1u9Hwq5NkspEMGI8Iio+4Wy
 3JNC7BZoBDrxiIBbFDNcup/K8ekHPBINApauzdf3c1b1GsBkZ8hk+fntYHwtiSRI9Vyt
 4tXgrRMNlBE3rfhX4J6MAW5mcymZNwtb6z97DQ2oNHIAEK6V20W57Y13uOH8aq/Bqsl1
 zw/qtzM5g3vLNU7QAlR7FCgDFogLygDdVmHK86lzzN60OpeJyew79kJb1NhlCUWLm6y+
 5ht0O47BC1cYxt1pWOz9IgzsTETulJqOmIFdrHAvfQTciOKCrctrFhU/RHoNuxV639Bk
 Fb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005820; x=1767610620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZrZGb6dWHCmT1ssrjOwvpDQ9Hw9Fe4nOcn9X7qrdwOQ=;
 b=ZSMyjgOvDKRbnhoGqUfrLYZvrRm6hT6o1QCuvoBO1Mw9oTNJbZyY5A6K9qUdVgjgsT
 IV1veiNE5Ny9FuFQjwEYSVQN8B8jmPAkI+zptFuFxK+GQTEQ5buieMjnWLexahYPxzg9
 7Y3JYWDT/0AlXMCQwj0nZFNgpcObbpau4Xn15JWw41BC/nXTbFxqR/LbXdkPKwKqMyn1
 RYoETX6G1EmZqPncKOpkeuOsvprj+Yc4GHk+HifimNe1EWDLglIAb0UUjCdCoq6DAjvp
 QGaLLgAjq0i+sfhvbbhNXrj3gLT5tKehnvyKT73LXv4tAFRGu9t7rxi7dP8kRTW5B9so
 LowQ==
X-Gm-Message-State: AOJu0YwY0WHmVcTwrU7q58Dd9o3bwW3s3FjvtI0clArNySmpgphmpjMB
 CVSVwvwtQpcC18yAEclesTk2IprfPLj6PMlQ/osnl1jus2xU3sPPLH4uV27B7CtHgBwBrQEuVWK
 5YhB/VmBkGoHz3LYy3lSoW6LywgbutzrcVimPh0SZzw==
X-Gm-Gg: AY/fxX6YN5WWWnIqCU6ZfXlCxOImhLIyEqNPqlaB1Q6DQb96On/iLzMHp3a+tmHuIfB
 PIn4wfmtIInf7/a5sQuOfjbIgTKgsZXJ1VSepTdSLEVGDhe6kuQAFV2niWa6B/OqMnJLmthdrIq
 jkFFI8zJayREEVsQlHU84KhQ9fDp4vrNFqvcsj9jZVUvVb+x+4WePMpCmQQD2FDAcf7APx031mj
 aXLnd99visRotGy0EqMyuxc/SgfdZfRct2Qt1DJYDY7YQpgNiKt3LrFVQA8Re/aKW0u0Nkopt+e
 Uc9fLO0iqMqRRu6rSP+YVligMiFh56lUk79VMSY=
X-Google-Smtp-Source: AGHT+IG4Zs9AK5GlrlkmZszWUbWiBDie0zV4Hb/h88rVAohbA7jeqryix/J2nfQuz1wwRMn4/ZKYDyq1Wc9db3i7ioo=
X-Received: by 2002:a17:907:d87:b0:b7b:e754:b5ba with SMTP id
 a640c23a62f3a-b80371e9f63mr3727422266b.56.1767005820473; Mon, 29 Dec 2025
 02:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20251224160335.88861-1-philmd@linaro.org>
 <20251224160335.88861-4-philmd@linaro.org>
In-Reply-To: <20251224160335.88861-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:56:34 +0200
X-Gm-Features: AQt7F2pAipwaD8uiJ42-rCnkLwy209iLvW9sD1DOwqBQUgFy_D56NwKtk1nHruc
Message-ID: <CAAjaMXbN=yeY=K=OajDptmgz6cjT5uXxod2=BwzRCZGpK3suSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs/targets: Forbid AVR to use legacy native
 endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x636.google.com
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

On Wed, Dec 24, 2025 at 6:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The qemu-system-avr binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/avr-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmm=
u.mak
> index baf20fb7f2f..154f58448ae 100644
> --- a/configs/targets/avr-softmmu.mak
> +++ b/configs/targets/avr-softmmu.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=3Davr
>  TARGET_XML_FILES=3D gdb-xml/avr-cpu.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>


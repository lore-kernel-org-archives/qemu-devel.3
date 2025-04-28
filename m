Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84CEC369D1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 03:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9F2C-0004T2-M4; Sun, 27 Apr 2025 23:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9F2A-0004Sm-QJ
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:19:55 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9F28-0005pa-Ub
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 23:19:54 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so825844166b.2
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745810391; x=1746415191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oTejmls0V2hjkQ8APTxUY3dNlDd+WJA1eZk7u31iAs=;
 b=G1VQEyLIzZPyII8CDmJFH8Ieb9BE/vLyaec9+in2xg8PhFfowECJbtX7617X/QupSC
 JmsNnO5h9esjdBm0qqEXWv1CKhneOnuC0SWllm7uQ/uDj7GXYWp2Pu75HWTRI7ltpbSv
 f0X7RVsbOxOxsjUAJaeXaHSG2x9jZwzHrf52OckuOJCIuZj4UPvoYOM3wQS0KWY+ADe8
 DDlausf5bd/M1PQ98/kQ0PzZe5dyBYOe5kyU7yDxcMBdyjscJ14v460vy0CEGvEVwzAA
 O0V2HJUOmZYYmCaOh8f+GXCAGAKWLjKcf6ylQz+lh2s/I92CpjYhgaVSQ9PmycoMD6CK
 N6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745810391; x=1746415191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oTejmls0V2hjkQ8APTxUY3dNlDd+WJA1eZk7u31iAs=;
 b=vk688LVZY0ITWpJhNjpMMjbrThAVl0Pu+DXtb24p6wcpuP9Wgv2ei2rdug2le80po3
 GBF7rsGrq1ho3ChOv11YZHojkFpzIRUwFI1ILbnsChpdlSTBHxdnIVmmNNP8q7yFOvwD
 2ICNQxonMESJNM5zebEwN0JDitgqV0ZXqPNDUrsrSADttY5JFXaX77/yjrNPTxwcMiBU
 KC0NLOtl6bcpzweCVPuWgGFJrf+3ZpHZP/mLtEyh6V/FpOWDO/czZfatX12HqidX9iuz
 s3tVx+7GGmFA69szoMWLeNEFbozCHmScSIXu+OfI5AiwZReArx/9dXC0jyhaJoC9INOp
 Qg2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGKRj5nFgi3qIpFF0yvkg9HsQz8e5cnruzXFFnOCvOiDnTEP8WeTAFwm0g6/q7GJUoX7Ba42WqoRY@nongnu.org
X-Gm-Message-State: AOJu0YzrYGo8cCPbrsioUUUEJD7qNLpjlvQ9dfmlRRqgLY7UBzVJ39Dx
 EykOBqJ3p/Ot0Mu0YMNNmEuURdh74rZ04pEcoCHDfqCxl7gnuHaBMTLm8X90Dekg31JDRY4Fm+D
 jaTuz7tdRYxwxDkWlCeNCf811/Gr1dZZnwLdK5Q==
X-Gm-Gg: ASbGnctIlhsuPUUwryob8v8Ey1UvnyCJCFmde2GS3DRCtsd0sf7bJT0Fs+TjzJwyPwP
 g6B3WSN6XLV6OFTYXex0jNEw76AfNdrCg67RnYrsuVnrZNv5qL1dmUWn0IiS0N5EJoA1eZ79aOL
 kAw6EWj0TmvaCLyBl6HCeqMWE=
X-Google-Smtp-Source: AGHT+IGuNqineJh657GXmFRHxAP2he7PTEg9Gdv9SI5o0jjhUzuSgR+aukgNkq68/eSZE76GTUf3928mFMsPpdXk1r4=
X-Received: by 2002:a17:907:6d1f:b0:ac7:805f:9056 with SMTP id
 a640c23a62f3a-ace73a7a4a1mr874931166b.32.1745810390827; Sun, 27 Apr 2025
 20:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-22-philmd@linaro.org>
In-Reply-To: <20250424222112.36194-22-philmd@linaro.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 28 Apr 2025 11:19:14 +0800
X-Gm-Features: ATxdqUHitdds0mhfEKf0-exbCOrPMyxpykhceu41Fw91HZpGdrHdUCJ00m31Jfw
Message-ID: <CAK3tnvLVaQT2VbOQSWvW0yXewrOmTuEuzhwTkVVxiPiDFsnv+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 21/21] hw/arm/virt: Get default CPU type at runtime
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
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

On Fri, Apr 25, 2025 at 6:23=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Prefer MachineClass::get_default_cpu_type() over
> MachineClass::default_cpu_type to get CPU type,
> evaluating TCG availability at runtime calling
> tcg_enabled().
>
> It's worth noting that this is a behavior change:
>
> - Previously only
>
>   ./configure --disable-tcg --enable-kvm
>   ./qemu-system-aarch64 -M virt -accel kvm
>
>   would default to 'max' and
>
>   ./configure --enable-tcg --enable-kvm
>   ./qemu-system-aarch64 -M virt -accel kvm
>
>   would default to 'cortex-a15'.
>
> - Afterward, -accel kvm will always default to 'max'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

Thanks
Chen

> ---
>  hw/arm/virt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 566afa4c978..b59cc90bd36 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3127,6 +3127,12 @@ static int virt_hvf_get_physical_address_range(Mac=
hineState *ms)
>      return requested_ipa_size;
>  }
>
> +static const char *virt_get_default_cpu_type(const MachineState *ms)
> +{
> +    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
> +                         : ARM_CPU_TYPE_NAME("max");
> +}
> +
>  static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
>  {
>      GPtrArray *vct =3D g_ptr_array_new_with_free_func(g_free);
> @@ -3184,11 +3190,7 @@ static void virt_machine_class_init(ObjectClass *o=
c, const void *data)
>      mc->minimum_page_bits =3D 12;
>      mc->possible_cpu_arch_ids =3D virt_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props =3D virt_cpu_index_to_props;
> -#ifdef CONFIG_TCG
> -    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a15");
> -#else
> -    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("max");
> -#endif
> +    mc->get_default_cpu_type =3D virt_get_default_cpu_type;
>      mc->get_valid_cpu_types =3D virt_get_valid_cpu_types;
>      mc->get_default_cpu_node_id =3D virt_get_default_cpu_node_id;
>      mc->kvm_type =3D virt_kvm_type;
> --
> 2.47.1
>
>


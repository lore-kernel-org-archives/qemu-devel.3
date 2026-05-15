Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDECCCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtV5-0007py-KG; Fri, 15 May 2026 10:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtUy-0007gy-9D
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtUw-0001WG-Id
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so666923f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855201; cv=none;
 d=google.com; s=arc-20240605;
 b=T6PcSVe9MZAFCn/k7QOP6iFjsbGXADPepKyUe1nK/11Qij2Zf/jGWw0adzw9ot8YTe
 xdD9ryP3gEnig2vetmf00H6HDmScRJuemGgJnDRnKERfPSzYxMRdprMpdYzyZ2v0RfrK
 WT/Bu/imMJYc15nfGsz8UNBfSrSHuIFDBtdwBAOySreJRw5TlPmiGhEggtpT14X4gbhi
 wGuCJ7dfUM4+TGFD8gLQ/xgoN2QxUr/xnMIcF/czKwLWqHvi8vAUwkQyG8MOzNMT3BFW
 yalZ8DF6sx4G8Z4NNV019Bd7ejxKPCr+E6ScSSOhLaFBX0QtPenNScR/aIwtjuiy3V89
 pa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BMI8Uk1wST0Ujsp4FbaBayK7DvVHn7e24vZuJ4mzK2o=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=A95xiQTSMleZlo6PeGpFeR+Fjinn25oRYUKv1qVRcQ4ipZFRIKC3vqlviSnQvwHlYO
 ByxeOXrXrY+LHI3vxBTyBqH2vHSr6rRmEIH27l1PAvpKPkNoPH4kMfJCLQ/qBPaXsXqU
 NBx8w7sKIoWXiO+SH2Oeg2XYcAYVv6Sg7DYG25Jzp/vElJQ8PVRhdJVUiRSl0kaswuNn
 55aiop2LIp/LnRMK3BDqx7odY5MYZyi50y7+c5iW2HzL0/wVY4dITOoNNK8nSBsk5p35
 4DmZ36GYrwgk4eaHeYQSFCGFXEesmWSZefqu47Oz31/slPCFi/Yoz4CoBwkzsAwNujRK
 j8Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855201; x=1779460001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMI8Uk1wST0Ujsp4FbaBayK7DvVHn7e24vZuJ4mzK2o=;
 b=A2qdeRCJXsYERrophik18SZaA39t/+FSvNCuufMGZZLBLD2Q02yhtkkiz4Svxx8B88
 OucGXU7K2zD3Ovlhq4zekr9QUnWAGhXMI4rZYNvx6r7EMeGf4H5D8D4dS10Z1/NOP0we
 d85kciqq32Mz9XoVjjKoSdvmn9gtE3z05EUQ2HQHZzCrDCWGQuDwFj+9kV6HS0JzNUTT
 vbnZP6P9eQMI2r8M2vT9ECue9TpVDw/oYLYyyuoc/HLNXjjeBew9KoOAPCtwhXirt3W8
 QAaMarqIOtg3pbynR9QbeNN4N4wOuAcKeZClfQ2wyAzEdF8teWo/fNY3eKiWriGlAqxI
 o8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855201; x=1779460001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BMI8Uk1wST0Ujsp4FbaBayK7DvVHn7e24vZuJ4mzK2o=;
 b=oK3yTGgliMVgiLkEVAHeu724ypsPyFAkL0lQYbyX+SwdVFS6lNiyysIr2SaK64CDuK
 uMI9qbZYlIvEB+FyavsBaV5Ugmg5NqTgpd7l1XGy3a9kzpUwJRfhYJZkexMIokE+PJQ9
 35d1liDJ9hE/ANWxDs+ehxJwExCo7KhWcIVml2kDutExRZfJzq9kWrgT5EVOWfc6Ryr8
 DnWL3tlPqtWIESKro1XN7Kqmhz1Pa1yVX11PAi5EPXL0JPg60lSWDK4miQaY+879czsU
 w1kJsT/h2eRnrT29j19iXBu5XO584t+zHOe1YqYrvOWUPK+J5b3F58IHuY/XadPfQn61
 6rzA==
X-Gm-Message-State: AOJu0YyVMHXUPNWoGU4udPncZgu1laDnPCScQsz30QL7O5JEASlP77zl
 frOqbMbyndgNm7J/84+x0xPfZqPNKiGC1IVVJA/Izzc8im4ziq0eXKFENxG217zSIUfKBEVisLm
 OAZgYfb4AvTXVrQoQnWvJ5wwl7dRRyBxj1xooNwrGBw==
X-Gm-Gg: Acq92OF5CSVj+EORjsRquDClhLrYGcf2vW0KP1iEG9G+Iz9Ig0L80Ur3XPkxs9xx0Yh
 4g+mqctbTfDpTIN1ZNcaeZWdRezwz7Lp9OuSliO92uU/kH3pdbAJJtdvfaSOfhXe0dNFkv8M8PX
 ixDo5oRfE8a31m4fB6q2zC+wp2gC/W71FwHQJhOikkhhR+1HMIXkw4at9FTf7AFoxZcEDyz1azv
 KywEuRyVeF8PjNN64j1ZXk68O85HmSGZj1Wv4KR9kYAQ1ve8AJf2yoZnNI2lOjiyWYDbtkzf8SF
 n3XE9SC4TcKskIJioZ14/Dc2nfPaK9AsCQ2x8xpHSFeudKBE74xtRZW+BiaQ
X-Received: by 2002:a05:6000:4691:b0:43e:ab40:28d with SMTP id
 ffacd0b85a97d-45d901e0d04mr10092142f8f.2.1778855201007; Fri, 15 May 2026
 07:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-15-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-15-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:26:14 +0300
X-Gm-Features: AVHnY4LwB3h2S6UqDbppdwNew7xWtPoiQ6FJLMWmfm5mX5s-rJbw7GdUL_1d0FU
Message-ID: <CAAjaMXaU50Qhn-eWuskpmDd9T_+3Vr5nemDsW_vXZXf8s1v=aQ@mail.gmail.com>
Subject: Re: [PATCH v6 14/20] target/arm: Implement DBGDEVID* registers in max
 AArch32 CPU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 15, 2026 at 5:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> 32-bit ARM max CPU is a 'Cortex-A57 advertising none of the AArch64
> features'. Keep it as close as possible as the A57, by implementing
> the debug ID registers, following the changes in aarch64_a57_initfn
> added by commits 48eb3ae64b3 ("target-arm: Adjust debug ID registers
> per-CPU") and 09754ca867f ("target/arm: Implement AArch32 DBGDEVID,
> DBGDEVID1, DBGDEVID2").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/tcg/cpu32.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index cf643ce43b1..2e8afc28602 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -755,6 +755,9 @@ static void arm_max_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR4, 0x00011142);
>      SET_IDREG(isar, ID_ISAR5, 0x00011121);
>      SET_IDREG(isar, ID_ISAR6, 0);
> +    cpu->isar.dbgdidr =3D 0x3516d000;
> +    cpu->isar.dbgdevid =3D 0x01110f13;
> +    cpu->isar.dbgdevid1 =3D 0x2;
>      cpu->isar.reset_pmcr_el0 =3D 0x41013000;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
>      /* 32KB L1 dcache */
> --
> 2.53.0
>


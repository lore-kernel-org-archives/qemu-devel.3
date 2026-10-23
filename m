Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36736606A322
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FAMrxvQ/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBJN-0002Md-Dh; Fri, 23 Oct 2026 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBJI-0002Lr-KN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:11:36 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBJF-0005WB-M1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:11:36 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8acda240937so5642187b3.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:11:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792746692; cv=none;
 d=google.com; s=arc-20260327;
 b=osI3MzsC2YtLS93ygEk27ZauE2uJ9ArM5wDar3nqFFaHYDOXWBycCVouX42X7UkPB5
 NJ0wenycMXxKp5PYRx91+76mLjXktSp140ZduVh3H+pFzmzSBl6iHjRK8pL5xKdgkWtO
 gNr/b7ymVYztcZeQuFHEn265oY9M2FjfJjntzKw/bK0fqSKYfFkLBU+K5hvObIQYtAFz
 S04oXxQUiX8TeImjqgYz9tuKZZzvuFna5EMiXEt/KiJU/rJvgzGbYquOerCgvZHrU8Yc
 ynDG4njSB1OMZI/61Ur4Lm8rzVePW4sBFqd0r7D4hzoMcNKBRTaQlbKnhjtjGhrusLxc
 2bIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5xA/KSNorTXUf2X1e2fKhyJeQBekeX5t1w+zo6hQ4Fk=;
 fh=KzXqvYPNslPAMMDj8OG45pnxPOz8RV1Xap4RkSf4Gyc=;
 b=n+MEJg7/o7nCMOb0nOVRxa7nhGFabg2h917KWw0V7HOqLCLXQUg6W4q8QcYHHQvnB0
 KRf1YmpKA/d5Zwjjzguc59bFPB7rs7Nv/HBHdXxXrVPENf7QXs0RnFljA4CR4SLyr1Cw
 KUr+qWu9ZsNovx96sDT6CmiD1lt8zcQJs4Qpm6Q4ntsxJOz2rsNXb+ZMKhfpwOQfEU2s
 H3Kj1cu94Ig4iGQPXQ6WQoU1rQcpmdGq4FjL2yjK27gUvSRrkFf/Q5zgVXoaH98UzF44
 YWLG6Ff4CIgVJYUzMkqCJ4YDQTZoSxTku/AazarAMu9emhrYCQid4GQU4+a1YJ9MDaQo
 kUwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792746692; x=1793351492; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5xA/KSNorTXUf2X1e2fKhyJeQBekeX5t1w+zo6hQ4Fk=;
 b=FAMrxvQ/Koj4B3z/I5xj8XQ+LKYAbKzb8sOfua6WWhKDIURY2elIxdPgJU69iWZQ90
 zSC/o3tpgK8iLKG5Rpbw4MXJDgb9OUSiqEqbk54i9UsXdlbSb0OL2UjEGNtpwGlrl/ti
 JM+qsRExDIn9R8lw4zYIo5OPqKWax90EjdW1gZ7OCdx7K4X2zo9Bn1B92vXIXXxiGCfz
 VBur9cwOS/2X2kQBHWvJEEKPKId2IxGKvXC1IAkUoTsMtTSPzSQMLOuLq7oxmKcxU0qo
 +cT8Exlfy/SiNzN9gdEncuRyguyiY3Oo7OlKq/QeeQa2zvqA0Nq4eWrfRTLpO0IOqh3d
 ATtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746692; x=1793351492;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5xA/KSNorTXUf2X1e2fKhyJeQBekeX5t1w+zo6hQ4Fk=;
 b=uJx3eAT/z0AP1g4B0HkRwg/MoeuEKLWxK9jZQtmipXnOGartNv8hlWO+QtGg1uWi9T
 VT6mReCrqQF18arePjycHCZXZh/kNDKLC4+oOh0VNsMfw8dvV6RMh3JI2pMySQNMyRNl
 krkO5No+TyMEj5TeQDkD042lvw0QGJTLuFgQYpnR2GzJyMgXr/fJZB3u+9tZo/0kD/Sm
 CLCsHvR5JdLcZQvXIFK+WOyhB/kGxtXUYq3eaEgmFw3pvUkNfenh3+M65Ss7sUnXKPET
 DShbROWbUz0+yLFpR6ZYK4/a247iAplKMN+0/89pEtEXFtcF8O9+J3QRQIlaum4JDiKN
 6klw==
X-Gm-Message-State: AFq9FYLGtqKViUYOYS91rDhAfAooDYccY8WQQG1hz/X3MxejPqDQMSHe
 qRLkC0PnttBttAN23D5EPUT1re9mLXfwRxqP6eQ3MiJ6C52LquzwQZaokhZRjDD6sOrJi8gjrQF
 +Od7v0zKwU7OziwtUCv9SUaWxNw3iYbtLpAuwazUKAg==
X-Gm-Gg: AYBFou2e8J1mZehQ7ummWosh3Li2mrBsvbfV66szN8dqcTQJYbNPszQi0iUZAw19UDH
 7GRfywF+WK7JeqNIrqkzwcYmQfHrReo35W7JHq3GzUuiwYa8y4ilILM9Q357sbQzXdWuB2DMXtm
 984xRZjtsVSOMrRlQTi/De9e8uoOlobHvBVWN28PYA7/MeNIYMdETkj18du9brPTXu74ok63mv1
 vyxIUOwREs8wyr8+caR9LZOuFH8cyrsGV1f5dQohAcLKnemi9YmmqbOUwHNrr5+8FVvWF0C+I6s
 Dvs2O+L3EcRIrjFtw1qrvXghUdu/Xc7XZ4/wloVgdJN+Hl9fZspgSEYX+dUvObbQzF7q8RSg756
 rUTFwhs1kXeKkWDwYzruBK+GMZ74tvgAkIU9Xhx7cmU4OGQXzk6MjydDycFkoyFjzWdaBOtzhbM
 sC1oce/PeSXZrO52mhBiBt
X-Received: by 2002:a05:690c:4028:b0:8b0:5847:8829 with SMTP id
 00721157ae682-8b157e94315mr9186947b3.56.1792746691892; Fri, 23 Oct 2026
 02:11:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020195655.135632-1-harshit007k@gmail.com>
In-Reply-To: <20261020195655.135632-1-harshit007k@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 10:11:20 +0100
X-Gm-Features: AclHuK_fj3DWc0RC19KP11ITjMocdQVCwM79k9Te1sZN6g2GNrYHO24FpnOrCIw
Message-ID: <CAFEAcA8_ODwnsTDzLAf-ZVhy=tzTG9pBLAg7dmEbss9dK6YMpg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sd: validate migrated blk_len in post_load
To: Harshit Mukhedkar <harshit007k@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 22:20, Harshit Mukhedkar <harshit007k@gmail.com> wrote:
>
> Migration streams are untrusted input. A crafted stream can set
> blk_len larger than the 512 byte data[] buffer, so a later block
> read passes that length to blk_pread() and overflows data[] on
> the host heap.
>
> Reject such state in post_load.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4725
> Reported-by: Karl Mehltretter
> Signed-off-by: Harshit Mukhedkar <harshit007k@gmail.com>
> ---
>  hw/sd/sd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


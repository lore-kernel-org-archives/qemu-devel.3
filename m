Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B39C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HNX-0002LD-MD; Tue, 07 May 2024 05:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HNU-0002Ds-UI
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:52 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HNT-0000j8-Bi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:52 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59cf0bda27so211283166b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715075089; x=1715679889; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhfhWaRrMvPU54vrJIoL/1T+Zon9Fg2fYR6SvkTPvuA=;
 b=IHE2WRtX9jcGNlHe0pz2NwLMxOpdB3iZp6OGc5FL6oZyIxXTAina4AHx+grV0Iw+GR
 8R50omJ55yIo3wVMXnPZ9KzBJ6yPX5tK6OnarblqP6Vl6qbgxwOWIdjMeIqdPHGHyEQp
 pLb+9HMBOyFAYWjsyvpyWR0tYs6Nk/0oJWWdVQu1CMmX34rzhb9I8ueCuCXefM28hxEx
 InNhIfJwqcGdACiuHqTlkS2/tTFbQK9VJTLvHrbCh5ACUZClBltYOR/fUoOk/UoLZcg5
 vuZTvLxmK7hnFuYFJ834WJrs+I14q0cmx5r3E8p2e+vy3sbMyiQipD6pf27jjawcH0ii
 iFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075089; x=1715679889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhfhWaRrMvPU54vrJIoL/1T+Zon9Fg2fYR6SvkTPvuA=;
 b=Ka7BhOTkoe8ZmBB/IgiU08o4QuEqBVH1H1b4WcqNlK7XGNVauaRhccHpSica8InFNi
 zKCcjfXXM//88W/VPl/Nv/3wnBnnvtOPLRP4p+iHYpjy0mrfCFT3IwxdzPtLbzDi80bD
 SejzK5+b6HHhAa7vRseGm4Ry0uHtbCq7hcqmVyrMj82BQiKz6wnO0KMywjAXiE44nDDH
 uONtMeTz+BB7s/ZO5o9F7laWvQQ4AcCEKzLBpDfN1M17QAPRJSHgrlF1d4Qwf1AlvpqD
 VZF3xSGNjhdF+zju53Iwvl1eMpu1BvqQxMcBTV3O+c7miibQkV1EAfTbKL7Z98a8BHEj
 V3uQ==
X-Gm-Message-State: AOJu0YyIaWQraDxK/b+/INGWqzJj0cFgnKfYVWNTycbT+9zMWr1YCdzf
 Zg77VLPeZrp0Wt5P4Rt2yt/HrrcRDvSGwS2wffiCdJ993vHzk7hdy4pXKCof3UnhZPBFoGX3KHU
 kmjQnHm3yZhKBtRWXFFzYT38tZ4L/AdJPrK6G4w==
X-Google-Smtp-Source: AGHT+IE+pdn8fr2eDJCXIif/vYrFtBOqQBmy7oXmvCntsNLTAx6tCxyRQ73ZV5QWgfcd6pxEn7M/sq3h4v8yeT4fQ6Y=
X-Received: by 2002:a50:f613:0:b0:572:689f:6380 with SMTP id
 c19-20020a50f613000000b00572689f6380mr10504336edn.3.1715075089507; Tue, 07
 May 2024 02:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240505141613.387508-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240505141613.387508-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:44:38 +0100
Message-ID: <CAFEAcA_KAOwFMudJXvPCF9bDk-oFRuiY2beyRf4Zp3G=t6NDxg@mail.gmail.com>
Subject: Re: [PATCH] hw/char: Correct STM32L4x5 usart register CR2 field ADD_0
 size
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Sun, 5 May 2024 at 15:16, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>



Applied to target-arm.next, thanks.

-- PMM


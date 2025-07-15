Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DC9C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubaIr-0006x2-Dh; Tue, 15 Jul 2025 03:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubaIp-0006vf-GT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:42:15 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ubaIn-0002ZP-EU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:42:15 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so9333786a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752565331; x=1753170131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hYR7w4dLF7UXeRre8tSi0Eeo0/ev/t+Pvvxeqfux61o=;
 b=c/GTfDrNkUVjgf0KDjP6ePExy67Rou4srbygL+vWWpBY+59/pQHyuFNw8xOhYDmZ2m
 wMUl42o+HlTkBZvh6Qtrco2TpsCGFXHjJ7g2qorzz1zTGSxtioiFokuLSeqqKfyidtJ8
 3Tj2VPfP2XUs+uPFO3+7CFSUIF0cJ2OBUCheAfpnwEGB8BLktFnseBNyZqwXa1YgUhLh
 Fn97BEXl5IKJwT2Aj4g1c97tzUOZZ2JU2P+129b1jsqKVbJvwVYlsnRda8OCVRUbbiam
 wawKAwFi08E0hROuYjRTExK5Fd8ycmvcV8dz85LaxklNTAdWwCDn/Cf1FVIX/qmjypzi
 BiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752565331; x=1753170131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYR7w4dLF7UXeRre8tSi0Eeo0/ev/t+Pvvxeqfux61o=;
 b=fCLuTO7rzaNnD5hauNaB9uxWUI01vA9m2i0/GR8IZxETYhnWsI8SAxYjXkvI+Xyb3q
 zcv9kYBHJjN3owZyxUzpfOuAn+GxzSImiGi3/Z6j4BLHbBHb8ZQw5BlxFKCBf2/QQAG9
 Ht5GTIq195fj5YIJ2+tuiwxEOI08yeC3Q0E/JEL9hI5U8+ABbYUsh+SyYknDjx+2USDn
 hnrdSaynPeNAzodrNhRb8aD4WLAalNMn2eO5tCtW3gt910zHBwuTAuPpRxWqcXCYNnVw
 BvPTRGbs0f6Gb1laWOuB47fKANc8MpHH/n+KZBi4OAq3O1/g6lH06NyA7kavwTnYfeHT
 Ll6g==
X-Gm-Message-State: AOJu0YzKEfT155rVJT57fPNlS7l7wCgbypwoXLglYcEMn2W5vrMHNn/u
 NOml9jBj3fvsUJndcicMRvqWdEzNYjz504lsczpCRRx+6NFcpQ3js5xGB8O1oJaRRA0vxM4uKBf
 Btg28igUAVm65hLMwsmRSesMkXUmj26nehuM6W8l/nFQ1pe3xDUDcI5A=
X-Gm-Gg: ASbGnctCNu43BacwIo+K9g09674wiRla9W+WMykezqESl67Sr/9gEkBsMWBVP2mma+G
 8kg1sH8ADBuKjehDdjGX7nTBCRhLsziQBgq6bCzkhWRqAlhOICbCDSIRKrlvWGgBAYKLNmclvVh
 p8UEaalpJfvAqZkVJ8bDP0ibDfBmX2BDDkuotsK0ctyMc2ULPjWL2uRbEs5N+jL+fls3TA2odjP
 IUMUGM=
X-Google-Smtp-Source: AGHT+IH9l5kwQ+/aFdN2ODXd15pi1XqGQJurcOEDtEwFvl/KI9Uv8CfosqCqCc4PCqPhf/Abc0EHOszJG7thOk13GEM=
X-Received: by 2002:a05:6402:3127:b0:609:b263:41d3 with SMTP id
 4fb4d7f45d1cf-611e86184f3mr10956068a12.32.1752565330836; Tue, 15 Jul 2025
 00:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250715071528.46196-1-philmd@linaro.org>
In-Reply-To: <20250715071528.46196-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 15 Jul 2025 10:41:44 +0300
X-Gm-Features: Ac12FXxi_XwekSIvtVBq4Pa1K_wHfP3KJhO9XrJJKp-apJEpMIR0cI6nIp8L1RQ
Message-ID: <CAAjaMXaeRTCw7XStmq=Mnj0M4TWop1zNCrSSa6sH0mvoE1SM9A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, 
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, Jul 15, 2025 at 10:19=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> "hw/xen/arch_hvm.h" only declares the arch_handle_ioreq() and
> arch_xen_set_memory() prototypes, which are not used by xen-pvh.c.
> Remove the unnecessary header inclusion.
>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20250513171737.74386-1-philmd@linaro.org>
> ---
>  hw/arm/xen-pvh.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 4b26bcff7a5..1a9eeb01c8e 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -10,7 +10,6 @@
>  #include "hw/boards.h"
>  #include "system/system.h"
>  #include "hw/xen/xen-pvh-common.h"
> -#include "hw/xen/arch_hvm.h"
>
>  #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>
> --
> 2.49.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


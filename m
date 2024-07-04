Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF49C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIsX-0001m6-Bt; Thu, 04 Jul 2024 05:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPIsW-0001lH-Ef
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:35:48 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPIsM-0002rl-Co
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:35:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa6b3so4141a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720085735; x=1720690535; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HmY7sgA1giYdLexKfeUXxNv0Ke5XVPxlGYl4+WbrtEw=;
 b=pdD+zizt1mlQCf13Ztpgbry5ye/aVL7yOMz33bNh/zuUrEk57sPDIF/MwmzAvTytPi
 aB6g0d+6p/+rBFkVKp+BtjvJIi4QD/IMzS1KpLOkAZDYFH0o3AkMeuIjtUxhrl2549Ld
 ON7I4m6ym/T7xo1spPkzTcYT1aivsrncbGCkFr9vCRHZKBGLsgSvHZjb6tREceH7FQ0g
 2MoLSme5I64boiJJYzAX1SoAmqN2/pUqO+XbPTriBqaehUKNEVRAHzdYtihuWFNWf+w1
 My8Supg1Dh4LItFgtzcM/BpG0nsmn8KJ2iA4tnlYTWshAnNTC80Ke+/N1s4ppK+OBp03
 QegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720085735; x=1720690535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmY7sgA1giYdLexKfeUXxNv0Ke5XVPxlGYl4+WbrtEw=;
 b=Lm73zIo/tL8FgzIETooaSAYXDC8Pc2sIEbU/CRXH+0qHl7KbAR3Mwg2QIInHf018+J
 B9VFAJoYw4P9TqgsghfCFTSYPPrMd64Gh7v/R7t3E1KWuN198tNJ6C3rrzhVVsjtNOEJ
 W8VEzk/LxoRkP1VuO+X5ZRogXuagk5DaErbYgrGI1sKBeAP75qtzR4F8IUE26RAZvoyU
 RiOxOGYbpWtdrHy+WChZXwxTEYOAWBlaQeJ5erMJccILYC8R54tqI5Kb4nCr8WSDJbLX
 LVzLGVr+jNjv7RtAdf4lJa1Vl15ghaBmMb4khixtsXZrKsYU/hK3PZyOnxr4e0qrHoCm
 UK1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfHTJw/O0+mwlihmvgNMnppAAHyAiCNCE5EOM01DavkktBzoVqFgiD+H0xCWdZgxTaKAkdjG8w8Cb3lyKktxvbPOJBZ+M=
X-Gm-Message-State: AOJu0YxzaDY0hNTR+AswNWK4TX0k7Mm4SLp4tUQGuk4+c3y09x/XXbrg
 wPSJ02COjzyemUTbvBomu+MeLPuz31WNKz4e6GUz820U8etVr5+uTO/oM6JywAtPRQXLgITA0D7
 emljOVeml/iL79IFHAje3TOTWVgEq/RaMwWAuvw==
X-Google-Smtp-Source: AGHT+IFbTR1Ef8u6fiv4NGrNg+TDdT/8wn4LheWeXDbrLfZ5rFHVZYOsQZhTrUGZRUFyhc0OfK7HzcqhafOmq3me9r4=
X-Received: by 2002:a05:6402:b29:b0:58c:3252:3ab8 with SMTP id
 4fb4d7f45d1cf-58e5bd7d6f3mr938422a12.37.1720085735488; Thu, 04 Jul 2024
 02:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-2-zhao1.liu@intel.com>
In-Reply-To: <20240704084759.1824420-2-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 10:35:24 +0100
Message-ID: <CAFEAcA9CLhREMhbNs4MU8+YfjLoZBeQR3Y1Hjtxs3g6AAdCxYw@mail.gmail.com>
Subject: Re: [PATCH 1/4] accel/kvm/kvm-all: Fix superfluous trailing semicolon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 4 Jul 2024 at 09:32, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  accel/kvm/kvm-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 2b4ab896794b..64bf47a03300 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3878,7 +3878,7 @@ static StatsList *add_kvmstat_entry(struct kvm_stats_desc *pdesc,
>      /* Alloc and populate data list */
>      stats = g_new0(Stats, 1);
>      stats->name = g_strdup(pdesc->name);
> -    stats->value = g_new0(StatsValue, 1);;
> +    stats->value = g_new0(StatsValue, 1);
>
>      if ((pdesc->flags & KVM_STATS_UNIT_MASK) == KVM_STATS_UNIT_BOOLEAN) {
>          stats->value->u.boolean = *stats_data;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


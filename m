Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8EE7544F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 18:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYTii-0000Q5-WB; Wed, 24 Dec 2025 13:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTif-0000Ie-5T
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:36:21 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYTia-000455-9d
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 13:36:18 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so911812866b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766601374; x=1767206174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO1FVFbNfLCnO9IEji672Uu2JjucrMBSNNVWyHgZojA=;
 b=K6YcQ3/ljfx/SISfnVN3ORvRcQt6IpovmkHoJeaZ5TQUvmLGqOOaWPZIAMhg503xg4
 HiHArodyLpRmnbN3KeRDeFUsyuAJN7ONPo38VkhzF0BBSRumQZjXr+jxZD712pGI5ZTj
 o+2UHnRA9r//Q/rZD67NUZBwdWNDxLbKSHjoT5Aweh4IrCi/ajnPjHpSKO44svjwOf9V
 qvjffWZj+zeRtCcWuhiEwdVgLP7NCbZju+V2IMYd6Hf2EgTF3+Gn3cPgsKzhCFn7O2uY
 RDyIbzlD1GgUCeJxjd7EKRhe9XdSRZc/uNFJUSdWcWzSGVAErhj4uFhmPcVsPZ+D+l4q
 +l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766601374; x=1767206174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tO1FVFbNfLCnO9IEji672Uu2JjucrMBSNNVWyHgZojA=;
 b=wdAtlXh9vKoZdncji/jfBgeAYIioUkOpyuxg4PBIb9DIWlVJOm4HATKbYPubvIDrQM
 tJyDw0LhAVo6FCADAbnELHNJW2ufBvGyBOMZCe3lGqr3FOnvMGKG61IhBiRMvzsUr3Oi
 MInu3L7x6zHokhS2jESuwAjH3lWLdATZ/naRbOwr3TTWyD1tSbGDo/qRBpO+XOHUSCT1
 G9Rafn7QMY8GTGkizMNMgGC2IZXFmgPWN/qGNh3tnbHh87+V4mTEYV4MO2k1NZ+s1eZj
 uxZtO956ZQQzMmMqIEYKn4tCSYVV2ZAO5iHFPd+mWTbQm+YumcPQDG+YHRWw3T+BFLsC
 HlXQ==
X-Gm-Message-State: AOJu0YwZy6nImhwQzCv2aaqT9uMB6kYnrg4M2YGjPN+U8hHRUhc3HQIi
 v7GROC9mrbS8QengejGaf6oWqokMPuCn2fepUVLcY/6Ck9C67nxLngnXCI589WVE+Wz/gGxt7jt
 3gSB8ipxcj4HYU9hmurLu+aHmLTk0YHpx2s/DK0Hs1xHQkIHsU7HXlWY=
X-Gm-Gg: AY/fxX7iA8xCBQGfusqrAQXbwPQjRV/m7Nds/J6x1lYouBUeanIwFIGdOhqkGfQmNha
 sItvhwqpWq0vFWBKr27QYibS2dQPMLbn+jD2aa5THY31WMpJkpLNSmrtMJ0nr+XUHMn9WuwWMob
 CejW9Qz2Uk7euIUsjINmRdRUL7PoNRtN/n4TmONUJU1UOUlmvN2aB73kbAJbl0m74w+hvbrIPev
 eZWzzMYlvf7xDjKq5i9yCvf9i+7e5UON6fApWHEoWm5POBuX+rwqtQ/RXmUFtHhR2OizeF+NS7w
 XQR/GA==
X-Google-Smtp-Source: AGHT+IEgQU9LCY2kisYzA/NHGWdi0sEcf0xaTMtL0CyfVZ7wYezF9zZLyxWbSjd86YxL0FIqARjzn4nA3eFNAqsKe7k=
X-Received: by 2002:a17:907:7f0d:b0:b73:301c:b158 with SMTP id
 a640c23a62f3a-b8036ecdbf1mr1854539066b.6.1766601373780; Wed, 24 Dec 2025
 10:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-7-philmd@linaro.org>
In-Reply-To: <20251224151351.86733-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 20:35:47 +0200
X-Gm-Features: AQt7F2qhqNFlURZgbDH6YfF8faS-NkZPvaSkP8f7YdkF4mwHjJgt9nXDphOoX7M
Message-ID: <CAAjaMXanaQyORx+LFqdPvSgpvb7xV+-DGwFLkn3R5GDt29MMYA@mail.gmail.com>
Subject: Re: [PATCH 6/9] configs/targets: Mark targets not using legacy
 ldst_phys() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 David Hildenbrand <david@kernel.org>, qemu-riscv@nongnu.org, 
 Steven Lee <steven_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

On Wed, Dec 24, 2025 at 5:15=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Luckily these targets don't use the legacy ldst_phys() API at
> all. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
> hide the API to them, avoiding further API uses to creep in.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  configs/targets/avr-softmmu.mak          | 1 +
>  configs/targets/microblaze-softmmu.mak   | 1 +
>  configs/targets/microblazeel-softmmu.mak | 1 +
>  configs/targets/rx-softmmu.mak           | 1 +
>  configs/targets/tricore-softmmu.mak      | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmm=
u.mak
> index b6157fc465d..baf20fb7f2f 100644
> --- a/configs/targets/avr-softmmu.mak
> +++ b/configs/targets/avr-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Davr
>  TARGET_XML_FILES=3D gdb-xml/avr-cpu.xml
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/mic=
roblaze-softmmu.mak
> index bab7b498c24..cf635798c90 100644
> --- a/configs/targets/microblaze-softmmu.mak
> +++ b/configs/targets/microblaze-softmmu.mak
> @@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=3Dy
>  TARGET_NEED_FDT=3Dy
>  TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/m=
icroblazeel-softmmu.mak
> index 8aee7ebc5cf..52feb957b48 100644
> --- a/configs/targets/microblazeel-softmmu.mak
> +++ b/configs/targets/microblazeel-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_ARCH=3Dmicroblaze
>  TARGET_NEED_FDT=3Dy
>  TARGET_XML_FILES=3Dgdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-=
protect.xml
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.=
mak
> index 1c250a6450d..3a90f1b9977 100644
> --- a/configs/targets/rx-softmmu.mak
> +++ b/configs/targets/rx-softmmu.mak
> @@ -3,3 +3,4 @@ TARGET_XML_FILES=3D gdb-xml/rx-core.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricor=
e-softmmu.mak
> index 781ce49a62f..5e018d81068 100644
> --- a/configs/targets/tricore-softmmu.mak
> +++ b/configs/targets/tricore-softmmu.mak
> @@ -1,2 +1,3 @@
>  TARGET_ARCH=3Dtricore
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
> --
> 2.52.0
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51784C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhshQ-0003DD-1S; Wed, 06 Mar 2024 09:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rhsgz-0003CL-2D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:56:28 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1rhsgx-000793-Iw
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:56:24 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so292370166b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709736981; x=1710341781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HynQNevTRFTnhhBTBFXt+8D5Wmwb8gSgwzclZoQWLxA=;
 b=c0F1r8JWrJ0VuA0KmDkaZncbFitAa/KC6AyhwTUmfss5PT3rve9YbuTSGBqBA1tZQ6
 0fKewD4CQ2JVcoNug1+Or7spKYNruMZMJjh8Z3SEQNFK+4bt8pzpx/Ilq/rxi6c7I7JZ
 1dUQjoZn7Dr6JBavFzPaIN//5ojSVqyp/xK1tjkHYenwtw+5vhCOll2GCNFPE7vGuSW3
 te0Rq3D8NkTL36HtzdJfis9Xrl5PgwJglqtEnJffZNt9mT7PoynQQPi1fKgp3I7Twj4Z
 Zn4ywNcTJ24Z0VRH5CKAY5yUnEJnCEosU0znnjRXlA5Rpqf/CUj4Ekarv8hATnSpPVZY
 xTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736981; x=1710341781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HynQNevTRFTnhhBTBFXt+8D5Wmwb8gSgwzclZoQWLxA=;
 b=IePK/z3h8UD9C7vYXa3jscTt/cWTD7GLKOZS9MPEBmJCG42A33mYK3up+SKWmsJqxe
 J2FfOTEvecII7ib/ernig1wBASrRnTfaSoK2qxWNsB1rt6A06tWFCwAFUrdjD+hQcn+K
 olTo2NC6MBbZnNaueq4tjLKIsfj9e6BZQzESFE+UXzn03XlirbqspIP7RX1eJohI7PWY
 D7MkyDI0ZUImSWP7xfPVJCwznxjHqXsLm9tg5d0DWqmvlnm7KvkecTiK1dXA+NCCEpzV
 G+T7IUJBw0D4nIA6y+2qZ1nZEQgs7WRBRpGFp16P73GxF+k93TURB3PsI4hvOEe1GSRP
 9BXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJRaWkRF3ecK4thryuj7b4F6I0JPGhj2QtpuX8hdVw3gL5Ml4wj6hNVnyNUAEPQ07b0vQlkUm2H/oRRVGuy58L1lXTPH0=
X-Gm-Message-State: AOJu0YxWDaGnkdXgR1p2THDE+408/zNLbloF9KhdWn4tP/gn3IJyICI3
 +FS1CcSQsQOC7rOVF73jrIKTX4inX4zHSS889D4IojEGDVjcu+Fbl5vZ0tdOkJjHiUq0sL7TElQ
 zURzIXoLuwusIWoOVkskXqybm7ck=
X-Google-Smtp-Source: AGHT+IEL989t5WltwZxkjyflbwkyLMIJz1YVe3rxti+SoQuUW3ljeYQ+vFYp50rlDPRczOnU1QtL7ARtKuntXMyZWac=
X-Received: by 2002:a17:906:c5b:b0:a45:c2f6:eadb with SMTP id
 t27-20020a1709060c5b00b00a45c2f6eadbmr653538ejf.73.1709736980718; Wed, 06 Mar
 2024 06:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20240229113842.619738-1-gaosong@loongson.cn>
 <20240229113842.619738-2-gaosong@loongson.cn>
 <168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org>
 <5e2419ec-6c1f-e21c-2105-fadb5971239c@loongson.cn>
In-Reply-To: <5e2419ec-6c1f-e21c-2105-fadb5971239c@loongson.cn>
From: chen huacai <zltjiangshi@gmail.com>
Date: Wed, 6 Mar 2024 22:56:10 +0800
Message-ID: <CABDp7VqyOL9OdxRohru74CyhQzR7W6MwKcg8WCvOVWJz1echMA@mail.gmail.com>
Subject: Re: [PULL v2 1/1] loongarch: Change the UEFI loading mode to loongarch
To: lixianglai <lixianglai@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Andrea Bolognani <abologna@redhat.com>, maobibo@loongson.cn,
 zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zltjiangshi@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi, Xianglai,

How to pass the BIOS file to qemu after this patch? With the old
cmdline I get an RCU stall and freeze the kvm host.

Huacai

On Sat, Mar 2, 2024 at 12:14=E2=80=AFPM lixianglai <lixianglai@loongson.cn>=
 wrote:
>
> Hi Philippe:
>
> On 29/2/24 12:38, Song Gao wrote:
>
> From: Xianglai Li <lixianglai@loongson.cn>
>
> The UEFI loading mode in loongarch is very different
> from that in other architectures:loongarch's UEFI code
> is in rom, while other architectures' UEFI code is in flash.
>
> loongarch UEFI can be loaded as follows:
> -machine virt,pflash=3Dpflash0-format
> -bios ./QEMU_EFI.fd
>
> Other architectures load UEFI using the following methods:
> -machine virt,pflash0=3Dpflash0-format,pflash1=3Dpflash1-format
>
> loongarch's UEFI loading method makes qemu and libvirt incompatible
> when using NVRAM, and the cost of loongarch's current loading method
> far outweighs the benefits, so we decided to use the same UEFI loading
> scheme as other architectures.
>
>
> FYI I'm still trying to find a way to avoid that, planning to discuss
> more with libvirt folks. Well, maybe it is a waste of my time and I
> should just stop worrying / caring about this long standing issue.
>
> Thank you so much for your attention to this issue
>
> and your long-standing contributions to the community!!:-)
>
> Best regards,
>
> Xianglai.
>
>
> Cc: Andrea Bolognani <abologna@redhat.com>
> Cc: maobibo@loongson.cn
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: zhaotianrui@loongson.cn
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Andrea Bolognani <abologna@redhat.com>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixi=
anglai@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>   include/hw/loongarch/virt.h |  10 ++--
>   3 files changed, 107 insertions(+), 33 deletions(-)
>
>


--=20
Huacai Chen


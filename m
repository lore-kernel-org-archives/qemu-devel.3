Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4EEC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7klr-00046G-5r; Wed, 23 Apr 2025 20:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7klo-00041Z-0t
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:48:52 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7klk-0004GR-57
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:48:50 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5241abb9761so217110e0c.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745455727; x=1746060527; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNzOMyTbvELxSjLUdBzszKvLohSoAn0colYYXzWsCf0=;
 b=D33Vf8dcwCwKhzayRdkWzTYnGt6BcNmkBI4+OBWc2ybL3simYzSUBuClY76CNb5JHc
 xUPyO8CTpgcr/lHp0nqmHx4DZ5928l6fXp8XMc6pA4spJIcNNDVjt3Q64SCaG3neCBSH
 RBZwU9GZlFmCRTbk3Th5rz8id8JqQ64hxhWUHqr9azwk/USEOOkFwU0hiuhoopFWzThz
 geVKaEZwdFE98yeT7Si8emF1r6GqIfodI0fFh5tL90hqWbLSjxUJRNlvinPi0xmUa5Nn
 pjmEbt3SesiLJc0HS63QejhlYAG5/z7/AWXkkmCb/pfLoh40YAwUoCRU07FwjV/6RuJ5
 Pblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455727; x=1746060527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNzOMyTbvELxSjLUdBzszKvLohSoAn0colYYXzWsCf0=;
 b=P59ujSGDpmSWU3RLZUbBNmV0yi3RhSC4IN5EmEvB1v1EkFqJY/xwfiUz+wRDcQYTne
 DwnJ7Y6mYWXzsuq4WKQAnWybrP2vTUUTZa+RboQkH6+4FEnEugSe8cGCE2ydcutiuR10
 i0L9v34CQJGD4GoSBy8S9fMNF6HqcMq7R9U7au9QG60kyfa+qrhv71PQdi7iqV4TAPPO
 YlPFep3P0gbA/pB5L35SpNjL7ElecZ0arEPodTkCAhUorl8lJV4a7zuhp5k4oz/g5oE7
 V3s9+iclPWYwGo+gr1ymzjZZH3wx4OpaL2fvfuXFJiGSWCPpD1z3kzWTuZkT68LLj4QM
 TmoA==
X-Gm-Message-State: AOJu0YwngVAOi8GMI/Y4YWEQ5Q7Z4hwrHsuQLQLa5LuvYWSRg1GpRH5C
 HsHZi1iVpuoY01w5npVxnnfCm1Rqo5j5KWjQGNKKmllcYjZTmoIbgx4AsEbpU/L5ELU6htNjPXm
 /rYF3jnd9dXcnE9bIAea9F91YynTAhg==
X-Gm-Gg: ASbGncvJqUGDvVNRt7M9Yped5Ny/gS+qaq789SnzQW3Gu/v0PcvFiAIUGWZb+6a1/i0
 ATnApZsfIa1yAZSSH6j7Jk6jvfdK9nq0byMxIMcjAXsM5tglIy0fJuZcKaHi5dCKX8FQPmbthti
 tfPGjwv6WpLblrrf4KtrWKYSOGaBDGw2ZR3Ts0Hxz3qmBWaVLZmMTD
X-Google-Smtp-Source: AGHT+IGianAVuTbopjBe+R7+LZv5zHcNcrQ8XqjD2EtbTeXLwtiom6JsBkYech6s7m/ilyjSSigUyiHhkylRG9P5TUM=
X-Received: by 2002:a05:6122:1351:b0:525:bf40:e628 with SMTP id
 71dfb90a1353d-52a783828c2mr758469e0c.6.1745455727185; Wed, 23 Apr 2025
 17:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250406070254.274797-1-pbonzini@redhat.com>
 <20250406070254.274797-28-pbonzini@redhat.com>
In-Reply-To: <20250406070254.274797-28-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 10:48:21 +1000
X-Gm-Features: ATxdqUGnpbYWZ4HzV5msblLLKBFvHyWD2qTYD87GObC5T5YPtoMi2BEbcvL78c4
Message-ID: <CAKmqyKNFCpLZx2RfXN75xMrhsoB+-LnQiEBo_mJxybVjS-bgcg@mail.gmail.com>
Subject: Re: [PATCH 27/27] target/riscv: remove .instance_post_init
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Apr 6, 2025 at 5:04=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Unlike other uses of .instance_post_init, accel_cpu_instance_init()
> *registers* properties, and therefore must be run before
> device_post_init() which sets them to their values from -global.
>
> In order to move all registration of properties to .instance_init,
> call accel_cpu_instance_init() at the end of riscv_cpu_init().
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 0a3a0343087..ee20bd7ca22 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1089,11 +1089,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
>      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) !=3D NUL=
L;
>  }
>
> -static void riscv_cpu_post_init(Object *obj)
> -{
> -    accel_cpu_instance_init(CPU(obj));
> -}
> -
>  static void riscv_cpu_init(Object *obj)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(obj);
> @@ -1149,6 +1144,8 @@ static void riscv_cpu_init(Object *obj)
>          riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>      }
>  #endif
> +
> +    accel_cpu_instance_init(CPU(obj));
>  }
>
>  typedef struct misa_ext_info {
> @@ -2889,7 +2886,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .instance_size =3D sizeof(RISCVCPU),
>          .instance_align =3D __alignof(RISCVCPU),
>          .instance_init =3D riscv_cpu_init,
> -        .instance_post_init =3D riscv_cpu_post_init,
>          .abstract =3D true,
>          .class_size =3D sizeof(RISCVCPUClass),
>          .class_init =3D riscv_cpu_common_class_init,
> --
> 2.49.0
>


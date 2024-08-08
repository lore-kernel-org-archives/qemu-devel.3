Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644A0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 04:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbuiU-0001WV-Pn; Thu, 08 Aug 2024 00:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuiT-0001Pj-Mk; Thu, 08 Aug 2024 00:25:33 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbuiS-0004HV-79; Thu, 08 Aug 2024 00:25:33 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-825a23c5e4cso145189241.3; 
 Wed, 07 Aug 2024 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723091130; x=1723695930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiA40MLsMtAnhRi+xNL2ixDz8ahQzn3oV+a9tx9IOb8=;
 b=QONIaiKpVHkLBao4gk9Q/n1DVxLwLBT0+UjtzvSpUzTw9vOJJuLdjLaWXziddpILcQ
 bHnXuwdMI2gYFL1Cpqm8YfDnZKuDAxFRcZlewxFtzFp6tSBOfKfeZhMUCVb5qSEFBWc8
 LLcqBnDW04YwyewRSjL1OPjzOLTm70rgsU9R4etJCQ0yX7EYjoI9NA/gKAd2sxpm6a1k
 tTTXkH2MwxT9EwHRZY58q/xc4tsRK5zajsCF/ZwDdYYl+AlbjGYy2Qxq+OawY33CrxRj
 /DpnqSCol3ycQCYXqQCQBfPD4l1ZYZxwyNTJx7LhrFdLn7A8RPlP4WYin0ei73mCaQNG
 2beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723091130; x=1723695930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiA40MLsMtAnhRi+xNL2ixDz8ahQzn3oV+a9tx9IOb8=;
 b=uc3IAWcngEYCaur3BsBu17ymsax9QvAlz21aPVDmVEZdpgCPhuuzCbXHAJoX/R9iDM
 u3y5MU5YklO9CnprC0lbOEuXKaM+kIAykiKtHCvE7jisGOoEeLpB1nnY1qKQurPfyVK6
 j1NsBuCGZAxiphYBtVGx3fuuy0tU9z3dnPX+klDFs0trAfduSgZiXjLjvFJhM9AT364a
 MPerlBE05lEvPOuBM5cWvChepQcpNjNVMWw73vMGJXYbp2wY4aSFNZ1lYlm5nHIxsd59
 ubgN0LSNXmzY+oDj1+yEQydN4zGZXpdZbbzpJmDjH6kQ1l+m7aQSFw/kL8xKdO9jlzrD
 IcfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+5a/lzYf7PbwhCEnRwJKlFWtoDCrr3oZEzD4ZkmfEsfD4n4AUbgDkt70e456v6QyUNYWzZ/QCwj9PbeSehpftHht2TA=
X-Gm-Message-State: AOJu0YyzdJzrhOSqNBBD4VTHkhpVPWEZJC/MdXfYxFPzHhLpweQhEbxG
 1ewM+8F7UufNP1Oj/QZ0mByU8pe+Vd4V4bddM62URHd3UvuC7wlXeINYOzhps6Dc5UQHuqjuG9w
 tpBC/B2AZgKtviwnDC9IdKog1+KE=
X-Google-Smtp-Source: AGHT+IE7KgIPaQSIl/x5HhvV7tDRYvnoyny6Aif+8ppNEdBTfWM5ICQBTocchp8WQnVDsiubjtNK0mX6teMeXMP0OOM=
X-Received: by 2002:a05:6102:e0a:b0:48f:e759:94bc with SMTP id
 ada2fe7eead31-495c5b4a2acmr815099137.16.1723091130386; Wed, 07 Aug 2024
 21:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715101409.1249373-1-ethan84@andestech.com>
In-Reply-To: <20240715101409.1249373-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 14:25:04 +1000
Message-ID: <CAKmqyKOJOUvf-=qNQ90BQeFGNayH1mmtcYNd=iYVjNf53V-uMw@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] hw/misc/riscv_iopmp: Add API to configure RISCV
 CPU IOPMP support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Mon, Jul 15, 2024 at 8:15=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> The iopmp_setup_cpu() function configures the RISCV CPU to support IOPMP =
and
> specifies the CPU's RRID.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  hw/misc/riscv_iopmp.c         | 6 ++++++
>  include/hw/misc/riscv_iopmp.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> index e62ac57437..374bf5c610 100644
> --- a/hw/misc/riscv_iopmp.c
> +++ b/hw/misc/riscv_iopmp.c
> @@ -1211,5 +1211,11 @@ void iopmp_setup_system_memory(DeviceState *dev, c=
onst MemMapEntry *memmap,
>                         "iopmp-downstream-as");
>  }
>
> +void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid)
> +{
> +    cpu->cfg.iopmp =3D true;
> +    cpu->cfg.iopmp_rrid =3D rrid;
> +}

This should just be a normal CPU property, which the machine can then
set to true if required

Alistair

> +
>
>  type_init(iopmp_register_types);
> diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.=
h
> index ebe9c4bc4a..7e7da56d10 100644
> --- a/include/hw/misc/riscv_iopmp.h
> +++ b/include/hw/misc/riscv_iopmp.h
> @@ -167,5 +167,6 @@ typedef struct IopmpState {
>
>  void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memm=
ap,
>                                 uint32_t mapentry_num);
> +void iopmp_setup_cpu(RISCVCPU *cpu, uint32_t rrid);
>
>  #endif
> --
> 2.34.1
>
>


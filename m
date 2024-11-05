Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4513CD40CE8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SWV-0002tN-RU; Tue, 05 Nov 2024 17:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SWT-0002sa-Bs; Tue, 05 Nov 2024 17:59:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SWR-0006o3-QE; Tue, 05 Nov 2024 17:59:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso51044185e9.1; 
 Tue, 05 Nov 2024 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847578; x=1731452378; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8uIkV3u6SmtEJg/8GH4X2spxKLpo4gSdS0bpKBursNg=;
 b=IpW4Xm6jp5Ue0cp0DCAb/evfIBjrx5jqOmlWVbGlt5PpIn7X9JxH0x4G48YY9Rjl92
 yHFW3onT+x7o38aWefb1noNlkrpl5T6pw1tEiafq3Y4nmcAHI4Vjkx3Jo7wPehRIZXkv
 V2ln93PvUGLCKlE20AybD8W2ZyP3kia1oQnJvfnGfcU7ircnHZbRU6AxixXZQ6iCcjsQ
 5HQ30pxqEP+U41N0NTAvc3E0YF/TmamRP34lH/bSmdaDoAWXsIdelLg1KOd0HremUPSc
 n2NxkPEHkTS9a6tVUYxkXiNzPS/8iprPQdqm7Ykz1dNazCSAy3aGrpwSfNfTX6NkigQe
 /iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847578; x=1731452378;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uIkV3u6SmtEJg/8GH4X2spxKLpo4gSdS0bpKBursNg=;
 b=V1KSn6h3awXw2pCmpiMEZVX8/w2veSXnb+xsnay/l7wnBoIEjliHaUqPVRbCeR0kuc
 mqRlTXpz3iX4jAB9vo41Gp35h1ksuEzhe2OjoKgHx9HZl/PCSuaXBTyps+yJRLQw4bcd
 29XF3ut+uM5F6Se6/Sj8WZ+Wn65efJuXVwi9/MghQomJLMl0IlT4WMlJbF/dvgMnDKqq
 Bn5/tftuxLDws7S1GQBtvjhILCJZGAToPZlMNKtQYM3AKHhNgezxjY4shaaq7OkkNRD5
 6lSfA7BqAik6MpefoZ4aY+3teGXvtK5cnyLWvkDEdp94O65IxiNRoKdi2qbBX9LNzkjU
 byZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv9k/ftt+Mfhf4VIEdelD5IMmOoP+/oPAkrmX9mX3oGO8QLfUCwUX0XdMRKhuroUCGY2DBk8QsvQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx2fIuLhM2C06W4SDpGX+tIs7DlkGQRJ0pe774VRdQKVjICS8w2
 q0Ly7YRdGP8mtfB21eFcDbcDTQwQxFogH83Pl92TBZaQz5JUL5NILaC/u9xoSxc=
X-Google-Smtp-Source: AGHT+IGdFSxT616ZnzVryWrUv5Ad4/inzte2KylzsV+VMPTKeQggWsUyQKK6vsCxrxa2FsgtwGE/7A==
X-Received: by 2002:a05:600c:4f06:b0:431:5f1b:a7c6 with SMTP id
 5b1f17b1804b1-432832965d2mr151455145e9.30.1730847578104; 
 Tue, 05 Nov 2024 14:59:38 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa74abb9sm1162795e9.42.2024.11.05.14.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:59:37 -0800 (PST)
Date: Tue, 5 Nov 2024 23:59:37 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 05/19] hw/microblaze/s3adsp1800: Declare machine type
 using DEFINE_TYPES macro
Message-ID: <ZyqjWWjYaNPdBTz4@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-6-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x331.google.com
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

On Tue, Nov 05, 2024 at 02:04:17PM +0100, Philippe Mathieu-Daudé wrote:
> Replace DEFINE_MACHINE() by DEFINE_TYPES(), converting the
> class_init() handler.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 581b0411e29..6c0f5c6c651 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -55,6 +55,9 @@
>  #define ETHLITE_IRQ         1
>  #define UARTLITE_IRQ        3
>  
> +#define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
> +            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
> +
>  static void
>  petalogix_s3adsp1800_init(MachineState *machine)
>  {
> @@ -132,11 +135,21 @@ petalogix_s3adsp1800_init(MachineState *machine)
>                             NULL);
>  }
>  
> -static void petalogix_s3adsp1800_machine_init(MachineClass *mc)
> +static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>      mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
>      mc->init = petalogix_s3adsp1800_init;
>      mc->is_default = true;
>  }
>  
> -DEFINE_MACHINE("petalogix-s3adsp1800", petalogix_s3adsp1800_machine_init)
> +static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
> +    {
> +        .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = petalogix_s3adsp1800_machine_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(petalogix_s3adsp1800_machine_types)
> -- 
> 2.45.2
> 


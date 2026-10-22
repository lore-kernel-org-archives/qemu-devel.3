Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427F606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OOLjPloa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QJy0FZbN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnyA-0002mJ-QF; Thu, 22 Oct 2026 04:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJnxq-0002iZ-UZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 04:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJnxm-00073F-Li
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 04:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792656948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pd9yvcvr/chlVXli0ryvwjePBO7nlluo7pGIyEbqnSw=;
 b=OOLjPloaXjHarLW0hQ5HWLYSi2M1PaY0OsMqADrgm8YkUxtdBEEGfs8OZ8NEGRJCmzCxpT
 GrR2y4X52aBP1QvDmmVkaQTbyrV5Vub6Tg1EdHCUVoU7iLu8H9KqkFCaSHXNeBBFcMsF/T
 PRNXHC3mrYgyLB20/tfGfvq+BK8nWOo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-twe2uhAIPFaeLPrB4bBhNA-1; Thu, 22 Oct 2026 08:15:47 +0000
X-MC-Unique: twe2uhAIPFaeLPrB4bBhNA-1
X-Mimecast-MFC-AGG-ID: twe2uhAIPFaeLPrB4bBhNA_1792656946
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so855510f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792656946; x=1793261746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pd9yvcvr/chlVXli0ryvwjePBO7nlluo7pGIyEbqnSw=;
 b=QJy0FZbNeGpU/oBKSABfjwyXkD+yPxANaPDMq7MCPeXP23EFsnU6Jcc8yiuuu4yf8h
 WVuXSETrm6R/dVkWZi6XfCVNpUZfXGSiRldHV6jFnpQQtaFiNRHCajibsAT+PT60PUJ9
 qm/nBMxZ9uFWv4AsUqs4GwnUR1xIZ4wW29LgqmDWDs/+pio+Xf+YmFAmT3VNWHhlaSz9
 gsKGCNWyBRUhEjI0u44NOfWdiPzLiJF2EzHFFo38H4AFSf1SegUqvaHImAyL/mZwdUUo
 Ke7v8sw1wnx+i1Ftmd3Oxcx90CvXy36akTX80X32res7ANxzkeYZ2D5JlpF55yiY9V0k
 iaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656946; x=1793261746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pd9yvcvr/chlVXli0ryvwjePBO7nlluo7pGIyEbqnSw=;
 b=uzNuuvuF+NzpiPRdZGaG0xPRLO205pBPEfoN4aCIJh10oL+ArzM7VxKEEDzsXNZayO
 sPYLJ14GgRkZIzYczhuMIf9844uu6wIjcs/g0UJsGOUhgU3Z+Mfa6UCewun3eF0Dzzma
 Mn02TGr14J0wTqcJGXsJP8KfC4Vmuk31ULq6U3WrnbKUQHuqTUyxi1gcTkBsO1lzmVE0
 hin3EjO751K1JAQ0VYX4HfJSiEnqC6W96jYAQY2UKMXByf8F41HYTyYFzUEifPynU/K2
 nsK75A4BbPCXYnBOKma4kljfAJ00VGCKAMwP+1KMbDJGVBK5TdsQ06ypZLeyfmc5WYDh
 jsqQ==
X-Gm-Message-State: AFq9FYLsnelr120boPZeOlM9jGPoRo2QGTaVbAz5GYPgIj4O4ftilu67
 iRqbb5XvQMxLMMjkU61zVXw5cCssJHmzOp+SDrRhD4rX/EhsC+ucPwIt6TgQuS85LrRdNn2DCvY
 yLf3qRGzPo0nZX/ug2py8/ab/dDBVV1hQxjmv94HOyB6yLfn9klU95rsX
X-Gm-Gg: AYBFou2Pcq/ADM/km8TlQF/7wyEToFoQSt6vbYn44glJ9Ksevsz4rlB8+XFhDR3A4Nw
 6DlO1fPPXZpUh8DrIr/Ow4HqG5YR7u8L12+uK1a2ZtSKKw60LcjGH+AqoMl37f0IyEBBXfyn6ly
 A6gyFKzASj8vYMNlZtlsgFmgDWralIw4u6Elq9YgM96GFgYzU19ByIa2P0EASJRV4RJkSiTQ+bv
 2OXKInEDjuKM8L+T0W3G+j7RY34PerhK7hl5ZZLrapiVRi6y301hVy+lklZ7yUFPrSrjkMcv6Io
 776e+oh5CU/n3K/8xxtFljHAPD6wTD4GEdG0BpnsJr11EuJtzag0dPJZ8Gg=
X-Received: by 2002:a5d:584e:0:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e264f32edmr9088982f8f.38.1792656945649; 
 Thu, 22 Oct 2026 01:15:45 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e264f32edmr9088932f8f.38.1792656945297; 
 Thu, 22 Oct 2026 01:15:45 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581f0e2sm9892434f8f.15.2026.10.22.01.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:15:44 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:15:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: pillow <waysorrypub@gmail.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, jiaxun.yang@flygoat.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD
 clock and add _STA
Message-ID: <20261022101543.3286780f@imammedo>
In-Reply-To: <20261022072238.319308-3-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
 <20261022072238.319308-3-waysorrypub@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 15:22:36 +0800
pillow <waysorrypub@gmail.com> wrote:

> The UART _DSD clock property contains a typo ("clock-frenquency")
> and has its key/value order reversed. It also specifies a 100 MHz
> clock, which does not match the emulated UART.
> 
> QEMU's UART model uses baudbase = 115200, corresponding to a clock
> frequency of 1,843,200 Hz. The Linux 8250 PnP driver uses the same
> frequency by default when no clock is specified.
> 
> Since the default already matches the UART model, there is no need
> to provide an explicit clock property. Drop it from _DSD, consistent
> with the existing x86 ISA serial ACPI implementation.
> 
> Also remove _CCA because the emulated UART does not support DMA,
> and add _STA = 0x0f to indicate that the device is present,
> enabled, visible, and functioning.
> 
> Signed-off-by: pillow <waysorrypub@gmail.com>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>

do not put several different changes together
split it up on several patches

> ---
>  hw/loongarch/virt-acpi-build.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 54965f0..55c7641 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -314,7 +314,6 @@ static void build_uart_device_aml(Aml *table, int index)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *pkg0, *pkg1, *pkg2;
>      Aml *scope;
>      uint32_t uart_irq;
>      uint64_t base;
> @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int index)
>      dev = aml_device("COM%d", index);
>      aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> -    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));
>      crs = aml_resource_template();
>      aml_append(crs,
>          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
> @@ -335,15 +334,6 @@ static void build_uart_device_aml(Aml *table, int index)
>      aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>                                    AML_SHARED, &uart_irq, 1));
>      aml_append(dev, aml_name_decl("_CRS", crs));
> -    pkg0 = aml_package(0x2);
> -    aml_append(pkg0, aml_int(0x05F5E100));
> -    aml_append(pkg0, aml_string("clock-frenquency"));
> -    pkg1 = aml_package(0x1);
> -    aml_append(pkg1, pkg0);
> -    pkg2 = aml_package(0x2);
> -    aml_append(pkg2, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
> -    aml_append(pkg2, pkg1);
> -    aml_append(dev, aml_name_decl("_DSD", pkg2));
>      aml_append(scope, dev);
>      aml_append(table, scope);
>  }



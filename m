Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EF1C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSwV-0002kj-8h; Tue, 03 Jun 2025 10:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSwT-0002kN-EE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMSwM-0002xs-HP
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748962107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOUWg3Jmen5X0cR8JVd4L/JaEPpWgJSbTLjC7zstNJE=;
 b=Qba50wwbINgQvvUUV3jTgvwspl2CyGCHowzn5LTlMpOqOeU1JJ1f6n5vfFEMUW5o+5I6xV
 mMXqqIyshLOTz1rHKoAv63ZJyaRcI4EeBWGOhyanLqbaJC0Loc80yMLxhziZ2qdUCwTlfg
 F1sGgHRatLKnys1NzD+ydL23BCL6qvs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-MrFVhuuwNsGZwUvGhrmaUg-1; Tue, 03 Jun 2025 10:48:26 -0400
X-MC-Unique: MrFVhuuwNsGZwUvGhrmaUg-1
X-Mimecast-MFC-AGG-ID: MrFVhuuwNsGZwUvGhrmaUg_1748962105
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso1773567f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962105; x=1749566905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOUWg3Jmen5X0cR8JVd4L/JaEPpWgJSbTLjC7zstNJE=;
 b=DecM0AVv8IvL6PZVPylgYJu37YZMXCKGf7nDgVw3Mw16ujjbjz+iwTNrjJwtY/Bxvy
 lvFunPyzJ4aDUgYYu7yLrgJG/qOgSKTas6mgyFbJwypEaWKNFKhf9URWYMIqKat+F7BT
 gCFTffoge9xqIDQEO3W77VGa+gng/3Odfpi1KJOzjQSdszA+MWzvlN7BJcANrECZocce
 Ak+g/0CCrOO8CZgC9d6kge+iH4z/ipSDHBzu1JinyXxgkm9DVq4IdSPfIK9LQ1sDKVFk
 DKQ398r6pt6wRampOlN982jK2jDGK3srhYU62kzLEeHiwQopb6xzh2sgBC7SHGXO8qCE
 tp4w==
X-Gm-Message-State: AOJu0YwdcHf+HAcrQadUX9SDInSrII4tVXKFb43HhG6R9loPnfYIv0cY
 FZhddAUCIxarDHLGVTtsxT30wY0e3qYzYXw8GN87636HaI1Yd6dqrm77+QxNE8dmu23zwZPaEuF
 lq3zocwxZHm4KS5+efMRhjyGNuDeWgv7qnkW045lktX6dC9kymObaNdNTPPjzic5dqAk=
X-Gm-Gg: ASbGncuhSsPKY9D+Iv2rZaqVeKEl9aBfXinHGln4agyqvD4JTsC7LNheCPMaK/N4W5F
 OoMo7a1ZAJaV/5p+CzjmoyprN5g6BnBTq3iwMmJqfd1+IChvegh0Pp3ZlEqOGXLukFCAt2i4zaK
 TOwuLBJveqDY5BlmjPzO7iIRnx0/QLAL73P7jAYx71ggdbhi+X4FbeOS/j5KH2t/dWmvXzj5yIy
 HX/8zLkF8PEVE7rQ47UVe0rGPRjfS+XnaF7trtzgr/VJ7DsdejtD0naUaHToAQQGOVpQ7SauiEO
 DR71tKAetT+AeKvmnp27IKNvjp69TDip
X-Received: by 2002:a05:6000:25ca:b0:3a4:df80:7284 with SMTP id
 ffacd0b85a97d-3a4f7a0234fmr14631805f8f.1.1748962104681; 
 Tue, 03 Jun 2025 07:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5grh0SdCRBD0B9/CZeU24+dLlomp8MBNe932vT3vMzrcncZ9kxpT3wCb3BaUsvwY/eXvHYA==
X-Received: by 2002:a05:6000:25ca:b0:3a4:df80:7284 with SMTP id
 ffacd0b85a97d-3a4f7a0234fmr14631781f8f.1.1748962104291; 
 Tue, 03 Jun 2025 07:48:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa2541sm161283085e9.15.2025.06.03.07.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:48:23 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:48:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf
 <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v4 02/19] hw/i386/pc: Remove
 PCMachineClass::broken_reserved_end field
Message-ID: <20250603164822.6dfe1d65@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250512083948.39294-3-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 12 May 2025 10:39:31 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The PCMachineClass::broken_reserved_end field was only used
> by the pc-q35-2.4 and pc-i440fx-2.4 machines, which got removed.
> Remove it and simplify pc_memory_init().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h |  1 -
>  hw/i386/pc.c         | 13 +++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9563674e2da..f4a874b17fc 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -107,7 +107,6 @@ struct PCMachineClass {
>      /* RAM / address space compat: */
>      bool gigabyte_align;
>      bool has_reserved_memory;
> -    bool broken_reserved_end;
>      bool enforce_amd_1tb_hole;
>      bool isa_bios_alias;
> =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 70656157ca0..c8bb4a3ee47 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -999,14 +999,13 @@ void pc_memory_init(PCMachineState *pcms,
> =20
>      if (machine->device_memory) {
>          uint64_t *val =3D g_malloc(sizeof(*val));
> -        uint64_t res_mem_end =3D machine->device_memory->base;
> -
> -        if (!pcmc->broken_reserved_end) {
> -            res_mem_end +=3D memory_region_size(&machine->device_memory-=
>mr);
> -        }
> +        uint64_t res_mem_end;
> =20
>          if (pcms->cxl_devices_state.is_enabled) {
>              res_mem_end =3D cxl_resv_end;
> +        } else {
> +            res_mem_end =3D machine->device_memory->base
> +                          + memory_region_size(&machine->device_memory->=
mr);
>          }
>          *val =3D cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
>          fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*=
val));
> @@ -1044,9 +1043,7 @@ uint64_t pc_pci_hole64_start(void)
>          hole64_start =3D pc_get_cxl_range_end(pcms);
>      } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_s=
ize)) {
>          pc_get_device_memory_range(pcms, &hole64_start, &size);
> -        if (!pcmc->broken_reserved_end) {
> -            hole64_start +=3D size;
> -        }
> +        hole64_start +=3D size;
>      } else {
>          hole64_start =3D pc_above_4g_end(pcms);
>      }



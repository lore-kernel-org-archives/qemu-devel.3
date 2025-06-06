Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2436C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNX3W-0006Vp-1l; Fri, 06 Jun 2025 09:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX3U-0006VM-N2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX3S-00036h-QG
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESq14eWXFTp1dCbeQEE3YVuG5nrY1WDU99BG76f8tX4=;
 b=JEZ3R18mPZsHFXGdzdg2tJ0DWIF5a5UkJhnznRiE9sLI3ofY9F5bEoSDuhGcDmYvewf84k
 Q18+Ohkxss1ub6gsbE1RnznBvjfO0V0zxd0yPBLc7uvgCT1uHai37lest4hQJyibVtA10x
 zNUODzKamg5vrGIBwAlYJPn4RM3IbDM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-7xvboBNJOH65XNV-SLNy5g-1; Fri, 06 Jun 2025 09:24:13 -0400
X-MC-Unique: 7xvboBNJOH65XNV-SLNy5g-1
X-Mimecast-MFC-AGG-ID: 7xvboBNJOH65XNV-SLNy5g_1749216253
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so989183f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216252; x=1749821052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ESq14eWXFTp1dCbeQEE3YVuG5nrY1WDU99BG76f8tX4=;
 b=S0L9heaVqpi1ntLxV5WEt0dw7fSjl9cL309cgDLXJK1xzmZjd7GX8eSKQRpl5E5QAa
 7uHlZE4RdH2ha1bHQ1ZclcsD63ai2zX7KMILdZhKnSasY61H1cu+mGHrFX80PGpWFLOE
 8K2MXUOfn/0q2aUn1uw30f61JwHgk/wVLso0Y68KXJEACW0NW3a0+SUGHUzzewo9/IFy
 bE7DndwVAOpteU9TqdOu5kpYNZdVLS93LgW/UQmLifJ/jIvCu86vFn7AFBu5ztoKIg3+
 Prbhye6LQgx5l7HvCk9UbqjD6t3M+LkVTwY+ISJy5GYT6UtQhaKj0BhRLRs4aTIKj195
 SF+g==
X-Gm-Message-State: AOJu0Yw1Y0fwYTC4SuAObe9ZlOP6WDcSqyznJzCyPwvaNc7Fdh9Pup2f
 /7EylfBMd3sVQSbWcjwKX7YZZdFwXjfwMV5VSIExM5h1fdO9vEv7SIFHxvKz36ntPw3RxhH5q7n
 6KuPl9+JYRK9mSpBhubeh99Hzm1eIPlA1bMYTebad5AtejDn81+5kzH+5
X-Gm-Gg: ASbGncuSJNk6MSjVJcks5HhhFg1WizEpG8pRRR1srzC4grxovwKZ4gtrZI3HHt3Y5B/
 tz+6FKkBJacHP9QqGr7WLmeontJxEqsed7e99RSdY9G9tbcyn1v1VOfAgnG0lbvpcoisjQYTNJN
 zt/vXT7u6p8a0ttnUckP3cUIt+M097ivAfQfO4pHYHoTchkrMkReZY3wX+g6ngVys/uHKuJqk8b
 UsTu5SKjXXFr0PrcTSK+L+v9rPaW9cKBFXCRJ69Qz+A7FJnJXfUhBUO4d9uNfQOjsO8CAGBTvlQ
 scJjVJ+iNHTKL0/HulvicSPYPWVkN0TbDQPK8vMi46M=
X-Received: by 2002:a05:6000:2010:b0:3a5:1c70:5677 with SMTP id
 ffacd0b85a97d-3a53168435dmr3150959f8f.7.1749216252539; 
 Fri, 06 Jun 2025 06:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHciE0fbJJInI+QZvkFVVhhHFgTCUtgkkU41jeviyU+AgQap/BlDR8QMkWx3VFZ0JBK2yJOIQ==
X-Received: by 2002:a05:6000:2010:b0:3a5:1c70:5677 with SMTP id
 ffacd0b85a97d-3a53168435dmr3150927f8f.7.1749216252135; 
 Fri, 06 Jun 2025 06:24:12 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464e3csm1896184f8f.99.2025.06.06.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:24:11 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:24:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Gerd
 Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH 11/18] hw/nvram/fw_cfg: Remove FWCfgState::file_slots field
Message-ID: <20250606152408.768cb3d1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-12-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-12-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu,  1 May 2025 23:04:49 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The FWCfgState::file_slots integer was only set in the
> hw_compat_2_8[] array, via the 'x-file-slots=3D0x10' property.
> We removed all machines using that array, lets remove that
> property and all the code around it. The number of slots is
> always FW_CFG_FILE_SLOTS_DFLT (32).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I'd keep this one,
alternatively if we decide to nuke it in favor of a constant,
I'd get rid of fw_cfg_file_slots() and simplify fw_cfg_file_slots_allocate(=
) at the same time

Gerd,
 WDYT?

> ---
>  include/hw/nvram/fw_cfg.h |  1 -
>  hw/nvram/fw_cfg.c         | 24 +-----------------------
>  2 files changed, 1 insertion(+), 24 deletions(-)
>=20
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index d41b9328fd1..07a31d214db 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -59,7 +59,6 @@ struct FWCfgState {
>      SysBusDevice parent_obj;
>      /*< public >*/
> =20
> -    uint16_t file_slots;
>      FWCfgEntry *entries[2];
>      int *entry_order;
>      FWCfgFiles *files;
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 54cfa07d3f5..71c41c979d7 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -257,7 +257,7 @@ static void fw_cfg_write(FWCfgState *s, uint8_t value)
> =20
>  static inline uint16_t fw_cfg_file_slots(const FWCfgState *s)
>  {
> -    return s->file_slots;
> +    return FW_CFG_FILE_SLOTS_DFLT;
>  }
>
> =20
>  /* Note: this function returns an exclusive limit. */
> @@ -1153,24 +1153,6 @@ static const TypeInfo fw_cfg_info =3D {
> =20
>  static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>  {
> -    uint16_t file_slots_max;
> -
> -    if (fw_cfg_file_slots(s) < FW_CFG_FILE_SLOTS_MIN) {
> -        error_setg(errp, "\"file_slots\" must be at least 0x%x",
> -                   FW_CFG_FILE_SLOTS_MIN);
> -        return;
> -    }
> -
> -    /* (UINT16_MAX & FW_CFG_ENTRY_MASK) is the highest inclusive selecto=
r value
> -     * that we permit. The actual (exclusive) value coming from the
> -     * configuration is (FW_CFG_FILE_FIRST + fw_cfg_file_slots(s)). */
> -    file_slots_max =3D (UINT16_MAX & FW_CFG_ENTRY_MASK) - FW_CFG_FILE_FI=
RST + 1;
> -    if (fw_cfg_file_slots(s) > file_slots_max) {
> -        error_setg(errp, "\"file_slots\" must not exceed 0x%" PRIx16,
> -                   file_slots_max);
> -        return;
> -    }
> -
>      s->entries[0] =3D g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>      s->entries[1] =3D g_new0(FWCfgEntry, fw_cfg_max_entry(s));
>      s->entry_order =3D g_new0(int, fw_cfg_max_entry(s));
> @@ -1179,8 +1161,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *=
s, Error **errp)
>  static const Property fw_cfg_io_properties[] =3D {
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
>                       true),
> -    DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slo=
ts,
> -                       FW_CFG_FILE_SLOTS_DFLT),
>  };
> =20
>  static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
> @@ -1228,8 +1208,6 @@ static const Property fw_cfg_mem_properties[] =3D {
>      DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enable=
d,
>                       true),
> -    DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_sl=
ots,
> -                       FW_CFG_FILE_SLOTS_DFLT),
>  };
> =20
>  static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)



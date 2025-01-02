Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D7AE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTLdM-0001ib-51; Thu, 02 Jan 2025 08:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tTLdI-0001hB-61
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:53:04 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tTLdG-0001pv-Kl
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 08:53:03 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467918c35easo152952941cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735825981; x=1736430781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEvGk8FrjUhkYqeaDZqOF70u61jz0WgVNFZYZrXmQxQ=;
 b=f4wYvh1ama0eZSVZCOv90KDzZhY90hNHlo9MpjW+mYkUKnQk6Paqov11fuXxNUiMoI
 RXoLYpVsQDAHZiJArgyuBIC2lw/6XEJOTRJ+LVlCm1P8KgCHZywkiMz9EEQ5WMXXYGsj
 fsjE9794q5PUOL3ewzAkzWJVmA9nFjFqCzLd6T893Cr8wehJOfHdBKSlqL8+OJKYJ+1S
 apt0QPyWAjZz+LLPZOF11zy9C0G3YwurOUKjVgCwGkOCdFBNBl/TnWsUbWbybAjN6lSo
 Iv076VNgJi4jm6K+T99LCtYbpmBz4nTsQ2SMDOwo7NaQT0zUovmoHwSxtYRQ/Uxc4ZUm
 eTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735825981; x=1736430781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEvGk8FrjUhkYqeaDZqOF70u61jz0WgVNFZYZrXmQxQ=;
 b=hsG+oPEsrk3bUDBqjde+FdE2Vw+2s+CMAVnO7td08uCWoUulQ1FAP+oaPD+AAsiH/C
 Za1o1EZ1wgBVY1brcjr7W1Lv1VxFNDFBvirAateL11EypPfJivzmt0EH3JP5XB85EbMA
 KJteF/ThDqrVDht54i4Ue7/BTfNfohUFqg7yTN9xS/4V4HmwfBy1fADSZIvvNuoLwg5d
 dENrrpI+iuJ1vOcIWfKSjAuF2UIOVLmU+F1jQSn+AIBXCHeHHtwq2RLdH7lzbdtIVy1G
 D9BTTL/x1qt7A2wI/faRPipkW9Nk1o/YJknz3qp40sACsmjvmZ9rwwsjAtz7YLvtKC50
 iLJQ==
X-Gm-Message-State: AOJu0YxW5fuuls2rwsKHLY5DruQW7UNk3lLcmTQC2YebzdYclpsyU9oF
 idZXs+oPx9zawqEWqNDUI9nKr/ODb3JSwrQRAYfDwyLU9m1owSn8Yccrbge2dFwz6q2N7r9B/X3
 zHqPFwk3teO0WviG30G6RhXtQtEE=
X-Gm-Gg: ASbGncsjCgn4QYZjNHvPRH/gad2DL5NHCDo92ZVvuR7aEyOm/w23E1sekkAp6qPagRk
 uJnlTJ9faL7oR4tZZQH7rzIgy1/G+PPcE+Djw+6vb/strr73QbXexr/vP7sz5IPQCvj1Wh/U=
X-Google-Smtp-Source: AGHT+IFPnvLXMv01FQi8t7f0VxcC/KsH+dKqefUdzljjTuzt3W/dc7fDHZjY8qvaVEAwEN99411EwtCr6epcDVGxFc4=
X-Received: by 2002:a05:622a:1aa4:b0:467:6e25:3f3d with SMTP id
 d75a77b69052e-46a4a8dcc71mr670619411cf.15.1735825980937; Thu, 02 Jan 2025
 05:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20250102132624.53443-1-philmd@linaro.org>
In-Reply-To: <20250102132624.53443-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 2 Jan 2025 17:52:49 +0400
Message-ID: <CAJ+F1CK7fX8LBz7c6gY3_gH-BRajm0xOnyAbaLVy-DhoF5mH9w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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

On Thu, Jan 2, 2025 at 5:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Follow the assumed QOM type definition style, prefixing with
> 'TYPE_', and dropping the '_DEVICE' suffix which doesn't add
> any value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Supersedes: <20241219153857.57450-5-philmd@linaro.org>
> Since v1:
> - Drop '_DEVICE' suffix (danpb)
> ---
>  include/hw/misc/vmcoreinfo.h | 7 +++----
>  hw/misc/vmcoreinfo.c         | 6 +++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
> index 0b7b55d400a..1aa44771632 100644
> --- a/include/hw/misc/vmcoreinfo.h
> +++ b/include/hw/misc/vmcoreinfo.h
> @@ -16,10 +16,9 @@
>  #include "standard-headers/linux/qemu_fw_cfg.h"
>  #include "qom/object.h"
>
> -#define VMCOREINFO_DEVICE "vmcoreinfo"
> +#define TYPE_VMCOREINFO "vmcoreinfo"
>  typedef struct VMCoreInfoState VMCoreInfoState;
> -DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
> -                         VMCOREINFO_DEVICE)
> +DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO, TYPE_VMCOREINFO)
>
>  typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
>
> @@ -33,7 +32,7 @@ struct VMCoreInfoState {
>  /* returns NULL unless there is exactly one device */
>  static inline VMCoreInfoState *vmcoreinfo_find(void)
>  {
> -    Object *o =3D object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
> +    Object *o =3D object_resolve_path_type("", TYPE_VMCOREINFO, NULL);
>
>      return o ? VMCOREINFO(o) : NULL;
>  }
> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
> index b1fcc22e92b..145f13a65cf 100644
> --- a/hw/misc/vmcoreinfo.c
> +++ b/hw/misc/vmcoreinfo.c
> @@ -47,13 +47,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Erro=
r **errp)
>       */
>      if (!vmcoreinfo_find()) {
>          error_setg(errp, "at most one %s device is permitted",
> -                   VMCOREINFO_DEVICE);
> +                   TYPE_VMCOREINFO);
>          return;
>      }
>
>      if (!fw_cfg || !fw_cfg->dma_enabled) {
>          error_setg(errp, "%s device requires fw_cfg with DMA",
> -                   VMCOREINFO_DEVICE);
> +                   TYPE_VMCOREINFO);
>          return;
>      }
>
> @@ -95,7 +95,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *k=
lass, void *data)
>
>  static const TypeInfo vmcoreinfo_types[] =3D {
>      {
> -        .name           =3D VMCOREINFO_DEVICE,
> +        .name           =3D TYPE_VMCOREINFO,
>          .parent         =3D TYPE_DEVICE,
>          .instance_size  =3D sizeof(VMCoreInfoState),
>          .class_init     =3D vmcoreinfo_device_class_init,
> --
> 2.47.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


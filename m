Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2CDC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7GV-0005B4-9C; Fri, 27 Jun 2025 07:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uV7GH-0004uu-M8
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uV7GF-0007hJ-HE
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751023729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsoD/P3GG40QpwUE4tGIf2y5jZQ8zxae6P2I2IiZx5g=;
 b=T2RhaZgACmKZfliRif4FNrZ81xIdtk6aVJfVZh+D4zljrlNU2VEVM801jOLwFt+YE2l80l
 pY6kuJW1cb/SEw4hWLwhYISu9ABKmQtPuqOmOPd3ZuRDBKam7z+yc/oPBVldP+k26ztYCk
 951EQykNagyAsqJa2SRbn3mgJkrTjS0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-8mGB11naNyCMI26FVyl3NQ-1; Fri, 27 Jun 2025 07:28:47 -0400
X-MC-Unique: 8mGB11naNyCMI26FVyl3NQ-1
X-Mimecast-MFC-AGG-ID: 8mGB11naNyCMI26FVyl3NQ_1751023727
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ae354979e7aso50608866b.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023726; x=1751628526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsoD/P3GG40QpwUE4tGIf2y5jZQ8zxae6P2I2IiZx5g=;
 b=S0JaK+CNSWPxvAVm5Ro3PqkOh8+hWCp/LZenfe9Ie0yVWQgRtCe2tnCljEjy13dxZE
 reDoc7yoUV0S1Om1UaRGfazzEgkjVmpel6WAh5qEzvcXseC47z6ZjnsvfKgqdajzcKL3
 /3rHF9ndxN+DpVf197faoK+eiSEunnknPaEFHoBYF2mp4gw/QG6QGk9jsdrFPCc7hINa
 kB6TTFnqKLH1eahDbYN7UuCXGsqjTstnxnQuD4GhzGEYBVKZ2oWP1uw8i4NIMYfzeUYY
 2NvAFHEykOWHYL6hxV4ARjTWsDO5AEKR9fQ/sifI6yMwbNYVQ8OVH2TfBq88fBcfsBY8
 L5xA==
X-Gm-Message-State: AOJu0Yymb4UKLwIGKHKfbJNsHy3j4gCg1SfjHeBLsWWk/FUEuvc4KEO7
 KZHxbjWeumx9KdTAISlFdZfx+84oFAjBN5rVdI+SE0L1KNIf8HqJiTZu1GEIhJm/7JropY2lqJI
 fF3DmvQbUnXevBZuB+DS7Dezs1+8VHC4Hdt5CLp5kUqKIyZw37ZcmRJoYzlH/SfRe3Tq3EyupBu
 4fwxSu+TJdVnqCY9PlkNzUq+iSKy4llOA=
X-Gm-Gg: ASbGncvrMQxuHNCJu466Qp7kIkPMAmQ8vKcGwNVcAP3w7kIL6GJK/6addmb+r2oagoD
 2s6fOAJFwa98YFfmvsWNgdgofacDj7OK2G2UBT1AS0DPCco5ac9CFpqEhRRmCBkEOAS0UiqUSqW
 GZEZxb
X-Received: by 2002:a17:907:3d8c:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae34fd7223emr248075166b.22.1751023726569; 
 Fri, 27 Jun 2025 04:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWqOUvSVzbnOSS1Jg3FbTwRmYggjKwjcJOkKGL9FLrDdbXdhc95/FOD0YTkS6geTzQC3e8WHSWqRlFwUUbuDs=
X-Received: by 2002:a17:907:3d8c:b0:ade:4339:9358 with SMTP id
 a640c23a62f3a-ae34fd7223emr248072266b.22.1751023726125; Fri, 27 Jun 2025
 04:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <12d0e71fd1b37ae132f78498d497cb72b90da5d1.1749820158.git.roy.hopkins@randomman.co.uk>
In-Reply-To: <12d0e71fd1b37ae132f78498d497cb72b90da5d1.1749820158.git.roy.hopkins@randomman.co.uk>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 27 Jun 2025 16:58:34 +0530
X-Gm-Features: Ac12FXy75tEg-fs8SIiZzDoJ-YdcfUcYZMZvE725fv4oj24lJbFXmcG84ijyJAU
Message-ID: <CAK3XEhPJncqwL6V6KOhOGLHOjSy-9OQTRWyTPQBP0NsHeVxr6A@mail.gmail.com>
Subject: Re: [PATCH v8 13/16] backends/igvm: Process initialization sections
 in IGVM file
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jun 13, 2025 at 8:52=E2=80=AFPM Roy Hopkins <roy.hopkins@randomman.=
co.uk> wrote:
>
> The initialization sections in IGVM files contain configuration that
> should be applied to the guest platform before it is started. This
> includes guest policy and other information that can affect the security
> level and the startup measurement of a guest.
>
> This commit introduces handling of the initialization sections during
> processing of the IGVM file.
>
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Gerd Hoffman <kraxel@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  backends/igvm.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 2a31021d44..ebdb4594d1 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -786,6 +786,27 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGue=
stSupport *cgs,
>          }
>      }
>
> +    header_count =3D
> +        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
> +    if (header_count < 0) {
> +        error_setg(
> +            errp,
> +            "Invalid initialization header count in IGVM file. Error cod=
e: %X",
> +            header_count);
> +        goto cleanup_parameters;
> +    }
> +
> +    for (ctx.current_header_index =3D 0;
> +         ctx.current_header_index < (unsigned)header_count;
> +         ctx.current_header_index++) {
> +        IgvmVariableHeaderType type =3D
> +            igvm_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZ=
ATION,
> +                                 ctx.current_header_index);
> +        if (qigvm_handler(&ctx, type, errp) < 0) {

So the next patch, patch #14 actually defines the handler.

@@ -92,6 +135,10 @@ static struct QIGVMHandler handlers[] =3D {
       qigvm_directive_environment_info },
     { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_required_memory },
+    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_snp_id_block },
+    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
+      qigvm_initialization_guest_policy },
 };


So I think patch #14 should come before this patch in the series.

> +            goto cleanup_parameters;
> +        }
> +    }
> +
>      /*
>       * Contiguous pages of data with compatible flags are grouped togeth=
er in
>       * order to reduce the number of memory regions we create. Make sure=
 the
> --
> 2.43.0
>



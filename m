Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F01C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 10:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV63U-00014Q-FS; Fri, 27 Jun 2025 06:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uV63T-00014F-1G
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 06:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uV63R-0005u3-5Y
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 06:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751019090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7m9SALfHf+PhpUtkQ46UmR8dLcfaAOpQnXAGOpxYKg=;
 b=WLAqRo1GmG1p2hi5l+ffqRPVhAw6O9e36P2UwdQ/kKIyBP2/3hzksqP8JBKXfh9Uo1ukq1
 JWY4Q0YK/JHL2LIzOJw2EEOZ5k9gCOSY1WJYQ0Ij7XytnAnEGCk92PxZlGEUO8XSCN8gX/
 YXFeBIebijUSTRpEJWK9JMx1xdBvzRY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-n1iZkLkvNyekEQR21KcJtw-1; Fri, 27 Jun 2025 06:11:28 -0400
X-MC-Unique: n1iZkLkvNyekEQR21KcJtw-1
X-Mimecast-MFC-AGG-ID: n1iZkLkvNyekEQR21KcJtw_1751019088
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae35e271028so28066466b.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 03:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751019088; x=1751623888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7m9SALfHf+PhpUtkQ46UmR8dLcfaAOpQnXAGOpxYKg=;
 b=C9gqsHR6It2CAi1hPqhSNRBqM1wC2toaTsLQw80/i8PeA5DtRRwcswJhi8SZWjv1QX
 lq80P/jSyHu/zNNUnZYCDS3RSURQPmYLaphbL1DGTviyGDzJvulnSCzNUMCYrOEUkkYp
 wrSojTLIWb3J+Dr+ucTvshWkLKnTLkG0K9L68DYaP0w0eCLgZqTLqeID1kzhPAXOeV1x
 b3/CDgOegMnQkV5FXqpLR+jMLh6C7H00yy2pOKoeKZCzhw/T5KNVZonjyP2x3ajHUeDe
 Hwdkyw0JdFNRFB/GEIrv+95ZbwgQwCBK4EvkcT+2uwkFXqtILlfLyRFC5xIXgdYqAHzq
 7KQQ==
X-Gm-Message-State: AOJu0YwSxlxCJ31TFL2jSz2vAszXTKl3cru96vZVks6es+oQrZ6//J2H
 cFjX/vaEoIfoZNUTq3Yhsm8iATRO//fGJKqcxIB6fVoWfIxmosLt/2BB1+JbH/FAkDj8WCMtLJ6
 Mm5TbfhVWrrotkASE1pZnd861tonNI7pgnV5MfZY4ZCCqR0d62fH9VD0hCcpDGKfK7f6kOM6hU8
 tLa0SjrN2TUoGwyfre5tLhkwvgfkOoJjg=
X-Gm-Gg: ASbGncupa28qAVqZWGrOFmKsUNXMrSG238ABeXbIAuYHkmkQsBotKTD0ypAEJCihDJZ
 4Rt6qp7aUcVeypJQjGm7alM+9yzCtrB43icOqZOmZXbF1hrAnuRJ2PxNz0aNRKT04zYUtE5b5ZA
 PGpWzm
X-Received: by 2002:a17:907:3e04:b0:ae0:4820:244c with SMTP id
 a640c23a62f3a-ae34fcf462emr182248766b.8.1751019087541; 
 Fri, 27 Jun 2025 03:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmoQqOVoheYXIqAflPdG6LXRV7mNvk6NuTepzgp70zD/2DF6xlSRxd4OCxYBTtEHIiUc15QQ/9gDLcsFRYxEY=
X-Received: by 2002:a17:907:3e04:b0:ae0:4820:244c with SMTP id
 a640c23a62f3a-ae34fcf462emr182245566b.8.1751019087096; Fri, 27 Jun 2025
 03:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <faf5775bd7d83b023e14f6c04cccec78a8a80037.1749820158.git.roy.hopkins@randomman.co.uk>
In-Reply-To: <faf5775bd7d83b023e14f6c04cccec78a8a80037.1749820158.git.roy.hopkins@randomman.co.uk>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 27 Jun 2025 15:41:14 +0530
X-Gm-Features: Ac12FXwmk5SlC8ydVwKwq4EHfpzXRZGIvusW2kRscsWIw-S9nHxknXxW39kTAGo
Message-ID: <CAK3XEhM0V=UmqLxhSjO_5Z-mi4VBWQWKvdhwG30DKgw-+ZmmNg@mail.gmail.com>
Subject: Re: [PATCH v8 03/16] backends/igvm: Add IGVM loader and configuration
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

On Fri, Jun 13, 2025 at 7:24=E2=80=AFPM Roy Hopkins <roy.hopkins@randomman.=
co.uk> wrote:
>
> Adds an IGVM loader to QEMU which processes a given IGVM file and
> applies the directives within the file to the current guest
> configuration.
>
> The IGVM loader can be used to configure both confidential and
> non-confidential guests. For confidential guests, the
> ConfidentialGuestSupport object for the system is used to encrypt
> memory, apply the initial CPU state and perform other confidential guest
> operations.
>
> The loader is configured via a new IgvmCfg QOM object which allows the
> user to provide a path to the IGVM file to process.
>
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Gerd Hoffman <kraxel@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  backends/igvm-cfg.c       |  51 +++
>  backends/igvm.c           | 807 ++++++++++++++++++++++++++++++++++++++
>  backends/igvm.h           |  22 ++
>  backends/meson.build      |   2 +
>  include/system/igvm-cfg.h |  46 +++
>  qapi/qom.json             |  17 +
>  6 files changed, 945 insertions(+)
>  create mode 100644 backends/igvm-cfg.c
>  create mode 100644 backends/igvm.c
>  create mode 100644 backends/igvm.h
>  create mode 100644 include/system/igvm-cfg.h
>

<snip>

> +
> +static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
> +                                    uint64_t gpa_start, unsigned page_co=
unt,
> +                                    const IgvmPageDataFlags *flags,
> +                                    const IgvmPageDataType page_type,
> +                                    Error **errp)
> +{
> +    uint8_t *region;
> +    IgvmHandle data_handle;
> +    const void *data;
> +    uint32_t data_size;
> +    unsigned page_index;
> +    bool zero =3D true;
> +    const uint64_t page_size =3D flags->is_2mb_page ? 0x200000 : 0x1000;
> +    int result;
> +    int cgs_page_type;
> +
> +    region =3D qigvm_prepare_memory(ctx, gpa_start, page_count * page_si=
ze,
> +                                  start_index, errp);
> +    if (!region) {
> +        return -1;
> +    }
> +
> +    for (page_index =3D 0; page_index < page_count; page_index++) {
> +        data_handle =3D igvm_get_header_data(
> +            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + start=
_index);
> +        if (data_handle =3D=3D IGVMAPI_NO_DATA) {
> +            /* No data indicates a zero page */
> +            memset(&region[page_index * page_size], 0, page_size);
> +        } else if (data_handle < 0) {
> +            error_setg(
> +                errp,
> +                "IGVM file contains invalid page data for directive with=
 "
> +                "index %d",
> +                page_index + start_index);
> +            return -1;
> +        } else {
> +            zero =3D false;
> +            data_size =3D igvm_get_buffer_size(ctx->file, data_handle);
> +            if (data_size < page_size) {
> +                memset(&region[page_index * page_size], 0, page_size);
> +            } else if (data_size > page_size) {
> +                error_setg(errp,
> +                           "IGVM file contains page data with invalid si=
ze for "
> +                           "directive with index %d",
> +                           page_index + start_index);
> +                return -1;
> +            }
> +            data =3D igvm_get_buffer(ctx->file, data_handle);
> +            memcpy(&region[page_index * page_size], data, data_size);
> +            igvm_free_buffer(ctx->file, data_handle);
> +        }
> +    }
> +
> +    /*
> +     * If a confidential guest support object is provided then use it to=
 set the
> +     * guest state.
> +     */
> +    if (ctx->cgs) {
> +        cgs_page_type =3D
> +            qigvm_type_to_cgs_type(page_type, flags->unmeasured, zero);
> +        if (cgs_page_type < 0) {
> +            error_setg(errp,
> +                       "Invalid page type in IGVM file. Directives: %d t=
o %d, "
> +                       "page type: %d",
> +                       start_index, start_index + page_count, page_type)=
;
> +            return -1;
> +        }
> +
> +        result =3D ctx->cgsc->set_guest_state(
> +            gpa_start, region, page_size * page_count, cgs_page_type, 0,=
 errp);
> +        if (result < 0) {
> +            return result;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int qigvm_process_mem_page(QIgvm *ctx,
> +                                  const IGVM_VHS_PAGE_DATA *page_data,
> +                                  Error **errp)
> +{
> +    if (page_data) {
> +        if (ctx->region_page_count =3D=3D 0) {
> +            ctx->region_start =3D page_data->gpa;
> +            ctx->region_start_index =3D ctx->current_header_index;
> +        } else {
> +            if (!qigvm_page_attrs_equal(ctx->file, ctx->current_header_i=
ndex,
> +                                        page_data,
> +                                        &ctx->region_prev_page_data) ||
> +                ((ctx->region_prev_page_data.gpa +
> +                  (ctx->region_prev_page_data.flags.is_2mb_page ? 0x2000=
00 :
> +                                                                  0x1000=
)) !=3D
> +                 page_data->gpa) ||
> +                (ctx->region_last_index !=3D (ctx->current_header_index =
- 1))) {
> +                /* End of current region */
> +                if (qigvm_process_mem_region(
> +                        ctx, ctx->region_start_index, ctx->region_start,
> +                        ctx->region_page_count,
> +                        &ctx->region_prev_page_data.flags,
> +                        ctx->region_prev_page_data.data_type, errp) < 0)=
 {
> +                    return -1;
> +                }
> +                ctx->region_page_count =3D 0;
> +                ctx->region_start =3D page_data->gpa;
> +                ctx->region_start_index =3D ctx->current_header_index;

Should we return here? Is there any need for the memcpy() below?

> +            }
> +        }
> +        memcpy(&ctx->region_prev_page_data, page_data,
> +               sizeof(ctx->region_prev_page_data));
> +        ctx->region_last_index =3D ctx->current_header_index;
> +        ctx->region_page_count++;
> +    } else {
> +        if (ctx->region_page_count > 0) {
> +            if (qigvm_process_mem_region(
> +                    ctx, ctx->region_start_index, ctx->region_start,
> +                    ctx->region_page_count, &ctx->region_prev_page_data.=
flags,
> +                    ctx->region_prev_page_data.data_type, errp) < 0) {
> +                return -1;
> +            }
> +            ctx->region_page_count =3D 0;
> +        }
> +    }
> +    return 0;
> +}
> +



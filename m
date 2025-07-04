Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76337C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 07:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXagO-0000g5-Nl; Fri, 04 Jul 2025 03:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uXagL-0000d4-Vt
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 03:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uXagH-000228-PU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 03:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751613475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z0zK9RuLQcCPLc9zqpwhT4ee0vHP0Uc0958cuXJMN0k=;
 b=Tn9qAuiOnjr85SEePb6P5alHG95VxOCwn0pfg0QVttVZ/8yZiwJ5HLYFlh2UZVru+8JKMU
 l1bi9tjaXWC/GnHFHvD16w78qm4djHPYj6ZDlBZmkysKu3Bzf7QftojgfTRqLlbNWJ+zsX
 uQez+BGOaVLJ9lowrb4d+rj1m3uaw4U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mqDgLRlGPpK_hm_uschYdQ-1; Fri, 04 Jul 2025 03:17:54 -0400
X-MC-Unique: mqDgLRlGPpK_hm_uschYdQ-1
X-Mimecast-MFC-AGG-ID: mqDgLRlGPpK_hm_uschYdQ_1751613473
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-748764d84feso1018607b3a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 00:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751613473; x=1752218273;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0zK9RuLQcCPLc9zqpwhT4ee0vHP0Uc0958cuXJMN0k=;
 b=KqYJgcyjw3Nwc9tgyd9Tkq3qLMdFoBo4t0wc++QKW+NsLJfumWM4KM17r0GN6Usrlc
 o9mO2xaJwqg57XHwSY0pI3It3ClmGhepc8+TXNHVCz1jp0eHpSQI7JzwUv+PtTU5v8Ka
 WK4lJTx5kScb+1KpsbnjD+P6bgg3OSpjmYAG6iNf1qUlBuCaiGYAzFeF0MQcxtYftu1z
 FcANpe0y9Qwyt4UGsZcIS7OPTWi6CEikZffcoWI22OJoIyXK2Enod0RkoDSh/2Pk99Eh
 k36N3MbUJmiecuDTSPWu21esPmY5aNtyybZtOOyaDRUaEtqZci4QuWYhfECARlRuBVu9
 8Azw==
X-Gm-Message-State: AOJu0Yx9Clr8fG/WnFp5OqpDm+J0c8ThK1ehvkNqX6aLyQrRFb90GEFY
 TR01RmfthrmEHgt9T8NaedsLf93f7PwN5EfEhlkVS8qYpsiTptgE9eehe9DPx86PEqR+/uVGzYG
 EeBCA4f5ydTkGrDTcusTkrDMmpIM76V2licOahBTIxh9hI6k0JHATbKHv
X-Gm-Gg: ASbGncsrBJXyUrh/JTsy2yfvpxjxshgRNOeAYWTKeedWkK5edOvak6X6P0hWeBQWceu
 NVgWbWN/iol4oVI/VSnWPkHZ02w0BPuVfg9taGsTLvC2mmhG03DXSR5pHd2ErmvLYPHBEofA5uD
 C/IzOdH52AdTmZt8mVB26lCTG0wFdtNkvCay3Zih0XBPdjLqcyriOQXoUTIxXVuVVsaFTKUMzan
 uCOY2/PFUI/u98bno4Qdgn+OHkxmQy8f5EyazFDtmd0bcuXhEfMfkkpTMEcOWd3MuRZw3MoTXyS
 WLyWdlrzd4wdCgC8SLLhCpHweuuEeztczc2a
X-Received: by 2002:a05:6a00:10c2:b0:748:38fa:89bd with SMTP id
 d2e1a72fcca58-74ce884e342mr1400490b3a.9.1751613473033; 
 Fri, 04 Jul 2025 00:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQrqeqKKnn1aSqtlWPnYRbh3sAcDS3vVF37trAdzI22RfUfVmoy28DM0IvQY7oKss/PqjORQ==
X-Received: by 2002:a05:6a00:10c2:b0:748:38fa:89bd with SMTP id
 d2e1a72fcca58-74ce884e342mr1400467b3a.9.1751613472597; 
 Fri, 04 Jul 2025 00:17:52 -0700 (PDT)
Received: from smtpclient.apple ([106.201.63.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce43d69d7sm1464271b3a.177.2025.07.04.00.17.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jul 2025 00:17:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v8 03/16] backends/igvm: Add IGVM loader and configuration
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <016694bcb0658e7bb0f0fe83be8cec5d2a6d185d.camel@randomman.co.uk>
Date: Fri, 4 Jul 2025 12:47:34 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6A9F166-4647-442C-9FFD-0CF8595E980D@redhat.com>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <faf5775bd7d83b023e14f6c04cccec78a8a80037.1749820158.git.roy.hopkins@randomman.co.uk>
 <CAK3XEhM0V=UmqLxhSjO_5Z-mi4VBWQWKvdhwG30DKgw-+ZmmNg@mail.gmail.com>
 <016694bcb0658e7bb0f0fe83be8cec5d2a6d185d.camel@randomman.co.uk>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 3 Jul 2025, at 6:56=E2=80=AFPM, Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>=20
> On Fri, 2025-06-27 at 15:41 +0530, Ani Sinha wrote:
>> On Fri, Jun 13, 2025 at 7:24=E2=80=AFPM Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>>>=20
>>> Adds an IGVM loader to QEMU which processes a given IGVM file and
>>> applies the directives within the file to the current guest
>>> configuration.
>>>=20
>>> The IGVM loader can be used to configure both confidential and
>>> non-confidential guests. For confidential guests, the
>>> ConfidentialGuestSupport object for the system is used to encrypt
>>> memory, apply the initial CPU state and perform other confidential =
guest
>>> operations.
>>>=20
>>> The loader is configured via a new IgvmCfg QOM object which allows =
the
>>> user to provide a path to the IGVM file to process.
>>>=20
>>> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Acked-by: Gerd Hoffman <kraxel@redhat.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  backends/igvm-cfg.c       |  51 +++
>>>  backends/igvm.c           | 807 =
++++++++++++++++++++++++++++++++++++++
>>>  backends/igvm.h           |  22 ++
>>>  backends/meson.build      |   2 +
>>>  include/system/igvm-cfg.h |  46 +++
>>>  qapi/qom.json             |  17 +
>>>  6 files changed, 945 insertions(+)
>>>  create mode 100644 backends/igvm-cfg.c
>>>  create mode 100644 backends/igvm.c
>>>  create mode 100644 backends/igvm.h
>>>  create mode 100644 include/system/igvm-cfg.h
>>>=20
>>=20
>> <snip>
>>=20
>>> +
>>> +static int qigvm_process_mem_region(QIgvm *ctx, unsigned =
start_index,
>>> +                                    uint64_t gpa_start, unsigned =
page_count,
>>> +                                    const IgvmPageDataFlags *flags,
>>> +                                    const IgvmPageDataType =
page_type,
>>> +                                    Error **errp)
>>> +{
>>> +    uint8_t *region;
>>> +    IgvmHandle data_handle;
>>> +    const void *data;
>>> +    uint32_t data_size;
>>> +    unsigned page_index;
>>> +    bool zero =3D true;
>>> +    const uint64_t page_size =3D flags->is_2mb_page ? 0x200000 : =
0x1000;
>>> +    int result;
>>> +    int cgs_page_type;
>>> +
>>> +    region =3D qigvm_prepare_memory(ctx, gpa_start, page_count * =
page_size,
>>> +                                  start_index, errp);
>>> +    if (!region) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    for (page_index =3D 0; page_index < page_count; page_index++) {
>>> +        data_handle =3D igvm_get_header_data(
>>> +            ctx->file, IGVM_HEADER_SECTION_DIRECTIVE, page_index + =
start_index);
>>> +        if (data_handle =3D=3D IGVMAPI_NO_DATA) {
>>> +            /* No data indicates a zero page */
>>> +            memset(&region[page_index * page_size], 0, page_size);
>>> +        } else if (data_handle < 0) {
>>> +            error_setg(
>>> +                errp,
>>> +                "IGVM file contains invalid page data for directive =
with "
>>> +                "index %d",
>>> +                page_index + start_index);
>>> +            return -1;
>>> +        } else {
>>> +            zero =3D false;
>>> +            data_size =3D igvm_get_buffer_size(ctx->file, =
data_handle);
>>> +            if (data_size < page_size) {
>>> +                memset(&region[page_index * page_size], 0, =
page_size);
>>> +            } else if (data_size > page_size) {
>>> +                error_setg(errp,
>>> +                           "IGVM file contains page data with =
invalid size for "
>>> +                           "directive with index %d",
>>> +                           page_index + start_index);
>>> +                return -1;
>>> +            }
>>> +            data =3D igvm_get_buffer(ctx->file, data_handle);
>>> +            memcpy(&region[page_index * page_size], data, =
data_size);
>>> +            igvm_free_buffer(ctx->file, data_handle);
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * If a confidential guest support object is provided then use =
it to set the
>>> +     * guest state.
>>> +     */
>>> +    if (ctx->cgs) {
>>> +        cgs_page_type =3D
>>> +            qigvm_type_to_cgs_type(page_type, flags->unmeasured, =
zero);
>>> +        if (cgs_page_type < 0) {
>>> +            error_setg(errp,
>>> +                       "Invalid page type in IGVM file. Directives: =
%d to %d, "
>>> +                       "page type: %d",
>>> +                       start_index, start_index + page_count, =
page_type);
>>> +            return -1;
>>> +        }
>>> +
>>> +        result =3D ctx->cgsc->set_guest_state(
>>> +            gpa_start, region, page_size * page_count, =
cgs_page_type, 0, errp);
>>> +        if (result < 0) {
>>> +            return result;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int qigvm_process_mem_page(QIgvm *ctx,
>>> +                                  const IGVM_VHS_PAGE_DATA =
*page_data,
>>> +                                  Error **errp)
>>> +{
>>> +    if (page_data) {
>>> +        if (ctx->region_page_count =3D=3D 0) {
>>> +            ctx->region_start =3D page_data->gpa;
>>> +            ctx->region_start_index =3D ctx->current_header_index;
>>> +        } else {
>>> +            if (!qigvm_page_attrs_equal(ctx->file, =
ctx->current_header_index,
>>> +                                        page_data,
>>> +                                        =
&ctx->region_prev_page_data) ||
>>> +                ((ctx->region_prev_page_data.gpa +
>>> +                  (ctx->region_prev_page_data.flags.is_2mb_page ? =
0x200000 :
>>> +                                                                  =
0x1000)) !=3D
>>> +                 page_data->gpa) ||
>>> +                (ctx->region_last_index !=3D =
(ctx->current_header_index - 1))) {
>>> +                /* End of current region */
>>> +                if (qigvm_process_mem_region(
>>> +                        ctx, ctx->region_start_index, =
ctx->region_start,
>>> +                        ctx->region_page_count,
>>> +                        &ctx->region_prev_page_data.flags,
>>> +                        ctx->region_prev_page_data.data_type, errp) =
< 0) {
>>> +                    return -1;
>>> +                }
>>> +                ctx->region_page_count =3D 0;
>>> +                ctx->region_start =3D page_data->gpa;
>>> +                ctx->region_start_index =3D =
ctx->current_header_index;
>>=20
>> Should we return here? Is there any need for the memcpy() below?
>>=20
>=20
> No. In this case the new region is not contiguous with the previous =
region so the
> previous region is completed and the current region variables =
initialized (using
> the same values as the case where no previous region existed above). =
The code then
> falls through to populate the new region with the first page, hence =
the memcpy.

Yes with your explanation it makes sense. Can you please add some =
comments to this code if you need to respin, otherwise I can add it once =
it merges.

>=20
>>> +            }
>>> +        }
>>> +        memcpy(&ctx->region_prev_page_data, page_data,
>>> +               sizeof(ctx->region_prev_page_data));
>>> +        ctx->region_last_index =3D ctx->current_header_index;
>>> +        ctx->region_page_count++;
>>> +    } else {
>>> +        if (ctx->region_page_count > 0) {
>>> +            if (qigvm_process_mem_region(
>>> +                    ctx, ctx->region_start_index, =
ctx->region_start,
>>> +                    ctx->region_page_count, =
&ctx->region_prev_page_data.flags,
>>> +                    ctx->region_prev_page_data.data_type, errp) < =
0) {
>>> +                return -1;
>>> +            }
>>> +            ctx->region_page_count =3D 0;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>> +




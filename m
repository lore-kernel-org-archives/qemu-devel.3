Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B00C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 06:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXa8J-00005Z-1k; Fri, 04 Jul 2025 02:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uXa8H-000056-Cv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uXa8E-0000Xz-MO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751611364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb//kfBOMV55JIXpAmVvh3fJBmXRK+Z1T1c3lcmtNuk=;
 b=PtBTJpo0PaCF6r+wbIlTnWQhKqVKhcxEXGsB7MF4tBv+ONmgOjt964bQ505bI2E7UY6WDI
 gkKZy0HJvLluPcyFcklKLS75W6WRAOPhwhh3HOQoSsMpI+GFFiH1OOa/EXFqrjOpKqP6v2
 w8WjIqkayq10oW+ih00o5O6I01VIek0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-fVAXUBiDPbS-9UjDYg6F-w-1; Fri, 04 Jul 2025 02:42:42 -0400
X-MC-Unique: fVAXUBiDPbS-9UjDYg6F-w-1
X-Mimecast-MFC-AGG-ID: fVAXUBiDPbS-9UjDYg6F-w_1751611362
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2349498f00eso15150985ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 23:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751611362; x=1752216162;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bb//kfBOMV55JIXpAmVvh3fJBmXRK+Z1T1c3lcmtNuk=;
 b=noCPp6d9QJVu+Js4cA5YviE50fvIQHFLo8wgK7eUfHjQBN+eDrISmAWg09udxR25lF
 4/urjRTnkj6EUBbn5g8kHp6boHKH8DTK2rLDfOZy3ebW19bcHIPfvyfA3sOvTljAVRYL
 b/MJw+dBuDqucVJ2AKJF3J3l6IkpbQ+8SzFio71+ZYD4yU00Vyd9nRNafJfZd9swK7La
 U4BIMGfLWVFWniIzy4JbKiY+cJoVMCNqVD0CUOfFr0TC+bZjrE4tdelKAypbUDTJR0wi
 v34s3SWmzJKVX/OtRyDJqZoo8FzR9x8RX2lHGsJFDg8nSXmbaNbKxcL5WjPZvq3HxIz/
 cxKg==
X-Gm-Message-State: AOJu0Ywk8YWcw6FJOz8JwB8CR5N6rYU/5w1f9427rOC9VnGLyLAlZTGD
 ijxv766GgzyIwmt6f3tewZCS1qrEMk1I0UqNizPwZupj51H3Dw3N2ArYIe0IPPsmtivswoMp1n0
 kA0KL4TdbZdfO3ZLueEyM8aXZwjacESqYWRNamGUyZQ6jQSiDoBWZ2kBp
X-Gm-Gg: ASbGncsZuPUDDmMOt+z4GEU2VsNxpphdgfrDMEHLZ3Jre1o+/MxgkfdijZTGMJcg/oh
 h73NI4v5s3y/tzcrj+L5qvpugAIaoEUUGdS1bQkA3lPyjCrGCVajdM5JSqi550J2i7yxiMBcRxX
 Wyy0uycmLs5o+LbNbWcoHaHhrxopzP9I2+tFv7l3wHocUHId9SKMEBPJUImHozk7XbTVAziRpFV
 eY88guR/PIJPjAfIAODBhhkpM3WdAG7OTfI4zXqgXuy/JZcNjqsBlnIBCTEn2MfWR/7nmwnur8o
 6zpmk8NxJ0tD7woLZXFI2rzCvbA/vU+8mRo6
X-Received: by 2002:a17:903:98b:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-23c858d019emr25814795ad.11.1751611361722; 
 Thu, 03 Jul 2025 23:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdMazdocxZVWe2cW67elwGgXI9IiUis9nPbcwDwFLNgCU55XyctFGN3V66a/6RhyyHrHVhFA==
X-Received: by 2002:a17:903:98b:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-23c858d019emr25814475ad.11.1751611361267; 
 Thu, 03 Jul 2025 23:42:41 -0700 (PDT)
Received: from smtpclient.apple ([106.201.63.6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8434ea21sm13400375ad.56.2025.07.03.23.42.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Jul 2025 23:42:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v8 13/16] backends/igvm: Process initialization sections
 in IGVM file
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <b4800e3cc61e4531d96e7c4a2bb2f0841f98c98c.camel@randomman.co.uk>
Date: Fri, 4 Jul 2025 12:12:23 +0530
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
Message-Id: <23BAF4B2-16C6-4DD7-BB8C-67CB170B720E@redhat.com>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <12d0e71fd1b37ae132f78498d497cb72b90da5d1.1749820158.git.roy.hopkins@randomman.co.uk>
 <CAK3XEhPJncqwL6V6KOhOGLHOjSy-9OQTRWyTPQBP0NsHeVxr6A@mail.gmail.com>
 <b4800e3cc61e4531d96e7c4a2bb2f0841f98c98c.camel@randomman.co.uk>
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



> On 3 Jul 2025, at 7:22=E2=80=AFPM, Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>=20
> On Fri, 2025-06-27 at 16:58 +0530, Ani Sinha wrote:
>> On Fri, Jun 13, 2025 at 8:52=E2=80=AFPM Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>>>=20
>>> The initialization sections in IGVM files contain configuration that
>>> should be applied to the guest platform before it is started. This
>>> includes guest policy and other information that can affect the =
security
>>> level and the startup measurement of a guest.
>>>=20
>>> This commit introduces handling of the initialization sections =
during
>>> processing of the IGVM file.
>>>=20
>>> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Acked-by: Gerd Hoffman <kraxel@redhat.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>  backends/igvm.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>=20
>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>> index 2a31021d44..ebdb4594d1 100644
>>> --- a/backends/igvm.c
>>> +++ b/backends/igvm.c
>>> @@ -786,6 +786,27 @@ int qigvm_process_file(IgvmCfg *cfg, =
ConfidentialGuestSupport *cgs,
>>>          }
>>>      }
>>>=20
>>> +    header_count =3D
>>> +        igvm_header_count(ctx.file, =
IGVM_HEADER_SECTION_INITIALIZATION);
>>> +    if (header_count < 0) {
>>> +        error_setg(
>>> +            errp,
>>> +            "Invalid initialization header count in IGVM file. =
Error code: %X",
>>> +            header_count);
>>> +        goto cleanup_parameters;
>>> +    }
>>> +
>>> +    for (ctx.current_header_index =3D 0;
>>> +         ctx.current_header_index < (unsigned)header_count;
>>> +         ctx.current_header_index++) {
>>> +        IgvmVariableHeaderType type =3D
>>> +            igvm_get_header_type(ctx.file, =
IGVM_HEADER_SECTION_INITIALIZATION,
>>> +                                 ctx.current_header_index);
>>> +        if (qigvm_handler(&ctx, type, errp) < 0) {
>>=20
>> So the next patch, patch #14 actually defines the handler.
>>=20
>> @@ -92,6 +135,10 @@ static struct QIGVMHandler handlers[] =3D {
>>        qigvm_directive_environment_info },
>>      { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
>>        qigvm_directive_required_memory },
>> +    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
>> +      qigvm_directive_snp_id_block },
>> +    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
>> +      qigvm_initialization_guest_policy },
>>  };
>>=20
>>=20
>> So I think patch #14 should come before this patch in the series.
>>=20
>=20
> This was deliberately placed before #14 as it introduces the mechanism =
for processing
> initialization sections, allowing future patches to then add sections =
as necessary.
> Patch #14 then uses this new capability to handle guest policy.

My concern was that qigvm_handler() would return -1 and throw "IGVM: =
Unknown header type encountered when processing file:=E2=80=9D without =
patch 14.

> This patch does
> compile successfully without patch #14 being applied.=20

I see. IGVM_HEADER_SECTION_INITIALIZATION actually comes from igvm.h =
header=20
enum IgvmHeaderSection {
  IGVM_HEADER_SECTION_PLATFORM,
  IGVM_HEADER_SECTION_INITIALIZATION,
  IGVM_HEADER_SECTION_DIRECTIVE,
};
So that explains successful compilation.


>=20
>>> +            goto cleanup_parameters;
>>> +        }
>>> +    }
>>> +
>>>      /*
>>>       * Contiguous pages of data with compatible flags are grouped =
together in
>>>       * order to reduce the number of memory regions we create. Make =
sure the
>>> --
>>> 2.43.0



